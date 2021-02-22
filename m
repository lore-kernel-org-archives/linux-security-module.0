Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0B5C433E0
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Feb 2021 21:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59AEA64E25
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Feb 2021 21:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhBVVNq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Feb 2021 16:13:46 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:35651 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhBVVNo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Feb 2021 16:13:44 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 8DFFB56122A;
        Mon, 22 Feb 2021 22:12:58 +0100 (CET)
Received: by mail-ot1-f54.google.com with SMTP id h22so5126854otr.6;
        Mon, 22 Feb 2021 13:12:58 -0800 (PST)
X-Gm-Message-State: AOAM5325Ke9+2OhWW7sd5b7WRjfp6Ecwh1rA9Qr9fY0c4GpKuxD9PfJU
        aRAPS151TctyuSthueKl5AkDTxkjQ9VDoEsy3o8=
X-Google-Smtp-Source: ABdhPJwmK3muigXNi8XZXhn+ic4o+uiZ5UpZpQT0fWB8nOdB5z1mzOL6/KQn824EU99Pvwo5PyKpG3gvJw1bxg76XvM=
X-Received: by 2002:a9d:dc9:: with SMTP id 67mr7261434ots.26.1614028377527;
 Mon, 22 Feb 2021 13:12:57 -0800 (PST)
MIME-Version: 1.0
References: <20210222150608.808146-1-mic@digikod.net> <20210222150608.808146-2-mic@digikod.net>
 <51725b44-bc40-0205-8583-285d3b35b5ca@schaufler-ca.com> <ee461f8d-a02d-0782-8f31-691853a57f00@digikod.net>
 <7b67163a-9de1-313f-5b5a-8c720cef9b73@schaufler-ca.com>
In-Reply-To: <7b67163a-9de1-313f-5b5a-8c720cef9b73@schaufler-ca.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 22 Feb 2021 22:12:46 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=n5FOxHXMLRrDQ3F-kDqbYngNoYKcz6_PWi1rPa0_8WpA@mail.gmail.com>
Message-ID: <CAJfZ7=n5FOxHXMLRrDQ3F-kDqbYngNoYKcz6_PWi1rPa0_8WpA@mail.gmail.com>
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
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Feb 22 22:12:59 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Feb 22, 2021 at 9:32 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 2/22/2021 10:31 AM, Mickaël Salaün wrote:
> > On 22/02/2021 17:51, Casey Schaufler wrote:
> >> On 2/22/2021 7:06 AM, Mickaël Salaün wrote:
> >>> From: Mickaël Salaün <mic@linux.microsoft.com>
> >>>
> >>> Add a new option CONFIG_LSM_AUTO to enable users to delegate default LSM
> >>> stacking order to kernel developers.  This enable to keep a consistent
> >>> order of enabled LSM when changing the LSM selection, especially when a
> >>> new LSM is added to the kernel.
> >> TL;DR - NAK
> >>
> >> Do you think that we might have considered this when stacking was
> >> introduced?
> > I didn't dig the detailed history of LSM stacking, but you are in Cc
> > because I know that you know. I may have though that the main goal of
> > the current LSM stacking implementation was to enable to stack existing
> > LSMs, which works well with this CONFIG_LSM list, but doesn't work as
> > well for new LSMs.
>
> It works just fine for new LSMs if you treat them as significant
> features which may have significant impact on the behavior of the
> system.
>
> >> Did you even consider the implications before sending
> >> the patch?
> > Yes, and it doesn't change much the current behavior without user
> > interaction. However, it gives the choice to users to choose how they
> > want their configuration to evolve.
>
> Automatic inclusions of new LSMs would be counter to existing practice.
> It won't work for "major" LSMs.
>
>
> >> This only makes any sense if you want to compile in
> >> AppArmor and/or Smack but always use SELinux. The existing Kconfig
> >> model handles that perfectly well.
> > This patch series doesn't change this behavior if the user doesn't want
> > it to change.
>
> Well, there's the question. If a distribution/system uses the new scheme
> "users" are going to get new LSMs spontaniously. If they don't it's up to
> the "user". Unsophisticated users won't want this, and the others don't
> need it.

Hello, sorry if I missed something simple but I did not understand
what "Automatic inclusions of new LSMs " and "get new LSMs
spontaniously" is about. If I understood the kernel practice
development correctly, when a new LSM will be included, it will have a
dedicated "config SECURITY_MYNEWLSM" which will be default to "n" in
order to respect the "principle of least astonishment". How could such
a new LSM be automatically/spontaneously added to the LSM list?

I understand that this is a tough issue and that the subject might
have been discussed a few years ago, and if that's the case, it would
be nice to have pointers to some clear documentation or past emails
(and it would be very very nice if the kernel documentation was
updated to document the current state of LSM stacking: for example
https://www.kernel.org/doc/html/v5.11/admin-guide/LSM/index.html still
documents the "security=" kernel parameter even though it conflicts
with CONFIG_LSM and can be ignored by the kernel in practise).

Thanks,
Nicolas

