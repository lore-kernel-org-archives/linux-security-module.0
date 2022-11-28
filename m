Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C989DC4321E
	for <linux-security-module@archiver.kernel.org>; Mon, 28 Nov 2022 03:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiK1DxG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 27 Nov 2022 22:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiK1DxF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 27 Nov 2022 22:53:05 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3255581
        for <linux-security-module@vger.kernel.org>; Sun, 27 Nov 2022 19:53:03 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d6so8961247pll.7
        for <linux-security-module@vger.kernel.org>; Sun, 27 Nov 2022 19:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UF1ge54xIUAlHX2n++cnMUpCa6Myhy4vGKBhQP7XRwo=;
        b=N51njAkDPRiOvWBJH4TPhl1rnQ6neieaIE+cew6kxfjHluLG7+EMzZzDDNtTGHGfcr
         9Jh+WxwP+N6kB6VIS4R/KwFFzt27vDQqypOd82UiEGdu3TTVPNnwVnZT3IiVj+invY6y
         GOceA9n6zIdpWzkbEnTXm042AyYYqbOcpmi0bdUm/9a/utH74s4zfLeHQ/6E6KLc1DPy
         207LZrRBpbu8OgbNts8XwsW6qA/VDzRJzxujROxsnnrEijRJs1LLROke2qhcmzjv7VtZ
         u9/5RbH9FYjOj0rt1ELKI5XOdV6/DtLhAJsGKN3qUfuHWkC5JEN3E/Y7OrIbilp0wjRn
         cFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UF1ge54xIUAlHX2n++cnMUpCa6Myhy4vGKBhQP7XRwo=;
        b=7VYBSIyOuHMLSQGBoVKRHiexxtU22cjbY13oks334xjKE1w5szPRDqVCShvi50eBUP
         Jwky2cPsDMKzFKEJzeq7CqPH2hKEacs1Jj3WW27DCvdoa9kQ3VMEMQt7Z4u13UXVmwEp
         qXN85aLgKxdE67HAvQLeGK396bwEe3PA/TgtjuNo642a1qGKHcmUABx/7D+Y3VSTQhdV
         r3F9Nw2M5e8aZnYHwGPLKYkGutKhtz3NgJRWK4t7LcUUHbCEHHP2FokPfA0RFE/Zbt/c
         uis3HpN0ZaQDmUuEHOMPyyBHXDoEPt3Ip2XMFxmG8FXcBrCZs9AFnrpWwj1QcgHQ0jix
         XNBQ==
X-Gm-Message-State: ANoB5pk4I7npJKlAKXnJ3reiXnf0hZJR0rk1+3RelhcrY3R7sUEzkQmO
        FJQSnHk8YLlIGBn+7WW+yU7eySk4MRBiJlnmkMaU
X-Google-Smtp-Source: AA0mqf7wQ2Uzn8UK+DPd4zA53So8KNWWgBEQFu8jmGln9wvg2shTpNANXvScuOP43LvWLdpGWPhbL0yBMvrh277NzsY=
X-Received: by 2002:a17:902:9892:b0:186:c3b2:56d1 with SMTP id
 s18-20020a170902989200b00186c3b256d1mr30991891plp.15.1669607583130; Sun, 27
 Nov 2022 19:53:03 -0800 (PST)
MIME-Version: 1.0
References: <20221123201552.7865-1-casey@schaufler-ca.com> <20221123201552.7865-2-casey@schaufler-ca.com>
 <94ac3c49-550b-c517-680f-ba653d568f72@digikod.net>
In-Reply-To: <94ac3c49-550b-c517-680f-ba653d568f72@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 27 Nov 2022 22:52:52 -0500
Message-ID: <CAHC9VhSza-P0hG_iSdW8MCAKaykUW5eLBkpg=bb4-D_=7-j3+Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] LSM: Identify modules by more than name
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Nov 25, 2022 at 11:30 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
> On 23/11/2022 21:15, Casey Schaufler wrote:
> > Create a struct lsm_id to contain identifying information
> > about Linux Security Modules (LSMs). At inception this contains
> > the name of the module and an identifier associated with the
> > security module. Change the security_add_hooks() interface to
> > use this structure. Change the individual modules to maintain
> > their own struct lsm_id and pass it to security_add_hooks().
> >
> > The values are for LSM identifiers are defined in a new UAPI
> > header file linux/lsm.h. Each existing LSM has been updated to
> > include it's LSMID in the lsm_id.
> >
> > The LSM ID values are sequential, with the oldest module
> > LSM_ID_CAPABILITY being the lowest value and the existing modules
> > numbered in the order they were included in the main line kernel.
> > This is an arbitrary convention for assigning the values, but
> > none better presents itself. The value 0 is defined as being invalid.
> > The values 1-99 are reserved for any special case uses which may
> > arise in the future.
> >
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > ---
> >   include/linux/lsm_hooks.h    | 16 ++++++++++++++--
> >   include/uapi/linux/lsm.h     | 32 ++++++++++++++++++++++++++++++++
> >   security/apparmor/lsm.c      |  8 +++++++-
> >   security/bpf/hooks.c         | 13 ++++++++++++-
> >   security/commoncap.c         |  8 +++++++-
> >   security/landlock/cred.c     |  2 +-
> >   security/landlock/fs.c       |  2 +-
> >   security/landlock/ptrace.c   |  2 +-
> >   security/landlock/setup.c    |  6 ++++++
> >   security/landlock/setup.h    |  1 +
> >   security/loadpin/loadpin.c   |  9 ++++++++-
> >   security/lockdown/lockdown.c |  8 +++++++-
> >   security/safesetid/lsm.c     |  9 ++++++++-
> >   security/security.c          | 12 ++++++------
> >   security/selinux/hooks.c     |  9 ++++++++-
> >   security/smack/smack_lsm.c   |  8 +++++++-
> >   security/tomoyo/tomoyo.c     |  9 ++++++++-
> >   security/yama/yama_lsm.c     |  8 +++++++-
> >   18 files changed, 141 insertions(+), 21 deletions(-)
> >   create mode 100644 include/uapi/linux/lsm.h

...

> > diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> > new file mode 100644
> > index 000000000000..47791c330cbf
> > --- /dev/null
> > +++ b/include/uapi/linux/lsm.h
> > @@ -0,0 +1,32 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/*
> > + * Linux Security Modules (LSM) - User space API
> > + *
> > + * Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
> > + * Copyright (C) 2022 Intel Corporation
> > + */
> > +
> > +#ifndef _UAPI_LINUX_LSM_H
> > +#define _UAPI_LINUX_LSM_H
> > +
> > +/*
> > + * ID values to identify security modules.
> > + * A system may use more than one security module.
> > + *
> > + * Values 1-99 are reserved for future use in special cases.
>
> This line should be removed unless justified. What could be special
> about IDs? The syscalls already have a "flags" argument, which is enough.
>
> > + */
> > +#define LSM_ID_INVALID               0
>
> Reserving 0 is good, but it doesn't deserve a dedicated declaration.
> LSM_ID_INVALID should be removed.
>
>
> > +#define LSM_ID_CAPABILITY    100
>
> This should be 1=E2=80=A6

No.  Scratch that, make that an emphatic "No".

If you want to argue for a different reserved low-number range, e.g.
something with a nice power-of-2 limit, I'm okay with that, but as I
wrote earlier I feel strongly we need to have a low-number reserved
range for potential future uses.

--=20
paul-moore.com
