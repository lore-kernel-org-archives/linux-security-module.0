Return-Path: <SRS0=Ewgb=UF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4B6C28EB8
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Jun 2019 22:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E05820673
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Jun 2019 22:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfFFWbz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Jun 2019 18:31:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48316 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726711AbfFFWby (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Jun 2019 18:31:54 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56MVoHm090332
        for <linux-security-module@vger.kernel.org>; Thu, 6 Jun 2019 18:31:53 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sy8xbf1f7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Thu, 06 Jun 2019 18:31:50 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 6 Jun 2019 23:28:09 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Jun 2019 23:28:07 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x56MS65m52822164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jun 2019 22:28:06 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EBE1A4053;
        Thu,  6 Jun 2019 22:28:06 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 724D1A404D;
        Thu,  6 Jun 2019 22:28:05 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Jun 2019 22:28:05 +0000 (GMT)
Subject: Re: [PATCH 2/2] ima: use the lsm policy update notifier
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Janne Karhunen <janne.karhunen@gmail.com>, sds@tycho.nsa.gov,
        paul@paul-moore.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Thu, 06 Jun 2019 18:28:04 -0400
In-Reply-To: <1559858345.4278.163.camel@linux.ibm.com>
References: <20190605083606.4209-1-janne.karhunen@gmail.com>
         <20190605083606.4209-2-janne.karhunen@gmail.com>
         <1559858345.4278.163.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19060622-0012-0000-0000-00000325FF5C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060622-0013-0000-0000-0000215EE8AB
Message-Id: <1559860084.4278.173.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906060152
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Janne,

One more comment below ...

> > +
> > +static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
> > +{
> > +	struct ima_rule_entry *nentry;
> > +	int i, result;
> > +
> > +	nentry = kmalloc(sizeof(*nentry), GFP_KERNEL);
> > +	if (!nentry)
> > +		return NULL;
> > +
> > +	memcpy(nentry, entry, sizeof(*nentry));
> > +	nentry->fsname = NULL;
> > +	for (i = 0; i < MAX_LSM_RULES; i++) {
> > +		nentry->lsm[i].rule = NULL;
> > +		nentry->lsm[i].args_p = NULL;
> > +	}

I don't think this loop is necessary.  Either use kzalloc() or move
the initialization to inside the loop below.

> > +
> > +	if (entry->fsname) {
> > +		nentry->fsname = kstrdup(entry->fsname, GFP_KERNEL);
> > +		if (!nentry->fsname)
> > +			goto out_err;
> > +	}
> > +	for (i = 0; i < MAX_LSM_RULES; i++) {
> > +		if (!entry->lsm[i].rule)
> > +			continue;

To here.

> > +
> > +		nentry->lsm[i].type = entry->lsm[i].type;
> > +		nentry->lsm[i].args_p = kstrdup(entry->lsm[i].args_p,
> > +						GFP_KERNEL);
> > +		if (!nentry->lsm[i].args_p)
> > +			goto out_err;

If the memory allocation fails, then nentry will be freed anyway.

thanks,

Mimid

