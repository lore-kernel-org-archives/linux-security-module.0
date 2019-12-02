Return-Path: <SRS0=f5xb=ZY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBAEC432C0
	for <linux-security-module@archiver.kernel.org>; Mon,  2 Dec 2019 22:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9535E2071E
	for <linux-security-module@archiver.kernel.org>; Mon,  2 Dec 2019 22:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="v7rxaNor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfLBWzo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 2 Dec 2019 17:55:44 -0500
Received: from mail-40135.protonmail.ch ([185.70.40.135]:32840 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfLBWzn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 2 Dec 2019 17:55:43 -0500
Date:   Mon, 02 Dec 2019 22:55:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1575327340;
        bh=UAVwIU53cQNHQD9YkIGgensK9qrKRvgUP5BwFWsqyBY=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=v7rxaNorLODaE6ExXEvhfDxee7dbh1tjNaAXOPUJ8kr6LQuKTbXGubyuaENCHHR3J
         K0VhKuc7sBehKD4u3UIavCR1ltOMJNsKTLVRWEzLg8dsVjMruRPkXgchmtvVwn5s+w
         H2hwoKKBPFk1tnxYO+JKWawt6659nhMqXWRh14h8=
To:     Matt Parnell <mparnell@gmail.com>
From:   Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     Kees Cook <keescook@chromium.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "matthew.garrett@nebula.com" <matthew.garrett@nebula.com>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: [PATCH] Kernel Lockdown: Add an option to allow raw MSR access even, in confidentiality mode.
Message-ID: <-uRGQFmc8hMANlmvOpPXEib39VyGsx15MXwgVf-vripxhDcjILDfe5O17fyf5MXoZflmIE4avp7SqW4ijO1kHPqgHJMCqg1fWtXeGylu2uc=@protonmail.ch>
In-Reply-To: <96625b06-3bba-6831-7127-22b690fccf1b@gmail.com>
References: <339ca47a-6ed1-4ab4-f8cf-7b205fa9f773@gmail.com>
 <201911301035.74813D4533@keescook>
 <f415ec28-8440-3b29-176c-50da09247ea3@gmail.com>
 <f988a531-a7f8-cef6-d3b4-6fbd89f5351f@gmail.com>
 <96625b06-3bba-6831-7127-22b690fccf1b@gmail.com>
Feedback-ID: QEdvdaLhFJaqnofhWA-dldGwsuoeDdDw7vz0UPs8r8sanA3bIt8zJdf4aDqYKSy4gJuZ0WvFYJtvq21y6ge_uQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Monday, December 2, 2019 6:29 PM, Matt Parnell <mparnell@gmail.com> wrot=
e:

> After doing some research it appears that for Intel chips, only a single
> register needs to be writeable. I'm not sure about AMD etc.
>
> intel-undervolt/blob/master/config.h:
>
> =C2=A0=C2=A0=C2=A0 #define MSR_ADDR_TEMPERATURE 0x1a2
> =C2=A0=C2=A0=C2=A0 #define MSR_ADDR_UNITS 0x606
> =C2=A0=C2=A0=C2=A0 #define MSR_ADDR_VOLTAGE 0x150
>
> Perhaps add an MSR whitelist to allow writing, if
> LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY=3DY and
> CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=3DY?
>
> CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is likely what prevents Apparmor or
> some other LSM policy manager allow this behavior...
>
> as an option at build time would be more sensible?
>
> On 12/1/19 2:53 PM, Matt Parnell wrote:
>
> > That is, I was intending to use lockdown from boot, which isn't
> > changeable after the fact if I'm not mistaken. How possible is granular
> > control of what is and is not locked down?
> > On 11/30/19 1:09 PM, Matt Parnell wrote:
> >
> > > I can see how using a policy would be beneficial; I only did this
> > > because as I understood it, policy wouldn't be able to change these
> > > particular settings since anything attempting to do so would be from
> > > userspace.
> > > On 11/30/19 12:36 PM, Kees Cook wrote:
> > >
> > > > On Sat, Nov 30, 2019 at 12:49:48AM -0600, Matt Parnell wrote:
> > > >
> > > > > From 452b8460e464422d268659a8abb93353a182f8c8 Mon Sep 17 00:00:00=
 2001
> > > > > From: Matt Parnell mparnell@gmail.com
> > > > > Date: Sat, 30 Nov 2019 00:44:09 -0600
> > > > > Subject: [PATCH] Kernel Lockdown: Add an option to allow raw MSR =
access even
> > > > > =C2=A0in confidentiality mode.
> > > > > For Intel CPUs, some of the MDS mitigations utilize the new "flus=
h" MSR, and
> > > > > while this isn't something normally used in userspace, it does ca=
use false
> > > > > positives for the "Forshadow" vulnerability.
> > > > > Additionally, Intel CPUs use MSRs for voltage and frequency contr=
ols,
> > > > > which in
> > > > > many cases is useful for undervolting to avoid excess heat.

Could you clarify if blocking msr breaks internal power management of intel
cpu or it only prevents manual tinkering with it by user? If the latter the=
n
I think it's ok to keep it as is.

Jordan
