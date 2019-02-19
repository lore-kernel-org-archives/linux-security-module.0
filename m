Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0E3C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAB520823
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfBSQeN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:34:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728688AbfBSQeN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:34:13 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 459A2145FB3;
        Tue, 19 Feb 2019 16:34:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7FA9C379F;
        Tue, 19 Feb 2019 16:34:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 41/43] vfs: Add some logging to the core users of the
 fs_context log
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:34:09 +0000
Message-ID: <155059404970.12449.2377788417776946395.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 19 Feb 2019 16:34:13 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add some logging to the core users of the fs_context log so that
information can be extracted from them as to the reason for failure.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/super.c                |    4 +++-
 kernel/cgroup/cgroup-v1.c |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 0ebb5c11fa56..583a0124bc39 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1467,8 +1467,10 @@ int vfs_get_tree(struct fs_context *fc)
 	struct super_block *sb;
 	int error;
 
-	if (fc->fs_type->fs_flags & FS_REQUIRES_DEV && !fc->source)
+	if (fc->fs_type->fs_flags & FS_REQUIRES_DEV && !fc->source) {
+		errorf(fc, "Filesystem requires source device");
 		return -ENOENT;
+	}
 
 	if (fc->root)
 		return -EBUSY;
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 571ef3447426..c126b34fd4ff 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -17,7 +17,7 @@
 
 #include <trace/events/cgroup.h>
 
-#define cg_invalf(fc, fmt, ...) ({ pr_err(fmt, ## __VA_ARGS__); -EINVAL; })
+#define cg_invalf(fc, fmt, ...) invalf(fc, fmt, ## __VA_ARGS__)
 
 /*
  * pidlists linger the following amount before being destroyed.  The goal

