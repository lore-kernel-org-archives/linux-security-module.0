Return-Path: <SRS0=lFQA=SA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4ACC43381
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Mar 2019 11:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CE4217F5
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Mar 2019 11:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfC2LBW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:01:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43794 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727675AbfC2LBW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 29 Mar 2019 07:01:22 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2TAwWvp075028
        for <linux-security-module@vger.kernel.org>; Fri, 29 Mar 2019 07:01:20 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rhg9veme2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Fri, 29 Mar 2019 07:00:07 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 29 Mar 2019 11:00:03 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 29 Mar 2019 11:00:00 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2TAxxR152625658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 10:59:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97E8A11C052;
        Fri, 29 Mar 2019 10:59:59 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 490F111C054;
        Fri, 29 Mar 2019 10:59:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.109.148])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Mar 2019 10:59:58 +0000 (GMT)
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Date:   Fri, 29 Mar 2019 06:59:47 -0400
In-Reply-To: <92718382-8669-748f-10d8-02fa21225210@omprussia.ru>
References: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
         <1552945715.8658.299.camel@linux.ibm.com>
         <452752df-98f9-c361-878a-5df84ab36847@omprussia.ru>
         <1552994559.4899.26.camel@linux.ibm.com>
         <84145490-6f70-214f-8241-42d556590240@omprussia.ru>
         <1553015134.4899.82.camel@linux.ibm.com>
         <a9830bde-8157-6078-b544-fcffb20d2501@omprussia.ru>
         <CACdnJut6YfLnq-nCC1hHTrKYXabHoSEXN1wMuCyVybU+o_iwCg@mail.gmail.com>
         <1553167318.4899.382.camel@linux.ibm.com>
         <dab923ca-ef53-4af2-034a-bea4151a4e25@omprussia.ru>
         <CACdnJuvVqibDdd+MLKOHqEfdngTk=GSkfybj1jS3MpmC7rjyHg@mail.gmail.com>
         <07347317-ee71-83c1-384a-0c3439980af7@omprussia.ru>
         <1553793463.8711.26.camel@linux.ibm.com>
         <92718382-8669-748f-10d8-02fa21225210@omprussia.ru>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032911-4275-0000-0000-00000321430A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032911-4276-0000-0000-00003830455D
Message-Id: <1553857187.9420.49.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=754 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903290080
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

[Cc'ing the LSM mailing list and others]

On Fri, 2019-03-29 at 13:00 +0300, Igor Zhbanov wrote:
> Hi Mimi,On 28.03.2019 20:17, Mimi Zohar wrote:

> > I just came across the grsecurity article on mprotect.[1]
> >  Has anyone looked at it? Would it make sense to make it a minor LSM?
> > 
> > [1]https://pax.grsecurity.net/docs/mprotect.txt
> 
> Interesting article. It is almost exactly of what I wanted to be implemented.
> 
> If this minor LSM would be stackable to allow combining with e.g. SELinux
> then why not.

Stacking shouldn't be a problem.  Other LSMs are already on the
mprotect hook.  Let's hear what others think.

Mimi

