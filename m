Return-Path: <SRS0=jfU4=RI=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E18C43381
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Mar 2019 15:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05EC920657
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Mar 2019 15:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lVgCWMca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfCEPwj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:52:39 -0500
Received: from mail-pf1-f198.google.com ([209.85.210.198]:51179 "EHLO
        mail-pf1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfCEPwj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Mar 2019 10:52:39 -0500
Received: by mail-pf1-f198.google.com with SMTP id q21so9778627pfi.17
        for <linux-security-module@vger.kernel.org>; Tue, 05 Mar 2019 07:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FoBSKAzFSIYt/6YHgZLhFwS2f+dZoT3ffrHQx+s3ThI=;
        b=lVgCWMcahQgbqE0uxGRsRNv3zdPAMz2EbCsHpfhENaRNkOhhGOBbwmiCdUXlO8wZ0I
         S1a8BQlTT/Y7ST50fc3m89fUzm1tNF0Fs4p6198+J/ingQIbI5s/iv6A2xnHYiMlMFdI
         0mD/UnHCo6jKT9i7ks6r0cm8m2SUfRViMecro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FoBSKAzFSIYt/6YHgZLhFwS2f+dZoT3ffrHQx+s3ThI=;
        b=cuaiPoBbxVoXoIe4B7DAVKisQ9/xlg879eEhRk9p/oELhGgzFd5JtSTDQS7xd4hYKD
         1dwlTt19FgqOWoAZ0lgT5vlI0ezJNxlRUdsNMyy1MBfTiF1B85bxSt28ES8tWq0xfqSU
         cdFDWcQYU8jQ/ZqkVbfd9dhHKABG4tOqaNRKWfMlg7b6u9SZ9gQ+AyBVPMFuBrhEtfkh
         04ZaJb+JqlYwby+vqLcoBgAt27EmIdR78isKhX54kwQlDZf8oaaAEE1K7ESdh8YXtVg+
         +YqWjTaEWY72sqKKM7rMFAKcWTLMtI4GrItYCcExZwSASyowHUkvngcEoIujSIiiXvEp
         pBgA==
X-Gm-Message-State: APjAAAXJx5SJcZX+4JM//coLEj26YlE/HLte4AJ8WzFNPIM5Zak2dfdf
        sEaPCvC9vfHOGu45zKjYfS8tGcs01JoogTqO
X-Google-Smtp-Source: APXvYqwETkgestNk5M6tHOm7fVRXqqeflr/UvRvLYeiqQh+y6mlR+1axLTHtKl6q1OMOwTlpdP3SxfEPs6m15QjP
X-Received: by 2002:a62:1ac5:: with SMTP id a188mr960672pfa.89.1551801157933;
 Tue, 05 Mar 2019 07:52:37 -0800 (PST)
Date:   Tue,  5 Mar 2019 07:52:29 -0800
In-Reply-To: <20190305154922.61040-1-mortonm@chromium.org>
Message-Id: <20190305155229.62831-1-mortonm@chromium.org>
Mime-Version: 1.0
References: <20190305154922.61040-1-mortonm@chromium.org>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH v4 2/2] LSM: SafeSetID: gate setgid transitions
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
Changes since the last patch: Minor updates since patch 1/2 combined the
'task_fix_setuid' and 'task_fix_setgid' hooks into one hook called
'task_fix_setid'.

 Documentation/admin-guide/LSM/SafeSetID.rst |   9 +-
 security/safesetid/lsm.c                    | 272 +++++++++++++++++---
 security/safesetid/lsm.h                    |  11 +-
 security/safesetid/securityfs.c             | 105 +++++---
 4 files changed, 320 insertions(+), 77 deletions(-)

diff --git a/Documentation/admin-guide/LSM/SafeSetID.rst b/Documentation/admin-guide/LSM/SafeSetID.rst
index 670a6544fd39..33307a8e9555 100644
--- a/Documentation/admin-guide/LSM/SafeSetID.rst
+++ b/Documentation/admin-guide/LSM/SafeSetID.rst
@@ -98,10 +98,13 @@ Directions for use
 ==================
 This LSM hooks the setid syscalls to make sure transitions are allowed if an
 applicable restriction policy is in place. Policies are configured through
-securityfs by writing to the safesetid/add_whitelist_policy and
+securityfs by writing to the safesetid/add_whitelist_{uid/gid}_policy* and
 safesetid/flush_whitelist_policies files at the location where securityfs is
-mounted. The format for adding a policy is '<UID>:<UID>', using literal
+mounted. The format for adding a policy is '<ID>:<ID>', using literal
 numbers, such as '123:456'. To flush the policies, any write to the file is
 sufficient. Again, configuring a policy for a UID will prevent that UID from
 obtaining auxiliary setid privileges, such as allowing a user to set up user
