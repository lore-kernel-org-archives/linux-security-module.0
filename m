Return-Path: <SRS0=zJ1g=OY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB975C43444
	for <linux-security-module@archiver.kernel.org>; Sat, 15 Dec 2018 09:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C41F2084D
	for <linux-security-module@archiver.kernel.org>; Sat, 15 Dec 2018 09:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbeLOJ4V (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 15 Dec 2018 04:56:21 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:58976 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729077AbeLOJ4V (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 15 Dec 2018 04:56:21 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C34ADADB7528D;
        Sat, 15 Dec 2018 17:56:17 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Sat, 15 Dec 2018
 17:56:15 +0800
Subject: Re: [PATCH -next] evm: CHECK-remove set but not used variable 'xattr'
To:     Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <1544867636-59276-1-git-send-email-yuehaibing@huawei.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <54fc931f-b200-8e61-8d70-8ba1eca9a181@huawei.com>
Date:   Sat, 15 Dec 2018 17:56:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1544867636-59276-1-git-send-email-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Sorry, the patch title need fix, Pls ignore this.

On 2018/12/15 17:53, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> security/integrity/evm/evm_main.c: In function 'init_evm':
> security/integrity/evm/evm_main.c:566:21: warning:
>  variable 'xattr' set but not used [-Wunused-but-set-variable]
> 
> It never used since commit 21af76631476 ("EVM: turn evm_config_xattrnames
> into a list")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  security/integrity/evm/evm_main.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 5ecaa3d..b6d9f14 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -563,7 +563,6 @@ static int __init init_evm(void)
>  {
>  	int error;
>  	struct list_head *pos, *q;
> -	struct xattr_list *xattr;
>  
>  	evm_init_config();
>  
> @@ -580,11 +579,8 @@ static int __init init_evm(void)
>  error:
>  	if (error != 0) {
>  		if (!list_empty(&evm_config_xattrnames)) {
> -			list_for_each_safe(pos, q, &evm_config_xattrnames) {
> -				xattr = list_entry(pos, struct xattr_list,
> -						   list);
> +			list_for_each_safe(pos, q, &evm_config_xattrnames)
>  				list_del(pos);
> -			}
>  		}
>  	}
> 
> 
> 
> 
> .
> 

