Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE82C433DB
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 23:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F5CF64FF9
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 23:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhCDXub (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Mar 2021 18:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbhCDXub (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Mar 2021 18:50:31 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FE1C061756
        for <linux-security-module@vger.kernel.org>; Thu,  4 Mar 2021 15:50:31 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id g20so358732plo.2
        for <linux-security-module@vger.kernel.org>; Thu, 04 Mar 2021 15:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fBM3x2Jvh9yrxQ8ou6SaTNUrWPPxI8MhXrn4+8d/y8c=;
        b=Hmor8MyonFhRh2pbmVfovEH002W6qy4lse5CAJQ+/Zm17vWvpD3lWwFdzOICcX+QIu
         3DYCK7YULgmVXv0tlY2ijCUyzXAMvvKpjroy9rkuXavrpG98/mg7Vx24VTJf4VNpvZmb
         NfdaAdu7K432oYrEjhmMEANSWaJU2yeh3J/TI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fBM3x2Jvh9yrxQ8ou6SaTNUrWPPxI8MhXrn4+8d/y8c=;
        b=jh1yCLVyy7dlngYatc21V9rE8o00KMks///+JcEQ2kZ1zh1kDX5SFus+uWbMyOuy9V
         /djt6Dh9C/P41SmHqTka7MnEsQNJOTcNBPgznLRXiFC+VPNHi9ud0rqjldTy0skqfMSQ
         xRtsk3Y0VZF363EZF8yL7+36aaxF6wkS4vu68vdDUnO2T2yObf407qyRygTUwzn9JHbw
         GTp7nOeyEp+nPoWZBD5s30O+m2xNzjl31WuTk0TSXkVJRDPInGVChDL8iQnOO+uFbhoa
         YoYcdjC6RhblPgiZqVaUfZkJEpfj+g0db7aSoDqTM8L9c5kYYpuH4OcSoNly6xlTu7N7
         /Scw==
X-Gm-Message-State: AOAM531JPSvM+wlv0ahTwZFLkei7+COiFyQqB0ufuBW7uzde6GFNVwDT
        jerLIs5jwqCsq6V4Mtw3UpZG0oywcWCdNw==
X-Google-Smtp-Source: ABdhPJyaoW1Ju/pSLOkgKfHs1exljGevVAWLF0woDDaC82pKsBL/28eSt8LgZmiOkVSWk05IonrI5w==
X-Received: by 2002:a17:90a:16d6:: with SMTP id y22mr7360453pje.55.1614901830516;
        Thu, 04 Mar 2021 15:50:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k128sm426613pfd.137.2021.03.04.15.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 15:50:29 -0800 (PST)
Date:   Thu, 4 Mar 2021 15:50:29 -0800
From:   Kees Cook <keescook@chromium.org>
To:     zhaojiele <unclexiaole@gmail.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security/loadpin: Replace "kernel_read_file_str[j]" with
 function                   "kernel_read_file_id_str(j)".
Message-ID: <202103041547.2D77671E92@keescook>
References: <20210304083638.174767-1-unclexiaole@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304083638.174767-1-unclexiaole@gmail.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Mar 04, 2021 at 08:36:38AM +0000, zhaojiele wrote:
> Actually Linux kernel already provide function "kernel_read_file_id_str()"
> for secure access in "kernel_read_file.h".And, in "parse_exclude()"
> function, there is no need for
> "BUILD_BUG_ON(ARRAY_SIZE(kernel_read_file_str) <
> ARRAY_SIZE(ignore_read_file_id))"
> when access array by functon "kernel_read_file_id_str(j)".
> 
> Signed-off-by: zhaojiele <unclexiaole@gmail.com>
> ---
>  security/loadpin/loadpin.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index b12f7d986b1e..3e8bdcd06600 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -210,8 +210,6 @@ static void __init parse_exclude(void)
>  	 */
>  	BUILD_BUG_ON(ARRAY_SIZE(exclude_read_files) !=
>  		     ARRAY_SIZE(ignore_read_file_id));
> -	BUILD_BUG_ON(ARRAY_SIZE(kernel_read_file_str) <
> -		     ARRAY_SIZE(ignore_read_file_id));

This should stay to make sure kernel_read_file_str doesn't diverge from
the other two. However, maybe it should be tightened to:

	BUILD_BUG_ON(ARRAY_SIZE(kernel_read_file_str) - 1 ==
		     ARRAY_SIZE(ignore_read_file_id));

>  
>  	for (i = 0; i < ARRAY_SIZE(exclude_read_files); i++) {
>  		cur = exclude_read_files[i];
> @@ -221,9 +219,9 @@ static void __init parse_exclude(void)
>  			continue;
>  
>  		for (j = 0; j < ARRAY_SIZE(ignore_read_file_id); j++) {
> -			if (strcmp(cur, kernel_read_file_str[j]) == 0) {
> +			if (strcmp(cur, kernel_read_file_id_str(j)) == 0) {
>  				pr_info("excluding: %s\n",
> -					kernel_read_file_str[j]);
> +					kernel_read_file_id_str(j));
>  				ignore_read_file_id[j] = 1;
>  				/*
>  				 * Can not break, because one read_file_str

I feel funny about making these into function calls when we've already
validated the index, but yeah, that would be fine. Can you send a v2
with the earlier suggestion addressed?

Thanks!

-Kees

-- 
Kees Cook
