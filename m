Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D75CC43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CD121738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfBSQdd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:33:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfBSQdd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:33:33 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5267F81DE8;
        Tue, 19 Feb 2019 16:33:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E49C06114E;
        Tue, 19 Feb 2019 16:33:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 36/43] cpuset: Use fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:33:28 +0000
Message-ID: <155059400804.12449.6061293146947154243.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 19 Feb 2019 16:33:32 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Make the cpuset filesystem use the filesystem context.  This is potentially
tricky as the cpuset fs is almost an alias for the cgroup filesystem, but
with some special parameters.

This can, however, be handled by setting up an appropriate cgroup
filesystem and returning the root directory of that as the root dir of this
one.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 kernel/cgroup/cpuset.c |   56 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 479743db6c37..9758b03834ac 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -39,6 +39,7 @@
 #include <linux/memory.h>
 #include <linux/export.h>
 #include <linux/mount.h>
+#include <linux/fs_context.h>
 #include <linux/namei.h>
 #include <linux/pagemap.h>
 #include <linux/proc_fs.h>
@@ -372,25 +373,52 @@ static inline bool is_in_v2_mode(void)
  * users. If someone tries to mount the "cpuset" filesystem, we
  * silently switch it to mount "cgroup" instead
  */
-static struct dentry *cpuset_mount(struct file_system_type *fs_type,
-			 int flags, const char *unused_dev_name, void *data)
-{
-	struct file_system_type *cgroup_fs = get_fs_type("cgroup");
-	struct dentry *ret = ERR_PTR(-ENODEV);
-	if (cgroup_fs) {
-		char mountopts[] =
-			"cpuset,noprefix,"
-			"release_agent=/sbin/cpuset_release_agent";
-		ret = cgroup_fs->mount(cgroup_fs, flags,
-					   unused_dev_name, mountopts);
-		put_filesystem(cgroup_fs);
+static int cpuset_get_tree(struct fs_context *fc)
+{
+	struct file_system_type *cgroup_fs;
+	struct fs_context *new_fc;
+	int ret;
+
+	cgroup_fs = get_fs_type("cgroup");
+	if (!cgroup_fs)
+		return -ENODEV;
+
+	new_fc = fs_context_for_mount(cgroup_fs, fc->sb_flags);
+	if (IS_ERR(new_fc)) {
+		ret = PTR_ERR(new_fc);
+	} else {
+		static const char agent_path[] = "/sbin/cpuset_release_agent";
+		ret = vfs_parse_fs_string(new_fc, "cpuset", NULL, 0);
+		if (!ret)
+			ret = vfs_parse_fs_string(new_fc, "noprefix", NULL, 0);
+		if (!ret)
+			ret = vfs_parse_fs_string(new_fc, "release_agent",
+					agent_path, sizeof(agent_path) - 1);
+		if (!ret)
+			ret = vfs_get_tree(new_fc);
+		if (!ret) {	/* steal the result */
+			fc->root = new_fc->root;
+			new_fc->root = NULL;
+		}
+		put_fs_context(new_fc);
 	}
+	put_filesystem(cgroup_fs);
 	return ret;
 }
 
+static const struct fs_context_operations cpuset_fs_context_ops = {
+	.get_tree	= cpuset_get_tree,
+};
+
+static int cpuset_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &cpuset_fs_context_ops;
+	return 0;
+}
+
 static struct file_system_type cpuset_fs_type = {
-	.name = "cpuset",
-	.mount = cpuset_mount,
+	.name			= "cpuset",
+	.init_fs_context	= cpuset_init_fs_context,
 };
 
 /*