-namespace UID mappings.
+namespace ID mappings.
+
+*safesetid/add_whitelist_policy can also be used for UID policies, since it is
+an alias for safesetid/add_whitelist_uid_policy
diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 5deffa92f25f..95c6f35b29f3 100644
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
@@ -61,13 +64,49 @@ static bool check_setuid_policy_hashtable_key(kuid_t parent)
 static bool check_setuid_policy_hashtable_key_value(kuid_t parent,
 						    kuid_t child)
 {
-	struct entry *entry;
+	struct id_entry *entry;
+
+	rcu_read_lock();
+	hash_for_each_possible_rcu(safesetid_whitelist_uid_hashtable,
+				   entry, next, __kuid_val(parent)) {
+		if (entry->parent_kuid == __kuid_val(parent) &&
+		    entry->child_kid == __kuid_val(child)) {
+			rcu_read_unlock();
+			return true;
+		}
+	}
+	rcu_read_unlock();
+
+	return false;
+}
+
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
 
 	rcu_read_lock();
-	hash_for_each_possible_rcu(safesetid_whitelist_hashtable,
+	hash_for_each_possible_rcu(safesetid_whitelist_gid_hashtable,
 				   entry, next, __kuid_val(parent)) {
 		if (entry->parent_kuid == __kuid_val(parent) &&
-		    entry->child_kuid == __kuid_val(child)) {
+		    entry->child_kid == __kgid_val(child)) {
 			rcu_read_unlock();
 			return true;
 		}
@@ -77,6 +116,12 @@ static bool check_setuid_policy_hashtable_key_value(kuid_t parent,
 	return false;
 }
 
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
 
@@ -115,19 +162,48 @@ static int check_uid_transition(kuid_t parent, kuid_t child)
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
- * set*uid to user under new cred struct, or the UID transition is allowed (by
- * Linux set*uid rules) even without CAP_SETUID.
+ * set*id to user under new cred struct, or the ID transition is allowed (by
+ * Linux set*id rules) even without CAP_SET*ID.
  */
 static int safesetid_task_fix_setid(struct cred *new,
 				     const struct cred *old,
 				     int flags)
 {
+	if (flags == LSM_SETUID_RE ||
+	    flags == LSM_SETUID_ID ||
+	    flags == LSM_SETUID_RES ||
+	    flags == LSM_SETUID_FS) {
+		/* Do nothing if there are no setuid restrictions for this UID. */
+		if (!check_setuid_policy_hashtable_key(old->uid))
+		return 0;
+	}
 
-	/* Do nothing if there are no setuid restrictions for this UID. */
-	if (!check_setuid_policy_hashtable_key(old->uid))
+	if (flags == LSM_SETGID_RE ||
+	    flags == LSM_SETGID_ID ||
+	    flags == LSM_SETGID_RES ||
+	    flags == LSM_SETGID_FS) {
+		/* Do nothing if there are no setgid restrictions for this UID. */
+		if (!check_setgid_policy_hashtable_key(old->uid))
 		return 0;
+	}
 
 	switch (flags) {
 	case LSM_SETUID_RE:
@@ -201,6 +277,77 @@ static int safesetid_task_fix_setid(struct cred *new,
 			return check_uid_transition(old->fsuid, new->fsuid);
 		}
 		break;
+	case LSM_SETGID_RE:
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
+	case LSM_SETGID_ID:
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
+	case LSM_SETGID_RES:
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
+	case LSM_SETGID_FS:
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
 	default:
 		pr_warn("Unknown setid state %d\n", flags);
 		force_sig(SIGKILL, current);
@@ -209,49 +356,96 @@ static int safesetid_task_fix_setid(struct cred *new,
 	return 0;
 }
 
-int add_safesetid_whitelist_entry(kuid_t parent, kuid_t child)
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
+	/* Return if the entry got added since we checked above */
+	if (check_setuid_policy_hashtable_key_value(parent, child)) {
+		spin_unlock(&safesetid_whitelist_uid_hashtable_spinlock);
+		kfree(new);
+		return 0;
+	}
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
+	/* Return if the entry got added since we checked above */
+	if (check_setgid_policy_hashtable_key_value(parent, child)) {
+		spin_unlock(&safesetid_whitelist_gid_hashtable_spinlock);
+		kfree(new);
+		return 0;
+	}
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
index 2c6c829be044..c4c25ba7275f 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -26,20 +26,19 @@ struct safesetid_file_entry {
 
 static struct safesetid_file_entry safesetid_files[] = {
 	{.name = "add_whitelist_policy",
-	 .type = SAFESETID_WHITELIST_ADD},
+	 .type = SAFESETID_WHITELIST_ADD_UID},
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
@@ -47,8 +46,6 @@ static int parse_safesetid_whitelist_policy(const char __user *buf,
 	const char separator[] = ":";
 	int ret;
 	size_t first_substring_length;
-	long parsed_parent;
-	long parsed_child;
 
 	/* Duplicate string from user memory and NULL-terminate */
 	kern_buf = memdup_user_nul(buf, len);
@@ -71,27 +68,15 @@ static int parse_safesetid_whitelist_policy(const char __user *buf,
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
@@ -99,6 +84,52 @@ static int parse_safesetid_whitelist_policy(const char __user *buf,
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
@@ -106,8 +137,10 @@ static ssize_t safesetid_file_write(struct file *file,
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
@@ -120,13 +153,23 @@ static ssize_t safesetid_file_write(struct file *file,
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
2.21.0.352.gf09ad66450-goog

