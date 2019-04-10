Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041F6C10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 16:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFEA20830
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 16:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nE3ywD1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfDJQ4J (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:56:09 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38599 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfDJQ4J (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 12:56:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id f36so1791655plb.5
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 09:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ESBUryCXNaGTygEmKIPq3edWvpEpB7IBNOCbsnV9Dhw=;
        b=nE3ywD1L77yIvYrfKvJS8BdPf8AzWuwNCZVfyzkuql3hKk+YXfcFWVcJCTJJg7Lpsv
         Ws6GC0GfqTpNPIdXme93NlA3WHOc55V3chcnWezx0lMx7xMce01X6MoUB+8TepTMNjdi
         1FRKXfsKxlHwObRc0ee41QLJBNJjXzh2kM09Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ESBUryCXNaGTygEmKIPq3edWvpEpB7IBNOCbsnV9Dhw=;
        b=tntxH4jk248Waav+78myTopWMydooPcIiSWGgsDZTLB+9LMKySF1v26L43E1nBjQGZ
         HSrpGWYvLteUsVNJ6qCCfLQbRlBNDO8fIjl+3mppoMgjkDldDcU9W+7NuI+ejNfZ9MNI
         S6+AQpKpcHJUaGUaOySY8LftjRrS7iGmL++3PvdMPAI8nGANfb8Gu39Hue4Eyex8pfW+
         aqh22HDcW9/5OUC/Xqv93nvrtiY4O5YY9qzZmyhpSOD3xB5EysNWK07AKBoi8W9+Kc8z
         BHftyk+a8w/w47YGMZhJvVNL0Ucec9Og5b3mKfeuQgHAqPw+5FgQGmM/14hTbtkuOl2q
         xg9g==
X-Gm-Message-State: APjAAAUPKVyU8t6AmcQN4SKCJ/Wqhoyzi2Qi3WnXrCBm416xkqUbNfRC
        OuA/hgExOxNd/Pn6Uq3cZzsa3HIixbFtXQ==
X-Google-Smtp-Source: APXvYqyQnb3LVfKRcg6+yL7dgcnmSsYEsx8UWiWFkITG6CP+Cv8xdY3BlpVBrcjgn6H5Yka10FSMcg==
X-Received: by 2002:a17:902:768c:: with SMTP id m12mr44492175pll.160.1554915368157;
        Wed, 10 Apr 2019 09:56:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9e10:971c:f11c:a814])
        by smtp.gmail.com with ESMTPSA id i10sm72165063pfj.7.2019.04.10.09.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:56:07 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
X-Google-Original-From: Micah Morton
To:     jmorris@namei.org, keescook@chromium.org, casey@schaufler-ca.com,
        linux-security-module@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, Micah Morton <mortonm@chromium.org>
Subject: [PATCH 07/10] LSM: SafeSetID: rewrite userspace API to atomic updates
Date:   Wed, 10 Apr 2019 09:56:05 -0700
Message-Id: <20190410165605.211749-1-mortonm@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jann Horn <jannh@google.com>

The current API of the SafeSetID LSM uses one write() per rule, and applies
each written rule instantly. This has several downsides:

 - While a policy is being loaded, once a single parent-child pair has been
   loaded, the parent is restricted to that specific child, even if
   subsequent rules would allow transitions to other child UIDs. This means
   that during policy loading, set*uid() can randomly fail.
 - To replace the policy without rebooting, it is necessary to first flush
   all old rules. This creates a time window in which no constraints are
   placed on the use of CAP_SETUID.
 - If we want to perform sanity checks on the final policy, this requires
   that the policy isn't constructed in a piecemeal fashion without telling
   the kernel when it's done.

Other kernel APIs - including things like the userns code and netfilter -
avoid this problem by performing updates atomically. Luckily, SafeSetID
hasn't landed in a stable (upstream) release yet, so maybe it's not too
late to completely change the API.

