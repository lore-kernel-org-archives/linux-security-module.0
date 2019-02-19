Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB118C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9276121738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbfBSQap (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:30:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729120AbfBSQao (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:30:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 488E081DEE;
        Tue, 19 Feb 2019 16:30:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76B4B60FD8;
        Tue, 19 Feb 2019 16:30:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 17/43] selinux: Implement the new mount API LSM hooks
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:30:41 +0000
Message-ID: <155059384161.12449.17357084420263811610.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 19 Feb 2019 16:30:44 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Implement the new mount API LSM hooks for SELinux.  At some point the old
hooks will need to be removed.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paul Moore <paul@paul-moore.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov
cc: linux-security-module@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 security/selinux/hooks.c            |   49 +++++++++++++++++++++++++++++++----
 security/selinux/include/security.h |   10 ++++---
 2 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f0e36c3492ba..f99381e97d73 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -48,6 +48,8 @@
 #include <linux/fdtable.h>
 #include <linux/namei.h>
 #include <linux/mount.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv6.h>
 #include <linux/tty.h>
@@ -454,11 +456,11 @@ static inline int inode_doinit(struct inode *inode)
 
 enum {
 	Opt_error = -1,
-	Opt_context = 1,
+	Opt_context = 0,
+	Opt_defcontext = 1,
 	Opt_fscontext = 2,
-	Opt_defcontext = 3,
-	Opt_rootcontext = 4,
-	Opt_seclabel = 5,
+	Opt_rootcontext = 3,
+	Opt_seclabel = 4,
 };
 
 #define A(s, has_arg) {#s, sizeof(#s) - 1, Opt_##s, has_arg}
@@ -1089,6 +1091,7 @@ static int show_sid(struct seq_file *m, u32 sid)
 	if (!rc) {
 		bool has_comma = context && strchr(context, ',');
 
+		seq_putc(m, '=');
 		if (has_comma)
 			seq_putc(m, '\"');
 		seq_escape(m, context, "\"\n\\");
@@ -1142,7 +1145,7 @@ static int selinux_sb_show_options(struct seq_file *m, struct super_block *sb)
 	}
 	if (sbsec->flags & SBLABEL_MNT) {
 		seq_putc(m, ',');
-		seq_puts(m, LABELSUPP_STR);
+		seq_puts(m, SECLABEL_STR);
 	}
 	return 0;
 }
@@ -2761,6 +2764,38 @@ static int selinux_umount(struct vfsmount *mnt, int flags)
 				   FILESYSTEM__UNMOUNT, NULL);
 }
 
+static const struct fs_parameter_spec selinux_param_specs[] = {
+	fsparam_string(CONTEXT_STR,	Opt_context),
+	fsparam_string(DEFCONTEXT_STR,	Opt_defcontext),
+	fsparam_string(FSCONTEXT_STR,	Opt_fscontext),
+	fsparam_string(ROOTCONTEXT_STR,	Opt_rootcontext),
+	fsparam_flag  (SECLABEL_STR,	Opt_seclabel),
+	{}
+};
+
+static const struct fs_parameter_description selinux_fs_parameters = {
+	.name		= "SELinux",
+	.specs		= selinux_param_specs,
+};
+
+static int selinux_fs_context_parse_param(struct fs_context *fc,
+					  struct fs_parameter *param)
+{
+	struct fs_parse_result result;
+	int opt, rc;
+
+	opt = fs_parse(fc, &selinux_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	rc = selinux_add_opt(opt, param->string, &fc->security);
+	if (!rc) {
+		param->string = NULL;
+		rc = 1;
+	}
+	return rc;
+}
+
 /* inode security operations */
 
 static int selinux_inode_alloc_security(struct inode *inode)
@@ -6710,6 +6745,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(bprm_committing_creds, selinux_bprm_committing_creds),
 	LSM_HOOK_INIT(bprm_committed_creds, selinux_bprm_committed_creds),
 
+	LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
+
 	LSM_HOOK_INIT(sb_alloc_security, selinux_sb_alloc_security),
 	LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
 	LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
@@ -6978,6 +7015,8 @@ static __init int selinux_init(void)
 	else
 		pr_debug("SELinux:  Starting in permissive mode\n");
 
+	fs_validate_description(&selinux_fs_parameters);
+
 	return 0;
 }
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index ba8eedf42b90..529d8941c9c5 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -59,11 +59,11 @@
 #define SE_SBPROC		0x0200
 #define SE_SBGENFS		0x0400
 
-#define CONTEXT_STR	"context="
-#define FSCONTEXT_STR	"fscontext="
-#define ROOTCONTEXT_STR	"rootcontext="
-#define DEFCONTEXT_STR	"defcontext="
-#define LABELSUPP_STR "seclabel"
+#define CONTEXT_STR	"context"
+#define FSCONTEXT_STR	"fscontext"
+#define ROOTCONTEXT_STR	"rootcontext"
+#define DEFCONTEXT_STR	"defcontext"
+#define SECLABEL_STR "seclabel"
 
 struct netlbl_lsm_secattr;
 

