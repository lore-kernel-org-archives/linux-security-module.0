Return-Path: <SRS0=9aR4=3Z=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0844AC35249
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Feb 2020 10:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF03D2085B
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Feb 2020 10:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgBEKjP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Feb 2020 05:39:15 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2374 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727170AbgBEKjP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Feb 2020 05:39:15 -0500
Received: from lhreml706-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id ECE3A413CD6F6985D433;
        Wed,  5 Feb 2020 10:39:13 +0000 (GMT)
Received: from fraeml706-chm.china.huawei.com (10.206.15.55) by
 lhreml706-cah.china.huawei.com (10.201.108.47) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 5 Feb 2020 10:39:13 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 5 Feb 2020 11:39:13 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Wed, 5 Feb 2020 11:39:13 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2 3/8] ima: Evaluate error in init_ima()
Thread-Topic: [PATCH v2 3/8] ima: Evaluate error in init_ima()
Thread-Index: AQHV3A/yDtFzVQlGOECsIOYH0olaDqgMaBfw
Date:   Wed, 5 Feb 2020 10:39:13 +0000
Message-ID: <2a45c4f2304549eb870279e83c5a3d86@huawei.com>
References: <20200205103317.29356-1-roberto.sassu@huawei.com>
 <20200205103317.29356-4-roberto.sassu@huawei.com>
In-Reply-To: <20200205103317.29356-4-roberto.sassu@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.220.96.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> -----Original Message-----
> From: Roberto Sassu
> Sent: Wednesday, February 5, 2020 11:33 AM
> To: zohar@linux.ibm.com; James.Bottomley@HansenPartnership.com;
> jarkko.sakkinen@linux.intel.com
> Cc: linux-integrity@vger.kernel.org; linux-security-module@vger.kernel.org;
> linux-kernel@vger.kernel.org; Silviu Vlasceanu
> <Silviu.Vlasceanu@huawei.com>; Roberto Sassu
> <roberto.sassu@huawei.com>
> Subject: [PATCH v2 3/8] ima: Evaluate error in init_ima()
> 
> Evaluate error in init_ima() before register_blocking_lsm_notifier() and
> return if not zero.
> 
> Fixes: b16942455193 ("ima: use the lsm policy update notifier")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Add in CC stable@vger.kernel.org.

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> ---
>  security/integrity/ima/ima_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_main.c
> b/security/integrity/ima/ima_main.c
> index d7e987baf127..a16c148ed90d 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -738,6 +738,9 @@ static int __init init_ima(void)
>  		error = ima_init();
>  	}
> 
> +	if (error)
> +		return error;
> +
>  	error = register_blocking_lsm_notifier(&ima_lsm_policy_notifier);
>  	if (error)
>  		pr_warn("Couldn't register LSM notifier, error %d\n", error);
> --
> 2.17.1

