Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C41C433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Feb 2021 06:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FEBF64DA3
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Feb 2021 06:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhBWGXI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Feb 2021 01:23:08 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:55321 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbhBWGWI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Feb 2021 01:22:08 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 1CEE6564E08;
        Tue, 23 Feb 2021 07:21:19 +0100 (CET)
Received: by mail-ot1-f48.google.com with SMTP id d9so390787ote.12;
        Mon, 22 Feb 2021 22:21:18 -0800 (PST)
X-Gm-Message-State: AOAM53128Q62lzVkktKznPuzWuzeQ4aUaxse48XdJBgcAXmzbln42Omo
        nGmF9QJbAIe+Tc5eYPXdP0bqGZVpFeZMLXLajb8=
X-Google-Smtp-Source: ABdhPJwfVvUyAYF7jvfPMHbDtpYxK7VJPG1FiU1BvYhjPT5npoJy+c43+4etOLGaia6bdyAEHSwqdLWZrxFE+qJSAnM=
X-Received: by 2002:a05:6830:115:: with SMTP id i21mr19340481otp.96.1614061277868;
 Mon, 22 Feb 2021 22:21:17 -0800 (PST)
MIME-Version: 1.0
References: <20210222150608.808146-1-mic@digikod.net> <20210222150608.808146-2-mic@digikod.net>
 <51725b44-bc40-0205-8583-285d3b35b5ca@schaufler-ca.com> <ee461f8d-a02d-0782-8f31-691853a57f00@digikod.net>
 <7b67163a-9de1-313f-5b5a-8c720cef9b73@schaufler-ca.com> <CAJfZ7=n5FOxHXMLRrDQ3F-kDqbYngNoYKcz6_PWi1rPa0_8WpA@mail.gmail.com>
 <3b97e25b-303c-d732-3e5d-f1b1a446e090@schaufler-ca.com>
