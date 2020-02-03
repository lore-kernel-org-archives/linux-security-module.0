Return-Path: <SRS0=n7+0=3X=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E92EC3524D
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Feb 2020 13:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33BD2080D
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Feb 2020 13:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgBCNV3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:21:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37486 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727872AbgBCNV3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Feb 2020 08:21:29 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 013DI8qI127981
        for <linux-security-module@vger.kernel.org>; Mon, 3 Feb 2020 08:21:27 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xxhf6p14h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Mon, 03 Feb 2020 08:21:27 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 3 Feb 2020 13:21:25 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 3 Feb 2020 13:21:21 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 013DLJwq57344220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Feb 2020 13:21:19 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0F4752059;
        Mon,  3 Feb 2020 13:21:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.207.146])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4449A52054;
        Mon,  3 Feb 2020 13:21:18 +0000 (GMT)
Subject: Re: [PATCH] security/integrity: Include __func__ in messages for
 easier debug
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Joe Perches <joe@perches.com>,
        Shuah Khan <skhan@linuxfoundation.org>, jmorris@namei.org,
        serge@hallyn.com, mpe@ellerman.id.au, erichte@linux.ibm.com,
        nayna@linux.ibm.com, yuehaibing@huawei.com
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 03 Feb 2020 08:21:17 -0500
In-Reply-To: <ab2e19123cc15e3f8039b0d36e6ebae385db700e.camel@perches.com>
References: <20200130020129.15328-1-skhan@linuxfoundation.org>
         <ab2e19123cc15e3f8039b0d36e6ebae385db700e.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20020313-0012-0000-0000-0000038342DD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020313-0013-0000-0000-000021BFA6B5
Message-Id: <1580736077.5585.4.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-03_04:2020-02-02,2020-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002030099
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2020-01-29 at 19:08 -0800, Joe Perches wrote:
> On Wed, 2020-01-29 at 19:01 -0700, Shuah Khan wrote:
> > Change messages to messages to make it easier to debug. The following
> > error message isn't informative enough to figure out what failed.
> > Change messages to include function information.
> > 
> > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> > ---
> >  .../integrity/platform_certs/load_powerpc.c     | 14 ++++++++------
> >  security/integrity/platform_certs/load_uefi.c   | 17 ++++++++++-------
> >  2 files changed, 18 insertions(+), 13 deletions(-)
> > 
> > diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
> 
> perhaps instead add #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> so all the pr_<level> logging is more specific.
> 
> This would prefix all pr_<level> output with "integrity: "

Agreed.  Joe, could you post a patch with a proper patch description
for this?

thanks,

Mimi

