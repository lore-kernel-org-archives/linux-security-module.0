Return-Path: <SRS0=0AS6=EI=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B345EC388F2
	for <linux-security-module@archiver.kernel.org>; Mon,  2 Nov 2020 14:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D300223C7
	for <linux-security-module@archiver.kernel.org>; Mon,  2 Nov 2020 14:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HcFyKdF5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgKBODw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 2 Nov 2020 09:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKBODw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 2 Nov 2020 09:03:52 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A6AC0617A6
        for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2020 06:03:52 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id n15so12647926otl.8
        for <linux-security-module@vger.kernel.org>; Mon, 02 Nov 2020 06:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wX6OTPW5wqdMmU5R1jeye+cO+mS+d0fs6KyBCs/5wsw=;
        b=HcFyKdF5Oxabqi6Th2rxqSyIRke5RWMH2AmIZyXZQ3TmoBvrbaIseTp5wFkwOrVqPZ
         tCECpraufZ58ZH9G49SY90oj4Chls/n7eDM4sjD2gr0pwsuHbQdnroAu92Rk0ekyVJaw
         NJ7Hhs+4aettc58fbaPSasUS6t4t+SlNNuUDqUXNwFpXPATS+Ow/qfEut7RHTVrjlV+6
         g4aUv/YW6MqK/Lt4ssHvtK1Iq5mZJ5OBS/8ScM//Guh+S8z3qSvRbA3W2bE93LYWpAYE
         ph1IhLdV0tjJAz/aCOf7JH57RtsOY1aDNXsn/3REL5bvA3UhtsAa3Ltt9/B+PAjjLoS3
         oOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wX6OTPW5wqdMmU5R1jeye+cO+mS+d0fs6KyBCs/5wsw=;
        b=MJNRTonLmjq6A2gKqJES5y9eo24hYWYETc02yTpxqejH2XYubrQM7jPLzsTZpSKfgu
         ATRuLA3g6XOW1QPAWunCK1VD/XvK1Lji7IbJAwVvqC0SqBEuODB8i9b4aOLxz31gHoPi
         8Dzh72ssBf+RiNTFPUvTwIWYU+RDKzTkvut3sv1Ao3r72e+MnCW5bO/LRj68lNIXS0wB
         USJxtzKWn9K95YCdZHeemC0m2wRkaTeFB/DaRPFL5wq1tYllCOJ249N41wMFDoJ7HB2T
         IWYey7hATfuRFK8oWJi8khHQLcw1IZWNvFhI0wxnwhxStUe3C26T81/boPdiq7mJodla
         BI+A==
X-Gm-Message-State: AOAM530R7x2DTH5CNadKhb6JE/m7W0vZjYmOBN93aje7mLPannDrMNMX
        TEOVYRbK3V/qZvRotjfEC5PfRKGYsBbt7mww0edHpQ==
X-Google-Smtp-Source: ABdhPJyEOrb8ST/xOmB2FH0kBLmvzaTQt/orQ/byCNraU37B7b7JC4p6EQ1WflES2+m4XQRx1rKiZyoklXvZDJq3UKw=
X-Received: by 2002:a9d:65d5:: with SMTP id z21mr2744223oth.251.1604325831671;
 Mon, 02 Nov 2020 06:03:51 -0800 (PST)
MIME-Version: 1.0
References: <20201029183526.2131776-1-aleksandrnogikh@gmail.com> <20201029183526.2131776-2-aleksandrnogikh@gmail.com>
In-Reply-To: <20201029183526.2131776-2-aleksandrnogikh@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 2 Nov 2020 15:03:40 +0100
Message-ID: <CANpmjNMnKY7v6o-9oDYObU=uGzSM-0Zncf-UUO7aCugS-odkjQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] security: add fault injection capability
To:     Aleksandr Nogikh <aleksandrnogikh@gmail.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@google.com>, casey@schaufler-ca.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 29 Oct 2020 at 19:35, Aleksandr Nogikh
<aleksandrnogikh@gmail.com> wrote:
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

Reviewed-by: Marco Elver <elver@google.com>

> ---
> v2:
> * Renamed should_fail_lsm_hook() to lsm_hooks_inject_fail().
> ---
>  lib/Kconfig.debug   |  6 +++++
>  security/security.c | 53 ++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 56 insertions(+), 3 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 537cf3c2937d..80d289591e29 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1803,6 +1803,12 @@ config FAIL_MAKE_REQUEST
>         help
>           Provide fault-injection capability for disk IO.
>
> +config FAIL_LSM_HOOKS
> +       bool "Fault-injection capability for LSM hooks"
> +       depends on FAULT_INJECTION
> +       help
> +         Provide fault-injection capability for LSM hooks.
> +
>  config FAIL_IO_TIMEOUT
>         bool "Fault-injection capability for faking disk interrupts"
>         depends on FAULT_INJECTION && BLOCK
> diff --git a/security/security.c b/security/security.c
> index 69ff6e2e2cd4..1105ad0f6891 100644
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
> @@ -669,6 +670,51 @@ static void __init lsm_early_task(struct task_struct *task)
>                 panic("%s: Early task alloc failed.\n", __func__);
>  }
>
> +
> +#ifdef CONFIG_FAIL_LSM_HOOKS
> +
> +static struct {
> +       struct fault_attr attr;
> +       int retval;
> +} fail_lsm_hooks = {
> +       .attr = FAULT_ATTR_INITIALIZER,
> +       .retval = -EACCES
> +};
> +
> +static int __init setup_fail_lsm_hooks(char *str)
> +{
> +       return setup_fault_attr(&fail_lsm_hooks.attr, str);
> +}
> +__setup("fail_lsm_hooks=", setup_fail_lsm_hooks);
> +
> +static int lsm_hooks_inject_fail(void)
> +{
> +       return should_fail(&fail_lsm_hooks.attr, 1) ? fail_lsm_hooks.retval : 0;
> +}
> +
> +#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
> +
> +static int __init fail_lsm_hooks_debugfs(void)
> +{
> +       umode_t mode = S_IFREG | 0600;
> +       struct dentry *dir;
> +
> +       dir = fault_create_debugfs_attr("fail_lsm_hooks", NULL,
> +                                       &fail_lsm_hooks.attr);
> +       debugfs_create_u32("retval", mode, dir, &fail_lsm_hooks.retval);
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
>   * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
>   * can be accessed with:
> @@ -707,16 +753,17 @@ static void __init lsm_early_task(struct task_struct *task)
>         } while (0)
>
>  #define call_int_hook(FUNC, IRC, ...) ({                       \
> -       int RC = IRC;                                           \
> -       do {                                                    \
> +       int RC = lsm_hooks_inject_fail();                       \
> +       if (RC == 0) {                                                          \
>                 struct security_hook_list *P;                   \
> +               RC = IRC;                                                               \
>                                                                 \
>                 hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
>                         RC = P->hook.FUNC(__VA_ARGS__);         \
>                         if (RC != 0)                            \
>                                 break;                          \
>                 }                                               \
> -       } while (0);                                            \
> +       }                                                       \
>         RC;                                                     \
>  })
>
> --
> 2.29.1.341.ge80a0c044ae-goog
>
