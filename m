Return-Path: <SRS0=L/C/=W4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E46BC3A5A4
	for <linux-security-module@archiver.kernel.org>; Sun,  1 Sep 2019 16:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34D52339D
	for <linux-security-module@archiver.kernel.org>; Sun,  1 Sep 2019 16:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="n1wV2hfI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfIAQEi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 1 Sep 2019 12:04:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39499 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbfIAQEh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 1 Sep 2019 12:04:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id j16so4498030ljg.6
        for <linux-security-module@vger.kernel.org>; Sun, 01 Sep 2019 09:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lh7hz3NgC+Jv820T/3FkhJrD5Mam3iRkCjzClMx/PpU=;
        b=n1wV2hfIWvMuv5eadiuhyFNOVuX4UKEqE+vChB8pt8lNZQ1ytAPrCO7bUOER5D6OrB
         bDtxOc47O7FwzGjbfgCKkMVJXM54JS/gbCssoxyNGkxsFVJPAeDcrzUeJH9AWMUbO9dm
         grI0uDkzoYYDIqH7vVCoIjmty6qTWkZIXxTLu6VxWko7Q+NO5qXLiKMYOIh7jMWRCkyj
         ed9/Ekdo6rwy6T8bJg9Lh5kKYKd2GSOd62Qi8pkJG2ZhHEAM1govI6Y8nB8k401rw4dt
         SrhrZNenzTSZ177rdcQ+m+9MjahaMgFzCBxNJLB0annCtvOpsy7WDjiACTUvxcROCXkg
         XRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lh7hz3NgC+Jv820T/3FkhJrD5Mam3iRkCjzClMx/PpU=;
        b=V9WyC2vN9ErM7u06T+3u2tZdWjtvi1Z+/Wm5WvMD7F37RPRkKE2c+DlPvnzRLJFTd4
         nlLjZdAWH06YnG19P7Bqtz/P+XXMis4aqkZjmfiBnlkofBORLIM0h49MV+nZ4XtqLFL7
         FnbDKiM0Xg9HYjGzhvDk/XTuD3IsOKFX0KpNNumipbRvn35M/npoOJ+n60bHvqTaP9JJ
         4yKnSHcH5zufXITwti8zxEYOmNwcSEfE/8S6lijK33CLNsslW1cd61VWxOzvNwnrZw/U
         ePMqvv91gQAc+GPmo0gceRmt6fCDReJZbMbeG1CE7L0ZIf62HW9QzmT8WWiblqTLdgYY
         0T0g==
X-Gm-Message-State: APjAAAV5vV5FQuxD4ERcoTNwqFl6uCfx/o7l9IY7SnpE/tuDuHohnK+2
        TcghfWQ90lgUNdvx0hKz6XDmaJTTrMOtCwVvib2R
X-Google-Smtp-Source: APXvYqw/P92GX1SczFXfGPwLbUlbd1ji9qx65S/Qs3ZAKZYgZcSVD6Wya/9K+kkN3lM/ZA+i2FWNVcLd8GTgVLzLp6Y=
X-Received: by 2002:a2e:84c5:: with SMTP id q5mr13932977ljh.158.1567353875226;
 Sun, 01 Sep 2019 09:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190901155205.16877-1-colin.king@canonical.com>
In-Reply-To: <20190901155205.16877-1-colin.king@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 1 Sep 2019 12:04:24 -0400
Message-ID: <CAHC9VhSVKEJ-EBAry5fVN3Ux22occGQ5jxbFBecMsR+q7+UT5A@mail.gmail.com>
Subject: Re: [PATCH] netlabel: remove redundant assignment to pointer iter
To:     Colin King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Sep 1, 2019 at 11:52 AM Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Pointer iter is being initialized with a value that is never read and
> is being re-assigned a little later on. The assignment is redundant
> and hence can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  net/netlabel/netlabel_kapi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This patch doesn't seem correct to me, at least not in current form.
At the top of _netlbl_catmap_getnode() is a check to see if iter is
NULL (as well as a few other checks on iter after that); this patch
would break that code.

Perhaps we can get rid of the iter/catmap assignment when we define
iter, but I don't think this patch is the right way to do it.

> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
> index 2b0ef55cf89e..409a3ae47ce2 100644
> --- a/net/netlabel/netlabel_kapi.c
> +++ b/net/netlabel/netlabel_kapi.c
> @@ -607,7 +607,7 @@ static struct netlbl_lsm_catmap *_netlbl_catmap_getnode(
>   */
>  int netlbl_catmap_walk(struct netlbl_lsm_catmap *catmap, u32 offset)
>  {
> -       struct netlbl_lsm_catmap *iter = catmap;
> +       struct netlbl_lsm_catmap *iter;
>         u32 idx;
>         u32 bit;
>         NETLBL_CATMAP_MAPTYPE bitmap;
> --
> 2.20.1

-- 
paul moore
www.paul-moore.com
