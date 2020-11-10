Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5ABC4741F
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Nov 2020 17:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25DEE2076E
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Nov 2020 17:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zh3PDYrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbgKJRmY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 10 Nov 2020 12:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgKJRmX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Nov 2020 12:42:23 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BC7C0613D1
        for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2020 09:42:23 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id v12so12057145pfm.13
        for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2020 09:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xF9/tbw9kOE7P0FAYcDx8ImhRA3RlHzojbtxK6nR5qQ=;
        b=Zh3PDYrAEV+1C0mncbeDX7SS6s2UY5CwYoWMUaL9sFqBdYheZMRcsKmg7v8y1s1cuv
         Yf4iIwxQ3jrQRk6U/dT5TAi21MtJDvfzx1yAMA2IgRuHcweM/YSocmMpwwvfIdxZmO9U
         5ABXvV0Vc+llYKajBKq6i2CXQW6ZoLhMNHGgwMLfooBOZp9ANdx8tP2bq4HtUR/2t3Xk
         MvgX1KAPi+RsI/l4zPszmlypBRHLbApduuI+ejk2dRinY1qtXNOVW2Ju0efaLfSNZ9Qi
         QrkLAjG1Cyf1VUttFW55xVYGA9Lee2nrr+onFSPr0+NvE4k6w/Saq3KBarsiOHxRGog2
         vC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xF9/tbw9kOE7P0FAYcDx8ImhRA3RlHzojbtxK6nR5qQ=;
        b=X8ceD9tNNEPC4R8A3Mh/n9brOqRxXaMqmKfFi/k/Fql/MW+B6rdnFsNfWXURQMAoUb
         E7EstuiBu6h8oFadDJ8v8lild/JNmryOECoKVN71oQNabZZtXFfiIc527GI/91jKvQiu
         2SgrJLlT5yJg9yEgpfAhOjMSzeuGfkqP/aD3j/ucHLrkZuoEg0Wh8yU962E31LVKeOiO
         UkhecTyW7JJZHREtgze9GYC4Flf3JmtRNNyNhfxAuADT6491r9aF+jBxRq647uo9yzey
         cUQW20OujvjvpkI0xtUu/xREezPkmTCmUX5BwhjxoydHNNRBrtTuMXTacQ/8lBVmOKjl
         1j/g==
X-Gm-Message-State: AOAM533peJ/J6qHnSdSkbF+eJEPFCmL0igrMhYNch8mByQb59PGMzrq7
        hMa2RrGKke8qWKk1BvZCAyXP+CJo1rFNv/kwuxIM3g==
X-Google-Smtp-Source: ABdhPJwdsVEbgjYrXxYPWkuixoMrNxfDNyPLQWf0eIjCwDeKr7Z/gL08l2Zaq4MZJZ9hkhkACznYuIg//9t9ZV0QZ+c=
X-Received: by 2002:a63:1f53:: with SMTP id q19mr18270115pgm.286.1605030142984;
 Tue, 10 Nov 2020 09:42:22 -0800 (PST)
MIME-Version: 1.0
References: <20201029183526.2131776-1-aleksandrnogikh@gmail.com> <20201029183526.2131776-2-aleksandrnogikh@gmail.com>
In-Reply-To: <20201029183526.2131776-2-aleksandrnogikh@gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 10 Nov 2020 18:42:12 +0100
Message-ID: <CAAeHK+yqS09Aodtvo-G=V26-HUXQV7KayG_oHgSNivexsm2BUQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] security: add fault injection capability
To:     Aleksandr Nogikh <aleksandrnogikh@gmail.com>
Cc:     James Morris <jmorris@namei.org>, serge@hallyn.com,
        akinobu.mita@gmail.com, Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@google.com>, casey@schaufler-ca.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 29, 2020 at 7:35 PM Aleksandr Nogikh
<aleksandrnogikh@gmail.com> wrote:
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

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

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
