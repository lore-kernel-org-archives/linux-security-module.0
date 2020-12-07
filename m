Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A002C433FE
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Dec 2020 16:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 675AF238E9
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Dec 2020 16:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgLGQfN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Dec 2020 11:35:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37721 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727666AbgLGQeg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Dec 2020 11:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607358789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z9GFPfP4QUc9Eox0SoIdqm6RVWFYT3GmDgPPKwCvoZY=;
        b=ReLv4IRXdNBZ8XxH3caocDdrtbs8etZnOJtsZqjxJvFmk+ixRRw+vh00OzlfrOIwSCbIWj
        5IDUfk4oVoFbB04imtk9Lcxy80fNYb66Sb+tcyvbjAGAN/Ifn8/ezoERY96bzI8ASnL48f
        M6Hbj2fOQ6BMs9Hu8dOJP63zCkfrVQE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-qaUte7glMECA-Kjj3xW8yg-1; Mon, 07 Dec 2020 11:33:07 -0500
X-MC-Unique: qaUte7glMECA-Kjj3xW8yg-1
Received: by mail-ed1-f70.google.com with SMTP id u18so6005168edy.5
        for <linux-security-module@vger.kernel.org>; Mon, 07 Dec 2020 08:33:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z9GFPfP4QUc9Eox0SoIdqm6RVWFYT3GmDgPPKwCvoZY=;
        b=OAOrMVvk27zOuc61H5MxWU+uonUX0LGBRW9pQ0ui7hxFnGtvbAlyKriQ+QRoev3pwJ
         8oPc0CigP07ncHq1/BWI2V65UzFLCnvRa3j27N1rMwfznF5BbeqLnduc2SLsPkdYpx4w
         Ie3IIvXcBk+T/n0Owv+reRhZnOzV6kd0c8uhWupeBUtyMnZA3NXX4lj1FDEGBeMwKeSC
         jsuEyV2Em3LlE6eMBFdZBOZGPwtWpG4sOl4tU37eC0NylLoHi8CCywzaRj5EwmrnzKTE
         mQfGjjrsIXW3XzC2F7tnS62ezztwzuctwdvkNbeTbuVcSJy/ck36v66wPTuMEoqwE1rF
         Ag8w==
X-Gm-Message-State: AOAM530ELCY4IZlEd9KsdpsjYtRTpmgn45DlLEadYzIWiuu96YXg5G3S
        r2v4KPs0rKbdIr2trASW0Nxb7R5Bzwb8+VTrw1YaGRMiqhp5FUGlRiJgxvxHZ9gP5kiMEiTlD+c
        k9cMaFfVgNFDkKHEzgABCTVVTPNs4M0gSzFEL
X-Received: by 2002:a50:b243:: with SMTP id o61mr21246725edd.57.1607358785661;
        Mon, 07 Dec 2020 08:33:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdoaGF6V93HN0G1oEmt6WxNgh14Oc+j5HptlRhKBAGk7XVmmffsr/juqgIckKEWhSdANFcew==
X-Received: by 2002:a50:b243:: with SMTP id o61mr21246662edd.57.1607358785086;
        Mon, 07 Dec 2020 08:33:05 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id op5sm12801964ejb.43.2020.12.07.08.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:33:03 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH v2 04/10] ovl: make ioctl() safe
Date:   Mon,  7 Dec 2020 17:32:49 +0100
Message-Id: <20201207163255.564116-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201207163255.564116-1-mszeredi@redhat.com>
References: <20201207163255.564116-1-mszeredi@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mszeredi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

ovl_ioctl_set_flags() does a capability check using flags, but then the
real ioctl double-fetches flags and uses potentially different value.

The "Check the capability before cred override" comment misleading: user
can skip this check by presenting benign flags first and then overwriting
them to non-benign flags.

Just remove the cred override for now, hoping this doesn't cause a
regression.

The proper solution is to create a new setxflags i_op (patches are in the
works).

