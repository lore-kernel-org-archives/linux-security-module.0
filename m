Return-Path: <SRS0=XQ6M=AY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FFAC433E2
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Jul 2020 19:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F6DD206F5
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Jul 2020 19:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCBKo8qQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgGMTwp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:52:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56148 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726803AbgGMTwn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Jul 2020 15:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594669960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=2U0i5nBFMJiaMmbYrmw4au0EuiB1Fhw+RBqWeEaSfro=;
        b=GCBKo8qQkR5VuaK5Lig1jwSMpFDtTgnhjPGew0xYt/UKfa1NqitsARbpQx/qgLND+/zNqj
        yYitfHyjyc8B6BA0f4rvOILl5XEFHBr52xe0vIIlUo1QArqAuKVYWn4JM+d2uoo44LKNX3
        jlfKOlirzeGCs3Zz9Ki24Yfpeg+WT6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-dOYZTyswOnSXKP1jiT5A5g-1; Mon, 13 Jul 2020 15:52:33 -0400
X-MC-Unique: dOYZTyswOnSXKP1jiT5A5g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A2951086;
        Mon, 13 Jul 2020 19:52:31 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7A36710A1;
        Mon, 13 Jul 2020 19:52:23 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>, eparis@parisplace.org,
        john.johansen@canonical.com, Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak84 v4] audit: purge audit_log_string from the intra-kernel audit API
Date:   Mon, 13 Jul 2020 15:51:59 -0400
Message-Id: <6effbbd4574407d6af21162e57d9102d5f8b02ed.1594664015.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

audit_log_string() was inteded to be an internal audit function and
since there are only two internal uses, remove them.  Purge all external
uses of it by restructuring code to use an existing audit_log_format()
or using audit_log_format().

Please see the upstream issue
https://github.com/linux-audit/audit-kernel/issues/84

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
Passes audit-testsuite.

Changelog:
v4
- use double quotes in all replaced audit_log_string() calls

v3
- fix two warning: non-void function does not return a value in all control paths
	Reported-by: kernel test robot <lkp@intel.com>

v2
- restructure to piggyback on existing audit_log_format() calls, checking quoting needs for each.

v1 Vlad Dronov
- https://github.com/nefigtut/audit-kernel/commit/dbbcba46335a002f44b05874153a85b9cc18aebf

 include/linux/audit.h     |  5 -----
 kernel/audit.c            |  4 ++--
 security/apparmor/audit.c | 10 ++++------
 security/apparmor/file.c  | 25 +++++++------------------
 security/apparmor/ipc.c   | 46 +++++++++++++++++++++++-----------------------
 security/apparmor/net.c   | 14 ++++++++------
 security/lsm_audit.c      |  4 ++--
 7 files changed, 46 insertions(+), 62 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 523f77494847..b3d859831a31 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -694,9 +694,4 @@ static inline bool audit_loginuid_set(struct task_struct *tsk)
 	return uid_valid(audit_get_loginuid(tsk));
 }
 
-static inline void audit_log_string(struct audit_buffer *ab, const char *buf)
-{
-	audit_log_n_string(ab, buf, strlen(buf));
-}
-
 #endif