The new API for SafeSetID is: If you want to change the policy, open
"safesetid/whitelist_policy" and write the entire policy,
newline-delimited, in there.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Micah Morton <mortonm@chromium.org>
---
 security/safesetid/lsm.c                      |  84 +++-----
 security/safesetid/lsm.h                      |  24 +--
 security/safesetid/securityfs.c               | 194 ++++++++++--------
 .../selftests/safesetid/safesetid-test.c      |  16 +-
 4 files changed, 149 insertions(+), 169 deletions(-)

diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index ab429e1816c5..4ab4d7cdba31 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -24,28 +24,38 @@
 /* Flag indicating whether initialization completed */
 int safesetid_initialized;
 
-#define NUM_BITS 8 /* 256 buckets in hash table */
+struct setuid_ruleset __rcu *safesetid_setuid_rules;
 
-static DEFINE_HASHTABLE(safesetid_whitelist_hashtable, NUM_BITS);
-
-static DEFINE_SPINLOCK(safesetid_whitelist_hashtable_spinlock);
-
-static enum sid_policy_type setuid_policy_lookup(kuid_t src, kuid_t dst)
+/* Compute a decision for a transition from @src to @dst under @policy. */
+enum sid_policy_type _setuid_policy_lookup(struct setuid_ruleset *policy,
+		kuid_t src, kuid_t dst)
 {
-	struct entry *entry;
+	struct setuid_rule *rule;
 	enum sid_policy_type result = SIDPOL_DEFAULT;
 
-	rcu_read_lock();
-	hash_for_each_possible_rcu(safesetid_whitelist_hashtable,
-				   entry, next, __kuid_val(src)) {
-		if (!uid_eq(entry->src_uid, src))
+	hash_for_each_possible(policy->rules, rule, next, __kuid_val(src)) {
+		if (!uid_eq(rule->src_uid, src))
 			continue;
-		if (uid_eq(entry->dst_uid, dst)) {
-			rcu_read_unlock();
+		if (uid_eq(rule->dst_uid, dst))
 			return SIDPOL_ALLOWED;
-		}
 		result = SIDPOL_CONSTRAINED;
 	}
+	return result;
+}
+
+/*
+ * Compute a decision for a transition from @src to @dst under the active
+ * policy.
+ */
+static enum sid_policy_type setuid_policy_lookup(kuid_t src, kuid_t dst)
+{
+	enum sid_policy_type result = SIDPOL_DEFAULT;
+	struct setuid_ruleset *pol;
+
+	rcu_read_lock();
+	pol = rcu_dereference(safesetid_setuid_rules);
+	if (pol)
+		result = _setuid_policy_lookup(pol, src, dst);
 	rcu_read_unlock();
 	return result;
 }
@@ -139,52 +149,6 @@ static int safesetid_task_fix_setuid(struct cred *new,
 	return -EACCES;
 }
 
-int add_safesetid_whitelist_entry(kuid_t parent, kuid_t child)
-{
-	struct entry *new;
-
-	/* Return if entry already exists */
-	if (setuid_policy_lookup(parent, child) == SIDPOL_ALLOWED)
-		return 0;
-
-	new = kzalloc(sizeof(struct entry), GFP_KERNEL);
-	if (!new)
-		return -ENOMEM;
-	new->src_uid = parent;
-	new->dst_uid = child;
-	spin_lock(&safesetid_whitelist_hashtable_spinlock);
-	hash_add_rcu(safesetid_whitelist_hashtable,
-		     &new->next,
-		     __kuid_val(parent));
-	spin_unlock(&safesetid_whitelist_hashtable_spinlock);
-	return 0;
-}
-
-void flush_safesetid_whitelist_entries(void)
-{
-	struct entry *entry;
-	struct hlist_node *hlist_node;
-	unsigned int bkt_loop_cursor;
-	HLIST_HEAD(free_list);
-
-	/*
-	 * Could probably use hash_for_each_rcu here instead, but this should
-	 * be fine as well.
-	 */
-	spin_lock(&safesetid_whitelist_hashtable_spinlock);
-	hash_for_each_safe(safesetid_whitelist_hashtable, bkt_loop_cursor,
-			   hlist_node, entry, next) {
-		hash_del_rcu(&entry->next);
-		hlist_add_head(&entry->dlist, &free_list);
-	}
-	spin_unlock(&safesetid_whitelist_hashtable_spinlock);
-	synchronize_rcu();
-	hlist_for_each_entry_safe(entry, hlist_node, &free_list, dlist) {
-		hlist_del(&entry->dlist);
-		kfree(entry);
-	}
-}
-
 static struct security_hook_list safesetid_security_hooks[] = {
 	LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
 	LSM_HOOK_INIT(capable, safesetid_security_capable)
diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
index 6806f902794c..4a34f558d964 100644
--- a/security/safesetid/lsm.h
+++ b/security/safesetid/lsm.h
@@ -21,12 +21,6 @@
 /* Flag indicating whether initialization completed */
 extern int safesetid_initialized;
 
-/* Function type. */
-enum safesetid_whitelist_file_write_type {
-	SAFESETID_WHITELIST_ADD, /* Add whitelist policy. */
-	SAFESETID_WHITELIST_FLUSH, /* Flush whitelist policies. */
-};
-
 enum sid_policy_type {
 	SIDPOL_DEFAULT, /* source ID is unaffected by policy */
 	SIDPOL_CONSTRAINED, /* source ID is affected by policy */
@@ -35,18 +29,24 @@ enum sid_policy_type {
 
 /*
  * Hash table entry to store safesetid policy signifying that 'src_uid'
- * can setid to 'dst_uid'.
+ * can setuid to 'dst_uid'.
  */
-struct entry {
+struct setuid_rule {
 	struct hlist_node next;
-	struct hlist_node dlist; /* for deletion cleanup */
 	kuid_t src_uid;
 	kuid_t dst_uid;
 };
 
-/* Add entry to safesetid whitelist to allow 'parent' to setid to 'child'. */
-int add_safesetid_whitelist_entry(kuid_t parent, kuid_t child);
+#define SETID_HASH_BITS 8 /* 256 buckets in hash table */
+
+struct setuid_ruleset {
+	DECLARE_HASHTABLE(rules, SETID_HASH_BITS);
+	struct rcu_head rcu;
+};
+
+enum sid_policy_type _setuid_policy_lookup(struct setuid_ruleset *policy,
+		kuid_t src, kuid_t dst);
 
-void flush_safesetid_whitelist_entries(void);
+extern struct setuid_ruleset __rcu *safesetid_setuid_rules;
 
 #endif /* _SAFESETID_H */
diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index 76c1e8a6ab93..13fce4c10930 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -11,25 +11,15 @@
  * published by the Free Software Foundation.
  *
  */
+
+#define pr_fmt(fmt) "SafeSetID: " fmt
+
 #include <linux/security.h>
 #include <linux/cred.h>
 
 #include "lsm.h"
 
-static struct dentry *safesetid_policy_dir;
-
-struct safesetid_file_entry {
-	const char *name;
-	enum safesetid_whitelist_file_write_type type;
-	struct dentry *dentry;
-};
-
-static struct safesetid_file_entry safesetid_files[] = {
-	{.name = "add_whitelist_policy",
-	 .type = SAFESETID_WHITELIST_ADD},
-	{.name = "flush_whitelist_policies",
-	 .type = SAFESETID_WHITELIST_FLUSH},
-};
+static DEFINE_SPINLOCK(policy_update_lock);
 
 /*
  * In the case the input buffer contains one or more invalid UIDs, the kuid_t
@@ -37,8 +27,8 @@ static struct safesetid_file_entry safesetid_files[] = {
  * function will return an error.
  * Contents of @buf may be modified.
  */
-static int parse_policy_line(
-	struct file *file, char *buf, kuid_t *parent, kuid_t *child)
+static int parse_policy_line(struct file *file, char *buf,
+	struct setuid_rule *rule)
 {
 	char *child_str;
 	int ret;
@@ -59,26 +49,103 @@ static int parse_policy_line(
 	if (ret)
 		return ret;
 
-	*parent = make_kuid(file->f_cred->user_ns, parsed_parent);
-	*child = make_kuid(file->f_cred->user_ns, parsed_child);
-	if (!uid_valid(*parent) || !uid_valid(*child))
+	rule->src_uid = make_kuid(file->f_cred->user_ns, parsed_parent);
+	rule->dst_uid = make_kuid(file->f_cred->user_ns, parsed_child);
+	if (!uid_valid(rule->src_uid) || !uid_valid(rule->dst_uid))
 		return -EINVAL;
 
 	return 0;
 }
 
-static int parse_safesetid_whitelist_policy(
-	struct file *file, const char __user *buf, size_t len,
-	kuid_t *parent, kuid_t *child)
+static void __release_ruleset(struct rcu_head *rcu)
 {
-	char *kern_buf = memdup_user_nul(buf, len);
-	int ret;
+	struct setuid_ruleset *pol =
+		container_of(rcu, struct setuid_ruleset, rcu);
+	int bucket;
+	struct setuid_rule *rule;
+	struct hlist_node *tmp;
+
+	hash_for_each_safe(pol->rules, bucket, tmp, rule, next)
+		kfree(rule);
+	kfree(pol);
+}
 
-	if (IS_ERR(kern_buf))
-		return PTR_ERR(kern_buf);
-	ret = parse_policy_line(file, kern_buf, parent, child);
-	kfree(kern_buf);
-	return ret;
+static void release_ruleset(struct setuid_ruleset *pol)
+{
+	call_rcu(&pol->rcu, __release_ruleset);
+}
+
+static ssize_t handle_policy_update(struct file *file,
+				    const char __user *ubuf, size_t len)
+{
+	struct setuid_ruleset *pol;
+	char *buf, *p, *end;
+	int err;
+
+	pol = kmalloc(sizeof(struct setuid_ruleset), GFP_KERNEL);
+	if (!pol)
+		return -ENOMEM;
+	hash_init(pol->rules);
+
+	p = buf = memdup_user_nul(ubuf, len);
+	if (IS_ERR(buf)) {
+		err = PTR_ERR(buf);
+		goto out_free_pol;
+	}
+
+	/* policy lines, including the last one, end with \n */
+	while (*p != '\0') {
+		struct setuid_rule *rule;
+
+		end = strchr(p, '\n');
+		if (end == NULL) {
+			err = -EINVAL;
+			goto out_free_buf;
+		}
+		*end = '\0';
+
+		rule = kmalloc(sizeof(struct setuid_rule), GFP_KERNEL);
+		if (!rule) {
+			err = -ENOMEM;
+			goto out_free_buf;
+		}
+
+		err = parse_policy_line(file, p, rule);
+		if (err)
+			goto out_free_rule;
+
+		if (_setuid_policy_lookup(pol, rule->src_uid, rule->dst_uid) ==
+		    SIDPOL_ALLOWED) {
+			pr_warn("bad policy: duplicate entry\n");
+			err = -EEXIST;
+			goto out_free_rule;
+		}
+
+		hash_add(pol->rules, &rule->next, __kuid_val(rule->src_uid));
+		p = end + 1;
+		continue;
+
+out_free_rule:
+		kfree(rule);
+		goto out_free_buf;
+	}
+
+	/*
+	 * Everything looks good, apply the policy and release the old one.
+	 * What we really want here is an xchg() wrapper for RCU, but since that
+	 * doesn't currently exist, just use a spinlock for now.
+	 */
+	spin_lock(&policy_update_lock);
+	rcu_swap_protected(safesetid_setuid_rules, pol,
+			   lockdep_is_held(&policy_update_lock));
+	spin_unlock(&policy_update_lock);
+	err = len;
+
+out_free_buf:
+	kfree(buf);
+out_free_pol:
+	release_ruleset(pol);
+	return err;
 }
 
 static ssize_t safesetid_file_write(struct file *file,
@@ -86,90 +153,45 @@ static ssize_t safesetid_file_write(struct file *file,
 				    size_t len,
 				    loff_t *ppos)
 {
-	struct safesetid_file_entry *file_entry =
-		file->f_inode->i_private;
-	kuid_t parent;
-	kuid_t child;
-	int ret;
-
 	if (!file_ns_capable(file, &init_user_ns, CAP_MAC_ADMIN))
 		return -EPERM;
 
 	if (*ppos != 0)
 		return -EINVAL;
 
-	switch (file_entry->type) {
-	case SAFESETID_WHITELIST_FLUSH:
-		flush_safesetid_whitelist_entries();
-		break;
-	case SAFESETID_WHITELIST_ADD:
-		ret = parse_safesetid_whitelist_policy(file, buf, len,
-						       &parent, &child);
-		if (ret)
-			return ret;
-
-		ret = add_safesetid_whitelist_entry(parent, child);
-		if (ret)
-			return ret;
-		break;
-	default:
-		pr_warn("Unknown securityfs file %d\n", file_entry->type);
-		break;
-	}
-
-	/* Return len on success so caller won't keep trying to write */
-	return len;
+	return handle_policy_update(file, buf, len);
 }
 
 static const struct file_operations safesetid_file_fops = {
 	.write = safesetid_file_write,
 };
 
-static void safesetid_shutdown_securityfs(void)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(safesetid_files); ++i) {
-		struct safesetid_file_entry *entry =
-			&safesetid_files[i];
-		securityfs_remove(entry->dentry);
-		entry->dentry = NULL;
-	}
-
-	securityfs_remove(safesetid_policy_dir);
-	safesetid_policy_dir = NULL;
-}
-
 static int __init safesetid_init_securityfs(void)
 {
-	int i;
 	int ret;
+	struct dentry *policy_dir;
+	struct dentry *policy_file;
 
 	if (!safesetid_initialized)
 		return 0;
 
-	safesetid_policy_dir = securityfs_create_dir("safesetid", NULL);
-	if (IS_ERR(safesetid_policy_dir)) {
-		ret = PTR_ERR(safesetid_policy_dir);
+	policy_dir = securityfs_create_dir("safesetid", NULL);
+	if (IS_ERR(policy_dir)) {
+		ret = PTR_ERR(policy_dir);
 		goto error;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(safesetid_files); ++i) {
-		struct safesetid_file_entry *entry =
-			&safesetid_files[i];
-		entry->dentry = securityfs_create_file(
-			entry->name, 0200, safesetid_policy_dir,
-			entry, &safesetid_file_fops);
-		if (IS_ERR(entry->dentry)) {
-			ret = PTR_ERR(entry->dentry);
-			goto error;
-		}
+	policy_file = securityfs_create_file("whitelist_policy", 0200,
+			policy_dir, NULL, &safesetid_file_fops);
+	if (IS_ERR(policy_file)) {
+		ret = PTR_ERR(policy_file);
+		goto error;
 	}
 
 	return 0;
 
 error:
-	safesetid_shutdown_securityfs();
+	securityfs_remove(policy_dir);
 	return ret;
 }
 fs_initcall(safesetid_init_securityfs);
diff --git a/tools/testing/selftests/safesetid/safesetid-test.c b/tools/testing/selftests/safesetid/safesetid-test.c
index 892c8e8b1b8b..4f03813d1911 100644
--- a/tools/testing/selftests/safesetid/safesetid-test.c
+++ b/tools/testing/selftests/safesetid/safesetid-test.c
@@ -142,23 +142,17 @@ static void ensure_securityfs_mounted(void)
 
 static void write_policies(void)
 {
+	static char *policy_str =
+		"1:2\n"
+		"1:3\n";
 	ssize_t written;
 	int fd;
 
 	fd = open(add_whitelist_policy_file, O_WRONLY);
 	if (fd < 0)
 		die("cant open add_whitelist_policy file\n");
-	written = write(fd, "1:2", strlen("1:2"));
-	if (written != strlen("1:2")) {
-		if (written >= 0) {
-			die("short write to %s\n", add_whitelist_policy_file);
-		} else {
-			die("write to %s failed: %s\n",
-				add_whitelist_policy_file, strerror(errno));
-		}
-	}
-	written = write(fd, "1:3", strlen("1:3"));
-	if (written != strlen("1:3")) {
+	written = write(fd, policy_str, strlen(policy_str));
+	if (written != strlen(policy_str)) {
 		if (written >= 0) {
 			die("short write to %s\n", add_whitelist_policy_file);
 		} else {
-- 
2.21.0.392.gf8f6787159e-goog

