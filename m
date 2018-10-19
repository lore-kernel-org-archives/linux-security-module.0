Return-Path: <SRS0=lQbE=M7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912A7ECDE43
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Oct 2018 16:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1106A20658
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Oct 2018 16:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1106A20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeJTAhZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:37:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49610 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727592AbeJTAhZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 Oct 2018 20:37:25 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9JGTdT2013152
        for <linux-security-module@vger.kernel.org>; Fri, 19 Oct 2018 12:30:34 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n7ft492gv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Fri, 19 Oct 2018 12:30:34 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <jejb@linux.ibm.com>;
        Fri, 19 Oct 2018 10:30:33 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 19 Oct 2018 10:30:29 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9JGUSgM20643946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Oct 2018 09:30:28 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34C9D7806A;
        Fri, 19 Oct 2018 16:30:28 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0CFA7805F;
        Fri, 19 Oct 2018 16:30:25 +0000 (GMT)
Received: from [153.66.254.194] (unknown [9.85.146.21])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 19 Oct 2018 16:30:25 +0000 (GMT)
Subject: Re: [PATCH v2 -next] KEYS: trusted: remove set but not used
 variable 'keyhndl'
From:   James Bottomley <jejb@linux.ibm.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Fri, 19 Oct 2018 09:30:23 -0700
In-Reply-To: <1539949699-74650-1-git-send-email-yuehaibing@huawei.com>
References: <1539241599-140866-1-git-send-email-yuehaibing@huawei.com>
         <1539949699-74650-1-git-send-email-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101916-0016-0000-0000-000009459F3C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009901; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01105003; UDB=6.00572094; IPR=6.00885054;
 MB=3.00023825; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-19 16:30:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101916-0017-0000-0000-000040C41DF7
Message-Id: <1539966623.2819.3.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-19_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=889 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810190146
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 2018-10-19 at 11:48 +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> security/keys/trusted.c: In function 'tpm_unseal':
> security/keys/trusted.c:592:11: warning:
>  variable 'keyhndl' set but not used [-Wunused-but-set-variable]
>   uint32_t keyhndl;
> 
> It never used since introduction in 
> commit d00a1c72f7f4 ("keys: add new trusted key-type")

This triggered an "er, shouldn't we be using the SRK parent by
default?"  search through the code, but it turns out that's all taken
care of in trusted_options_alloc() where we'll set up the SRK as parent
with well known auth and unless overridden on the command line, that's
what we use, so I'm happy this is simply left over code from a
different implementation of that use case.

James