diff --git a/kernel/audit.c b/kernel/audit.c
index 8c201f414226..a2f3e34aa724 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2080,13 +2080,13 @@ void audit_log_d_path(struct audit_buffer *ab, const char *prefix,
 	/* We will allow 11 spaces for ' (deleted)' to be appended */
 	pathname = kmalloc(PATH_MAX+11, ab->gfp_mask);
 	if (!pathname) {
-		audit_log_string(ab, "<no_memory>");
+		audit_log_format(ab, "\"<no_memory>\"");
 		return;
 	}
 	p = d_path(path, pathname, PATH_MAX+11);
 	if (IS_ERR(p)) { /* Should never happen since we send PATH_MAX */
 		/* FIXME: can we save some information here? */
-		audit_log_string(ab, "<too_long>");
+		audit_log_format(ab, "\"<too_long>\"");
 	} else
 		audit_log_untrustedstring(ab, p);
 	kfree(pathname);
diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
index 597732503815..f7e97c7e80f3 100644
--- a/security/apparmor/audit.c
+++ b/security/apparmor/audit.c
@@ -57,18 +57,16 @@ static void audit_pre(struct audit_buffer *ab, void *ca)
 	struct common_audit_data *sa = ca;
 
 	if (aa_g_audit_header) {
-		audit_log_format(ab, "apparmor=");
-		audit_log_string(ab, aa_audit_type[aad(sa)->type]);
+		audit_log_format(ab, "apparmor=\"%s\"",
+				 aa_audit_type[aad(sa)->type]);
 	}
 
 	if (aad(sa)->op) {
-		audit_log_format(ab, " operation=");
-		audit_log_string(ab, aad(sa)->op);
+		audit_log_format(ab, " operation=\"%s\"", aad(sa)->op);
 	}
 
 	if (aad(sa)->info) {
-		audit_log_format(ab, " info=");
-		audit_log_string(ab, aad(sa)->info);
+		audit_log_format(ab, " info=\"%s\"", aad(sa)->info);
 		if (aad(sa)->error)
 			audit_log_format(ab, " error=%d", aad(sa)->error);
 	}
diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index 9a2d14b7c9f8..92acf9a49405 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -35,20 +35,6 @@ static u32 map_mask_to_chr_mask(u32 mask)
 }
 
 /**
- * audit_file_mask - convert mask to permission string
- * @buffer: buffer to write string to (NOT NULL)
- * @mask: permission mask to convert
- */
-static void audit_file_mask(struct audit_buffer *ab, u32 mask)
-{
-	char str[10];
-
-	aa_perm_mask_to_str(str, sizeof(str), aa_file_perm_chrs,
-			    map_mask_to_chr_mask(mask));
-	audit_log_string(ab, str);
-}
-
-/**
  * file_audit_cb - call back for file specific audit fields
  * @ab: audit_buffer  (NOT NULL)
  * @va: audit struct to audit values of  (NOT NULL)
@@ -57,14 +43,17 @@ static void file_audit_cb(struct audit_buffer *ab, void *va)
 {
 	struct common_audit_data *sa = va;
 	kuid_t fsuid = current_fsuid();
+	char str[10];
 
 	if (aad(sa)->request & AA_AUDIT_FILE_MASK) {
-		audit_log_format(ab, " requested_mask=");
-		audit_file_mask(ab, aad(sa)->request);
+		aa_perm_mask_to_str(str, sizeof(str), aa_file_perm_chrs,
+				    map_mask_to_chr_mask(aad(sa)->request));
+		audit_log_format(ab, " requested_mask=\"%s\"", str);
 	}
 	if (aad(sa)->denied & AA_AUDIT_FILE_MASK) {
-		audit_log_format(ab, " denied_mask=");
-		audit_file_mask(ab, aad(sa)->denied);
+		aa_perm_mask_to_str(str, sizeof(str), aa_file_perm_chrs,
+				    map_mask_to_chr_mask(aad(sa)->denied));
+		audit_log_format(ab, " denied_mask=\"%s\"", str);
 	}
 	if (aad(sa)->request & AA_AUDIT_FILE_MASK) {
 		audit_log_format(ab, " fsuid=%d",
diff --git a/security/apparmor/ipc.c b/security/apparmor/ipc.c
index 4ecedffbdd33..fe36d112aad9 100644
--- a/security/apparmor/ipc.c
+++ b/security/apparmor/ipc.c
@@ -20,25 +20,23 @@
 
 /**
  * audit_ptrace_mask - convert mask to permission string
- * @buffer: buffer to write string to (NOT NULL)
  * @mask: permission mask to convert
+ *
+ * Returns: pointer to static string
  */
-static void audit_ptrace_mask(struct audit_buffer *ab, u32 mask)
+static const char *audit_ptrace_mask(u32 mask)
 {
 	switch (mask) {
 	case MAY_READ:
-		audit_log_string(ab, "read");
-		break;
+		return "read";
 	case MAY_WRITE:
-		audit_log_string(ab, "trace");
-		break;
+		return "trace";
 	case AA_MAY_BE_READ:
-		audit_log_string(ab, "readby");
-		break;
+		return "readby";
 	case AA_MAY_BE_TRACED:
-		audit_log_string(ab, "tracedby");
-		break;
+		return "tracedby";
 	}
+	return "";
 }
 
 /* call back to audit ptrace fields */
