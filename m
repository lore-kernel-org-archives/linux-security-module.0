Return-Path: <SRS0=wc+g=C7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46911C2D0E2
	for <linux-security-module@archiver.kernel.org>; Tue, 22 Sep 2020 12:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6255206DC
	for <linux-security-module@archiver.kernel.org>; Tue, 22 Sep 2020 12:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPvSkLfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgIVMpa (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 22 Sep 2020 08:45:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36350 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726571AbgIVMp3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 22 Sep 2020 08:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600778727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=+Jv1Wo3uUQSIMwzegggWKyycsTQOaza4eSXUljZNlQE=;
        b=IPvSkLfyd+BKlmBhjnmwJ80oV/jWNTMLPTac4fVpAfJnSGUFXU0VmDpNPe74+s7k0DvpwE
        +UfIBH2uTcFinQ69KXwfHd5ZpNIvlP6jmlTtdmKXbfyV8fudXEaRlGFfo6Ughg+AqGkQDF
        KtbwrC3quexfbp0Bzr6VeFUGe9aGEug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-URCr8RkoMr6xq3tfDwsmQA-1; Tue, 22 Sep 2020 08:45:25 -0400
X-MC-Unique: URCr8RkoMr6xq3tfDwsmQA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E217809ACE;
        Tue, 22 Sep 2020 12:45:24 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5E4B19C4F;
        Tue, 22 Sep 2020 12:45:16 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak120 V5] audit: trigger accompanying records when no rules present
Date:   Tue, 22 Sep 2020 08:44:50 -0400
Message-Id: <7081a5b9c7d2e8085c49cec2fa72fcbb0b25e0d7.1600778472.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

When there are no audit rules registered, mandatory records (config,
etc.) are missing their accompanying records (syscall, proctitle, etc.).

This is due to audit context dummy set on syscall entry based on absence
of rules that signals that no other records are to be printed.  Clear the dummy
bit if any record is generated, open coding this in audit_log_start().

The proctitle context and dummy checks are pointless since the
proctitle record will not be printed if no syscall records are printed.

The fds array is reset to -1 after the first syscall to indicate it
isn't valid any more, but was never set to -1 when the context was
allocated to indicate it wasn't yet valid.

Check ctx->pwd in audit_log_name().

The audit_inode* functions can be called without going through
getname_flags() or getname_kernel() that sets audit_names and cwd, so
set the cwd in audit_alloc_name() if it has not already been done so due to
audit_names being valid and purge all other audit_getcwd() calls.

Revert the LSM dump_common_audit_data() LSM_AUDIT_DATA_* cases from the
ghak96 patch since they are no longer necessary due to cwd coverage in
audit_alloc_name().

Thanks to bauen1 <j2468h@googlemail.com> for reporting LSM situations in
which context->cwd is not valid, inadvertantly fixed by the ghak96 patch.

Please see upstream github issue
https://github.com/linux-audit/audit-kernel/issues/120
This is also related to upstream github issue
https://github.com/linux-audit/audit-kernel/issues/96

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
Chagelog:
v5:
- open code audit_clear_dummy() in audit_log_start()
- fix check for ctx->pwd in audit_log_name()
- open code _audit_getcwd() contents in audit_alloc_name()
- ditch all *audit_getcwd() calls

v4:
- resubmit after revert

v3:
- initialize fds[0] to -1
- init cwd for ghak96 LSM_AUDIT_DATA_NET:AF_UNIX case
- init cwd for audit_inode{,_child}

v2:
- unconditionally clear dummy
- create audit_clear_dummy accessor function
- remove proctitle context and dummy checks

 include/linux/audit.h |  8 --------
 kernel/audit.c        |  3 +++
 kernel/auditsc.c      | 27 +++++++--------------------
 security/lsm_audit.c  |  5 -----
 4 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index b3d859831a31..82b7c1116a85 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -292,7 +292,6 @@ extern void __audit_syscall_entry(int major, unsigned long a0, unsigned long a1,
 extern void __audit_syscall_exit(int ret_success, long ret_value);
 extern struct filename *__audit_reusename(const __user char *uptr);
 extern void __audit_getname(struct filename *name);
-extern void __audit_getcwd(void);
 extern void __audit_inode(struct filename *name, const struct dentry *dentry,
 				unsigned int flags);
 extern void __audit_file(const struct file *);
@@ -351,11 +350,6 @@ static inline void audit_getname(struct filename *name)
 	if (unlikely(!audit_dummy_context()))
 		__audit_getname(name);
 }
