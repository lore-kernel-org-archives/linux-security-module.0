Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA84C2BB3F
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Nov 2023 17:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjKORVX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Nov 2023 12:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKORVW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Nov 2023 12:21:22 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF130BB
        for <linux-security-module@vger.kernel.org>; Wed, 15 Nov 2023 09:21:17 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d9ca471cf3aso7168231276.2
        for <linux-security-module@vger.kernel.org>; Wed, 15 Nov 2023 09:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700068877; x=1700673677; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvnGVZuZf7IT7KtcV9AmNBQCflffOcnaJ9h4MWpxbCg=;
        b=SFq4L0T1ZFwFJl+xL6ic19oEuS0Efahnl/OoX5aL0spKvH6iQFMrf/KNdhZataYfKY
         rZB45wJgfxwccznk1ePnmSgR7oTA0YPB+nb6nyXMZUD+qGLeaX9XgUr6ltC3LQw79FBk
         r9PYHtK5Yf0miwynYPmJTujHcalvEnqjhu3i4kn2wolClEU9qWIK6xFOy/hl+QXM5YL3
         +o25W9iZ7Itr0ywdHQVsdFhN8retFjiZxrXHAX+XQeKA3hwtKHaEAOyx0DeR23ipVxcR
         sPm4fYRQaiwNoQun7eOKvHz2Z19d0Uyq2IUV4HB1tRTmCmO7/cRIhhS+r60IQBJmFwZF
         BB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700068877; x=1700673677;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JvnGVZuZf7IT7KtcV9AmNBQCflffOcnaJ9h4MWpxbCg=;
        b=Jfwrfx/wz2i6VdV2KqFbCY3uqHXy7/2pVYugEhA2+liVxPCMWfrGpYpeu10XEPBurR
         ZCJnoueljv374ougoFbiVdKSoF2u2OBNk3j6RzwHKuXQOxuxAVO+xfc4DQiYXTF/N1pd
         FgufPeGIgNgMpiZUnSKhyXvSD/7dp/uMsMCs72EB5Q72863YNonOxff4Ev+G7Nv0DvjJ
         QHiq9E7ugETt+XaqFUYvk2ZLS7PMc2z271w55pz1NHWIBn8kQjOV5Ms6mJaZxhz6KTz0
         WjWXESEpxsSm3/JpaXajPesmpGC9jlIHYmlrD++ZNDocQI5+Fbzx2vuBCyiwmpLaMY6P
         nUVA==
X-Gm-Message-State: AOJu0YxV/1zCX0MTD0zxtbH3qJuWKRTJjd5dPnpQuszv0Kg6FQPYL3zk
        xEgFuCEnKJr0ulVsDm7bl2fS1ttzokjKpLc/3fmK3fUg4US3Nvs=
X-Google-Smtp-Source: AGHT+IHgkn0kPO7vT2GbHfKQ0vBz3sApdIwV4qqXpJuZTr2GpSmdm3Na1jDaC49qF/aSJtgRD9uiZeCLgvw1hridNO8=
X-Received: by 2002:a25:cec5:0:b0:daf:56fe:41f8 with SMTP id
 x188-20020a25cec5000000b00daf56fe41f8mr13007069ybe.11.1700068876746; Wed, 15
 Nov 2023 09:21:16 -0800 (PST)
MIME-Version: 1.0
References: <20231115164832.100894-2-paul@paul-moore.com>
In-Reply-To: <20231115164832.100894-2-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 15 Nov 2023 12:21:05 -0500
Message-ID: <CAHC9VhToYWVTmXmmXMdGE3XZcBV65RrFWvFaYX+nWd-Mr6k=yA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update the LSM entry
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 15, 2023 at 11:48=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Bring the LSM / "SECURITY SUBSYSTEM" entry up to date with the
> following changes:
>
> * Remove the "(suggested Cc:)" note on the mailing list.  I don't
> really care if the LSM list is on the To: or Cc: line, I just want
> folks to include it when appropriate.
>
> * Remove the website link.  The website isn't really maintained in
> any meaningful way so we're going to go ahead and remove it so we
> lessen the chance of conflicting or confusing information in the
> future.
>
> * Add our patchwork link.  I'm not sure this is of much use for
> anyone but the maintainer, but there is a provision for including it
> here so we might as well include it.
>
> * Add a bug report URI.  I suspect most everyone knows to send mail
> to the mailing list if they hit a bug, but let's make it official.
>
> * Add a link to the LSM tree process/management documentation.  While
> the doc exists both in the canonical kernel.org location and the
> GitHub mirror, provide a link to the mirror as GitHub does a better
> job rendering the Markdown.
>
> * Aside from changes to the LSM code itself, we also would like to be
> notified when the LSMM call sites are changed so we are adding a
> security_XXX(...) regex to try and catch all of the callers.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  MAINTAINERS | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2482b40fd786..007e43ee3e47 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19507,14 +19507,17 @@ SECURITY SUBSYSTEM
>  M:     Paul Moore <paul@paul-moore.com>
>  M:     James Morris <jmorris@namei.org>
>  M:     "Serge E. Hallyn" <serge@hallyn.com>
> -L:     linux-security-module@vger.kernel.org (suggested Cc:)
> +L:     linux-security-module@vger.kernel.org
>  S:     Supported
> -W:     http://kernsec.org/
> +Q:     https://patchwork.kernel.org/project/linux-security-module/list
> +B:     mailto:linux-security-module@vger.kernel.org
> +P:     https://github.com/LinuxSecurityModule/kernel/blob/main/README.md
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git

Unfortunately I didn't realize this until the patch hit my inbox, but
I should also update the tree location to use https instead of git.
I'll fix that when I merge the patch.

>  F:     include/uapi/linux/lsm.h
>  F:     security/
>  F:     tools/testing/selftests/lsm/
>  X:     security/selinux/
> +K:     \bsecurity_[a-z_0-9]\+\b
>
>  SELINUX SECURITY MODULE
>  M:     Paul Moore <paul@paul-moore.com>
> --
> 2.42.1

--=20
paul-moore.com
