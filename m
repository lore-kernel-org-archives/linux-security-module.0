Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F70C43334
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jun 2022 00:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244411AbiFHAnJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1840090AbiFHAEX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 Jun 2022 20:04:23 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C422534ED
        for <linux-security-module@vger.kernel.org>; Tue,  7 Jun 2022 12:18:24 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id w13-20020a17090a780d00b001e8961b355dso4540107pjk.5
        for <linux-security-module@vger.kernel.org>; Tue, 07 Jun 2022 12:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0EImpbXnAApSc8BvVL56qbdQpeRig2mR5AXQClUMyjc=;
        b=D+sDw6OfB5boDSeDNM9bqFr0F+tvRj6Ohj2Z1YTWNs+0xdYLLaOMK5kJXF2k+FXvoN
         S1Jx/D6ktM3EJjcmR6k7X2cXEptshfJtA4Ojr3XNwEKFX52bC4dCEHTSLs803Od905Qd
         +7X+bRiPsgncXxvXODceVFz4G8VDzZDv6yt5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0EImpbXnAApSc8BvVL56qbdQpeRig2mR5AXQClUMyjc=;
        b=kw4Wc2Vt2CaRhwuIuw1h/jnoJGOqppYmuAGoNfgr3T41vhTGPpqUshV/7asUgHB0Y2
         zRYuOoO+ulYs5l4jngeIL4pdALLtwzLXPhvFvIiDy4ZVxQhqcw6n2yrk3SctcLe3AeBq
         D4fGzgdYGyx0LoRMZ7Bojw8wyAKL9r1BPZs+qQrarLXbR8Q2ZlL+OHXzoNtaEVhhEX9D
         EF0M6m0Kz0eusLF8/UYQkNIR/gmw7zeCqFojQl50ZC553lfTBmS7OGR2Gm/o8Y3VXZYE
         Hwm9HYNEuyJEdRfZAn5vpUGeCb7BeJx9fg3qJrFhdhOmW9bv/Qh4/3VgpzLmuQ2xTwab
         1R4g==
X-Gm-Message-State: AOAM533ZZtpaHfbZd7ziQvkWX5kg+aFX2Y6u9clbEml8ZS5L0wXoMjB9
        KkeNJK5DO9WL7jA31/o6yDvyJwYM5263dg==
X-Google-Smtp-Source: ABdhPJyBmgCZaEYkm6poadEXRpVAz2i5/BGDgN9MhkPQ/Q6rYJplJtUTI/mP0HwnvEwNnezRL45GYQ==
X-Received: by 2002:a17:903:240c:b0:153:c452:f282 with SMTP id e12-20020a170903240c00b00153c452f282mr29733430plo.88.1654629502873;
        Tue, 07 Jun 2022 12:18:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q3-20020a056a0002a300b0051be16492basm9177167pfs.195.2022.06.07.12.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 12:18:22 -0700 (PDT)
Date:   Tue, 7 Jun 2022 12:18:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "GONG, Ruiqi" <gongruiqi1@huawei.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: Re: [RESEND PATCH] smack: Replace kzalloc + strncpy with kstrndup
Message-ID: <202206071218.D281DE50@keescook>
References: <20220607093649.928131-1-gongruiqi1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607093649.928131-1-gongruiqi1@huawei.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 07, 2022 at 05:36:49PM +0800, GONG, Ruiqi wrote:
> Simplify the code by using kstrndup instead of kzalloc and strncpy in
> smk_parse_smack(), which meanwhile remove strncpy as [1] suggests.
> 
> [1]: https://github.com/KSPP/linux/issues/90
> 
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
