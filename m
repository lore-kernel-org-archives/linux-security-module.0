Return-Path: <SRS0=p2Kc=SF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8718C10F0B
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Apr 2019 11:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BAA20830
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Apr 2019 11:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfDCL6U (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:58:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35058 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725956AbfDCL6U (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Apr 2019 07:58:20 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33BtpXd094159
        for <linux-security-module@vger.kernel.org>; Wed, 3 Apr 2019 07:58:18 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rmvbj07cy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Wed, 03 Apr 2019 07:58:18 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 3 Apr 2019 12:58:15 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Apr 2019 12:58:11 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x33BwAjl44892286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Apr 2019 11:58:10 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 582F4A4060;
        Wed,  3 Apr 2019 11:58:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2300DA4054;
        Wed,  3 Apr 2019 11:58:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.94.125])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Apr 2019 11:58:09 +0000 (GMT)
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Date:   Wed, 03 Apr 2019 07:57:58 -0400
In-Reply-To: <cb46d5ba-30de-664f-67d4-646da4592a6f@omprussia.ru>
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
         <1553857187.9420.49.camel@linux.ibm.com>
         <b5a89692-4c93-80b3-37e5-41265765cdc3@tycho.nsa.gov>
         <cb46d5ba-30de-664f-67d4-646da4592a6f@omprussia.ru>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19040311-0016-0000-0000-0000026AC9F6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040311-0017-0000-0000-000032C6D58F
Message-Id: <1554292678.7309.47.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904030083
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 2019-03-29 at 15:50 +0300, Igor Zhbanov wrote:
> On 29.03.2019 15:28, Stephen Smalley wrote:
> > On 3/29/19 6:59 AM, Mimi Zohar wrote:
> >> [Cc'ing the LSM mailing list and others]
> >>
> >> On Fri, 2019-03-29 at 13:00 +0300, Igor Zhbanov wrote:
> >>> Hi Mimi,On 28.03.2019 20:17, Mimi Zohar wrote:
> >>
> >>>> I just came across the grsecurity article on mprotect.[1]
> >>>>   Has anyone looked at it? Would it make sense to make it a minor LSM?
> >>>>
> >>>> [1]https://pax.grsecurity.net/docs/mprotect.txt
> >>>
> >>> Interesting article. It is almost exactly of what I wanted to be
> >>> implemented.
> >>>
> >>> If this minor LSM would be stackable to allow combining with e.g. SELinux
> >>> then why not.
> >>
> >> Stacking shouldn't be a problem.  Other LSMs are already on the
> >> mprotect hook.  Let's hear what others think.
> > 
> > SELinux already provides a set of controls over executable mappings;
> > see selinux_mmap_file and selinux_file_mprotect. Other major security
> > modules may do likewise but I can't speak to that. Is there some gap
> > you are trying to address that isn't already covered, or are you just
> > trying to provide such restrictions without requiring one of the
> > major modules?
> 
> I want to be sure that no unsigned code page could be executed. So exploits
> could only be of ROP kind and not being able to download any extra code
> from their servers. That's why I found that disabling of anonymous executable
> pages could be useful for that (as well as disabling of making executable
> pages writable to modify already mapped code). In conjunction with IMA it
> should guarantee that no untrusted code could be executed.

Let's separate the different types of attacks.  From an IMA
perspective, memory attacks are out of scope.  That leaves mmap'ed
files, possibly just mmap'ed shared files.  Currently IMA can be
configured to verify a file's integrity, based on signatures, being
mmap'ed execute.  Assuming that not all files opened require a file
signature, a file could be mmap'ed read/write and later changed to
execute to circumvent the mmap'ed execute signature requirement.  If
the existing LSMs are able to prevent this sort of attack, we could
just document this requirement.

Mimi

