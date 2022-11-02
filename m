Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C331C4332F
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Nov 2022 17:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiKBRaM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 2 Nov 2022 13:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbiKBR3w (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Nov 2022 13:29:52 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B14555A6
        for <linux-security-module@vger.kernel.org>; Wed,  2 Nov 2022 10:29:48 -0700 (PDT)
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2A2HTX9Q025078;
        Thu, 3 Nov 2022 02:29:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Thu, 03 Nov 2022 02:29:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2A2HTXev025075
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Nov 2022 02:29:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <df2603c6-85a4-76da-1724-4d29dbfd106b@I-love.SAKURA.ne.jp>
Date:   Thu, 3 Nov 2022 02:29:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: [PATCH 6b/10] CaitSith: Add policy management functions.
Content-Language: en-US
To:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <kees@kernel.org>
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20221102171025.126961-6-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20221102171025.126961-6-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This file implements similar functions provided by security/tomoyo/common.c
and security/tomoyo/securityfs_if.c files.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Reposting "[PATCH 06/10] CaitSith: Add policy management functions." as two patches due to
"BOUNCE linux-security-module@vger.kernel.org: Message too long (>100000 chars)" failure.
This is the latter part.

 security/caitsith/policy_io.c | 2360 +++++++++++++++++++++++++++++++++
 1 file changed, 2360 insertions(+)

diff --git a/security/caitsith/policy_io.c b/security/caitsith/policy_io.c
index 27e2ec57f3b8..36acc994b679 100644
--- a/security/caitsith/policy_io.c
+++ b/security/caitsith/policy_io.c
@@ -1899,3 +1899,2363 @@ static struct cs_condition *cs_get_condition(struct cs_io_buffer *head)
 	kfree(entry);
 	return NULL;
 }
