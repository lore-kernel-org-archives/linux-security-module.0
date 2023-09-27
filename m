Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A049AE82CAE
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Sep 2023 16:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjI0QFj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 27 Sep 2023 12:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjI0QFh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 Sep 2023 12:05:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD1392
        for <linux-security-module@vger.kernel.org>; Wed, 27 Sep 2023 09:05:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FB8C433C8;
        Wed, 27 Sep 2023 16:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695830736;
        bh=XP6mtWlqLwgc3ZpxC6obAxv9ig24vYLM6ZXVDBuCbdg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SDzLHctQF9fkpXszLzY8RiXoJW8gUf6GEVHU6wPf+tsw9zI3KVzMRSXA5WeF59l7p
         lGLPhwBxWavtis7+FP2w0dntYuC9rUAodMjhLrN/BWz33nvxl/3kAQB7/4+/xO/77D
         IJ/Zx7aBUhQERB14deOVODmx9jtnS1xKLnZB4h+wt5ndQvrFY0DKxbJat+AqoKZhA5
         2++Xk0AjeyWFxF54D4sr1AP5g4cANHcJUVbt1aP1Pvi4WJ7isV83AKP+Y/5Sul49fd
         H6qDboyA3zgpzCTzUpwHQkj5zEBM24TknS9cM6E68j18GoxAFlMBAGh/vfXJe4uW0f
         8rGC+iVK+YTvg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5046bf37ec1so9260327e87.1;
        Wed, 27 Sep 2023 09:05:36 -0700 (PDT)
X-Gm-Message-State: AOJu0YxlqzvB8l5r3a02C3doZYTkHKqtYJ20GeDa2Ih4+pKkoU1A13oS
        x/V+Ynrb9WhRX4OXWpfcxRi29wF/T9+sy/dHe4g=
X-Google-Smtp-Source: AGHT+IFXhn8DVbsmnHblN/5RojodhdIAHlnAfHPcCx82E2ys6BHrUCk/m1xywMYnWQsH+JUtD63HibGq2SI5YbjfCjc=
X-Received: by 2002:a19:ad4b:0:b0:503:a9c:af83 with SMTP id
 s11-20020a19ad4b000000b005030a9caf83mr2254712lfd.41.1695830734405; Wed, 27
 Sep 2023 09:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp> <9fccf6d7-4b1b-dd4e-5479-3c6d21d08d5a@I-love.SAKURA.ne.jp>
In-Reply-To: <9fccf6d7-4b1b-dd4e-5479-3c6d21d08d5a@I-love.SAKURA.ne.jp>
From:   Song Liu <song@kernel.org>
Date:   Wed, 27 Sep 2023 09:05:21 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6dZUvnSbWazyVsDHS-ZXHWbdX2a79zK=QzS9Y-mesj-Q@mail.gmail.com>
Message-ID: <CAPhsuW6dZUvnSbWazyVsDHS-ZXHWbdX2a79zK=QzS9Y-mesj-Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] LSM: A sample of dynamically appendable LSM module.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        KP Singh <kpsingh@kernel.org>,
        Paul Moore <paul@paul-moore.com>, bpf <bpf@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 27, 2023 at 8:09=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> This is an example of dynamically appendable LSM modules.

Maybe add this to samples/lsm/ or samples/security/?

And we need to assign maintainer(s) for it. Maybe add the files to
"SECURITY SUBSYSTEM" in MAINTAINERS

Thanks,
Song

>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  demo/Makefile |  1 +
>  demo/demo.c   | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 demo/Makefile
>  create mode 100644 demo/demo.c
>
> diff --git a/demo/Makefile b/demo/Makefile
> new file mode 100644
> index 000000000000..8a6ab0945858
> --- /dev/null
> +++ b/demo/Makefile
> @@ -0,0 +1 @@
> +obj-m +=3D demo.o
> diff --git a/demo/demo.c b/demo/demo.c
> new file mode 100644
> index 000000000000..90b03d10bd72
> --- /dev/null
> +++ b/demo/demo.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/module.h>
> +#include <linux/lsm_hooks.h>
> +
> +static int demo_task_alloc_security(struct task_struct *p,
> +                                   unsigned long clone_flags)
> +{
> +       static unsigned int count;
> +
> +       if (count++ < 5)
> +               dump_stack();
> +       return 0;
> +}
> +
> +static void demo_task_free_security(struct task_struct *p)
> +{
> +       static unsigned int count;
> +
> +       if (count++ < 5)
> +               dump_stack();
> +}
> +
> +static struct security_hook_list demo_hooks[] __ro_after_init =3D {
> +       LSM_HOOK_INIT(task_free, demo_task_free_security),
> +       LSM_HOOK_INIT(task_alloc, demo_task_alloc_security),
> +};
> +
> +static int __init demo_init(void)
> +{
> +       const int ret =3D register_loadable_lsm(demo_hooks,
> +                                             ARRAY_SIZE(demo_hooks), "de=
mo");
> +
> +       pr_info("Registering demo LSM module returned %d.\n", ret);
> +       return ret;
> +}
> +
> +module_init(demo_init);
> +MODULE_LICENSE("GPL");
> --
> 2.18.4
>
>
