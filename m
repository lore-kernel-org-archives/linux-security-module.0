Return-Path: <SRS0=u3U2=QA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2735FC282C3
	for <linux-security-module@archiver.kernel.org>; Thu, 24 Jan 2019 09:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B42218A2
	for <linux-security-module@archiver.kernel.org>; Thu, 24 Jan 2019 09:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfAXJiD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:38:03 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:10705 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfAXJiD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 Jan 2019 04:38:03 -0500
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0O9biiG015229;
        Thu, 24 Jan 2019 18:37:44 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Thu, 24 Jan 2019 18:37:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0O9bcUx015135
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 24 Jan 2019 18:37:44 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 1/2] tomoyo: Coding style fix.
Date:   Thu, 24 Jan 2019 18:37:35 +0900
Message-Id: <1548322656-9212-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Follow many of recommendations by scripts/checkpatch.pl, and follow
"lift switch variables out of switches" by Kees Cook.
This patch makes no functional change.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/tomoyo/audit.c         |  31 +++++----
 security/tomoyo/common.c        | 138 ++++++++++++++++++++++++++++------------
 security/tomoyo/common.h        |  13 ++--
 security/tomoyo/condition.c     |  59 ++++++++++++-----
 security/tomoyo/domain.c        |  50 ++++++++++-----
 security/tomoyo/file.c          |  20 ++++++
 security/tomoyo/gc.c            |  19 ++++++
 security/tomoyo/group.c         |   5 ++
 security/tomoyo/load_policy.c   |   8 +--
 security/tomoyo/memory.c        |   9 ++-
 security/tomoyo/mount.c         |   2 +
 security/tomoyo/realpath.c      |  18 +++++-
 security/tomoyo/securityfs_if.c |   4 ++
 security/tomoyo/tomoyo.c        |  15 ++++-
 security/tomoyo/util.c          |  23 +++++--
 15 files changed, 309 insertions(+), 105 deletions(-)

