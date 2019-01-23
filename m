Return-Path: <SRS0=bfYL=P7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1649C282C2
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Jan 2019 18:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A205D21872
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Jan 2019 18:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfAWSjP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:39:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725999AbfAWSjO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 Jan 2019 13:39:14 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0NIYtNJ049116
        for <linux-security-module@vger.kernel.org>; Wed, 23 Jan 2019 13:39:13 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q6vdnkesw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Wed, 23 Jan 2019 13:39:13 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 23 Jan 2019 18:39:10 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Jan 2019 18:39:08 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0NId7ii59637790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Jan 2019 18:39:07 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0436011C052;
        Wed, 23 Jan 2019 18:39:07 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7AC311C04C;
        Wed, 23 Jan 2019 18:39:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.107.54])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Jan 2019 18:39:05 +0000 (GMT)
Subject: Re: [PATCH -next] evm: remove set but not used variable 'xattr'
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Wed, 23 Jan 2019 13:38:55 -0500
In-Reply-To: <9bdb64b6-501e-cd37-d4ab-a041ac25e738@huawei.com>
References: <1544867636-59276-1-git-send-email-yuehaibing@huawei.com>
         <1544868370-83459-1-git-send-email-yuehaibing@huawei.com>
         <9bdb64b6-501e-cd37-d4ab-a041ac25e738@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19012318-0020-0000-0000-0000030A7435
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012318-0021-0000-0000-0000215BAFD1
Message-Id: <1548268735.3971.6.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-23_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901230136
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 2019-01-17 at 16:21 +0800, YueHaibing wrote:
> ping...
> 
> On 2018/12/15 18:06, YueHaibing wrote:
> > Fixes gcc '-Wunused-but-set-variable' warning:
> > 
> > security/integrity/evm/evm_main.c: In function 'init_evm':
> > security/integrity/evm/evm_main.c:566:21: warning:
> >  variable 'xattr' set but not used [-Wunused-but-set-variable]
> > 
> > It never used since commit 21af76631476 ("EVM: turn evm_config_xattrnames
> > into a list")
> > 
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thank you.  This patch is now queued in the next-integrity branch of
https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git

Mimi

> > ---
> >  security/integrity/evm/evm_main.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> > index 5ecaa3d..b6d9f14 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -563,7 +563,6 @@ static int __init init_evm(void)
> >  {
> >  	int error;
> >  	struct list_head *pos, *q;
> > -	struct xattr_list *xattr;
> >  
> >  	evm_init_config();
> >  
> > @@ -580,11 +579,8 @@ static int __init init_evm(void)
> >  error:
> >  	if (error != 0) {
> >  		if (!list_empty(&evm_config_xattrnames)) {
> > -			list_for_each_safe(pos, q, &evm_config_xattrnames) {
> > -				xattr = list_entry(pos, struct xattr_list,
> > -						   list);
> > +			list_for_each_safe(pos, q, &evm_config_xattrnames)
> >  				list_del(pos);
> > -			}
> >  		}
> >  	}
> > 
> > 
> > 
> > 
> > .
> > 
> 

