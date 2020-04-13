Return-Path: <SRS0=fcCn=55=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0274FC2BA2B
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Apr 2020 21:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1BE62051A
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Apr 2020 21:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389361AbgDMV4K (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:56:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728016AbgDMV4I (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Apr 2020 17:56:08 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03DLYjbb057936
        for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2020 17:56:06 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30ba1h18a7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2020 17:56:06 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 13 Apr 2020 22:55:26 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 Apr 2020 22:55:22 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03DLssww49349012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 21:54:54 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CEB3A4054;
        Mon, 13 Apr 2020 21:56:00 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC7C2A405B;
        Mon, 13 Apr 2020 21:55:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.178.165])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 Apr 2020 21:55:58 +0000 (GMT)
Subject: Re: [PATCH 0/2] support to read and tune appraise mode in runtime
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        zhangliguang@linux.alibaba.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>
Date:   Mon, 13 Apr 2020 17:55:58 -0400
In-Reply-To: <20200409033907.102833-1-tianjia.zhang@linux.alibaba.com>
References: <20200409033907.102833-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20041321-0020-0000-0000-000003C73DFB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041321-0021-0000-0000-000022201479
Message-Id: <1586814958.7311.92.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_11:2020-04-13,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 impostorscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130157
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 2020-04-09 at 11:39 +0800, Tianjia Zhang wrote:
> Support the read and write operations of ima_appraise by adding a
> securifyfs file 'appraise_mode'.
> 
> In order to tune appraise mode in runtime, writing a PKCS#7 signature
> corresponding the signed content is required. The content should be off,
> enforce, log or fix. Given a simple way to archive this:
> 
> $ echo -n off > mode
> $ openssl smime -sign -nocerts -noattr -binary \
>     -in mode -inkey <system_trusted_key> \
>     -signer <cert> -outform der -out mode.p7s
> $ sudo cat mode.p7s \
>     > /sys/kernel/security/ima/appraise_mode
> 
> Note that the signing key must be a trust key located in
> system trusted keyring. So even the root privilege cannot
> simply disable the enforcement.

There are major problems with disabling IMA appraisal.  This patch set
proposes disabling IMA appraisal without even providing the motivation
for such support.

A lot of effort went into preventing custom IMA policies from
disabling appraising the kexec or kernel module signatures.  In
addition, the "lockdown" patch set was upstreamed permitting IMA
signature verification.  This patch set would break both of these
features.

IMA relies on its own keyring for verifying file signatures, not the
builtin or secondary trusted kernel keyrings.

Two methods already exist - xattr and appended signatures - for
verifying file signatures.  This patch set assumes creating and
signing a file, which is then written to a securityfs file.  Like for
loading a custom IMA policy, instead of cat'ing the file, write the
pathname to the securityfs file.

If you must define a new IMA method for verifying file signatures,
then it needs to be generic and added to ima_appraise_measurement().
 (Refer to the new IMA appended signature support.)

Mimi

> 
> Tianjia Zhang (2):
>   ima: support to read appraise mode
>   ima: support to tune appraise mode in runtime
> 
>  security/integrity/ima/ima_fs.c | 134 +++++++++++++++++++++++++++++++-
>  1 file changed, 133 insertions(+), 1 deletion(-)
> 

