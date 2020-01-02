Return-Path: <SRS0=bjmC=2X=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156ECC3276C
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Jan 2020 21:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE54F21655
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Jan 2020 21:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="JHUeC6kg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgABVix (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Jan 2020 16:38:53 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39155 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgABViw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Jan 2020 16:38:52 -0500
Received: by mail-lf1-f66.google.com with SMTP id y1so30707630lfb.6
        for <linux-security-module@vger.kernel.org>; Thu, 02 Jan 2020 13:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=izh5OZYGkrVzZGLIRcnwDr2NJ38SgGkZzimGiFC85rk=;
        b=JHUeC6kgRc7fARcX9H3QlNeMTy+P4yRjwwanYEvUwTaWZzkpfSbsaK3UyNoj0OHU2C
         xPQoPc41CGC1QSMKjBDinNrphMxA5ymzxTzVwLtY1U9OMJjQpdwu2qSCLrj8ZCFel5Yi
         syDDiEW1eyLAoYXkRq4tUMl4IF0dyCxSzYrgarEpVJ7GF25rDFysfpyNPIZmTkCdBX6S
         N7/+Ljdg98HGUa/uru1y5GXGYxfF5n4GDC2RoZzaBy5psnkiSC1EZ5ndZ63HtSxczOLb
         0AV4dCzkb9ZOiznqb6OWgXgFypIRT8HZ3mlzLBAf643m3/JReSELaRndRX3fWlc66vwP
         iNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=izh5OZYGkrVzZGLIRcnwDr2NJ38SgGkZzimGiFC85rk=;
        b=GBlYFS7Kuw+0vCoZH1JKY3IIlhJdG4IeI7ZaAaf22rHwNL2Fs2dOgcLWzSqFWG0Ytl
         P3aib+k5vV+4fEGAx+S2zrQ4nnTE87l+eoBZbMrx/ed22F/fSgpyU2mrwGP9voxK2Oif
         G5HPxuiCgXwKHgpbb8ERhHGkRulVaiYKHOCEfnaP4kOznhntdpZRguU0Q8EDhi+GtNZI
         Xzj5pYuojjQPIa1va6Op08quD5Qvy5wn+XCtd4PXmN9e9z8p0rVGHDqYF14S/suHOyVO
         rk5vLsOtC0esflWaGiHbe37PI+KbqYW/LV8UfMkQR4skZ62M/iWgwwyxMufXE4PV63pI
         TTZA==
X-Gm-Message-State: APjAAAXG+LJtNjA2Ez7WMnB2MXBqQLoR3o6QnHkkuyZwGySbylHRvSVB
        O5J1+JfdYIY9/N27u3oCTXlv0EHnBiyChQ4csRta
X-Google-Smtp-Source: APXvYqwoswRj9bnDPK46FXYdSXFYDaRM0Be7smpomLXlpCqekeelAeOs0ridng5WOkH8jBBD8k2T6g223srvXrir3+c=
X-Received: by 2002:a19:ae04:: with SMTP id f4mr48293482lfc.64.1578001130689;
 Thu, 02 Jan 2020 13:38:50 -0800 (PST)
MIME-Version: 1.0
References: <157678334821.158235.2125894638773393579.stgit@chester> <CAFqZXNvXuWx-kCJeZKOgx4NSesCvnC63kHf6-=_SrFLH4xubag@mail.gmail.com>
In-Reply-To: <CAFqZXNvXuWx-kCJeZKOgx4NSesCvnC63kHf6-=_SrFLH4xubag@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 2 Jan 2020 16:38:39 -0500
Message-ID: <CAHC9VhTHroatmHKt3Saru18TktFY8EXjsxkx-pWvx87-RUx8HA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: deprecate disabling SELinux and runtime
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jan 2, 2020 at 4:24 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Dec 19, 2019 at 8:22 PM Paul Moore <paul@paul-moore.com> wrote:
> > Deprecate the CONFIG_SECURITY_SELINUX_DISABLE functionality.  The
> > code was originally developed to make it easier for Linux
> > distributions to support architectures where adding parameters to the
> > kernel command line was difficult.  Unfortunately, supporting runtime
> > disable meant we had to make some security trade-offs when it came to
> > the LSM hooks, as documented in the Kconfig help text:
> >
> >   NOTE: selecting this option will disable the '__ro_after_init'
> >   kernel hardening feature for security hooks.   Please consider
> >   using the selinux=0 boot parameter instead of enabling this
> >   option.
> >
> > Fortunately it looks as if that the original motivation for the
> > runtime disable functionality is gone, and Fedora/RHEL appears to be
> > the only major distribution enabling this capability at build time
> > so we are now taking steps to remove it entirely from the kernel.
> > The first step is to mark the functionality as deprecated and print
> > an error when it is used (what this patch is doing).  As Fedora/RHEL
> > makes progress in transitioning the distribution away from runtime
> > disable, we will introduce follow-up patches over several kernel
> > releases which will block for increasing periods of time when the
> > runtime disable is used.  Finally we will remove the option entirely
> > once we believe all users have moved to the kernel cmdline approach.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Looks reasonable, informal ACK from me.

Thanks.  You want to make that a formal ACK? ;)

-- 
paul moore
www.paul-moore.com