diff --git a/security/tomoyo/audit.c b/security/tomoyo/audit.c
index 479b03a..3c96e84 100644
--- a/security/tomoyo/audit.c
+++ b/security/tomoyo/audit.c
@@ -32,6 +32,7 @@ static char *tomoyo_print_bprm(struct linux_binprm *bprm,
 	int argv_count = bprm->argc;
 	int envp_count = bprm->envc;
 	bool truncated = false;
+
 	if (!buffer)
 		return NULL;
 	len = snprintf(buffer, tomoyo_buffer_len - 1, "argv[]={ ");
@@ -49,6 +50,7 @@ static char *tomoyo_print_bprm(struct linux_binprm *bprm,
 		while (offset < PAGE_SIZE) {
 			const char *kaddr = dump->data;
 			const unsigned char c = kaddr[offset++];
+
 			if (cp == last_start)
 				*cp++ = '"';
 			if (cp >= buffer + tomoyo_buffer_len - 32) {
@@ -154,19 +156,18 @@ static char *tomoyo_print_header(struct tomoyo_request_info *r)
 	char *buffer = kmalloc(tomoyo_buffer_len, GFP_NOFS);
 	int pos;
 	u8 i;
+
 	if (!buffer)
 		return NULL;
 
 	tomoyo_convert_time(ktime_get_real_seconds(), &stamp);
 
 	pos = snprintf(buffer, tomoyo_buffer_len - 1,
-		       "#%04u/%02u/%02u %02u:%02u:%02u# profile=%u mode=%s "
-		       "granted=%s (global-pid=%u) task={ pid=%u ppid=%u "
-		       "uid=%u gid=%u euid=%u egid=%u suid=%u sgid=%u "
-		       "fsuid=%u fsgid=%u }", stamp.year, stamp.month,
-		       stamp.day, stamp.hour, stamp.min, stamp.sec, r->profile,
-		       tomoyo_mode[r->mode], tomoyo_yesno(r->granted), gpid,
-		       tomoyo_sys_getpid(), tomoyo_sys_getppid(),
+		       "#%04u/%02u/%02u %02u:%02u:%02u# profile=%u mode=%s granted=%s (global-pid=%u) task={ pid=%u ppid=%u uid=%u gid=%u euid=%u egid=%u suid=%u sgid=%u fsuid=%u fsgid=%u }",
+		       stamp.year, stamp.month, stamp.day, stamp.hour,
+		       stamp.min, stamp.sec, r->profile, tomoyo_mode[r->mode],
+		       tomoyo_yesno(r->granted), gpid, tomoyo_sys_getpid(),
+		       tomoyo_sys_getppid(),
 		       from_kuid(&init_user_ns, current_uid()),
 		       from_kgid(&init_user_ns, current_gid()),
 		       from_kuid(&init_user_ns, current_euid()),
@@ -185,6 +186,7 @@ static char *tomoyo_print_header(struct tomoyo_request_info *r)
 		struct tomoyo_mini_stat *stat;
 		unsigned int dev;
 		umode_t mode;
+
 		if (!obj->stat_valid[i])
 			continue;
 		stat = &obj->stat[i];
@@ -193,8 +195,8 @@ static char *tomoyo_print_header(struct tomoyo_request_info *r)
 		if (i & 1) {
 			pos += snprintf(buffer + pos,
 					tomoyo_buffer_len - 1 - pos,
-					" path%u.parent={ uid=%u gid=%u "
-					"ino=%lu perm=0%o }", (i >> 1) + 1,
+					" path%u.parent={ uid=%u gid=%u ino=%lu perm=0%o }",
+					(i >> 1) + 1,
 					from_kuid(&init_user_ns, stat->uid),
 					from_kgid(&init_user_ns, stat->gid),
 					(unsigned long)stat->ino,
@@ -202,8 +204,8 @@ static char *tomoyo_print_header(struct tomoyo_request_info *r)
 			continue;
 		}
 		pos += snprintf(buffer + pos, tomoyo_buffer_len - 1 - pos,
-				" path%u={ uid=%u gid=%u ino=%lu major=%u"
-				" minor=%u perm=0%o type=%s", (i >> 1) + 1,
+				" path%u={ uid=%u gid=%u ino=%lu major=%u minor=%u perm=0%o type=%s",
+				(i >> 1) + 1,
 				from_kuid(&init_user_ns, stat->uid),
 				from_kgid(&init_user_ns, stat->gid),
 				(unsigned long)stat->ino,
@@ -249,6 +251,7 @@ char *tomoyo_init_log(struct tomoyo_request_info *r, int len, const char *fmt,
 	const char *symlink = NULL;
 	int pos;
 	const char *domainname = r->domain->domainname->name;
+
 	header = tomoyo_print_header(r);
 	if (!header)
 		return NULL;
@@ -256,6 +259,7 @@ char *tomoyo_init_log(struct tomoyo_request_info *r, int len, const char *fmt,
 	len += strlen(domainname) + strlen(header) + 10;
 	if (r->ee) {
 		struct file *file = r->ee->bprm->file;
+
 		realpath = tomoyo_realpath_from_path(&file->f_path);
 		bprm_info = tomoyo_print_bprm(r->ee->bprm, &r->ee->dump);
 		if (!realpath || !bprm_info)
@@ -275,6 +279,7 @@ char *tomoyo_init_log(struct tomoyo_request_info *r, int len, const char *fmt,
 	pos = snprintf(buf, len, "%s", header);
 	if (realpath) {
 		struct linux_binprm *bprm = r->ee->bprm;
+
 		pos += snprintf(buf + pos, len - pos,
 				" exec={ realpath=\"%s\" argc=%d envc=%d %s }",
 				realpath, bprm->argc, bprm->envc, bprm_info);
@@ -328,6 +333,7 @@ static bool tomoyo_get_audit(const struct tomoyo_policy_namespace *ns,
 	const u8 category = tomoyo_index2category[index] +
 		TOMOYO_MAX_MAC_INDEX;
 	struct tomoyo_profile *p;
+
 	if (!tomoyo_policy_loaded)
 		return false;
 	p = tomoyo_profile(ns, profile);
@@ -362,6 +368,7 @@ void tomoyo_write_log2(struct tomoyo_request_info *r, int len, const char *fmt,
 	char *buf;
 	struct tomoyo_log *entry;
 	bool quota_exceeded = false;
+
 	if (!tomoyo_get_audit(r->domain->ns, r->profile, r->type,
 			      r->matched_acl, r->granted))
 		goto out;
@@ -413,6 +420,7 @@ void tomoyo_write_log(struct tomoyo_request_info *r, const char *fmt, ...)
 {
 	va_list args;
 	int len;
+
 	va_start(args, fmt);
 	len = vsnprintf((char *) &len, 1, fmt, args) + 1;
 	va_end(args);
@@ -431,6 +439,7 @@ void tomoyo_write_log(struct tomoyo_request_info *r, const char *fmt, ...)
 void tomoyo_read_log(struct tomoyo_io_buffer *head)
 {
 	struct tomoyo_log *ptr = NULL;
+
 	if (head->r.w_pos)
 		return;
 	kfree(head->read_buf);
diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 6936def..0f8079b 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -197,6 +197,7 @@ static void tomoyo_addprintf(char *buffer, int len, const char *fmt, ...)
 {
 	va_list args;
 	const int pos = strlen(buffer);
+
 	va_start(args, fmt);
 	vsnprintf(buffer + pos, len - pos - 1, fmt, args);
 	va_end(args);
@@ -214,6 +215,7 @@ static bool tomoyo_flush(struct tomoyo_io_buffer *head)
 	while (head->r.w_pos) {
 		const char *w = head->r.w[0];
 		size_t len = strlen(w);
+
 		if (len) {
 			if (len > head->read_user_buf_avail)
 				len = head->read_user_buf_avail;
@@ -279,6 +281,7 @@ static void tomoyo_io_printf(struct tomoyo_io_buffer *head, const char *fmt,
 	size_t len;
 	size_t pos = head->r.avail;
 	int size = head->readbuf_size - pos;
+
 	if (size <= 0)
 		return;
 	va_start(args, fmt);
@@ -344,6 +347,7 @@ static void tomoyo_set_slash(struct tomoyo_io_buffer *head)
 void tomoyo_init_policy_namespace(struct tomoyo_policy_namespace *ns)
 {
 	unsigned int idx;
+
 	for (idx = 0; idx < TOMOYO_MAX_ACL_GROUPS; idx++)
 		INIT_LIST_HEAD(&ns->acl_group[idx]);
 	for (idx = 0; idx < TOMOYO_MAX_GROUP; idx++)
@@ -433,6 +437,7 @@ static void tomoyo_print_name_union_quoted(struct tomoyo_io_buffer *head,
 		u8 min_type = ptr->value_type[0];
 		const u8 max_type = ptr->value_type[1];
 		char buffer[128];
+
 		buffer[0] = '\0';
 		for (i = 0; i < 2; i++) {
 			switch (min_type) {
@@ -487,6 +492,7 @@ static void tomoyo_print_number_union(struct tomoyo_io_buffer *head,
 {
 	struct tomoyo_profile *ptr;
 	struct tomoyo_profile *entry;
+
 	if (profile >= TOMOYO_MAX_PROFILES)
 		return NULL;
 	ptr = ns->profile_ptr[profile];
@@ -530,6 +536,7 @@ struct tomoyo_profile *tomoyo_profile(const struct tomoyo_policy_namespace *ns,
 {
 	static struct tomoyo_profile tomoyo_null_profile;
 	struct tomoyo_profile *ptr = ns->profile_ptr[profile];
+
 	if (!ptr)
 		ptr = &tomoyo_null_profile;
 	return ptr;
@@ -546,6 +553,7 @@ struct tomoyo_profile *tomoyo_profile(const struct tomoyo_policy_namespace *ns,
 static s8 tomoyo_find_yesno(const char *string, const char *find)
 {
 	const char *cp = strstr(string, find);
+
 	if (cp) {
 		cp += strlen(find);
 		if (!strncmp(cp, "=yes", 4))
@@ -569,6 +577,7 @@ static void tomoyo_set_uint(unsigned int *i, const char *string,
 			    const char *find)
 {
 	const char *cp = strstr(string, find);
+
 	if (cp)
 		sscanf(cp + strlen(find), "=%u", i);
 }
@@ -587,6 +596,7 @@ static int tomoyo_set_mode(char *name, const char *value,
 {
 	u8 i;
 	u8 config;
+
 	if (!strcmp(name, "CONFIG")) {
 		i = TOMOYO_MAX_MAC_INDEX + TOMOYO_MAX_MAC_CATEGORY_INDEX;
 		config = profile->default_config;
@@ -595,10 +605,12 @@ static int tomoyo_set_mode(char *name, const char *value,
 		for (i = 0; i < TOMOYO_MAX_MAC_INDEX
 			     + TOMOYO_MAX_MAC_CATEGORY_INDEX; i++) {
 			int len = 0;
+
 			if (i < TOMOYO_MAX_MAC_INDEX) {
 				const u8 c = tomoyo_index2category[i];
 				const char *category =
 					tomoyo_category_keywords[c];
+
 				len = strlen(category);
 				if (strncmp(name, category, len) ||
 				    name[len++] != ':' || name[len++] != ':')
@@ -618,6 +630,7 @@ static int tomoyo_set_mode(char *name, const char *value,
 		config = TOMOYO_CONFIG_USE_DEFAULT;
 	} else {
 		u8 mode;
+
 		for (mode = 0; mode < 4; mode++)
 			if (strstr(value, tomoyo_mode[mode]))
 				/*
@@ -664,6 +677,7 @@ static int tomoyo_write_profile(struct tomoyo_io_buffer *head)
 	unsigned int i;
 	char *cp;
 	struct tomoyo_profile *profile;
+
 	if (sscanf(data, "PROFILE_VERSION=%u", &head->w.ns->profile_version)
 	    == 1)
 		return 0;
@@ -683,6 +697,7 @@ static int tomoyo_write_profile(struct tomoyo_io_buffer *head)
 		const struct tomoyo_path_info *new_comment
 			= tomoyo_get_name(cp);
 		const struct tomoyo_path_info *old_comment;
+
 		if (!new_comment)
 			return -ENOMEM;
 		spin_lock(&lock);
@@ -732,6 +747,7 @@ static void tomoyo_read_profile(struct tomoyo_io_buffer *head)
 	struct tomoyo_policy_namespace *ns =
 		container_of(head->r.ns, typeof(*ns), namespace_list);
 	const struct tomoyo_profile *profile;
+
 	if (head->r.eof)
 		return;
  next:
@@ -760,6 +776,7 @@ static void tomoyo_read_profile(struct tomoyo_io_buffer *head)
 			u8 i;
 			const struct tomoyo_path_info *comment =
 				profile->comment;
+
 			tomoyo_print_namespace(head);
 			tomoyo_io_printf(head, "%u-COMMENT=", index);
 			tomoyo_set_string(head, comment ? comment->name : "");
@@ -788,6 +805,7 @@ static void tomoyo_read_profile(struct tomoyo_io_buffer *head)
 			      + TOMOYO_MAX_MAC_CATEGORY_INDEX; head->r.bit++) {
 			const u8 i = head->r.bit;
 			const u8 config = profile->config[i];
+
 			if (config == TOMOYO_CONFIG_USE_DEFAULT)
 				continue;
 			tomoyo_print_namespace(head);
@@ -847,10 +865,10 @@ static int tomoyo_update_manager_entry(const char *manager,
 	struct tomoyo_acl_param param = {
 		/* .ns = &tomoyo_kernel_namespace, */
 		.is_delete = is_delete,
-		.list = &tomoyo_kernel_namespace.
-		policy_list[TOMOYO_ID_MANAGER],
+		.list = &tomoyo_kernel_namespace.policy_list[TOMOYO_ID_MANAGER],
 	};
 	int error = is_delete ? -ENOENT : -ENOMEM;
+
 	if (!tomoyo_correct_domain(manager) &&
 	    !tomoyo_correct_word(manager))
 		return -EINVAL;
@@ -894,10 +912,10 @@ static void tomoyo_read_manager(struct tomoyo_io_buffer *head)
 {
 	if (head->r.eof)
 		return;
-	list_for_each_cookie(head->r.acl, &tomoyo_kernel_namespace.
-			     policy_list[TOMOYO_ID_MANAGER]) {
+	list_for_each_cookie(head->r.acl, &tomoyo_kernel_namespace.policy_list[TOMOYO_ID_MANAGER]) {
 		struct tomoyo_manager *ptr =
 			list_entry(head->r.acl, typeof(*ptr), head.list);
+
 		if (ptr->head.is_deleted)
 			continue;
 		if (!tomoyo_flush(head))
@@ -933,8 +951,7 @@ static bool tomoyo_manager(void)
 	exe = tomoyo_get_exe();
 	if (!exe)
 		return false;
-	list_for_each_entry_rcu(ptr, &tomoyo_kernel_namespace.
-				policy_list[TOMOYO_ID_MANAGER], head.list) {
+	list_for_each_entry_rcu(ptr, &tomoyo_kernel_namespace.policy_list[TOMOYO_ID_MANAGER], head.list) {
 		if (!ptr->head.is_deleted &&
 		    (!tomoyo_pathcmp(domainname, ptr->manager) ||
 		     !strcmp(exe, ptr->manager->name))) {
@@ -945,9 +962,10 @@ static bool tomoyo_manager(void)
 	if (!found) { /* Reduce error messages. */
 		static pid_t last_pid;
 		const pid_t pid = current->pid;
+
 		if (last_pid != pid) {
-			printk(KERN_WARNING "%s ( %s ) is not permitted to "
-			       "update policies.\n", domainname->name, exe);
+			pr_warn("%s ( %s ) is not permitted to update policies.\n",
+				domainname->name, exe);
 			last_pid = pid;
 		}
 	}
@@ -974,12 +992,14 @@ static bool tomoyo_select_domain(struct tomoyo_io_buffer *head,
 	unsigned int pid;
 	struct tomoyo_domain_info *domain = NULL;
 	bool global_pid = false;
+
 	if (strncmp(data, "select ", 7))
 		return false;
 	data += 7;
 	if (sscanf(data, "pid=%u", &pid) == 1 ||
 	    (global_pid = true, sscanf(data, "global-pid=%u", &pid) == 1)) {
 		struct task_struct *p;
+
 		rcu_read_lock();
 		if (global_pid)
 			p = find_task_by_pid_ns(pid, &init_pid_ns);
@@ -1020,10 +1040,11 @@ static bool tomoyo_select_domain(struct tomoyo_io_buffer *head,
  * Returns true if @a == @b, false otherwise.
  */
 static bool tomoyo_same_task_acl(const struct tomoyo_acl_info *a,
-			      const struct tomoyo_acl_info *b)
+				 const struct tomoyo_acl_info *b)
 {
 	const struct tomoyo_task_acl *p1 = container_of(a, typeof(*p1), head);
 	const struct tomoyo_task_acl *p2 = container_of(b, typeof(*p2), head);
+
 	return p1->domainname == p2->domainname;
 }
 
@@ -1039,11 +1060,13 @@ static bool tomoyo_same_task_acl(const struct tomoyo_acl_info *a,
 static int tomoyo_write_task(struct tomoyo_acl_param *param)
 {
 	int error = -EINVAL;
+
 	if (tomoyo_str_starts(&param->data, "manual_domain_transition ")) {
 		struct tomoyo_task_acl e = {
 			.head.type = TOMOYO_TYPE_MANUAL_TASK_ACL,
 			.domainname = tomoyo_get_domainname(param),
 		};
+
 		if (e.domainname)
 			error = tomoyo_update_domain(&e.head, sizeof(e), param,
 						     tomoyo_same_task_acl,
@@ -1110,7 +1133,7 @@ static int tomoyo_write_domain2(struct tomoyo_policy_namespace *ns,
 	};
 	static const struct {
 		const char *keyword;
-		int (*write) (struct tomoyo_acl_param *);
+		int (*write)(struct tomoyo_acl_param *param);
 	} tomoyo_callback[5] = {
 		{ "file ", tomoyo_write_file },
 		{ "network inet ", tomoyo_write_inet_network },
@@ -1152,8 +1175,10 @@ static int tomoyo_write_domain(struct tomoyo_io_buffer *head)
 	const bool is_delete = head->w.is_delete;
 	bool is_select = !is_delete && tomoyo_str_starts(&data, "select ");
 	unsigned int profile;
+
 	if (*data == '<') {
 		int ret = 0;
+
 		domain = NULL;
 		if (is_delete)
 			ret = tomoyo_delete_domain(data);
@@ -1181,6 +1206,7 @@ static int tomoyo_write_domain(struct tomoyo_io_buffer *head)
 	}
 	for (profile = 0; profile < TOMOYO_MAX_DOMAIN_INFO_FLAGS; profile++) {
 		const char *cp = tomoyo_dif[profile];
+
 		if (strncmp(data, cp, strlen(cp) - 1))
 			continue;
 		domain->flags[profile] = !is_delete;
@@ -1225,9 +1251,11 @@ static bool tomoyo_print_condition(struct tomoyo_io_buffer *head,
 			const struct tomoyo_envp *envp =
 				(typeof(envp)) (argv + cond->argc);
 			u16 skip;
+
 			for (skip = 0; skip < head->r.cond_index; skip++) {
 				const u8 left = condp->left;
 				const u8 right = condp->right;
+
 				condp++;
 				switch (left) {
 				case TOMOYO_ARGV_ENTRY:
@@ -1253,6 +1281,7 @@ static bool tomoyo_print_condition(struct tomoyo_io_buffer *head,
 				const u8 match = condp->equals;
 				const u8 left = condp->left;
 				const u8 right = condp->right;
+
 				if (!tomoyo_flush(head))
 					return false;
 				condp++;
@@ -1262,8 +1291,7 @@ static bool tomoyo_print_condition(struct tomoyo_io_buffer *head,
 				case TOMOYO_ARGV_ENTRY:
 					tomoyo_io_printf(head,
 							 "exec.argv[%lu]%s=\"",
-							 argv->index, argv->
-							 is_not ? "!" : "");
+							 argv->index, argv->is_not ? "!" : "");
 					tomoyo_set_string(head,
 							  argv->value->name);
 					tomoyo_set_string(head, "\"");
@@ -1274,12 +1302,10 @@ static bool tomoyo_print_condition(struct tomoyo_io_buffer *head,
 							  "exec.envp[\"");
 					tomoyo_set_string(head,
 							  envp->name->name);
-					tomoyo_io_printf(head, "\"]%s=", envp->
-							 is_not ? "!" : "");
+					tomoyo_io_printf(head, "\"]%s=", envp->is_not ? "!" : "");
 					if (envp->value) {
 						tomoyo_set_string(head, "\"");
-						tomoyo_set_string(head, envp->
-								  value->name);
+						tomoyo_set_string(head, envp->value->name);
 						tomoyo_set_string(head, "\"");
 					} else {
 						tomoyo_set_string(head,
@@ -1375,6 +1401,7 @@ static bool tomoyo_print_entry(struct tomoyo_io_buffer *head,
 		struct tomoyo_path_acl *ptr =
 			container_of(acl, typeof(*ptr), head);
 		const u16 perm = ptr->perm;
+
 		for (bit = 0; bit < TOMOYO_MAX_PATH_OPERATION; bit++) {
 			if (!(perm & (1 << bit)))
 				continue;
@@ -1395,6 +1422,7 @@ static bool tomoyo_print_entry(struct tomoyo_io_buffer *head,
 	} else if (acl_type == TOMOYO_TYPE_MANUAL_TASK_ACL) {
 		struct tomoyo_task_acl *ptr =
 			container_of(acl, typeof(*ptr), head);
+
 		tomoyo_set_group(head, "task ");
 		tomoyo_set_string(head, "manual_domain_transition ");
 		tomoyo_set_string(head, ptr->domainname->name);
@@ -1404,6 +1432,7 @@ static bool tomoyo_print_entry(struct tomoyo_io_buffer *head,
 		struct tomoyo_path2_acl *ptr =
 			container_of(acl, typeof(*ptr), head);
 		const u8 perm = ptr->perm;
+
 		for (bit = 0; bit < TOMOYO_MAX_PATH2_OPERATION; bit++) {
 			if (!(perm & (1 << bit)))
 				continue;
@@ -1424,6 +1453,7 @@ static bool tomoyo_print_entry(struct tomoyo_io_buffer *head,
 		struct tomoyo_path_number_acl *ptr =
 			container_of(acl, typeof(*ptr), head);
 		const u8 perm = ptr->perm;
+
 		for (bit = 0; bit < TOMOYO_MAX_PATH_NUMBER_OPERATION; bit++) {
 			if (!(perm & (1 << bit)))
 				continue;
@@ -1444,6 +1474,7 @@ static bool tomoyo_print_entry(struct tomoyo_io_buffer *head,
 		struct tomoyo_mkdev_acl *ptr =
 			container_of(acl, typeof(*ptr), head);
 		const u8 perm = ptr->perm;
+
 		for (bit = 0; bit < TOMOYO_MAX_MKDEV_OPERATION; bit++) {
 			if (!(perm & (1 << bit)))
 				continue;
@@ -1490,6 +1521,7 @@ static bool tomoyo_print_entry(struct tomoyo_io_buffer *head,
 					  ->name);
 		} else {
 			char buf[128];
+
 			tomoyo_print_ip(buf, sizeof(buf), &ptr->address);
 			tomoyo_io_printf(head, "%s", buf);
 		}
@@ -1519,6 +1551,7 @@ static bool tomoyo_print_entry(struct tomoyo_io_buffer *head,
 	} else if (acl_type == TOMOYO_TYPE_MOUNT_ACL) {
 		struct tomoyo_mount_acl *ptr =
 			container_of(acl, typeof(*ptr), head);
+
 		tomoyo_set_group(head, "file mount");
 		tomoyo_print_name_union(head, &ptr->dev_name);
 		tomoyo_print_name_union(head, &ptr->dir_name);
@@ -1562,6 +1595,7 @@ static bool tomoyo_read_domain2(struct tomoyo_io_buffer *head,
 	list_for_each_cookie(head->r.acl, list) {
 		struct tomoyo_acl_info *ptr =
 			list_entry(head->r.acl, typeof(*ptr), list);
+
 		if (!tomoyo_print_entry(head, ptr))
 			return false;
 	}
@@ -1583,8 +1617,9 @@ static void tomoyo_read_domain(struct tomoyo_io_buffer *head)
 	list_for_each_cookie(head->r.domain, &tomoyo_domain_list) {
 		struct tomoyo_domain_info *domain =
 			list_entry(head->r.domain, typeof(*domain), list);
+		u8 i;
+
 		switch (head->r.step) {
-			u8 i;
 		case 0:
 			if (domain->is_deleted &&
 			    !head->r.print_this_domain_only)
@@ -1711,6 +1746,7 @@ static int tomoyo_write_exception(struct tomoyo_io_buffer *head)
 		.data = head->write_buf,
 	};
 	u8 i;
+
 	if (tomoyo_str_starts(&param.data, "aggregator "))
 		return tomoyo_write_aggregator(&param);
 	for (i = 0; i < TOMOYO_MAX_TRANSITION_TYPE; i++)
@@ -1722,6 +1758,7 @@ static int tomoyo_write_exception(struct tomoyo_io_buffer *head)
 	if (tomoyo_str_starts(&param.data, "acl_group ")) {
 		unsigned int group;
 		char *data;
+
 		group = simple_strtoul(param.data, &data, 10);
 		if (group < TOMOYO_MAX_ACL_GROUPS && *data++ == ' ')
 			return tomoyo_write_domain2
@@ -1746,12 +1783,15 @@ static bool tomoyo_read_group(struct tomoyo_io_buffer *head, const int idx)
 	struct tomoyo_policy_namespace *ns =
 		container_of(head->r.ns, typeof(*ns), namespace_list);
 	struct list_head *list = &ns->group_list[idx];
+
 	list_for_each_cookie(head->r.group, list) {
 		struct tomoyo_group *group =
 			list_entry(head->r.group, typeof(*group), head.list);
+
 		list_for_each_cookie(head->r.acl, &group->member_list) {
 			struct tomoyo_acl_head *ptr =
 				list_entry(head->r.acl, typeof(*ptr), list);
+
 			if (ptr->is_deleted)
 				continue;
 			if (!tomoyo_flush(head))
@@ -1771,10 +1811,10 @@ static bool tomoyo_read_group(struct tomoyo_io_buffer *head, const int idx)
 							   head)->number);
 			} else if (idx == TOMOYO_ADDRESS_GROUP) {
 				char buffer[128];
-
 				struct tomoyo_address_group *member =
 					container_of(ptr, typeof(*member),
 						     head);
+
 				tomoyo_print_ip(buffer, sizeof(buffer),
 						&member->address);
 				tomoyo_io_printf(head, " %s", buffer);
@@ -1802,6 +1842,7 @@ static bool tomoyo_read_policy(struct tomoyo_io_buffer *head, const int idx)
 	struct tomoyo_policy_namespace *ns =
 		container_of(head->r.ns, typeof(*ns), namespace_list);
 	struct list_head *list = &ns->policy_list[idx];
+
 	list_for_each_cookie(head->r.acl, list) {
 		struct tomoyo_acl_head *acl =
 			container_of(head->r.acl, typeof(*acl), list);
@@ -1814,6 +1855,7 @@ static bool tomoyo_read_policy(struct tomoyo_io_buffer *head, const int idx)
 			{
 				struct tomoyo_transition_control *ptr =
 					container_of(acl, typeof(*ptr), head);
+
 				tomoyo_print_namespace(head);
 				tomoyo_set_string(head, tomoyo_transition_type
 						  [ptr->type]);
@@ -1829,6 +1871,7 @@ static bool tomoyo_read_policy(struct tomoyo_io_buffer *head, const int idx)
 			{
 				struct tomoyo_aggregator *ptr =
 					container_of(acl, typeof(*ptr), head);
+
 				tomoyo_print_namespace(head);
 				tomoyo_set_string(head, "aggregator ");
 				tomoyo_set_string(head,
@@ -1858,6 +1901,7 @@ static void tomoyo_read_exception(struct tomoyo_io_buffer *head)
 {
 	struct tomoyo_policy_namespace *ns =
 		container_of(head->r.ns, typeof(*ns), namespace_list);
+
 	if (head->r.eof)
 		return;
 	while (head->r.step < TOMOYO_MAX_POLICY &&
@@ -1921,6 +1965,7 @@ struct tomoyo_query {
 static int tomoyo_truncate(char *str)
 {
 	char *start = str;
+
 	while (*(unsigned char *) str > (unsigned char) ' ')
 		str++;
 	*str = '\0';
@@ -1943,6 +1988,7 @@ static void tomoyo_add_entry(struct tomoyo_domain_info *domain, char *header)
 	char *symlink = NULL;
 	char *cp = strchr(header, '\n');
 	int len;
+
 	if (!cp)
 		return;
 	cp = strchr(cp + 1, '\n');
@@ -2002,6 +2048,7 @@ int tomoyo_supervisor(struct tomoyo_request_info *r, const char *fmt, ...)
 	static unsigned int tomoyo_serial;
 	struct tomoyo_query entry = { };
 	bool quota_exceeded = false;
+
 	va_start(args, fmt);
 	len = vsnprintf((char *) &len, 1, fmt, args) + 1;
 	va_end(args);
@@ -2063,8 +2110,7 @@ int tomoyo_supervisor(struct tomoyo_request_info *r, const char *fmt, ...)
 		    (tomoyo_answer_wait, entry.answer ||
 		     !atomic_read(&tomoyo_query_observers), HZ))
 			break;
-		else
-			entry.timer++;
+		entry.timer++;
 	}
 	spin_lock(&tomoyo_query_list_lock);
 	list_del(&entry.list);
@@ -2100,6 +2146,7 @@ int tomoyo_supervisor(struct tomoyo_request_info *r, const char *fmt, ...)
 {
 	struct tomoyo_query *ptr;
 	struct tomoyo_domain_info *domain = NULL;
+
 	spin_lock(&tomoyo_query_list_lock);
 	list_for_each_entry(ptr, &tomoyo_query_list, list) {
 		if (ptr->serial != serial)
@@ -2142,15 +2189,15 @@ static void tomoyo_read_query(struct tomoyo_io_buffer *head)
 	unsigned int pos = 0;
 	size_t len = 0;
 	char *buf;
+
 	if (head->r.w_pos)
 		return;
-	if (head->read_buf) {
-		kfree(head->read_buf);
-		head->read_buf = NULL;
-	}
+	kfree(head->read_buf);
+	head->read_buf = NULL;
 	spin_lock(&tomoyo_query_list_lock);
 	list_for_each(tmp, &tomoyo_query_list) {
 		struct tomoyo_query *ptr = list_entry(tmp, typeof(*ptr), list);
+
 		if (pos++ != head->r.query_index)
 			continue;
 		len = ptr->query_len;
@@ -2168,6 +2215,7 @@ static void tomoyo_read_query(struct tomoyo_io_buffer *head)
 	spin_lock(&tomoyo_query_list_lock);
 	list_for_each(tmp, &tomoyo_query_list) {
 		struct tomoyo_query *ptr = list_entry(tmp, typeof(*ptr), list);
+
 		if (pos++ != head->r.query_index)
 			continue;
 		/*
@@ -2202,9 +2250,11 @@ static int tomoyo_write_answer(struct tomoyo_io_buffer *head)
 	struct list_head *tmp;
 	unsigned int serial;
 	unsigned int answer;
+
 	spin_lock(&tomoyo_query_list_lock);
 	list_for_each(tmp, &tomoyo_query_list) {
 		struct tomoyo_query *ptr = list_entry(tmp, typeof(*ptr), list);
+
 		ptr->timer = 0;
 	}
 	spin_unlock(&tomoyo_query_list_lock);
@@ -2213,6 +2263,7 @@ static int tomoyo_write_answer(struct tomoyo_io_buffer *head)
 	spin_lock(&tomoyo_query_list_lock);
 	list_for_each(tmp, &tomoyo_query_list) {
 		struct tomoyo_query *ptr = list_entry(tmp, typeof(*ptr), list);
+
 		if (ptr->serial != serial)
 			continue;
 		ptr->answer = answer;
@@ -2287,6 +2338,7 @@ static void tomoyo_read_stat(struct tomoyo_io_buffer *head)
 {
 	u8 i;
 	unsigned int total = 0;
+
 	if (head->r.eof)
 		return;
 	for (i = 0; i < TOMOYO_MAX_POLICY_STAT; i++) {
@@ -2295,9 +2347,9 @@ static void tomoyo_read_stat(struct tomoyo_io_buffer *head)
 				 tomoyo_stat_updated[i]);
 		if (tomoyo_stat_modified[i]) {
 			struct tomoyo_time stamp;
+
 			tomoyo_convert_time(tomoyo_stat_modified[i], &stamp);
-			tomoyo_io_printf(head, " (Last: %04u/%02u/%02u "
-					 "%02u:%02u:%02u)",
+			tomoyo_io_printf(head, " (Last: %04u/%02u/%02u %02u:%02u:%02u)",
 					 stamp.year, stamp.month, stamp.day,
 					 stamp.hour, stamp.min, stamp.sec);
 		}
@@ -2305,6 +2357,7 @@ static void tomoyo_read_stat(struct tomoyo_io_buffer *head)
 	}
 	for (i = 0; i < TOMOYO_MAX_MEMORY_STAT; i++) {
 		unsigned int used = tomoyo_memory_used[i];
+
 		total += used;
 		tomoyo_io_printf(head, "Memory used by %-22s %10u",
 				 tomoyo_memory_headers[i], used);
@@ -2329,6 +2382,7 @@ static int tomoyo_write_stat(struct tomoyo_io_buffer *head)
 {
 	char *data = head->write_buf;
 	u8 i;
+
 	if (tomoyo_str_starts(&data, "Memory used by "))
 		for (i = 0; i < TOMOYO_MAX_MEMORY_STAT; i++)
 			if (tomoyo_str_starts(&data, tomoyo_memory_headers[i]))
@@ -2457,6 +2511,7 @@ int tomoyo_open_control(const u8 type, struct file *file)
 __poll_t tomoyo_poll_control(struct file *file, poll_table *wait)
 {
 	struct tomoyo_io_buffer *head = file->private_data;
+
 	if (head->poll)
 		return head->poll(file, wait) | EPOLLOUT | EPOLLWRNORM;
 	return EPOLLIN | EPOLLRDNORM | EPOLLOUT | EPOLLWRNORM;
@@ -2472,6 +2527,7 @@ __poll_t tomoyo_poll_control(struct file *file, poll_table *wait)
 static inline void tomoyo_set_namespace_cursor(struct tomoyo_io_buffer *head)
 {
 	struct list_head *ns;
+
 	if (head->type != TOMOYO_EXCEPTIONPOLICY &&
 	    head->type != TOMOYO_PROFILE)
 		return;
@@ -2517,7 +2573,7 @@ ssize_t tomoyo_read_control(struct tomoyo_io_buffer *head, char __user *buffer,
 	int idx;
 
 	if (!head->read)
-		return -ENOSYS;
+		return -EINVAL;
 	if (mutex_lock_interruptible(&head->io_sem))
 		return -EINTR;
 	head->read_user_buf = buffer;
@@ -2557,6 +2613,7 @@ static int tomoyo_parse_policy(struct tomoyo_io_buffer *head, char *line)
 	    head->type == TOMOYO_PROFILE) {
 		if (*line == '<') {
 			char *cp = strchr(line, ' ');
+
 			if (cp) {
 				*cp++ = '\0';
 				head->w.ns = tomoyo_assign_namespace(line);
@@ -2589,8 +2646,9 @@ ssize_t tomoyo_write_control(struct tomoyo_io_buffer *head,
 	size_t avail_len = buffer_len;
 	char *cp0 = head->write_buf;
 	int idx;
+
 	if (!head->write)
-		return -ENOSYS;
+		return -EINVAL;
 	if (!access_ok(buffer, buffer_len))
 		return -EFAULT;
 	if (mutex_lock_interruptible(&head->io_sem))
@@ -2600,9 +2658,11 @@ ssize_t tomoyo_write_control(struct tomoyo_io_buffer *head,
 	/* Read a line and dispatch it to the policy handler. */
 	while (avail_len > 0) {
 		char c;
+
 		if (head->w.avail >= head->writebuf_size - 1) {
 			const int len = head->writebuf_size * 2;
 			char *cp = kzalloc(len, GFP_NOFS);
+
 			if (!cp) {
 				error = -ENOMEM;
 				break;
@@ -2701,30 +2761,27 @@ void tomoyo_check_profile(void)
 {
 	struct tomoyo_domain_info *domain;
 	const int idx = tomoyo_read_lock();
+
 	tomoyo_policy_loaded = true;
-	printk(KERN_INFO "TOMOYO: 2.5.0\n");
+	pr_info("TOMOYO: 2.5.0\n");
 	list_for_each_entry_rcu(domain, &tomoyo_domain_list, list) {
 		const u8 profile = domain->profile;
 		const struct tomoyo_policy_namespace *ns = domain->ns;
+
 		if (ns->profile_version != 20110903)
-			printk(KERN_ERR
-			       "Profile version %u is not supported.\n",
+			pr_err("Profile version %u is not supported.\n",
 			       ns->profile_version);
 		else if (!ns->profile_ptr[profile])
-			printk(KERN_ERR
-			       "Profile %u (used by '%s') is not defined.\n",
+			pr_err("Profile %u (used by '%s') is not defined.\n",
 			       profile, domain->domainname->name);
 		else
 			continue;
-		printk(KERN_ERR
-		       "Userland tools for TOMOYO 2.5 must be installed and "
-		       "policy must be initialized.\n");
-		printk(KERN_ERR "Please see http://tomoyo.sourceforge.jp/2.5/ "
-		       "for more information.\n");
+		pr_err("Userland tools for TOMOYO 2.5 must be installed and policy must be initialized.\n");
+		pr_err("Please see http://tomoyo.sourceforge.jp/2.5/ for more information.\n");
 		panic("STOP!");
 	}
 	tomoyo_read_unlock(idx);
-	printk(KERN_INFO "Mandatory Access Control activated.\n");
+	pr_info("Mandatory Access Control activated.\n");
 }
 
 /**
@@ -2743,9 +2800,11 @@ void __init tomoyo_load_builtin_policy(void)
 #include "builtin-policy.h"
 	u8 i;
 	const int idx = tomoyo_read_lock();
+
 	for (i = 0; i < 5; i++) {
 		struct tomoyo_io_buffer head = { };
 		char *start = "";
+
 		switch (i) {
 		case 0:
 			start = tomoyo_builtin_profile;
@@ -2775,6 +2834,7 @@ void __init tomoyo_load_builtin_policy(void)
 		}
 		while (1) {
 			char *end = strchr(start, '\n');
+
 			if (!end)
 				break;
 			*end = '\0';
diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index cfd075c..f2c458a 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -10,6 +10,8 @@
 #ifndef _SECURITY_TOMOYO_COMMON_H
 #define _SECURITY_TOMOYO_COMMON_H
 
+#define pr_fmt(fmt) fmt
+
 #include <linux/ctype.h>
 #include <linux/string.h>
 #include <linux/mm.h>
@@ -788,9 +790,9 @@ struct tomoyo_acl_param {
  * interfaces.
  */
 struct tomoyo_io_buffer {
-	void (*read) (struct tomoyo_io_buffer *);
-	int (*write) (struct tomoyo_io_buffer *);
-	__poll_t (*poll) (struct file *file, poll_table *wait);
+	void (*read)(struct tomoyo_io_buffer *head);
+	int (*write)(struct tomoyo_io_buffer *head);
+	__poll_t (*poll)(struct file *file, poll_table *wait);
 	/* Exclusive lock for this structure.   */
 	struct mutex io_sem;
 	char __user *read_user_buf;
@@ -1042,8 +1044,8 @@ unsigned int tomoyo_check_flags(const struct tomoyo_domain_info *domain,
 void __init tomoyo_load_builtin_policy(void);
 void __init tomoyo_mm_init(void);
 void tomoyo_check_acl(struct tomoyo_request_info *r,
-		      bool (*check_entry) (struct tomoyo_request_info *,
-					   const struct tomoyo_acl_info *));
+		      bool (*check_entry)(struct tomoyo_request_info *,
+					  const struct tomoyo_acl_info *));
 void tomoyo_check_profile(void);
 void tomoyo_convert_time(time64_t time, struct tomoyo_time *stamp);
 void tomoyo_del_condition(struct list_head *element);
@@ -1131,6 +1133,7 @@ static inline void tomoyo_read_unlock(int idx)
 static inline pid_t tomoyo_sys_getppid(void)
 {
 	pid_t pid;
+
 	rcu_read_lock();
 	pid = task_tgid_vnr(rcu_dereference(current->real_parent));
 	rcu_read_unlock();
diff --git a/security/tomoyo/condition.c b/security/tomoyo/condition.c
index 8d0e1b9..8f6d57c 100644
--- a/security/tomoyo/condition.c
+++ b/security/tomoyo/condition.c
@@ -28,9 +28,11 @@ static bool tomoyo_argv(const unsigned int index, const char *arg_ptr,
 {
 	int i;
 	struct tomoyo_path_info arg;
+
 	arg.name = arg_ptr;
 	for (i = 0; i < argc; argv++, checked++, i++) {
 		bool result;
+
 		if (index != argv->index)
 			continue;
 		*checked = 1;
@@ -62,12 +64,14 @@ static bool tomoyo_envp(const char *env_name, const char *env_value,
 	int i;
 	struct tomoyo_path_info name;
 	struct tomoyo_path_info value;
+
 	name.name = env_name;
 	tomoyo_fill_path_info(&name);
 	value.name = env_value;
 	tomoyo_fill_path_info(&value);
 	for (i = 0; i < envc; envp++, checked++, i++) {
 		bool result;
+
 		if (!tomoyo_path_matches_pattern(&name, envp->name))
 			continue;
 		*checked = 1;
@@ -113,6 +117,7 @@ static bool tomoyo_scan_bprm(struct tomoyo_execve *ee,
 	bool result = true;
 	u8 local_checked[32];
 	u8 *checked;
+
 	if (argc + envc <= sizeof(local_checked)) {
 		checked = local_checked;
 		memset(local_checked, 0, sizeof(local_checked));
@@ -131,6 +136,7 @@ static bool tomoyo_scan_bprm(struct tomoyo_execve *ee,
 			/* Read. */
 			const char *kaddr = dump->data;
 			const unsigned char c = kaddr[offset++];
+
 			if (c && arg_len < TOMOYO_EXEC_TMPSIZE - 10) {
 				if (c == '\\') {
 					arg_ptr[arg_len++] = '\\';
@@ -160,6 +166,7 @@ static bool tomoyo_scan_bprm(struct tomoyo_execve *ee,
 				argv_count--;
 			} else if (envp_count) {
 				char *cp = strchr(arg_ptr, '=');
+
 				if (cp) {
 					*cp = '\0';
 					if (!tomoyo_envp(arg_ptr, cp + 1,
@@ -182,6 +189,7 @@ static bool tomoyo_scan_bprm(struct tomoyo_execve *ee,
 out:
 	if (result) {
 		int i;
+
 		/* Check not-yet-checked entries. */
 		for (i = 0; i < argc; i++) {
 			if (checked[i])
@@ -229,6 +237,7 @@ static bool tomoyo_scan_exec_realpath(struct file *file,
 {
 	bool result;
 	struct tomoyo_path_info exe;
+
 	if (!file)
 		return false;
 	exe.name = tomoyo_realpath_from_path(&file->f_path);
@@ -250,6 +259,7 @@ static bool tomoyo_scan_exec_realpath(struct file *file,
 static const struct tomoyo_path_info *tomoyo_get_dqword(char *start)
 {
 	char *cp = start + strlen(start) - 1;
+
 	if (cp == start || *start++ != '"' || *cp != '"')
 		return NULL;
 	*cp = '\0';
@@ -270,6 +280,7 @@ static bool tomoyo_parse_name_union_quoted(struct tomoyo_acl_param *param,
 					   struct tomoyo_name_union *ptr)
 {
 	char *filename = param->data;
+
 	if (*filename == '@')
 		return tomoyo_parse_name_union(param, ptr);
 	ptr->filename = tomoyo_get_dqword(filename);
@@ -310,6 +321,7 @@ static bool tomoyo_parse_envp(char *left, char *right,
 	const struct tomoyo_path_info *name;
 	const struct tomoyo_path_info *value;
 	char *cp = left + strlen(left) - 1;
+
 	if (*cp-- != ']' || *cp != '"')
 		goto out;
 	*cp = '\0';
@@ -364,6 +376,7 @@ static inline bool tomoyo_same_condition(const struct tomoyo_condition *a,
 static u8 tomoyo_condition_type(const char *word)
 {
 	u8 i;
+
 	for (i = 0; i < TOMOYO_MAX_CONDITION_KEYWORD; i++) {
 		if (!strcmp(word, tomoyo_condition_keyword[i]))
 			break;
@@ -395,6 +408,7 @@ static u8 tomoyo_condition_type(const char *word)
 {
 	struct tomoyo_condition *ptr;
 	bool found = false;
+
 	if (mutex_lock_interruptible(&tomoyo_policy_lock)) {
 		dprintk(KERN_WARNING "%u: %s failed\n", __LINE__, __func__);
 		ptr = NULL;
@@ -442,12 +456,14 @@ static char *tomoyo_get_transit_preference(struct tomoyo_acl_param *param,
 {
 	char * const pos = param->data;
 	bool flag;
+
 	if (*pos == '<') {
 		e->transit = tomoyo_get_domainname(param);
 		goto done;
 	}
 	{
 		char *cp = strchr(pos, ' ');
+
 		if (cp)
 			*cp = '\0';
 		flag = tomoyo_correct_path(pos) || !strcmp(pos, "keep") ||
@@ -489,6 +505,7 @@ struct tomoyo_condition *tomoyo_get_condition(struct tomoyo_acl_param *param)
 		tomoyo_get_transit_preference(param, &e);
 	char * const end_of_string = start_of_string + strlen(start_of_string);
 	char *pos;
+
 rerun:
 	pos = start_of_string;
 	while (1) {
@@ -498,6 +515,7 @@ struct tomoyo_condition *tomoyo_get_condition(struct tomoyo_acl_param *param)
 		char *cp;
 		char *right_word;
 		bool is_not;
+
 		if (!*left_word)
 			break;
 		/*
@@ -622,8 +640,8 @@ struct tomoyo_condition *tomoyo_get_condition(struct tomoyo_acl_param *param)
 		}
 store_value:
 		if (!condp) {
-			dprintk(KERN_WARNING "%u: dry_run left=%u right=%u "
-				"match=%u\n", __LINE__, left, right, !is_not);
+			dprintk(KERN_WARNING "%u: dry_run left=%u right=%u match=%u\n",
+				__LINE__, left, right, !is_not);
 			continue;
 		}
 		condp->left = left;
@@ -660,6 +678,7 @@ struct tomoyo_condition *tomoyo_get_condition(struct tomoyo_acl_param *param)
 	envp = (struct tomoyo_envp *) (argv + e.argc);
 	{
 		bool flag = false;
+
 		for (pos = start_of_string; pos < end_of_string; pos++) {
 			if (*pos)
 				continue;
@@ -698,6 +717,7 @@ void tomoyo_get_attributes(struct tomoyo_obj_info *obj)
 
 	for (i = 0; i < TOMOYO_MAX_PATH_STAT; i++) {
 		struct inode *inode;
+
 		switch (i) {
 		case TOMOYO_PATH1:
 			dentry = obj->path1.dentry;
@@ -718,6 +738,7 @@ void tomoyo_get_attributes(struct tomoyo_obj_info *obj)
 		inode = d_backing_inode(dentry);
 		if (inode) {
 			struct tomoyo_mini_stat *stat = &obj->stat[i];
+
 			stat->uid  = inode->i_uid;
 			stat->gid  = inode->i_gid;
 			stat->ino  = inode->i_ino;
@@ -726,8 +747,7 @@ void tomoyo_get_attributes(struct tomoyo_obj_info *obj)
 			stat->rdev = inode->i_rdev;
 			obj->stat_valid[i] = true;
 		}
-		if (i & 1) /* i == TOMOYO_PATH1_PARENT ||
-			      i == TOMOYO_PATH2_PARENT */
+		if (i & 1) /* TOMOYO_PATH1_PARENT or TOMOYO_PATH2_PARENT */
 			dput(dentry);
 	}
 }
@@ -758,6 +778,7 @@ bool tomoyo_condition(struct tomoyo_request_info *r,
 	u16 argc;
 	u16 envc;
 	struct linux_binprm *bprm = NULL;
+
 	if (!cond)
 		return true;
 	condc = cond->condc;
@@ -780,6 +801,7 @@ bool tomoyo_condition(struct tomoyo_request_info *r,
 		const u8 right = condp->right;
 		bool is_bitop[2] = { false, false };
 		u8 j;
+
 		condp++;
 		/* Check argv[] and envp[] later. */
 		if (left == TOMOYO_ARGV_ENTRY || left == TOMOYO_ENVP_ENTRY)
@@ -787,10 +809,11 @@ bool tomoyo_condition(struct tomoyo_request_info *r,
 		/* Check string expressions. */
 		if (right == TOMOYO_NAME_UNION) {
 			const struct tomoyo_name_union *ptr = names_p++;
+			struct tomoyo_path_info *symlink;
+			struct tomoyo_execve *ee;
+			struct file *file;
+
 			switch (left) {
-				struct tomoyo_path_info *symlink;
-				struct tomoyo_execve *ee;
-				struct file *file;
 			case TOMOYO_SYMLINK_TARGET:
 				symlink = obj ? obj->symlink_target : NULL;
 				if (!symlink ||
@@ -812,6 +835,7 @@ bool tomoyo_condition(struct tomoyo_request_info *r,
 		for (j = 0; j < 2; j++) {
 			const u8 index = j ? right : left;
 			unsigned long value = 0;
+
 			switch (index) {
 			case TOMOYO_TASK_UID:
 				value = from_kuid(&init_user_ns, current_uid());
@@ -874,31 +898,31 @@ bool tomoyo_condition(struct tomoyo_request_info *r,
 				value = S_ISVTX;
 				break;
 			case TOMOYO_MODE_OWNER_READ:
-				value = S_IRUSR;
+				value = 0400;
 				break;
 			case TOMOYO_MODE_OWNER_WRITE:
-				value = S_IWUSR;
+				value = 0200;
 				break;
 			case TOMOYO_MODE_OWNER_EXECUTE:
-				value = S_IXUSR;
+				value = 0100;
 				break;
 			case TOMOYO_MODE_GROUP_READ:
-				value = S_IRGRP;
+				value = 0040;
 				break;
 			case TOMOYO_MODE_GROUP_WRITE:
-				value = S_IWGRP;
+				value = 0020;
 				break;
 			case TOMOYO_MODE_GROUP_EXECUTE:
-				value = S_IXGRP;
+				value = 0010;
 				break;
 			case TOMOYO_MODE_OTHERS_READ:
-				value = S_IROTH;
+				value = 0004;
 				break;
 			case TOMOYO_MODE_OTHERS_WRITE:
-				value = S_IWOTH;
+				value = 0002;
 				break;
 			case TOMOYO_MODE_OTHERS_EXECUTE:
-				value = S_IXOTH;
+				value = 0001;
 				break;
 			case TOMOYO_EXEC_ARGC:
 				if (!bprm)
@@ -923,6 +947,7 @@ bool tomoyo_condition(struct tomoyo_request_info *r,
 				{
 					u8 stat_index;
 					struct tomoyo_mini_stat *stat;
+
 					switch (index) {
 					case TOMOYO_PATH1_UID:
 					case TOMOYO_PATH1_GID:
@@ -1036,12 +1061,14 @@ bool tomoyo_condition(struct tomoyo_request_info *r,
 		if (left == TOMOYO_NUMBER_UNION) {
 			/* Fetch values now. */
 			const struct tomoyo_number_union *ptr = numbers_p++;
+
 			min_v[0] = ptr->values[0];
 			max_v[0] = ptr->values[1];
 		}
 		if (right == TOMOYO_NUMBER_UNION) {
 			/* Fetch values now. */
 			const struct tomoyo_number_union *ptr = numbers_p++;
+
 			if (ptr->group) {
 				if (tomoyo_number_matches_group(min_v[0],
 								max_v[0],
diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index 39abf3a..bf832b3 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -30,10 +30,10 @@
  */
 int tomoyo_update_policy(struct tomoyo_acl_head *new_entry, const int size,
 			 struct tomoyo_acl_param *param,
-			 bool (*check_duplicate) (const struct tomoyo_acl_head
-						  *,
-						  const struct tomoyo_acl_head
-						  *))
+			 bool (*check_duplicate)(const struct tomoyo_acl_head
+						 *,
+						 const struct tomoyo_acl_head
+						 *))
 {
 	int error = param->is_delete ? -ENOENT : -ENOMEM;
 	struct tomoyo_acl_head *entry;
@@ -90,13 +90,13 @@ static inline bool tomoyo_same_acl_head(const struct tomoyo_acl_info *a,
  */
 int tomoyo_update_domain(struct tomoyo_acl_info *new_entry, const int size,
 			 struct tomoyo_acl_param *param,
-			 bool (*check_duplicate) (const struct tomoyo_acl_info
-						  *,
-						  const struct tomoyo_acl_info
-						  *),
-			 bool (*merge_duplicate) (struct tomoyo_acl_info *,
-						  struct tomoyo_acl_info *,
-						  const bool))
+			 bool (*check_duplicate)(const struct tomoyo_acl_info
+						 *,
+						 const struct tomoyo_acl_info
+						 *),
+			 bool (*merge_duplicate)(struct tomoyo_acl_info *,
+						 struct tomoyo_acl_info *,
+						 const bool))
 {
 	const bool is_delete = param->is_delete;
 	int error = is_delete ? -ENOENT : -ENOMEM;
@@ -157,8 +157,8 @@ int tomoyo_update_domain(struct tomoyo_acl_info *new_entry, const int size,
  * Caller holds tomoyo_read_lock().
  */
 void tomoyo_check_acl(struct tomoyo_request_info *r,
-		      bool (*check_entry) (struct tomoyo_request_info *,
-					   const struct tomoyo_acl_info *))
+		      bool (*check_entry)(struct tomoyo_request_info *,
+					  const struct tomoyo_acl_info *))
 {
 	const struct tomoyo_domain_info *domain = r->domain;
 	struct tomoyo_acl_info *ptr;
@@ -198,6 +198,7 @@ void tomoyo_check_acl(struct tomoyo_request_info *r,
 static const char *tomoyo_last_word(const char *name)
 {
 	const char *cp = strrchr(name, ' ');
+
 	if (cp)
 		return cp + 1;
 	return name;
@@ -220,6 +221,7 @@ static bool tomoyo_same_transition_control(const struct tomoyo_acl_head *a,
 	const struct tomoyo_transition_control *p2 = container_of(b,
 								  typeof(*p2),
 								  head);
+
 	return p1->type == p2->type && p1->is_last_name == p2->is_last_name
 		&& p1->domainname == p2->domainname
 		&& p1->program == p2->program;
@@ -240,6 +242,7 @@ int tomoyo_write_transition_control(struct tomoyo_acl_param *param,
 	int error = param->is_delete ? -ENOENT : -ENOMEM;
 	char *program = param->data;
 	char *domainname = strstr(program, " from ");
+
 	if (domainname) {
 		*domainname = '\0';
 		domainname += 6;
@@ -293,6 +296,7 @@ int tomoyo_write_transition_control(struct tomoyo_acl_param *param,
  const enum tomoyo_transition_type type)
 {
 	const struct tomoyo_transition_control *ptr;
+
 	list_for_each_entry_rcu(ptr, list, head.list) {
 		if (ptr->head.is_deleted || ptr->type != type)
 			continue;
@@ -338,9 +342,11 @@ int tomoyo_write_transition_control(struct tomoyo_acl_param *param,
 {
 	const char *last_name = tomoyo_last_word(domainname->name);
 	enum tomoyo_transition_type type = TOMOYO_TRANSITION_CONTROL_NO_RESET;
+
 	while (type < TOMOYO_MAX_TRANSITION_TYPE) {
 		const struct list_head * const list =
 			&ns->policy_list[TOMOYO_ID_TRANSITION_CONTROL];
+
 		if (!tomoyo_scan_transition(list, domainname, program,
 					    last_name, type)) {
 			type++;
@@ -375,6 +381,7 @@ static bool tomoyo_same_aggregator(const struct tomoyo_acl_head *a,
 							  head);
 	const struct tomoyo_aggregator *p2 = container_of(b, typeof(*p2),
 							  head);
+
 	return p1->original_name == p2->original_name &&
 		p1->aggregated_name == p2->aggregated_name;
 }
@@ -394,6 +401,7 @@ int tomoyo_write_aggregator(struct tomoyo_acl_param *param)
 	int error = param->is_delete ? -ENOENT : -ENOMEM;
 	const char *original_name = tomoyo_read_token(param);
 	const char *aggregated_name = tomoyo_read_token(param);
+
 	if (!tomoyo_correct_word(original_name) ||
 	    !tomoyo_correct_path(aggregated_name))
 		return -EINVAL;
@@ -426,6 +434,7 @@ int tomoyo_write_aggregator(struct tomoyo_acl_param *param)
 (const char *name, const unsigned int len)
 {
 	struct tomoyo_policy_namespace *ns;
+
 	list_for_each_entry(ns, &tomoyo_namespace_list, namespace_list) {
 		if (strncmp(name, ns->name, len) ||
 		    (name[len] && name[len] != ' '))
@@ -451,6 +460,7 @@ struct tomoyo_policy_namespace *tomoyo_assign_namespace(const char *domainname)
 	struct tomoyo_policy_namespace *entry;
 	const char *cp = domainname;
 	unsigned int len = 0;
+
 	while (*cp && *cp++ != ' ')
 		len++;
 	ptr = tomoyo_find_namespace(domainname, len);
@@ -466,6 +476,7 @@ struct tomoyo_policy_namespace *tomoyo_assign_namespace(const char *domainname)
 	ptr = tomoyo_find_namespace(domainname, len);
 	if (!ptr && tomoyo_memory_ok(entry)) {
 		char *name = (char *) (entry + 1);
+
 		ptr = entry;
 		memmove(name, domainname, len);
 		name[len] = '\0';
@@ -490,6 +501,7 @@ static bool tomoyo_namespace_jump(const char *domainname)
 {
 	const char *namespace = tomoyo_current_namespace()->name;
 	const int len = strlen(namespace);
+
 	return strncmp(domainname, namespace, len) ||
 		(domainname[len] && domainname[len] != ' ');
 }
@@ -510,6 +522,7 @@ struct tomoyo_domain_info *tomoyo_assign_domain(const char *domainname,
 	struct tomoyo_domain_info e = { };
 	struct tomoyo_domain_info *entry = tomoyo_find_domain(domainname);
 	bool created = false;
+
 	if (entry) {
 		if (transit) {
 			/*
@@ -546,6 +559,7 @@ struct tomoyo_domain_info *tomoyo_assign_domain(const char *domainname,
 	 */
 	if (transit) {
 		const struct tomoyo_domain_info *domain = tomoyo_domain();
+
 		e.profile = domain->profile;
 		e.group = domain->group;
 	}
@@ -569,6 +583,7 @@ struct tomoyo_domain_info *tomoyo_assign_domain(const char *domainname,
 	if (entry && transit) {
 		if (created) {
 			struct tomoyo_request_info r;
+
 			tomoyo_init_request_info(&r, entry,
 						 TOMOYO_MAC_FILE_EXECUTE);
 			r.granted = false;
@@ -712,6 +727,7 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
 		struct tomoyo_aggregator *ptr;
 		struct list_head *list =
 			&old_domain->ns->policy_list[TOMOYO_ID_AGGREGATOR];
+
 		/* Check 'aggregator' directive. */
 		candidate = &exename;
 		list_for_each_entry_rcu(ptr, list, head.list) {
@@ -747,6 +763,7 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
 	 */
 	if (ee->transition) {
 		const char *domainname = ee->transition->name;
+
 		reject_on_transition_failure = true;
 		if (!strcmp(domainname, "keep"))
 			goto force_keep_domain;
@@ -758,6 +775,7 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
 			goto force_initialize_domain;
 		if (!strcmp(domainname, "parent")) {
 			char *cp;
+
 			strncpy(ee->tmp, old_domain->domainname->name,
 				TOMOYO_EXEC_TMPSIZE - 1);
 			cp = strrchr(ee->tmp, ' ');
@@ -822,8 +840,7 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
 	if (domain)
 		retval = 0;
 	else if (reject_on_transition_failure) {
-		printk(KERN_WARNING "ERROR: Domain '%s' not ready.\n",
-		       ee->tmp);
+		pr_warn("ERROR: Domain '%s' not ready.\n", ee->tmp);
 		retval = -ENOMEM;
 	} else if (ee->r.mode == TOMOYO_CONFIG_ENFORCING)
 		retval = -ENOMEM;
@@ -834,8 +851,7 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
 			ee->r.granted = false;
 			tomoyo_write_log(&ee->r, "%s", tomoyo_dif
 					 [TOMOYO_DIF_TRANSITION_FAILED]);
-			printk(KERN_WARNING
-			       "ERROR: Domain '%s' not defined.\n", ee->tmp);
+			pr_warn("ERROR: Domain '%s' not defined.\n", ee->tmp);
 		}
 	}
  out:
diff --git a/security/tomoyo/file.c b/security/tomoyo/file.c
index 2a374b4d..86f7d1b 100644
--- a/security/tomoyo/file.c
+++ b/security/tomoyo/file.c
@@ -214,6 +214,7 @@ static int tomoyo_audit_path_number_log(struct tomoyo_request_info *r)
 	const u8 type = r->param.path_number.operation;
 	u8 radix;
 	char buffer[64];
+
 	switch (type) {
 	case TOMOYO_TYPE_CREATE:
 	case TOMOYO_TYPE_MKDIR:
@@ -253,6 +254,7 @@ static bool tomoyo_check_path_acl(struct tomoyo_request_info *r,
 {
 	const struct tomoyo_path_acl *acl = container_of(ptr, typeof(*acl),
 							 head);
+
 	if (acl->perm & (1 << r->param.path.operation)) {
 		r->param.path.matched_path =
 			tomoyo_compare_name_union(r->param.path.filename,
@@ -275,6 +277,7 @@ static bool tomoyo_check_path_number_acl(struct tomoyo_request_info *r,
 {
 	const struct tomoyo_path_number_acl *acl =
 		container_of(ptr, typeof(*acl), head);
+
 	return (acl->perm & (1 << r->param.path_number.operation)) &&
 		tomoyo_compare_number_union(r->param.path_number.number,
 					    &acl->number) &&
@@ -295,6 +298,7 @@ static bool tomoyo_check_path2_acl(struct tomoyo_request_info *r,
 {
 	const struct tomoyo_path2_acl *acl =
 		container_of(ptr, typeof(*acl), head);
+
 	return (acl->perm & (1 << r->param.path2.operation)) &&
 		tomoyo_compare_name_union(r->param.path2.filename1, &acl->name1)
 		&& tomoyo_compare_name_union(r->param.path2.filename2,
@@ -314,6 +318,7 @@ static bool tomoyo_check_mkdev_acl(struct tomoyo_request_info *r,
 {
 	const struct tomoyo_mkdev_acl *acl =
 		container_of(ptr, typeof(*acl), head);
+
 	return (acl->perm & (1 << r->param.mkdev.operation)) &&
 		tomoyo_compare_number_union(r->param.mkdev.mode,
 					    &acl->mode) &&
@@ -338,6 +343,7 @@ static bool tomoyo_same_path_acl(const struct tomoyo_acl_info *a,
 {
 	const struct tomoyo_path_acl *p1 = container_of(a, typeof(*p1), head);
 	const struct tomoyo_path_acl *p2 = container_of(b, typeof(*p2), head);
+
 	return tomoyo_same_name_union(&p1->name, &p2->name);
 }
 
@@ -358,6 +364,7 @@ static bool tomoyo_merge_path_acl(struct tomoyo_acl_info *a,
 		->perm;
 	u16 perm = *a_perm;
 	const u16 b_perm = container_of(b, struct tomoyo_path_acl, head)->perm;
+
 	if (is_delete)
 		perm &= ~b_perm;
 	else
@@ -384,6 +391,7 @@ static int tomoyo_update_path_acl(const u16 perm,
 		.perm = perm
 	};
 	int error;
+
 	if (!tomoyo_parse_name_union(param, &e.name))
 		error = -EINVAL;
 	else
@@ -407,6 +415,7 @@ static bool tomoyo_same_mkdev_acl(const struct tomoyo_acl_info *a,
 {
 	const struct tomoyo_mkdev_acl *p1 = container_of(a, typeof(*p1), head);
 	const struct tomoyo_mkdev_acl *p2 = container_of(b, typeof(*p2), head);
+
 	return tomoyo_same_name_union(&p1->name, &p2->name) &&
 		tomoyo_same_number_union(&p1->mode, &p2->mode) &&
 		tomoyo_same_number_union(&p1->major, &p2->major) &&
@@ -431,6 +440,7 @@ static bool tomoyo_merge_mkdev_acl(struct tomoyo_acl_info *a,
 	u8 perm = *a_perm;
 	const u8 b_perm = container_of(b, struct tomoyo_mkdev_acl, head)
 		->perm;
+
 	if (is_delete)
 		perm &= ~b_perm;
 	else
@@ -457,6 +467,7 @@ static int tomoyo_update_mkdev_acl(const u8 perm,
 		.perm = perm
 	};
 	int error;
+
 	if (!tomoyo_parse_name_union(param, &e.name) ||
 	    !tomoyo_parse_number_union(param, &e.mode) ||
 	    !tomoyo_parse_number_union(param, &e.major) ||
@@ -486,6 +497,7 @@ static bool tomoyo_same_path2_acl(const struct tomoyo_acl_info *a,
 {
 	const struct tomoyo_path2_acl *p1 = container_of(a, typeof(*p1), head);
 	const struct tomoyo_path2_acl *p2 = container_of(b, typeof(*p2), head);
+
 	return tomoyo_same_name_union(&p1->name1, &p2->name1) &&
 		tomoyo_same_name_union(&p1->name2, &p2->name2);
 }
@@ -507,6 +519,7 @@ static bool tomoyo_merge_path2_acl(struct tomoyo_acl_info *a,
 		->perm;
 	u8 perm = *a_perm;
 	const u8 b_perm = container_of(b, struct tomoyo_path2_acl, head)->perm;
+
 	if (is_delete)
 		perm &= ~b_perm;
 	else
@@ -533,6 +546,7 @@ static int tomoyo_update_path2_acl(const u8 perm,
 		.perm = perm
 	};
 	int error;
+
 	if (!tomoyo_parse_name_union(param, &e.name1) ||
 	    !tomoyo_parse_name_union(param, &e.name2))
 		error = -EINVAL;
@@ -621,6 +635,7 @@ static bool tomoyo_same_path_number_acl(const struct tomoyo_acl_info *a,
 							       head);
 	const struct tomoyo_path_number_acl *p2 = container_of(b, typeof(*p2),
 							       head);
+
 	return tomoyo_same_name_union(&p1->name, &p2->name) &&
 		tomoyo_same_number_union(&p1->number, &p2->number);
 }
@@ -643,6 +658,7 @@ static bool tomoyo_merge_path_number_acl(struct tomoyo_acl_info *a,
 	u8 perm = *a_perm;
 	const u8 b_perm = container_of(b, struct tomoyo_path_number_acl, head)
 		->perm;
+
 	if (is_delete)
 		perm &= ~b_perm;
 	else
@@ -667,6 +683,7 @@ static int tomoyo_update_path_number_acl(const u8 perm,
 		.perm = perm
 	};
 	int error;
+
 	if (!tomoyo_parse_name_union(param, &e.name) ||
 	    !tomoyo_parse_number_union(param, &e.number))
 		error = -EINVAL;
@@ -947,6 +964,7 @@ static bool tomoyo_same_mount_acl(const struct tomoyo_acl_info *a,
 {
 	const struct tomoyo_mount_acl *p1 = container_of(a, typeof(*p1), head);
 	const struct tomoyo_mount_acl *p2 = container_of(b, typeof(*p2), head);
+
 	return tomoyo_same_name_union(&p1->dev_name, &p2->dev_name) &&
 		tomoyo_same_name_union(&p1->dir_name, &p2->dir_name) &&
 		tomoyo_same_name_union(&p1->fs_type, &p2->fs_type) &&
@@ -966,6 +984,7 @@ static int tomoyo_update_mount_acl(struct tomoyo_acl_param *param)
 {
 	struct tomoyo_mount_acl e = { .head.type = TOMOYO_TYPE_MOUNT_ACL };
 	int error;
+
 	if (!tomoyo_parse_name_union(param, &e.dev_name) ||
 	    !tomoyo_parse_name_union(param, &e.dir_name) ||
 	    !tomoyo_parse_name_union(param, &e.fs_type) ||
@@ -995,6 +1014,7 @@ int tomoyo_write_file(struct tomoyo_acl_param *param)
 	u16 perm = 0;
 	u8 type;
 	const char *operation = tomoyo_read_token(param);
+
 	for (type = 0; type < TOMOYO_MAX_PATH_OPERATION; type++)
 		if (tomoyo_permstr(operation, tomoyo_path_keyword[type]))
 			perm |= 1 << type;
diff --git a/security/tomoyo/gc.c b/security/tomoyo/gc.c
index e22bea8..9537832 100644
--- a/security/tomoyo/gc.c
+++ b/security/tomoyo/gc.c
@@ -77,11 +77,13 @@ static bool tomoyo_name_used_by_io_buffer(const char *string)
 	spin_lock(&tomoyo_io_buffer_list_lock);
 	list_for_each_entry(head, &tomoyo_io_buffer_list, list) {
 		int i;
+
 		head->users++;
 		spin_unlock(&tomoyo_io_buffer_list_lock);
 		mutex_lock(&head->io_sem);
 		for (i = 0; i < TOMOYO_MAX_IO_READ_QUEUE; i++) {
 			const char *w = head->r.w[i];
+
 			if (w < string || w > string + size)
 				continue;
 			in_use = true;
@@ -108,6 +110,7 @@ static inline void tomoyo_del_transition_control(struct list_head *element)
 {
 	struct tomoyo_transition_control *ptr =
 		container_of(element, typeof(*ptr), head.list);
+
 	tomoyo_put_name(ptr->domainname);
 	tomoyo_put_name(ptr->program);
 }
@@ -123,6 +126,7 @@ static inline void tomoyo_del_aggregator(struct list_head *element)
 {
 	struct tomoyo_aggregator *ptr =
 		container_of(element, typeof(*ptr), head.list);
+
 	tomoyo_put_name(ptr->original_name);
 	tomoyo_put_name(ptr->aggregated_name);
 }
@@ -138,6 +142,7 @@ static inline void tomoyo_del_manager(struct list_head *element)
 {
 	struct tomoyo_manager *ptr =
 		container_of(element, typeof(*ptr), head.list);
+
 	tomoyo_put_name(ptr->manager);
 }
 
@@ -152,6 +157,7 @@ static void tomoyo_del_acl(struct list_head *element)
 {
 	struct tomoyo_acl_info *acl =
 		container_of(element, typeof(*acl), list);
+
 	tomoyo_put_condition(acl->cond);
 	switch (acl->type) {
 	case TOMOYO_TYPE_PATH_ACL:
@@ -226,6 +232,7 @@ static void tomoyo_del_acl(struct list_head *element)
 		{
 			struct tomoyo_task_acl *entry =
 				container_of(acl, typeof(*entry), head);
+
 			tomoyo_put_name(entry->domainname);
 		}
 		break;
@@ -247,6 +254,7 @@ static inline void tomoyo_del_domain(struct list_head *element)
 		container_of(element, typeof(*domain), list);
 	struct tomoyo_acl_info *acl;
 	struct tomoyo_acl_info *tmp;
+
 	/*
 	 * Since this domain is referenced from neither
 	 * "struct tomoyo_io_buffer" nor "struct cred"->security, we can delete
@@ -286,6 +294,7 @@ void tomoyo_del_condition(struct list_head *element)
 		= (const struct tomoyo_argv *) (names_p + names_count);
 	const struct tomoyo_envp *envp
 		= (const struct tomoyo_envp *) (argv + argc);
+
 	for (i = 0; i < numbers_count; i++)
 		tomoyo_put_number_union(numbers_p++);
 	for (i = 0; i < names_count; i++)
@@ -321,6 +330,7 @@ static inline void tomoyo_del_path_group(struct list_head *element)
 {
 	struct tomoyo_path_group *member =
 		container_of(element, typeof(*member), head.list);
+
 	tomoyo_put_name(member->member_name);
 }
 
@@ -335,6 +345,7 @@ static inline void tomoyo_del_group(struct list_head *element)
 {
 	struct tomoyo_group *group =
 		container_of(element, typeof(*group), head.list);
+
 	tomoyo_put_name(group->group_name);
 }
 
@@ -476,6 +487,7 @@ static void tomoyo_collect_member(const enum tomoyo_policy_id id,
 {
 	struct tomoyo_acl_head *member;
 	struct tomoyo_acl_head *tmp;
+
 	list_for_each_entry_safe(member, tmp, member_list, list) {
 		if (!member->is_deleted)
 			continue;
@@ -495,6 +507,7 @@ static void tomoyo_collect_acl(struct list_head *list)
 {
 	struct tomoyo_acl_info *acl;
 	struct tomoyo_acl_info *tmp;
+
 	list_for_each_entry_safe(acl, tmp, list, list) {
 		if (!acl->is_deleted)
 			continue;
@@ -513,10 +526,12 @@ static void tomoyo_collect_entry(void)
 	int i;
 	enum tomoyo_policy_id id;
 	struct tomoyo_policy_namespace *ns;
+
 	mutex_lock(&tomoyo_policy_lock);
 	{
 		struct tomoyo_domain_info *domain;
 		struct tomoyo_domain_info *tmp;
+
 		list_for_each_entry_safe(domain, tmp, &tomoyo_domain_list,
 					 list) {
 			tomoyo_collect_acl(&domain->acl_info_list);
@@ -534,6 +549,7 @@ static void tomoyo_collect_entry(void)
 	{
 		struct tomoyo_shared_acl_head *ptr;
 		struct tomoyo_shared_acl_head *tmp;
+
 		list_for_each_entry_safe(ptr, tmp, &tomoyo_condition_list,
 					 list) {
 			if (atomic_read(&ptr->users) > 0)
@@ -547,6 +563,7 @@ static void tomoyo_collect_entry(void)
 			struct list_head *list = &ns->group_list[i];
 			struct tomoyo_group *group;
 			struct tomoyo_group *tmp;
+
 			switch (i) {
 			case 0:
 				id = TOMOYO_ID_PATH_GROUP;
@@ -574,6 +591,7 @@ static void tomoyo_collect_entry(void)
 		struct list_head *list = &tomoyo_name_list[i];
 		struct tomoyo_shared_acl_head *ptr;
 		struct tomoyo_shared_acl_head *tmp;
+
 		list_for_each_entry_safe(ptr, tmp, list, list) {
 			if (atomic_read(&ptr->users) > 0)
 				continue;
@@ -595,6 +613,7 @@ static int tomoyo_gc_thread(void *unused)
 {
 	/* Garbage collector thread is exclusive. */
 	static DEFINE_MUTEX(tomoyo_gc_mutex);
+
 	if (!mutex_trylock(&tomoyo_gc_mutex))
 		goto out;
 	tomoyo_collect_entry();
diff --git a/security/tomoyo/group.c b/security/tomoyo/group.c
index 21b0cc3..a37c7dc 100644
--- a/security/tomoyo/group.c
+++ b/security/tomoyo/group.c
@@ -75,11 +75,13 @@ int tomoyo_write_group(struct tomoyo_acl_param *param, const u8 type)
 {
 	struct tomoyo_group *group = tomoyo_get_group(param, type);
 	int error = -EINVAL;
+
 	if (!group)
 		return -ENOMEM;
 	param->list = &group->member_list;
 	if (type == TOMOYO_PATH_GROUP) {
 		struct tomoyo_path_group e = { };
+
 		e.member_name = tomoyo_get_name(tomoyo_read_token(param));
 		if (!e.member_name) {
 			error = -ENOMEM;
@@ -90,6 +92,7 @@ int tomoyo_write_group(struct tomoyo_acl_param *param, const u8 type)
 		tomoyo_put_name(e.member_name);
 	} else if (type == TOMOYO_NUMBER_GROUP) {
 		struct tomoyo_number_group e = { };
+
 		if (param->data[0] == '@' ||
 		    !tomoyo_parse_number_union(param, &e.number))
 			goto out;
@@ -129,6 +132,7 @@ int tomoyo_write_group(struct tomoyo_acl_param *param, const u8 type)
 			  const struct tomoyo_group *group)
 {
 	struct tomoyo_path_group *member;
+
 	list_for_each_entry_rcu(member, &group->member_list, head.list) {
 		if (member->head.is_deleted)
 			continue;
@@ -156,6 +160,7 @@ bool tomoyo_number_matches_group(const unsigned long min,
 {
 	struct tomoyo_number_group *member;
 	bool matched = false;
+
 	list_for_each_entry_rcu(member, &group->member_list, head.list) {
 		if (member->head.is_deleted)
 			continue;
diff --git a/security/tomoyo/load_policy.c b/security/tomoyo/load_policy.c
index 81b9516..3445ae6 100644
--- a/security/tomoyo/load_policy.c
+++ b/security/tomoyo/load_policy.c
@@ -37,11 +37,12 @@ static int __init tomoyo_loader_setup(char *str)
 static bool tomoyo_policy_loader_exists(void)
 {
 	struct path path;
+
 	if (!tomoyo_loader)
 		tomoyo_loader = CONFIG_SECURITY_TOMOYO_POLICY_LOADER;
 	if (kern_path(tomoyo_loader, LOOKUP_FOLLOW, &path)) {
-		printk(KERN_INFO "Not activating Mandatory Access Control "
-		       "as %s does not exist.\n", tomoyo_loader);
+		pr_info("Not activating Mandatory Access Control as %s does not exist.\n",
+			tomoyo_loader);
 		return false;
 	}
 	path_put(&path);
@@ -96,8 +97,7 @@ void tomoyo_load_policy(const char *filename)
 	if (!tomoyo_policy_loader_exists())
 		return;
 	done = true;
-	printk(KERN_INFO "Calling %s to load policy. Please wait.\n",
-	       tomoyo_loader);
+	pr_info("Calling %s to load policy. Please wait.\n", tomoyo_loader);
 	argv[0] = (char *) tomoyo_loader;
 	argv[1] = NULL;
 	envp[0] = "HOME=/";
diff --git a/security/tomoyo/memory.c b/security/tomoyo/memory.c
index 12477e0..2e7fcfa 100644
--- a/security/tomoyo/memory.c
+++ b/security/tomoyo/memory.c
@@ -19,9 +19,9 @@ void tomoyo_warn_oom(const char *function)
 	/* Reduce error messages. */
 	static pid_t tomoyo_last_pid;
 	const pid_t pid = current->pid;
+
 	if (tomoyo_last_pid != pid) {
-		printk(KERN_WARNING "ERROR: Out of memory at %s.\n",
-		       function);
+		pr_warn("ERROR: Out of memory at %s.\n", function);
 		tomoyo_last_pid = pid;
 	}
 	if (!tomoyo_policy_loaded)
@@ -48,6 +48,7 @@ bool tomoyo_memory_ok(void *ptr)
 {
 	if (ptr) {
 		const size_t s = ksize(ptr);
+
 		tomoyo_memory_used[TOMOYO_MEMORY_POLICY] += s;
 		if (!tomoyo_memory_quota[TOMOYO_MEMORY_POLICY] ||
 		    tomoyo_memory_used[TOMOYO_MEMORY_POLICY] <=
@@ -73,6 +74,7 @@ bool tomoyo_memory_ok(void *ptr)
 void *tomoyo_commit_ok(void *data, const unsigned int size)
 {
 	void *ptr = kzalloc(size, GFP_NOFS);
+
 	if (tomoyo_memory_ok(ptr)) {
 		memmove(ptr, data, size);
 		memset(data, 0, size);
@@ -98,6 +100,7 @@ struct tomoyo_group *tomoyo_get_group(struct tomoyo_acl_param *param,
 	struct list_head *list;
 	const char *group_name = tomoyo_read_token(param);
 	bool found = false;
+
 	if (!tomoyo_correct_word(group_name) || idx >= TOMOYO_MAX_GROUP)
 		return NULL;
 	e.group_name = tomoyo_get_name(group_name);
@@ -116,6 +119,7 @@ struct tomoyo_group *tomoyo_get_group(struct tomoyo_acl_param *param,
 	}
 	if (!found) {
 		struct tomoyo_group *entry = tomoyo_commit_ok(&e, sizeof(e));
+
 		if (entry) {
 			INIT_LIST_HEAD(&entry->member_list);
 			atomic_set(&entry->head.users, 1);
@@ -191,6 +195,7 @@ const struct tomoyo_path_info *tomoyo_get_name(const char *name)
 void __init tomoyo_mm_init(void)
 {
 	int idx;
+
 	for (idx = 0; idx < TOMOYO_MAX_HASH; idx++)
 		INIT_LIST_HEAD(&tomoyo_name_list[idx]);
 	tomoyo_kernel_namespace.name = "<kernel>";
diff --git a/security/tomoyo/mount.c b/security/tomoyo/mount.c
index 7dc7f59..2755971 100644
--- a/security/tomoyo/mount.c
+++ b/security/tomoyo/mount.c
@@ -49,6 +49,7 @@ static bool tomoyo_check_mount_acl(struct tomoyo_request_info *r,
 {
 	const struct tomoyo_mount_acl *acl =
 		container_of(ptr, typeof(*acl), head);
+
 	return tomoyo_compare_number_union(r->param.mount.flags,
 					   &acl->flags) &&
 		tomoyo_compare_name_union(r->param.mount.type,
@@ -89,6 +90,7 @@ static int tomoyo_mount_acl(struct tomoyo_request_info *r,
 	struct tomoyo_path_info rdir;
 	int need_dev = 0;
 	int error = -ENOMEM;
+
 	r->obj = &obj;
 
 	/* Get fstype. */
diff --git a/security/tomoyo/realpath.c b/security/tomoyo/realpath.c
index 6ff8c21..85e6e31 100644
--- a/security/tomoyo/realpath.c
+++ b/security/tomoyo/realpath.c
@@ -94,11 +94,13 @@ static char *tomoyo_get_absolute_path(const struct path *path, char * const buff
 				      const int buflen)
 {
 	char *pos = ERR_PTR(-ENOMEM);
+
 	if (buflen >= 256) {
 		/* go to whatever namespace root we are under */
 		pos = d_absolute_path(path, buffer, buflen - 1);
 		if (!IS_ERR(pos) && *pos == '/' && pos[1]) {
 			struct inode *inode = d_backing_inode(path->dentry);
+
 			if (inode && S_ISDIR(inode->i_mode)) {
 				buffer[buflen - 2] = '/';
 				buffer[buflen - 1] = '\0';
@@ -123,10 +125,12 @@ static char *tomoyo_get_dentry_path(struct dentry *dentry, char * const buffer,
 				    const int buflen)
 {
 	char *pos = ERR_PTR(-ENOMEM);
+
 	if (buflen >= 256) {
 		pos = dentry_path_raw(dentry, buffer, buflen - 1);
 		if (!IS_ERR(pos) && *pos == '/' && pos[1]) {
 			struct inode *inode = d_backing_inode(dentry);
+
 			if (inode && S_ISDIR(inode->i_mode)) {
 				buffer[buflen - 2] = '/';
 				buffer[buflen - 1] = '\0';
@@ -150,12 +154,14 @@ static char *tomoyo_get_local_path(struct dentry *dentry, char * const buffer,
 {
 	struct super_block *sb = dentry->d_sb;
 	char *pos = tomoyo_get_dentry_path(dentry, buffer, buflen);
+
 	if (IS_ERR(pos))
 		return pos;
 	/* Convert from $PID to self if $PID is current thread. */
 	if (sb->s_magic == PROC_SUPER_MAGIC && *pos == '/') {
 		char *ep;
 		const pid_t pid = (pid_t) simple_strtoul(pos + 1, &ep, 10);
+
 		if (*ep == '/' && pid && pid ==
 		    task_tgid_nr_ns(current, sb->s_fs_info)) {
 			pos = ep - 5;
@@ -170,6 +176,7 @@ static char *tomoyo_get_local_path(struct dentry *dentry, char * const buffer,
 		goto prepend_filesystem_name;
 	{
 		struct inode *inode = d_backing_inode(sb->s_root);
+
 		/*
 		 * Use filesystem name if filesystem does not support rename()
 		 * operation.
@@ -182,6 +189,7 @@ static char *tomoyo_get_local_path(struct dentry *dentry, char * const buffer,
 		char name[64];
 		int name_len;
 		const dev_t dev = sb->s_dev;
+
 		name[sizeof(name) - 1] = '\0';
 		snprintf(name, sizeof(name) - 1, "dev(%u,%u):", MAJOR(dev),
 			 MINOR(dev));
@@ -197,6 +205,7 @@ static char *tomoyo_get_local_path(struct dentry *dentry, char * const buffer,
 	{
 		const char *name = sb->s_type->name;
 		const int name_len = strlen(name);
+
 		pos -= name_len + 1;
 		if (pos < buffer)
 			goto out;
@@ -223,10 +232,10 @@ static char *tomoyo_get_socket_name(const struct path *path, char * const buffer
 	struct inode *inode = d_backing_inode(path->dentry);
 	struct socket *sock = inode ? SOCKET_I(inode) : NULL;
 	struct sock *sk = sock ? sock->sk : NULL;
+
 	if (sk) {
-		snprintf(buffer, buflen, "socket:[family=%u:type=%u:"
-			 "protocol=%u]", sk->sk_family, sk->sk_type,
-			 sk->sk_protocol);
+		snprintf(buffer, buflen, "socket:[family=%u:type=%u:protocol=%u]",
+			 sk->sk_family, sk->sk_type, sk->sk_protocol);
 	} else {
 		snprintf(buffer, buflen, "socket:[unknown]");
 	}
@@ -255,12 +264,14 @@ char *tomoyo_realpath_from_path(const struct path *path)
 	unsigned int buf_len = PAGE_SIZE / 2;
 	struct dentry *dentry = path->dentry;
 	struct super_block *sb;
+
 	if (!dentry)
 		return NULL;
 	sb = dentry->d_sb;
 	while (1) {
 		char *pos;
 		struct inode *inode;
+
 		buf_len <<= 1;
 		kfree(buf);
 		buf = kmalloc(buf_len, GFP_NOFS);
@@ -323,6 +334,7 @@ char *tomoyo_realpath_nofollow(const char *pathname)
 
 	if (pathname && kern_path(pathname, 0, &path) == 0) {
 		char *buf = tomoyo_realpath_from_path(&path);
+
 		path_put(&path);
 		return buf;
 	}
diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs_if.c
index 338872f..546281c 100644
--- a/security/tomoyo/securityfs_if.c
+++ b/security/tomoyo/securityfs_if.c
@@ -21,6 +21,7 @@ static bool tomoyo_check_task_acl(struct tomoyo_request_info *r,
 {
 	const struct tomoyo_task_acl *acl = container_of(ptr, typeof(*acl),
 							 head);
+
 	return !tomoyo_pathcmp(r->param.task.domainname, acl->domainname);
 }
 
@@ -42,6 +43,7 @@ static ssize_t tomoyo_write_self(struct file *file, const char __user *buf,
 {
 	char *data;
 	int error;
+
 	if (!count || count >= TOMOYO_EXEC_TMPSIZE - 10)
 		return -ENOMEM;
 	data = memdup_user_nul(buf, count);
@@ -52,6 +54,7 @@ static ssize_t tomoyo_write_self(struct file *file, const char __user *buf,
 		const int idx = tomoyo_read_lock();
 		struct tomoyo_path_info name;
 		struct tomoyo_request_info r;
+
 		name.name = data;
 		tomoyo_fill_path_info(&name);
 		/* Check "task manual_domain_transition" permission. */
@@ -100,6 +103,7 @@ static ssize_t tomoyo_read_self(struct file *file, char __user *buf,
 	const char *domain = tomoyo_domain()->domainname->name;
 	loff_t len = strlen(domain);
 	loff_t pos = *ppos;
+
 	if (pos >= len || !count)
 		return 0;
 	len -= pos;
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index c2ab657..716c92e 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -105,6 +105,7 @@ static int tomoyo_bprm_check_security(struct linux_binprm *bprm)
 	if (!s->old_domain_info) {
 		const int idx = tomoyo_read_lock();
 		const int err = tomoyo_find_next_domain(bprm);
+
 		tomoyo_read_unlock(idx);
 		return err;
 	}
@@ -151,6 +152,7 @@ static int tomoyo_path_truncate(const struct path *path)
 static int tomoyo_path_unlink(const struct path *parent, struct dentry *dentry)
 {
 	struct path path = { .mnt = parent->mnt, .dentry = dentry };
+
 	return tomoyo_path_perm(TOMOYO_TYPE_UNLINK, &path, NULL);
 }
 
@@ -167,6 +169,7 @@ static int tomoyo_path_mkdir(const struct path *parent, struct dentry *dentry,
 			     umode_t mode)
 {
 	struct path path = { .mnt = parent->mnt, .dentry = dentry };
+
 	return tomoyo_path_number_perm(TOMOYO_TYPE_MKDIR, &path,
 				       mode & S_IALLUGO);
 }
@@ -182,6 +185,7 @@ static int tomoyo_path_mkdir(const struct path *parent, struct dentry *dentry,
 static int tomoyo_path_rmdir(const struct path *parent, struct dentry *dentry)
 {
 	struct path path = { .mnt = parent->mnt, .dentry = dentry };
+
 	return tomoyo_path_perm(TOMOYO_TYPE_RMDIR, &path, NULL);
 }
 
@@ -198,6 +202,7 @@ static int tomoyo_path_symlink(const struct path *parent, struct dentry *dentry,
 			       const char *old_name)
 {
 	struct path path = { .mnt = parent->mnt, .dentry = dentry };
+
 	return tomoyo_path_perm(TOMOYO_TYPE_SYMLINK, &path, old_name);
 }
 
@@ -255,6 +260,7 @@ static int tomoyo_path_link(struct dentry *old_dentry, const struct path *new_di
 {
 	struct path path1 = { .mnt = new_dir->mnt, .dentry = old_dentry };
 	struct path path2 = { .mnt = new_dir->mnt, .dentry = new_dentry };
+
 	return tomoyo_path2_perm(TOMOYO_TYPE_LINK, &path1, &path2);
 }
 
@@ -275,6 +281,7 @@ static int tomoyo_path_rename(const struct path *old_parent,
 {
 	struct path path1 = { .mnt = old_parent->mnt, .dentry = old_dentry };
 	struct path path2 = { .mnt = new_parent->mnt, .dentry = new_dentry };
+
 	return tomoyo_path2_perm(TOMOYO_TYPE_RENAME, &path1, &path2);
 }
 
@@ -306,11 +313,11 @@ static int tomoyo_file_fcntl(struct file *file, unsigned int cmd,
  */
 static int tomoyo_file_open(struct file *f)
 {
-	int flags = f->f_flags;
 	/* Don't check read permission here if called from do_execve(). */
 	if (current->in_execve)
 		return 0;
-	return tomoyo_check_open_permission(tomoyo_domain(), &f->f_path, flags);
+	return tomoyo_check_open_permission(tomoyo_domain(), &f->f_path,
+					    f->f_flags);
 }
 
 /**
@@ -354,6 +361,7 @@ static int tomoyo_path_chmod(const struct path *path, umode_t mode)
 static int tomoyo_path_chown(const struct path *path, kuid_t uid, kgid_t gid)
 {
 	int error = 0;
+
 	if (uid_valid(uid))
 		error = tomoyo_path_number_perm(TOMOYO_TYPE_CHOWN, path,
 						from_kuid(&init_user_ns, uid));
@@ -403,6 +411,7 @@ static int tomoyo_sb_mount(const char *dev_name, const struct path *path,
 static int tomoyo_sb_umount(struct vfsmount *mnt, int flags)
 {
 	struct path path = { .mnt = mnt, .dentry = mnt->mnt_root };
+
 	return tomoyo_path_perm(TOMOYO_TYPE_UMOUNT, &path, NULL);
 }
 
@@ -573,7 +582,7 @@ static int __init tomoyo_init(void)
 
 	/* register ourselves with the security framework */
 	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
-	printk(KERN_INFO "TOMOYO Linux initialized\n");
+	pr_info("TOMOYO Linux initialized\n");
 	s->domain_info = &tomoyo_kernel_domain;
 	atomic_inc(&tomoyo_kernel_domain.users);
 	s->old_domain_info = NULL;
diff --git a/security/tomoyo/util.c b/security/tomoyo/util.c
index badffc8..0517cbd 100644
--- a/security/tomoyo/util.c
+++ b/security/tomoyo/util.c
@@ -91,6 +91,7 @@
 void tomoyo_convert_time(time64_t time64, struct tomoyo_time *stamp)
 {
 	struct tm tm;
+
 	time64_to_tm(time64, 0, &tm);
 	stamp->sec = tm.tm_sec;
 	stamp->min = tm.tm_min;
@@ -113,6 +114,7 @@ void tomoyo_convert_time(time64_t time64, struct tomoyo_time *stamp)
 bool tomoyo_permstr(const char *string, const char *keyword)
 {
 	const char *cp = strstr(string, keyword);
+
 	if (cp)
 		return cp == string || *(cp - 1) == '/';
 	return false;
@@ -132,6 +134,7 @@ char *tomoyo_read_token(struct tomoyo_acl_param *param)
 {
 	char *pos = param->data;
 	char *del = strchr(pos, ' ');
+
 	if (del)
 		*del++ = '\0';
 	else
@@ -152,6 +155,7 @@ char *tomoyo_read_token(struct tomoyo_acl_param *param)
 {
 	char *start = param->data;
 	char *pos = start;
+
 	while (*pos) {
 		if (*pos++ != ' ' || *pos++ == '/')
 			continue;
@@ -181,8 +185,10 @@ u8 tomoyo_parse_ulong(unsigned long *result, char **str)
 	const char *cp = *str;
 	char *ep;
 	int base = 10;
+
 	if (*cp == '0') {
 		char c = *(cp + 1);
+
 		if (c == 'x' || c == 'X') {
 			base = 16;
 			cp += 2;
@@ -240,6 +246,7 @@ bool tomoyo_parse_name_union(struct tomoyo_acl_param *param,
 			     struct tomoyo_name_union *ptr)
 {
 	char *filename;
+
 	if (param->data[0] == '@') {
 		param->data++;
 		ptr->group = tomoyo_get_group(param, TOMOYO_PATH_GROUP);
@@ -266,6 +273,7 @@ bool tomoyo_parse_number_union(struct tomoyo_acl_param *param,
 	char *data;
 	u8 type;
 	unsigned long v;
+
 	memset(ptr, 0, sizeof(*ptr));
 	if (param->data[0] == '@') {
 		param->data++;
@@ -429,6 +437,7 @@ static bool tomoyo_correct_word2(const char *string, size_t len)
 	unsigned char c;
 	unsigned char d;
 	unsigned char e;
+
 	if (!len)
 		goto out;
 	while (len--) {
@@ -533,6 +542,7 @@ bool tomoyo_correct_domain(const unsigned char *domainname)
 		return true;
 	while (1) {
 		const unsigned char *cp = strchr(domainname, ' ');
+
 		if (!cp)
 			break;
 		if (*domainname != '/' ||
@@ -554,6 +564,7 @@ bool tomoyo_domain_def(const unsigned char *buffer)
 {
 	const unsigned char *cp;
 	int len;
+
 	if (*buffer != '<')
 		return false;
 	cp = strchr(buffer, ' ');
@@ -668,6 +679,9 @@ static bool tomoyo_file_matches_pattern2(const char *filename,
 {
 	while (filename < filename_end && pattern < pattern_end) {
 		char c;
+		int i;
+		int j;
+
 		if (*pattern != '\\') {
 			if (*filename++ != *pattern++)
 				return false;
@@ -676,8 +690,6 @@ static bool tomoyo_file_matches_pattern2(const char *filename,
 		c = *filename;
 		pattern++;
 		switch (*pattern) {
-			int i;
-			int j;
 		case '?':
 			if (c == '/') {
 				return false;
@@ -985,6 +997,7 @@ int tomoyo_init_request_info(struct tomoyo_request_info *r,
 			     struct tomoyo_domain_info *domain, const u8 index)
 {
 	u8 profile;
+
 	memset(r, 0, sizeof(*r));
 	if (!domain)
 		domain = tomoyo_domain();
@@ -1018,6 +1031,7 @@ bool tomoyo_domain_quota_is_ok(struct tomoyo_request_info *r)
 	list_for_each_entry_rcu(ptr, &domain->acl_info_list, list) {
 		u16 perm;
 		u8 i;
+
 		if (ptr->is_deleted)
 			continue;
 		switch (ptr->type) {
@@ -1062,9 +1076,8 @@ bool tomoyo_domain_quota_is_ok(struct tomoyo_request_info *r)
 		domain->flags[TOMOYO_DIF_QUOTA_WARNED] = true;
 		/* r->granted = false; */
 		tomoyo_write_log(r, "%s", tomoyo_dif[TOMOYO_DIF_QUOTA_WARNED]);
-		printk(KERN_WARNING "WARNING: "
-		       "Domain '%s' has too many ACLs to hold. "
-		       "Stopped learning mode.\n", domain->domainname->name);
+		pr_warn("WARNING: Domain '%s' has too many ACLs to hold. Stopped learning mode.\n",
+			domain->domainname->name);
 	}
 	return false;
 }
-- 
1.8.3.1

