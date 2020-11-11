Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C75FC388F9
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Nov 2020 11:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5369206FB
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Nov 2020 11:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u5HABaE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgKKLsO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 11 Nov 2020 06:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgKKLsN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Nov 2020 06:48:13 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB90FC0613D4
        for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2020 03:48:13 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id 63so708510qva.7
        for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2020 03:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5/bsZJ2SXh7EWUOoj25+V0UBuv9sNRFfAJnPmwXVu1s=;
        b=u5HABaE355NHv54+nsM4vzu7xItgx0bQHDH2oFWb6imxmfuScr2jqNWW9XgYnl2fXm
         0dJj3090WHnTYYiAJI03sv1PFoeTpFS0EM4G9e7pYlUrph8o/iHjnw836qP7wIX2KQc6
         hHVirZoSrFeQo5ctaC139iDJnI+/H+JlScB0leoVqTZQMIUBbcjLN+xv45LULAE3/MCp
         Icje2YNe/vdtZGfFSHYBqnoAIzNN1hoXNuGARlURG9vZOq6A1O186BWmZNgRWcGtcplG
         gHyc4nPOcsK0Kl7q7YXiZmWMHIJxXFH+A4TInnVI1HPQxlrtaS7bxLchejT9DeQwd8gi
         X/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5/bsZJ2SXh7EWUOoj25+V0UBuv9sNRFfAJnPmwXVu1s=;
        b=L7Nnq3i8ZBYlJW+0H+shU0XKawbt8tIuL//JMJ0bji31Dx6SkgYJApYyvp7N+eEmSE
         QSdHXemlFtCmz9vuh+74aJnlGNGTv+J1dVeaQGtL0gl7hR9MMS2V651AbmhaBVe2D49z
         Hi1t4avYL7ZzOgLUOoIMN/uKV5ny2L8rsX5QoRJjc5583YHgq/whOtL9oavmA4tqMMLv
         Mp1Mg1miRJsUZVqjvhPomM+xMYv7JT22bXdJ3/CSoAGXynZWzqQbzLsEhztXVasOCJHr
         A71/cFGoxcTLajlpcaViJ3z8wwlLPfyotrITHejICTkbPEA6p7Kq2A0JczeyzTwNyFB1
         cqzQ==
X-Gm-Message-State: AOAM5337aeV+2064qgM/DMbcETfN7Y39mklqlZegFSXOE2kjmVPB0lyv
        JPQf1GHpJgD87p4GBfG9FgAG4DFHcjYvMXwEPmMHYA==
X-Google-Smtp-Source: ABdhPJweQklfC8h2MxgH/sGjP1zb3U75XU///xckXr9YQGBWjDC0IaHCs2qgjypRFDn52a26LrzfhAWQ8TwFdUjcW7E=
X-Received: by 2002:a05:6214:209:: with SMTP id i9mr24657975qvt.38.1605095292686;
 Wed, 11 Nov 2020 03:48:12 -0800 (PST)
MIME-Version: 1.0
References: <20201111104409.1530957-1-a.nogikh@gmail.com> <20201111104409.1530957-2-a.nogikh@gmail.com>
In-Reply-To: <20201111104409.1530957-2-a.nogikh@gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 12:48:01 +0100
Message-ID: <CAG_fn=U63McR4-0uAfK44=GeYr78wP5PRzasG59CoSXLm0fCcQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] security: add fault injection capability
To:     Aleksandr Nogikh <a.nogikh@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Kees Cook <keescook@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        mortonm@chromium.org, Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 11, 2020 at 11:45 AM Aleksandr Nogikh <a.nogikh@gmail.com> wrot=
e:
>
> From: Aleksandr Nogikh <nogikh@google.com>
>
> Add a fault injection capability to call_int_hook macro. This will
> facilitate testing of fault tolerance of the code that invokes
> security hooks as well as the fault tolerance of the LSM
> implementations themselves.
>
> Add a KConfig option (CONFIG_FAIL_LSM_HOOKS) that controls whether the
> capability is enabled. In order to enable configuration from the user
> space, add the standard debugfs entries for fault injection (if
> CONFIG_FAULT_INJECTION_DEBUG_FS is enabled).
>
> Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
> Reviewed-by: Marco Elver <elver@google.com>
> Reviewed-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> v4:
> - Changed retval debugfs file type - now it keeps a signed integer.
> - Made CONFIG_FAIL_LSM_HOOKS depend on CONFIG_SECURITY.
> v2:
> - Renamed should_fail_lsm_hook() to lsm_hooks_inject_fail().
> ---
>  lib/Kconfig.debug   |  6 ++++
>  security/security.c | 69 +++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 72 insertions(+), 3 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 6140413174be..5f4399816019 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1813,6 +1813,12 @@ config FAIL_MAKE_REQUEST
>         help
>           Provide fault-injection capability for disk IO.
>
> +config FAIL_LSM_HOOKS
> +       bool "Fault-injection capability for LSM hooks"
> +       depends on FAULT_INJECTION && SECURITY
> +       help
> +         Provide fault-injection capability for LSM hooks.
> +
>  config FAIL_IO_TIMEOUT
>         bool "Fault-injection capability for faking disk interrupts"
>         depends on FAULT_INJECTION && BLOCK
> diff --git a/security/security.c b/security/security.c
> index 69ff6e2e2cd4..be3a3c7c6d6a 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -28,6 +28,7 @@
>  #include <linux/backing-dev.h>
>  #include <linux/string.h>
>  #include <linux/msg.h>
> +#include <linux/fault-inject.h>
>  #include <net/flow.h>
>
>  #define MAX_LSM_EVM_XATTR      2
> @@ -669,6 +670,67 @@ static void __init lsm_early_task(struct task_struct=
 *task)
