Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52179C47082
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Jun 2021 17:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3365661090
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Jun 2021 17:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFGRIT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Jun 2021 13:08:19 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:38620 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhFGRIR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Jun 2021 13:08:17 -0400
Received: by mail-ej1-f50.google.com with SMTP id og14so22579115ejc.5
        for <linux-security-module@vger.kernel.org>; Mon, 07 Jun 2021 10:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6jG8fG0GqzHaHTewjIgBEd/sf2X5LfQRA/MV1//47rE=;
        b=whUEEw+Tpa+aHX4KqcRNinkQaQDZZR1eVDWgqy2acmutkSNAKodGfV3Eh3zCFF/r2E
         EZuI6vEGmpvM9b9tpCC3m4mE6rV4VGvDBbEdp6/eMQIHAfmXLAq+rgKyWXQDYLWxN1DW
         PkeyeB552VkZiac16yN5s9wfxUBlnIw7Ro7n9VmzUTx861wQKnDEgOobPy2LmTu1Pu3I
         lPF6JKTP5EKFQ8XbaJ0rb4pswTvk1E4jLVsSz2a8dXxrvvB/QeIxVPpdTlJu0NqHFHjd
         o8qoGwkTRbeEJOFR0vl6mqJfDhu2pHl0gk1AsW+SSo1T6rJAFL3TuCrYCjzdO57Eff+C
         q7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6jG8fG0GqzHaHTewjIgBEd/sf2X5LfQRA/MV1//47rE=;
        b=MW3nn5hWKModqTeaWFmxMlMcf1fiNsiQkdChpbd8RACUFnbwadmvgVReFNHpl/cRpk
         tqM5+0AgUESzr8iHXZwo0VkyxRiGOgpbWpQxVddy5ld+B1rdsTSwm/wkEIg06a+0oxj1
         vrIA6PG/DT7Q5Vr8KoG0i0WZ4no6n4Z11KOsejcOrNazZ4RwMTaB/Nx2f3eROcWNFKvO
         T9r3CL6jUtaTQI17DJ2Qn8m+Vw/G73xLdZiyRy+I0bTeEUopqOWcvTv1WF3hoD8t03Lc
         6G2xjFKJ9XrNq6EIksuSF+AE0QieDiRhFwc4ut9xc3tAIx75y50dioKkYcMhAy+ez1F4
         paCA==
X-Gm-Message-State: AOAM5319ZmlNnms2iD/AauZcMGTJ+5AasnjQGKPsT1KWt/OWPktiVorN
        DSEw1BeTTgz/7XW5Ai8H3XOl6yiMIYcu91G4XRrT
X-Google-Smtp-Source: ABdhPJxSqbbzdEkBauzBSZOj63lXqru92bwaU25QDlfWMPQ0Xv+0ErdjoGY3j8FBExHlfkyjKqjxqNBL+6LMw0E28KE=
X-Received: by 2002:a17:906:1113:: with SMTP id h19mr18675234eja.398.1623085525430;
 Mon, 07 Jun 2021 10:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210607150100.2856110-1-zhengyongjun3@huawei.com>
In-Reply-To: <20210607150100.2856110-1-zhengyongjun3@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 7 Jun 2021 13:05:14 -0400
Message-ID: <CAHC9VhRbcBjYSpt0q2LrizWA6O2iPPOSfsEggUxfU4oigk3x2A@mail.gmail.com>
Subject: Re: [PATCH net-next] netlabel: Fix spelling mistakes
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 7, 2021 at 10:47 AM Zheng Yongjun <zhengyongjun3@huawei.com> wrote:
>
> Fix some spelling mistakes in comments:
> Interate  ==> Iterate
> sucess  ==> success
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  net/netlabel/netlabel_domainhash.c | 2 +-
>  net/netlabel/netlabel_kapi.c       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
