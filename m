Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D864C12002
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Jul 2021 19:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16723613C2
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Jul 2021 19:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhGNTPZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 14 Jul 2021 15:15:25 -0400
Received: from namei.org ([65.99.196.166]:42532 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229735AbhGNTPY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 14 Jul 2021 15:15:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 1F7414A2;
        Wed, 14 Jul 2021 19:05:50 +0000 (UTC)
Date:   Thu, 15 Jul 2021 05:05:50 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Austin Kim <austindh.kim@gmail.com>
cc:     serge@hallyn.com, keescook@chromium.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, austin.kim@lge.com,
        kernel-team@lge.com
Subject: Re: [PATCH] LSM: add NULL check for kcalloc()
In-Reply-To: <20210712234434.GA29205@raspberrypi>
Message-ID: <e0a2655b-3bc6-fd45-bd84-8df2dc6bc5f@namei.org>
References: <20210712234434.GA29205@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 13 Jul 2021, Austin Kim wrote:

> From: Austin Kim <austin.kim@lge.com>
> 
> kcalloc() may return NULL when memory allocation fails.
> So it is necessary to add NULL check after the call to kcalloc() is made.
> 
> Signed-off-by: Austin Kim <austin.kim@lge.com>
> ---
>  security/security.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/security/security.c b/security/security.c
> index 09533cbb7221..f885c9e9bc35 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -321,6 +321,8 @@ static void __init ordered_lsm_init(void)
>  
>  	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
>  				GFP_KERNEL);
> +	if (ordered_lsms)
> +		return;

Your logic is reversed here.

Should this also be a kernel panic?

>  
>  	if (chosen_lsm_order) {
>  		if (chosen_major_lsm) {
> -- 
> 2.20.1
> 

-- 
James Morris
<jmorris@namei.org>

