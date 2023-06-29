Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14273EB64DC
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Jun 2023 04:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjF2Edm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Jun 2023 00:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjF2Edk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Jun 2023 00:33:40 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5B8213D
        for <linux-security-module@vger.kernel.org>; Wed, 28 Jun 2023 21:33:38 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-392116ae103so212452b6e.0
        for <linux-security-module@vger.kernel.org>; Wed, 28 Jun 2023 21:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688013217; x=1690605217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJW2r3ntggsBVvy1ila5sjLU4Aw8geyuKy3kMy86JU8=;
        b=Oirx2ssq91MRt0ie2O1eepU4Csg8OJ2yDunQfSdCo0mSH0OqwXaLkb+02b3nMlfuIF
         tyyOfQDBnTHmVypFsesVF3grpD7EFFj+dNe5tQn31FwPEmXyfxkvGgUCfpZH4qDxt/ey
         E9KTWDd4AdMv5GWgLYQC+wGlLbEbbLDkFpGK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688013217; x=1690605217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJW2r3ntggsBVvy1ila5sjLU4Aw8geyuKy3kMy86JU8=;
        b=LeIKgFPSixAebMx1Q1/lssVwm3cFaE+iDdMQBTRVMRGFb7ejUHKblK4kHSk744lXAC
         AY1ekRPKBFxeGSsnSu9S9ytDoeWGktc68A4nwIEC4eE1rG8Gzfq5etfdBTEUx5nXsWnW
         pmzKevRE0qBLhrJxrXyZpzAz+4aWzw25dNSATVQzrrt7oI+93VAT/AYXyVFv9LEJsETG
         Rn4wPdGqLJnp8j/2tjKn/KZmuti6mB4U+XKPDRpNF7V0er6I9Udqiono8XT3FtX8VPsM
         OrBKJ4TLy2mOZ9uvTm5G5axqYpJrRDFY5UHQ5lJ2RWClOuWGrKxuhc308FuA5Q5NFZWr
         QLFQ==
X-Gm-Message-State: AC+VfDyGt2GZr8FwwfkcB9HaKVFiBtif4XmOTMO6XBSJVygHPBSzL2OX
        NJAXFAIDX3BRb8vlcRjNWSKIjxT7C3Cib0ROBmEiMQ==
X-Google-Smtp-Source: ACHHUZ4WbBcGDRw30mJTQOdCSRmryXfsnM4fcbrvXYszwENk4IYIuPTU/UqW//jSW9jKBg3jtjF1hU6rRnoLABDI0PA=
X-Received: by 2002:a05:6808:314:b0:3a0:61b4:1bed with SMTP id
 i20-20020a056808031400b003a061b41bedmr16676381oie.35.1688013217553; Wed, 28
 Jun 2023 21:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221215001205.51969-1-jeffxu@google.com> <20221215001205.51969-4-jeffxu@google.com>
 <ZJwcsU0vI-nzgOB_@codewreck.org> <ZJyKeeqRJxzwlMhk@codewreck.org>
In-Reply-To: <ZJyKeeqRJxzwlMhk@codewreck.org>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Wed, 28 Jun 2023 21:33:27 -0700
Message-ID: <CABi2SkWnAgHK1i6iqSqPMYuNEhtHBkO8jUuCvmG3RmUB5TKHJw@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     skhan@linuxfoundation.org, keescook@chromium.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello!

On Wed, Jun 28, 2023 at 12:31=E2=80=AFPM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Dominique Martinet wrote on Wed, Jun 28, 2023 at 08:42:41PM +0900:
> > If flags already has either MFD_EXEC or MFD_NOEXEC_SEAL, you don't chec=
k
> > the sysctl at all.
> > [...repro snipped..]
> >
> > What am I missing?
>
> (Perhaps the intent is just to force people to use the flag so it is
> easier to check for memfd_create in seccomp or other LSM?
> But I don't see why such a check couldn't consider the absence of a flag
> as well, so I don't see the point.)
>
Yes. There is consideration to motivate app devs to migrate their code
to use the new EXEC/NOEXEC_SEAL flag for memfd_create, if that answers
your question.

>
> > BTW I find the current behaviour rather hard to use: setting this to 2
> > should still set NOEXEC by default in my opinion, just refuse anything
> > that explicitly requested EXEC.
>
> And I just noticed it's not possible to lower the value despite having
> CAP_SYS_ADMIN: what the heck?! I have never seen such a sysctl and it
> just forced me to reboot because I willy-nilly tested in the init pid
> namespace, and quite a few applications that don't require exec broke
> exactly as I described below.
>
> If the user has CAP_SYS_ADMIN there are more container escape methods
> than I can count, this is basically free pass to root on main namespace
> anyway, you're not protecting anything. Please let people set the sysctl
> to what they want.
>
Yama has a similar setting,  for example, 3 (YAMA_SCOPE_NO_ATTACH)
will not allow downgrading at runtime.

Since this is a security feature, not allowing downgrading at run time
is part of the security consideration. I hope you understand.

> --
> Dominique Martinet | Asmadeus

Thanks!
-Jeff
