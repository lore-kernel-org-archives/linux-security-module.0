Return-Path: <SRS0=mFfD=6P=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DE8C47256
	for <linux-security-module@archiver.kernel.org>; Fri,  1 May 2020 07:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 784DF2071C
	for <linux-security-module@archiver.kernel.org>; Fri,  1 May 2020 07:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="nIFyGcUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgEAHbd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 1 May 2020 03:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgEAHbc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 May 2020 03:31:32 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED0EC035494
        for <linux-security-module@vger.kernel.org>; Fri,  1 May 2020 00:31:31 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x18so10579458wrq.2
        for <linux-security-module@vger.kernel.org>; Fri, 01 May 2020 00:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rAliNqiNu+1dGXi4Ijb6n1X5xzkWQyLVearRKu8YpyE=;
        b=nIFyGcUtpdLyvAYYS/MRLj42vjeHrDf7Yp9WzAVh7V4mFIedZx7M9y0t8FNL9xjK3i
         jCIG+1XWbQ16yz1zYQkHRherfClADA4zBSf9WX8PIgBH0hGmmzifDNvRoksTSVbUt+n5
         TNtfvZjPBvxeyU7T1oeVmpZvb4EZXgC1OkgRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rAliNqiNu+1dGXi4Ijb6n1X5xzkWQyLVearRKu8YpyE=;
        b=it7t3z3AmSr4dVQP6B2iYd7HhFVQop/JencULpUmVcWEcU7exp9mgQVYYhX1TTYgX3
         gevGdW2Z0Ocodk15vc2VVJvdxSK4qU7fZDI0r0hNiRGF9r7mwFWn28PGwsi94hUd/xCG
         QuUKUKLuXLNzqM1I4eFq8EXVSrvxzZhdQXLvxfumMZzOr/HvjqRkYUQpz94PeY4sYZx9
         SnfWTJRAAsndizMYkM74JThmHi37Zh9poighivHLXgwOYgMhQ0PLb9D4xp5dcLi5GqF8
         ZQV5vxwAY3HlS04KearyNZRquS3BlLygLmxhNF8tQMMnyW+mPvxNmxPNr5BNfdHSRcxq
         IhGw==
X-Gm-Message-State: AGi0PuZ01bAGHQ1J61q8N6GpIbGVizBA+NLOnqMPRAMziflgkkjkZsTN
        NI3WPBGh/ClOOPEU9Nvzubn9YhQs+lWoxQ==
X-Google-Smtp-Source: APiQypLex36dnTHSszriNToHwyP9qb2U8oD664JwLqWSLyOs7CdJVhKAqZYYVNBUWIgzKn6Uw6nt4g==
X-Received: by 2002:adf:e552:: with SMTP id z18mr2666258wrm.244.1588318289891;
        Fri, 01 May 2020 00:31:29 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id u30sm3250343wru.13.2020.05.01.00.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 00:31:29 -0700 (PDT)
Date:   Fri, 1 May 2020 09:31:27 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] vfs: allow unprivileged whiteout creation
Message-ID: <20200501073127.GB13131@miu.piliscsaba.redhat.com>
References: <20200409212859.GH28467@miu.piliscsaba.redhat.com>
 <20200501041444.GJ23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501041444.GJ23230@ZenIV.linux.org.uk>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 01, 2020 at 05:14:44AM +0100, Al Viro wrote:
> On Thu, Apr 09, 2020 at 11:28:59PM +0200, Miklos Szeredi wrote:
> > From: Miklos Szeredi <mszeredi@redhat.com>
> > 
> > Whiteouts, unlike real device node should not require privileges to create.
> > 
> > The general concern with device nodes is that opening them can have side
> > effects.  The kernel already avoids zero major (see
> > Documentation/admin-guide/devices.txt).  To be on the safe side the patch
> > explicitly forbids registering a char device with 0/0 number (see
> > cdev_add()).
> > 
> > This guarantees that a non-O_PATH open on a whiteout will fail with ENODEV;
> > i.e. it won't have any side effect.
> 
> >  int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
> >  {
> > +	bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
> >  	int error = may_create(dir, dentry);
> >  
> >  	if (error)
> >  		return error;
> >  
> > -	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
> > +	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD) &&
> > +	    !is_whiteout)
> >  		return -EPERM;
> 
> Hmm...  That exposes vfs_whiteout() to LSM; are you sure that you won't
> end up with regressions for overlayfs on sufficiently weird setups?

You're right.  OTOH, what can we do?  We can't fix the weird setups, only the
distros/admins can.

Can we just try this, and revert to calling ->mknod directly from overlayfs if
it turns out to be a problem that people can't fix easily?

I guess we could add a new ->whiteout security hook as well, but I'm not sure
it's worth it.  Cc: LMS mailing list; patch re-added for context.

Thanks,
Miklos

---
 fs/char_dev.c                 |    3 +++
 fs/namei.c                    |   17 ++++-------------
 include/linux/device_cgroup.h |    3 +++
 3 files changed, 10 insertions(+), 13 deletions(-)

--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -483,6 +483,9 @@ int cdev_add(struct cdev *p, dev_t dev,
 	p->dev = dev;
 	p->count = count;
 
+	if (WARN_ON(dev == WHITEOUT_DEV))
+		return -EBUSY;
+
 	error = kobj_map(cdev_map, dev, count, NULL,
 			 exact_match, exact_lock, p);
 	if (error)
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3505,12 +3505,14 @@ EXPORT_SYMBOL(user_path_create);
 
 int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
 {
+	bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
 	int error = may_create(dir, dentry);
 
 	if (error)
 		return error;
 
-	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
+	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD) &&
+	    !is_whiteout)
 		return -EPERM;
 
 	if (!dir->i_op->mknod)
@@ -4345,9 +4347,6 @@ static int do_renameat2(int olddfd, cons
 	    (flags & RENAME_EXCHANGE))
 		return -EINVAL;
 
-	if ((flags & RENAME_WHITEOUT) && !capable(CAP_MKNOD))
-		return -EPERM;
-
 	if (flags & RENAME_EXCHANGE)
 		target_flags = 0;
 
@@ -4485,15 +4484,7 @@ SYSCALL_DEFINE2(rename, const char __use
 
 int vfs_whiteout(struct inode *dir, struct dentry *dentry)
 {
-	int error = may_create(dir, dentry);
-	if (error)
-		return error;
-
-	if (!dir->i_op->mknod)
-		return -EPERM;
-
-	return dir->i_op->mknod(dir, dentry,
-				S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
+	return vfs_mknod(dir, dentry, S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
 }
 EXPORT_SYMBOL(vfs_whiteout);
 
--- a/include/linux/device_cgroup.h
+++ b/include/linux/device_cgroup.h
@@ -51,6 +51,9 @@ static inline int devcgroup_inode_mknod(
 	if (!S_ISBLK(mode) && !S_ISCHR(mode))
 		return 0;
 
+	if (S_ISCHR(mode) && dev == WHITEOUT_DEV)
+		return 0;
+
 	if (S_ISBLK(mode))
 		type = DEVCG_DEV_BLOCK;
 	else
