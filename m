Return-Path: <SRS0=bsG4=EN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43CDC388F7
	for <linux-security-module@archiver.kernel.org>; Sat,  7 Nov 2020 09:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61ADF2151B
	for <linux-security-module@archiver.kernel.org>; Sat,  7 Nov 2020 09:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eF1vq7rK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgKGJEw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 7 Nov 2020 04:04:52 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10055 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgKGJEv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 7 Nov 2020 04:04:51 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa663360000>; Sat, 07 Nov 2020 01:04:54 -0800
Received: from [10.2.49.167] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 7 Nov
 2020 09:04:50 +0000
Subject: Re: [PATCH 1/2] tomoyo: Convert get_user_pages*() to
 pin_user_pages*()
To:     Souptick Joarder <jrdr.linux@gmail.com>, <takedakn@nttdata.co.jp>,
        <penguin-kernel@I-love.SAKURA.ne.jp>, <jmorris@namei.org>,
        <serge@hallyn.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
References: <1604737451-19082-1-git-send-email-jrdr.linux@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <e5401549-8c31-2c6d-58dd-864232de17af@nvidia.com>
Date:   Sat, 7 Nov 2020 01:04:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1604737451-19082-1-git-send-email-jrdr.linux@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604739894; bh=f8+saql79WUV7L5gLMVpGfAw9HSYkhJovfzxVrV8yD8=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=eF1vq7rKYFI6buH8AXG3THsWAlBxpIRNEgZZfdzdzkm25+SlgZznBSPScwXxE5WcI
         3/73IpS6+6ThBd9E0JS0yc2FXMmwix3VqQQiUDYpfswJ999hGH44JNUSTAm28s5nkL
         4cIDZd/enhtOxmdu3OEkH1FmqLEAAkh2NSmE4U3JuT4i1IK7FGdUMhTRqjLYBXss4h
         kKYIrrOYYoOKywMK60+E4mtDMvajf9KVgj17BWusydioS7HqU6+iLiZZyQF6NSAqZO
         B8rixL5iEPNfX6U2Rhn20SY8Qn1wIg/FEXi4fIOpIQjBebbI6MX3+HfHQoKc5XCNpC
         pn67CI8azA/vA==
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/7/20 12:24 AM, Souptick Joarder wrote:
> In 2019, we introduced pin_user_pages*() and now we are converting
> get_user_pages*() to the new API as appropriate. [1] & [2] could
> be referred for more information. This is case 5 as per document [1].

It turns out that Case 5 can be implemented via a better pattern, as long
as we're just dealing with a page at a time, briefly:

lock_page()
write to page's data
unlock_page()

...which neatly synchronizes with writeback and other fs activities.

I was going to track down the Case 5's and do that [1].

+CC Jan and Matthew, to keep us on the straight and narrow, just in case
I'm misunderstanding something.

[1] https://lore.kernel.org/r/e78fb7af-627b-ce80-275e-51f97f1f3168@nvidia.com

thanks,
-- 
John Hubbard
NVIDIA

> 
> [1] Documentation/core-api/pin_user_pages.rst
> 
> [2] "Explicit pinning of user-space pages":
>          https://lwn.net/Articles/807108/
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
>   security/tomoyo/domain.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
> index dc4ecc0..bd748be 100644
> --- a/security/tomoyo/domain.c
> +++ b/security/tomoyo/domain.c
> @@ -914,7 +914,7 @@ bool tomoyo_dump_page(struct linux_binprm *bprm, unsigned long pos,
>   	 * (represented by bprm).  'current' is the process doing
>   	 * the execve().
>   	 */
> -	if (get_user_pages_remote(bprm->mm, pos, 1,
> +	if (pin_user_pages_remote(bprm->mm, pos, 1,
>   				FOLL_FORCE, &page, NULL, NULL) <= 0)
>   		return false;
>   #else
> @@ -936,7 +936,7 @@ bool tomoyo_dump_page(struct linux_binprm *bprm, unsigned long pos,
>   	}
>   	/* Same with put_arg_page(page) in fs/exec.c */
>   #ifdef CONFIG_MMU
> -	put_page(page);
> +	unpin_user_page(page);
>   #endif
>   	return true;
>   }
> 
