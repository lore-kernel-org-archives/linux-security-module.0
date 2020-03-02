Return-Path: <SRS0=VYUt=4T=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13C1C3F2CD
	for <linux-security-module@archiver.kernel.org>; Mon,  2 Mar 2020 22:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D05721739
	for <linux-security-module@archiver.kernel.org>; Mon,  2 Mar 2020 22:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgCBWUS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 2 Mar 2020 17:20:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50556 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726720AbgCBWUR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 2 Mar 2020 17:20:17 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 022MJbRx110452
        for <linux-security-module@vger.kernel.org>; Mon, 2 Mar 2020 17:20:16 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yfk5mbqr4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Mon, 02 Mar 2020 17:20:16 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 2 Mar 2020 22:20:13 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Mar 2020 22:20:09 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 022MK8bh33358016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Mar 2020 22:20:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBBFE42052;
        Mon,  2 Mar 2020 22:20:08 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC25842041;
        Mon,  2 Mar 2020 22:20:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.229.179])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Mar 2020 22:20:07 +0000 (GMT)
Subject: Re: [PATCH v3 5/8] ima: Switch to dynamically allocated buffer for
 template digests
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        James.Bottomley@HansenPartnership.com,
        jarkko.sakkinen@linux.intel.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Mon, 02 Mar 2020 17:20:07 -0500
In-Reply-To: <20200210100244.21728-1-roberto.sassu@huawei.com>
References: <20200210100244.21728-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030222-0016-0000-0000-000002EC7078
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030222-0017-0000-0000-0000334FB4EF
Message-Id: <1583187607.8544.147.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_09:2020-03-02,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020145
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 2020-02-10 at 11:02 +0100, Roberto Sassu wrote:
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 2f380fb92a7a..f04bec2ab83f 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -45,11 +45,15 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8 };
>  #define IMA_TEMPLATE_IMA_NAME "ima"
>  #define IMA_TEMPLATE_IMA_FMT "d|n"
>  
> +#define NR_BANKS(chip) ((chip != NULL) ? chip->nr_allocated_banks : 0)
> +
>  /* current content of the policy */
>  extern int ima_policy_flag;
>  
>  /* set during initialization */
>  extern int ima_hash_algo;
> +extern int ima_sha1_idx __ro_after_init;
> +extern int ima_extra_slots __ro_after_init;
>  extern int ima_appraise;
>  extern struct tpm_chip *ima_tpm_chip;
>  
> @@ -92,7 +96,7 @@ struct ima_template_desc {
>  
>  struct ima_template_entry {
>  	int pcr;
> -	u8 digest[TPM_DIGEST_SIZE];	/* sha1 or md5 measurement hash */
> +	struct tpm_digest *digests;
>  	struct ima_template_desc *template_desc; /* template descriptor */
>  	u32 template_data_len;
>  	struct ima_field_data template_data[0];	/* template related data */
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index 51f562111864..ea6d834a5fab 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -27,6 +27,7 @@ void ima_free_template_entry(struct ima_template_entry *entry)
>  	for (i = 0; i < entry->template_desc->num_fields; i++)
>  		kfree(entry->template_data[i].data);
>  
> +	kfree(entry->digests);
>  	kfree(entry);
>  }
>  
> @@ -50,6 +51,13 @@ int ima_alloc_init_template(struct ima_event_data *event_data,
>  	if (!*entry)
>  		return -ENOMEM;
>  
> +	(*entry)->digests = kcalloc(NR_BANKS(ima_tpm_chip) + ima_extra_slots,
> +				    sizeof(*(*entry)->digests), GFP_NOFS);

"sizeof(*(*entry)" should be simplified for readability.  Defining a
local "entry" or "digests" variable might help.  Similarly in
ima_restore_template_data().

> +	if (!(*entry)->digests) {
> +		result = -ENOMEM;
> +		goto out;
> +	}
> +
>  	(*entry)->template_desc = template_desc;
>  	for (i = 0; i < template_desc->num_fields; i++) {
>  		const struct ima_template_field *field =
> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
> index 2d356ae8e823..ea24d2f6b513 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -59,6 +59,10 @@ MODULE_PARM_DESC(ahash_bufsize, "Maximum ahash buffer size");
>  static struct crypto_shash *ima_shash_tfm;
>  static struct crypto_ahash *ima_ahash_tfm;
>  
> +int ima_sha1_idx __ro_after_init;
> +/* Additional number of slots to be reserved for SHA1 and IMA default algo */
> +int ima_extra_slots __ro_after_init = 1;

The reasoning behind needing an extra slot is clear from the patch
description, but not the reason for defining a variable.  Let's
clarify this comment a bit by inserting "reserved, as needed, for
SHA1"

> +
>  int __init ima_init_crypto(void)
>  {
>  	long rc;
> @@ -502,7 +506,8 @@ static int ima_calc_field_array_hash_tfm(struct ima_field_data *field_data,
>  	}
>  
>  	if (!rc)
> -		rc = crypto_shash_final(shash, entry->digest);
> +		rc = crypto_shash_final(shash,
> +					entry->digests[ima_sha1_idx].digest);

There's no reason to split this line.  It's less than 80 characters.

Mimi

>  
>  	return rc;
>  }

