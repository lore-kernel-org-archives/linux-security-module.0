Return-Path: <SRS0=pLHH=QW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7D4C43381
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Feb 2019 22:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B4E222D7
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Feb 2019 22:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mHQXWfpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbfBOWWe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:22:34 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:44550 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730007AbfBOWWe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 15 Feb 2019 17:22:34 -0500
Received: by mail-it1-f200.google.com with SMTP id v12so9123477itv.9
        for <linux-security-module@vger.kernel.org>; Fri, 15 Feb 2019 14:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=U1p7xOdapXI1ZqKF11VecICv2l/ROIdgQ3sTYAH2HVs=;
        b=mHQXWfpzVGtsN8vsmIjecmZ6KneLRfIdvfBn77N9omBm9BA2ML4+2WORQ2TsDScTu7
         f6idlh0ZjCU33C1gQJlWT92OYi7/z4P3P23i/Ahpkg9D1eVkU2eXjxXtB597+uvyqVKB
         NfgQbBH4UXQYO8vmBWxVHGmn64voQQ8kNPOjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=U1p7xOdapXI1ZqKF11VecICv2l/ROIdgQ3sTYAH2HVs=;
        b=V+bFEoDOfdhMkh6HWCbPh2n1DbemofipmLU5aN6smp0aaeeuC0Al2LuwVoO9XcbOJW
         G/lPjuUyiVBYxiMeQxZvNiiqxcpSD/ytsKf7FfsF3spsYWrxRfDxSxZ4CGIXFmN37tIr
         ksmXUZ9qtPZ6HoLFSVdmL84caVE3kcjYAnpxAXoi9D9MhGC7Ucr6h+6gRceoidhPSALf
         iHM92jVzGlO59hKHZXfT5V+ZxUy2+oDN0S42fAigf13kEkbAuYGWYBmwueeNhAac3yuW
         M8ewRsQiJETtwiKiFTs+31xx2efy0jUc1LaZ/atMLPxSBocb07ZgJjygRjA+THsmOif0
         xrGQ==
X-Gm-Message-State: AHQUAuag5gUO12xC+564qd6t0HQ6YunYB3tJhbxiCw58vvXSi88ITofK
        pYTDvm/v7sFRpLNaVNeB8UHTpwvuLaZ7S6hr
X-Google-Smtp-Source: AHgI3IbNWEb4WxUn7CF8dj5R/JEkfRnbxh2hxjNN1nh34TQOVyl2eY2WlxQIlD8iGl27qEIp//sOALKdb2vprdb7
X-Received: by 2002:a24:9143:: with SMTP id i64mr6393211ite.32.1550269352752;
 Fri, 15 Feb 2019 14:22:32 -0800 (PST)
Date:   Fri, 15 Feb 2019 14:22:28 -0800
Message-Id: <20190215222228.133709-1-mortonm@chromium.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH 2/2] LSM: SafeSetID: gate setgid transitions
From:   mortonm@chromium.org
To:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        casey@schaufler-ca.com, sds@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Cc:     Micah Morton <mortonm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Micah Morton <mortonm@chromium.org>

The SafeSetID LSM already gates setuid transitions for UIDs on the
system whose use of CAP_SETUID has been 'restricted'. This patch
implements the analogous functionality for setgid transitions, in order
to restrict the use of CAP_SETGID for certain UIDs on the system. One
notable consequence of this addition is that a process running under a
restricted UID (i.e. one that is only allowed to setgid to certain
approved GIDs) will not be allowed to call the setgroups() syscall to
set its supplementary group IDs. For now, we leave such support for
restricted setgroups() to future work, as it would require hooking the
logic in setgroups() and verifying that the array of GIDs passed in from
userspace only consists of approved GIDs.

Signed-off-by: Micah Morton <mortonm@chromium.org>
---
Tested with slight mod to test in tools/testing/selftests/safesetid for
testing setgid as well as setuid.

 security/safesetid/lsm.c        | 263 +++++++++++++++++++++++++++-----
 security/safesetid/lsm.h        |  11 +-
 security/safesetid/securityfs.c | 105 +++++++++----
 3 files changed, 307 insertions(+), 72 deletions(-)

diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index cecd38e2ac80..5d9710b7bb04 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -26,27 +26,30 @@ int safesetid_initialized;
 
 #define NUM_BITS 8 /* 128 buckets in hash table */
 
