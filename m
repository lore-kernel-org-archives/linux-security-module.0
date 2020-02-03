Return-Path: <SRS0=n7+0=3X=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F703C35247
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Feb 2020 15:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D9B217BA
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Feb 2020 15:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgBCPP3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 3 Feb 2020 10:15:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729062AbgBCPP3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Feb 2020 10:15:29 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 013FCwGH029343;
        Mon, 3 Feb 2020 10:15:09 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xxhfahuk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Feb 2020 10:15:08 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 013FEtRo002103;
        Mon, 3 Feb 2020 15:15:08 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02dal.us.ibm.com with ESMTP id 2xw0y6e89g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Feb 2020 15:15:07 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 013FF6wf45220128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Feb 2020 15:15:06 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F4216BE05A;
        Mon,  3 Feb 2020 15:15:05 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F0DCBE05B;
        Mon,  3 Feb 2020 15:15:04 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.160.115.135])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  3 Feb 2020 15:15:04 +0000 (GMT)
Subject: Re: [PATCH] security/integrity: Include __func__ in messages for
 easier debug
To:     Joe Perches <joe@perches.com>,
        Shuah Khan <skhan@linuxfoundation.org>, jmorris@namei.org,
        serge@hallyn.com, mpe@ellerman.id.au, zohar@linux.ibm.com,
        erichte@linux.ibm.com, nayna@linux.ibm.com, yuehaibing@huawei.com
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200130020129.15328-1-skhan@linuxfoundation.org>
 <ab2e19123cc15e3f8039b0d36e6ebae385db700e.camel@perches.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <79d7b969-9b7d-7853-356b-876e444d3390@linux.vnet.ibm.com>
Date:   Mon, 3 Feb 2020 10:15:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <ab2e19123cc15e3f8039b0d36e6ebae385db700e.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-03_04:2020-02-02,2020-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 clxscore=1011 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002030114
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 1/29/20 10:08 PM, Joe Perches wrote:
> On Wed, 2020-01-29 at 19:01 -0700, Shuah Khan wrote:
>> Change messages to messages to make it easier to debug. The following
>> error message isn't informative enough to figure out what failed.
>> Change messages to include function information.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   .../integrity/platform_certs/load_powerpc.c     | 14 ++++++++------
>>   security/integrity/platform_certs/load_uefi.c   | 17 ++++++++++-------
>>   2 files changed, 18 insertions(+), 13 deletions(-)
>>
>> diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
> perhaps instead add #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> so all the pr_<level> logging is more specific.
>
> This would prefix all pr_<level> output with "integrity: "
>
> 3integrity: Couldn't get size: 0x%lx
> 3integrity: Error reading db var: 0x%lx
> 3integrity: MODSIGN: Couldn't get UEFI db list
> 3integrity: Couldn't parse db signatures: %d
> 6integrity: Couldn't get UEFI MokListRT
> 3integrity: Couldn't parse MokListRT signatures: %d
> 6integrity: Couldn't get UEFI dbx list
> 3integrity: Couldn't parse dbx signatures: %d
>
> 5integrity: Platform Keyring initialized
> 6integrity: Error adding keys to platform keyring %s
>
> ---
>   security/integrity/platform_certs/load_powerpc.c     | 3 +++
>   security/integrity/platform_certs/load_uefi.c        | 2 ++
>   security/integrity/platform_certs/platform_keyring.c | 2 ++
>   3 files changed, 7 insertions(+)
>
> diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
> index a2900c..5cfbd0 100644
> --- a/security/integrity/platform_certs/load_powerpc.c
> +++ b/security/integrity/platform_certs/load_powerpc.c
> @@ -5,6 +5,9 @@
>    *
>    *      - loads keys and hashes stored and controlled by the firmware.
>    */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +

Looks good. How about slight addition in it as below:

#define pr_fmt(fmt) KBUILD_MODNAME ": load_powerpc: " fmt


>   #include <linux/kernel.h>
>   #include <linux/sched.h>
>   #include <linux/cred.h>
> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
> index 111898a..480450a 100644
> --- a/security/integrity/platform_certs/load_uefi.c
> +++ b/security/integrity/platform_certs/load_uefi.c
> @@ -1,5 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

Similarly...

#define pr_fmt(fmt) KBUILD_MODNAME ": load_uefi: " fmt

> +
>   #include <linux/kernel.h>
>   #include <linux/sched.h>
>   #include <linux/cred.h>
> diff --git a/security/integrity/platform_certs/platform_keyring.c b/security/integrity/platform_certs/platform_keyring.c
> index 7646e35..9bd2846 100644
> --- a/security/integrity/platform_certs/platform_keyring.c
> +++ b/security/integrity/platform_certs/platform_keyring.c
> @@ -6,6 +6,8 @@
>    * Author(s): Nayna Jain <nayna@linux.ibm.com>
>    */
>   
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

Same here...

#define pr_fmt(fmt) KBUILD_MODNAME ": platform_keyring:  " fmt

Thanks & Regards,

       - Nayna

