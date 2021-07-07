Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEA7C07E95
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Jul 2021 10:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 241D461A2B
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Jul 2021 10:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhGGKRZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Jul 2021 06:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhGGKRZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Jul 2021 06:17:25 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D689C061574;
        Wed,  7 Jul 2021 03:14:45 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso1309439pjp.5;
        Wed, 07 Jul 2021 03:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/v1v63E0rW3Sz0wWz+xxvrNljXSoGIcWgLgvmV340X0=;
        b=r/ffmgD5xpCW0UJzyqwV9Mx7X8KN1SMy7aB/k3mI0d4pAONd+gY31jASH6L9nCcTaS
         0MGJ+jU9vM3u7wCsppsvc+O/NXDbBEBpGChF78KO1cOMV8SGs04rTTxf+0MXZ1BS25qE
         3vws7QMETu80NK3u9QrnmfahUigoLLj/mIx1Uc4aN+rPQfPh2cN+FZ0QXktseSVfddkr
         YyfX+lliHgO1yyz7n+bHbn5NpbFgOIGVJp+UqXnEMM3f+0TZ0brlXLV+a3hl7MZq8m36
         Khh1g4Yt/r+keuwQzUcS3SsaMW7xCmKo3wGcYogaHhfUkEhUa4qCltalihP+/7/uZh4M
         twyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/v1v63E0rW3Sz0wWz+xxvrNljXSoGIcWgLgvmV340X0=;
        b=eTRHR/quupv60CXAliiUSGpFOVx+abhYh596jJ6YsERiznYugo/jHLEVk8Fa1SISwC
         7dPZU09lDwaA9vOxQzOMA8xycn2qrObO1M4PGGCzdlQRHN2txdfjrG+fQZetfyzNLzVI
         ARU73iHpmUGGBd16qy4YUe53dlqvFOzoJlBxo3NiI2xl46Qtx8BNzQRlF9uI0i2QjCSN
         xzqS7uD9gsx1qXq3CydoPCNpURsaU/++OnlYJFtvqRq+r3ertxABD4smdRlHZSb83E/g
         NntJhAd5LBBXp618NulDGnXSMArxU9XPbZltjl8/06QcIJr0z4A1G4izVFn7gr4UVdGo
         rYcA==
X-Gm-Message-State: AOAM5333phzNkl4QenboEASl3XZQBAPc3QUPMdTsHVTovS0zl6x7vAdw
        NeuWNmqkitsq+suHZoW0JKCaWR67CuwU0PvEQnumoSKSfzg=
X-Google-Smtp-Source: ABdhPJzpnGJQbb/lAV153VUGKVOlFScbGXYNHs+4YUpNuPaJ2LzDco2arjS97UhJIDDiS5YwLG1j3xr4wfUyHbJ41NM=
X-Received: by 2002:a17:903:31c3:b029:ed:6f74:49c7 with SMTP id
 v3-20020a17090331c3b02900ed6f7449c7mr20212312ple.12.1625652885021; Wed, 07
 Jul 2021 03:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210629134144.GA1168@raspberrypi>
In-Reply-To: <20210629134144.GA1168@raspberrypi>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Wed, 7 Jul 2021 19:14:33 +0900
Message-ID: <CADLLry4_qB607aC2WdjvH6+QWijPNU4cQNhacr-mLOBN-heZAA@mail.gmail.com>
Subject: Re: [PATCH] smack: mark 'smack_enabled' global variable as __initdata
To:     casey@schaufler-ca.com, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

2021=EB=85=84 6=EC=9B=94 29=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 10:41, =
Austin Kim <austindh.kim@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Austin Kim <austin.kim@lge.com>
>
> Mark 'smack_enabled' as __initdata
> since it is only used during initialization code.
>
> Signed-off-by: Austin Kim <austin.kim@lge.com>
> ---
>  security/smack/smack.h     | 2 +-
>  security/smack/smack_lsm.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index c3cfbdf4944a..99c3422596ab 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -302,7 +302,7 @@ int smack_populate_secattr(struct smack_known *skp);
>  /*
>   * Shared data.
>   */
> -extern int smack_enabled;
> +extern int smack_enabled __initdata;
>  extern int smack_cipso_direct;
>  extern int smack_cipso_mapped;
>  extern struct smack_known *smack_net_ambient;
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 223a6da0e6dc..cacbe7518519 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -54,7 +54,7 @@
>  static DEFINE_MUTEX(smack_ipv6_lock);
>  static LIST_HEAD(smk_ipv6_port_list);
>  struct kmem_cache *smack_rule_cache;
> -int smack_enabled;
> +int smack_enabled __initdata;
>
>  #define A(s) {"smack"#s, sizeof("smack"#s) - 1, Opt_##s}
>  static struct {
> --
> 2.20.1
>

Dear Maintainers

Would you please review the above patch if you are available?
It might not take long.

Thanks.
Austin Kim
