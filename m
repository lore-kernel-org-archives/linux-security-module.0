Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DD8C433EF
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Nov 2021 12:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 258166109F
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Nov 2021 12:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhKCMRK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Nov 2021 08:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhKCMRK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Nov 2021 08:17:10 -0400
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD03AC061203
        for <linux-security-module@vger.kernel.org>; Wed,  3 Nov 2021 05:14:33 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Hkm0m1xDpzMq3Fn;
        Wed,  3 Nov 2021 13:14:32 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Hkm0l4h6gzlhP4W;
        Wed,  3 Nov 2021 13:14:31 +0100 (CET)
Subject: Re: [PATCH] landlock: Initialize kernel stack variables properly
To:     Austin Kim <austindh.kim@gmail.com>, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211103071427.GA13854@raspberrypi>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <7a71215c-58f4-081b-6a2e-030073f2737e@digikod.net>
Date:   Wed, 3 Nov 2021 13:17:19 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20211103071427.GA13854@raspberrypi>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Austin,

On 03/11/2021 08:14, Austin Kim wrote:
> In case kernel stack variables are not initialized properly, there might 
> be a little chance of kernel information disclosure. So it is better for 
> kernel stack variables to be initialized with null characters.
> 
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> ---
>  security/landlock/syscalls.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 32396962f04d..50a6f7091428 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -320,6 +320,8 @@ SYSCALL_DEFINE4(landlock_add_rule,
>  	if (rule_type != LANDLOCK_RULE_PATH_BENEATH)
>  		return -EINVAL;
>  
> +	memset(&path_beneath_attr, 0, sizeof(path_beneath_attr));
> +

This memset is already done with the copy_from_user() call just below.

>  	/* Copies raw user space buffer, only one type for now. */
>  	res = copy_from_user(&path_beneath_attr, rule_attr,
>  			sizeof(path_beneath_attr));
> 
