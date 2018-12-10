Return-Path: <SRS0=+97+=OT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28167C04EB8
	for <linux-security-module@archiver.kernel.org>; Mon, 10 Dec 2018 16:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99EC20821
	for <linux-security-module@archiver.kernel.org>; Mon, 10 Dec 2018 16:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99EC20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbeLJQch (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:32:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726324AbeLJQch (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 10 Dec 2018 11:32:37 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBAGTZ0U017884
        for <linux-security-module@vger.kernel.org>; Mon, 10 Dec 2018 11:32:35 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p9sedg2q4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Mon, 10 Dec 2018 11:32:35 -0500
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <kgold@linux.ibm.com>;
        Mon, 10 Dec 2018 16:32:33 -0000
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 10 Dec 2018 16:32:30 -0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBAGWUJW29294684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Dec 2018 16:32:30 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E742AC605F;
        Mon, 10 Dec 2018 16:32:29 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 953C0C605D;
        Mon, 10 Dec 2018 16:32:29 +0000 (GMT)
Received: from [9.2.202.70] (unknown [9.2.202.70])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 10 Dec 2018 16:32:29 +0000 (GMT)
Subject: Re: Documenting the proposal for TPM 2.0 security in the face of bus
 interposer attacks
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <1542648844.2910.9.camel@HansenPartnership.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Date:   Mon, 10 Dec 2018 11:33:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <1542648844.2910.9.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18121016-8235-0000-0000-00000E368167
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010208; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01129798; UDB=6.00587025; IPR=6.00909932;
 MB=3.00024642; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-10 16:32:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121016-8236-0000-0000-000043A7A772
Message-Id: <16c8baf7-e2a9-6e12-b736-a0e2384282ed@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-10_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=945 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812100148
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/19/2018 12:34 PM, James Bottomley wrote:

> 2. At some point in time the attacker could reset the TPM, clearing
>     the PCRs and then send down their own measurements which would
>     effectively overwrite the boot time measurements the TPM has
>     already done.
> [snip]
> However, the second can only really be detected by relying
> on some sort of mechanism for protection which would change over TPM
> reset.

FYI: TPM 2.0 has a resetCount that can be used to detect, but not 
protect against, this attack.

> Every TPM comes shipped with a couple of X.509 certificates for the
> primary endorsement key.  This document assumes that the Elliptic
> Curve version of the certificate exists at 01C00002, but will work
> equally well with the RSA certificate (at 01C00001).

A nit.  The RSA cert is at 01c00002.  The ECC cert is at 01c0000a.

