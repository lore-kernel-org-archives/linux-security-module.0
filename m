Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296B6C4743D
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Jun 2021 17:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12EE76127A
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Jun 2021 17:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbhFHREr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 8 Jun 2021 13:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbhFHREq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Jun 2021 13:04:46 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DA6C061795
        for <linux-security-module@vger.kernel.org>; Tue,  8 Jun 2021 10:02:38 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g24so12282769pji.4
        for <linux-security-module@vger.kernel.org>; Tue, 08 Jun 2021 10:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4usFl7sIsVthQj7CAaTLNOirYn+9w5CcbbsPb6gzTZs=;
        b=JlUf729Lw0qh8gpM+lacYrwI/BZHfR8iaIh6HWob68cqLRbEOcHJt9U9t2YgpQU93j
         5p+//oTnvpy2Z43uQrbn65F8sQfCvpsHOcdByFr2F9G3lB39uVlA7OfOv5iL0bwRwVfq
         YTTgYWPVApdUTu3XoW2nGATAhWdVzSTq61Bg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4usFl7sIsVthQj7CAaTLNOirYn+9w5CcbbsPb6gzTZs=;
        b=TaqnyIiWXtOhznvkXAKsTr5qn9hZN3nKrr18Hd/6l+L0U/RJy5ANYWFlDPmedcCawW
         4ZAg4XCRXM0HTVfnl9c7QMgYBCjjxnMD3d0d40C9DaHIRiB7Nmgy1yxKif2ovFGH7tBT
         jhiBltv7faNLW7QrfQbtGp6aR1D/vs/jE91moYIYeRGoSY7icC6cVQ6LDOdfJu7MmbF/
         HqGLV4389PpjpjxE5i/xxFCCXjnEzbsx/VHGzgxGMHKh5AN+7asOTGv8zkL+jOW4NpV2
         aptHuOkG6jBiantcWHXrGkJQDwNnOEw3267HOOT26AJPoKQ7ttgT5ODa4AZ+nZCdBtsS
         Mp4A==
X-Gm-Message-State: AOAM532Bklc/0Ry+VtfjqhpjOEyDY6gQ0IMOXn0rXKzJbRBPhbbZjVuS
        KqX0Ip+s2WI1GPS/kUbsYNtODw==
X-Google-Smtp-Source: ABdhPJxaSatIHX/sZrfjfZA+xFPKOXe2WFUxGqcRbH4r+NdC1vX/iNz1cah9e+xIGvpANxz9gqGpmQ==
X-Received: by 2002:a17:90a:b28d:: with SMTP id c13mr5823656pjr.80.1623171757403;
        Tue, 08 Jun 2021 10:02:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w2sm11476540pfc.126.2021.06.08.10.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:02:36 -0700 (PDT)
Date:   Tue, 8 Jun 2021 10:02:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ima: Fix fall-through warning for Clang
Message-ID: <202106081002.252C11321F@keescook>
References: <20210607204934.GA63263@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607204934.GA63263@embeddedor>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 07, 2021 at 03:49:34PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a
> fall-through warning by explicitly adding a break statement instead
> of just letting the code fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> JFYI: We had thousands of these sorts of warnings and now we are down
>       to just 13 in linux-next(20210607). This is one of those last
>       remaining warnings. :)

Looks right to me; thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

> 
>  security/integrity/ima/ima_template_lib.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
> index 518fd50ea48a..8f96247b4a5c 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> @@ -119,6 +119,7 @@ static void ima_show_template_data_ascii(struct seq_file *m,
>  		default:
>  			break;
>  		}
> +		break;
>  	default:
>  		break;
>  	}
> -- 
> 2.27.0
> 

-- 
Kees Cook
