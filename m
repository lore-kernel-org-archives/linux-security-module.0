Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A89C10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 16:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B73320830
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 16:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OaLXS+Pz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388139AbfDJQzh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:55:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36555 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733280AbfDJQzh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 12:55:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so1914301pgc.3
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 09:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WNZ9A2E9lNF9DtU6n0CDvqQTdXDB3ObGpdEuZNzmKOY=;
        b=OaLXS+PziqiVaNQkSudkaluUerpK/Ox64n0BZJGKc/enS4668KPO6G6BeAMU0eyvHw
         pBKuOzbEpG7NDkD2Y47aPhmMYrvDCTOYKYckwEaVFVsgiJO3x+03VG2aPjwSmr2ZOSKV
         aSFrohUbDUpCH3zP0o+Wp/ytwNa1jmYkC0+Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WNZ9A2E9lNF9DtU6n0CDvqQTdXDB3ObGpdEuZNzmKOY=;
        b=BZuAVc0/dTnuUu6S6kiFgUvAqDZI/DWbko4muwegFms6vhs0nnLPEXIJo11tNC5YqI
         mDGErFZ7oBhZhFA1bSSK5CbTvO+o4nWj7k2fnL8KSGystoO8CggpDBMvQdI9qbAIDWYu
         OFvcxi14Lcr/cLZPjq4ZGmFx+p9Z0hlilNWi0pZDqXI3jo/XB70ZrhoJIT7zBUTuLe9x
         p+uXkr61vl9+BtD3tUe5iV2VUXOXHhh2quC0aCGuZAXmGGkSpKuglDi/GcCAvoC8nBzj
         WZei+65GSFXCxfJX3Mvi7jhl3rIyQqdb6uPcCX9o0nfJmiGmmX5J55BZoNziURL38xDa
         Wf+w==
X-Gm-Message-State: APjAAAXhGi0e0GmgZbs2FB76A6xPiMiGvGaU9ql6rMPoe9zUPxBF9BJ4
        iqB3mZhZFAC35QzuypXBJ5z6rQ==
X-Google-Smtp-Source: APXvYqwJW1qMpK+QBO0HX/syVxyfQcV2A0pqHWKwBsSeyp2Ry4vXQT7b5vABi6QT6eg1uamkXGUfaQ==
X-Received: by 2002:a63:330e:: with SMTP id z14mr41045000pgz.4.1554915336804;
        Wed, 10 Apr 2019 09:55:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9e10:971c:f11c:a814])
        by smtp.gmail.com with ESMTPSA id k65sm77525737pfb.68.2019.04.10.09.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:55:36 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
X-Google-Original-From: Micah Morton
To:     jmorris@namei.org, keescook@chromium.org, casey@schaufler-ca.com,
        linux-security-module@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, Micah Morton <mortonm@chromium.org>
Subject: [PATCH 03/10] LSM: SafeSetID: refactor policy hash table
Date:   Wed, 10 Apr 2019 09:55:34 -0700
Message-Id: <20190410165534.210333-1-mortonm@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jann Horn <jannh@google.com>

parent_kuid and child_kuid are kuids, there is no reason to make them
uint64_t. (And anyway, in the kernel, the normal name for that would be
u64, not uint64_t.)

check_setuid_policy_hashtable_key() and
check_setuid_policy_hashtable_key_value() are basically the same thing,
merge them.

Also fix the comment that claimed that (1<<8)==128.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Micah Morton <mortonm@chromium.org>
---
 security/safesetid/lsm.c | 62 ++++++++++++----------------------------
 security/safesetid/lsm.h | 19 ++++++++++++
 2 files changed, 37 insertions(+), 44 deletions(-)

diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 5310fcf3052a..15cd13b5a211 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -14,67 +14,40 @@
 
 #define pr_fmt(fmt) "SafeSetID: " fmt
 
-#include <linux/hashtable.h>
 #include <linux/lsm_hooks.h>
 #include <linux/module.h>
 #include <linux/ptrace.h>
 #include <linux/sched/task_stack.h>
 #include <linux/security.h>
+#include "lsm.h"
 
 /* Flag indicating whether initialization completed */
 int safesetid_initialized;
 
-#define NUM_BITS 8 /* 128 buckets in hash table */
+#define NUM_BITS 8 /* 256 buckets in hash table */
 
 static DEFINE_HASHTABLE(safesetid_whitelist_hashtable, NUM_BITS);
 
-/*
- * Hash table entry to store safesetid policy signifying that 'parent' user
- * can setid to 'child' user.
- */
-struct entry {
-	struct hlist_node next;
-	struct hlist_node dlist; /* for deletion cleanup */
-	uint64_t parent_kuid;
-	uint64_t child_kuid;
-};
-
 static DEFINE_SPINLOCK(safesetid_whitelist_hashtable_spinlock);
 
