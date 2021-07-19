Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EF0C636C9
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Jul 2021 06:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0FBA611AF
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Jul 2021 06:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhGSG37 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 19 Jul 2021 02:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbhGSG36 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Jul 2021 02:29:58 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5375FC061765
        for <linux-security-module@vger.kernel.org>; Sun, 18 Jul 2021 23:26:58 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id g8so22468534lfh.8
        for <linux-security-module@vger.kernel.org>; Sun, 18 Jul 2021 23:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3lPCqQljJf2IbScxAFf1031HOfRkixI8y+inmwaEQLU=;
        b=z2jvnSeXzDI9LPibiAzjKQbSIyzToX8RVGLxm1q6JUMlUH1kl0pL+3wgTp6oW882g1
         xyogIuA7XaCw1fRG5z7RhOMgH7biVV5AJlOQdCUiWu3H+tGYqv9Tt7WoqluESFL1MZMM
         OHBSr0ZQ02dme41z/gRxG57q+hi8wfHMVnKtqMsq3xhqnqG/s2gfePY6gNoS7TLPCo6k
         tke5hJgz9GFURVOKSr8GxysmbIi3gC/Mv9BHcGYzVkYS5BQUlGSei4TOQO5jBnXilObb
         DdjvuG4IVAo/JDgW2wnUXhK6joE88nG97kREx8s15jqnx1MJVFWv4ljjNeTnvwnZfN6v
         zioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3lPCqQljJf2IbScxAFf1031HOfRkixI8y+inmwaEQLU=;
        b=bmwSLm/Q8e2twWXXZ7TnW1l7bcKXQ1XgMnOuRdeF1MCLOfRLe+WrOvrnEjDXAYUe+C
         6pTxfMQ/sAHtg+zkijvbSX/f3bzrHCoPowMpz+h/bZq/VQi2h1GwB6VRA4inHICz7B91
         noIgKeTvZl7edo42rK3nqdSR3rmpQ7kwoQz01sGz4DsItiZ9B2L8Wa7+eFGofV0FiKQ3
         zQTKce7AP+S8WyougoeSFu2Yh91QiH2v4rTWBhJwqvysQ2+ep4aHhepT5JGhBsSAXmMW
         4KO5Fb2yYf2yRw+7kpyt+eNUCDg1LiUtmqqx+5gsoRLQ6s/HAxZHZu8WhKTYueQBrlWl
         8cpQ==
X-Gm-Message-State: AOAM531o7cgYXvOBsUz9Fohmhh05dZwj4bHO43bLCamuOLHGBkr87rVc
        98RqGMbGwynDbA7bbHh6dEIc8tx0q2tw8tqlqQ3V4g==
X-Google-Smtp-Source: ABdhPJwcVB5VSPOP+/OH08BW5Jay0hN57oGFKlGhOhwsFjFhAJ5AjL1LvhtxB4k5IkyqvZfHbetmuyk5aibT9lfPDQ0=
X-Received: by 2002:a19:c757:: with SMTP id x84mr17381730lff.302.1626676016627;
 Sun, 18 Jul 2021 23:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210716081722.4130161-1-andreas@rammhold.de>
In-Reply-To: <20210716081722.4130161-1-andreas@rammhold.de>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 19 Jul 2021 11:56:45 +0530
Message-ID: <CAFA6WYNu+XxESXKLUQ8k3TDY18n1Y-R7m9=iTp-BerU69wLWdg@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: Fix trusted key backends when building as module
To:     Andreas Rammhold <andreas@rammhold.de>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 16 Jul 2021 at 13:54, Andreas Rammhold <andreas@rammhold.de> wrote:
>
> Before this commit the kernel could end up with no trusted key sources
> even thought both of the currently supported backends (tpm & tee) were

s/thought/though/

> compoiled as modules. This manifested in the trusted key type not being

s/compoiled/compiled/

> registered at all.
>
> When checking if a CONFIG_=E2=80=A6 preprocessor variable is defined we o=
nly
> test for the builtin (=3Dy) case and not the module (=3Dm) case. By using
> the IS_ENABLE(=E2=80=A6) macro we to test for both cases.
>

s/to/do/

> Signed-off-by: Andreas Rammhold <andreas@rammhold.de>
> ---
>  security/keys/trusted-keys/trusted_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Apart from minor nits above, add a corresponding fixes tag. With that:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/tr=
usted-keys/trusted_core.c
> index d5c891d8d353..fd640614b168 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -27,10 +27,10 @@ module_param_named(source, trusted_key_source, charp,=
 0);
>  MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
>
>  static const struct trusted_key_source trusted_key_sources[] =3D {
> -#if defined(CONFIG_TCG_TPM)
> +#if IS_ENABLED(CONFIG_TCG_TPM)
>         { "tpm", &trusted_key_tpm_ops },
>  #endif
> -#if defined(CONFIG_TEE)
> +#if IS_ENABLED(CONFIG_TEE)
>         { "tee", &trusted_key_tee_ops },
>  #endif
>  };
> --
> 2.32.0
>
