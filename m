Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A200C4338F
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Jul 2021 08:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F04760EBD
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Jul 2021 08:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbhGWH7U (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 23 Jul 2021 03:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39295 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234445AbhGWH7U (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Jul 2021 03:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627029593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0R6geRNUNQC0kRoF+lSv0pifLg2KS6M6ylGJCMhofy4=;
        b=IF4/l2ffsAVJmuw29rHktc4SwMyJ4y0K0BcSlO2tua+9Rx7EaPkkM5FhCmO+okA/6oW0sX
        yWOLuOvbyQCjf8p5QkNb2TUkxD0yZTib2yDJSgiSYfvokeQ6LHwvmdxXdFQY3qOCDp5KNv
        5SvV5y0q9g7lB/Ue0IfhnsaZipA8h8U=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-YVEnU4TCNdetsDtvXmVekQ-1; Fri, 23 Jul 2021 04:39:51 -0400
X-MC-Unique: YVEnU4TCNdetsDtvXmVekQ-1
Received: by mail-yb1-f197.google.com with SMTP id r64-20020a2576430000b02905592911c932so1042897ybc.15
        for <linux-security-module@vger.kernel.org>; Fri, 23 Jul 2021 01:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0R6geRNUNQC0kRoF+lSv0pifLg2KS6M6ylGJCMhofy4=;
        b=frisjfl3bjpjhzI4R8ItYo9rjEYpNNNIQTqHwdYqPPG1m6w3xg7EGicwXdZKOynlXi
         p42TOxelKw1BvoawpwR10ZdxUJU1ybfsGp1narTy2Bi90I3riclnjycLOe70P89bD2Q6
         JuBHP4XYUf1hgvoKdWbuUl6wPgPwovAxNGflMSZLc2RPx0mn0XjOYusyX6q6IY065iun
         zPVENzGluNkkKsJ8w7cfOpQmFTGT6kRnvPhfDTLnnZqaErjCwE/A4WlRgvQqz3wVib/D
         bKlyUyPYVivIJNkad+0OYKV1VswP+bCwvZYrxN0H9y7A4tHmM7dP94U1u1kK4q+2xYAA
         LXlw==
X-Gm-Message-State: AOAM530FCwrfJZHjRtFQa7s0a3Cyn//cAPVC19KLalyXPSWskGPzwo6d
        +DFi5v03pOw61n/hg8q7uRSykvXrHfqcKewLrwMYmQCuvVDcQwcqsCQ2C+neU2UMnWeDItN3PCP
        Jvi0HICLh5dtrD1NckjGHZ14ngnaYdfmvH2TQPy+gEb37Cq26NbPK
X-Received: by 2002:a25:ad06:: with SMTP id y6mr4824949ybi.439.1627029591447;
        Fri, 23 Jul 2021 01:39:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoipMlzBA/c+4YtmIWldiJukH66ZNqDaJOTH+DaPJOdlJ6BqCck6ROt8is3ynzWvQ2IC9DyGQaGkkj7dNqS/Y=
X-Received: by 2002:a25:ad06:: with SMTP id y6mr4824924ybi.439.1627029591301;
 Fri, 23 Jul 2021 01:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210624152515.1844133-1-omosnace@redhat.com>
In-Reply-To: <20210624152515.1844133-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 23 Jul 2021 10:39:40 +0200
Message-ID: <CAFqZXNtb-VdL9f8Ntg3RLZtP0x-7ZgEP1D0qL9fWCM7SPWcHXQ@mail.gmail.com>
Subject: Re: [RFC PATCH] userfaultfd: open userfaultfds with O_RDONLY
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        "Robert O'Callahan" <roc@ocallahan.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 24, 2021 at 5:25 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
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
> I marked this as RFC, because I'm not sure if this has any unwanted side
> effects. I only ran this patch through selinux-testsuite, which has a
> simple userfaultfd subtest, and a reproducer from the Bugzilla report.
>
> Please tell me whether this makes sense and/or if it passes any
> userfaultfd tests you guys might have.
>
>  fs/userfaultfd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 14f92285d04f..24e14c36068f 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -986,7 +986,7 @@ static int resolve_userfault_fork(struct userfaultfd_ctx *new,
>         int fd;
>
>         fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, new,
> -                       O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS), inode);
> +                       O_RDONLY | (new->flags & UFFD_SHARED_FCNTL_FLAGS), inode);
>         if (fd < 0)
>                 return fd;
>
> @@ -2088,7 +2088,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
>         mmgrab(ctx->mm);
>
>         fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, ctx,
> -                       O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
> +                       O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
>         if (fd < 0) {
>                 mmdrop(ctx->mm);
>                 kmem_cache_free(userfaultfd_ctx_cachep, ctx);
> --
> 2.31.1

Ping? Any comments on this patch?

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