>                 panic("%s: Early task alloc failed.\n", __func__);
>  }
>
> +
> +#ifdef CONFIG_FAIL_LSM_HOOKS
> +
> +static struct {
> +       struct fault_attr attr;
> +       int retval;
> +} fail_lsm_hooks =3D {
> +       .attr =3D FAULT_ATTR_INITIALIZER,
> +       .retval =3D -EACCES
> +};
> +
> +static int __init setup_fail_lsm_hooks(char *str)
> +{
> +       return setup_fault_attr(&fail_lsm_hooks.attr, str);
> +}
> +__setup("fail_lsm_hooks=3D", setup_fail_lsm_hooks);
> +
> +static int lsm_hooks_inject_fail(void)
> +{
> +       return should_fail(&fail_lsm_hooks.attr, 1) ? fail_lsm_hooks.retv=
al : 0;
> +}
> +
> +#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
> +
> +static int fail_lsm_retval_set(void *data, u64 val)
> +{
> +       fail_lsm_hooks.retval =3D (int)val;
> +       return 0;
> +}
> +
> +static int fail_lsm_retval_get(void *data, u64 *val)
> +{
> +       *val =3D (u64)fail_lsm_hooks.retval;
> +       return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(fail_lsm_retval_ops, fail_lsm_retval_get,
> +                                                fail_lsm_retval_set, "%l=
ld\n");
> +
> +static int __init fail_lsm_hooks_debugfs(void)
> +{
> +       umode_t mode =3D S_IFREG | 0600;
> +       struct dentry *dir;
> +
> +       dir =3D fault_create_debugfs_attr("fail_lsm_hooks", NULL,
> +                                       &fail_lsm_hooks.attr);
> +       debugfs_create_file("retval", mode, dir, NULL,
> +                                               &fail_lsm_retval_ops);
> +       return 0;
> +}
> +
> +late_initcall(fail_lsm_hooks_debugfs);
> +
> +#endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
> +
> +#else
> +
> +static inline int lsm_hooks_inject_fail(void) { return 0; }
> +
> +#endif /* CONFIG_FAIL_LSM_HOOKS */
> +
>  /*
>   * The default value of the LSM hook is defined in linux/lsm_hook_defs.h=
 and
>   * can be accessed with:
> @@ -707,16 +769,17 @@ static void __init lsm_early_task(struct task_struc=
t *task)
>         } while (0)
>
>  #define call_int_hook(FUNC, IRC, ...) ({                       \
> -       int RC =3D IRC;                                           \
> -       do {                                                    \
> +       int RC =3D lsm_hooks_inject_fail();                       \
> +       if (RC =3D=3D 0) {                                               =
           \
>                 struct security_hook_list *P;                   \
> +               RC =3D IRC;                                              =
                 \
>                                                                 \
>                 hlist_for_each_entry(P, &security_hook_heads.FUNC, list) =
{ \
>                         RC =3D P->hook.FUNC(__VA_ARGS__);         \
>                         if (RC !=3D 0)                            \
>                                 break;                          \
>                 }                                               \
> -       } while (0);                                            \
> +       }                                                       \
>         RC;                                                     \
>  })
>
> --
> 2.29.2.222.g5d2a92d10f8-goog
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
