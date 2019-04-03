Return-Path: <SRS0=p2Kc=SF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576F4C4360F
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Apr 2019 12:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB1620830
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Apr 2019 12:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfDCMLj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:11:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59510 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725956AbfDCMLj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Apr 2019 08:11:39 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33C5obh100937
        for <linux-security-module@vger.kernel.org>; Wed, 3 Apr 2019 08:11:37 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rmvbh8wcu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Wed, 03 Apr 2019 08:11:37 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 3 Apr 2019 13:11:35 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Apr 2019 13:11:32 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x33CBVHX48890098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Apr 2019 12:11:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 028F7A4057;
        Wed,  3 Apr 2019 12:11:31 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBC50A4051;
        Wed,  3 Apr 2019 12:11:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.94.125])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Apr 2019 12:11:28 +0000 (GMT)
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <mjg59@google.com>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Date:   Wed, 03 Apr 2019 08:11:18 -0400
In-Reply-To: <CACdnJusPpis1JJgfNOrQoqPcVk0q2OGbosrXOVtZmG0cSqkotw@mail.gmail.com>
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
         <CACdnJusPpis1JJgfNOrQoqPcVk0q2OGbosrXOVtZmG0cSqkotw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19040312-4275-0000-0000-00000323CB7F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040312-4276-0000-0000-00003832D25F
Message-Id: <1554293478.7309.54.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904030084
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 2019-04-02 at 15:31 -0700, Matthew Garrett wrote:
> On Fri, Mar 29, 2019 at 5:50 AM Igor Zhbanov <i.zhbanov@omprussia.ru> wrote:
> > I want to be sure that no unsigned code page could be executed. So exploits
> > could only be of ROP kind and not being able to download any extra code
> > from their servers. That's why I found that disabling of anonymous executable
> > pages could be useful for that (as well as disabling of making executable
> > pages writable to modify already mapped code). In conjunction with IMA it
> > should guarantee that no untrusted code could be executed.
> 
> Remember that many interpreted languages allow execution of code
> provided to them on the command line (eg, python -c) and also grant
> access to arbitrary syscalls, so there's still no guarantee that
> you're only executing trusted code.

Interpreters are a known concern, as Yves-Alexis Perez pointed out in
his LSS-2018 Europe talk[1].

Mimi

[1] https://events.linuxfoundation.org/wp-content/uploads/2017/12/Linu
x-Kernel-Security-Contributions-by-ANSSI-Yves-Alexis-Perez-ANSSI.pdf

