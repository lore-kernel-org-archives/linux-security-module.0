Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90725C433FE
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Nov 2022 17:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiKBRMS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 2 Nov 2022 13:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiKBRLh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Nov 2022 13:11:37 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A7D1D0C3
        for <linux-security-module@vger.kernel.org>; Wed,  2 Nov 2022 10:11:33 -0700 (PDT)
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2A2HAvBv021897;
        Thu, 3 Nov 2022 02:10:57 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Thu, 03 Nov 2022 02:10:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2A2HAnkK021849
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Nov 2022 02:10:57 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <kees@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 09/10] CaitSith: Add garbage collector functions.
Date:   Thu,  3 Nov 2022 02:10:24 +0900
Message-Id: <20221102171025.126961-9-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This file implements similar functions provided by
security/tomoyo/gc.c file.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/caitsith/gc.c | 573 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 573 insertions(+)
 create mode 100644 security/caitsith/gc.c

diff --git a/security/caitsith/gc.c b/security/caitsith/gc.c
new file mode 100644
index 000000000000..85d75f22fa2c
--- /dev/null
+++ b/security/caitsith/gc.c
@@ -0,0 +1,573 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * gc.c
+ *
+ * Copyright (C) 2005-2012  NTT DATA CORPORATION
+ *
+ * Version: 0.2.10   2021/06/06
+ */
+
+#include "caitsith.h"
+
+/***** SECTION1: Constants definition *****/
+
+/* The list for "struct cs_io_buffer". */
+static LIST_HEAD(cs_io_buffer_list);
+/* Lock for protecting cs_io_buffer_list. */
+static DEFINE_SPINLOCK(cs_io_buffer_list_lock);
+
+/***** SECTION2: Structure definition *****/
+
+/***** SECTION3: Prototype definition section *****/
+
+static bool cs_domain_used_by_task(struct cs_domain_info *domain);
+static bool cs_name_used_by_io_buffer(const char *string, const size_t size);
+static bool cs_struct_used_by_io_buffer(const struct list_head *element);
+static int cs_gc_thread(void *unused);
+static void cs_collect_acl(struct list_head *list);
+static void cs_collect_entry(void);
+static void cs_collect_member(const enum cs_policy_id id,
+			      struct list_head *member_list);
+static void cs_try_to_gc(const enum cs_policy_id type,
+			 struct list_head *element);
+
+/***** SECTION4: Standalone functions section *****/
+
+/***** SECTION5: Variables definition section *****/
+
+/*
+ * Lock for syscall users.
+ *
+ * This lock is held for only protecting single SRCU section.
+ */
+struct srcu_struct cs_ss;
+
+/***** SECTION6: Dependent functions section *****/
+
+/**
+ * cs_struct_used_by_io_buffer - Check whether the list element is used by /sys/kernel/security/caitsith/ users or not.
+ *
+ * @element: Pointer to "struct list_head".
+ *
+ * Returns true if @element is used by /sys/kernel/security/caitsith/ users,
+ * false otherwise.
+ */
+static bool cs_struct_used_by_io_buffer(const struct list_head *element)
+{
+	struct cs_io_buffer *head;
+	bool in_use = false;
+
+	spin_lock(&cs_io_buffer_list_lock);
+	list_for_each_entry(head, &cs_io_buffer_list, list) {
+		head->users++;
+		spin_unlock(&cs_io_buffer_list_lock);
+		mutex_lock(&head->io_sem);
+		if (head->r.acl == element || head->r.subacl == element ||
+		    head->r.group == element || &head->w.acl->list == element)
+			in_use = true;
+		mutex_unlock(&head->io_sem);
+		spin_lock(&cs_io_buffer_list_lock);
+		head->users--;
+		if (in_use)
+			break;
+	}
+	spin_unlock(&cs_io_buffer_list_lock);
+	return in_use;
+}
+
+/**
+ * cs_name_used_by_io_buffer - Check whether the string is used by /sys/kernel/security/caitsith/ users or not.
+ *
+ * @string: String to check.
+ * @size:   Memory allocated for @string .
+ *
+ * Returns true if @string is used by /sys/kernel/security/caitsith/ users,
+ * false otherwise.
+ */
+static bool cs_name_used_by_io_buffer(const char *string, const size_t size)
+{
+	struct cs_io_buffer *head;
+	bool in_use = false;
+
+	spin_lock(&cs_io_buffer_list_lock);
+	list_for_each_entry(head, &cs_io_buffer_list, list) {
+		int i;
+
+		head->users++;
+		spin_unlock(&cs_io_buffer_list_lock);
+		mutex_lock(&head->io_sem);
+		for (i = 0; i < CS_MAX_IO_READ_QUEUE; i++) {
+			const char *w = head->r.w[i];
+
+			if (w < string || w > string + size)
+				continue;
+			in_use = true;
+			break;
+		}
+		mutex_unlock(&head->io_sem);
+		spin_lock(&cs_io_buffer_list_lock);
+		head->users--;
+		if (in_use)
+			break;
+	}
+	spin_unlock(&cs_io_buffer_list_lock);
+	return in_use;
+}
+
+/**
+ * cs_domain_used_by_task - Check whether the given pointer is referenced by a task.
+ *
+ * @domain: Pointer to "struct cs_domain_info".
+ *
+ * Returns true if @domain is in use, false otherwise.
+ */
+static bool cs_domain_used_by_task(struct cs_domain_info *domain)
+{
+	bool in_use = false;
+	/*
+	 * Don't delete this domain if somebody is doing execve().
+	 *
+	 * Since cs_finish_execve() first reverts cs_domain_info and then
+	 * updates cs_flags, we need smp_rmb() to make sure that GC first
+	 * checks cs_flags and then checks cs_domain_info.
+	 */
+	int idx;
+
+	rcu_read_lock();
+	for (idx = 0; idx < CS_MAX_TASK_SECURITY_HASH; idx++) {
+		struct cs_security *ptr;
+		struct list_head *list = &cs_task_security_list[idx];
+
+		list_for_each_entry_rcu(ptr, list, list) {
+			if (!(ptr->cs_flags & CS_TASK_IS_IN_EXECVE)) {
+				smp_rmb(); /* Avoid out of order execution. */
+				if (ptr->cs_domain_info != domain)
+					continue;
+			}
+			in_use = true;
+			goto out;
+		}
+	}
+	in_use = cs_used_by_cred(domain);
+out:
+	rcu_read_unlock();
+	return in_use;
+}
+
+/**
+ * cs_acl_info_has_sub_acl - Clear "struct cs_acl_info"->acl_info.
+ *
+ * @list: Pointer to "struct list_head".
+ *
+ * Returns true if @list is not empty, false otherwise.
+ */
+static bool cs_acl_info_has_sub_acl(struct list_head *list)
+{
+	struct cs_acl_info *acl;
+	struct cs_acl_info *tmp;
+
+	if (list_empty(list))
+		return false;
+	mutex_lock(&cs_policy_lock);
+	list_for_each_entry_safe(acl, tmp, list, list) {
+		cs_try_to_gc(CS_ID_ACL, &acl->list);
+	}
+	mutex_unlock(&cs_policy_lock);
+	return !list_empty(list);
+}
+
+/**
+ * cs_del_acl - Delete members in "struct cs_acl_info".
+ *
+ * @element: Pointer to "struct list_head".
+ *
+ * Returns nothing.
+ */
+static inline void cs_del_acl(struct list_head *element)
+{
+	struct cs_acl_info *acl = container_of(element, typeof(*acl), list);
+
+	cs_put_condition(acl->cond);
+}
+
+/**
+ * cs_del_domain - Delete members in "struct cs_domain_info".
+ *
+ * @element: Pointer to "struct list_head".
+ *
+ * Returns nothing.
+ *
+ * Caller holds cs_policy_lock mutex.
+ */
+static inline void cs_del_domain(struct list_head *element)
+{
+	struct cs_domain_info *domain =
+		container_of(element, typeof(*domain), list);
+	cs_put_name(domain->domainname);
+}
+
+/**
+ * cs_del_string_group - Delete members in "struct cs_string_group".
+ *
+ * @element: Pointer to "struct list_head".
+ *
+ * Returns nothing.
+ */
+static inline void cs_del_string_group(struct list_head *element)
+{
+	struct cs_string_group *member =
+		container_of(element, typeof(*member), head.list);
+	cs_put_name(member->member_name);
+}
+
+/**
+ * cs_del_group - Delete "struct cs_group".
+ *
+ * @element: Pointer to "struct list_head".
+ *
+ * Returns nothing.
+ */
+static inline void cs_del_group(struct list_head *element)
+{
+	struct cs_group *group =
+		container_of(element, typeof(*group), head.list);
+	cs_put_name(group->group_name);
+}
+
+/**
+ * cs_del_condition - Delete members in "struct cs_condition".
+ *
+ * @element: Pointer to "struct list_head".
+ *
+ * Returns nothing.
+ */
+void cs_del_condition(struct list_head *element)
+{
+	struct cs_condition *cond = container_of(element, typeof(*cond),
+						 head.list);
+	const union cs_condition_element *condp = (typeof(condp)) (cond + 1);
+
+	while ((void *) condp < (void *) ((u8 *) cond) + cond->size) {
+		const enum cs_conditions_index left = condp->left;
+		const enum cs_conditions_index right = condp->right;
+
+		condp++;
+		if (left == CS_ARGV_ENTRY)
+			condp++;
+		else if (left == CS_ENVP_ENTRY) {
+			cs_put_name(condp->path);
+			condp++;
+		}
+		if (right == CS_IMM_GROUP) {
+			cs_put_group(condp->group);
+			condp++;
+		} else if (right == CS_IMM_NAME_ENTRY) {
+			if (condp->path != &cs_null_name)
+				cs_put_name(condp->path);
+			condp++;
+		} else if (right == CS_IMM_NUMBER_ENTRY1)
+			condp++;
+		else if (right == CS_IMM_NUMBER_ENTRY2)
+			condp += 2;
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+		else if (right == CS_IMM_IPV6ADDR_ENTRY1)
+			condp = (void *)
+				(((u8 *) condp) + sizeof(struct in6_addr));
+		else if (right == CS_IMM_IPV6ADDR_ENTRY2)
+			condp = (void *)
+				(((u8 *) condp) + sizeof(struct in6_addr) * 2);
+#endif
+	}
+}
+
+/**
+ * cs_try_to_gc - Try to kfree() an entry.
+ *
+ * @type:    One of values in "enum cs_policy_id".
+ * @element: Pointer to "struct list_head".
+ *
+ * Returns nothing.
+ *
+ * Caller holds cs_policy_lock mutex.
+ */
+static void cs_try_to_gc(const enum cs_policy_id type,
+			 struct list_head *element)
+{
+	/*
+	 * __list_del_entry() guarantees that the list element became no longer
+	 * reachable from the list which the element was originally on (e.g.
+	 * cs_domain_list). Also, synchronize_srcu() guarantees that the list
+	 * element became no longer referenced by syscall users.
+	 */
+	__list_del_entry(element);
+	mutex_unlock(&cs_policy_lock);
+	synchronize_srcu(&cs_ss);
+	/*
+	 * However, there are two users which may still be using the list
+	 * element. We need to defer until both users forget this element.
+	 *
+	 * Don't kfree() until "struct cs_io_buffer"->r.{group,acl,subacl} and
+	 * "struct cs_io_buffer"->w.acl forget this element.
+	 */
+	if (cs_struct_used_by_io_buffer(element))
+		goto reinject;
+	switch (type) {
+	case CS_ID_GROUP:
+		cs_del_group(element);
+		break;
+	case CS_ID_STRING_GROUP:
+		cs_del_string_group(element);
+		break;
+	case CS_ID_CONDITION:
+		cs_del_condition(element);
+		break;
+	case CS_ID_NAME:
+		/*
+		 * Don't kfree() until all "struct cs_io_buffer"->r.w[] forget
+		 * this element.
+		 */
+		if (cs_name_used_by_io_buffer
+		    (container_of(element, typeof(struct cs_name),
+				  head.list)->entry.name,
+		     container_of(element, typeof(struct cs_name),
+				  head.list)->size))
+			goto reinject;
+		break;
+	case CS_ID_ACL:
+		/*
+		 * Don't kfree() until "struct cs_acl_info"->acl_info_list
+		 * becomes empty.
+		 */
+		if (cs_acl_info_has_sub_acl
+		    (&container_of(element, typeof(struct cs_acl_info),
+				   list)->acl_info_list))
+			goto reinject;
+		cs_del_acl(element);
+		break;
+	case CS_ID_DOMAIN:
+		/*
+		 * Don't kfree() until all "struct task_struct" forget this
+		 * element.
+		 */
+		if (cs_domain_used_by_task
+		    (container_of(element, typeof(struct cs_domain_info),
+				  list)))
+			goto reinject;
+		cs_del_domain(element);
+		break;
+	default:
+		break;
+	}
+	mutex_lock(&cs_policy_lock);
+	cs_memory_used[CS_MEMORY_POLICY] -= ksize(element);
+	kfree(element);
+	return;
+reinject:
+	/*
+	 * We can safely reinject this element here because
+	 * (1) Appending list elements and removing list elements are protected
+	 *     by cs_policy_lock mutex.
+	 * (2) Only this function removes list elements and this function is
+	 *     exclusively executed by cs_gc_mutex mutex.
+	 * are true.
+	 */
+	mutex_lock(&cs_policy_lock);
+	list_add_rcu(element, element->prev);
+}
+
+/**
+ * cs_collect_member - Delete elements with "struct cs_acl_head".
+ *
+ * @id:          One of values in "enum cs_policy_id".
+ * @member_list: Pointer to "struct list_head".
+ *
+ * Returns nothing.
+ *
+ * Caller holds cs_policy_lock mutex.
+ */
+static void cs_collect_member(const enum cs_policy_id id,
+			      struct list_head *member_list)
+{
+	struct cs_acl_head *member;
+	struct cs_acl_head *tmp;
+
+	list_for_each_entry_safe(member, tmp, member_list, list) {
+		if (!member->is_deleted)
+			continue;
+		member->is_deleted = CS_GC_IN_PROGRESS;
+		cs_try_to_gc(id, &member->list);
+	}
+}
+
+/**
+ * cs_collect_acl - Delete elements in "struct cs_acl_info".
+ *
+ * @list: Pointer to "struct list_head".
+ *
+ * Returns nothing.
+ *
+ * Caller holds cs_policy_lock mutex.
+ */
+static void cs_collect_acl(struct list_head *list)
+{
+	struct cs_acl_info *acl;
+	struct cs_acl_info *tmp;
+
+	list_for_each_entry_safe(acl, tmp, list, list) {
+		if (!acl->is_deleted)
+			continue;
+		cs_try_to_gc(CS_ID_ACL, &acl->list);
+	}
+}
+
+/**
+ * cs_collect_entry - Try to kfree() deleted elements.
+ *
+ * Returns nothing.
+ */
+static void cs_collect_entry(void)
+{
+	int i;
+
+	mutex_lock(&cs_policy_lock);
+	{
+		struct cs_domain_info *domain;
+		struct cs_domain_info *tmp;
+
+		list_for_each_entry_safe(domain, tmp, &cs_domain_list, list) {
+			if (domain == &cs_kernel_domain ||
+			    cs_domain_used_by_task(domain))
+				continue;
+			cs_try_to_gc(CS_ID_DOMAIN, &domain->list);
+		}
+	}
+	for (i = 0; i < CS_MAX_MAC_INDEX; i++) {
+		struct cs_acl_info *ptr;
+		struct cs_acl_info *tmp;
+		struct list_head * const list = &cs_acl_list[i];
+
+		list_for_each_entry_safe(ptr, tmp, list, list) {
+			cs_collect_acl(&ptr->acl_info_list);
+			if (!ptr->is_deleted)
+				continue;
+			/* ptr->is_deleted = CS_GC_IN_PROGRESS; */
+			cs_try_to_gc(CS_ID_ACL, &ptr->list);
+		}
+	}
+	{
+		struct cs_shared_acl_head *ptr;
+		struct cs_shared_acl_head *tmp;
+
+		list_for_each_entry_safe(ptr, tmp, &cs_condition_list, list) {
+			if (atomic_read(&ptr->users) > 0)
+				continue;
+			atomic_set(&ptr->users, CS_GC_IN_PROGRESS);
+			cs_try_to_gc(CS_ID_CONDITION, &ptr->list);
+		}
+	}
+	for (i = 0; i < CS_MAX_GROUP; i++) {
+		struct list_head *list = &cs_group_list[i];
+		struct cs_group *group;
+		struct cs_group *tmp;
+		enum cs_policy_id id = CS_ID_STRING_GROUP;
+
+		if (i == CS_NUMBER_GROUP)
+			id = CS_ID_NUMBER_GROUP;
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+		else if (i == CS_IP_GROUP)
+			id = CS_ID_IP_GROUP;
+#endif
+		list_for_each_entry_safe(group, tmp, list, head.list) {
+			cs_collect_member(id, &group->member_list);
+			if (!list_empty(&group->member_list) ||
+			    atomic_read(&group->head.users) > 0)
+				continue;
+			atomic_set(&group->head.users, CS_GC_IN_PROGRESS);
+			cs_try_to_gc(CS_ID_GROUP, &group->head.list);
+		}
+	}
+	for (i = 0; i < CS_MAX_HASH; i++) {
+		struct list_head *list = &cs_name_list[i];
+		struct cs_shared_acl_head *ptr;
+		struct cs_shared_acl_head *tmp;
+
+		list_for_each_entry_safe(ptr, tmp, list, list) {
+			if (atomic_read(&ptr->users) > 0)
+				continue;
+			atomic_set(&ptr->users, CS_GC_IN_PROGRESS);
+			cs_try_to_gc(CS_ID_NAME, &ptr->list);
+		}
+	}
+	mutex_unlock(&cs_policy_lock);
+}
+
+/**
+ * cs_gc_thread - Garbage collector thread function.
+ *
+ * @unused: Unused.
+ *
+ * Returns 0.
+ */
+static int cs_gc_thread(void *unused)
+{
+	/* Garbage collector thread is exclusive. */
+	static DEFINE_MUTEX(cs_gc_mutex);
+
+	if (!mutex_trylock(&cs_gc_mutex))
+		goto out;
+	cs_collect_entry();
+	{
+		struct cs_io_buffer *head;
+		struct cs_io_buffer *tmp;
+
+		spin_lock(&cs_io_buffer_list_lock);
+		list_for_each_entry_safe(head, tmp, &cs_io_buffer_list,
+					 list) {
+			if (head->users)
+				continue;
+			list_del(&head->list);
+			kfree(head->read_buf);
+			kfree(head->write_buf);
+			kfree(head);
+		}
+		spin_unlock(&cs_io_buffer_list_lock);
+	}
+	mutex_unlock(&cs_gc_mutex);
+out:
+	/* This acts as do_exit(0). */
+	return 0;
+}
+
+/**
+ * cs_notify_gc - Register/unregister /sys/kernel/security/caitsith/ users.
+ *
+ * @head:        Pointer to "struct cs_io_buffer".
+ * @is_register: True if register, false if unregister.
+ *
+ * Returns nothing.
+ */
+void cs_notify_gc(struct cs_io_buffer *head, const bool is_register)
+{
+	bool is_write = false;
+
+	spin_lock(&cs_io_buffer_list_lock);
+	if (is_register) {
+		head->users = 1;
+		list_add(&head->list, &cs_io_buffer_list);
+	} else {
+		is_write = head->write_buf != NULL;
+		if (!--head->users) {
+			list_del(&head->list);
+			kfree(head->read_buf);
+			kfree(head->write_buf);
+			kfree(head);
+		}
+	}
+	spin_unlock(&cs_io_buffer_list_lock);
+	if (is_write) {
+		struct task_struct *task = kthread_create(cs_gc_thread, NULL,
+							  "CaitSith's GC");
+		if (!IS_ERR(task))
+			wake_up_process(task);
+	}
+}
-- 
2.18.4

