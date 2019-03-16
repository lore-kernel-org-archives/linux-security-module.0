Return-Path: <SRS0=wxE6=RT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0368BC43381
	for <linux-security-module@archiver.kernel.org>; Sat, 16 Mar 2019 05:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30BA218A1
	for <linux-security-module@archiver.kernel.org>; Sat, 16 Mar 2019 05:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PHpq2Y6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbfCPFZI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 16 Mar 2019 01:25:08 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42467 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfCPFZI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 16 Mar 2019 01:25:08 -0400
Received: by mail-vs1-f68.google.com with SMTP id c189so6620505vsd.9
        for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2019 22:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XUbM3rN6drZ5zRdiVKP0Jupxp7VX7qkDWLnxB94bLb4=;
        b=PHpq2Y6EoC7crtH3QoJhAhEHi1h5Ttz1exB6gxDFa2jykFZZJ0CQOuRFbrE/tnU63Z
         Utb5Aw7HOdRT7kwLllWlEERORUgRvPWjz4RkDoSoKKgZTIlIwWzRRcyCOwB7nUXyuE9D
         tdJFI+fkmyEPF1/MhX4uKLgEV0RuKzE3hNXjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XUbM3rN6drZ5zRdiVKP0Jupxp7VX7qkDWLnxB94bLb4=;
        b=Jp3l8GUlUfAWBVqh66WS711XY503JW63GpxE0ZLP1ee4yvs/y0xcPxxh+tnfqY4JRe
         OHHjU/taYquO70o7uD0d4lmRhj5jGkKgzYGz5e8MM6WeOVbm31qxkikrBgCHUy+b4IqB
         N0FS7wbSNfsEaLk07FwpKwT2X3L20nPIpDbuPfFpvEgousNM37J9XPw3u+MYDQT5+rKw
         1TylJbNiqrboJSU+bQhICcVoYREbfJuR14SY626ZG/vbcZ8/qV7e0mHy7qqVoFMMpqRg
         DHPi6Nm0tjJAnbt1ovA8U+F5EjyjROJBvA+0fWKdA0V6zQTRGVMeAePbXWIVn5SrKQvi
         UG7g==
X-Gm-Message-State: APjAAAVCET2PlG5FeRh1FN6UvFgOHQgo39bEZYE/zrUIy3CauzczQ5mW
        DtnhM7VUcSMucMsPYeGfup/UZ4GmrGY=
X-Google-Smtp-Source: APXvYqwiWBNdNrV7gJV2wZ1+V5kQ5xMjfzCgvy7R5fUuuH0okm57Ky0efaJvQ9yq5LUopVcVAwkSzA==
X-Received: by 2002:a67:f90e:: with SMTP id t14mr3970725vsq.181.1552713906531;
        Fri, 15 Mar 2019 22:25:06 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id b19sm991652vsd.6.2019.03.15.22.25.05
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 22:25:05 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id n14so6605911vsp.12
        for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2019 22:25:05 -0700 (PDT)
X-Received: by 2002:a67:ed0c:: with SMTP id l12mr3959329vsp.66.1552713904745;
 Fri, 15 Mar 2019 22:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190315110555.0807d015@cakuba.netronome.com> <20190315120105.5541ad46@cakuba.netronome.com>
 <20190315165440.53b9db3c@cakuba.netronome.com>
In-Reply-To: <20190315165440.53b9db3c@cakuba.netronome.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 15 Mar 2019 22:24:53 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKHRPuaALQcPXvpDeuVgZR+EeRqo9Qj4j3kYatb3HUSSA@mail.gmail.com>
Message-ID: <CAGXu5jKHRPuaALQcPXvpDeuVgZR+EeRqo9Qj4j3kYatb3HUSSA@mail.gmail.com>
Subject: Re: mount.nfs: Protocol error after upgrade to linux/master
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Mar 15, 2019 at 4:54 PM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Fri, 15 Mar 2019 12:01:05 -0700, Jakub Kicinski wrote:
> > On Fri, 15 Mar 2019 11:05:55 -0700, Jakub Kicinski wrote:
> > > Hi,
> > >
> > > I just upgraded from:
> > >
> > > commit a3b1933d34d5bb26d7503752e3528315a9e28339 (net)
> > > Merge: c6873d18cb4a 24319258660a
> > > Author: David S. Miller <davem@davemloft.net>
> > > Date:   Mon Mar 11 16:22:49 2019 -0700
> > >
> > > to
> > >
> > > commit 3b319ee220a8795406852a897299dbdfc1b09911
> > > Merge: 9352ca585b2a b6e88119f1ed
> > > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > > Date:   Thu Mar 14 10:48:14 2019 -0700
> > >
> > > and I'm seeing:
> > >
> > > # mount /home/
> > > mount.nfs: Protocol error
> > >
> > > No errors in dmesg, please let me know if it's a known problem or what
> > > other info could be of use.
> >
> > Hm.. I tried to bisect but reverting to that commit doesn't help.
> >
> > Looks like the server responds with:
> >
> >   ICMP parameter problem - octet 22, length 80
> >
> > pointing at some IP options (type 134)...
>
> Okay, figured it out, it's the commit 13e735c0e953 ("LSM: Introduce
> CONFIG_LSM") and all the related changes in security/
>
> I did olddefconfig and it changed my security module from apparmor to
> smack silently.  smack must be slapping those IP options on by default.
>
> Pretty awful user experience, and a non-zero chance that users who
> upgrade their kernels will miss this and end up with the wrong security
> module...

I wonder if we can add some kind of logic to Kconfig to retain the old
CONFIG_DEFAULT_SECURITY and include it as the first legacy-major LSM
listed in CONFIG_LSM?

Like, but the old selector back in, but mark is as "soon to be
entirely replaced with CONFIG_LSM" and then make CONFIG_LSM's default
be "yama,loadpin,safesetid,integrity,$(CONFIG_DEFAULT_SECURITY),selinux,smack,tomoyo,apparmor"
? Duplicates are ignored...

-- 
Kees Cook
