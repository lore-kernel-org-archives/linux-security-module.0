Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71115C433F5
	for <linux-security-module@archiver.kernel.org>; Wed, 18 May 2022 20:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242565AbiERUZb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 18 May 2022 16:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242552AbiERUZb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 18 May 2022 16:25:31 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8C393469
        for <linux-security-module@vger.kernel.org>; Wed, 18 May 2022 13:25:30 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id a11so3189966pff.1
        for <linux-security-module@vger.kernel.org>; Wed, 18 May 2022 13:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T0RUFEAAb0EUvAvgjmVhvNXqgIl2634hQPp6NyaB/BE=;
        b=L6sJM823YSYGCEu5Vx6kyBcGRMkDtvbRk1g3zMveNTQGmV1rJUbhpDm7tL9Sx53GdH
         9BrG2SjuHMe2C+hS937ohWm4LWCp73Kyg7h/TnDUfPe5ubtQDzsM0mbu8ovx+iAubhfz
         4oTampAzdwVEv+3BeGvkjx4CzH4EErl0TPsPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T0RUFEAAb0EUvAvgjmVhvNXqgIl2634hQPp6NyaB/BE=;
        b=fqi/TfHW7ejLKhI4joDcvrx0KogzsTZ3btlvlz6PzC6S1TmTR4UHv6KfZEZ8MrmK45
         QynG31ucYu5x4S1quhpviiyqZQNYTFQD3l5r3a/1Qz/JpIwugUpgOugG0n+3/PNkICP8
         xFrTR3F6dntM1ZYVkWIcfM/GipMZ155YSH2Y/Na2lcn1QjK927HidDm9zO0jusw12ygg
         ovUNYCeb7qhH8uf9M8kgfqLkB4wdg/kEAVIWqPrlz5lfqO+tlTML3XbVxauLq7JQWalf
         f279vrkU4xNDoxJ1I+NqjF6kgkZS++21il42ohg6jAx7Ht00V7Qlve72lF6gWEj+rCzA
         XmUw==
X-Gm-Message-State: AOAM53388aMIGJvenVeL/0q4sM57Ae+CxwuTSQMGXzz/GnJMa9l9Fqjr
        RBWd0deBT3Tpt9QR7qqc/pCCviDz/70YCQ==
X-Google-Smtp-Source: ABdhPJwFG8w1ZTkhJXaj8JxUZLxZnFHlyBsxl5a7UPCmYkYRpDDj0B2yfmzhsYf7Q7TqK6uD1CEWqw==
X-Received: by 2002:a63:e40c:0:b0:3f2:5729:eace with SMTP id a12-20020a63e40c000000b003f25729eacemr998455pgi.384.1652905530072;
        Wed, 18 May 2022 13:25:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ji15-20020a170903324f00b001616e13fccdsm2114121plb.221.2022.05.18.13.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:25:29 -0700 (PDT)
Date:   Wed, 18 May 2022 13:25:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "GONG, Ruiqi" <gongruiqi1@huawei.com>
Cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: Re: [PATCH] security: keys: add __randomize_layout to
 keyring_search_context
Message-ID: <202205181325.0D772A54@keescook>
References: <20220518091841.141441-1-gongruiqi1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518091841.141441-1-gongruiqi1@huawei.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, May 18, 2022 at 09:18:41AM +0000, GONG, Ruiqi wrote:
> Struct keyring_search_context contains a pointer to `struct cred`, which
> is a security-critical structure and whose layout is randomized already.
> Apply __randomize_layout to struct keyring_search_context as well, as
> suggested in [1].
> 
> [1]: https://github.com/KSPP/linux/issues/188
> 
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>

Seems reasonable to me; it's an entirely internal structure.

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
>  security/keys/internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/keys/internal.h b/security/keys/internal.h
> index 9b9cf3b6fcbb..3e3def5fbaa4 100644
> --- a/security/keys/internal.h
> +++ b/security/keys/internal.h
> @@ -136,7 +136,7 @@ struct keyring_search_context {
>  	bool			possessed;
>  	key_ref_t		result;
>  	time64_t		now;
> -};
> +} __randomize_layout;
>  
>  extern bool key_default_cmp(const struct key *key,
>  			    const struct key_match_data *match_data);
> -- 
> 2.17.1
> 

-- 
Kees Cook
