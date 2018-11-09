Return-Path: <SRS0=fuo0=NU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7372C0044C
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Nov 2018 14:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7BB20825
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Nov 2018 14:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7BB20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbeKIXzk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:55:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58304 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727735AbeKIXzj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Nov 2018 18:55:39 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA9EAEpf180452
        for <linux-security-module@vger.kernel.org>; Fri, 9 Nov 2018 09:14:52 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nnb3pa0kn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Fri, 09 Nov 2018 09:14:51 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 9 Nov 2018 14:14:50 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 9 Nov 2018 14:14:48 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA9EElUA53412054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Nov 2018 14:14:47 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F036211C052;
        Fri,  9 Nov 2018 14:14:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 539F111C05B;
        Fri,  9 Nov 2018 14:14:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.106.24])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Nov 2018 14:14:46 +0000 (GMT)
Subject: Re: [PATCH] KEYS: revert requiring signature "encoding"
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     David Howells <dhowells@redhat.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Fri, 09 Nov 2018 09:14:35 -0500
In-Reply-To: <27927.1541769383@warthog.procyon.org.uk>
References: <1541743166-5036-1-git-send-email-zohar@linux.ibm.com>
         <27927.1541769383@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18110914-0008-0000-0000-000002903613
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110914-0009-0000-0000-000021FA37E2
Message-Id: <1541772875.3990.29.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-09_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811090131
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 2018-11-09 at 13:16 +0000, David Howells wrote:
> Mimi Zohar <zohar@linux.ibm.com> wrote:
> 
> > Attempting to verify IMA signatures fail causing the system to hang.
> 
> Can you say why?

On systems with IMA-appraisal enabled with a policy requiring file 
signatures, the "good" signature values are stored on the filesystem
as extended attributes (security.ima).  Signature verification failure
would normally be limited to just a particular file (eg. executable),
but during boot signature verification failure could result in a
system hang.

Removing existing signature formats breaks existing systems.  This
patch adds support for RSA signatures without an explicit "pkcs1" sig-
>encoding.

> 
> > Fixes: commit 82f94f24475c ("KEYS: Provide software public key query
> >        function [ver #2]")
> 
> Btw, no word "commit" after Fixes:.

Ok.

Looking the patch over again, do you prefer the duplicate call or
defining a local variable and using the ternary conditional operator
("?:") like this:

	bool rsa = false;

	if (!(sig->encoding) && strcmp(pkey->pkey_algo, "rsa") == 0)
                rsa = true;

        ret = software_key_determine_akcipher(rsa ? "pkcs1" : sig->encoding,
                                              sig->hash_algo,
                                              pkey, alg_name);

Mimi