+
+/**
+ * cs_yesno - Return "yes" or "no".
+ *
+ * @value: Bool value.
+ *
+ * Returns "yes" if @value is not 0, "no" otherwise.
+ */
+static const char *cs_yesno(const unsigned int value)
+{
+	return value ? "yes" : "no";
+}
+
+/**
+ * cs_flush - Flush queued string to userspace's buffer.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ *
+ * Returns true if all data was flushed, false otherwise.
+ */
+static bool cs_flush(struct cs_io_buffer *head)
+{
+	while (head->r.w_pos) {
+		const char *w = head->r.w[0];
+		size_t len = strlen(w);
+
+		if (len) {
+			if (len > head->read_user_buf_avail)
+				len = head->read_user_buf_avail;
+			if (!len)
+				return false;
+			if (copy_to_user(head->read_user_buf, w, len))
+				return false;
+			head->read_user_buf_avail -= len;
+			head->read_user_buf += len;
+			w += len;
+		}
+		head->r.w[0] = w;
+		if (*w)
+			return false;
+		/* Add '\0' for audit logs and query. */
+		if (head->type == CS_AUDIT || head->type == CS_QUERY) {
+			if (!head->read_user_buf_avail ||
+			    copy_to_user(head->read_user_buf, "", 1))
+				return false;
+			head->read_user_buf_avail--;
+			head->read_user_buf++;
+		}
+		head->r.w_pos--;
+		for (len = 0; len < head->r.w_pos; len++)
+			head->r.w[len] = head->r.w[len + 1];
+	}
+	head->r.avail = 0;
+	return true;
+}
+
+/**
+ * cs_set_string - Queue string to "struct cs_io_buffer" structure.
+ *
+ * @head:   Pointer to "struct cs_io_buffer".
+ * @string: String to print.
+ *
+ * Returns nothing.
+ *
+ * Note that @string has to be kept valid until @head is kfree()d.
+ * This means that char[] allocated on stack memory cannot be passed to
+ * this function. Use cs_io_printf() for char[] allocated on stack memory.
+ */
+static void cs_set_string(struct cs_io_buffer *head, const char *string)
+{
+	if (head->r.w_pos < CS_MAX_IO_READ_QUEUE) {
+		head->r.w[head->r.w_pos++] = string;
+		cs_flush(head);
+	} else
+		pr_warn("Too many words in a line.\n");
+}
+
+/**
+ * cs_io_printf - printf() to "struct cs_io_buffer" structure.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ * @fmt:  The printf()'s format string, followed by parameters.
+ *
+ * Returns nothing.
+ */
+static void cs_io_printf(struct cs_io_buffer *head, const char *fmt, ...)
+{
+	va_list args;
+	size_t len;
+	size_t pos = head->r.avail;
+	int size = head->readbuf_size - pos;
+
+	if (size <= 0)
+		return;
+	va_start(args, fmt);
+	len = vsnprintf(head->read_buf + pos, size, fmt, args) + 1;
+	va_end(args);
+	if (pos + len >= head->readbuf_size) {
+		pr_warn("Too many words in a line.\n");
+		return;
+	}
+	head->r.avail += len;
+	cs_set_string(head, head->read_buf + pos);
+}
+
+/**
+ * cs_set_space - Put a space to "struct cs_io_buffer" structure.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ *
+ * Returns nothing.
+ */
+static void cs_set_space(struct cs_io_buffer *head)
+{
+	cs_set_string(head, " ");
+}
+
+/**
+ * cs_set_lf - Put a line feed to "struct cs_io_buffer" structure.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ *
+ * Returns true if all data was flushed, false otherwise.
+ */
+static bool cs_set_lf(struct cs_io_buffer *head)
+{
+	cs_set_string(head, "\n");
+	return !head->r.w_pos;
+}
+
+/**
+ * cs_check_profile - Check policy is loaded.
+ *
+ * Returns nothing.
+ */
+void cs_check_profile(void)
+{
+	cs_policy_loaded = true;
+	pr_info("CaitSith (LSM): 0.2.10   2021/06/06\n");
+	if (cs_policy_version == 20120401) {
+		pr_info("CaitSith module activated.\n");
+		return;
+	}
+	pr_err("Policy version %u is not supported.\n", cs_policy_version);
+	pr_err("Userland tools for CaitSith must be installed and policy must be initialized.\n");
+	pr_err("Please see https://caitsith.osdn.jp/ for more information.\n");
+	panic("STOP!");
+}
+
+/**
+ * cs_str_starts - Check whether the given string starts with the given keyword.
+ *
+ * @src:  Pointer to pointer to the string.
+ * @find: Pointer to the keyword.
+ *
+ * Returns true if @src starts with @find, false otherwise.
+ *
+ * The @src is updated to point the first character after the @find
+ * if @src starts with @find.
+ */
+static bool cs_str_starts(char **src, const char *find)
+{
+	const int len = strlen(find);
+	char *tmp = *src;
+
+	if (strncmp(tmp, find, len))
+		return false;
+	tmp += len;
+	*src = tmp;
+	return true;
+}
+
+/**
+ * cs_find_domain - Find a domain by the given name.
+ *
+ * @domainname: The domainname to find.
+ *
+ * Returns pointer to "struct cs_domain_info" if found, NULL otherwise.
+ *
+ * Caller holds cs_read_lock().
+ */
+static struct cs_domain_info *cs_find_domain(const char *domainname)
+{
+	struct cs_domain_info *domain;
+	struct cs_path_info name;
+
+	name.name = domainname;
+	cs_fill_path_info(&name);
+	list_for_each_entry_srcu(domain, &cs_domain_list, list, &cs_ss) {
+		if (!cs_pathcmp(&name, domain->domainname))
+			return domain;
+	}
+	return NULL;
+}
+
+/**
+ * cs_select_acl - Parse select command.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ * @data: String to parse.
+ *
+ * Returns true on success, false otherwise.
+ *
+ * Caller holds cs_read_lock().
+ */
+static bool cs_select_acl(struct cs_io_buffer *head, const char *data)
+{
+	unsigned int qid;
+	enum cs_mac_index type;
+	struct cs_acl_info *acl;
+
+	if (sscanf(data, "Q=%u", &qid) != 1)
+		return false;
+	acl = cs_find_acl_by_qid(qid, &type);
+	head->w.acl = acl;
+	/* Accessing read_buf is safe because head->io_sem is held. */
+	if (!head->read_buf)
+		return true; /* Do nothing if open(O_WRONLY). */
+	memset(&head->r, 0, sizeof(head->r));
+	head->r.print_this_acl_only = true;
+	if (acl) {
+		head->r.acl = &acl->list;
+		head->r.acl_index = type;
+	} else
+		head->r.eof = true;
+	cs_io_printf(head, "# Q=%u\n", qid);
+	return true;
+}
+
+/**
+ * cs_update_acl - Update "struct cs_acl_info" entry.
+ *
+ * @list:   Pointer to "struct list_head".
+ * @head:   Pointer to "struct cs_io_buffer".
+ * @update: True to store matching entry, false otherwise.
+ *
+ * Returns 0 on success, negative value otherwise.
+ *
+ * Caller holds cs_read_lock().
+ */
+static int cs_update_acl(struct list_head * const list,
+			 struct cs_io_buffer *head, const bool update)
+{
+	struct cs_acl_info *ptr;
+	struct cs_acl_info new_entry = { };
+	const bool is_delete = head->w.is_delete;
+	int error = is_delete ? -ENOENT : -ENOMEM;
+
+	new_entry.priority = head->w.priority;
+	new_entry.is_deny = head->w.is_deny;
+	if (head->w.data[0]) {
+		new_entry.cond = cs_get_condition(head);
+		if (!new_entry.cond)
+			return -EINVAL;
+	}
+	if (mutex_lock_killable(&cs_policy_lock))
+		goto out;
+	list_for_each_entry_srcu(ptr, list, list, &cs_ss) {
+		if (ptr->priority > new_entry.priority)
+			break;
+		/*
+		 * We cannot reuse deleted "struct cs_acl_info" entry because
+		 * somebody might be referencing children of this deleted entry
+		 * from srcu section. We cannot delete children of this deleted
+		 * entry until all children are no longer referenced. Thus, let
+		 * the garbage collector wait and delete rather than trying to
+		 * reuse this deleted entry.
+		 */
+		if (ptr->is_deleted || ptr->cond != new_entry.cond ||
+		    ptr->priority != new_entry.priority ||
+		    ptr->is_deny != new_entry.is_deny)
+			continue;
+		ptr->is_deleted = is_delete;
+		if (!is_delete && update)
+			head->w.acl = ptr;
+		error = 0;
+		break;
+	}
+	if (error && !is_delete) {
+		struct cs_acl_info *entry =
+			cs_commit_ok(&new_entry, sizeof(new_entry));
+
+		if (entry) {
+			INIT_LIST_HEAD(&entry->acl_info_list);
+			list_add_tail_rcu(&entry->list, &ptr->list);
+			if (update)
+				head->w.acl = entry;
+		}
+	}
+	mutex_unlock(&cs_policy_lock);
+out:
+	cs_put_condition(new_entry.cond);
+	return error;
+}
+
+/**
+ * cs_parse_entry - Update ACL entry.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ *
+ * Returns 0 on success, negative value otherwise.
+ *
+ * Caller holds cs_read_lock().
+ */
+static int cs_parse_entry(struct cs_io_buffer *head)
+{
+	enum cs_mac_index type;
+	const char *operation = cs_read_token(head);
+
+	for (type = 0; type < CS_MAX_MAC_INDEX; type++) {
+		if (strcmp(operation, cs_mac_keywords[type]))
+			continue;
+		head->w.acl_index = type;
+		/*
+		 * This is_deny is for rejecting transition= argument
+		 * in "acl" line, for that argument is accepted for
+		 * only "allow" line.
+		 */
+		head->w.is_deny = true;
+		return cs_update_acl(&cs_acl_list[type], head, true);
+	}
+	return -EINVAL;
+}
+
+/**
+ * cs_print_number - Print number argument.
+ *
+ * @head:  Pointer to "struct cs_io_buffer".
+ * @radix: One of values in "enum cs_value_type".
+ * @value: Value to print.
+ *
+ * Returns nothing.
+ */
+static void cs_print_number(struct cs_io_buffer *head,
+			    const enum cs_value_type radix,
+			    const unsigned long value)
+{
+	switch (radix) {
+	case CS_VALUE_TYPE_HEXADECIMAL:
+		cs_io_printf(head, "0x%lX", value);
+		break;
+	case CS_VALUE_TYPE_OCTAL:
+		cs_io_printf(head, "0%lo", value);
+		break;
+	default:
+		cs_io_printf(head, "%lu", value);
+	}
+}
+
+/**
+ * cs_condword - Get condition's name.
+ *
+ * @type: One of values in "enum cs_mac_index".
+ * @cond: One of values in "enum cs_condition_index".
+ *
+ * Returns condition's name.
+ */
+static const char *cs_condword(const enum cs_mac_index type,
+			       const enum cs_conditions_index cond)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cs_conditions); i++) {
+		if (!(cs_conditions[i].available & F(type)) ||
+		    cs_conditions[i].cmd != cond)
+			continue;
+		return cs_conditions[i].keyword;
+	}
+	return "unknown"; /* This should not happen. */
+}
+
+/**
+ * cs_print_condition_loop - Print condition part.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ * @cond: Pointer to "struct cs_condition".
+ *
+ * Returns true on success, false otherwise.
+ */
+static bool cs_print_condition_loop(struct cs_io_buffer *head,
+				    const struct cs_condition *cond)
+{
+	const enum cs_mac_index type = head->r.acl_index;
+	const union cs_condition_element *condp = head->r.cond;
+
+	while ((void *) condp < (void *) ((u8 *) cond) + cond->size) {
+		const bool is_not = condp->is_not;
+		const enum cs_conditions_index left = condp->left;
+		const enum cs_conditions_index right = condp->right;
+		const u8 radix = condp->radix;
+
+		if (!cs_flush(head)) {
+			head->r.cond = condp;
+			return false;
+		}
+		condp++;
+		cs_set_space(head);
+		switch (left) {
+		case CS_ARGV_ENTRY:
+			cs_io_printf(head, "argv[%lu]", condp->value);
+			condp++;
+			break;
+		case CS_ENVP_ENTRY:
+			cs_set_string(head, "envp[\"");
+			cs_set_string(head, condp->path->name);
+			condp++;
+			cs_set_string(head, "\"]");
+			break;
+		default:
+			cs_set_string(head, cs_condword(type, left));
+		}
+		cs_set_string(head, is_not ? "!=" : "=");
+		switch (right) {
+		case CS_IMM_GROUP:
+			cs_set_string(head, "@");
+			cs_set_string(head, condp->group->group_name->name);
+			condp++;
+			break;
+		case CS_IMM_NAME_ENTRY:
+			if (condp->path != &cs_null_name) {
+				cs_set_string(head, "\"");
+				cs_set_string(head, condp->path->name);
+				cs_set_string(head, "\"");
+			} else {
+				cs_set_string(head, "NULL");
+			}
+			condp++;
+			break;
+		case CS_IMM_NUMBER_ENTRY1:
+		case CS_IMM_NUMBER_ENTRY2:
+			cs_print_number(head, radix & 3, condp->value);
+			condp++;
+			if (right == CS_IMM_NUMBER_ENTRY1)
+				break;
+			cs_set_string(head, "-");
+			cs_print_number(head, (radix >> 2) & 3, condp->value);
+			condp++;
+			break;
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+		case CS_IMM_IPV4ADDR_ENTRY1:
+		case CS_IMM_IPV4ADDR_ENTRY2:
+			cs_print_ipv4(head, &condp->ip);
+			condp++;
+			if (right == CS_IMM_IPV4ADDR_ENTRY1)
+				break;
+			cs_set_string(head, "-");
+			cs_print_ipv4(head, &condp->ip);
+			condp++;
+			break;
+		case CS_IMM_IPV6ADDR_ENTRY1:
+		case CS_IMM_IPV6ADDR_ENTRY2:
+			cs_print_ipv6(head, (const struct in6_addr *) condp);
+			condp = (void *)
+				((u8 *) condp) + sizeof(struct in6_addr);
+			if (right == CS_IMM_IPV6ADDR_ENTRY1)
+				break;
+			cs_set_string(head, "-");
+			cs_print_ipv6(head, (const struct in6_addr *) condp);
+			condp = (void *)
+				((u8 *) condp) + sizeof(struct in6_addr);
+			break;
+#endif
+		default:
+			cs_set_string(head, cs_condword(type, right));
+		}
+	}
+	head->r.cond = NULL;
+	return true;
+}
+
+/**
+ * cs_print_condition - Print condition part.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ * @cond: Pointer to "struct cs_condition".
+ *
+ * Returns true on success, false otherwise.
+ */
+static bool cs_print_condition(struct cs_io_buffer *head,
+			       const struct cs_condition *cond)
+{
+	switch (head->r.cond_step) {
+	case 0:
+		head->r.cond = (const union cs_condition_element *)
+			(cond + 1);
+		head->r.cond_step++;
+		fallthrough;
+	case 1:
+		if (!cs_print_condition_loop(head, cond))
+			return false;
+		head->r.cond_step++;
+		fallthrough;
+	case 2:
+		head->r.cond = NULL;
+		return true;
+	}
+	return false;
+}
+
+/**
+ * cs_read_acl - Print an ACL entry.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ * @acl:  Pointer to an ACL entry.
+ *
+ * Returns true on success, false otherwise.
+ */
+static bool cs_read_acl(struct cs_io_buffer *head,
+			const struct cs_acl_info *acl)
+{
+	const enum cs_mac_index type = head->r.acl_index;
+
+	if (head->r.cond)
+		goto print_cond_part;
+	if (acl->is_deleted)
+		return true;
+	if (!cs_flush(head))
+		return false;
+	cs_io_printf(head, "%u ", acl->priority);
+	cs_set_string(head, "acl ");
+	cs_set_string(head, cs_mac_keywords[type]);
+	if (acl->cond) {
+		head->r.cond_step = 0;
+print_cond_part:
+		if (!cs_print_condition(head, acl->cond))
+			return false;
+	}
+	cs_set_lf(head);
+	return true;
+}
+
+/**
+ * cs_write_pid - Specify PID to obtain domainname.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ *
+ * Returns 0.
+ */
+static int cs_write_pid(struct cs_io_buffer *head)
+{
+	head->r.eof = false;
+	return 0;
+}
+
+/**
+ * cs_read_pid - Read information of a process.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ *
+ * Returns nothing.
+ *
+ * Reads the domainname which the specified PID is in or
+ * process information of the specified PID on success.
+ *
+ * Caller holds cs_read_lock().
+ */
+static void cs_read_pid(struct cs_io_buffer *head)
+{
+	char *buf = head->write_buf;
+	bool task_info = false;
+	bool global_pid = false;
+	unsigned int pid;
+	struct task_struct *p;
+	struct cs_domain_info *domain = NULL;
+	u32 cs_flags = 0;
+
+	/* Accessing write_buf is safe because head->io_sem is held. */
+	if (!buf) {
+		head->r.eof = true;
+		return; /* Do nothing if open(O_RDONLY). */
+	}
+	if (head->r.w_pos || head->r.eof)
+		return;
+	head->r.eof = true;
+	if (cs_str_starts(&buf, "info "))
+		task_info = true;
+	if (cs_str_starts(&buf, "global-pid "))
+		global_pid = true;
+	pid = (unsigned int) simple_strtoul(buf, NULL, 10);
+	rcu_read_lock();
+	if (global_pid)
+		p = find_task_by_pid_ns(pid, &init_pid_ns);
+	else
+		p = find_task_by_vpid(pid);
+	if (p) {
+		domain = cs_task_domain(p);
+		cs_flags = cs_task_flags(p);
+	}
+	rcu_read_unlock();
+	if (!domain)
+		return;
+	if (!task_info) {
+		cs_io_printf(head, "%u ", pid);
+		cs_set_string(head, domain->domainname->name);
+	} else {
+		cs_io_printf(head, "%u manager=%s ", pid,
+			     cs_yesno(cs_flags &
+				      CS_TASK_IS_MANAGER));
+	}
+}
+
+/**
+ * cs_update_group - Update "struct cs_string_group"/"struct cs_number_group"/"struct cs_ip_group" list.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ * @type: Type of this group.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_update_group(struct cs_io_buffer *head,
+			   const enum cs_group_id type)
+{
+	u8 size;
+	const bool is_delete = head->w.is_delete;
+	int error = is_delete ? -ENOENT : -ENOMEM;
+	struct cs_group *group = cs_get_group(head, type);
+	char *word = cs_read_token(head);
+	union {
+		struct cs_acl_head head;
+		struct cs_string_group path;
+		struct cs_number_group number;
+		struct cs_ip_group address;
+	} e = { };
+
+	if (!group)
+		return -ENOMEM;
+	if (!*word) {
+		error = -EINVAL;
+		goto out;
+	}
+	if (type == CS_STRING_GROUP) {
+		if (!cs_correct_word(word)) {
+			error = -EINVAL;
+			goto out;
+		}
+		e.path.member_name = cs_get_name(word);
+		if (!e.path.member_name) {
+			error = -ENOMEM;
+			goto out;
+		}
+		size = sizeof(e.path);
+	} else if (type == CS_NUMBER_GROUP) {
+		e.number.radix = cs_parse_values(word, e.number.value);
+		if (e.number.radix == CS_VALUE_TYPE_INVALID)
+			goto out;
+		size = sizeof(e.number);
+	} else {
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+		switch (cs_parse_ipaddr(word, e.address.ip)) {
+		case CS_IMM_IPV4ADDR_ENTRY1:
+		case CS_IMM_IPV4ADDR_ENTRY2:
+			e.address.is_ipv6 = false;
+			break;
+		case CS_IMM_IPV6ADDR_ENTRY1:
+		case CS_IMM_IPV6ADDR_ENTRY2:
+			e.address.is_ipv6 = true;
+			break;
+		default:
+			goto out;
+		}
+		size = sizeof(e.address);
+#else
+		goto out;
+#endif
+	}
+	if (mutex_lock_killable(&cs_policy_lock) == 0) {
+		struct cs_acl_head *entry;
+
+		list_for_each_entry_srcu(entry, &group->member_list,
+					 list, &cs_ss) {
+			if (entry->is_deleted == CS_GC_IN_PROGRESS ||
+			    memcmp(entry + 1, &e.head + 1,
+				   size - sizeof(*entry)))
+				continue;
+			entry->is_deleted = is_delete;
+			error = 0;
+			break;
+		}
+		if (error && !is_delete) {
+			entry = cs_commit_ok(&e, size);
+			if (entry) {
+				list_add_tail_rcu(&entry->list,
+						  &group->member_list);
+				error = 0;
+			}
+		}
+		mutex_unlock(&cs_policy_lock);
+	}
+	if (type == CS_STRING_GROUP)
+		cs_put_name(e.path.member_name);
+out:
+	cs_put_group(group);
+	return error;
+}
+
+/**
+ * cs_write_policy - Write policy.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_write_policy(struct cs_io_buffer *head)
+{
+	enum cs_group_id i;
+	unsigned int priority;
+	char *word = cs_read_token(head);
+
+	if (sscanf(word, "%u", &priority) == 1)
+		word = cs_read_token(head);
+	else
+		priority = 1000;
+	if (priority >= 65536 || !*word)
+		return -EINVAL;
+	head->w.priority = priority;
+	if (!head->w.acl)
+		goto no_acl_selected;
+	head->w.is_deny = !strcmp(word, "deny");
+	if (head->w.is_deny || !strcmp(word, "allow"))
+		return cs_update_acl(&head->w.acl->acl_info_list, head,
+				     false);
+	if (!strcmp(word, "audit")) {
+		head->w.acl->audit = simple_strtoul(head->w.data, NULL, 10);
+		return 0;
+	}
+	head->w.acl = NULL;
+no_acl_selected:
+	if (cs_select_acl(head, word))
+		return 0;
+	if (!strcmp(word, "acl"))
+		return cs_parse_entry(head);
+	for (i = 0; i < CS_MAX_GROUP; i++)
+		if (!strcmp(word, cs_group_name[i]))
+			return cs_update_group(head, i);
+	if (sscanf(word, "POLICY_VERSION=%u", &cs_policy_version) == 1)
+		return 0;
+	if (strcmp(word, "quota"))
+		return -EINVAL;
+	if (cs_str_starts(&head->w.data, "memory "))
+		return cs_write_memory_quota(head->w.data);
+	return cs_write_audit_quota(head->w.data);
+}
+
+/**
+ * cs_read_subgroup - Read "struct cs_string_group"/"struct cs_number_group"/"struct cs_ip_group" list.
+ *
+ * @head:  Pointer to "struct cs_io_buffer".
+ * @group: Pointer to "struct cs_group".
+ * @idx:   One of values in "enum cs_group_id".
+ *
+ * Returns true on success, false otherwise.
+ *
+ * Caller holds cs_read_lock().
+ */
+static bool cs_read_subgroup(struct cs_io_buffer *head,
+			     struct cs_group *group,
+			     const enum cs_group_id idx)
+{
+	list_for_each_cookie(head->r.acl, &group->member_list) {
+		struct cs_acl_head *ptr =
+			list_entry(head->r.acl, typeof(*ptr), list);
+
+		if (ptr->is_deleted)
+			continue;
+		if (!cs_flush(head))
+			return false;
+		cs_set_string(head, cs_group_name[idx]);
+		cs_set_space(head);
+		cs_set_string(head, group->group_name->name);
+		cs_set_space(head);
+		if (idx == CS_STRING_GROUP) {
+			cs_set_string(head, container_of
+				      (ptr, struct cs_string_group,
+				       head)->member_name->name);
+		} else if (idx == CS_NUMBER_GROUP) {
+			struct cs_number_group *e =
+				container_of(ptr, typeof(*e), head);
+
+			cs_print_number(head, e->radix & 3, e->value[0]);
+			if (e->radix >> 2) {
+				cs_set_string(head, "-");
+				cs_print_number(head, (e->radix >> 2) & 3,
+						e->value[1]);
+			}
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+		} else if (idx == CS_IP_GROUP) {
+			cs_print_ip(head, container_of
+				    (ptr, struct cs_ip_group, head));
+#endif
+		}
+		cs_set_lf(head);
+	}
+	head->r.acl = NULL;
+	return true;
+}
+
+/**
+ * cs_read_group - Read "struct cs_string_group"/"struct cs_number_group"/"struct cs_ip_group" list.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ *
+ * Returns true on success, false otherwise.
+ *
+ * Caller holds cs_read_lock().
+ */
+static bool cs_read_group(struct cs_io_buffer *head)
+{
+	while (head->r.step < CS_MAX_GROUP) {
+		const enum cs_group_id idx = head->r.step;
+		struct list_head *list = &cs_group_list[idx];
+
+		list_for_each_cookie(head->r.group, list) {
+			struct cs_group *group =
+				list_entry(head->r.group, typeof(*group),
+					   head.list);
+
+			if (!cs_read_subgroup(head, group, idx))
+				return false;
+		}
+		head->r.group = NULL;
+		head->r.step++;
+	}
+	head->r.step = 0;
+	return true;
+}
+
+/**
+ * cs_supervisor - Ask for the supervisor's decision.
+ *
+ * @r: Pointer to "struct cs_request_info".
+ *
+ * Returns 0 if the supervisor decided to permit the access request,
+ * CS_RETRY_REQUEST if the supervisor decided to retry the access request,
+ * -EPERM otherwise.
+ */
+static int cs_supervisor(struct cs_request_info *r)
+{
+	int error = -EPERM;
+	int len;
+	static unsigned int cs_serial;
+	struct cs_query entry = { };
+	bool quota_exceeded = false;
+
+	if (!r->matched_acl)
+		return -EPERM;
+	/* Get message. */
+	entry.query = cs_init_log(r);
+	if (!entry.query)
+		return -EPERM;
+	entry.query_len = strlen(entry.query) + 1;
+	len = ksize(entry.query);
+	entry.acl = r->matched_acl;
+	entry.acl_type = r->type;
+	spin_lock(&cs_query_list_lock);
+	if (cs_memory_quota[CS_MEMORY_QUERY] &&
+	    cs_memory_used[CS_MEMORY_QUERY] + len
+	    >= cs_memory_quota[CS_MEMORY_QUERY]) {
+		quota_exceeded = true;
+	} else {
+		entry.serial = cs_serial++;
+		entry.retry = r->retry;
+		cs_memory_used[CS_MEMORY_QUERY] += len;
+		list_add_tail(&entry.list, &cs_query_list);
+	}
+	spin_unlock(&cs_query_list_lock);
+	if (quota_exceeded)
+		goto out;
+	/* Give 10 seconds for supervisor's opinion. */
+	while (entry.timer < 10) {
+		wake_up_all(&cs_query_wait);
+		if (wait_event_killable_timeout
+		    (cs_answer_wait, entry.answer ||
+		     !atomic_read(&cs_query_observers), HZ))
+			break;
+		entry.timer++;
+	}
+	spin_lock(&cs_query_list_lock);
+	list_del(&entry.list);
+	cs_memory_used[CS_MEMORY_QUERY] -= len;
+	spin_unlock(&cs_query_list_lock);
+	switch (entry.answer) {
+	case 3: /* Asked to retry by administrator. */
+		error = CS_RETRY_REQUEST;
+		r->retry++;
+		break;
+	case 1:
+		/* Granted by administrator. */
+		error = 0;
+		break;
+	default:
+		/* Timed out or rejected by administrator. */
+		break;
+	}
+out:
+	kfree(entry.query);
+	return error;
+}
+
+/**
+ * cs_audit_log - Audit permission check log.
+ *
+ * @r: Pointer to "struct cs_request_info".
+ *
+ * Returns 0 to grant the request, CS_RETRY_REQUEST to retry the permission
+ * check, -EPERM otherwise.
+ */
+int cs_audit_log(struct cs_request_info *r)
+{
+	/* Do not reject if not yet activated. */
+	if (!cs_policy_loaded)
+		return 0;
+	/* Write /sys/kernel/security/caitsith/audit unless quota exceeded. */
+	if (cs_log_count[r->result] < cs_log_quota[r->audit][r->result])
+		cs_write_log(r);
+	/* Nothing more to do unless denied. */
+	if (r->result != CS_MATCHING_DENIED)
+		return 0;
+	/* Update policy violation counter if denied. */
+	cs_update_stat(CS_STAT_REQUEST_DENIED);
+	/* Nothing more to do unless caitsith-queryd is running. */
+	if (!atomic_read(&cs_query_observers))
+		return -EPERM;
+	/* Ask the caitsith-queryd for decision. */
+	return cs_supervisor(r);
+}
+
+/**
+ * cs_find_acl_by_qid - Get ACL by query id.
+ *
+ * @serial: Query ID assigned by cs_supervisor().
+ * @type:   Pointer to "enum cs_mac_index".
+ *
+ * Returns pointer to "struct cs_acl_info" if found, NULL otherwise.
+ *
+ * @type holds "enum cs_mac_index" value if found.
+ */
+static struct cs_acl_info *cs_find_acl_by_qid(unsigned int serial,
+					      enum cs_mac_index *type)
+{
+	struct cs_query *ptr;
+	struct cs_acl_info *acl = NULL;
+
+	spin_lock(&cs_query_list_lock);
+	list_for_each_entry(ptr, &cs_query_list, list) {
+		if (ptr->serial != serial)
+			continue;
+		acl = ptr->acl;
+		*type = ptr->acl_type;
+		break;
+	}
+	spin_unlock(&cs_query_list_lock);
+	return acl;
+}
+
+/**
+ * cs_read_query - Read access requests which violated policy in enforcing mode.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ *
+ * Returns nothing.
+ */
+static void cs_read_query(struct cs_io_buffer *head)
+{
+	struct list_head *tmp;
+	unsigned int pos = 0;
+	size_t len = 0;
+	char *buf;
+
+	if (head->r.w_pos)
+		return;
+	kfree(head->read_buf);
+	head->read_buf = NULL;
+	spin_lock(&cs_query_list_lock);
+	list_for_each(tmp, &cs_query_list) {
+		struct cs_query *ptr = list_entry(tmp, typeof(*ptr), list);
+
+		if (pos++ != head->r.query_index)
+			continue;
+		len = ptr->query_len;
+		break;
+	}
+	spin_unlock(&cs_query_list_lock);
+	if (!len) {
+		head->r.query_index = 0;
+		return;
+	}
+	buf = kzalloc(len + 32, GFP_NOFS);
+	if (!buf)
+		return;
+	pos = 0;
+	spin_lock(&cs_query_list_lock);
+	list_for_each(tmp, &cs_query_list) {
+		struct cs_query *ptr = list_entry(tmp, typeof(*ptr), list);
+
+		if (pos++ != head->r.query_index)
+			continue;
+		/*
+		 * Some query can be skipped because cs_query_list
+		 * can change, but I don't care.
+		 */
+		if (len == ptr->query_len)
+			snprintf(buf, len + 31, "Q%u-%hu\n%s", ptr->serial,
+				 ptr->retry, ptr->query);
+		break;
+	}
+	spin_unlock(&cs_query_list_lock);
+	if (buf[0]) {
+		head->read_buf = buf;
+		head->r.w[head->r.w_pos++] = buf;
+		head->r.query_index++;
+	} else {
+		kfree(buf);
+	}
+}
+
+/**
+ * cs_write_answer - Write the supervisor's decision.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ *
+ * Returns 0 on success, -EINVAL otherwise.
+ */
+static int cs_write_answer(struct cs_io_buffer *head)
+{
+	char *data = head->write_buf;
+	struct list_head *tmp;
+	unsigned int serial;
+	unsigned int answer;
+
+	spin_lock(&cs_query_list_lock);
+	list_for_each(tmp, &cs_query_list) {
+		struct cs_query *ptr = list_entry(tmp, typeof(*ptr), list);
+
+		ptr->timer = 0;
+	}
+	spin_unlock(&cs_query_list_lock);
+	if (sscanf(data, "A%u=%u", &serial, &answer) != 2)
+		return -EINVAL;
+	spin_lock(&cs_query_list_lock);
+	list_for_each(tmp, &cs_query_list) {
+		struct cs_query *ptr = list_entry(tmp, typeof(*ptr), list);
+
+		if (ptr->serial != serial)
+			continue;
+		ptr->answer = (u8) answer;
+		/* Remove from cs_query_list. */
+		if (ptr->answer) {
+			list_del(&ptr->list);
+			INIT_LIST_HEAD(&ptr->list);
+		}
+		break;
+	}
+	spin_unlock(&cs_query_list_lock);
+	wake_up_all(&cs_answer_wait);
+	return 0;
+}
+
+/**
+ * cs_read_version - Get version.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ *
+ * Returns nothing.
+ */
+static void cs_read_version(struct cs_io_buffer *head)
+{
+	if (head->r.eof)
+		return;
+	cs_set_string(head, "0.2");
+	head->r.eof = true;
+}
+
+/**
+ * cs_update_stat - Update statistic counters.
+ *
+ * @index: Index for policy type.
+ *
+ * Returns nothing.
+ */
+static void cs_update_stat(const u8 index)
+{
+	atomic_inc(&cs_stat_updated[index]);
+	cs_stat_modified[index] = ktime_get_real_seconds();
+}
+
+/**
+ * cs_read_stat - Read statistic data.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ *
+ * Returns nothing.
+ */
+static void cs_read_stat(struct cs_io_buffer *head)
+{
+	u8 i;
+
+	for (i = 0; i < CS_MAX_POLICY_STAT; i++) {
+		static const char * const k[CS_MAX_POLICY_STAT] = {
+			[CS_STAT_POLICY_UPDATES] = "Policy updated:",
+			[CS_STAT_REQUEST_DENIED] = "Requests denied:",
+		};
+
+		cs_io_printf(head, "stat %s %u", k[i],
+			     atomic_read(&cs_stat_updated[i]));
+		if (cs_stat_modified[i]) {
+			struct cs_time stamp;
+
+			cs_convert_time(cs_stat_modified[i], &stamp);
+			cs_io_printf(head,
+				     " (Last: %04u/%02u/%02u %02u:%02u:%02u)",
+				     stamp.year, stamp.month, stamp.day,
+				     stamp.hour, stamp.min, stamp.sec);
+		}
+		cs_set_lf(head);
+	}
+	for (i = 0; i < CS_MAX_MEMORY_STAT; i++)
+		cs_io_printf(head, "stat Memory used by %s: %u\n",
+			     cs_memory_headers[i], cs_memory_used[i]);
+}
+
+/**
+ * cs_read_quota - Read quota data.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ *
+ * Returns true on success, false otherwise.
+ */
+static bool cs_read_quota(struct cs_io_buffer *head)
+{
+	unsigned int i;
+
+	while (head->r.step < CS_MAX_MEMORY_STAT) {
+		i = head->r.step++;
+		if (!cs_memory_quota[i])
+			continue;
+		cs_io_printf(head, "quota memory %s %u\n",
+			     cs_memory_headers[i], cs_memory_quota[i]);
+	}
+	while (head->r.step < CS_MAX_LOG_QUOTA + CS_MAX_MEMORY_STAT) {
+		unsigned int a;
+		unsigned int d;
+		unsigned int u;
+
+		if (!cs_flush(head))
+			return false;
+		i = head->r.step - CS_MAX_MEMORY_STAT;
+		a = cs_log_quota[i][CS_MATCHING_ALLOWED];
+		d = cs_log_quota[i][CS_MATCHING_DENIED];
+		u = cs_log_quota[i][CS_MATCHING_UNMATCHED];
+		if (a || d || u)
+			cs_io_printf(head,
+				     "quota audit[%u] allowed=%u denied=%u unmatched=%u\n",
+				     i, a, d, u);
+		head->r.step++;
+	}
+	head->r.step = 0;
+	return true;
+}
+
+/**
+ * cs_write_memory_quota - Set memory quota.
+ *
+ * @data: Line to parse.
+ *
+ * Returns 0 on success, -EINVAL otherwise.
+ */
+static int cs_write_memory_quota(char *data)
+{
+	u8 i;
+
+	for (i = 0; i < CS_MAX_MEMORY_STAT; i++)
+		if (cs_str_starts(&data, cs_memory_headers[i])) {
+			if (*data == ' ')
+				data++;
+			cs_memory_quota[i] =
+				simple_strtoul(data, NULL, 10);
+			return 0;
+		}
+	return -EINVAL;
+}
+
+/**
+ * cs_write_audit_quota - Set audit log quota.
+ *
+ * @data: Line to parse.
+ *
+ * Returns 0 on success, -EINVAL otherwise.
+ */
+static int cs_write_audit_quota(char *data)
+{
+	unsigned int i;
+
+	if (sscanf(data, "audit[%u]", &i) != 1 || i >= CS_MAX_LOG_QUOTA)
+		return -EINVAL;
+	data = strchr(data, ' ');
+	if (!data++)
+		return -EINVAL;
+	while (1) {
+		unsigned int logs;
+		char *cp = strchr(data, ' ');
+
+		if (cp)
+			*cp++ = '\0';
+		if (sscanf(data, "allowed=%u", &logs) == 1)
+			cs_log_quota[i][CS_MATCHING_ALLOWED] = logs;
+		else if (sscanf(data, "denied=%u", &logs) == 1)
+			cs_log_quota[i][CS_MATCHING_DENIED] = logs;
+		else if (sscanf(data, "unmatched=%u", &logs) == 1)
+			cs_log_quota[i][CS_MATCHING_UNMATCHED] = logs;
+		if (!cp)
+			break;
+		data = cp;
+	}
+	return 0;
+}
+
+/**
+ * cs_print_bprm - Print "struct linux_binprm" for auditing.
+ *
+ * @bprm: Pointer to "struct linux_binprm".
+ * @dump: Pointer to "struct cs_page_dump".
+ *
+ * Returns the contents of @bprm on success, NULL otherwise.
+ *
+ * This function uses kzalloc(), so caller must kfree() if this function
+ * didn't return NULL.
+ */
+static char *cs_print_bprm(struct linux_binprm *bprm,
+			   struct cs_page_dump *dump)
+{
+	static const int cs_buffer_len = 4096 * 2;
+	char *buffer = kzalloc(cs_buffer_len, GFP_NOFS);
+	char *cp;
+	char *last_start;
+	unsigned long pos = bprm->p;
+	int offset = pos % PAGE_SIZE;
+	int argv_count = bprm->argc;
+	int envp_count = bprm->envc;
+	bool skip = false;
+	bool env_value = false;
+
+	if (!buffer)
+		return NULL;
+	cp = buffer + snprintf(buffer, cs_buffer_len - 1, " argc=%d envc=%d",
+			       argv_count, envp_count);
+	last_start = cp;
+	while (argv_count || envp_count) {
+		if (!cs_dump_page(bprm, pos, dump)) {
+			kfree(buffer);
+			return NULL;
+		}
+		pos += PAGE_SIZE - offset;
+		/* Read. */
+		while (offset < PAGE_SIZE) {
+			const char *kaddr = dump->data;
+			const unsigned char c = kaddr[offset++];
+			int len;
+
+			/* Check for end of buffer. */
+			if (skip) {
+				if (c)
+					continue;
+				goto reset;
+			}
+			len = buffer + cs_buffer_len - cp - 1;
+			if (len <= 32 && c) {
+				cp = last_start;
+				skip = true;
+				continue;
+			}
+			/* Print argv[$index]=" or envp[" part. */
+			if (cp == last_start) {
+				int l;
+
+				if (argv_count)
+					l = snprintf(cp, len, " argv[%u]=\"",
+						     bprm->argc - argv_count);
+				else
+					l = snprintf(cp, len, " envp[\"");
+				cp += l;
+				len -= l;
+			}
+			if (c > ' ' && c < 127 && c != '\\') {
+				/* Print "]=" part if printing environ. */
+				if (c == '=' && !argv_count && !env_value) {
+					cp += snprintf(cp, len, "\"]=\"");
+					env_value = true;
+				} else
+					*cp++ = c;
+				continue;
+			}
+			if (c) {
+				*cp++ = '\\';
+				*cp++ = (c >> 6) + '0';
+				*cp++ = ((c >> 3) & 7) + '0';
+				*cp++ = (c & 7) + '0';
+				continue;
+			}
+			/* Print "]=" part if not yet printed. */
+			if (!argv_count && !env_value)
+				cp += snprintf(cp, len, "\"]=\"");
+			*cp++ = '"';
+			last_start = cp;
+reset:
+			skip = false;
+			env_value = false;
+			if (argv_count)
+				argv_count--;
+			else if (envp_count)
+				envp_count--;
+			if (!argv_count && !envp_count)
+				break;
+		}
+		offset = 0;
+	}
+	*cp = '\0';
+	return buffer;
+}
+
+/**
+ * cs_filetype - Get string representation of file type.
+ *
+ * @mode: Mode value for stat().
+ *
+ * Returns file type string.
+ */
+static inline const char *cs_filetype(const umode_t mode)
+{
+	switch (mode & S_IFMT) {
+	case S_IFREG:
+	case 0:
+		return "file";
+	case S_IFDIR:
+		return "directory";
+	case S_IFLNK:
+		return "symlink";
+	case S_IFIFO:
+		return "fifo";
+	case S_IFSOCK:
+		return "socket";
+	case S_IFBLK:
+		return "block";
+	case S_IFCHR:
+		return "char";
+	}
+	return "unknown"; /* This should not happen. */
+}
+
+/**
+ * cs_print_trailer - Get misc info of audit log.
+ *
+ * @r: Pointer to "struct cs_request_info".
+ *
+ * Returns string representation.
+ *
+ * This function uses kmalloc(), so caller must kfree() if this function
+ * didn't return NULL.
+ */
+static char *cs_print_trailer(struct cs_request_info *r)
+{
+	const char *exe = r->exename.name;
+	const char *domain = cs_current_domain()->domainname->name;
+	const int cs_buffer_len = 2000 + strlen(exe) + strlen(domain);
+	char *buffer = kmalloc(cs_buffer_len, GFP_NOFS);
+	int pos;
+	u8 i;
+
+	if (!buffer)
+		return NULL;
+	pos = snprintf(buffer, cs_buffer_len - 1,
+		       " task.pid=%u task.ppid=%u task.uid=%u task.gid=%u task.euid=%u task.egid=%u task.suid=%u task.sgid=%u task.fsuid=%u task.fsgid=%u task.exe=\"%s\" task.domain=\"%s\"",
+		       cs_sys_getpid(), cs_sys_getppid(),
+		       from_kuid(&init_user_ns, current_uid()),
+		       from_kgid(&init_user_ns, current_gid()),
+		       from_kuid(&init_user_ns, current_euid()),
+		       from_kgid(&init_user_ns, current_egid()),
+		       from_kuid(&init_user_ns, current_suid()),
+		       from_kgid(&init_user_ns, current_sgid()),
+		       from_kuid(&init_user_ns, current_fsuid()),
+		       from_kgid(&init_user_ns, current_fsgid()),
+		       exe, domain);
+	if (!r->obj.path[0].dentry && !r->obj.path[1].dentry)
+		goto no_obj_info;
+	cs_get_attributes(r);
+	for (i = 0; i < CS_MAX_PATH_STAT; i++) {
+		const enum cs_conditions_index cond =
+			CS_PATH_ATTRIBUTE_START + (i * 16);
+		struct cs_mini_stat *stat;
+		unsigned int dev;
+		umode_t mode;
+
+		if (!r->obj.stat_valid[i])
+			continue;
+		stat = &r->obj.stat[i];
+		mode = stat->mode;
+		pos += snprintf(buffer + pos, cs_buffer_len - 1 - pos,
+				" %s=%u %s=%u %s=0%o",
+				cs_condword(r->type, cond +
+					    CS_PATH_ATTRIBUTE_UID),
+				from_kuid(&init_user_ns, stat->uid),
+				cs_condword(r->type, cond +
+					    CS_PATH_ATTRIBUTE_GID),
+				from_kgid(&init_user_ns, stat->gid),
+				cs_condword(r->type, cond +
+					    CS_PATH_ATTRIBUTE_PERM),
+				mode & S_IALLUGO);
+		/* No need to audit if parent directory. */
+		if (i & 1)
+			goto skip;
+		pos += snprintf(buffer + pos, cs_buffer_len - 1 - pos,
+				" %s=%s",
+				cs_condword(r->type, cond +
+					    CS_PATH_ATTRIBUTE_TYPE),
+				cs_filetype(mode));
+		/* No need to audit unless block or char. */
+		if (!S_ISCHR(mode) && !S_ISBLK(mode))
+			goto skip;
+		dev = stat->rdev;
+		pos += snprintf(buffer + pos, cs_buffer_len - 1 - pos,
+				" %s=%u %s=%u",
+				cs_condword(r->type, cond +
+					    CS_PATH_ATTRIBUTE_DEV_MAJOR),
+				MAJOR(dev),
+				cs_condword(r->type, cond +
+					    CS_PATH_ATTRIBUTE_DEV_MINOR),
+				MINOR(dev));
+skip:
+		dev = stat->dev;
+		pos += snprintf(buffer + pos, cs_buffer_len - 1 - pos,
+				" %s=%lu %s=%u %s=%u %s=0x%lX",
+				cs_condword(r->type, cond +
+					    CS_PATH_ATTRIBUTE_INO),
+				(unsigned long) stat->ino,
+				cs_condword(r->type, cond +
+					    CS_PATH_ATTRIBUTE_MAJOR),
+				MAJOR(dev),
+				cs_condword(r->type, cond +
+					    CS_PATH_ATTRIBUTE_MINOR),
+				MINOR(dev),
+				cs_condword(r->type, cond +
+					    CS_PATH_ATTRIBUTE_FSMAGIC),
+				stat->fsmagic);
+	}
+no_obj_info:
+	if (pos < cs_buffer_len - 1)
+		return buffer;
+	kfree(buffer);
+	return NULL;
+}
+
+/**
+ * cs_print_param -  Get arg info of audit log.
+ *
+ * @r:   Pointer to "struct cs_request_info".
+ * @buf: Buffer to write.
+ * @len: Size of @buf in bytes.
+ */
+static int cs_print_param(struct cs_request_info *r, char *buf, int len)
+{
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+	/* Make sure that IP address argument is ready. */
+	char ip[sizeof("xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:255.255.255.255")];
+
+	switch (r->type) {
+	case CS_MAC_INET_STREAM_BIND:
+	case CS_MAC_INET_STREAM_LISTEN:
+	case CS_MAC_INET_STREAM_CONNECT:
+	case CS_MAC_INET_STREAM_ACCEPT:
+	case CS_MAC_INET_DGRAM_BIND:
+	case CS_MAC_INET_DGRAM_SEND:
+	case CS_MAC_INET_RAW_BIND:
+	case CS_MAC_INET_RAW_SEND:
+		if (!r->param.ip)
+			return 0;
+		if (r->param.is_ipv6) {
+			snprintf(ip, sizeof(ip), "%pI6c",
+				 (const struct in6_addr *) r->param.ip);
+		} else {
+			snprintf(ip, sizeof(ip), "%pI4", r->param.ip);
+		}
+		break;
+	default:
+		break;
+	}
+#endif
+	/* Make sure that string arguments are ready. */
+	if (!r->param.s[0] && r->obj.path[0].dentry) {
+		cs_populate_patharg(r, true);
+		if (!r->param.s[0])
+			return 0;
+	}
+	if (!r->param.s[1] && r->obj.path[1].dentry) {
+		cs_populate_patharg(r, false);
+		if (!r->param.s[1])
+			return 0;
+	}
+	switch (r->type) {
+		int pos;
+		u8 i;
+	case CS_MAC_EXECUTE:
+		return snprintf(buf, len, " exec=\"%s\" path=\"%s\"",
+				r->param.s[1]->name, r->param.s[0]->name);
+	case CS_MAC_READ:
+	case CS_MAC_WRITE:
+	case CS_MAC_APPEND:
+	case CS_MAC_UNLINK:
+#ifdef CONFIG_SECURITY_CAITSITH_GETATTR
+	case CS_MAC_GETATTR:
+#endif
+	case CS_MAC_RMDIR:
+	case CS_MAC_TRUNCATE:
+	case CS_MAC_CHROOT:
+		return snprintf(buf, len, " path=\"%s\"", r->param.s[0]->name);
+	case CS_MAC_CREATE:
+	case CS_MAC_MKDIR:
+	case CS_MAC_MKFIFO:
+	case CS_MAC_MKSOCK:
+		return snprintf(buf, len, " path=\"%s\" perm=0%lo",
+				r->param.s[0]->name, r->param.i[0]);
+	case CS_MAC_SYMLINK:
+		return snprintf(buf, len, " path=\"%s\" target=\"%s\"",
+				r->param.s[0]->name, r->param.s[1]->name);
+	case CS_MAC_MKBLOCK:
+	case CS_MAC_MKCHAR:
+		return snprintf(buf, len,
+				" path=\"%s\" perm=0%lo dev_major=%lu dev_minor=%lu",
+				r->param.s[0]->name, r->param.i[0],
+				r->param.i[1], r->param.i[2]);
+	case CS_MAC_LINK:
+	case CS_MAC_RENAME:
+		return snprintf(buf, len, " old_path=\"%s\" new_path=\"%s\"",
+				r->param.s[0]->name, r->param.s[1]->name);
+	case CS_MAC_CHMOD:
+		return snprintf(buf, len, " path=\"%s\" perm=0%lo",
+				r->param.s[0]->name, r->param.i[0]);
+	case CS_MAC_CHOWN:
+		return snprintf(buf, len, " path=\"%s\" uid=%lu",
+				r->param.s[0]->name, r->param.i[0]);
+	case CS_MAC_CHGRP:
+		return snprintf(buf, len, " path=\"%s\" gid=%lu",
+				r->param.s[0]->name, r->param.i[0]);
+	case CS_MAC_IOCTL:
+		return snprintf(buf, len, " path=\"%s\" cmd=0x%lX",
+				r->param.s[0]->name, r->param.i[0]);
+	case CS_MAC_MOUNT:
+		pos = 0;
+		for (i = 0; i < 4; i++) {
+			static const char * const cs_names[4] = {
+				"source", "target", "fstype", "data"
+			};
+			if (i == 3)
+				pos += snprintf(buf + pos, pos < len ?
+						len - pos : 0, " flags=0x%lX",
+						r->param.i[0]);
+			if (!r->param.s[i])
+				continue;
+			pos += snprintf(buf + pos, pos < len ? len - pos : 0,
+					" %s=\"%s\"", cs_names[i],
+					r->param.s[i]->name);
+		}
+		return pos;
+	case CS_MAC_UMOUNT:
+		return snprintf(buf, len, " path=\"%s\" flags=0x%lX",
+				r->param.s[0]->name, r->param.i[0]);
+	case CS_MAC_PIVOT_ROOT:
+		return snprintf(buf, len, " new_root=\"%s\" put_old=\"%s\"",
+				r->param.s[0]->name, r->param.s[1]->name);
+#ifdef CONFIG_SECURITY_CAITSITH_ENVIRON
+	case CS_MAC_ENVIRON:
+		return snprintf(buf, len,
+				" name=\"%s\" value=\"%s\" exec=\"%s\" path=\"%s\"",
+				r->param.s[2]->name, r->param.s[3]->name,
+				r->param.s[1]->name, r->param.s[0]->name);
+#endif
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+	case CS_MAC_INET_STREAM_BIND:
+	case CS_MAC_INET_STREAM_LISTEN:
+	case CS_MAC_INET_STREAM_CONNECT:
+	case CS_MAC_INET_STREAM_ACCEPT:
+	case CS_MAC_INET_DGRAM_BIND:
+	case CS_MAC_INET_DGRAM_SEND:
+		return snprintf(buf, len, " ip=%s port=%lu", ip,
+				r->param.i[0]);
+	case CS_MAC_INET_RAW_BIND:
+	case CS_MAC_INET_RAW_SEND:
+		return snprintf(buf, len, " ip=%s proto=%lu", ip,
+				r->param.i[0]);
+	case CS_MAC_UNIX_STREAM_BIND:
+	case CS_MAC_UNIX_STREAM_LISTEN:
+	case CS_MAC_UNIX_STREAM_CONNECT:
+	case CS_MAC_UNIX_STREAM_ACCEPT:
+	case CS_MAC_UNIX_DGRAM_BIND:
+	case CS_MAC_UNIX_DGRAM_SEND:
+	case CS_MAC_UNIX_SEQPACKET_BIND:
+	case CS_MAC_UNIX_SEQPACKET_LISTEN:
+	case CS_MAC_UNIX_SEQPACKET_CONNECT:
+	case CS_MAC_UNIX_SEQPACKET_ACCEPT:
+		return snprintf(buf, len, " addr=\"%s\"", r->param.s[0]->name);
+#endif
+#ifdef CONFIG_SECURITY_CAITSITH_MANUAL_DOMAIN_TRANSITION
+	case CS_MAC_MANUAL_DOMAIN_TRANSITION:
+		return snprintf(buf, len, " domain=\"%s\"",
+				r->param.s[0]->name);
+#endif
+	default:
+		break;
+	}
+	return 0;
+}
+
+/**
+ * cs_init_log - Allocate buffer for audit logs.
+ *
+ * @r: Pointer to "struct cs_request_info".
+ *
+ * Returns pointer to allocated memory.
+ *
+ * This function uses kzalloc(), so caller must kfree() if this function
+ * didn't return NULL.
+ */
+static char *cs_init_log(struct cs_request_info *r)
+{
+	const pid_t gpid = task_pid_nr(current);
+	struct cs_time stamp;
+	static const char * const k[CS_MAX_MATCHING] = {
+		[CS_MATCHING_UNMATCHED] = "unmatched",
+		[CS_MATCHING_ALLOWED] = "allowed",
+		[CS_MATCHING_DENIED] = "denied",
+	};
+	char *buf;
+	const char *bprm_info;
+	const char *trailer;
+	int len;
+
+	if (!r->exename.name && !cs_get_exename(&r->exename))
+		return NULL;
+	cs_convert_time(ktime_get_real_seconds(), &stamp);
+	trailer = cs_print_trailer(r);
+	if (r->bprm)
+		bprm_info = cs_print_bprm(r->bprm, &r->dump);
+	else
+		bprm_info = NULL;
+	len = 0;
+	while (1) {
+		int pos;
+
+		buf = kzalloc(len, GFP_NOFS);
+		if (!buf)
+			break;
+		pos = snprintf(buf, len,
+			       "#%04u/%02u/%02u %02u:%02u:%02u# global-pid=%u result=%s priority=%u / %s",
+			       stamp.year, stamp.month, stamp.day, stamp.hour,
+			       stamp.min, stamp.sec, gpid, k[r->result],
+			       r->matched_acl ? r->matched_acl->priority : 0,
+			       cs_mac_keywords[r->type]);
+		pos += cs_print_param(r, buf + pos,
+				      pos < len ? len - pos : 0);
+		if (bprm_info)
+			pos += snprintf(buf + pos, pos < len ? len - pos : 0,
+					"%s", bprm_info);
+		if (trailer)
+			pos += snprintf(buf + pos, pos < len ? len - pos : 0,
+					"%s", trailer);
+		pos += snprintf(buf + pos, pos < len ? len - pos : 0,
+				"\n") + 1;
+		if (pos <= len)
+			break;
+		kfree(buf);
+		len = pos;
+	}
+	kfree(bprm_info);
+	kfree(trailer);
+	return buf;
+}
+
+/**
+ * cs_write_log - Write an audit log.
+ *
+ * @r: Pointer to "struct cs_request_info".
+ *
+ * Returns nothing.
+ */
+static void cs_write_log(struct cs_request_info *r)
+{
+	struct cs_log *entry;
+	bool quota_exceeded = false;
+	char *buf = cs_init_log(r);
+
+	if (!buf)
+		return;
+	entry = kzalloc(sizeof(*entry), GFP_NOFS);
+	if (!entry) {
+		kfree(buf);
+		return;
+	}
+	entry->log = buf;
+	/*
+	 * The entry->size is used for memory quota checks.
+	 * Don't go beyond strlen(entry->log).
+	 */
+	entry->size = ksize(buf) + ksize(entry);
+	entry->result = r->result;
+	spin_lock(&cs_log_lock);
+	if (cs_memory_quota[CS_MEMORY_AUDIT] &&
+	    cs_memory_used[CS_MEMORY_AUDIT] + entry->size >=
+	    cs_memory_quota[CS_MEMORY_AUDIT]) {
+		quota_exceeded = true;
+	} else {
+		cs_memory_used[CS_MEMORY_AUDIT] += entry->size;
+		list_add_tail(&entry->list, &cs_log);
+		cs_log_count[entry->result]++;
+	}
+	spin_unlock(&cs_log_lock);
+	if (quota_exceeded) {
+		kfree(buf);
+		kfree(entry);
+		return;
+	}
+	wake_up(&cs_log_wait);
+}
+
+/**
+ * cs_read_log - Read an audit log.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ *
+ * Returns nothing.
+ */
+static void cs_read_log(struct cs_io_buffer *head)
+{
+	struct cs_log *ptr = NULL;
+
+	if (head->r.w_pos)
+		return;
+	kfree(head->read_buf);
+	head->read_buf = NULL;
+	spin_lock(&cs_log_lock);
+	if (!list_empty(&cs_log)) {
+		ptr = list_entry(cs_log.next, typeof(*ptr), list);
+		list_del(&ptr->list);
+		cs_log_count[ptr->result]--;
+		cs_memory_used[CS_MEMORY_AUDIT] -= ptr->size;
+	}
+	spin_unlock(&cs_log_lock);
+	if (ptr) {
+		head->read_buf = ptr->log;
+		head->r.w[head->r.w_pos++] = head->read_buf;
+		kfree(ptr);
+	}
+}
+
+/**
+ * cs_transit_domain - Transit to other domain.
+ *
+ * @domainname: The name of domain.
+ *
+ * Returns true on success, false otherwise.
+ *
+ * Caller holds cs_read_lock().
+ */
+bool cs_transit_domain(const char *domainname)
+{
+	struct cs_security *security = cs_current_security();
+	struct cs_domain_info e = { };
+	struct cs_domain_info *entry = cs_find_domain(domainname);
+
+	if (entry) {
+		security->cs_domain_info = entry;
+		return true;
+	}
+	/* Requested domain does not exist. */
+	/* Don't create requested domain if domainname is invalid. */
+	if (!cs_correct_domain(domainname))
+		return false;
+	e.domainname = cs_get_name(domainname);
+	if (!e.domainname)
+		return false;
+	if (mutex_lock_killable(&cs_policy_lock))
+		goto out;
+	entry = cs_find_domain(domainname);
+	if (entry)
+		goto done;
+	entry = cs_commit_ok(&e, sizeof(e));
+	if (!entry)
+		goto done;
+	list_add_tail_rcu(&entry->list, &cs_domain_list);
+done:
+	mutex_unlock(&cs_policy_lock);
+out:
+	cs_put_name(e.domainname);
+	if (entry)
+		security->cs_domain_info = entry;
+	return entry != NULL;
+}
+
+/**
+ * cs_parse_policy - Parse a policy line.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ * @line: Line to parse.
+ *
+ * Returns 0 on success, negative value otherwise.
+ *
+ * Caller holds cs_read_lock().
+ */
+static int cs_parse_policy(struct cs_io_buffer *head, char *line)
+{
+	/* Set current line's content. */
+	head->w.data = line;
+	head->w.is_deny = false;
+	head->w.priority = 0;
+	/* Delete request? */
+	head->w.is_delete = !strncmp(line, "delete ", 7);
+	if (head->w.is_delete)
+		memmove(line, line + 7, strlen(line + 7) + 1);
+	/* Do the update. */
+	switch (head->type) {
+	case CS_PROCESS_STATUS:
+		return cs_write_pid(head);
+	case CS_QUERY:
+		return cs_write_answer(head);
+	case CS_POLICY:
+		return cs_write_policy(head);
+	default:
+		return -EINVAL;
+	}
+}
+
+/**
+ * cs_load_builtin_policy - Load built-in policy.
+ *
+ * Returns nothing.
+ */
+static void __init cs_load_builtin_policy(void)
+{
+	/*
+	 * This include file is manually created and contains built-in policy.
+	 *
+	 * static char [] __initdata cs_builtin_policy = { ... };
+	 */
+#include "builtin-policy.h"
+	const int idx = cs_read_lock();
+	struct cs_io_buffer head = { };
+	char *start = cs_builtin_policy;
+
+	head.type = CS_POLICY;
+	while (1) {
+		char *end = strchr(start, '\n');
+
+		if (!end)
+			break;
+		*end = '\0';
+		cs_normalize_line(start);
+		head.write_buf = start;
+		cs_parse_policy(&head, start);
+		start = end + 1;
+	}
+	cs_read_unlock(idx);
+#ifdef CONFIG_SECURITY_CAITSITH_OMIT_USERSPACE_LOADER
+	cs_check_profile();
+#endif
+}
+
+/**
+ * cs_read_self - read() for /sys/kernel/security/caitsith/self_domain interface.
+ *
+ * @file:  Pointer to "struct file".
+ * @buf:   Domainname which current thread belongs to.
+ * @count: Size of @buf.
+ * @ppos:  Bytes read by now.
+ *
+ * Returns read size on success, negative value otherwise.
+ */
+static ssize_t cs_read_self(struct file *file, char __user *buf, size_t count,
+			    loff_t *ppos)
+{
+	const char *domain = cs_current_domain()->domainname->name;
+	loff_t len = strlen(domain);
+	loff_t pos = *ppos;
+
+	if (pos >= len || !count)
+		return 0;
+	len -= pos;
+	if (count < len)
+		len = count;
+	if (copy_to_user(buf, domain + pos, len))
+		return -EFAULT;
+	*ppos += len;
+	return len;
+}
+
+/**
+ * cs_read_subacl - Read sub ACL in ACL entry.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ * @list: Pointer to "struct list_head".
+ *
+ * Returns true on success, false otherwise.
+ *
+ * Caller holds cs_read_lock().
+ */
+static bool cs_read_subacl(struct cs_io_buffer *head,
+			   const struct list_head *list)
+{
+	list_for_each_cookie(head->r.subacl, list) {
+		struct cs_acl_info *acl =
+			list_entry(head->r.subacl, typeof(*acl), list);
+
+		switch (head->r.step) {
+		case 3:
+			if (acl->is_deleted)
+				continue;
+			if (!cs_flush(head))
+				return false;
+			cs_io_printf(head, "    %u ", acl->priority);
+			if (acl->is_deny)
+				cs_set_string(head, "deny");
+			else
+				cs_set_string(head, "allow");
+			head->r.cond_step = 0;
+			head->r.step++;
+			fallthrough;
+		case 4:
+			if (!cs_flush(head))
+				return false;
+			if (acl->cond &&
+			    !cs_print_condition(head, acl->cond))
+				return false;
+			cs_set_lf(head);
+			head->r.step--;
+		}
+	}
+	head->r.subacl = NULL;
+	return true;
+}
+
+/**
+ * cs_read_policy - Read policy.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ *
+ * Caller holds cs_read_lock().
+ */
+static void cs_read_policy(struct cs_io_buffer *head)
+{
+	if (head->r.eof)
+		return;
+	if (head->r.print_this_acl_only)
+		goto skip;
+	if (!head->r.version_done) {
+		cs_io_printf(head, "POLICY_VERSION=%u\n", cs_policy_version);
+		head->r.version_done = true;
+	}
+	if (!head->r.stat_done) {
+		cs_read_stat(head);
+		head->r.stat_done = true;
+	}
+	if (!head->r.quota_done) {
+		if (!cs_read_quota(head))
+			return;
+		head->r.quota_done = true;
+	}
+	if (!head->r.group_done) {
+		if (!cs_read_group(head))
+			return;
+		head->r.group_done = true;
+		cs_set_lf(head);
+	}
+	while (head->r.acl_index < CS_MAX_MAC_INDEX) {
+		list_for_each_cookie(head->r.acl,
+				     &cs_acl_list[head->r.acl_index]) {
+			struct cs_acl_info *ptr;
+
+skip:
+			ptr = list_entry(head->r.acl, typeof(*ptr), list);
+			switch (head->r.step) {
+			case 0:
+				if (ptr->is_deleted &&
+				    !head->r.print_this_acl_only)
+					continue;
+				head->r.step++;
+				fallthrough;
+			case 1:
+				if (!cs_read_acl(head, ptr))
+					return;
+				head->r.step++;
+				fallthrough;
+			case 2:
+				if (!cs_flush(head))
+					return;
+				cs_io_printf(head, "    audit %u\n",
+					     ptr->audit);
+				head->r.step++;
+				fallthrough;
+			case 3:
+			case 4:
+				if (!cs_read_subacl(head,
+						    &ptr->acl_info_list))
+					return;
+				head->r.step = 5;
+				fallthrough;
+			case 5:
+				if (!cs_flush(head))
+					return;
+				cs_set_lf(head);
+				head->r.step = 0;
+				if (head->r.print_this_acl_only)
+					goto done;
+			}
+		}
+		head->r.acl = NULL;
+		head->r.acl_index++;
+	}
+done:
+	head->r.eof = true;
+}
+
+/**
+ * cs_open - open() for /sys/kernel/security/caitsith/ interface.
+ *
+ * @inode: Pointer to "struct inode".
+ * @file:  Pointer to "struct file".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_open(struct inode *inode, struct file *file)
+{
+	const u8 type = (unsigned long) inode->i_private;
+	struct cs_io_buffer *head = kzalloc(sizeof(*head), GFP_NOFS);
+
+	if (!head)
+		return -ENOMEM;
+	mutex_init(&head->io_sem);
+	head->type = type;
+	if ((file->f_mode & FMODE_READ) && type != CS_AUDIT &&
+	    type != CS_QUERY) {
+		/* Don't allocate read_buf for poll() access. */
+		head->readbuf_size = 4096;
+		head->read_buf = kzalloc(head->readbuf_size, GFP_NOFS);
+		if (!head->read_buf) {
+			kfree(head);
+			return -ENOMEM;
+		}
+	}
+	if (file->f_mode & FMODE_WRITE) {
+		head->writebuf_size = 4096;
+		head->write_buf = kzalloc(head->writebuf_size, GFP_NOFS);
+		if (!head->write_buf) {
+			kfree(head->read_buf);
+			kfree(head);
+			return -ENOMEM;
+		}
+	}
+	/*
+	 * If the file is /sys/kernel/security/caitsith/query , increment the
+	 * observer counter. The obserber counter is used by cs_supervisor() to
+	 * see if there is some process monitoring
+	 * /sys/kernel/security/caitsith/query .
+	 */
+	if (type == CS_QUERY)
+		atomic_inc(&cs_query_observers);
+	file->private_data = head;
+	cs_notify_gc(head, true);
+	return 0;
+}
+
+/**
+ * cs_release - close() for /sys/kernel/security/caitsith/ interface.
+ *
+ * @inode: Pointer to "struct inode".
+ * @file:  Pointer to "struct file".
+ *
+ * Returns 0.
+ */
+static int cs_release(struct inode *inode, struct file *file)
+{
+	struct cs_io_buffer *head = file->private_data;
+
+	/*
+	 * If the file is /sys/kernel/security/caitsith/query ,
+	 * decrement the observer counter.
+	 */
+	if (head->type == CS_QUERY &&
+	    atomic_dec_and_test(&cs_query_observers))
+		wake_up_all(&cs_answer_wait);
+	cs_notify_gc(head, false);
+	return 0;
+}
+
+/**
+ * cs_poll - poll() for /sys/kernel/security/caitsith/ interface.
+ *
+ * @file: Pointer to "struct file".
+ * @wait: Pointer to "poll_table". Maybe NULL.
+ *
+ * Returns POLLIN | POLLRDNORM | POLLOUT | POLLWRNORM if ready to read/write,
+ * POLLOUT | POLLWRNORM otherwise.
+ */
+static unsigned int cs_poll(struct file *file, poll_table *wait)
+{
+	struct cs_io_buffer *head = file->private_data;
+
+	if (head->type == CS_AUDIT) {
+		if (!cs_memory_used[CS_MEMORY_AUDIT]) {
+			poll_wait(file, &cs_log_wait, wait);
+			if (!cs_memory_used[CS_MEMORY_AUDIT])
+				return POLLOUT | POLLWRNORM;
+		}
+	} else if (head->type == CS_QUERY) {
+		if (list_empty(&cs_query_list)) {
+			poll_wait(file, &cs_query_wait, wait);
+			if (list_empty(&cs_query_list))
+				return POLLOUT | POLLWRNORM;
+		}
+	}
+	return POLLIN | POLLRDNORM | POLLOUT | POLLWRNORM;
+}
+
+/**
+ * cs_read - read() for /sys/kernel/security/caitsith/ interface.
+ *
+ * @file:  Pointer to "struct file".
+ * @buf:   Pointer to buffer.
+ * @count: Size of @buf.
+ * @ppos:  Unused.
+ *
+ * Returns bytes read on success, negative value otherwise.
+ */
+static ssize_t cs_read(struct file *file, char __user *buf, size_t count,
+		       loff_t *ppos)
+{
+	struct cs_io_buffer *head = file->private_data;
+	int len;
+	int idx;
+
+	if (mutex_lock_killable(&head->io_sem))
+		return -EINTR;
+	head->read_user_buf = buf;
+	head->read_user_buf_avail = count;
+	idx = cs_read_lock();
+	if (cs_flush(head)) {
+		/* Call the policy handler. */
+		switch (head->type) {
+		case CS_AUDIT:
+			cs_read_log(head);
+			break;
+		case CS_PROCESS_STATUS:
+			cs_read_pid(head);
+			break;
+		case CS_VERSION:
+			cs_read_version(head);
+			break;
+		case CS_QUERY:
+			cs_read_query(head);
+			break;
+		case CS_POLICY:
+			cs_read_policy(head);
+			break;
+		}
+		cs_flush(head);
+	}
+	cs_read_unlock(idx);
+	len = head->read_user_buf - buf;
+	mutex_unlock(&head->io_sem);
+	return len;
+}
+
+#ifdef CONFIG_SECURITY_CAITSITH_MANUAL_DOMAIN_TRANSITION
+
+/**
+ * cs_write_self - write() for /sys/kernel/security/caitsith/self_domain interface.
+ *
+ * @file:  Pointer to "struct file".
+ * @buf:   Domainname to transit to.
+ * @count: Size of @buf.
+ * @ppos:  Unused.
+ *
+ * Returns @count on success, negative value otherwise.
+ *
+ * If domain transition was permitted but the domain transition failed, this
+ * function returns error rather than terminating current thread with SIGKILL.
+ */
+static ssize_t cs_write_self(struct file *file, const char __user *buf,
+			     size_t count, loff_t *ppos)
+{
+	char *data;
+	int error;
+
+	if (!count || count >= CS_EXEC_TMPSIZE - 10)
+		return -ENOMEM;
+	data = memdup_user_nul(buf, count);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+	cs_normalize_line(data);
+	if (cs_correct_domain(data)) {
+		const int idx = cs_read_lock();
+		struct cs_path_info name;
+		struct cs_request_info r = { };
+
+		name.name = data;
+		cs_fill_path_info(&name);
+		/* Check "manual_domain_transition" permission. */
+		r.type = CS_MAC_MANUAL_DOMAIN_TRANSITION;
+		r.param.s[0] = &name;
+		cs_check_acl(&r, true);
+		if (r.result != CS_MATCHING_ALLOWED)
+			error = -EPERM;
+		else
+			error = cs_transit_domain(data) ? 0 : -ENOENT;
+		cs_read_unlock(idx);
+	} else
+		error = -EINVAL;
+	kfree(data);
+	return error ? error : count;
+}
+
+#endif
+
+/**
+ * cs_write - write() for /sys/kernel/security/caitsith/ interface.
+ *
+ * @file:  Pointer to "struct file".
+ * @buf:   Pointer to buffer.
+ * @count: Size of @buf.
+ * @ppos:  Unused.
+ *
+ * Returns @count on success, negative value otherwise.
+ */
+static ssize_t cs_write(struct file *file, const char __user *buf,
+			size_t count, loff_t *ppos)
+{
+	struct cs_io_buffer *head = file->private_data;
+	int error = count;
+	char *cp0 = head->write_buf;
+	int idx;
+
+	if (mutex_lock_killable(&head->io_sem))
+		return -EINTR;
+	head->read_user_buf_avail = 0;
+	idx = cs_read_lock();
+	/* Read a line and dispatch it to the policy handler. */
+	while (count) {
+		char c;
+
+		if (head->w.avail >= head->writebuf_size - 1) {
+			const int len = head->writebuf_size * 2;
+			char *cp = kzalloc(len, GFP_NOFS);
+
+			if (!cp) {
+				error = -ENOMEM;
+				break;
+			}
+			memmove(cp, cp0, head->w.avail);
+			kfree(cp0);
+			head->write_buf = cp;
+			cp0 = cp;
+			head->writebuf_size = len;
+		}
+		if (get_user(c, buf)) {
+			error = -EFAULT;
+			break;
+		}
+		buf++;
+		count--;
+		cp0[head->w.avail++] = c;
+		if (c != '\n')
+			continue;
+		cp0[head->w.avail - 1] = '\0';
+		head->w.avail = 0;
+		cs_normalize_line(cp0);
+		/* Don't allow updating policies by non manager programs. */
+		if (head->type != CS_PROCESS_STATUS && !cs_manager()) {
+			error = -EPERM;
+			goto out;
+		}
+		switch (cs_parse_policy(head, cp0)) {
+		case -EPERM:
+			error = -EPERM;
+			goto out;
+		case 0:
+			/* Update statistics. */
+			if (head->type == CS_POLICY)
+				cs_update_stat(CS_STAT_POLICY_UPDATES);
+			break;
+		}
+	}
+out:
+	cs_read_unlock(idx);
+	mutex_unlock(&head->io_sem);
+	return error;
+}
+
+/**
+ * cs_create_entry - Create interface files under /sys/kernel/security/caitsith/ directory.
+ *
+ * @name:   The name of the interface file.
+ * @mode:   The permission of the interface file.
+ * @parent: The parent directory.
+ * @key:    Type of interface.
+ *
+ * Returns nothing.
+ */
+static void __init cs_create_entry(const char *name, const umode_t mode,
+				   struct dentry *parent, const u8 key)
+{
+	securityfs_create_file(name, S_IFREG | mode, parent,
+			       (void *) (unsigned long) key, &cs_operations);
+}
+
+/**
+ * cs_securityfs_init - Initialize /sys/kernel/security/caitsith/ interface.
+ *
+ * Returns nothing.
+ */
+static void __init cs_securityfs_init(void)
+{
+	struct dentry *cs_dir = securityfs_create_dir("caitsith", NULL);
+
+	cs_create_entry("query",            0600, cs_dir, CS_QUERY);
+	cs_create_entry("audit",            0400, cs_dir, CS_AUDIT);
+	cs_create_entry(".process_status",  0600, cs_dir, CS_PROCESS_STATUS);
+	cs_create_entry("version",          0400, cs_dir, CS_VERSION);
+	cs_create_entry("policy",           0600, cs_dir, CS_POLICY);
+	securityfs_create_file("self_domain", S_IFREG | 0666, cs_dir, NULL,
+			       &cs_self_operations);
+}
+
+/**
+ * cs_init_module - Initialize this module.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int __init cs_init_module(void)
+{
+	u16 idx;
+
+#ifdef DEBUG_CONDITION
+	for (idx = 0; idx < CS_MAX_MAC_INDEX; idx++) {
+		if (cs_mac_keywords[idx])
+			continue;
+		pr_info("cs_mac_keywords[%u]==NULL\n", idx);
+		return -EINVAL;
+	}
+#endif
+	if (init_srcu_struct(&cs_ss))
+		panic("Out of memory.");
+	for (idx = 0; idx < CS_MAX_MAC_INDEX; idx++)
+		INIT_LIST_HEAD(&cs_acl_list[idx]);
+	for (idx = 0; idx < CS_MAX_GROUP; idx++)
+		INIT_LIST_HEAD(&cs_group_list[idx]);
+	for (idx = 0; idx < CS_MAX_HASH; idx++)
+		INIT_LIST_HEAD(&cs_name_list[idx]);
+	cs_null_name.name = "NULL";
+	cs_fill_path_info(&cs_null_name);
+	cs_kernel_domain.domainname = cs_get_name("<kernel>");
+	list_add_tail_rcu(&cs_kernel_domain.list, &cs_domain_list);
+	cs_securityfs_init();
+	cs_load_builtin_policy();
+	return 0;
+}
-- 
2.18.4