@@ -47,12 +45,12 @@ static void audit_ptrace_cb(struct audit_buffer *ab, void *va)
 	struct common_audit_data *sa = va;
 
 	if (aad(sa)->request & AA_PTRACE_PERM_MASK) {
-		audit_log_format(ab, " requested_mask=");
-		audit_ptrace_mask(ab, aad(sa)->request);
+		audit_log_format(ab, " requested_mask=\"%s\"",
+				 audit_ptrace_mask(aad(sa)->request));
 
 		if (aad(sa)->denied & AA_PTRACE_PERM_MASK) {
-			audit_log_format(ab, " denied_mask=");
-			audit_ptrace_mask(ab, aad(sa)->denied);
+			audit_log_format(ab, " denied_mask=\"%s\"",
+					 audit_ptrace_mask(aad(sa)->denied));
 		}
 	}
 	audit_log_format(ab, " peer=");
@@ -142,16 +140,18 @@ static inline int map_signal_num(int sig)
 }
 
 /**
- * audit_file_mask - convert mask to permission string
- * @buffer: buffer to write string to (NOT NULL)
+ * audit_signal_mask - convert mask to permission string
  * @mask: permission mask to convert
+ *
+ * Returns: pointer to static string
  */
-static void audit_signal_mask(struct audit_buffer *ab, u32 mask)
+static const char *audit_signal_mask(u32 mask)
 {
 	if (mask & MAY_READ)
-		audit_log_string(ab, "receive");
+		return "receive";
 	if (mask & MAY_WRITE)
-		audit_log_string(ab, "send");
+		return "send";
+	return "";
 }
 
 /**
@@ -164,11 +164,11 @@ static void audit_signal_cb(struct audit_buffer *ab, void *va)
 	struct common_audit_data *sa = va;
 
 	if (aad(sa)->request & AA_SIGNAL_PERM_MASK) {
-		audit_log_format(ab, " requested_mask=");
-		audit_signal_mask(ab, aad(sa)->request);
+		audit_log_format(ab, " requested_mask=\"%s\"",
+				 audit_signal_mask(aad(sa)->request));
 		if (aad(sa)->denied & AA_SIGNAL_PERM_MASK) {
-			audit_log_format(ab, " denied_mask=");
-			audit_signal_mask(ab, aad(sa)->denied);
+			audit_log_format(ab, " denied_mask=\"%s\"",
+					 audit_signal_mask(aad(sa)->denied));
 		}
 	}
 	if (aad(sa)->signal == SIGUNKNOWN)
diff --git a/security/apparmor/net.c b/security/apparmor/net.c
index d8afc39f663a..fa0e85568450 100644
--- a/security/apparmor/net.c
+++ b/security/apparmor/net.c
@@ -72,16 +72,18 @@ void audit_net_cb(struct audit_buffer *ab, void *va)
 {
 	struct common_audit_data *sa = va;
 
-	audit_log_format(ab, " family=");
 	if (address_family_names[sa->u.net->family])
-		audit_log_string(ab, address_family_names[sa->u.net->family]);
+		audit_log_format(ab, " family=\"%s\"",
+				 address_family_names[sa->u.net->family]);
 	else
-		audit_log_format(ab, "\"unknown(%d)\"", sa->u.net->family);
-	audit_log_format(ab, " sock_type=");
+		audit_log_format(ab, " family=\"unknown(%d)\"",
+				 sa->u.net->family);
 	if (sock_type_names[aad(sa)->net.type])
-		audit_log_string(ab, sock_type_names[aad(sa)->net.type]);
+		audit_log_format(ab, " sock_type=\"%s\"",
+				 sock_type_names[aad(sa)->net.type]);
 	else
-		audit_log_format(ab, "\"unknown(%d)\"", aad(sa)->net.type);
+		audit_log_format(ab, " sock_type=\"unknown(%d)\"",
+				 aad(sa)->net.type);
 	audit_log_format(ab, " protocol=%d", aad(sa)->net.protocol);
 
 	if (aad(sa)->request & NET_PERMS_MASK) {
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 7c555621c2bd..53d0d183db8f 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -432,8 +432,8 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 				 a->u.ibendport->port);
 		break;
 	case LSM_AUDIT_DATA_LOCKDOWN:
-		audit_log_format(ab, " lockdown_reason=");
-		audit_log_string(ab, lockdown_reasons[a->u.reason]);
+		audit_log_format(ab, " lockdown_reason=\"%s\"",
+				 lockdown_reasons[a->u.reason]);
 		break;
 	} /* switch (a->type) */
 }
-- 
1.8.3.1

