Return-Path: <SRS0=b0TY=EF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3DAC00A89
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Oct 2020 19:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67A302222F
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Oct 2020 19:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="SuJtxiwk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgJ3TW2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 30 Oct 2020 15:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbgJ3TVy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 30 Oct 2020 15:21:54 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2135BC0613CF
        for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2020 12:21:54 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id p16so1685399vkf.13
        for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2020 12:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8I5vCt7sQpLxqO9fFZglUpeymmnJZb+1HjzCHkxiFnI=;
        b=SuJtxiwkoB6tT6rUkiqexK55I2Znto0HzbzoxVsqOK/P6c9gFQuP6oaZkgRXt529ZU
         a+bJWmyqi0+flho90rhtlkwHEs/7it0kmTdVLD/LJTnan7DMQe7EUfH5HwKopELvdr6c
         zUX1a7CTPjVwz/VH/TBiLoorR+ZXggEpvShSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8I5vCt7sQpLxqO9fFZglUpeymmnJZb+1HjzCHkxiFnI=;
        b=f25x8QtJvjHUfjr8lm+Ob9/3aFKIQHQZvzB/0gLnMSI0LHzSVK6tCiq73+6xrsiK8F
         RJBp+5YWKHWOBhthtiW7BISLcfqFA5Mv2dAHy49A42LG6Bil+9U0qgZ+BlhSDjOAJMt/
         b2gkgvpLZdlLyzns5VaWaUVKc5Z/R7N2V+pfHq+Nq6VusIXgKm+fusa3c/PeJ2rHi+SM
         P+x4ZTW6DKN7WnTLsKoU6nh1ycXCLKoWcXW7Pd0jDqIqKP/+0IVjROexrLTMPqgyZBlN
         b1v0Gy0K4tN1bMwHcu9vF3RUOcvNYOJoMzPgd40mwe9L0o+hvjURkXOngaRtO4giYVyR
         +oZQ==
X-Gm-Message-State: AOAM532V1PTc2BYlqR34GdKPrtgQLpMeGJ0QD/5lkOpYQ4q+sNT18A0E
        nYb6McGGkHFfmZts1rABui4jK3NuYiUWeh/MesjOow==
X-Google-Smtp-Source: ABdhPJxhGLBaazY1X0XxdFRD1fbdQdiuFWbQMhMjddSkpPS+9nVoe7eHxNfL0vqo7pYecWi6tpSi1Itb0ThaHuhtKN4=
X-Received: by 2002:a1f:23d0:: with SMTP id j199mr8477163vkj.11.1604085713313;
 Fri, 30 Oct 2020 12:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008caae305ab9a5318@google.com> <000000000000a726a405ada4b6cf@google.com>
 <CAFqZXNvQcjp201ahjLBhYJJCuYqZrYLGDA-wE3hXiJpRNgbTKg@mail.gmail.com>
 <CAJfpegtzQB09ind8tkYzaiu6ODJvhMKj3myxVS75vbjTcOxU8g@mail.gmail.com> <CACT4Y+Yyxdju4FR-E3bc5ERM6xhecnos6mkJR5==xS+RS_DUuw@mail.gmail.com>
In-Reply-To: <CACT4Y+Yyxdju4FR-E3bc5ERM6xhecnos6mkJR5==xS+RS_DUuw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 30 Oct 2020 20:21:42 +0100
Message-ID: <CAJfpegsAabASuHYtoi_DoooV1vM7Evfrd8ESZDDTx2oXHiR6cw@mail.gmail.com>
Subject: Re: general protection fault in security_inode_getattr
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        syzbot <syzbot+f07cc9be8d1d226947ed@syzkaller.appspotmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        network dev <netdev@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Song Liu <songliubraving@fb.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yonghong Song <yhs@fb.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 30, 2020 at 7:42 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Oct 30, 2020 at 2:02 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, Aug 24, 2020 at 11:00 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > On Mon, Aug 24, 2020 at 9:37 PM syzbot
> > > <syzbot+f07cc9be8d1d226947ed@syzkaller.appspotmail.com> wrote:
> > > > syzbot has found a reproducer for the following issue on:
> > >
> > > Looping in fsdevel and OverlayFS maintainers, as this seems to be
> > > FS/OverlayFS related...
> >
> > Hmm, the oopsing code is always something like:
> >
> > All code
> > ========
> >    0: 1b fe                sbb    %esi,%edi
> >    2: 49 8d 5e 08          lea    0x8(%r14),%rbx
> >    6: 48 89 d8              mov    %rbx,%rax
> >    9: 48 c1 e8 03          shr    $0x3,%rax
> >    d: 42 80 3c 38 00        cmpb   $0x0,(%rax,%r15,1)
> >   12: 74 08                je     0x1c
> >   14: 48 89 df              mov    %rbx,%rdi
> >   17: e8 bc b4 5b fe        callq  0xfffffffffe5bb4d8
> >   1c: 48 8b 1b              mov    (%rbx),%rbx
> >   1f: 48 83 c3 68          add    $0x68,%rbx
> >   23: 48 89 d8              mov    %rbx,%rax
> >   26: 48 c1 e8 03          shr    $0x3,%rax
> >   2a:* 42 80 3c 38 00        cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
> >   2f: 74 08                je     0x39
> >   31: 48 89 df              mov    %rbx,%rdi
> >   34: e8 9f b4 5b fe        callq  0xfffffffffe5bb4d8
> >   39: 48 8b 1b              mov    (%rbx),%rbx
> >   3c: 48 83 c3 0c          add    $0xc,%rbx
> >
> >
> > And that looks (to me) like the unrolled loop in call_int_hook().  I
> > don't see how that could be related to overlayfs, though it's
> > definitely interesting why it only triggers from
> > overlay->vfs_getattr()->security_inode_getattr()...
>
>
> >   26: 48 c1 e8 03          shr    $0x3,%rax
> >   2a:* 42 80 3c 38 00        cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
>
>
> This access is part of KASAN check. But the original address kernel
> tries to access is NULL, so it's not an issue with KASAN.
>
> The line is this:
>
> int security_inode_getattr(const struct path *path)
> {
>     if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
>         return 0;
>
> So it's either path is NULL, or something in d_backing_inode
> dereferences NULL path->dentry.
>
> The reproducer does involve overlayfs:
>
> mkdir(&(0x7f0000000240)='./file1\x00', 0x0)
> mkdir(&(0x7f0000000300)='./bus\x00', 0x0)
> r0 = creat(&(0x7f00000000c0)='./bus/file1\x00', 0x0)
> mkdir(&(0x7f0000000080)='./file0\x00', 0x0)
> mount$overlay(0x400002, &(0x7f0000000000)='./bus\x00',
> &(0x7f0000000100)='overlay\x00', 0x0,
> &(0x7f00000003c0)=ANY=[@ANYBLOB='upperdir=./file1,lowerdir=./bus,workdir=./file0,metacopy=on'])
> link(&(0x7f0000000200)='./bus/file1\x00', &(0x7f00000002c0)='./bus/file0\x00')
> write$RDMA_USER_CM_CMD_RESOLVE_ADDR(r0, 0x0, 0x0)
> acct(&(0x7f0000000040)='./bus/file0\x00')
>
> Though, it may be overlayfs-related, or it may be a generic bug that
> requires a tricky reproducer and the only reproducer syzbot come up
> with happened to involve overlayfs.
> But there are 4 reproducers on syzbot dashboard and all of them
> involve overlayfs and they are somewhat different. So my bet would be
> on overlayfs.

Seems there's no C reproducer, though.   Can this be reproduced
without KASAN obfuscating the oops?

Thanks,
Miklos
