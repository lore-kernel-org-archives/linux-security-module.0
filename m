Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DA7C3F6B0
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Aug 2022 22:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbiHPWMP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Aug 2022 18:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237365AbiHPWMO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Aug 2022 18:12:14 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444348FD61
        for <linux-security-module@vger.kernel.org>; Tue, 16 Aug 2022 15:12:13 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-11c4d7d4683so52762fac.8
        for <linux-security-module@vger.kernel.org>; Tue, 16 Aug 2022 15:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=bknMuEzY2g2ODMFx0pPstR6QEhnsKog5Pl0iH/Ldgz4=;
        b=sL5dB1VPJNsbf7G8+raTZ4CNHBvpk7wuUoHen4F/fRTlul2K/o6MnEL0QELNEgsXV5
         8uwAQx9hINB2uTWQ0G+WTB+PukHYNee/MzAqYyyV44+Yri8pGj61r+lHfamUK8p8w4X7
         QRKqDPOPL9df5lxT34qEXLNreDeG9SXoOiwcQAPOeFr88+qXNgL64ohaZHIVEk+mgB5R
         wnGXnCFP58BNzbyVX8OjR1IGJbgoEjD+wT7pAjEFqxbJu1di5xE14EIVzTnYMG1XM9Y9
         6uf1djrUsKmdWrPsGSGSoKlADOPuJiThHSoMfwFLvak3qmxWc7ku1U1IrL0Q701vNeVo
         jU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=bknMuEzY2g2ODMFx0pPstR6QEhnsKog5Pl0iH/Ldgz4=;
        b=cOxnv5YRUfJV3PKE2zBYJzyHdiwsLeEQLq1MfhUe2u0sjZ974CXrhP1K0U3kCegMov
         HOuu45QHlSNrl1X2oAr2XA59Sa8xhZcCS1GIq3cRiJ+R/TcMYiTwbu06VhBSv3IkkHTQ
         iCoq5Lgtb3Zt2OPPXpt3DYq9qaJ3K+y36txbYPKfMOOmET8OgESvVTrd2gHVDH/1KU+j
         MW4Duq5hws7vOxK4gN8nBVWcTxoqI9j9TbP18s9iBdZKJpVlB2Yi1z3kR0GpNTpT3MPV
         9L8MAgZaSW5zYwV7OPXOFHtXt8HFM/WesBHtAXAoBv3WfRPE8B7fCNJQ7HirH4i+ZMDj
         KK/Q==
X-Gm-Message-State: ACgBeo3FYamNE5KgCEjnxiNeWYALPQMaxWKyPUBCHHD3rAPUyr6FGqZ1
        1YmxRincQKBqnGHAIxbYkAdlhrFUUxsGLw8g5PFa
X-Google-Smtp-Source: AA6agR4Kj8XNYB9B3lGnewDxsdQnXfT+Fb5iBt539vCMF1wUyb8ZJN1qBsC0HMD5LPLcd7Vjw7gmG8QhiI7dUCI9BGQ=
X-Received: by 2002:a05:6870:a78d:b0:11c:437b:ec70 with SMTP id
 x13-20020a056870a78d00b0011c437bec70mr320272oao.136.1660687932528; Tue, 16
 Aug 2022 15:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220708093451.472870-1-omosnace@redhat.com>
In-Reply-To: <20220708093451.472870-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 16 Aug 2022 18:12:01 -0400
Message-ID: <CAHC9VhSFUJ6J4_wt1SKAoLourNGVkxu0Tbd9NPDbYqjjrs-qoQ@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND] userfaultfd: open userfaultfds with O_RDONLY
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Robert O'Callahan" <roc@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 8, 2022 at 5:35 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Since userfaultfd doesn't implement a write operation, it is more
> appropriate to open it read-only.
>
> When userfaultfds are opened read-write like it is now, and such fd is
> passed from one process to another, SELinux will check both read and
> write permissions for the target process, even though it can't actually
> do any write operation on the fd later.
>
> Inspired by the following bug report, which has hit the SELinux scenario
> described above:
> https://bugzilla.redhat.com/show_bug.cgi?id=1974559
>
> Reported-by: Robert O'Callahan <roc@ocallahan.org>
> Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> Resending as the last submission was ignored for over a year...
>
> https://lore.kernel.org/lkml/20210624152515.1844133-1-omosnace@redhat.com/T/
>
> I marked this as RFC, because I'm not sure if this has any unwanted side
> effects. I only ran this patch through selinux-testsuite, which has a
> simple userfaultfd subtest, and a reproducer from the Bugzilla report.
>
> Please tell me whether this makes sense and/or if it passes any
> userfaultfd tests you guys might have.
>
>  fs/userfaultfd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

VFS folks, any objection to this patch?  It seems reasonable to me and
I'd really prefer this to go in via the vfs tree, but I'm not above
merging this via the lsm/next tree to get someone in vfs land to pay
attention to this ...

> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index e943370107d0..8ccf00be63e1 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -989,7 +989,7 @@ static int resolve_userfault_fork(struct userfaultfd_ctx *new,
>         int fd;
>
>         fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, new,
> -                       O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS), inode);
> +                       O_RDONLY | (new->flags & UFFD_SHARED_FCNTL_FLAGS), inode);
>         if (fd < 0)
>                 return fd;
>
> @@ -2090,7 +2090,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
>         mmgrab(ctx->mm);
>
>         fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, ctx,
> -                       O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
> +                       O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
>         if (fd < 0) {
>                 mmdrop(ctx->mm);
>                 kmem_cache_free(userfaultfd_ctx_cachep, ctx);
> --
> 2.36.1

-- 
paul-moore.com
