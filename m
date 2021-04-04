Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D62C433B4
	for <linux-security-module@archiver.kernel.org>; Sun,  4 Apr 2021 16:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E49A61368
	for <linux-security-module@archiver.kernel.org>; Sun,  4 Apr 2021 16:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhDDQBO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 4 Apr 2021 12:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229861AbhDDQBN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 4 Apr 2021 12:01:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7D9E60232;
        Sun,  4 Apr 2021 16:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617552069;
        bh=Gv7SsSaMsWSBL4LjRskRhkx3N1krNPvmb86FOM3wQwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qtypswkjiKTBU9PCGvU2Tj82l63EbqTlt+FzdtcGR3o/dNLtcZGGXM+3ci7IQDgiw
         tvYadMBqgpsDE3uPlonZiwRXnRjQaooq1LekVhgnKvib2Zne3ptduEluQKie35gEsr
         it2iMyufLPxkKEagr86HaB+ysp/ZnIcrFdk7CIFW8TT6uH/BNqofayyifEclqL/fv0
         ibFAHgfWTSIBdZyXHX38oW9gJN5KLfXZA3bsL2HZiazRFLYcXVSesRL7yC1huXEw88
         cbKcYdMbNrweHK2JrRNnlXeVP9P0X7jDYupBxV32kptvuyZB8nFGVmQnpAkNeGGxHG
         Es4tmXZgEdJHg==
Date:   Sun, 4 Apr 2021 19:01:06 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, jejb@linux.ibm.com
Subject: Re: [PATCH -next] KEYS: trusted: Switch to kmemdup_nul()
Message-ID: <YGniwpyGNPLvn3Mf@kernel.org>
References: <20210402092346.2444932-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402092346.2444932-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Apr 02, 2021 at 05:23:46PM +0800, Yang Yingliang wrote:
> Use kmemdup_nul() helper instead of open-coding to
> simplify the code.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  security/keys/trusted-keys/trusted_tpm1.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)


Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

> 
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index 493eb91ed017..90ded4757e79 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -978,11 +978,9 @@ static int trusted_instantiate(struct key *key,
>  	if (datalen <= 0 || datalen > 32767 || !prep->data)
>  		return -EINVAL;
>  
> -	datablob = kmalloc(datalen + 1, GFP_KERNEL);
> +	datablob = kmemdup_nul(prep->data, datalen, GFP_KERNEL);
>  	if (!datablob)
>  		return -ENOMEM;
> -	memcpy(datablob, prep->data, datalen);
> -	datablob[datalen] = '\0';
>  
>  	options = trusted_options_alloc();
>  	if (!options) {
> -- 
> 2.25.1
> 
> 
