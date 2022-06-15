Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41552C433EF
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jun 2022 02:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbiFOCHi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Jun 2022 22:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbiFOCHh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Jun 2022 22:07:37 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE869FD1
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jun 2022 19:07:26 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w17so5918303wrg.7
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jun 2022 19:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pka2Wf3vF4GgaDRWibWr079VJVrRTWnpwOYpLbvjDbs=;
        b=I9lCrgw50jYr/zbSokAJMRemwaludazv+GM8VWtF36MwEVXl5X7SPH+6w41n5np1/s
         aLFPX857Tjt538NSgzqurAYE5pBQOByU5FPDFHGWCitBZq1I9lzarzB5Msfg40UDBAi1
         ujwSx+JjugS5Wh6d6j0AqJdOIWiJ4sT9GBVd/XM4ElMWvjKgWiCRoqBFKV9nLJNcawNp
         btWTTK2vhhrnmP880PjIhbX66F6pr14AM55cZtD1eHnDoxTlr9AdT/vtlAmRd5gCsDTd
         4/4oUUMvwfExzdu3ts39FrqR7ahvIvD7XsjGxjBWxynrSEgiNSKjY9hkTHg93uTHqCGf
         auSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pka2Wf3vF4GgaDRWibWr079VJVrRTWnpwOYpLbvjDbs=;
        b=LD28no+PuaskxWnwN7zTUWe2ecxdTZdthoD52M0gRkXB2cwIA9wwaDYOH1OQn9iVPl
         ylxbAZrrxZ4scRjkgvvRfA/sX7rzKjJu4yZBNA13ZBw08rUBpR3nQrl+WSNMnOh6UkGq
         La+Z90LDE5ZSmtXLcGi3IkM059ACGImYnDxG45JggK6XgPrHtvPDpgqn8wlFPAckYjru
         bLMiI5zW3BVz0HMat7cNeY8VH53Xrea5wGJowjCP1apRVbAUpCtrpCOu2C1EsF943uOY
         AmxvQCDW7m2Ayg1R6V3DzdQpB4OTXEUaHFeBLi4WIY03xUzD1iomaR/i+HnOAuXIwibP
         wlDg==
X-Gm-Message-State: AJIora+/0Pw0L5hN6TfxC8nyWfYeThKNEUADXEvbwiIbYUTJwhswzSZD
        GXyjJBunq7BZJhV3w/dJUQMkQ7pU97WdBK3yDTN7
X-Google-Smtp-Source: AGRyM1u/SjHMDbnC03CAUgMJ1rqh1VaHc6RFE84uufAQpvDP3zd1dOKS/VWzDHy3BOe+tRjYspRfWlm44PW8kCU90kA=
X-Received: by 2002:a05:6000:1448:b0:219:ebf7:79ff with SMTP id
 v8-20020a056000144800b00219ebf779ffmr7723237wrx.70.1655258845363; Tue, 14 Jun
 2022 19:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220614121030.115491-1-xiujianfeng@huawei.com>
In-Reply-To: <20220614121030.115491-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Jun 2022 22:07:14 -0400
Message-ID: <CAHC9VhR8k-MDnHsMcdYb5SondWGem19CRPx5p23WtkcrHFaBnQ@mail.gmail.com>
Subject: Re: [PATCH -next] lsm_audit: Clean up redundant NULL pointer check
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 14, 2022 at 8:13 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> The implements of {ip,tcp,udp,dccp,sctp,ipv6}_hdr(skb) guarantee that
> they will never return NULL, and elsewhere user don't do the check
> as well, so remove the check here.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/lsm_audit.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

-- 
paul-moore.com
