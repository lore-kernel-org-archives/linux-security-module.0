Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D650C001B3
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Jun 2023 15:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjFWPUk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 23 Jun 2023 11:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjFWPUd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Jun 2023 11:20:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F96E52
        for <linux-security-module@vger.kernel.org>; Fri, 23 Jun 2023 08:20:31 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bd5059e5347so4406652276.0
        for <linux-security-module@vger.kernel.org>; Fri, 23 Jun 2023 08:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687533630; x=1690125630;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFrinGzhAuwz1S3qbQGBFZD+wQOTROxTA9pmnJSY3K4=;
        b=6YQxG/A4f1xzdaiCFwiUiTq6QoKgzviPtcxIW7HXX9tsW9+wJHeTWd9I5h1f5ozKsW
         E/zqGoVTHUfqNXijvWGXqcDPNkFFv3Hqfyb+LelboBITDHKgPe7aQAMGu6Q73At0XI+s
         1+J56ELMW/Wa8p93KVyh/w6Gn0ptHmkuNDBzBx13gnssUEr6o/coP9WZlckECAp5v+69
         j06gMwFVwx2trk968GDOZ6cQHILh3+gL/6xQBC01IXO9rqou2Unj5ToztzAN8oouqAkx
         936+PaIrQ4bNbIHX/W2L8TWF44mEXEQN/UB4B73GutGYncAE+1bz8m6wuolU0CYO/YME
         RE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687533630; x=1690125630;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aFrinGzhAuwz1S3qbQGBFZD+wQOTROxTA9pmnJSY3K4=;
        b=K6WJnN9pnxr7WNnS28n1lGFblOAQ97fANPdcNuDpAnGRPQ6A+XHssVAnD7qgCA+lMv
         g3EyU5mZqMwcW29ZYp6s19GKxHsmcpZJzvVlIralkooJ4LLneUT4tXMVH4pijkKPO1b3
         5yPY9cBzQdM4HVCznznqGR27A0SN2Ef6TwkbM0Nj+ZwKOOVU6ebcYYAeMXDkVUxNfmfq
         /wc6xvTRot0DuqxA83HT5Y7nM+nkLeFIt525hfCtifAeG9CaIS69hNWO2WkVs6HnVw8b
         D+IUh8Obuqh9jv91WuVukIFsr1pmMjnwA/xWeb2nYMyoEbkFG9p3moIg04Rhq6pO5+42
         uhxw==
X-Gm-Message-State: AC+VfDySS4YVrrFKOOcAZ/7kd6XAMB3MXImyYOU/YAWWDe+7N7maOqod
        qp+s8sJLr9omu+zkp9knOlArvgNg7lIk2YyeYiaYJ9nIIn4hXoJWvyU1jtCITYEQai60n9HWxtE
        f/xBbDe+pmx2XRBPzlRnfQFnHQRbahBzGSW340OlTaWEnr6PitwLcz3zcRUl+HMAFTLZKzqgMic
        c3xWPtOw==
X-Google-Smtp-Source: ACHHUZ5o30nZk6Chs6s5rvuWOB5B1+5BV1InMKVzOr8mFORpc+JuYQnK9m7osrNU5xXv0BDaUbO0jkDFRsY=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:8b55:dee0:6991:c318])
 (user=gnoack job=sendgmr) by 2002:a05:6902:561:b0:bad:2b06:da3 with SMTP id
 a1-20020a056902056100b00bad2b060da3mr9426170ybt.3.1687533630537; Fri, 23 Jun
 2023 08:20:30 -0700 (PDT)
Date:   Fri, 23 Jun 2023 17:20:27 +0200
In-Reply-To: <20230623144329.136541-1-gnoack@google.com>
Message-Id: <ZJW4O+HVymf4nB6A@google.com>
Mime-Version: 1.0
References: <20230623144329.136541-1-gnoack@google.com>
Subject: Re: [PATCH v2 0/6] Landlock: ioctl support
From:   "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To:     linux-security-module@vger.kernel.org,
        "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc:     Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-fsdevel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello!

On Fri, Jun 23, 2023 at 04:43:23PM +0200, G=C3=BCnther Noack wrote:
> Proposed approach
> ~~~~~~~~~~~~~~~~~
>=20
> Introduce the LANDLOCK_ACCESS_FS_IOCTL right, which restricts the use
> of ioctl(2) on file descriptors.
>=20
> We attach the LANDLOCK_ACCESS_FS_IOCTL right to opened file
> descriptors, as we already do for LANDLOCK_ACCESS_FS_TRUNCATE.
>=20
> I believe that this approach works for the majority of use cases, and
> offers a good trade-off between Landlock API and implementation
> complexity and flexibility when the feature is used.
>=20
> Current limitations
> ~~~~~~~~~~~~~~~~~~~
>=20
> With this patch set, ioctl(2) requests can *not* be filtered based on
> file type, device number (dev_t) or on the ioctl(2) request number.
>=20
> On the initial RFC patch set [1], we have reached consensus to start
> with this simpler coarse-grained approach, and build additional ioctl
> restriction capabilities on top in subsequent steps.

We *could* use this opportunity to blanket disable the TIOCSTI ioctl, if a
Landlock policy gets enabled and ioctls are handled.

TIOCSTI is a TTY ioctl which is commonly used as a sandbox escape, if the
sandboxes system can get a hold on a TTY file descriptor from outside the
sandbox (like STDOUT, hah).

An excellent summary of these problems was already written by Kees Cook on =
the
Linux patch which removes TIOCSTI depending on a kernel config option:
https://lore.kernel.org/lkml/20221022182828.give.717-kees@kernel.org/

Unfortunately on the distributions I have tested so far (Debian and Arch Li=
nux),
TIOCSTI is still enabled.

***Proposal***:

  I am in favor of *disabling* TIOCSTI in all Landlocked processes,
  if the Landlock policy handles the LANDLOCK_ACCESS_FS_IOCTL right.

If we want to do it in a backwards-compatible way, now would be the time to=
 add
it to the patch set. :)

As far as I can tell, there are no good legitimate use cases for TIOCSTI, a=
nd it
would fix the aforementioned sandbox escaping trick for a Landlocked proces=
s.
With the patch set as it is now, the only way to prevent that sandbox escap=
e is
unfortunately to either (1) close the TTY file descriptors when enabling
Landlock, or (2) rely on an outside process to pass something else than a T=
TY
for FDs 0, 1 and 2.

Does that sound reasonable?  If yes, I'd send an update to this patch set w=
hich
forbids TIOCSTI.

Thanks,
=E2=80=94G=C3=BCnther

--=20
Sent using Mutt =F0=9F=90=95 Woof Woof
