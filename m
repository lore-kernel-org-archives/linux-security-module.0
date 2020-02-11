Return-Path: <SRS0=MM4E=37=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B7EC352A3
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Feb 2020 17:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F071C20656
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Feb 2020 17:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgBKRBD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:01:03 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53557 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgBKRAx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Feb 2020 12:00:53 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j1Ysj-00014T-PM; Tue, 11 Feb 2020 16:59:29 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>
Cc:     smbarber@chromium.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 24/24] devpts: handle fsid mappings
Date:   Tue, 11 Feb 2020 17:57:53 +0100
Message-Id: <20200211165753.356508-25-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211165753.356508-1-christian.brauner@ubuntu.com>
References: <20200211165753.356508-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

When a uid or gid mount option is specified with devpts have it lookup the
corresponding kfsids in the fsid mappings. If no fsid mappings are setup the
behavior is unchanged, i.e. fsids are looked up in the id mappings.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/devpts/inode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 42e5a766d33c..139958892572 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -24,6 +24,7 @@
 #include <linux/parser.h>
 #include <linux/fsnotify.h>
 #include <linux/seq_file.h>
+#include <linux/fsuidgid.h>
 
 #define DEVPTS_DEFAULT_MODE 0600
 /*
@@ -277,7 +278,7 @@ static int parse_mount_options(char *data, int op, struct pts_mount_opts *opts)
 		case Opt_uid:
 			if (match_int(&args[0], &option))
 				return -EINVAL;
-			uid = make_kuid(current_user_ns(), option);
+			uid = make_kfsuid(current_user_ns(), option);
 			if (!uid_valid(uid))
 				return -EINVAL;
 			opts->uid = uid;
@@ -286,7 +287,7 @@ static int parse_mount_options(char *data, int op, struct pts_mount_opts *opts)
 		case Opt_gid:
 			if (match_int(&args[0], &option))
 				return -EINVAL;
-			gid = make_kgid(current_user_ns(), option);
+			gid = make_kfsgid(current_user_ns(), option);
 			if (!gid_valid(gid))
 				return -EINVAL;
 			opts->gid = gid;
@@ -410,7 +411,7 @@ static int devpts_show_options(struct seq_file *seq, struct dentry *root)
 			   from_kuid_munged(&init_user_ns, opts->uid));
 	if (opts->setgid)
 		seq_printf(seq, ",gid=%u",
-			   from_kgid_munged(&init_user_ns, opts->gid));
+			   from_kfsgid_munged(&init_user_ns, opts->gid));
 	seq_printf(seq, ",mode=%03o", opts->mode);
 	seq_printf(seq, ",ptmxmode=%03o", opts->ptmxmode);
 	if (opts->max < NR_UNIX98_PTY_MAX)
-- 
2.25.0

