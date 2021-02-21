Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE73C433E0
	for <linux-security-module@archiver.kernel.org>; Sun, 21 Feb 2021 08:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EF9664F04
	for <linux-security-module@archiver.kernel.org>; Sun, 21 Feb 2021 08:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhBUI7o (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 21 Feb 2021 03:59:44 -0500
Received: from condef-07.nifty.com ([202.248.20.72]:17871 "EHLO
        condef-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhBUI7o (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 21 Feb 2021 03:59:44 -0500
Received: from conssluserg-02.nifty.com ([10.126.8.81])by condef-07.nifty.com with ESMTP id 11L8qAa7027714
        for <linux-security-module@vger.kernel.org>; Sun, 21 Feb 2021 17:52:10 +0900
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 11L8p770023054;
        Sun, 21 Feb 2021 17:51:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 11L8p770023054
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1613897468;
        bh=iqSwxMKCsABy6iNhZE+GhtPoF7o0BPskBBd/oYpdaVM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KXkXcUclwPXA+p41WdrF368SHfROjI46ag/aUVk1uhN+j9dTGFnv7Tx4SqIyWT/I1
         xWoWk/tH6GqlJhL+gAp2y26wZ1nKxKRDpRPNE8Wx4olEIkHIixFLTu+wiJolUmzQyc
         Rx7h6TpyaQyp6IOIKP7NQ9CcqePqqbM6oNQbmY6odRpTHVId0iMpu2h53Uc501ciw/
         If5AgFvKfH5Rfhf4gbM1LQV+eDvbAvdIGQhAjqLHmw9aBNJ9qsXWdjZWh8yYnxWvY3
         LGGKsOnh3pQEeEdzeY3p+c8n6Txl1cUR4LN+h8cBkBrchRj4EZbs7GOqZLBI8qjurW
         kseafs/+YKgIg==
X-Nifty-SrcIP: [209.85.214.173]
Received: by mail-pl1-f173.google.com with SMTP id k22so5779268pll.6;
        Sun, 21 Feb 2021 00:51:07 -0800 (PST)
X-Gm-Message-State: AOAM531HoRFK1VYYXjFri6OYU0WztYyD9/kAKjYsQZF15Pd9p3CsY64W
        OZKvOtw/oZ4mg4C3IWJ50adIv7628HWQEn98vaM=
X-Google-Smtp-Source: ABdhPJz4v+i0r5snD6o0LrGuQWEhgrI/x1QvyGhW0xTHrdmb2lJuHI2hRLwGwpdSdd9nuBTOIQ6nWL8SfzzX9mxDhFQ=
X-Received: by 2002:a17:90a:609:: with SMTP id j9mr17818087pjj.198.1613897466983;
 Sun, 21 Feb 2021 00:51:06 -0800 (PST)
MIME-Version: 1.0
References: <20210215181511.2840674-1-mic@digikod.net> <20210215181511.2840674-4-mic@digikod.net>
 <CAFqZXNsvqx-pbC+wzHB4aXX6h=buU3csM_a=By-zCOmx0n-xCQ@mail.gmail.com>
In-Reply-To: <CAFqZXNsvqx-pbC+wzHB4aXX6h=buU3csM_a=By-zCOmx0n-xCQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 21 Feb 2021 17:50:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQDWxGJU41D4+AbjFiX63BiA+bsNzTHZsKKc-LPyO7oCQ@mail.gmail.com>
Message-ID: <CAK7LNAQDWxGJU41D4+AbjFiX63BiA+bsNzTHZsKKc-LPyO7oCQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] security: Add LSMs dependencies to CONFIG_LSM
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 16, 2021 at 4:03 AM Ondrej Mosnacek <omosnace@redhat.com> wrote=
:
>
> On Mon, Feb 15, 2021 at 7:17 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net=
> wrote:
> > From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> >
> > Thanks to the previous commit, this gives the opportunity to users, whe=
n
> > running make oldconfig, to update the list of enabled LSMs at boot time
> > if an LSM has just been enabled or disabled in the build.  Moreover,
> > this list only makes sense if at least one LSM is enabled.
> >
> > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: Serge E. Hallyn <serge@hallyn.com>
> > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> > Link: https://lore.kernel.org/r/20210215181511.2840674-4-mic@digikod.ne=
t
> > ---
> >
> > Changes since v1:
> > * Add CONFIG_SECURITY as a dependency of CONFIG_LSM.  This prevent an
> >   error when building without any LSMs.
> > ---
> >  security/Kconfig | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/security/Kconfig b/security/Kconfig
> > index 7561f6f99f1d..addcc1c04701 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -277,6 +277,10 @@ endchoice
> >
> >  config LSM
> >         string "Ordered list of enabled LSMs"
> > +       depends on SECURITY || SECURITY_LOCKDOWN_LSM || SECURITY_YAMA |=
| \
> > +               SECURITY_LOADPIN || SECURITY_SAFESETID || INTEGRITY || =
\
> > +               SECURITY_SELINUX || SECURITY_SMACK || SECURITY_TOMOYO |=
| \
> > +               SECURITY_APPARMOR || BPF_LSM
>
> This looks really awkward, since all of these already depend on
> SECURITY (if not, it's a bug)... I guarantee you that after some time
> someone will come, see that the weird boolean expression is equivalent
> to just SECURITY, and simplify it.


Currently, LSM does not depend on SECURITY.
So you can always define LSM irrespective of SECURITY,
which seems a bug.

So, I agree with adding 'depends on SECURITY'.

What he is trying to achieve in this series
seems wrong, of course.










> I assume the new mechanism wouldn't work as intended if there is just
> SECURITY? If not, then maybe you should rather specify this value
> dependency via some new  field rather than abusing "depends on" (say,
> "value depends on"?). The fact that a seemingly innocent change to the
> config definition breaks your mechanism suggests that the design is
> flawed.
>
> I do think this would be a useful feature, but IMHO shouldn't be
> implemented like this.
>
> >         default "lockdown,yama,loadpin,safesetid,integrity,smack,selinu=
x,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> >         default "lockdown,yama,loadpin,safesetid,integrity,apparmor,sel=
inux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> >         default "lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" =
if DEFAULT_SECURITY_TOMOYO
> > --
> > 2.30.0
> >
>
> --
> Ondrej Mosnacek
> Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
>


--=20
Best Regards
Masahiro Yamada
