Return-Path: <SRS0=eR/s=RC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A678C43381
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Feb 2019 14:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCE72133D
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Feb 2019 14:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfB0OTe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:19:34 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:58096 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbfB0OTe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 Feb 2019 09:19:34 -0500
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1REJPlm057862;
        Wed, 27 Feb 2019 23:19:25 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Wed, 27 Feb 2019 23:19:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1REJKmR057812
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:19:25 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] tomoyo: Change pathname calculation for read-only filesystems.
Date:   Wed, 27 Feb 2019 23:19:24 +0900
Message-Id: <1551277164-8715-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Commit 5625f2e3266319fd ("TOMOYO: Change pathname for non-rename()able
filesystems.") intended to be applied to filesystems where the content is
not controllable from the userspace (e.g. proc, sysfs, securityfs), based
on an assumption that such filesystems do not support rename() operation.

But it turned out that read-only filesystems also do not support rename()
operation despite the content is controllable from the userspace, and that
commit is annoying TOMOYO users who want to use e.g. squashfs as the root
filesystem due to use of local name which does not start with '/'.

Therefore, based on an assumption that filesystems which require the
device argument upon mount() request is an indication that the content
is controllable from the userspace, do not use local name if a filesystem
does not support rename() operation but requires the device argument upon
mount() request.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/tomoyo/realpath.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/tomoyo/realpath.c b/security/tomoyo/realpath.c
index 85e6e31..e7832448 100644
--- a/security/tomoyo/realpath.c
+++ b/security/tomoyo/realpath.c
@@ -295,7 +295,8 @@ char *tomoyo_realpath_from_path(const struct path *path)
 		 * or dentry without vfsmount.
 		 */
 		if (!path->mnt ||
-		    (!inode->i_op->rename))
+		    (!inode->i_op->rename &&
+		     !(sb->s_type->fs_flags & FS_REQUIRES_DEV)))
 			pos = tomoyo_get_local_path(path->dentry, buf,
 						    buf_len - 1);
 		/* Get absolute name for the rest. */
-- 
1.8.3.1

