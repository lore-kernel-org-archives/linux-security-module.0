Return-Path: <SRS0=Yj31=56=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C626C2BA19
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Apr 2020 15:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC0F20768
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Apr 2020 15:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oq/OEGlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438237AbgDNPSP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:18:15 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53734 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438173AbgDNPSL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Apr 2020 11:18:11 -0400
Received: from [192.168.0.109] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id D5D1620B4749;
        Tue, 14 Apr 2020 08:18:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D5D1620B4749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1586877490;
        bh=4IIImuaLvQT2iR/sNQJatsIB6K/I65B+tYihxbsMJ7k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oq/OEGlfP9okH1qtZ31v4IyXkYxGMGV7aIw+XPesurrFtdWZY9SCu7Fc3ITFnt2rj
         YOzyLo111+2jN2fVKEuGOBQLYErHisIizP+eSbQ4WxxLsVKII0XDO4Xn+NLSBblFhG
         pGYKmpc/zhu60ng8DKVag8Cp7EGrJA3LOnb7yPSI=
Subject: Re: [PATCH 2/2] ima: simplify function process_buffer_measurement
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, zhangliguang@linux.alibaba.com,
        zhang.jia@linux.alibaba.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200414114850.98622-1-tianjia.zhang@linux.alibaba.com>
 <20200414114850.98622-3-tianjia.zhang@linux.alibaba.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <a18c37b9-7534-86c4-3bae-111ac1fa4053@linux.microsoft.com>
Date:   Tue, 14 Apr 2020 08:18:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414114850.98622-3-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 4/14/20 4:48 AM, Tianjia Zhang wrote:

> Remove duplicate judgment code to make it more suitable for linux
> code style.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>   security/integrity/ima/ima_main.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 9d0abedeae77..55cbbe97ce6e 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -750,15 +750,15 @@ void process_buffer_measurement(const void *buf, int size,
>   		goto out;
>   
>   	ret = ima_store_template(entry, violation, NULL, buf, pcr);
> -
> -	if (ret < 0)
> -		ima_free_template_entry(entry);
> -
> -out:
>   	if (ret < 0)
> -		pr_devel("%s: failed, result: %d\n", __func__, ret);
> +		goto out_free_entry;
>   
>   	return;
> +
> +out_free_entry:
> +	ima_free_template_entry(entry);
> +out:
> +	pr_devel("%s: failed, result: %d\n", __func__, ret);
>   }

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
