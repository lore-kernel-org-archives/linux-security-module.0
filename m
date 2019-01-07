Return-Path: <SRS0=eMAe=PP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCD2C43387
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Jan 2019 21:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA31E2089F
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Jan 2019 21:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DGHbVUV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfAGVJ0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:09:26 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41772 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfAGVJZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Jan 2019 16:09:25 -0500
Received: by mail-vs1-f65.google.com with SMTP id t17so1145721vsc.8
        for <linux-security-module@vger.kernel.org>; Mon, 07 Jan 2019 13:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=up1MW20yEfSNO6kjzw/ThzXsTljbPgzfQgz+1UwjdnE=;
        b=DGHbVUV5gdm2AAWcbnDV8PxQ4RIiu8swDmyjv91s2px9gLnuA3FBfLRxvCeRUdJCGJ
         W+vzMh7j9nH9Fy8aygdN+2jnPdv53t5st/PPWdH07USj4Z2uuLgAP8cn0BklFGmgSVBH
         AW2dWs+7HXWQDO0Qepk3M+lbzHEnPhyf/15ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=up1MW20yEfSNO6kjzw/ThzXsTljbPgzfQgz+1UwjdnE=;
        b=hpbcDhikbaiZFONnD7YWFNE1QJfQtVFMSzA8AfRKW+NT+WJTWsBkKoKvNsMcYQQadW
         Vx6pjuuL9UVncWc4C4mj9N+zwycxfgG1jnVWG8yKquEkm9DzScKsDQjv1f1OsyCbbMVE
         oLpir+gOwo2vGMSDs74rBfT7DlNGph/PyytKC+s3VDqAWuqSCCdf0EBuiJPy8rKZQvZi
         N3ziQgxpwk6GZbbJRvMfNdlZk+bYjHa48gEz2sSCf+xpmBSfvgSSq8bj0bcTG4Q9OGxK
         oytmrqZjcqswOlk/K2GqtcfdwOIgCQEBjbzp1ffx4Dz3MeN3CoymSUQvc8Mm7BzZ/oW7
         Lj4g==
X-Gm-Message-State: AJcUukeB2DPpyARLr067ZTCfXtdBuqxwLeJXJZT63ZdlEF8JHJhCYsHE
        /XjaUAeVWmFw1oYdJUvq6aOlsPMWjQI=
X-Google-Smtp-Source: ALg8bN6ODX5/6WH4+ZM9+FlCDo9VR+j1T9ArXPh+DfoFQsYlO5TvC5iZxj1WE4zevr1Lvi+7NMoN4w==
X-Received: by 2002:a67:6484:: with SMTP id y126mr25491424vsb.193.1546895364284;
        Mon, 07 Jan 2019 13:09:24 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id v79sm18745103vkv.13.2019.01.07.13.09.22
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 13:09:24 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id d201so421657vka.0
        for <linux-security-module@vger.kernel.org>; Mon, 07 Jan 2019 13:09:22 -0800 (PST)
X-Received: by 2002:a1f:3d10:: with SMTP id k16mr23120881vka.13.1546895361430;
 Mon, 07 Jan 2019 13:09:21 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1812311511360.1435@namei.org> <20190107101540.GA87402@gmail.com>
In-Reply-To: <20190107101540.GA87402@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 7 Jan 2019 13:09:09 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLYe_H_BF5SK2GWjYL9P7RJ9t0oadjDNnDL7UTXfb_Jfw@mail.gmail.com>
Message-ID: <CAGXu5jLYe_H_BF5SK2GWjYL9P7RJ9t0oadjDNnDL7UTXfb_Jfw@mail.gmail.com>
Subject: Re: [GIT PULL] security: seccomp changes for v4.21
To:     Ingo Molnar <mingo@kernel.org>, Tycho Andersen <tycho@tycho.ws>
Cc:     James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jan 7, 2019 at 2:15 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * James Morris <jmorris@namei.org> wrote:
>
> > From Kees:
> >
> > "- Add SECCOMP_RET_USER_NOTIF
> >
> > - seccomp fixes for sparse warnings and s390 build (Tycho)"
> >
> >
> >
> > The following changes since commit 1072bd678547f8663cfb81a22fdb50c589e4976e:
> >
> >   security: fs: make inode explicitly non-modular (2018-12-12 14:58:51 -0800)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-seccomp
> >
> > for you to fetch changes up to 55b8cbe470d103b44104c64dbf89e5cad525d4e0:
> >
> >   Merge tag 'seccomp-next-part2' of https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux into next-seccomp (2018-12-17 11:36:26 -0800)
> >
> > ----------------------------------------------------------------
> > James Morris (2):
> >       Merge tag 'seccomp-next' of https://git.kernel.org/.../kees/linux into next-seccomp
> >       Merge tag 'seccomp-next-part2' of https://git.kernel.org/.../kees/linux into next-seccomp
> >
> > Tycho Andersen (6):
> >       seccomp: hoist struct seccomp_data recalculation higher
> >       seccomp: switch system call argument type to void *
> >       seccomp: add a return code to trap to userspace
> >       samples: add an example of seccomp user trap
> >       seccomp: fix poor type promotion
> >       seccomp, s390: fix build for syscall type change
> >
> >  Documentation/ioctl/ioctl-number.txt           |   1 +
> >  Documentation/userspace-api/seccomp_filter.rst |  84 +++++
> >  arch/s390/kernel/compat_wrapper.c              |   2 +-
> >  include/linux/seccomp.h                        |   9 +-
> >  include/linux/syscalls.h                       |   2 +-
> >  include/uapi/linux/seccomp.h                   |  40 ++-
> >  kernel/seccomp.c                               | 467 ++++++++++++++++++++++++-
> >  samples/seccomp/.gitignore                     |   1 +
> >  samples/seccomp/Makefile                       |   7 +-
> >  samples/seccomp/user-trap.c                    | 375 ++++++++++++++++++++
> >  tools/testing/selftests/seccomp/seccomp_bpf.c  | 447 ++++++++++++++++++++++-
> >  11 files changed, 1411 insertions(+), 24 deletions(-)
> >  create mode 100644 samples/seccomp/user-trap.c
>
> 32-bit x86 allyesconfig doesn't build:
>
>  /usr/bin/ld: i386:x86-64 architecture of input file `samples/seccomp/user-trap.o' is incompatible with i386 output
>  /usr/bin/ld: samples/seccomp/user-trap.o: file class ELFCLASS64 incompatible with ELFCLASS32
>  /usr/bin/ld: final link failed: File in wrong format
>  collect2: error: ld returned 1 exit status
>  scripts/Makefile.host:99: recipe for target 'samples/seccomp/user-trap' failed
>  make[2]: *** [samples/seccomp/user-trap] Error 1
>
> Is this a known regression?

That looks like something is busted in the samples Makefile? Tycho,
are you able to reproduce this?

-Kees

-- 
Kees Cook
