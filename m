Return-Path: <SRS0=1tMQ=5S=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1446C43331
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Apr 2020 14:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27B4206F5
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Apr 2020 14:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7OC864X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387592AbgDBOOH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:14:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43496 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729213AbgDBOOH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Apr 2020 10:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585836845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6nCWsAOSv7XHTWMgOr7TR0iBoCbpPuN1i913e5SrGzo=;
        b=R7OC864Xtduwx34IQPnKqaU0WhSTQUoPDflMbE3LmqCoB6jPdM0U4QcFCUScl2wOE9lFhX
        cE0RLfPXvg+RnkxfzugoF11ca0EccmKvyNx1yEJgz6KoUMiXsqjUtYKq3iJ8uvAq0Meyf7
        WiF/m26qgtG4FRpZxXLXkXYjUsh5fZo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-lZTpThyjNoKYa8RHESMVTw-1; Thu, 02 Apr 2020 10:14:00 -0400
X-MC-Unique: lZTpThyjNoKYa8RHESMVTw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5ED828024D0;
        Thu,  2 Apr 2020 14:13:59 +0000 (UTC)
Received: from rules.brq.redhat.com (unknown [10.40.193.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 135CC1001B2D;
        Thu,  2 Apr 2020 14:13:31 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        linux-audit@redhat.com, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH ghak96] audit: set cwd in audit context for file-related LSM audit records
Date:   Thu,  2 Apr 2020 16:13:19 +0200
Message-Id: <20200402141319.28714-1-vdronov@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Set a current working directory in an audit context for the following rec=
ord
types in dump_common_audit_data(): LSM_AUDIT_DATA_PATH, LSM_AUDIT_DATA_FI=
LE,
LSM_AUDIT_DATA_IOCTL_OP, LSM_AUDIT_DATA_DENTRY, LSM_AUDIT_DATA_INODE so a
separate CWD record is emitted later.

Link: https://github.com/linux-audit/audit-kernel/issues/96
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
out-of-commit-message-note:

Hello,
Honestly, I'm not sure about "if (!context->in_syscall)" check in
__audit_getcwd(). It was copied from __audit_getname() and I do
not quite understand why it is there and if __audit_getcwd() needs
it. If you have an idea on this, could you please, tell?

 include/linux/audit.h |  9 ++++++++-
 kernel/auditsc.c      | 17 +++++++++++++++++
 security/lsm_audit.c  |  5 +++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index f9ceae57ca8d..b4306abc5891 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -268,7 +268,7 @@ extern void __audit_syscall_entry(int major, unsigned=
 long a0, unsigned long a1,
 extern void __audit_syscall_exit(int ret_success, long ret_value);
 extern struct filename *__audit_reusename(const __user char *uptr);
 extern void __audit_getname(struct filename *name);
-
+extern void __audit_getcwd(void);
 extern void __audit_inode(struct filename *name, const struct dentry *de=
ntry,
 				unsigned int flags);
 extern void __audit_file(const struct file *);
@@ -327,6 +327,11 @@ static inline void audit_getname(struct filename *na=
me)
 	if (unlikely(!audit_dummy_context()))
 		__audit_getname(name);
 }
+static inline void audit_getcwd(void)
+{
+	if (unlikely(!audit_dummy_context()))
+		__audit_getcwd();
+}
 static inline void audit_inode(struct filename *name,
 				const struct dentry *dentry,
 				unsigned int aflags) {
@@ -545,6 +550,8 @@ static inline struct filename *audit_reusename(const =
__user char *name)
 }
 static inline void audit_getname(struct filename *name)
 { }
+static inline void audit_getcwd(void)
+{ }
 static inline void __audit_inode(struct filename *name,
 					const struct dentry *dentry,
 					unsigned int flags)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 814406a35db1..16316032ef9f 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1890,6 +1890,23 @@ void __audit_getname(struct filename *name)
 		get_fs_pwd(current->fs, &context->pwd);
 }
=20
+/**
+ * __audit_getcwd - set a current working directory
+ *
+ * Set a current working directory of an audited process for this contex=
t.
+ * Called from security/lsm_audit.c:dump_common_audit_data().
+ */
+void __audit_getcwd(void)
+{
+	struct audit_context *context =3D audit_context();
+
+	if (!context->in_syscall)
+		return;
+
+	if (!context->pwd.dentry)
+		get_fs_pwd(current->fs, &context->pwd);
+}
+
 static inline int audit_copy_fcaps(struct audit_names *name,
 				   const struct dentry *dentry)
 {
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 2d2bf49016f4..7c555621c2bd 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -241,6 +241,7 @@ static void dump_common_audit_data(struct audit_buffe=
r *ab,
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
 			audit_log_format(ab, " ino=3D%lu", inode->i_ino);
 		}
+		audit_getcwd();
 		break;
 	}
 	case LSM_AUDIT_DATA_FILE: {
@@ -254,6 +255,7 @@ static void dump_common_audit_data(struct audit_buffe=
r *ab,
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
 			audit_log_format(ab, " ino=3D%lu", inode->i_ino);
 		}
+		audit_getcwd();
 		break;
 	}
 	case LSM_AUDIT_DATA_IOCTL_OP: {
@@ -269,6 +271,7 @@ static void dump_common_audit_data(struct audit_buffe=
r *ab,
 		}
=20
 		audit_log_format(ab, " ioctlcmd=3D0x%hx", a->u.op->cmd);
+		audit_getcwd();
 		break;
 	}
 	case LSM_AUDIT_DATA_DENTRY: {
@@ -283,6 +286,7 @@ static void dump_common_audit_data(struct audit_buffe=
r *ab,
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
 			audit_log_format(ab, " ino=3D%lu", inode->i_ino);
 		}
+		audit_getcwd();
 		break;
 	}
 	case LSM_AUDIT_DATA_INODE: {
@@ -300,6 +304,7 @@ static void dump_common_audit_data(struct audit_buffe=
r *ab,
 		audit_log_format(ab, " dev=3D");
 		audit_log_untrustedstring(ab, inode->i_sb->s_id);
 		audit_log_format(ab, " ino=3D%lu", inode->i_ino);
+		audit_getcwd();
 		break;
 	}
 	case LSM_AUDIT_DATA_TASK: {
--=20
2.20.1

