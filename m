Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E509C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B3F21738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfBSQcd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:32:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfBSQcc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:32:32 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5733A2F5D;
        Tue, 19 Feb 2019 16:32:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C0FB379F;
        Tue, 19 Feb 2019 16:32:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 30/43] cgroup2: switch to option-by-option parsing
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:32:30 +0000
Message-ID: <155059395041.12449.16641083373128419721.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 19 Feb 2019 16:32:32 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

[again, carved out of patch by dhowells]
[NB: we probably want to handle "source" in parse_param here]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 kernel/cgroup/cgroup.c |   62 ++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index faba00caa197..d0cddfbdf5cf 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -54,6 +54,7 @@
 #include <linux/proc_ns.h>
 #include <linux/nsproxy.h>
 #include <linux/file.h>
+#include <linux/fs_parser.h>
 #include <linux/sched/cputime.h>
 #include <linux/psi.h>
 #include <net/sock.h>
@@ -1772,26 +1773,37 @@ int cgroup_show_path(struct seq_file *sf, struct kernfs_node *kf_node,
 	return len;
 }
 
-static int parse_cgroup_root_flags(char *data, unsigned int *root_flags)
-{
-	char *token;
+enum cgroup2_param {
+	Opt_nsdelegate,
+	nr__cgroup2_params
+};
 
-	*root_flags = 0;
+static const struct fs_parameter_spec cgroup2_param_specs[] = {
+	fsparam_flag  ("nsdelegate",		Opt_nsdelegate),
+	{}
+};
 
-	if (!data || *data == '\0')
-		return 0;
+static const struct fs_parameter_description cgroup2_fs_parameters = {
+	.name		= "cgroup2",
+	.specs		= cgroup2_param_specs,
+};
 
-	while ((token = strsep(&data, ",")) != NULL) {
-		if (!strcmp(token, "nsdelegate")) {
-			*root_flags |= CGRP_ROOT_NS_DELEGATE;
-			continue;
-		}
+static int cgroup2_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
+	struct fs_parse_result result;
+	int opt;
 
-		pr_err("cgroup2: unknown option \"%s\"\n", token);
-		return -EINVAL;
-	}
+	opt = fs_parse(fc, &cgroup2_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
 
-	return 0;
+	switch (opt) {
+	case Opt_nsdelegate:
+		ctx->flags |= CGRP_ROOT_NS_DELEGATE;
+		return 0;
+	}
+	return -EINVAL;
 }
 
 static void apply_cgroup_root_flags(unsigned int root_flags)
@@ -2074,15 +2086,6 @@ static void cgroup_fs_context_free(struct fs_context *fc)
 	kfree(ctx);
 }
 
-static int cgroup_parse_monolithic(struct fs_context *fc, void *data)
-{
-	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
-
-	if (data)
-		security_sb_eat_lsm_opts(data, &fc->security);
-	return parse_cgroup_root_flags(data, &ctx->flags);
-}
-
 static int cgroup_get_tree(struct fs_context *fc)
 {
 	struct cgroup_namespace *ns = current->nsproxy->cgroup_ns;
@@ -2108,7 +2111,7 @@ static int cgroup_get_tree(struct fs_context *fc)
 
 static const struct fs_context_operations cgroup_fs_context_ops = {
 	.free		= cgroup_fs_context_free,
-	.parse_monolithic = cgroup_parse_monolithic,
+	.parse_param	= cgroup2_parse_param,
 	.get_tree	= cgroup_get_tree,
 	.reconfigure	= cgroup_reconfigure,
 };
@@ -2174,10 +2177,11 @@ struct file_system_type cgroup_fs_type = {
 };
 
 static struct file_system_type cgroup2_fs_type = {
-	.name = "cgroup2",
-	.init_fs_context = cgroup_init_fs_context,
-	.kill_sb = cgroup_kill_sb,
-	.fs_flags = FS_USERNS_MOUNT,
+	.name			= "cgroup2",
+	.init_fs_context	= cgroup_init_fs_context,
+	.parameters		= &cgroup2_fs_parameters,
+	.kill_sb		= cgroup_kill_sb,
+	.fs_flags		= FS_USERNS_MOUNT,
 };
 
 int cgroup_path_ns_locked(struct cgroup *cgrp, char *buf, size_t buflen,

