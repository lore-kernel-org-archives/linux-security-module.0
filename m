Return-Path: <SRS0=zjoR=NC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB27C7112C
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Oct 2018 13:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2229520651
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Oct 2018 13:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2229520651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeJVWMR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Oct 2018 18:12:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727218AbeJVWMR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Oct 2018 18:12:17 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9MDk90f110532
        for <linux-security-module@vger.kernel.org>; Mon, 22 Oct 2018 09:53:35 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n9ckx0xa6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Mon, 22 Oct 2018 09:53:35 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <kgold@linux.ibm.com>;
        Mon, 22 Oct 2018 07:53:34 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 22 Oct 2018 07:53:32 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9MDrV2B23593032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Oct 2018 06:53:31 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62F65C6055;
        Mon, 22 Oct 2018 13:53:31 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E37B6C605D;
        Mon, 22 Oct 2018 13:53:30 +0000 (GMT)
Received: from [9.2.202.77] (unknown [9.2.202.77])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 22 Oct 2018 13:53:30 +0000 (GMT)
Subject: Re: [PATCH v4 0/7] add integrity and security to TPM2 transactions
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <1540193596.3202.7.camel@HansenPartnership.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Date:   Mon, 22 Oct 2018 09:53:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1540193596.3202.7.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18102213-0016-0000-0000-00000947288E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009916; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01106353; UDB=6.00572923; IPR=6.00886437;
 MB=3.00023857; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-22 13:53:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102213-0017-0000-0000-000040CCC0F9
Message-Id: <a8a69222-94fb-7406-d9b2-207079727eb8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-22_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810220120
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/22/2018 3:33 AM, James Bottomley wrote:
> By now, everybody knows we have a problem with the TPM2_RS_PW easy
> button on TPM2 in that transactions on the TPM bus can be intercepted
> and altered.  The way to fix this is to use real sessions for HMAC
> capabilities to ensure integrity and to use parameter and response
> encryption to ensure confidentiality of the data flowing over the TPM
> bus.

Does this design assume that there was at time zero no monitoring?
This would permit some shared secret to be established.

Or does it assume that the interception may have been present from
the first boot?  If so, how is the first shared secret established.
Salting using the EK is the usual method, but this requires walking the 
EK certificate chain and embedding the TPM vendor CA certificates in the 
kernel.


> This patch series is about adding a simple API which can ensure the
> above properties as a layered addition to the existing TPM handling
> code.  This series now includes protections for PCR extend, getting
> random numbers from the TPM and data sealing and unsealing.  It
> therefore eliminates all uses of TPM2_RS_PW in the kernel and adds
> encryption protection to sensitive data flowing into and out of the
> TPM.
> 
> In the third version I added data sealing and unsealing protection,
> apart from one API based problem which means that the way trusted keys
> were protected it's not currently possible to HMAC protect an authority
> that comes with a policy, so the API will have to be extended to fix
> that case

TPM 2.0 observations (questioning 'not possible'):

1 - Any policy that requires a password (policypassword) can substitute
an HMAC (policyauthvalue) at the callers discretion.  They result
in the same policy digest.

2 - Any command can be HMAC protected, even one like pcrread that does 
not require authorization.  Start an HMAC session and specify audit.
Of course, a shared secret has to be used, either a bind or salted
session.

3 - If the command is already using a policy session, but does not 
require a password, I believe that the same technique #2 can be
used - specify audit with that policy session.

I've tested #3 with bind but not salt.  I can test if there's
interest.

> In this fourth version, I tidy up some of the code and add more
> security features, the most notable is that we now calculate the NULL
> seed name and compare our calculation to the value returned in
> TPM2_ReadPublic, which means we now can't be spoofed.  This version
> also gives a sysfs variable for the null seed which userspace can use
> to run a key certification operation to prove that the TPM was always
> secure when communicating with the kernel.
> 
> I've verified this using the test suite in the last patch on a VM
> connected to a tpm2 emulator.  I also instrumented the emulator to make
> sure the sensitive data was properly encrypted.

