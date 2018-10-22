Return-Path: <SRS0=zjoR=NC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497CBC004D3
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Oct 2018 15:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F96205F4
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Oct 2018 15:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F96205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbeJWAJh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Oct 2018 20:09:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727590AbeJWAJg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Oct 2018 20:09:36 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9MFnv4N043837
        for <linux-security-module@vger.kernel.org>; Mon, 22 Oct 2018 11:50:31 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n9fyymsga-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Mon, 22 Oct 2018 11:50:31 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <kgold@linux.ibm.com>;
        Mon, 22 Oct 2018 09:50:30 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 22 Oct 2018 09:50:28 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9MFoS9j47054850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Oct 2018 08:50:28 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0107DC605A;
        Mon, 22 Oct 2018 15:50:28 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3D47C6057;
        Mon, 22 Oct 2018 15:50:27 +0000 (GMT)
Received: from [9.2.202.77] (unknown [9.2.202.77])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 22 Oct 2018 15:50:27 +0000 (GMT)
Subject: Re: [PATCH v4 0/7] add integrity and security to TPM2 transactions
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <1540193596.3202.7.camel@HansenPartnership.com>
 <a8a69222-94fb-7406-d9b2-207079727eb8@linux.ibm.com>
 <1540217887.3012.14.camel@HansenPartnership.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Date:   Mon, 22 Oct 2018 11:50:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1540217887.3012.14.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18102215-8235-0000-0000-00000E19E82D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009916; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01106392; UDB=6.00572947; IPR=6.00886476;
 MB=3.00023859; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-22 15:50:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102215-8236-0000-0000-000043173A76
Message-Id: <e773aafe-4b12-775c-9df9-0e747880a35f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-22_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=640 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810220136
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/22/2018 10:18 AM, James Bottomley wrote:
>> 1 - Any policy that requires a password (policypassword) can
>> substitute
>> an HMAC (policyauthvalue) at the callers discretion.  They result
>> in the same policy digest.
> Right but this requires the co-operation of the policy handle creator,
> so it's an API change.
> 

In case it wasn't clear:  The choice is not made at the time the
policy is calculated, nor is it made at startauthsession (when
the policy is created).

The choice is made when the policy is being satisfied.

policypassword tells the TPM to expect a plaintext password, while
policyauthvalue tells the TPM to expect an HMAC.

It's subtle that either policy command results in the same policy
digest.

