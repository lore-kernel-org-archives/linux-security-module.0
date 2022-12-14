Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B0CC4332F
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Dec 2022 23:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiLNXeH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 14 Dec 2022 18:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiLNXdk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 14 Dec 2022 18:33:40 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E5C21A0
        for <linux-security-module@vger.kernel.org>; Wed, 14 Dec 2022 15:32:54 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c13so5571919pfp.5
        for <linux-security-module@vger.kernel.org>; Wed, 14 Dec 2022 15:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EX38wRipK6YZXjwZPd7Su4K9Er1H54jvjyAx9rqRw1Q=;
        b=PDEg3nH3xgHnheIK+JiFoLehsOV0gTUq21j4kLrRR1ZLvl25FbD7m8LX1fSIYwz/87
         PIxzI5e9Pfn8V6aq1oOKcTbffZGDbFjXTXJhyLPaPkgFnINJjvhacuxaIOC1x6UwmVsZ
         d3iVOkBRfgId+oB/p//Pexfh3cuN+6pDvx6QMWBzGeykcVt02UbhvWYbj5G/9VF1Mrgi
         SOuvClJPMP6WbasvMUuLP1kVi84M3frkmNzV0VYdxvfWNm8RJXyMUXR2L9ZznH7S//1F
         vMvSYMesxZ8hHbbrwxzlnOR/mS/6Ywx+ti6WoVXe+D/TlHqjypG2vGA+5YOFEjXALgM4
         JWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EX38wRipK6YZXjwZPd7Su4K9Er1H54jvjyAx9rqRw1Q=;
        b=0/IttmqxWfctvKzh+hpua1kLK3YZp0cbtPOIFvQ8NYzlBpqfg9lcroWd6hZ4KEJASt
         Mgabc5qpVxALKBZL2vimR5/sJXJ1Qa7txlyvkeo4DJgf0HDVah6bHcOamKKoIexZZAbJ
         7icG/+BIzBn5H4o7gGyUThqk1wtStSV1D8Fc8p5KosLkH7eVvyfPFUysebtGvh8VlGJz
         SJd/vRwBSQfyOlgjPtActcOurAqcVL1gVfVvmicy58vavS+b2VMfZ7X6FqCJb1B7KIyT
         ojuB0Qor2Ed96ThW6BtKt0Lfce+lndHLtlyeo/kEmCn5zTm2RFTAYh8ndUULtxVX7RSf
         GtFg==
X-Gm-Message-State: ANoB5plCXC2+JEhLl0qCxahAbEPIwqSVoO7FyvubqgrHlkFBPvw+Tjev
        KEFe4mQuARbCSFp1e6zUHf5TWj3ADKvJ8rH+lIwqIQ==
X-Google-Smtp-Source: AA0mqf6FrLS1D7V7SRNCy3k8CyVO9nDpptYhTX527VVCoLeeGz/DIxUaHIqaRhNRIJVDOOmwzpQTEeBAzUWYmJerZnw=
X-Received: by 2002:a63:f04d:0:b0:470:5d17:a62e with SMTP id
 s13-20020a63f04d000000b004705d17a62emr68719053pgj.620.1671060773915; Wed, 14
 Dec 2022 15:32:53 -0800 (PST)
MIME-Version: 1.0
References: <20221209160453.3246150-1-jeffxu@google.com> <202212141053.7F5D1F6@keescook>
In-Reply-To: <202212141053.7F5D1F6@keescook>
From:   Jeff Xu <jeffxu@google.com>
Date:   Wed, 14 Dec 2022 15:32:16 -0800
Message-ID: <CALmYWFss4hGOgJaeah8p7q86xmE7AOwOazxggGCuY=A+ZUVWhQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] mm/memfd: introduce MFD_NOEXEC_SEAL and MFD_EXEC
To:     Kees Cook <keescook@chromium.org>
Cc:     jeffxu@chromium.org, skhan@linuxfoundation.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Dec 14, 2022 at 10:54 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Dec 09, 2022 at 04:04:47PM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@google.com>
> >
> > Since Linux introduced the memfd feature, memfd have always had their
> > execute bit set, and the memfd_create() syscall doesn't allow setting
> > it differently.
> >
> > However, in a secure by default system, such as ChromeOS, (where all
> > executables should come from the rootfs, which is protected by Verified
> > boot), this executable nature of memfd opens a door for NoExec bypass
> > and enables =E2=80=9Cconfused deputy attack=E2=80=9D.  E.g, in VRP bug =
[1]: cros_vm
> > process created a memfd to share the content with an external process,
> > however the memfd is overwritten and used for executing arbitrary code
> > and root escalation. [2] lists more VRP in this kind.
> >
> > On the other hand, executable memfd has its legit use, runc uses memfd=
=E2=80=99s
> > seal and executable feature to copy the contents of the binary then
> > execute them, for such system, we need a solution to differentiate runc=
's
> > use of  executable memfds and an attacker's [3].
> >
> > To address those above, this set of patches add following:
> > 1> Let memfd_create() set X bit at creation time.
> > 2> Let memfd to be sealed for modifying X bit.
> > 3> A new pid namespace sysctl: vm.memfd_noexec to control the behavior =
of
> >    X bit.For example, if a container has vm.memfd_noexec=3D2, then
> >    memfd_create() without MFD_NOEXEC_SEAL will be rejected.
> > 4> A new security hook in memfd_create(). This make it possible to a ne=
w
> > LSM, which rejects or allows executable memfd based on its security pol=
icy.
>
> I think patch 1-5 look good to land. The LSM hook seems separable, and
> could continue on its own. Thoughts?
>
Agreed.

> (Which tree should memfd change go through?)
>
I'm not sure, is there a recommendation ?

Thanks.
Jeff

> -Kees
>
> --
> Kees Cook
