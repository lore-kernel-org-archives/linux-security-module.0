Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A0CC433F5
	for <linux-security-module@archiver.kernel.org>; Thu, 12 May 2022 22:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359045AbiELWD3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 12 May 2022 18:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348898AbiELWD2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 12 May 2022 18:03:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E4B27F114
        for <linux-security-module@vger.kernel.org>; Thu, 12 May 2022 15:03:27 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k126-20020a1ca184000000b003943fd07180so3766790wme.3
        for <linux-security-module@vger.kernel.org>; Thu, 12 May 2022 15:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3Jn18d1qZKkOahd53J55xmHFXF7VdRPAAkhlV5tmYKk=;
        b=nYmdMV2ntKt4lkJ7yOQvkzf/JRzEtl7Rf1dfsSfviFUJJ2ww0eDAbukGeZi9l1oZH4
         Qh+b9pEWhyiFfOhaMMGX6qFfk76VfOmeYrKMbYcjTLGXrh4KWnY/2cTdkNMhcoV+M2mA
         1HgMDAxMaUsFNtCTE6yqdg+3mfJZbh8fp7pw00PeWEKlYjK0YO7SQnBl+srCsydffv2a
         9S4tlexQUxnNurok5tYEtz6zo7uC460tChpaSl3gTCyUowhFirAUe5nkl78F4vrE4A1I
         EUNvvpOmqAuOw9aDSdyLe/CkgKNoiaN1YSgkuyeBakU1BmA0Xx6RjCojAIcEDN8LhVZg
         uA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3Jn18d1qZKkOahd53J55xmHFXF7VdRPAAkhlV5tmYKk=;
        b=dMG5JEcvbmT4zkY4C+Z43VW17PNqNZKpHcMtOYPluUza7frr1o5uxproprx92SmT0E
         VuD4Id3z7Oe3pH0AwIQk7UWDXJ2uQnVfY0ULBES49eGxlYubWWye5589AoqBRRinj9xG
         PdhebxM6ADP+kJkGJro8pdJw5TwEhhY5LCqWvS2JDxMqhj58zHhcbSaUrYZxNzqyNTCI
         1Vni3tiGTLnPxtgqCj+WzzZBmkMqWr4Uv5GfUbn+rMTpqa5mgFiY8+DbTOk2epUjTaMJ
         X9ttAMI7iJ0Uc9UnIILodHMw6vy83Tzeaoe5xtxaxVANF4xHcnhi0YXusWvCe9BkCQcg
         Mb9g==
X-Gm-Message-State: AOAM530VU6+P72rIN6OHgeaHbm8UxZsFmAiJQc39jutVGjM62q70RmvL
        vtYOHCc349G4rQnzVXUCFqCyrILiytW/Aq1W7pYS
X-Google-Smtp-Source: ABdhPJwsuxnGt76AlK3oHZf22gRwtAWrjwzm8UOEjWL3AzczIKoP/A/YwUjiu7WxfneTyX6HeEVPC1M31RluJkCmwk4=
X-Received: by 2002:a05:600c:4fd0:b0:394:7999:98ab with SMTP id
 o16-20020a05600c4fd000b00394799998abmr1607349wmq.179.1652393006170; Thu, 12
 May 2022 15:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220512120847.124822-1-mic@digikod.net>
In-Reply-To: <20220512120847.124822-1-mic@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 May 2022 18:03:15 -0400
Message-ID: <CAHC9VhRDYnKmSGiNzED5bsT+hGarFBO9M2qHR8v1SKj4zGqMeQ@mail.gmail.com>
Subject: Re: [PATCH v1] landlock: Explain how to support Landlock
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 12, 2022 at 8:08 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
> Let's help users by documenting how to enable and check for Landlock in
> the kernel and the running system.  The userspace-api section may not be
> the best place for this but it still makes sense to put all the user
> documentation at the same place.
>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20220512120847.124822-1-mic@digikod.net
> ---
>  Documentation/userspace-api/landlock.rst | 26 ++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/use=
rspace-api/landlock.rst
> index 7b4fe6218132..e69dbddcc191 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -388,6 +388,32 @@ Starting with the Landlock ABI version 2, it is now =
possible to securely
>  control renaming and linking thanks to the new `LANDLOCK_ACCESS_FS_REFER=
`
>  access right.
>
> +Landlock support
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Kernel configuration
> +--------------------

I would suggest changing the section name to "Kernel build
configuration" to make it clear the instructions below need to be done
at build time.

> +Landlock can be supported since Linux 5.13 but it must be configured in =
the

I would suggest rephrasing the first part of this sentence slightly:

"Landlock was first introduced in Linux v5.13 but it must be ..."

> +kernel with `CONFIG_SECURITY_LANDLOCK=3Dy`, and it should be enabled at =
boot time

CONFIG_LSM is a Kconfig build time variable not a runtime command line
variable, yes?

> +with `CONFIG_LSM=3Dlandlock,[...]`.  The `[...]` must be replaced with t=
he list
> +of LSMs that may be useful for the running system (see the `CONFIG_LSM` =
help).
> +
> +Running system configuration
> +----------------------------

This is nit-picky, but I would suggest a section name of "Kernel
command line configuration".

> +If the running kernel doesn't have `landlock` in `CONFIG_LSM`, then we c=
an
> +still enable it by adding `lsm=3Dlandlock,[...]` to
> +Documentation/admin-guide/kernel-parameters.rst. The `[...]` must be rep=
laced
> +with the list of LSMs that may be useful for the running system (see the
> +`CONFIG_LSM` help).
> +
> +Running system check
> +--------------------
> +
> +We can check that Landlock is enabled by looking for "landlock: Up and r=
unning"
> +in kernel logs: `dmesg | grep landlock`

I would suggest moving the "Running system check" section up closer to
the top of the documentation, perhaps right before the "Landlock
rules" section.  My thinking is that it is better to mention this as
soon as possible in the doc so that users can verify Landlock is
present and functioning before trying any of the code examples and
failing.  I think it is okay to leave the "how to enable Landlock"
sections at the bottom and simply refer to them in the "system check"
section.

--=20
paul-moore.com
