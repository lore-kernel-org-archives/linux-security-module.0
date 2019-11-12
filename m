Return-Path: <SRS0=Bogo=ZE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DD4C43331
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Nov 2019 18:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA1F2067B
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Nov 2019 18:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfKLSHo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:07:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726718AbfKLSHn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Nov 2019 13:07:43 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACHx6km139264
        for <linux-security-module@vger.kernel.org>; Tue, 12 Nov 2019 13:07:40 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w7yaceauq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Tue, 12 Nov 2019 13:07:17 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 12 Nov 2019 18:06:09 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Nov 2019 18:06:05 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xACI65me49610782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 18:06:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0597AE04D;
        Tue, 12 Nov 2019 18:06:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C984AAE045;
        Tue, 12 Nov 2019 18:06:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.194.252])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Nov 2019 18:06:03 +0000 (GMT)
Subject: Re: [PATCH v5 04/10] IMA: Updated IMA policy functions to return
 keyrings option read from the policy
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 12 Nov 2019 13:06:03 -0500
In-Reply-To: <407b93e1-f474-7b01-816f-62b45690f417@linux.microsoft.com>
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
         <20191111193303.12781-5-nramas@linux.microsoft.com>
         <1573578316.17949.43.camel@linux.ibm.com>
         <407b93e1-f474-7b01-816f-62b45690f417@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111218-0016-0000-0000-000002C31290
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111218-0017-0000-0000-00003324A9F2
Message-Id: <1573581963.17949.63.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-12_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120154
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 2019-11-12 at 09:47 -0800, Lakshmi Ramasubramanian wrote:
> On 11/12/2019 9:05 AM, Mimi Zohar wrote:
> 
> >>   int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
> >>   		     enum ima_hooks func, int mask, int flags, int *pcr,
> >> -		     struct ima_template_desc **template_desc)
> >> +		     struct ima_template_desc **template_desc,
> >> +		     char **keyrings)
> >>   {
> >>   	struct ima_rule_entry *entry;
> >>   	int action = 0, actmask = flags | (flags << 1);
> >> @@ -527,6 +529,9 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
> >>   		if ((pcr) && (entry->flags & IMA_PCR))
> >>   			*pcr = entry->pcr;
> >>   
> >> +		if ((keyrings) && (entry->flags & IMA_KEYRINGS))
> >> +			*keyrings = entry->keyrings;
> > 
> > ima_match_rules() determines whether the rule is in policy or not. It
> > returns true on rule match, false on failure.  There's no need to
> > return the list of keyrings.
> 
> But the above code change is in ima_match_policy() - not in 
> ima_match_rules() function.
> 
> ima_match_rules() function is updated in Patch #1 -
> [PATCH v5 01/10] IMA: Added KEYRING_CHECK func in IMA policy to measure keys
> 
> I've updated that function to check if func is "KEYRING_CHECK" and 
> return true\false as appropriate.
> 
> Am I missing something?

The first patch adds basic support for the new "func".  This allows
measuring all keys.  ima_match_rules() then needs to be updated in the
patch that adds the "keyrings=" or "keyring=" support to limit it to a
specific keyring.

Mimi

