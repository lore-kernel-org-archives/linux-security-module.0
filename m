Return-Path: <SRS0=OzCb=CT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6D9C43461
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Sep 2020 19:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 421CC21D92
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Sep 2020 19:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayHty/H8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgIJTvV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:51:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52697 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731235AbgIJPEW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 Sep 2020 11:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599750234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=c93RPNenWSa8Q8zrhsnxgdtparF1pzVAsKmNQNMwnlE=;
        b=ayHty/H869bUyNDDHGsAdH5tQGUf2LYCsthgC23JZczuxYzK8ei6XoMyu5HxICXWH1ACeW
        E9riwKYBLzPxwEHKBE88seOm7eErWEIC+jM3Bz6YqmbtetTdk0CQcocfiDSsRVrWmtmvCY
        BDrNODOBs4TFLgTFoThXtXbcAphAcw0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-F9eqrIHzNAKH37HHqBySfg-1; Thu, 10 Sep 2020 11:03:44 -0400
X-MC-Unique: F9eqrIHzNAKH37HHqBySfg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1859488EF2E;
        Thu, 10 Sep 2020 15:02:41 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CA3719C66;
        Thu, 10 Sep 2020 15:02:38 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [[PATCH V4]] audit: trigger accompanying records when no rules present
Date:   Thu, 10 Sep 2020 11:01:54 -0400
Message-Id: <35f2b8c69b4b9abbc076dd55a6f0f52cf20abad7.1599687447.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

When there are no audit rules registered, mandatory records (config,
etc.) are missing their accompanying records (syscall, proctitle, etc.).

This is due to audit context dummy set on syscall entry based on absence
of rules that signals that no other records are to be printed.

Clear the dummy bit if any record is generated.

The proctitle context and dummy checks are pointless since the
proctitle record will not be printed if no syscall records are printed.

The fds array is reset to -1 after the first syscall to indicate it
isn't valid any more, but was never set to -1 when the context was
allocated to indicate it wasn't yet valid.

The audit_inode* functions can be called without going through
getname_flags() or getname_kernel() that sets audit_names and cwd, so
set the cwd if it has not already been done so due to audit_names being
valid.

The LSM dump_common_audit_data() LSM_AUDIT_DATA_NET:AF_UNIX case was
missed with the ghak96 patch, so add that case here.

Thanks to bauen1 <j2468h@googlemail.com> for reporting LSM situations in
which context->cwd is not valid, inadvertantly fixed by the ghak96 patch.

Please see upstream github issue
https://github.com/linux-audit/audit-kernel/issues/120
This is also related to upstream github issue
https://github.com/linux-audit/audit-kernel/issues/96

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
Passes audit-testsuite.

Chagelog:
v4:
- rebase on audit/next v5.9-rc1
- squash v2+v3fix
- add pwd NULL check in audit_log_name()
- resubmit after revert

v3:
- initialize fds[0] to -1
- init cwd for ghak96 LSM_AUDIT_DATA_NET:AF_UNIX case
- init cwd for audit_inode{,_child}

v2:
- unconditionally clear dummy
- create audit_clear_dummy accessor function
- remove proctitle context and dummy checks

 kernel/audit.c       |  1 +
 kernel/audit.h       |  8 ++++++++
 kernel/auditsc.c     | 11 +++++++----
 security/lsm_audit.c |  1 +
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 68cee3bc8cfe..8604eccb348f 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1865,6 +1865,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 	}
 
 	audit_get_stamp(ab->ctx, &t, &serial);
+	audit_clear_dummy(ab->ctx);
 	audit_log_format(ab, "audit(%llu.%03lu:%u): ",
 			 (unsigned long long)t.tv_sec, t.tv_nsec/1000000, serial);
 
diff --git a/kernel/audit.h b/kernel/audit.h
index 3b9c0945225a..abcfef58435b 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -290,6 +290,13 @@ extern int audit_signal_info_syscall(struct task_struct *t);
 extern void audit_filter_inodes(struct task_struct *tsk,
 				struct audit_context *ctx);
 extern struct list_head *audit_killed_trees(void);
+
+static inline void audit_clear_dummy(struct audit_context *ctx)
+{
+	if (ctx)
+		ctx->dummy = 0;
+}
+
 #else /* CONFIG_AUDITSYSCALL */
 #define auditsc_get_stamp(c, t, s) 0
 #define audit_put_watch(w) {}
@@ -323,6 +330,7 @@ static inline int audit_signal_info_syscall(struct task_struct *t)
 }
 
 #define audit_filter_inodes(t, c) AUDIT_DISABLED
+#define audit_clear_dummy(c) {}
 #endif /* CONFIG_AUDITSYSCALL */
 
 extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 8dba8f0983b5..9d2de93f40b3 100644
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
+			if (&context->pwd)
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
@@ -2079,6 +2080,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
 	}
 	handle_path(dentry);
 	audit_copy_inode(n, dentry, inode, flags & AUDIT_INODE_NOEVAL);
+	_audit_getcwd(context);
 }
 
 void __audit_file(const struct file *file)
@@ -2197,6 +2199,7 @@ void __audit_inode_child(struct inode *parent,
 		audit_copy_inode(found_child, dentry, inode, 0);
 	else
 		found_child->ino = AUDIT_INO_UNSET;
+	_audit_getcwd(context);
 }
 EXPORT_SYMBOL_GPL(__audit_inode_child);
 
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 53d0d183db8f..e93077612246 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -369,6 +369,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 					audit_log_untrustedstring(ab, p);
 				else
 					audit_log_n_hex(ab, p, len);
+				audit_getcwd();
 				break;
 			}
 		}
-- 
2.18.4