Xfstests don't show a regression.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/file.c | 75 ++-------------------------------------------
 1 file changed, 3 insertions(+), 72 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index efccb7c1f9bc..3cd1590f2030 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -541,46 +541,26 @@ static long ovl_real_ioctl(struct file *file, unsigned int cmd,
 			   unsigned long arg)
 {
 	struct fd real;
-	const struct cred *old_cred;
 	long ret;
 
 	ret = ovl_real_fdget(file, &real);
 	if (ret)
 		return ret;
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = security_file_ioctl(real.file, cmd, arg);
 	if (!ret)
 		ret = vfs_ioctl(real.file, cmd, arg);
-	revert_creds(old_cred);
 
 	fdput(real);
 
 	return ret;
 }
 
-static unsigned int ovl_iflags_to_fsflags(unsigned int iflags)
-{
-	unsigned int flags = 0;
-
-	if (iflags & S_SYNC)
-		flags |= FS_SYNC_FL;
-	if (iflags & S_APPEND)
-		flags |= FS_APPEND_FL;
-	if (iflags & S_IMMUTABLE)
-		flags |= FS_IMMUTABLE_FL;
-	if (iflags & S_NOATIME)
-		flags |= FS_NOATIME_FL;
-
-	return flags;
-}
-
 static long ovl_ioctl_set_flags(struct file *file, unsigned int cmd,
-				unsigned long arg, unsigned int flags)
+				unsigned long arg)
 {
 	long ret;
 	struct inode *inode = file_inode(file);
-	unsigned int oldflags;
 
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
@@ -591,12 +571,6 @@ static long ovl_ioctl_set_flags(struct file *file, unsigned int cmd,
 
 	inode_lock(inode);
 
-	/* Check the capability before cred override */
-	oldflags = ovl_iflags_to_fsflags(READ_ONCE(inode->i_flags));
-	ret = vfs_ioc_setflags_prepare(inode, oldflags, flags);
-	if (ret)
-		goto unlock;
-
 	ret = ovl_maybe_copy_up(file_dentry(file), O_WRONLY);
 	if (ret)
 		goto unlock;
@@ -613,46 +587,6 @@ static long ovl_ioctl_set_flags(struct file *file, unsigned int cmd,
 
 }
 
-static long ovl_ioctl_set_fsflags(struct file *file, unsigned int cmd,
-				  unsigned long arg)
-{
-	unsigned int flags;
-
-	if (get_user(flags, (int __user *) arg))
-		return -EFAULT;
-
-	return ovl_ioctl_set_flags(file, cmd, arg, flags);
-}
-
-static unsigned int ovl_fsxflags_to_fsflags(unsigned int xflags)
-{
-	unsigned int flags = 0;
-
-	if (xflags & FS_XFLAG_SYNC)
-		flags |= FS_SYNC_FL;
-	if (xflags & FS_XFLAG_APPEND)
-		flags |= FS_APPEND_FL;
-	if (xflags & FS_XFLAG_IMMUTABLE)
-		flags |= FS_IMMUTABLE_FL;
-	if (xflags & FS_XFLAG_NOATIME)
-		flags |= FS_NOATIME_FL;
-
-	return flags;
-}
-
-static long ovl_ioctl_set_fsxflags(struct file *file, unsigned int cmd,
-				   unsigned long arg)
-{
-	struct fsxattr fa;
-
-	memset(&fa, 0, sizeof(fa));
-	if (copy_from_user(&fa, (void __user *) arg, sizeof(fa)))
-		return -EFAULT;
-
-	return ovl_ioctl_set_flags(file, cmd, arg,
-				   ovl_fsxflags_to_fsflags(fa.fsx_xflags));
-}
-
 long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	long ret;
@@ -663,12 +597,9 @@ long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		ret = ovl_real_ioctl(file, cmd, arg);
 		break;
 
-	case FS_IOC_SETFLAGS:
-		ret = ovl_ioctl_set_fsflags(file, cmd, arg);
-		break;
-
 	case FS_IOC_FSSETXATTR:
-		ret = ovl_ioctl_set_fsxflags(file, cmd, arg);
+	case FS_IOC_SETFLAGS:
+		ret = ovl_ioctl_set_flags(file, cmd, arg);
 		break;
 
 	default:
-- 
2.26.2