-static inline void audit_getcwd(void)
-{
-	if (unlikely(audit_context()))
-		__audit_getcwd();
-}
 static inline void audit_inode(struct filename *name,
 				const struct dentry *dentry,
 				unsigned int aflags) {
@@ -584,8 +578,6 @@ static inline struct filename *audit_reusename(const __user char *name)
 }
 static inline void audit_getname(struct filename *name)
 { }
-static inline void audit_getcwd(void)
-{ }
 static inline void audit_inode(struct filename *name,
 				const struct dentry *dentry,
 				unsigned int aflags)
diff --git a/kernel/audit.c b/kernel/audit.c
index 68cee3bc8cfe..dd9d22ba4fd2 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1865,6 +1865,9 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 	}
 
 	audit_get_stamp(ab->ctx, &t, &serial);
+	/* cancel dummy context to enable supporting records */
+	if (ctx)
+		ctx->dummy = 0;
 	audit_log_format(ab, "audit(%llu.%03lu:%u): ",
 			 (unsigned long long)t.tv_sec, t.tv_nsec/1000000, serial);
 
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 8dba8f0983b5..183d79cc2e12 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -929,6 +929,7 @@ static inline struct audit_context *audit_alloc_context(enum audit_state state)
 	context->prio = state == AUDIT_RECORD_CONTEXT ? ~0ULL : 0;
 	INIT_LIST_HEAD(&context->killed_trees);
 	INIT_LIST_HEAD(&context->names_list);
+	context->fds[0] = -1;
 	return context;
 }
 
@@ -1367,7 +1368,10 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 			/* name was specified as a relative path and the
 			 * directory component is the cwd
 			 */
-			audit_log_d_path(ab, " name=", &context->pwd);
+			if (context->pwd.dentry && context->pwd.mnt)
+				audit_log_d_path(ab, " name=", &context->pwd);
+			else
+				audit_log_format(ab, " name=(null)");
 			break;
 		default:
 			/* log the name's directory component */
@@ -1435,9 +1439,6 @@ static void audit_log_proctitle(void)
 	struct audit_context *context = audit_context();
 	struct audit_buffer *ab;
 
-	if (!context || context->dummy)
-		return;
-
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_PROCTITLE);
 	if (!ab)
 		return;	/* audit_panic or being filtered */
@@ -1866,6 +1867,8 @@ static struct audit_names *audit_alloc_name(struct audit_context *context,
 	list_add_tail(&aname->list, &context->names_list);
 
 	context->name_count++;
+	if (!context->pwd.dentry)
+		get_fs_pwd(current->fs, &context->pwd);
 	return aname;
 }
 
@@ -1894,20 +1897,6 @@ __audit_reusename(const __user char *uptr)
 	return NULL;
 }
 
-inline void _audit_getcwd(struct audit_context *context)
-{
-	if (!context->pwd.dentry)
-		get_fs_pwd(current->fs, &context->pwd);
-}
-
-void __audit_getcwd(void)
-{
-	struct audit_context *context = audit_context();
-
-	if (context->in_syscall)
-		_audit_getcwd(context);
-}
-
 /**
  * __audit_getname - add a name to the list
  * @name: name to add
@@ -1931,8 +1920,6 @@ void __audit_getname(struct filename *name)
 	n->name_len = AUDIT_NAME_FULL;
 	name->aname = n;
 	name->refcnt++;
-
-	_audit_getcwd(context);
 }
 
 static inline int audit_copy_fcaps(struct audit_names *name,
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 53d0d183db8f..221370794d14 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -241,7 +241,6 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
 			audit_log_format(ab, " ino=%lu", inode->i_ino);
 		}
-		audit_getcwd();
 		break;
 	}
 	case LSM_AUDIT_DATA_FILE: {
@@ -255,7 +254,6 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
 			audit_log_format(ab, " ino=%lu", inode->i_ino);
 		}
-		audit_getcwd();
 		break;
 	}
 	case LSM_AUDIT_DATA_IOCTL_OP: {
@@ -271,7 +269,6 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		}
 
 		audit_log_format(ab, " ioctlcmd=0x%hx", a->u.op->cmd);
-		audit_getcwd();
 		break;
 	}
 	case LSM_AUDIT_DATA_DENTRY: {
@@ -286,7 +283,6 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
 			audit_log_format(ab, " ino=%lu", inode->i_ino);
 		}
-		audit_getcwd();
 		break;
 	}
 	case LSM_AUDIT_DATA_INODE: {
@@ -304,7 +300,6 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		audit_log_format(ab, " dev=");
 		audit_log_untrustedstring(ab, inode->i_sb->s_id);
 		audit_log_format(ab, " ino=%lu", inode->i_ino);
-		audit_getcwd();
 		break;
 	}
 	case LSM_AUDIT_DATA_TASK: {
-- 
2.18.4

