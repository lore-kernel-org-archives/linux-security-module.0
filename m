Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7825C433B4
	for <linux-security-module@archiver.kernel.org>; Tue,  6 Apr 2021 12:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 896EF613C6
	for <linux-security-module@archiver.kernel.org>; Tue,  6 Apr 2021 12:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243170AbhDFMqw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 6 Apr 2021 08:46:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238988AbhDFMqu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 6 Apr 2021 08:46:50 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 136CYekB067856;
        Tue, 6 Apr 2021 08:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=N2HYbq+DP5GjAQFh4BQgOct+20zb8QIEIVdBX6wIHCY=;
 b=FWu6/BnJann6sR1t8VTlBoFQUcNJSf/wNUrmffH5SGZQgXiR5MxEtno2uO34gsiEZXt5
 Fdzs4PES+wwVK70HxJZuB/uQ0ZScQtJSAiq/jihM057APQ/Kye759T0VP91jxMF7a9CD
 IxUAGaayqQnGc4MYaR3pweQgCSMXv4iWFLqMijS8d0U3mTbTRjkcBwqbgVk9A4l0OQ8b
 2newToYYyYwemp8d9xJXUOMTIJHYJfEw3SmZnoIj+WHlcbc3e5Fpsx8lRgv90Qhrm8j2
 tY3zUgOoHjdubPzoSJ+9ql/uP8X1g/9qbkYHEY38DVj9qNUxf6l2PJ5dpudGm1a9WPyx Rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37q5dv9hfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 08:46:39 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 136CYdOc067743;
        Tue, 6 Apr 2021 08:46:39 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37q5dv9heb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 08:46:38 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 136CTBOL018010;
        Tue, 6 Apr 2021 12:46:36 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 37q2q5j5dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 12:46:36 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 136CkDf730343546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Apr 2021 12:46:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11E645204F;
        Tue,  6 Apr 2021 12:46:34 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.36.140])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A27105204E;
        Tue,  6 Apr 2021 12:46:32 +0000 (GMT)
Message-ID: <02aea740eadccd6512a3781632284113127a5494.camel@linux.ibm.com>
Subject: Re: [PATCH] integrity/ima: Add declarations to init_once void
 arguments.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jiele Zhao <unclexiaole@gmail.com>, serge@hallyn.com,
        jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 06 Apr 2021 08:46:31 -0400
In-Reply-To: <20210323013318.296993-1-unclexiaole@gmail.com>
References: <20210323013318.296993-1-unclexiaole@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vSu16LnikMXMNY2tQ4AgHnB8qowSsU32
X-Proofpoint-ORIG-GUID: HzlMjAEURFFEjxDo8NOrTyeS1hbHVGBH
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-06_03:2021-04-01,2021-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104060086
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Jiele,

On Tue, 2021-03-23 at 01:33 +0000, Jiele Zhao wrote:
> init_once is a callback to kmem_cache_create. The parameter
> type of this function is void *, so it's better to give a
> explicit cast here.
> 
> Signed-off-by: Jiele Zhao <unclexiaole@gmail.com>

Please remove the "ima" in the Subject line and re-post Cc'ing the
linux-integrity mailing list.

> ---
>  security/integrity/iint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 1d20003243c3..5f3f2de997e1 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -152,7 +152,7 @@ void integrity_inode_free(struct inode *inode)
> 
>  static void init_once(void *foo)
>  {
> -	struct integrity_iint_cache *iint = foo;
> +	struct integrity_iint_cache *iint = (struct integrity_iint_cache *)foo;

Like the other init_once() examples, please add a blank before foo.

thanks,

Mimi
> 
>  	memset(iint, 0, sizeof(*iint));
>  	iint->ima_file_status = INTEGRITY_UNKNOWN;


