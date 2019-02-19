Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8C3C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED07E21738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbfBSQaw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:30:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729120AbfBSQaw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:30:52 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B77A6804F2;
        Tue, 19 Feb 2019 16:30:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C1F1608C1;
        Tue, 19 Feb 2019 16:30:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 18/43] smack: Implement filesystem context security hooks
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:30:49 +0000
Message-ID: <155059384951.12449.6175507681481014891.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 19 Feb 2019 16:30:51 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Implement filesystem context security hooks for the smack LSM.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Casey Schaufler <casey@schaufler-ca.com>
cc: linux-security-module@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 security/smack/smack.h     |   19 +++++--------------
 security/smack/smack_lsm.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index f7db791fb566..0380a9c89d3b 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -195,22 +195,13 @@ struct smack_known_list_elem {
 
 enum {
 	Opt_error = -1,
-	Opt_fsdefault = 1,
-	Opt_fsfloor = 2,
-	Opt_fshat = 3,
-	Opt_fsroot = 4,
-	Opt_fstransmute = 5,
+	Opt_fsdefault = 0,
+	Opt_fsfloor = 1,
+	Opt_fshat = 2,
+	Opt_fsroot = 3,
+	Opt_fstransmute = 4,
 };
 
-/*
- * Mount options
- */
-#define SMK_FSDEFAULT	"smackfsdef="
-#define SMK_FSFLOOR	"smackfsfloor="
-#define SMK_FSHAT	"smackfshat="
-#define SMK_FSROOT	"smackfsroot="
-#define SMK_FSTRANS	"smackfstransmute="
-
 #define SMACK_DELETE_OPTION	"-DELETE"
 #define SMACK_CIPSO_OPTION 	"-CIPSO"
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 430d4f35e55c..5f93c4f84384 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -43,6 +43,8 @@
 #include <linux/shm.h>
 #include <linux/binfmts.h>
 #include <linux/parser.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include "smack.h"
 
 #define TRANS_TRUE	"TRUE"
@@ -541,7 +543,6 @@ static int smack_syslog(int typefrom_file)
 	return rc;
 }
 
-
 /*
  * Superblock Hooks.
  */
@@ -646,6 +647,44 @@ static int smack_add_opt(int token, const char *s, void **mnt_opts)
 	return -EINVAL;
 }
 
+static const struct fs_parameter_spec smack_param_specs[] = {
+	fsparam_string("fsdefault",	Opt_fsdefault),
+	fsparam_string("fsfloor",	Opt_fsfloor),
+	fsparam_string("fshat",		Opt_fshat),
+	fsparam_string("fsroot",	Opt_fsroot),
+	fsparam_string("fstransmute",	Opt_fstransmute),
+	{}
+};
+
+static const struct fs_parameter_description smack_fs_parameters = {
+	.name		= "smack",
+	.specs		= smack_param_specs,
+};
+
+/**
+ * smack_fs_context_parse_param - Parse a single mount parameter
+ * @fc: The new filesystem context being constructed.
+ * @param: The parameter.
+ *
+ * Returns 0 on success, -ENOPARAM to pass the parameter on or anything else on
+ * error.
+ */
+static int smack_fs_context_parse_param(struct fs_context *fc,
+					struct fs_parameter *param)
+{
+	struct fs_parse_result result;
+	int opt, rc;
+
+	opt = fs_parse(fc, &smack_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	rc = smack_add_opt(opt, param->string, &fc->security);
+	if (!rc)
+		param->string = NULL;
+	return rc;
+}
+
 static int smack_sb_eat_lsm_opts(char *options, void **mnt_opts)
 {
 	char *from = options, *to = options;
@@ -4587,6 +4626,8 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
 	LSM_HOOK_INIT(syslog, smack_syslog),
 
+	LSM_HOOK_INIT(fs_context_parse_param, smack_fs_context_parse_param),
+
 	LSM_HOOK_INIT(sb_alloc_security, smack_sb_alloc_security),
 	LSM_HOOK_INIT(sb_free_security, smack_sb_free_security),
 	LSM_HOOK_INIT(sb_free_mnt_opts, smack_free_mnt_opts),

