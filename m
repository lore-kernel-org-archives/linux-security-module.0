Return-Path: <SRS0=rvaM=NT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A798FECDE47
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Nov 2018 15:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799472077B
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Nov 2018 15:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799472077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeKIBbA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:31:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726700AbeKIBbA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 8 Nov 2018 20:31:00 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA8Fs8px040195
        for <linux-security-module@vger.kernel.org>; Thu, 8 Nov 2018 10:54:52 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nmnum7d5n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Thu, 08 Nov 2018 10:54:51 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <kgold@linux.ibm.com>;
        Thu, 8 Nov 2018 15:54:45 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Nov 2018 15:54:43 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA8Fsgpj37355726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 15:54:42 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42CFCAC05F;
        Thu,  8 Nov 2018 15:54:42 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F189AC059;
        Thu,  8 Nov 2018 15:54:42 +0000 (GMT)
Received: from [9.74.9.249] (unknown [9.74.9.249])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Nov 2018 15:54:42 +0000 (GMT)
Subject: Re: [PATCH v4 1/6] tpm: dynamically allocate active_banks array
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20181106150159.1136-1-roberto.sassu@huawei.com>
 <20181106150159.1136-2-roberto.sassu@huawei.com>
 <98482eee-6e91-1666-1ce2-cfa94a33efc2@linux.ibm.com>
 <da2ef557-3041-a1ca-47cb-fd7ab92876aa@huawei.com>
 <086944ab-dd56-5522-af26-e9bb545556fd@linux.ibm.com>
 <20181108152124.GE14072@linux.intel.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Date:   Thu, 8 Nov 2018 10:54:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181108152124.GE14072@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18110815-0040-0000-0000-0000048F25A6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010008; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000269; SDB=6.01114506; UDB=6.00577119; IPR=6.00894604;
 MB=3.00024076; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-08 15:54:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110815-0041-0000-0000-000008982BE8
Message-Id: <74cc831a-f4b6-6c59-58d8-f3f74c283346@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=642 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080134
To:     unlisted-recipients:; (no To-header on input)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/8/2018 10:21 AM, Jarkko Sakkinen wrote:

> I would just allocate array of the size of possible banks and grow
> nr_active_banks for active algorithms to keep the code simple because
> we are talking about insignificant amount of wasted space (might be
> even zero bytes given how kernel allocators works)>

Just beware that "possible banks" is tricky.  While 2 is typical, 
getcapability will return a bitmap for each digest algorithm.  This is
also currently 2, but will be 3 in the next TPM, is 4 in the SW TPM,
and is potentially even higher.

Also, account for a TPM that is malicious and can return a count
as high as 0xffffffff.  Range check count.



