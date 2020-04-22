Return-Path: <SRS0=ipMR=6G=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3FEC54FCB
	for <linux-security-module@archiver.kernel.org>; Wed, 22 Apr 2020 19:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD202077D
	for <linux-security-module@archiver.kernel.org>; Wed, 22 Apr 2020 19:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJTihIUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgDVTNG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725913AbgDVTNF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 22 Apr 2020 15:13:05 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42516C03C1A9;
        Wed, 22 Apr 2020 12:13:05 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b11so3849323wrs.6;
        Wed, 22 Apr 2020 12:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kyf7m5anVJ/hrxFQtRlRUr5WSztIezngru5jjVYf0KI=;
        b=jJTihIUpgN+krqZ47MmLRuGF/oFrwqUxmwOA9crF53teLZdI6Osmzl5OjDwBAZyhnS
         PEuWuEfbWbKkXch3P81+n4BHUrgB4layLx/cd5J+XYT4FYOuL2ju+S+vhK8ELp3bzrIF
         5MpeFX1m496AVUSZ6nVKeenR++tOJoSPeaQ2SmrmEdK4Y0+IHlLVefqtoTJQlSledYB8
         tmI/JPF9+9qeee+hr29XX4qhNy3jJoJO3WMxLynkRFdjss8kKkGsaYOySn3BbhRd+unM
         ECpCV+Vqk/wyxQaknjxo5s3I/DgfYjRM3apnwcuYnmP/YfWHB7ckXbqaTgqhBmgcbGCY
         X/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kyf7m5anVJ/hrxFQtRlRUr5WSztIezngru5jjVYf0KI=;
        b=NW3Jl1Sks/llS7/Cm9/UOH/YSYd68FrR+iij4l7S+lV0vc5JqWrVh+EUqbOVKLSHAG
         0cdMRUGzTJigrAbNeQDXKIzYJ4h37vjxpVBVa/16tGV+ybgdsMi2sf7JatMmXr93edTK
         nkv8pD7PjBr61A/rIGNiGKgQrERdSKMlyBUicfJvraECX73LvhZMeqWti1ohRUR0KyLV
         Rl9h0SnpFJtnHtVs328VUaX5woMOR53TWYbrhJcmeHOv80mpWyAmaOHmkrliaz+LFAyE
         zkt47gKrHbbZ347rcAZ4xwned1BJqIPI+KrFMdNQXGCIz3Gf8/P6kvpNBGZekh2qRZmL
         g8jg==
X-Gm-Message-State: AGi0PuZkDBtDxj9a4lq2LuPugt7+0tPHhA4mqS5G1IGMV2gWSjEhK01z
        OE7jMp+zKdUIKB4PRujc5B7HMD3cEtA=
X-Google-Smtp-Source: APiQypJQ+QTW4RBTbQp5UpnepeJlIUfphpFiuz+PLLvTsIn3MYqgHABpClxU6d42ZJAUq9Mi2Oq40A==
X-Received: by 2002:adf:df8e:: with SMTP id z14mr543518wrl.319.1587582783738;
        Wed, 22 Apr 2020 12:13:03 -0700 (PDT)
Received: from lorien (lorien.valinor.li. [2a01:4f8:192:61d5::2])
        by smtp.gmail.com with ESMTPSA id q184sm276332wma.25.2020.04.22.12.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 12:13:02 -0700 (PDT)
Date:   Wed, 22 Apr 2020 21:13:01 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     netdev@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netlabel: Kconfig: Update reference for NetLabel Tools
 project
Message-ID: <20200422191301.GA2361@lorien.valinor.li>
References: <20200422190753.2077110-1-carnil@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422190753.2077110-1-carnil@debian.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 22, 2020 at 09:07:53PM +0200, Salvatore Bonaccorso wrote:
> The NetLabel Tools project has moved from http://netlabel.sf.net to a
> GitHub. Update to directly refer to the new home for the tools.

Oh, well s/GitHub/GitHub project/.

> 
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> ---
>  net/netlabel/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/netlabel/Kconfig b/net/netlabel/Kconfig
> index 64280a1d3906..07b03c306f28 100644
> --- a/net/netlabel/Kconfig
> +++ b/net/netlabel/Kconfig
> @@ -14,6 +14,6 @@ config NETLABEL
>  	  Documentation/netlabel as well as the NetLabel SourceForge project
>  	  for configuration tools and additional documentation.
>  
> -	   * http://netlabel.sf.net
> +	   * https://github.com/netlabel/netlabel_tools
>  
>  	  If you are unsure, say N.
> -- 
> 2.26.2
> 
