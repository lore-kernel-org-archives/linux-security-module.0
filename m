Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37F7CD4844
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Sep 2023 16:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjIVQIO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 22 Sep 2023 12:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjIVQIO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Sep 2023 12:08:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C616100
        for <linux-security-module@vger.kernel.org>; Fri, 22 Sep 2023 09:08:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCA2C433CB
        for <linux-security-module@vger.kernel.org>; Fri, 22 Sep 2023 16:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695398888;
        bh=TyyKrSNDOmitK8LSKeEIonhNFxYjDi/94RCTzvIMmEc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GXQkKuqUu3Z5gvhsYGDHVvI8o7UacQ3HyHy3dSNgO44egNasLsvvF9JuI5FCxdt5W
         kiAHZbEVE/Dr10HDXZj132JuPk2n2O3CzQ9YZR6UEzEul+EHExdPAh+GSXDXty0AKt
         kUUsdp8mJBhJTBGvfGStfCl7+A1A53TilmQiYsfJ4SAFmgU003k2UcQfaQl1RSA/11
         ayfUKGDcDiTArzh8ft7hTI5t5trLZiuulYqsN7ypwcWAz8vbSYAV4CS2ozxxXgwGbw
         6BQD7pRRJ70641UtD2jZiYDHIGjO90ksEKUu4jSB4meuWUDAxlUYHE/jBboVQN+7kp
         mFVzDOj/QH8xw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5031426b626so3648770e87.3
        for <linux-security-module@vger.kernel.org>; Fri, 22 Sep 2023 09:08:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YwDsHKHEpUpYfIFVjKx+yvw5NKHyv5a+iS6xI4pV+PaGCEL+LEV
        lwxyn7hhOLyHVL2rRnODA2T2sORBmCN/9bXUyou33g==
X-Google-Smtp-Source: AGHT+IG8yfS18kbASIPfqp05uIy0ygNKMUUzhZa3mAoNqBfG5E+3atLD7Rczz4cq0b1TbAJTO0PjMe7mAl0y0XyqR+I=
X-Received: by 2002:ac2:44ce:0:b0:4fe:db6:cb41 with SMTP id
 d14-20020ac244ce000000b004fe0db6cb41mr7769508lfm.39.1695398886289; Fri, 22
 Sep 2023 09:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230922145505.4044003-1-kpsingh@kernel.org> <20230922145505.4044003-3-kpsingh@kernel.org>
 <202309220848.010A198E7@keescook>
In-Reply-To: <202309220848.010A198E7@keescook>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 22 Sep 2023 18:07:55 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4yCuQTbxPMVc5T=KO-jeu8=0mCUNcVapacJpOxPOp=EQ@mail.gmail.com>
Message-ID: <CACYkzJ4yCuQTbxPMVc5T=KO-jeu8=0mCUNcVapacJpOxPOp=EQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] security: Count the LSMs enabled at compile time
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, renauld@google.com,
        Kui-Feng Lee <sinquersw@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 22, 2023 at 5:50=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Fri, Sep 22, 2023 at 04:55:02PM +0200, KP Singh wrote:
> > These macros are a clever trick to determine a count of the number of
> > LSMs that are enabled in the config to ascertain the maximum number of
> > static calls that need to be configured per LSM hook.
> >
> > Without this one would need to generate static calls for the total
> > number of LSMs in the kernel (even if they are not compiled) times the
> > number of LSM hooks which ends up being quite wasteful.
> >
> > Suggested-by: Kui-Feng Lee <sinquersw@gmail.com>
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Acked-by: Song Liu <song@kernel.org>
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
>
> Thought below, but regardless of result:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
>
> > ---
> >  include/linux/lsm_count.h | 107 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 107 insertions(+)
> >  create mode 100644 include/linux/lsm_count.h
> >
> > diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
> > new file mode 100644
> > index 000000000000..4d6dac6efb75
> > --- /dev/null
> > +++ b/include/linux/lsm_count.h
> > @@ -0,0 +1,107 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * Copyright (C) 2023 Google LLC.
> > + */
> > +
> > +#ifndef __LINUX_LSM_COUNT_H
> > +#define __LINUX_LSM_COUNT_H
> > +
> > +#include <linux/args.h>
> > +
> > +#ifdef CONFIG_SECURITY
> > +
> > +/*
> > + * Macros to count the number of LSMs enabled in the kernel at compile=
 time.
> > + */
> > +
> > +/*
> > + * Capabilities is enabled when CONFIG_SECURITY is enabled.
> > + */
> > +#if IS_ENABLED(CONFIG_SECURITY)
> > +#define CAPABILITIES_ENABLED 1,
> > +#else
> > +#define CAPABILITIES_ENABLED
> > +#endif
>
> We're in an #ifdef CONFIG_SECURITY, so CAPABILITIES_ENABLED will always
> be set. As such, we could leave off the trailing comma and list it
> _last_ in the macro, and then ...
>
> > +/*
> > + *  There is a trailing comma that we need to be accounted for. This i=
s done by
> > + *  using a skipped argument in __COUNT_LSMS
> > + */
> > +#define __COUNT_LSMS(skipped_arg, args...) COUNT_ARGS(args)
> > +#define COUNT_LSMS(args...) __COUNT_LSMS(args)
>
> This wouldn't be needed...

Slight preference for explicitly having the capabilities listed than
implicitly over counting. But no strong opinion, fine with either
approches.

>
> > +
> > +#define MAX_LSM_COUNT                        \
> > +     COUNT_LSMS(                     \
> > +             CAPABILITIES_ENABLED    \
> > +             SELINUX_ENABLED         \
> > +             SMACK_ENABLED           \
> > +             APPARMOR_ENABLED        \
> > +             TOMOYO_ENABLED          \
> > +             YAMA_ENABLED            \
> > +             LOADPIN_ENABLED         \
> > +             LOCKDOWN_ENABLED        \
> > +             BPF_LSM_ENABLED         \
> > +             LANDLOCK_ENABLED)
>
>
>         COUNT_ARGS(                     \
>                 SELINUX_ENABLED         \
>                 SMACK_ENABLED           \
>                 ...
>                 CAPABILITIES_ENABLED)
>
> -Kees
>
> --
> Kees Cook
