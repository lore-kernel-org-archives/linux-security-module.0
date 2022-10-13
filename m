Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5FDC4332F
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Oct 2022 21:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiJMVzG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 13 Oct 2022 17:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiJMVzB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 13 Oct 2022 17:55:01 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C617332DA5
        for <linux-security-module@vger.kernel.org>; Thu, 13 Oct 2022 14:54:50 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-35ad0584879so30010107b3.7
        for <linux-security-module@vger.kernel.org>; Thu, 13 Oct 2022 14:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pMIVAykxBe38/iC/E6uc7T7wvmS7tw/OTeZ758Y5Y7o=;
        b=P9IbXagKldqPlhXR/Ynxm74++40pPNmrIoKj68/ZaL40Wbei+ACwPUSuWAl+FrQ2So
         B7tQeT+IPJtEryxCbbTzWRzvxaKKFxqqkupLRDwCRZ3Rzvup4fin04QZw5pR8Szdkttz
         xLoGJmkmhX0lqgAFM8sBVqC8PBZpSnq9vZKRUv2nel9s8FTBihHQdUm+ai3lfUbStLCN
         Ilt1ZF2yLG5ZHPbw78eV5Bmfs0dBUr4RBQd2m8lybcBxjwGo3hEZFzfZTo7uSyP415AA
         IlafW7O47qwp53T7yWpEmIoiTGNoiW3iaa165UcV/apUNWyGhMcWNdgl7i7SkiNQ0lb3
         Ko0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMIVAykxBe38/iC/E6uc7T7wvmS7tw/OTeZ758Y5Y7o=;
        b=lcuIVI7gYMxQNBnuVWS4/ZuNJaqwOrA2oNPiupaBNa79KTNFLdC3nfOUkBDJQc6TNc
         Ry+kR/xPje2XhUG4H/Vbl4xhdIverDzx7hCX5QY+8hkgNLhMFzCg4Qbxq0s6dkwfpS17
         3Wuc+R20VUZbqKseCKyl5pa1eDAuEcN65WRdgmYoWN8D4cUWdbbm+K6rdxuwtxDcNHKf
         3WR6+N/ejuW4kpiYT+vVSW15y+CXdymyGigmhkSaOEWgQDiexRZDoiDGqRL8SZC759eb
         0+vyb6MLLzX+A9/qhXOToPyaiYXUbIgKDcLVjbPmh1GzqByFmFjoWaVS4oIQz8/eCO2j
         uAaA==
X-Gm-Message-State: ACrzQf0PFV8igncHZLNfFkoIM75FrhZ5K70qi+Fa1uZQ75q2mhEbWVF9
        WGKaWNlo1NHb4gKVhWfSoOmSFH8ghyAQCagXoCEf
X-Google-Smtp-Source: AMsMyM4JEMdMZBfMMOEelszS2FpP9sTFphB2c0U7BQE0LEIVEYbWEkduPrNlOO6ZaZ5zQ40oGab8VSOjZhfOIxy4NMA=
X-Received: by 2002:a0d:ebc1:0:b0:360:5a77:4d78 with SMTP id
 u184-20020a0debc1000000b003605a774d78mr1942006ywe.336.1665698052305; Thu, 13
 Oct 2022 14:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221013214637.30807-1-palmer@rivosinc.com>
In-Reply-To: <20221013214637.30807-1-palmer@rivosinc.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Oct 2022 17:54:00 -0400
Message-ID: <CAHC9VhTPt40PFC5NASOjOK+fqJym5JOyb8UrwAL7DGDQWqVwqA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: git://github -> https://github.com for cschaufler
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 13, 2022 at 5:49 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> Github deprecated the git:// links about a year ago, so let's move to
> the https:// URLs instead.
>
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> I've split these up by github username so folks can take them
> independently, as some of these repos have been renamed at github and
> thus need more than just a sed to fix them.
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Casey is the one who needs to ACK this (and he has an email delay at
the moment), but the URL looks good to me.

Reviewed-by: Paul Moore <paul@paul-moore.com>

> diff --git a/MAINTAINERS b/MAINTAINERS
> index daadd0de77a9..019cdb48e254 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18723,7 +18723,7 @@ M:      Casey Schaufler <casey@schaufler-ca.com>
>  L:     linux-security-module@vger.kernel.org
>  S:     Maintained
>  W:     http://schaufler-ca.com
> -T:     git git://github.com/cschaufler/smack-next
> +T:     git https://github.com/cschaufler/smack-next
>  F:     Documentation/admin-guide/LSM/Smack.rst
>  F:     security/smack/
>
> --
> 2.38.0

-- 
paul-moore.com
