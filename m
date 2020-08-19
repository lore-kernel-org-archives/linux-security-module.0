Return-Path: <SRS0=6iY4=B5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0C3C433DF
	for <linux-security-module@archiver.kernel.org>; Wed, 19 Aug 2020 18:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68109208E4
	for <linux-security-module@archiver.kernel.org>; Wed, 19 Aug 2020 18:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dm12xVmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgHSSEc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgHSSE2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 19 Aug 2020 14:04:28 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF15C061342
        for <linux-security-module@vger.kernel.org>; Wed, 19 Aug 2020 11:04:27 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id u10so11199144plr.7
        for <linux-security-module@vger.kernel.org>; Wed, 19 Aug 2020 11:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o5QWU1nEiy+Wm6gh5sFTQwgB0RXtZgwdt6tODGtZKRg=;
        b=Dm12xVmMzZ7+gsbRjbkm68z3UhSAAY6ovLHRwBvSlZRYXMn/jyVefCRwwEuid/htYs
         br88nAj9HKrAuowA12vkOzJAwRYaRkbgsNo09lWJDv7VL18k1yKtxP+qrqbV68ClR1J9
         aINuOTkBRJSvuCX+knwKWIe7bXQAL6ulo1Sg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o5QWU1nEiy+Wm6gh5sFTQwgB0RXtZgwdt6tODGtZKRg=;
        b=VCzENvUkC+OHuuPL5PfJNoIsST5TSxDWjLxNes/zt7bE4fzi5YFWTusNguGRl6Anc/
         V2UpTOJ/14ybd8dBxJ8CDCgddi7FbwSJ1eUTEzGO0m0YEPega1/b2TzdysqvMmXP/h0k
         V15KWQbBUwPuOeAgutRgIj8O/Axttw0TIQAL44o5viKbDPi4xYqfMDTX5h71y8a84C/y
         GNX9Jl/zQtL5XjqBwtSog1Lxp14eF5DsmtQ5u1sTOdBJAyrWyHxhLYf+d1QRkrnKEpVq
         p9kU2tolVNbxLoOc2imfI1B+Zp0H9K9k0vraQsJs6d1RaocnFjYIMGJvtqNMY0tYASYt
         Bh2g==
X-Gm-Message-State: AOAM530plrtMAtFa/DW3/qN22QJNRlclpObqDjgUTZbTn3QUDIFrRolS
        YBYS6Z5RDRrwFn1qVIE11mlKRg==
X-Google-Smtp-Source: ABdhPJzcCUFsTUuuU/7fR9DIMfV1GDtBk230JWzP+wvh2sEXRmU+hodx93sL2eXCM5k81uPM4O9/vg==
X-Received: by 2002:a17:90b:46d3:: with SMTP id jx19mr5046020pjb.158.1597860267077;
        Wed, 19 Aug 2020 11:04:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d4sm3563704pju.56.2020.08.19.11.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 11:04:26 -0700 (PDT)
Date:   Wed, 19 Aug 2020 11:04:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] mm/migrate: Avoid possible unnecessary
 ptrace_may_access() call in kernel_move_pages()
Message-ID: <202008191103.D88345E410@keescook>
References: <20200817115933.44565-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817115933.44565-1-linmiaohe@huawei.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 17, 2020 at 07:59:33AM -0400, Miaohe Lin wrote:
> There is no need to check if this process has the right to modify the
> specified process when they are same.
> 
> Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 34a842a8eb6a..342c1ce0b433 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1903,7 +1903,7 @@ static int kernel_move_pages(pid_t pid, unsigned long nr_pages,
>  	 * Check if this process has the right to modify the specified
>  	 * process. Use the regular "ptrace_may_access()" checks.
>  	 */
> -	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
> +	if (pid && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
>  		rcu_read_unlock();
>  		err = -EPERM;
>  		goto out;

NAK, please don't do this -- the ptrace and security hooks already do
these kinds of self-introspection checks, and I'd like to keep a central
place to perform these kinds of checks.

Is there a specific problem you've encountered that this fixes?

-- 
Kees Cook
