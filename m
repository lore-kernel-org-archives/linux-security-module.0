Return-Path: <SRS0=qseI=6O=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99197C8300B
	for <linux-security-module@archiver.kernel.org>; Thu, 30 Apr 2020 11:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7147D207DD
	for <linux-security-module@archiver.kernel.org>; Thu, 30 Apr 2020 11:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5VuDmhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgD3LBe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726413AbgD3LBd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 30 Apr 2020 07:01:33 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59916C035494
        for <linux-security-module@vger.kernel.org>; Thu, 30 Apr 2020 04:01:33 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so1381196wmc.5
        for <linux-security-module@vger.kernel.org>; Thu, 30 Apr 2020 04:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lFFxK4DtytcE6RpAFl8YJiEBCoYUrJi5EC/p8/Y25iA=;
        b=f5VuDmhyUjEspScUeszN5n8DPGcEiF/Kok9r2XQcaRe8HDfwuUTjWP4f00L9FgVpR6
         NwrnkORD6lm6KvLluh5w59qQbKGxSAS44/NqciSnz039zIu/mHcI+vU5AHQsV+NmkfVr
         2wk0iYhDyLiGTZFSRNC7xo8I9oxNI1yh7E8bUl9fe+UMfMfdBO5QFMqgwxpgtqJixBIJ
         nzKHb0khXvNE1r3a2NF9Ib5NUDnWpC51UlhYpkPtdJXUcSg/2kdiJzqetXJ7v7YWlZr/
         RRuw/gMakeQ5lAPHyVeiUFgbvw9ZfIwxNWNJ87QjflMf7FFzL6O7O7DWFFSgP58BUTAu
         l+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lFFxK4DtytcE6RpAFl8YJiEBCoYUrJi5EC/p8/Y25iA=;
        b=mrt88Z5gFkQYeEQClC2aNCzf1t2bnd9/gEDeiDQhb5rPhZJf0DelSM4NfRkVNKP668
         VfQT1dlH3xLHUx421v+LBRU7FrJnOIvww1NV9rq0zFanEUwLztRpCc++0IvNKkr+Kn8X
         FCLJnL2NQMQhZebZiaqTqb5cnhJANdb1FI1j9OpwvjtKUcELBIclXbIcxAiYF6VLNO+3
         AFHDZmySnLJerPrh2Zdm+lNC7Nibr2etbVJHrtR7O9IXUMUg8RbY9qA/2X7zJgUmGij8
         F3rwgS3HinLYHHCsyM2M7m6QbfiYfZT1bNcpg3G72YLF+xMoO0Cr99vKz9tfkf3ElBrj
         dzXg==
X-Gm-Message-State: AGi0PuZZTK3hhkqRR6/npvG3y8FSVl33g0hoG1USL+j8RJnoO+mUhzG7
        R3yN3z9jay/byIS2LUviKu+tPlZGalLWXQijuHk=
X-Google-Smtp-Source: APiQypLouP4lVbKqpnSX7OlYl+j6EOSiT1pw349EOnWeumTX5PjyI+H/ngeTt/eryzVdA1cq5n6/uYXQL49LzeEGesE=
X-Received: by 2002:a1c:a512:: with SMTP id o18mr2301640wme.138.1588244491958;
 Thu, 30 Apr 2020 04:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200428175129.634352-1-mic@digikod.net> <20200430015429.wuob7m5ofdewubui@yavin.dot.cyphar.com>
In-Reply-To: <20200430015429.wuob7m5ofdewubui@yavin.dot.cyphar.com>
From:   "Lev R. Oshvang ." <levonshe@gmail.com>
Date:   Thu, 30 Apr 2020 14:01:21 +0300
Message-ID: <CAP22eLE6DA5P+Cx6aVP=eq3tKRGz=+P+w8omk3CcEXVo0f1Nfg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Add support for RESOLVE_MAYEXEC
To:     Aleksa Sarai <cyphar@cyphar.com>, viro@zeniv.linux.org.uk
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Eric Chiang <ericchiang@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        kernel-hardening@lists.openwall.com,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Apr 30, 2020 at 4:55 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> On 2020-04-28, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wrote:
> > The goal of this patch series is to enable to control script execution
> > with interpreters help.  A new RESOLVE_MAYEXEC flag, usable through
> > openat2(2), is added to enable userspace script interpreter to delegate
> > to the kernel (and thus the system security policy) the permission to
> > interpret/execute scripts or other files containing what can be seen as
> > commands.
> >
> > This third patch series mainly differ from the previous one by relying
> > on the new openat2(2) system call to get rid of the undefined behavior
> > of the open(2) flags.  Thus, the previous O_MAYEXEC flag is now replace=
d
> > with the new RESOLVE_MAYEXEC flag and benefits from the openat2(2)
> > strict check of this kind of flags.
>
> My only strong upfront objection is with this being a RESOLVE_ flag.
>
> RESOLVE_ flags have a specific meaning (they generally apply to all
> components, and affect the rules of path resolution). RESOLVE_MAYEXEC
> does neither of these things and so seems out of place among the other
> RESOLVE_ flags.
>
> I would argue this should be an O_ flag, but not supported for the
> old-style open(2). This is what the O_SPECIFIC_FD patchset does[1] and I
> think it's a reasonable way of solving such problems.
>
> --
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> <https://www.cyphar.com/>

I see that we discuss here the problem which was originated due to the
lack of flags checks at open()
As a newbie in kernel I want to propose maybe naive approach - add
missing flag cheeks to open().
In order to not break badly coded  application at once (applications
hat pass full u32 number I propose to introduce
2 new sysctls:
fs.verify_open_flags =3D BITMASK of flags open() uses in this kernel,
i.r O_CREAT||O_RDOBLY|O_RDWR,,
fs.verify_open_flags_action =3D NONE|WARN
1) fs.verify_open_flags  and flags_action  knobs will allow
distributions and package maintainers to detect and fix bad code. On
the other hand, it will allow to finally verify flags. passed to open
2) It will show kernel ABI to libc

3) The semantics of O_MAYEXEC is clear and is long waited for.
I think that O_MAYEXEC pretty well describes the intention of
application to treat the file as the source of actions, whether it is
ELF or script or another format. (not necessary Posix permissions
case)
This intention is passed to the kernel and then to LSM, IMA.

4) since we need to rewrite interpretersin order to use this flag, we
can also query fs.verify_open_flags to see whether it is available.

I hope I added my 2 cents.