-static bool check_setuid_policy_hashtable_key(kuid_t parent)
+static enum sid_policy_type setuid_policy_lookup(kuid_t src, kuid_t dst)
 {
 	struct entry *entry;
+	enum sid_policy_type result = SIDPOL_DEFAULT;
 
 	rcu_read_lock();
 	hash_for_each_possible_rcu(safesetid_whitelist_hashtable,
-				   entry, next, __kuid_val(parent)) {
-		if (entry->parent_kuid == __kuid_val(parent)) {
+				   entry, next, __kuid_val(src)) {
+		if (!uid_eq(entry->src_uid, src))
+			continue;
+		if (uid_eq(entry->dst_uid, dst)) {
 			rcu_read_unlock();
-			return true;
+			return SIDPOL_ALLOWED;
 		}
+		result = SIDPOL_CONSTRAINED;
 	}
 	rcu_read_unlock();
-
-	return false;
-}
-
-static bool check_setuid_policy_hashtable_key_value(kuid_t parent,
-						    kuid_t child)
-{
-	struct entry *entry;
-
-	rcu_read_lock();
-	hash_for_each_possible_rcu(safesetid_whitelist_hashtable,
-				   entry, next, __kuid_val(parent)) {
-		if (entry->parent_kuid == __kuid_val(parent) &&
-		    entry->child_kuid == __kuid_val(child)) {
-			rcu_read_unlock();
-			return true;
-		}
-	}
-	rcu_read_unlock();
-
-	return false;
+	return result;
 }
 
 static int safesetid_security_capable(const struct cred *cred,
@@ -83,7 +56,7 @@ static int safesetid_security_capable(const struct cred *cred,
 				      unsigned int opts)
 {
 	if (cap == CAP_SETUID &&
-	    check_setuid_policy_hashtable_key(cred->uid)) {
+	    setuid_policy_lookup(cred->uid, INVALID_UID) != SIDPOL_DEFAULT) {
 		if (!(opts & CAP_OPT_INSETID)) {
 			/*
 			 * Deny if we're not in a set*uid() syscall to avoid
@@ -116,7 +89,8 @@ static bool uid_permitted_for_cred(const struct cred *old, kuid_t new_uid)
 	 * Transitions to new UIDs require a check against the policy of the old
 	 * RUID.
 	 */
-	permitted = check_setuid_policy_hashtable_key_value(old->uid, new_uid);
+	permitted =
+	    setuid_policy_lookup(old->uid, new_uid) != SIDPOL_CONSTRAINED;
 	if (!permitted) {
 		pr_warn("UID transition ((%d,%d,%d) -> %d) blocked\n",
 			__kuid_val(old->uid), __kuid_val(old->euid),
@@ -136,7 +110,7 @@ static int safesetid_task_fix_setuid(struct cred *new,
 {
 
 	/* Do nothing if there are no setuid restrictions for our old RUID. */
-	if (!check_setuid_policy_hashtable_key(old->uid))
+	if (setuid_policy_lookup(old->uid, INVALID_UID) == SIDPOL_DEFAULT)
 		return 0;
 
 	if (uid_permitted_for_cred(old, new->uid) &&
@@ -159,14 +133,14 @@ int add_safesetid_whitelist_entry(kuid_t parent, kuid_t child)
 	struct entry *new;
 
 	/* Return if entry already exists */
-	if (check_setuid_policy_hashtable_key_value(parent, child))
+	if (setuid_policy_lookup(parent, child) == SIDPOL_ALLOWED)
 		return 0;
 
 	new = kzalloc(sizeof(struct entry), GFP_KERNEL);
 	if (!new)
 		return -ENOMEM;
-	new->parent_kuid = __kuid_val(parent);
-	new->child_kuid = __kuid_val(child);
+	new->src_uid = parent;
+	new->dst_uid = child;
 	spin_lock(&safesetid_whitelist_hashtable_spinlock);
 	hash_add_rcu(safesetid_whitelist_hashtable,
 		     &new->next,
diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
index c1ea3c265fcf..6806f902794c 100644
--- a/security/safesetid/lsm.h
+++ b/security/safesetid/lsm.h
@@ -15,6 +15,8 @@
 #define _SAFESETID_H
 
 #include <linux/types.h>
+#include <linux/uidgid.h>
+#include <linux/hashtable.h>
 
 /* Flag indicating whether initialization completed */
 extern int safesetid_initialized;
@@ -25,6 +27,23 @@ enum safesetid_whitelist_file_write_type {
 	SAFESETID_WHITELIST_FLUSH, /* Flush whitelist policies. */
 };
 
+enum sid_policy_type {
+	SIDPOL_DEFAULT, /* source ID is unaffected by policy */
+	SIDPOL_CONSTRAINED, /* source ID is affected by policy */
+	SIDPOL_ALLOWED /* target ID explicitly allowed */
+};
+
+/*
+ * Hash table entry to store safesetid policy signifying that 'src_uid'
+ * can setid to 'dst_uid'.
+ */
+struct entry {
+	struct hlist_node next;
+	struct hlist_node dlist; /* for deletion cleanup */
+	kuid_t src_uid;
+	kuid_t dst_uid;
+};
+
 /* Add entry to safesetid whitelist to allow 'parent' to setid to 'child'. */
 int add_safesetid_whitelist_entry(kuid_t parent, kuid_t child);
 
-- 
2.21.0.392.gf8f6787159e-goog