In-Reply-To: <3b97e25b-303c-d732-3e5d-f1b1a446e090@schaufler-ca.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 23 Feb 2021 07:21:07 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=ny5xon0qX9_KPu12Ntdef9NfvjHWBow8q-yvjVhfdt0g@mail.gmail.com>
Message-ID: <CAJfZ7=ny5xon0qX9_KPu12Ntdef9NfvjHWBow8q-yvjVhfdt0g@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] security: Add CONFIG_LSM_AUTO to handle default
 LSM stack ordering
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Feb 23 07:21:20 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Feb 22, 2021 at 11:46 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>
> On 2/22/2021 1:12 PM, Nicolas Iooss wrote:
> > On Mon, Feb 22, 2021 at 9:32 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 2/22/2021 10:31 AM, Mickaël Salaün wrote:
> >>> On 22/02/2021 17:51, Casey Schaufler wrote:
> >>>> On 2/22/2021 7:06 AM, Mickaël Salaün wrote:
> >>>>> From: Mickaël Salaün <mic@linux.microsoft.com>
> >>>>>
> >>>>> Add a new option CONFIG_LSM_AUTO to enable users to delegate default LSM
> >>>>> stacking order to kernel developers.  This enable to keep a consistent
> >>>>> order of enabled LSM when changing the LSM selection, especially when a
> >>>>> new LSM is added to the kernel.
> >>>> TL;DR - NAK
> >>>>
> >>>> Do you think that we might have considered this when stacking was
> >>>> introduced?
> >>> I didn't dig the detailed history of LSM stacking, but you are in Cc
> >>> because I know that you know. I may have though that the main goal of
> >>> the current LSM stacking implementation was to enable to stack existing
> >>> LSMs, which works well with this CONFIG_LSM list, but doesn't work as
> >>> well for new LSMs.
> >> It works just fine for new LSMs if you treat them as significant
> >> features which may have significant impact on the behavior of the
> >> system.
> >>
> >>>> Did you even consider the implications before sending
> >>>> the patch?
> >>> Yes, and it doesn't change much the current behavior without user
> >>> interaction. However, it gives the choice to users to choose how they
> >>> want their configuration to evolve.
> >> Automatic inclusions of new LSMs would be counter to existing practice.
> >> It won't work for "major" LSMs.
> >>
> >>
> >>>> This only makes any sense if you want to compile in
> >>>> AppArmor and/or Smack but always use SELinux. The existing Kconfig
> >>>> model handles that perfectly well.
> >>> This patch series doesn't change this behavior if the user doesn't want
> >>> it to change.
> >> Well, there's the question. If a distribution/system uses the new scheme
> >> "users" are going to get new LSMs spontaniously. If they don't it's up to
> >> the "user". Unsophisticated users won't want this, and the others don't
> >> need it.
> > Hello, sorry if I missed something simple but I did not understand
> > what "Automatic inclusions of new LSMs " and "get new LSMs
> > spontaniously" is about. If I understood the kernel practice
> > development correctly, when a new LSM will be included, it will have a
> > dedicated "config SECURITY_MYNEWLSM" which will be default to "n" in
> > order to respect the "principle of least astonishment". How could such
> > a new LSM be automatically/spontaneously added to the LSM list?
>
> It wouldn't. But compiling the new LSM mynewlsm doesn't add it to
> the list, either. Today no one should expect a LSM to be active if
> it hasn't been added to the CONFIG_LSM list. The proposed addition
> of CONFIG_LSM_AUTO would change that. "make oldconfig" would add
> security modules that are built to the list. This is unnecessary
> since whoever changed CONFIG_SECURITY_MYNEWLSM to "y" could easily
> have added it to CONFIG_LSM. In the right place.
>
> > I understand that this is a tough issue and that the subject might
> > have been discussed a few years ago, and if that's the case, it would
> > be nice to have pointers to some clear documentation or past emails
> > (and it would be very very nice if the kernel documentation was
> > updated to document the current state of LSM stacking:
>
> I'm not going to argue against that.
>
> >  for example
> > https://www.kernel.org/doc/html/v5.11/admin-guide/LSM/index.html still
> > documents the "security=" kernel parameter even though it conflicts
> > with CONFIG_LSM and can be ignored by the kernel in practise).
>
> You can still select one "major" module using security= if you
> don't use lsm= to specify a full list. We put real effort into
> being backward compatible.

No, this is not true. If CONFIG_LSM is defined to "lockdown,yama,bpf"
and if the kernel command line contains "security=selinux" without any
"lsm" parameter, then SELinux is not enabled properly.

This broke the configuration of several Arch Linux users (cf.
https://bbs.archlinux.org/viewtopic.php?id=263360 and
https://github.com/archlinuxhardened/selinux/issues/81) and I reported
this on some kernel mailing lists a few days ago
(https://lore.kernel.org/linux-security-module/CAJfZ7=nWJisw2RRW2AvFgpYKQK_PghudeBqiTQXNfedS2idP-Q@mail.gmail.com/).
Your answer to this issue was very clear (and thank you for explaining
this):

« You can't (currently) use SELinux and BPF at the same time. This is
because the infrastructure does not support multiple secid<->secctx
translation hooks. You get the first one in the list. BPF provides all
hooks, so the SELinux hooks aren't reached and the secid to secctx
translation fails in the "bpf,selinux" case. »

Anyway, this means that using "security=..." does not work if
CONFIG_LSM contains the BPF LSM module, so no: you *cannot* select one
major module using security=, when the kernel is compiled with
CONFIG_LSM="lockdown,yama,bpf".

Backward compatibility was broken and Arch Linux users were required
to switch to lsm= in order to use AppArmor, SELinux, etc. (and the
documentation of this distribution got updated:
https://wiki.archlinux.org/index.php/AppArmor,
https://wiki.archlinux.org/index.php/SELinux, etc.).

Nicolas

