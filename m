Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B65C433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Mar 2021 13:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70D3F619B3
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Mar 2021 13:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhCWNlG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Mar 2021 09:41:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14851 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbhCWNkp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Mar 2021 09:40:45 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F4XWh4gnMz92Nc;
        Tue, 23 Mar 2021 21:38:40 +0800 (CST)
Received: from [10.67.110.237] (10.67.110.237) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Mar 2021 21:40:33 +0800
Subject: Re: [PATCH] ima: Fix the error code for restoring the PCR value
To:     <zohar@linux.ibm.com>, <roberto.sassu@huawei.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <dmitry.kasatkin@gmail.com>, <jmorris@namei.org>,
        <serge@hallyn.com>, <yangjihong1@huawei.com>,
        <zhangjinhao2@huawei.com>, lihuafei <lihuafei1@huawei.com>
References: <20210303032824.124112-1-lihuafei1@huawei.com>
From:   Li Huafei <lihuafei1@huawei.com>
Message-ID: <9df8d712-0e58-f95d-8f95-5feae2150b42@huawei.com>
Date:   Tue, 23 Mar 2021 21:40:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210303032824.124112-1-lihuafei1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.237]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

ping. :-)

On 2021/3/3 11:28, Li Huafei wrote:
> In ima_restore_measurement_list(), hdr[HDR_PCR].data is pointing to a
> buffer of type u8, which contains the dumped 32-bit pcr value.
> Currently, only the least significant byte is used to restore the pcr
> value. We should convert hdr[HDR_PCR].data to a pointer of type u32
> before fetching the value to restore the correct pcr value.
> 
> Fixes: 47fdee60b47f ("ima: use ima_parse_buf() to parse measurements headers")
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
>   security/integrity/ima/ima_template.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
> index e22e510ae92d..4e081e650047 100644
> --- a/security/integrity/ima/ima_template.c
> +++ b/security/integrity/ima/ima_template.c
> @@ -494,8 +494,8 @@ int ima_restore_measurement_list(loff_t size, void *buf)
>   			}
>   		}
>   
> -		entry->pcr = !ima_canonical_fmt ? *(hdr[HDR_PCR].data) :
> -			     le32_to_cpu(*(hdr[HDR_PCR].data));
> +		entry->pcr = !ima_canonical_fmt ? *(u32 *)(hdr[HDR_PCR].data) :
> +			     le32_to_cpu(*(u32 *)(hdr[HDR_PCR].data));
>   		ret = ima_restore_measurement_entry(entry);
>   		if (ret < 0)
>   			break;
> 