-static DEFINE_HASHTABLE(safesetid_whitelist_hashtable, NUM_BITS);
+static DEFINE_HASHTABLE(safesetid_whitelist_uid_hashtable, NUM_BITS);
+static DEFINE_HASHTABLE(safesetid_whitelist_gid_hashtable, NUM_BITS);
+
+static DEFINE_SPINLOCK(safesetid_whitelist_uid_hashtable_spinlock);
+static DEFINE_SPINLOCK(safesetid_whitelist_gid_hashtable_spinlock);
 
 /*
  * Hash table entry to store safesetid policy signifying that 'parent' user
- * can setid to 'child' user.
+ * can setid to 'child' user. This struct is used in both the uid and gid
+ * hashtables.
  */
-struct entry {
+struct id_entry {
 	struct hlist_node next;
 	struct hlist_node dlist; /* for deletion cleanup */
 	uint64_t parent_kuid;
-	uint64_t child_kuid;
+	uint64_t child_kid; /* Represents either a UID or a GID */
 };
 
-static DEFINE_SPINLOCK(safesetid_whitelist_hashtable_spinlock);
-
 static bool check_setuid_policy_hashtable_key(kuid_t parent)
 {
-	struct entry *entry;
+	struct id_entry *entry;
 
 	rcu_read_lock();
-	hash_for_each_possible_rcu(safesetid_whitelist_hashtable,
+	hash_for_each_possible_rcu(safesetid_whitelist_uid_hashtable,
 				   entry, next, __kuid_val(parent)) {
 		if (entry->parent_kuid == __kuid_val(parent)) {
 			rcu_read_unlock();
@@ -61,13 +64,13 @@ static bool check_setuid_policy_hashtable_key(kuid_t parent)
 static bool check_setuid_policy_hashtable_key_value(kuid_t parent,
 						    kuid_t child)
 {
-	struct entry *entry;
+	struct id_entry *entry;
 
 	rcu_read_lock();
-	hash_for_each_possible_rcu(safesetid_whitelist_hashtable,
+	hash_for_each_possible_rcu(safesetid_whitelist_uid_hashtable,
 				   entry, next, __kuid_val(parent)) {
 		if (entry->parent_kuid == __kuid_val(parent) &&
-		    entry->child_kuid == __kuid_val(child)) {
+		    entry->child_kid == __kuid_val(child)) {
 			rcu_read_unlock();
 			return true;
 		}
@@ -77,6 +80,48 @@ static bool check_setuid_policy_hashtable_key_value(kuid_t parent,
 	return false;
 }
 
+static bool check_setgid_policy_hashtable_key(kuid_t parent)
+{
+	struct id_entry *entry;
+
+	rcu_read_lock();
+	hash_for_each_possible_rcu(safesetid_whitelist_gid_hashtable,
+				   entry, next, __kuid_val(parent)) {
+		if (entry->parent_kuid == __kuid_val(parent)) {
+			rcu_read_unlock();
+			return true;
+		}
+	}
+	rcu_read_unlock();
+
+	return false;
+}
+
+static bool check_setgid_policy_hashtable_key_value(kuid_t parent,
+						    kgid_t child)
+{
+	struct id_entry *entry;
+
+	rcu_read_lock();
+	hash_for_each_possible_rcu(safesetid_whitelist_gid_hashtable,
+				   entry, next, __kuid_val(parent)) {
+		if (entry->parent_kuid == __kuid_val(parent) &&
+		    entry->child_kid == __kgid_val(child)) {
+			rcu_read_unlock();
+			return true;
+		}
+	}
+	rcu_read_unlock();
+
+	return false;
+}
+
+/*
+ * This hook causes the security_capable check to fail when there are
+ * restriction policies for a UID and the process is trying to do something
+ * (other than a setid transition) that is gated by CAP_SETUID/CAP_SETGID
+ * (e.g. allowing user to set up userns UID/GID mappings).
+ */
 static int safesetid_security_capable(const struct cred *cred,
 				      struct user_namespace *ns,
 				      int cap,
@@ -85,17 +130,19 @@ static int safesetid_security_capable(const struct cred *cred,
 	if (cap == CAP_SETUID &&
 	    check_setuid_policy_hashtable_key(cred->uid)) {
 		if (!(opts & CAP_OPT_INSETID)) {
-			/*
-			 * Deny if we're not in a set*uid() syscall to avoid
-			 * giving powers gated by CAP_SETUID that are related
-			 * to functionality other than calling set*uid() (e.g.
-			 * allowing user to set up userns uid mappings).
-			 */
 			pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions",
 				__kuid_val(cred->uid));
 			return -1;
 		}
 	}
+	if (cap == CAP_SETGID &&
+	    check_setgid_policy_hashtable_key(cred->uid)) {
+		if (!(opts & CAP_OPT_INSETID)) {
+			pr_warn("Operation requires CAP_SETGID, which is not available to UID %u for operations besides approved set*gid transitions",
+				__kuid_val(cred->uid));
+			return -1;
+		}
+	}
 	return 0;
 }
 
@@ -115,6 +162,22 @@ static int check_uid_transition(kuid_t parent, kuid_t child)
 	return -EACCES;
 }
 
+static int check_gid_transition(kuid_t parent, kgid_t child)
+{
+	if (check_setgid_policy_hashtable_key_value(parent, child))
+		return 0;
+	pr_warn("Denied UID %d setting GID to %d",
+		__kuid_val(parent),
+		__kgid_val(child));
+	/*
+	 * Kill this process to avoid potential security vulnerabilities
+	 * that could arise from a missing whitelist entry preventing a
+	 * privileged process from dropping to a lesser-privileged one.
+	 */
+	force_sig(SIGKILL, current);
+	return -EACCES;
+}
+
 /*
  * Check whether there is either an exception for user under old cred struct to
  * set*uid to user under new cred struct, or the UID transition is allowed (by
@@ -124,7 +187,6 @@ static int safesetid_task_fix_setuid(struct cred *new,
 				     const struct cred *old,
 				     int flags)
 {
-
 	/* Do nothing if there are no setuid restrictions for this UID. */
 	if (!check_setuid_policy_hashtable_key(old->uid))
 		return 0;
@@ -209,54 +271,183 @@ static int safesetid_task_fix_setuid(struct cred *new,
 	return 0;
 }
 
-int add_safesetid_whitelist_entry(kuid_t parent, kuid_t child)
+/*
+ * Check whether there is either an exception for user under old cred struct to
+ * set*gid to group under new cred struct, or the GID transition is allowed (by
+ * Linux set*gid rules) even without CAP_SETGID.
+ */
+static int safesetid_task_fix_setgid(struct cred *new,
+				     const struct cred *old,
+				     int flags)
+{
+	/* Do nothing if there are no setgid restrictions for this GID. */
+	if (!check_setgid_policy_hashtable_key(old->uid))
+		return 0;
+
+	switch (flags) {
+	case LSM_SETID_RE:
+		/*
+		 * Users for which setgid restrictions exist can only set the
+		 * real GID to the real GID or the effective GID, unless an
+		 * explicit whitelist policy allows the transition.
+		 */
+		if (!gid_eq(old->gid, new->gid) &&
+			!gid_eq(old->egid, new->gid)) {
+			return check_gid_transition(old->uid, new->gid);
+		}
+		/*
+		 * Users for which setgid restrictions exist can only set the
+		 * effective GID to the real GID, the effective GID, or the
+		 * saved set-GID, unless an explicit whitelist policy allows
+		 * the transition.
+		 */
+		if (!gid_eq(old->gid, new->egid) &&
+			!gid_eq(old->egid, new->egid) &&
+			!gid_eq(old->sgid, new->egid)) {
+			return check_gid_transition(old->euid, new->egid);
+		}
+		break;
+	case LSM_SETID_ID:
+		/*
+		 * Users for which setgid restrictions exist cannot change the
+		 * real GID or saved set-GID unless an explicit whitelist
+		 * policy allows the transition.
+		 */
+		if (!gid_eq(old->gid, new->gid))
+			return check_gid_transition(old->uid, new->gid);
+		if (!gid_eq(old->sgid, new->sgid))
+			return check_gid_transition(old->suid, new->sgid);
+		break;
+	case LSM_SETID_RES:
+		/*
+		 * Users for which setgid restrictions exist cannot change the
+		 * real GID, effective GID, or saved set-GID to anything but
+		 * one of: the current real GID, the current effective GID or
+		 * the current saved set-user-ID unless an explicit whitelist
+		 * policy allows the transition.
+		 */
+		if (!gid_eq(new->gid, old->gid) &&
+			!gid_eq(new->gid, old->egid) &&
+			!gid_eq(new->gid, old->sgid)) {
+			return check_gid_transition(old->uid, new->gid);
+		}
+		if (!gid_eq(new->egid, old->gid) &&
+			!gid_eq(new->egid, old->egid) &&
+			!gid_eq(new->egid, old->sgid)) {
+			return check_gid_transition(old->euid, new->egid);
+		}
+		if (!gid_eq(new->sgid, old->gid) &&
+			!gid_eq(new->sgid, old->egid) &&
+			!gid_eq(new->sgid, old->sgid)) {
+			return check_gid_transition(old->suid, new->sgid);
+		}
+		break;
+	case LSM_SETID_FS:
+		/*
+		 * Users for which setgid restrictions exist cannot change the
+		 * filesystem GID to anything but one of: the current real GID,
+		 * the current effective GID or the current saved set-GID
+		 * unless an explicit whitelist policy allows the transition.
+		 */
+		if (!gid_eq(new->fsgid, old->gid)  &&
+			!gid_eq(new->fsgid, old->egid)  &&
+			!gid_eq(new->fsgid, old->sgid) &&
+			!gid_eq(new->fsgid, old->fsgid)) {
+			return check_gid_transition(old->fsuid, new->fsgid);
+		}
+		break;
+	default:
+		pr_warn("Unknown setid state %d\n", flags);
+		force_sig(SIGKILL, current);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int add_safesetid_whitelist_uid_entry(kuid_t parent, kuid_t child)
 {
-	struct entry *new;
+	struct id_entry *new;
 
 	/* Return if entry already exists */
 	if (check_setuid_policy_hashtable_key_value(parent, child))
 		return 0;
 
-	new = kzalloc(sizeof(struct entry), GFP_KERNEL);
+	new = kzalloc(sizeof(struct id_entry), GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+	new->parent_kuid = __kuid_val(parent);
+	new->child_kid = __kuid_val(child);
+	spin_lock(&safesetid_whitelist_uid_hashtable_spinlock);
+	hash_add_rcu(safesetid_whitelist_uid_hashtable,
+		     &new->next,
+		     __kuid_val(parent));
+	spin_unlock(&safesetid_whitelist_uid_hashtable_spinlock);
+	return 0;
+}
+
+int add_safesetid_whitelist_gid_entry(kuid_t parent, kgid_t child)
+{
+	struct id_entry *new;
+
+	/* Return if entry already exists */
+	if (check_setgid_policy_hashtable_key_value(parent, child))
+		return 0;
+
+	new = kzalloc(sizeof(struct id_entry), GFP_KERNEL);
 	if (!new)
 		return -ENOMEM;
 	new->parent_kuid = __kuid_val(parent);
-	new->child_kuid = __kuid_val(child);
-	spin_lock(&safesetid_whitelist_hashtable_spinlock);
-	hash_add_rcu(safesetid_whitelist_hashtable,
+	new->child_kid = __kgid_val(child);
+	spin_lock(&safesetid_whitelist_gid_hashtable_spinlock);
+	hash_add_rcu(safesetid_whitelist_gid_hashtable,
 		     &new->next,
 		     __kuid_val(parent));
-	spin_unlock(&safesetid_whitelist_hashtable_spinlock);
+	spin_unlock(&safesetid_whitelist_gid_hashtable_spinlock);
 	return 0;
 }
 
 void flush_safesetid_whitelist_entries(void)
 {
-	struct entry *entry;
+	struct id_entry *id_entry;
 	struct hlist_node *hlist_node;
 	unsigned int bkt_loop_cursor;
-	HLIST_HEAD(free_list);
+	HLIST_HEAD(uid_free_list);
+	HLIST_HEAD(gid_free_list);
 
 	/*
 	 * Could probably use hash_for_each_rcu here instead, but this should
 	 * be fine as well.
 	 */
-	spin_lock(&safesetid_whitelist_hashtable_spinlock);
-	hash_for_each_safe(safesetid_whitelist_hashtable, bkt_loop_cursor,
-			   hlist_node, entry, next) {
-		hash_del_rcu(&entry->next);
-		hlist_add_head(&entry->dlist, &free_list);
+	spin_lock(&safesetid_whitelist_uid_hashtable_spinlock);
+	hash_for_each_safe(safesetid_whitelist_uid_hashtable, bkt_loop_cursor,
+			   hlist_node, id_entry, next) {
+		hash_del_rcu(&id_entry->next);
+		hlist_add_head(&id_entry->dlist, &uid_free_list);
+	}
+	spin_unlock(&safesetid_whitelist_uid_hashtable_spinlock);
+	synchronize_rcu();
+	hlist_for_each_entry_safe(id_entry, hlist_node, &uid_free_list, dlist) {
+		hlist_del(&id_entry->dlist);
+		kfree(id_entry);
+	}
+
+	spin_lock(&safesetid_whitelist_gid_hashtable_spinlock);
+	hash_for_each_safe(safesetid_whitelist_gid_hashtable, bkt_loop_cursor,
+			   hlist_node, id_entry, next) {
+		hash_del_rcu(&id_entry->next);
+		hlist_add_head(&id_entry->dlist, &gid_free_list);
 	}
-	spin_unlock(&safesetid_whitelist_hashtable_spinlock);
+	spin_unlock(&safesetid_whitelist_gid_hashtable_spinlock);
 	synchronize_rcu();
-	hlist_for_each_entry_safe(entry, hlist_node, &free_list, dlist) {
-		hlist_del(&entry->dlist);
-		kfree(entry);
+	hlist_for_each_entry_safe(id_entry, hlist_node, &gid_free_list, dlist) {
+		hlist_del(&id_entry->dlist);
+		kfree(id_entry);
 	}
 }
 
 static struct security_hook_list safesetid_security_hooks[] = {
 	LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
+	LSM_HOOK_INIT(task_fix_setgid, safesetid_task_fix_setgid),
 	LSM_HOOK_INIT(capable, safesetid_security_capable)
 };
 
diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
index c1ea3c265fcf..e9ae192caff2 100644
--- a/security/safesetid/lsm.h
+++ b/security/safesetid/lsm.h
@@ -21,13 +21,16 @@ extern int safesetid_initialized;
 
 /* Function type. */
 enum safesetid_whitelist_file_write_type {
-	SAFESETID_WHITELIST_ADD, /* Add whitelist policy. */
+	SAFESETID_WHITELIST_ADD_UID, /* Add UID whitelist policy. */
+	SAFESETID_WHITELIST_ADD_GID, /* Add GID whitelist policy. */
 	SAFESETID_WHITELIST_FLUSH, /* Flush whitelist policies. */
 };
 
-/* Add entry to safesetid whitelist to allow 'parent' to setid to 'child'. */
-int add_safesetid_whitelist_entry(kuid_t parent, kuid_t child);
-
+/* Add entry to safesetid whitelist to allow 'parent' to setuid to 'child'. */
+int add_safesetid_whitelist_uid_entry(kuid_t parent, kuid_t child);
+/* Add entry to safesetid whitelist to allow 'parent' to setgid to 'child'. */
+int add_safesetid_whitelist_gid_entry(kgid_t parent, kgid_t child);
+/* Flush all UID/GID whitelist policies. */
 void flush_safesetid_whitelist_entries(void);
 
 #endif /* _SAFESETID_H */
diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index 2c6c829be044..62134f2edbe5 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -25,21 +25,18 @@ struct safesetid_file_entry {
 };
 
 static struct safesetid_file_entry safesetid_files[] = {
-	{.name = "add_whitelist_policy",
-	 .type = SAFESETID_WHITELIST_ADD},
+	{.name = "add_whitelist_uid_policy",
+	 .type = SAFESETID_WHITELIST_ADD_UID},
+	{.name = "add_whitelist_gid_policy",
+	 .type = SAFESETID_WHITELIST_ADD_GID},
 	{.name = "flush_whitelist_policies",
 	 .type = SAFESETID_WHITELIST_FLUSH},
 };
 
-/*
- * In the case the input buffer contains one or more invalid UIDs, the kuid_t
- * variables pointed to by 'parent' and 'child' will get updated but this
- * function will return an error.
- */
-static int parse_safesetid_whitelist_policy(const char __user *buf,
+static int parse_userbuf_to_longs(const char __user *buf,
 					    size_t len,
-					    kuid_t *parent,
-					    kuid_t *child)
+					    long *parent,
+					    long *child)
 {
 	char *kern_buf;
 	char *parent_buf;
@@ -47,8 +44,6 @@ static int parse_safesetid_whitelist_policy(const char __user *buf,
 	const char separator[] = ":";
 	int ret;
 	size_t first_substring_length;
-	long parsed_parent;
-	long parsed_child;
 
 	/* Duplicate string from user memory and NULL-terminate */
 	kern_buf = memdup_user_nul(buf, len);
@@ -71,27 +66,15 @@ static int parse_safesetid_whitelist_policy(const char __user *buf,
 		goto free_kern;
 	}
 
-	ret = kstrtol(parent_buf, 0, &parsed_parent);
+	ret = kstrtol(parent_buf, 0, parent);
 	if (ret)
 		goto free_both;
 
 	child_buf = kern_buf + first_substring_length + 1;
-	ret = kstrtol(child_buf, 0, &parsed_child);
+	ret = kstrtol(child_buf, 0, child);
 	if (ret)
 		goto free_both;
 
-	*parent = make_kuid(current_user_ns(), parsed_parent);
-	if (!uid_valid(*parent)) {
-		ret = -EINVAL;
-		goto free_both;
-	}
-
-	*child = make_kuid(current_user_ns(), parsed_child);
-	if (!uid_valid(*child)) {
-		ret = -EINVAL;
-		goto free_both;
-	}
-
 free_both:
 	kfree(parent_buf);
 free_kern:
@@ -99,6 +82,52 @@ static int parse_safesetid_whitelist_policy(const char __user *buf,
 	return ret;
 }
 
+static int parse_safesetid_whitelist_uid_policy(const char __user *buf,
+					    size_t len,
+					    kuid_t *parent_uid,
+					    kuid_t *child_uid)
+{
+	int ret;
+	long parent, child;
+
+	ret = parse_userbuf_to_longs(buf, len, &parent, &child);
+	if (ret)
+		return ret;
+
+	*parent_uid = make_kuid(current_user_ns(), parent);
+	if (!uid_valid(*parent_uid))
+		return -EINVAL;
+
+	*child_uid = make_kuid(current_user_ns(), child);
+	if (!uid_valid(*child_uid))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int parse_safesetid_whitelist_gid_policy(const char __user *buf,
+					    size_t len,
+					    kgid_t *parent_gid,
+					    kgid_t *child_gid)
+{
+	int ret;
+	long parent, child;
+
+	ret = parse_userbuf_to_longs(buf, len, &parent, &child);
+	if (ret)
+		return ret;
+
+	*parent_gid = make_kgid(current_user_ns(), parent);
+	if (!gid_valid(*parent_gid))
+		return -EINVAL;
+
+	*child_gid = make_kgid(current_user_ns(), child);
+	if (!gid_valid(*child_gid))
+		return -EINVAL;
+
+	return 0;
+}
+
 static ssize_t safesetid_file_write(struct file *file,
 				    const char __user *buf,
 				    size_t len,
@@ -106,8 +135,10 @@ static ssize_t safesetid_file_write(struct file *file,
 {
 	struct safesetid_file_entry *file_entry =
 		file->f_inode->i_private;
-	kuid_t parent;
-	kuid_t child;
+	kuid_t uid_parent;
+	kuid_t uid_child;
+	kgid_t gid_parent;
+	kgid_t gid_child;
 	int ret;
 
 	if (!ns_capable(current_user_ns(), CAP_MAC_ADMIN))
@@ -120,13 +151,23 @@ static ssize_t safesetid_file_write(struct file *file,
 	case SAFESETID_WHITELIST_FLUSH:
 		flush_safesetid_whitelist_entries();
 		break;
-	case SAFESETID_WHITELIST_ADD:
-		ret = parse_safesetid_whitelist_policy(buf, len, &parent,
-								 &child);
+	case SAFESETID_WHITELIST_ADD_UID:
+		ret = parse_safesetid_whitelist_uid_policy(buf, len, &uid_parent,
+								 &uid_child);
+		if (ret)
+			return ret;
+
+		ret = add_safesetid_whitelist_uid_entry(uid_parent, uid_child);
+		if (ret)
+			return ret;
+		break;
+	case SAFESETID_WHITELIST_ADD_GID:
+		ret = parse_safesetid_whitelist_gid_policy(buf, len, &gid_parent,
+								 &gid_child);
 		if (ret)
 			return ret;
 
-		ret = add_safesetid_whitelist_entry(parent, child);
+		ret = add_safesetid_whitelist_gid_entry(gid_parent, gid_child);
 		if (ret)
 			return ret;
 		break;
-- 
2.21.0.rc0.258.g878e2cd30e-goog

