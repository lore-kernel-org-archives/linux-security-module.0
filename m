Return-Path: <SRS0=cLeu=3P=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1432C35247
	for <linux-security-module@archiver.kernel.org>; Sun, 26 Jan 2020 17:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924A8206F0
	for <linux-security-module@archiver.kernel.org>; Sun, 26 Jan 2020 17:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgAZRBS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 26 Jan 2020 12:01:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726173AbgAZRBS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 26 Jan 2020 12:01:18 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00QGxBrL019860
        for <linux-security-module@vger.kernel.org>; Sun, 26 Jan 2020 12:01:17 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrjq56e5k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Sun, 26 Jan 2020 12:01:16 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 26 Jan 2020 17:01:14 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 26 Jan 2020 17:01:11 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00QH0JRf44171560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jan 2020 17:00:20 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03A8811C04A;
        Sun, 26 Jan 2020 17:01:11 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2ECC511C052;
        Sun, 26 Jan 2020 17:01:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.205.7])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 26 Jan 2020 17:01:10 +0000 (GMT)
Subject: Re: [PATCH v2] ima: export the measurement list when needed
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Ken Goldman <kgold@linux.ibm.com>, david.safford@gmail.com,
        monty.wiseman@ge.com, "Serge E. Hallyn" <serge@hallyn.com>
Date:   Sun, 26 Jan 2020 12:01:09 -0500
In-Reply-To: <CAE=NcraSfo0fwxCnFQd08Ga59DsvxPTch-n_iN7fxt+3RdmP+A@mail.gmail.com>
References: <20200108111743.23393-1-janne.karhunen@gmail.com>
         <CAE=NcrZrbRinOAbB+k1rjhcae3nqfJ8snC_EnY8njMDioM7=vg@mail.gmail.com>
         <1579708579.5182.77.camel@linux.ibm.com>
         <CAE=NcraSfo0fwxCnFQd08Ga59DsvxPTch-n_iN7fxt+3RdmP+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012617-0028-0000-0000-000003D48843
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012617-0029-0000-0000-00002498CA09
Message-Id: <1580058069.5990.36.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-26_02:2020-01-24,2020-01-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=899
 lowpriorityscore=0 mlxscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001260147
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 2020-01-23 at 10:41 +0200, Janne Karhunen wrote:
> On Wed, Jan 22, 2020 at 5:56 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> 
> > > While it can now be argued that since this is an admin-driven event,
> > > kernel does not need to write the file. However, the intention is to
> > > bring out a second patch a bit later that adds a variable to define
> > > the max number of entries to be kept in the kernel memory and
> > > workqueue based automatic flushing. In those cases the kernel has to
> > > be able to write the file without any help from the admin..
> >
> > I don't think it is common, and probably not acceptable, for the
> > kernel to open a file for writing.
> 
> Ok. It just means that the kernel cannot do its own memory management
> and will depend on the user flushing the memory often enough to
> prevent something bad from happening. Is this more common in the
> kernel than writing out a file?

Ok, there are examples of both passing a file descriptor and passing a
pathname from userspace, but even in the case of passing a pathname,
userspace normally creates the file.

There's been discussion in the past of defining an integrity
capability.  Are we at that point where we really do need to define an
integrity capability or is everyone comfortable with relying on
CAP_SYS_ADMIN?

When implementing this feature of exporting and truncating the
measurement list, please keep in mind how this would work in the
context of IMA namespaces.

thanks,

Mimi

