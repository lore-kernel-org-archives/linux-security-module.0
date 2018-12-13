Return-Path: <SRS0=Wiv6=OW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02E9C67839
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Dec 2018 20:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C4820672
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Dec 2018 20:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C4820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeLMUUk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:20:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727343AbeLMUUj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 13 Dec 2018 15:20:39 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBDKJ6oi064150
        for <linux-security-module@vger.kernel.org>; Thu, 13 Dec 2018 15:20:39 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pbug28dqu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Thu, 13 Dec 2018 15:20:38 -0500
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <kgold@linux.ibm.com>;
        Thu, 13 Dec 2018 20:20:38 -0000
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Dec 2018 20:20:35 -0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBDKKYQU27197522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Dec 2018 20:20:34 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 428C2C6057;
        Thu, 13 Dec 2018 20:20:34 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0B75C6055;
        Thu, 13 Dec 2018 20:20:23 +0000 (GMT)
Received: from [9.2.202.49] (unknown [9.2.202.49])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 13 Dec 2018 20:20:23 +0000 (GMT)
Subject: Re: [PATCH v4 1/6] tpm: dynamically allocate active_banks array
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20181106150159.1136-1-roberto.sassu@huawei.com>
 <20181106150159.1136-2-roberto.sassu@huawei.com>
 <98482eee-6e91-1666-1ce2-cfa94a33efc2@linux.ibm.com>
 <da2ef557-3041-a1ca-47cb-fd7ab92876aa@huawei.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Date:   Thu, 13 Dec 2018 15:21:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <da2ef557-3041-a1ca-47cb-fd7ab92876aa@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18121320-0036-0000-0000-00000A6A3314
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010220; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000271; SDB=6.01131314; UDB=6.00587932; IPR=6.00911446;
 MB=3.00024682; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-13 20:20:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121320-0037-0000-0000-000049F82CEB
Message-Id: <47a8bee4-404a-9fff-f85c-0c323eaa6ad5@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-13_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812130174
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/7/2018 4:41 AM, Roberto Sassu wrote:
> On 11/7/2018 7:14 AM, Nayna Jain wrote:
> 
> In the TPM Commands specification (section 30.2.1), I found:
> 
> TPM_CAP_PCRS – Returns the current allocation of PCR in a
> TPML_PCR_SELECTION.
> 
> You mentioned:
> 
> #TPM_RC_SIZE response code when count is greater
> than the possible number of banks
> 
> but TPML_PCR_SELECTION is provided by the TPM.
> 
> Roberto
> 
> 
[snip]
>>
>>
>> As per my understanding, the count in the TPML_PCR_SELECTION represent 
>> the number of possible banks and not the number of active banks.
>> TCG Structures Spec for TPM 2.0 - Table 102 mentions this as 
>> explanation of #TPM_RC_SIZE.

FYI: This was clarified in the TCG's TPM work group today.  TPM_CAP_PCRS 
returns:

The TPML_PCR_SELECTION must include a TPMS_PCR_SELECTION for each PCR 
bank in which there is at least one allocated PCR. The 
TPML_PCR_SELECTION may return a TPMS_PCR_SELECTION for each implemented 
PCR bank.  The TPML_PCR_SELECTION may return a TPMS_PCR_SELECTION for 
each implemented hash algorithm.

Also:

The TPM doesn't use the term "active banks"

Allocated = a bank that has at least one PCR bit set in the selection 
bitmap.

Supported or implemented banks = the number of PCR banks that can be 
allocated, based on the TPM hardware.

Hash algorithms = The hash algorithms supported by the TPM

For example, the TPM may support 3 hash algorithms and 2 PCR banks, and 
have 1 bank allocated.




