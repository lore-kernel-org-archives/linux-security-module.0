Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AB9C433E0
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Feb 2021 16:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ED2464E77
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Feb 2021 16:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhBLQMN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 12 Feb 2021 11:12:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1978 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230390AbhBLQMM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 12 Feb 2021 11:12:12 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11CFx5nO125874;
        Fri, 12 Feb 2021 11:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+bqF9W4bn6Jl6kx7g2XaQykKAUCjpocQbbxzK+IzthU=;
 b=mRA7cLGeLERmb0RLP0guybZvSyu0ldxAcjdzxOEDhnWtFs9usc2BrvAcMHBVNu3Od9Z5
 rxcKnm4wOvtgTA17TG0rbUix4/yuIEoq7OJsuFqqSryVnw8MHisop/sbircQaREjRXzO
 +zzVRYK5KqOs+QB1FNwc947TaU0Q4DqdBVAEgdPGVkT2g4GmiBs76pRmIZRUeydIJBbG
 Amex5h1zFiRJ0sZkpI0LmuZFPUoypoM3GeZHBXZuJa9kHIluboc8BHM4Iyu7zRo40s2E
 apNO/jEDP5muhpcg/R7eWsJzM90O8AyRTRV6wKxtVz+cJOfeN3tCzRaT2Zg4+asjQsqj Kg== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36nvt10f3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 11:11:05 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11CG7ah6008317;
        Fri, 12 Feb 2021 16:11:04 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04wdc.us.ibm.com with ESMTP id 36hjr9x5d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 16:11:04 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11CGB3nj17563938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 16:11:03 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6963578064;
        Fri, 12 Feb 2021 16:11:03 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B5307806B;
        Fri, 12 Feb 2021 16:11:02 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.160.81.209])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 12 Feb 2021 16:11:01 +0000 (GMT)
Subject: Re: [PATCH -next] integrity: Make function integrity_add_key() static
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     linux-security-module@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>,
        Hulk Robot <hulkci@huawei.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20210210080131.1209889-1-weiyongjun1@huawei.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <565ffe94-a453-31b4-8b7d-9e03d406e10d@linux.vnet.ibm.com>
Date:   Fri, 12 Feb 2021 11:11:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210210080131.1209889-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-12_05:2021-02-12,2021-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120121
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 2/10/21 3:01 AM, Wei Yongjun wrote:
> The sparse tool complains as follows:
>
> security/integrity/digsig.c:146:12: warning:
>   symbol 'integrity_add_key' was not declared. Should it be static?
>
> This function is not used outside of digsig.c, so this
> commit marks it static.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>   security/integrity/digsig.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index 0f518dcfde05..250fb0836156 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -143,8 +143,8 @@ int __init integrity_init_keyring(const unsigned int id)
>   	return __integrity_init_keyring(id, perm, restriction);
>   }
>
> -int __init integrity_add_key(const unsigned int id, const void *data,
> -			     off_t size, key_perm_t perm)
> +static int __init integrity_add_key(const unsigned int id, const void *data,
> +				    off_t size, key_perm_t perm)
>   {
>   	key_ref_t key;
>   	int rc = 0;

Reviewed-by: Nayna Jain <nayna@linux.ibm.com>


Thanks & Regards,
     - Nayna

