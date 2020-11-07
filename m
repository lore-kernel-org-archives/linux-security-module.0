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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293D3C388F9
	for <linux-security-module@archiver.kernel.org>; Sat,  7 Nov 2020 08:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C13A220704
	for <linux-security-module@archiver.kernel.org>; Sat,  7 Nov 2020 08:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BRFc2wwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgKGI5U (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 7 Nov 2020 03:57:20 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2340 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727886AbgKGI5U (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 7 Nov 2020 03:57:20 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa6616d0000>; Sat, 07 Nov 2020 00:57:17 -0800
Received: from [10.2.49.167] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 7 Nov
 2020 08:57:19 +0000
Subject: Re: [PATCH 2/2] tomoyo: Fixed typo in documentation
To:     Souptick Joarder <jrdr.linux@gmail.com>, <takedakn@nttdata.co.jp>,
        <penguin-kernel@I-love.SAKURA.ne.jp>, <jmorris@namei.org>,
        <serge@hallyn.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1604737451-19082-1-git-send-email-jrdr.linux@gmail.com>
 <1604737451-19082-2-git-send-email-jrdr.linux@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <f5ed0413-315c-d5d0-e33f-c2b247a28da2@nvidia.com>
Date:   Sat, 7 Nov 2020 00:57:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1604737451-19082-2-git-send-email-jrdr.linux@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604739437; bh=GNBT74wqxJtuG5loJdp7D8HcVqzSXdQrLdbC4A0LMlQ=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=BRFc2wwb70lyxFunGYjWYoCw6UmdGCbov2/Go2lEOcwE/3cQ4EvHFRYchP+6XXqdP
         Z8BZ3PdnG/k7RAYgq8iHTWaoYWTH85VPgN+Lr4AMgg/5LfJcLGw505zs52a08IlVun
         V5uxc6Thbebw3aqfhjn8GzyblF4wmXV1wLeeKuYaa7n2UHY+J7YuFDpY0odmLt2us2
         xIpQQWXBkmH/6qvuLPrSeilCQI4R08X4ZBpV26D4fUcngo/yQjW7lFozsdk/us//Xr
         AKeGD2AJhcn2Z5qVTNYJCvnKZfK+g2J12b4YxWjbL8JlACuCHfigNzTjCXG7MQTPjI
         3pZ77kpzmTDDg==
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/7/20 12:24 AM, Souptick Joarder wrote:
> Fixed typo s/Poiner/Pointer
> 
> Fixes: 5b636857fee6 ("TOMOYO: Allow using argv[]/envp[] of execve() as conditions.")
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
>   security/tomoyo/domain.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
> index bd748be..7b2babe 100644
> --- a/security/tomoyo/domain.c
> +++ b/security/tomoyo/domain.c
> @@ -891,7 +891,7 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
>    *
>    * @bprm: Pointer to "struct linux_binprm".
>    * @pos:  Location to dump.
> - * @dump: Poiner to "struct tomoyo_page_dump".
> + * @dump: Pointer to "struct tomoyo_page_dump".

Not worth a separate patch, especially since the original comment is merely
copying the C sources, and as such, does not add any value.

I'd either a) craft a new documentation line that adds some value, or b) just
merge this patch into the previous one, and make a note in the commit
description to the effect that you've included a trivial typo fix as long
as you're there.


thanks,
-- 
John Hubbard
NVIDIA

>    *
>    * Returns true on success, false otherwise.
>    */
> 
