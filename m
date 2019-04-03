Return-Path: <SRS0=p2Kc=SF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB75FC4360F
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Apr 2019 16:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A402120700
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Apr 2019 16:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfDCQWJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:22:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58972 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726097AbfDCQWJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Apr 2019 12:22:09 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33GM6e6113104
        for <linux-security-module@vger.kernel.org>; Wed, 3 Apr 2019 12:22:08 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rmxk0dvud-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Wed, 03 Apr 2019 12:22:06 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 3 Apr 2019 17:22:01 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Apr 2019 17:21:58 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x33GLviL55509192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Apr 2019 16:21:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95A64A4053;
        Wed,  3 Apr 2019 16:21:57 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BF5CA4040;
        Wed,  3 Apr 2019 16:21:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.94.218])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Apr 2019 16:21:55 +0000 (GMT)
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Date:   Wed, 03 Apr 2019 12:21:45 -0400
In-Reply-To: <d40b94ed-b9c8-d877-b109-d45c5472ae15@tycho.nsa.gov>
References: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
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
         <1553857187.9420.49.camel@linux.ibm.com>
         <b5a89692-4c93-80b3-37e5-41265765cdc3@tycho.nsa.gov>
         <cb46d5ba-30de-664f-67d4-646da4592a6f@omprussia.ru>
         <1554292678.7309.47.camel@linux.ibm.com>
         <648f1a64-e95d-d929-62dc-06decaf5a14b@tycho.nsa.gov>
         <1554301990.7309.71.camel@linux.ibm.com>
         <d40b94ed-b9c8-d877-b109-d45c5472ae15@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19040316-0020-0000-0000-0000032BE343
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040316-0021-0000-0000-0000217DEF3F
Message-Id: <1554308505.3839.13.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904030111
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2019-04-03 at 10:33 -0400, Stephen Smalley wrote:
> On 4/3/19 10:33 AM, Mimi Zohar wrote:
> > On Wed, 2019-04-03 at 09:10 -0400, Stephen Smalley wrote:
> >> On 4/3/19 7:57 AM, Mimi Zohar wrote:
> > 
> >>> Let's separate the different types of attacks.  From an IMA
> >>> perspective, memory attacks are out of scope.  That leaves mmap'ed
> >>> files, possibly just mmap'ed shared files.  Currently IMA can be
> >>> configured to verify a file's integrity, based on signatures, being
> >>> mmap'ed execute.  Assuming that not all files opened require a file
> >>> signature, a file could be mmap'ed read/write and later changed to
> >>> execute to circumvent the mmap'ed execute signature requirement.  If
> >>> the existing LSMs are able to prevent this sort of attack, we could
> >>> just document this requirement.
> >>
> >> I guess I don't understand why IMA isn't already being called from
> >> security_file_mprotect(). security_file_mprotect() could just call
> >> ima_file_mmap(vma->vm_file, prot) if all of the security hooks pass.
> >>
> >> SELinux can be used to prevent unauthorized mprotect PROT_EXEC but it
> >> won't perform a measurement of the file if it is allowed by policy.
> > 
> >  From a measurement perspective, this will at least measure the file,
> > but the call to ima_file_mmap() will verify the file signature against
> > the file, not what is currently in memory, right?
> 
> Yes, but you can use SELinux to prevent that (don't allow execmem or 
> execmod permissions for that domain).

Ok, let's start with at least adding the ima_file_mmap() call as you
suggested.  For LSMs which don't have this capability, they might need
to be stacked with a minor LSM such as S.A.R.A, once it is upstreamed,
or similar.

Mimi

