Return-Path: <SRS0=nZhg=OU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17042C6783B
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Dec 2018 21:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB32E20849
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Dec 2018 21:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB32E20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbeLKVAk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:00:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726136AbeLKVAk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Dec 2018 16:00:40 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBBKsdvb096048
        for <linux-security-module@vger.kernel.org>; Tue, 11 Dec 2018 16:00:38 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2paj95phxe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Tue, 11 Dec 2018 16:00:37 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <kgold@linux.ibm.com>;
        Tue, 11 Dec 2018 21:00:35 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Dec 2018 21:00:32 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBBL0VS920119726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Dec 2018 21:00:32 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7FEBAE066;
        Tue, 11 Dec 2018 21:00:31 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6031AE06A;
        Tue, 11 Dec 2018 21:00:31 +0000 (GMT)
Received: from [9.74.8.180] (unknown [9.74.8.180])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 11 Dec 2018 21:00:31 +0000 (GMT)
Subject: Re: [PATCH v6 1/7] tpm: dynamically allocate the allocated_banks
 array
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20181204082138.24600-1-roberto.sassu@huawei.com>
 <20181204082138.24600-2-roberto.sassu@huawei.com>
 <20181204231848.GA1233@linux.intel.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Date:   Tue, 11 Dec 2018 16:01:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181204231848.GA1233@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18121121-0064-0000-0000-00000384B37E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010214; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01130368; UDB=6.00587365; IPR=6.00910501;
 MB=3.00024658; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-11 21:00:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121121-0065-0000-0000-00003BA4BD7F
Message-Id: <b0990515-a1eb-dcb0-70ad-37a876be329c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=770 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812110184
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 12/4/2018 6:18 PM, Jarkko Sakkinen wrote:
> 
>> +		for (j = 0; j < pcr_selection.size_of_select; j++)
>> +			if (pcr_selection.pcr_select[j])
>> +				break;
>> +
>> +		if (j < pcr_selection.size_of_select) {
>> +			chip->allocated_banks[nr_alloc_banks] = hash_alg;
>> +			nr_alloc_banks++;
>> +		}
>> +
> 
> Why was this needed? Can CAP_PCRS return completely unallocated banks?
> 

Yes.  E.g., here's a TPM with 4 hash algorithms and two banks with 
allocated PCRs.

 > getcapability -cap 5
4 PCR selections
     hash TPM_ALG_SHA1
     TPMS_PCR_SELECTION length 3
     ff ff ff
     hash TPM_ALG_SHA256
     TPMS_PCR_SELECTION length 3
     ff ff ff
     hash TPM_ALG_SHA384
     TPMS_PCR_SELECTION length 3
     00 00 00
     hash TPM_ALG_SHA512
     TPMS_PCR_SELECTION length 3
     00 00 00

