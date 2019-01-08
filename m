Return-Path: <SRS0=cuGm=PQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE954C43387
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Jan 2019 23:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDDC214C6
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Jan 2019 23:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RINc9Z/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfAHXbI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:31:08 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39994 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbfAHXbG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Jan 2019 18:31:06 -0500
Received: by mail-vs1-f66.google.com with SMTP id z3so3621692vsf.7
        for <linux-security-module@vger.kernel.org>; Tue, 08 Jan 2019 15:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fj1hGcIq46+n7srV6RvX7Dt1TPMiykx9jEzwUwjBvIY=;
        b=RINc9Z/oBU9n/IiWeg9VoFbkVbXqBq4w0FD27eLdMWabbZLjrmSBNFOsGpEFa8A/bR
         oYiqTw2sln/Iowse0uRNjuG2y4+5aTOizsgcRPXrqzqsZY6a6Z+un43x6oNHNJO1rgLh
         z61iNZSHdc4T96fhOcPNU3UmZiId8PLEGRMso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fj1hGcIq46+n7srV6RvX7Dt1TPMiykx9jEzwUwjBvIY=;
        b=bHx9eNCtvFRvY2QkUprIQpeHUgsVmxgYgUQ2UnaQf1GjOWuRHqFZU3S1jUzAMxxQpA
         /WnBsR9TzGIDk1NJmS065Vb4XlhkSL7dOlnhkt41VPVijhL06L4yFBjJJf3aonFlpCwF
         UUvSPJOBVDPSg9bQTPiNdDYECqDuhKmt6KIU45UZy6Kmyy8+5RHNXprCyTrLMfxndpjt
         /ak3xL291YZsj+GqBdzHDWaDC8rURu0iNYsJOHVMyAMTYAaDXFOv3juGIWh0Q1BgHG1D
         03EAO+H2DzD1pCgLffTD9CsjKe2ixBrcNgEXfWBKgMl1QldxbqZKhSfoMVOSSCG44fSB
         bt5w==
X-Gm-Message-State: AJcUukfpRJ6vN7+Ct8aZrtd3w7bjYEVvMIfghUZ1hm5tyn64rdxXqocF
        fUf7bRTSqemO7tf5E+C4ligRp0KbThQ=
X-Google-Smtp-Source: ALg8bN6N+6D2LVFJ45feUx+Cm6m+TqAeMPynAVa5J4FT8jG/8O5EauxSzinU3OBz1paiEkNq0eRBCA==
X-Received: by 2002:a67:df04:: with SMTP id s4mr1455776vsk.212.1546990265024;
        Tue, 08 Jan 2019 15:31:05 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id b131sm28187965vkf.45.2019.01.08.15.31.01
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 15:31:02 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id d201so1285390vka.0
        for <linux-security-module@vger.kernel.org>; Tue, 08 Jan 2019 15:31:01 -0800 (PST)
X-Received: by 2002:a1f:3d10:: with SMTP id k16mr1401233vka.13.1546990261237;
 Tue, 08 Jan 2019 15:31:01 -0800 (PST)
MIME-Version: 1.0
References: <20181212081712.32347-1-mic@digikod.net> <20181212081712.32347-4-mic@digikod.net>
 <CAG48ez3SAW8EyaJ9T1U3qPoRhYwe4CCyL9bAxuc3GxjrXipi-A@mail.gmail.com>
 <f13bf750-f418-343c-baa6-9eee6e0f5e19@ssi.gouv.fr> <CAG48ez00CpXOOJPLgpQd_e0gG2KgYb1p8bwssA8FDOugHTxRAA@mail.gmail.com>
 <0f7d39f8-035b-8566-94c9-ea836b280e24@ssi.gouv.fr>
In-Reply-To: <0f7d39f8-035b-8566-94c9-ea836b280e24@ssi.gouv.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 8 Jan 2019 15:30:49 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKHPE6WfbXpiwzm=vRbgJ-rCePxsrYmVzZ1+RURp-6nJg@mail.gmail.com>
Message-ID: <CAGXu5jKHPE6WfbXpiwzm=vRbgJ-rCePxsrYmVzZ1+RURp-6nJg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/5] Yama: Enforces noexec mounts or file
 executability through O_MAYEXEC
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>
Cc:     Jann Horn <jannh@google.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        philippe.trebuchet@ssi.gouv.fr, Shuah Khan <shuah@kernel.org>,
        thibaut.sautereau@ssi.gouv.fr, vincent.strubel@ssi.gouv.fr,
        Perez Yves-Alexis <yves-alexis.perez@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jan 8, 2019 at 5:29 AM Micka=C3=ABl Sala=C3=BCn
<mickael.salaun@ssi.gouv.fr> wrote:
>
>
> On 03/01/2019 12:17, Jann Horn wrote:
> > On Thu, Dec 13, 2018 at 3:49 PM Micka=C3=ABl Sala=C3=BCn
> > <mickael.salaun@ssi.gouv.fr> wrote:
> >> On 12/12/2018 18:09, Jann Horn wrote:
> >>> On Wed, Dec 12, 2018 at 9:18 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod=
.net> wrote:
> >>>> Enable to either propagate the mount options from the underlying VFS
> >>>> mount to prevent execution, or to propagate the file execute permiss=
ion.
> >>>> This may allow a script interpreter to check execution permissions
> >>>> before reading commands from a file.
> >>>>
> >>>> The main goal is to be able to protect the kernel by restricting
> >>>> arbitrary syscalls that an attacker could perform with a crafted bin=
ary
> >>>> or certain script languages.  It also improves multilevel isolation
> >>>> by reducing the ability of an attacker to use side channels with
> >>>> specific code.  These restrictions can natively be enforced for ELF
> >>>> binaries (with the noexec mount option) but require this kernel
> >>>> extension to properly handle scripts (e.g., Python, Perl).

I like this idea, but I think it shouldn't live in Yama (since it is
currently intended to be a ptrace-policy-only LSM). It was
_originally_ designed to do various DAC improvements, but the
agreement was that those should live directly in the VFS instead (i.e.
the symlink, hardlink and now fifo and regular file defenses).

This should likely go in similarly. (But if not, it could also be its own L=
SM.)

--=20
Kees Cook
