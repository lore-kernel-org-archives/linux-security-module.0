Return-Path: <SRS0=/Sjk=AO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082A9C433E0
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Jul 2020 16:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0B17208C7
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Jul 2020 16:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGRsolbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgGCQ4y (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 3 Jul 2020 12:56:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59648 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726147AbgGCQ4y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 Jul 2020 12:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593795412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=A17YU0TJdMJJbx+XyJzyM20ucRgGb0iLLQw+LKi/Iwk=;
        b=WGRsolbXnK60u85Ixg/WdzcfJGT2+u04gQ+O0w8cxCHpGp9pGisIE8KfkGi215Vhlu4Y9w
        yxuo93cflo/bPznYYhDpZxh0hqnSUbLI+Nv4tZwyXaT+atxvQGn+DedObmbhLy9Y1cV6Xy
        NIolLY9l04wAa6HkInsOT5SOE55NEd4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-_RIuiWmDMA-qU_6Iq1eapA-1; Fri, 03 Jul 2020 12:56:48 -0400
X-MC-Unique: _RIuiWmDMA-qU_6Iq1eapA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AAF656B9B;
        Fri,  3 Jul 2020 16:56:47 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C05310013D9;
        Fri,  3 Jul 2020 16:56:44 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>, eparis@parisplace.org,
        john.johansen@canonical.com, Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak96 v3] audit: issue CWD record to accompany LSM_AUDIT_DATA_* records
Date:   Fri,  3 Jul 2020 12:56:19 -0400
Message-Id: <878ac79163e31142963f1cd4f743599c35b6754a.1593691408.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The LSM_AUDIT_DATA_* records for PATH, FILE, IOCTL_OP, DENTRY and INODE
are incomplete without the task context of the AUDIT Current Working
Directory record.  Add it.

This record addition can't use audit_dummy_context to determine whether
or not to store the record information since the LSM_AUDIT_DATA_*
records are initiated by various LSMs independent of any audit rules.
context->in_syscall is used to determine if it was called in user
context like audit_getname.

Please see the upstream issue
https://github.com/linux-audit/audit-kernel/issues/96

Adapted from Vladis Dronov's v2 patch.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
Passes audit-testsuite.

Changelog:
v3
- adapt and refactor__audit_getname, don't key on dummy

v2
2020-04-02 vdronov https://www.redhat.com/archives/linux-audit/2020-April/msg00004.html
- convert to standalone CWD record

v1:
2020-03-24 vdronov https://github.com/nefigtut/audit-kernel/commit/df0b55b7ab84e1c9faa588b08e547e604bf25c87
- add cwd= field to LSM record

 include/linux/audit.h |  9 ++++++++-
 kernel/auditsc.c      | 17 +++++++++++++++--
 security/lsm_audit.c  |  5 +++++
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 03c4035a532b..bb850d588e1c 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -292,7 +292,7 @@ extern void __audit_syscall_entry(int major, unsigned long a0, unsigned long a1,
 extern void __audit_syscall_exit(int ret_success, long ret_value);
 extern struct filename *__audit_reusename(const __user char *uptr);
 extern void __audit_getname(struct filename *name);
-
+extern void __audit_getcwd(void);
 extern void __audit_inode(struct filename *name, const struct dentry *dentry,
 				unsigned int flags);
 extern void __audit_file(const struct file *);
@@ -351,6 +351,11 @@ static inline void audit_getname(struct filename *name)
 	if (unlikely(!audit_dummy_context()))
 		__audit_getname(name);
 }
+static inline void audit_getcwd(void)
+{
+	if (unlikely(audit_context()))
+		__audit_getcwd();
+}
 static inline void audit_inode(struct filename *name,
 				const struct dentry *dentry,
 				unsigned int aflags) {
@@ -579,6 +584,8 @@ static inline struct filename *audit_reusename(const __user char *name)
 }
 static inline void audit_getname(struct filename *name)
 { }
+static inline void audit_getcwd(void)
+{ }
 static inline void audit_inode(struct filename *name,
 				const struct dentry *dentry,
 				unsigned int aflags)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 3a9100e95fda..934ab5b8c1c5 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1891,6 +1891,20 @@ struct filename *
 	return NULL;
 }
 
+inline void _audit_getcwd(struct audit_context *context)
+{
+	if (!context->pwd.dentry)
+		get_fs_pwd(current->fs, &context->pwd);
+}
+
+void __audit_getcwd(void)
+{
+	struct audit_context *context = audit_context();
+
+	if (context->in_syscall)
+		_audit_getcwd(context);
+}
+
 /**
  * __audit_getname - add a name to the list
  * @name: name to add
@@ -1915,8 +1929,7 @@ void __audit_getname(struct filename *name)
 	name->aname = n;
 	name->refcnt++;
 
-	if (!context->pwd.dentry)
-		get_fs_pwd(current->fs, &context->pwd);
+	_audit_getcwd(context);
 }
 
 static inline int audit_copy_fcaps(struct audit_names *name,
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 2d2bf49016f4..7c555621c2bd 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -241,6 +241,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
 			audit_log_format(ab, " ino=%lu", inode->i_ino);
 		}
+		audit_getcwd();
 		break;
 	}
 	case LSM_AUDIT_DATA_FILE: {
@@ -254,6 +255,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
 			audit_log_format(ab, " ino=%lu", inode->i_ino);
 		}
+		audit_getcwd();
 		break;
 	}
 	case LSM_AUDIT_DATA_IOCTL_OP: {
@@ -269,6 +271,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		}
 
 		audit_log_format(ab, " ioctlcmd=0x%hx", a->u.op->cmd);
+		audit_getcwd();
 		break;
 	}
 	case LSM_AUDIT_DATA_DENTRY: {
@@ -283,6 +286,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
 			audit_log_format(ab, " ino=%lu", inode->i_ino);
 		}
+		audit_getcwd();
 		break;
 	}
 	case LSM_AUDIT_DATA_INODE: {
@@ -300,6 +304,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		audit_log_format(ab, " dev=");
 		audit_log_untrustedstring(ab, inode->i_sb->s_id);
 		audit_log_format(ab, " ino=%lu", inode->i_ino);
+		audit_getcwd();
 		break;
 	}
 	case LSM_AUDIT_DATA_TASK: {
-- 
1.8.3.1

