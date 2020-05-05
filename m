Return-Path: <SRS0=J6Hd=6T=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19399C47259
	for <linux-security-module@archiver.kernel.org>; Tue,  5 May 2020 14:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F114C20838
	for <linux-security-module@archiver.kernel.org>; Tue,  5 May 2020 14:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbgEEOSg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 May 2020 10:18:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54208 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730192AbgEEOQz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 May 2020 10:16:55 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 045E4H3k144875;
        Tue, 5 May 2020 10:16:52 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30sp8juqqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 10:16:52 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 045E4MUL145111;
        Tue, 5 May 2020 10:16:51 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30sp8juqnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 10:16:50 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 045EFKbq027122;
        Tue, 5 May 2020 14:16:48 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 30s0g5awdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 14:16:47 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 045EFZSd61211098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 May 2020 14:15:35 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6616342041;
        Tue,  5 May 2020 14:16:45 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A180842042;
        Tue,  5 May 2020 14:16:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.200.227])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 May 2020 14:16:44 +0000 (GMT)
Message-ID: <1588688204.5157.5.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] ima: verify mprotect change is consistent with mmap
 policy
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jann Horn <jannh@google.com>
Cc:     linux-integrity@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Date:   Tue, 05 May 2020 10:16:44 -0400
In-Reply-To: <CAG48ez2PwqoDBx0pkZKFHvMXHNqAc8AfuTR5oPoF-obHqUo0zQ@mail.gmail.com>
References: <1588627060-7399-1-git-send-email-zohar@linux.ibm.com>
         <CAG48ez2PwqoDBx0pkZKFHvMXHNqAc8AfuTR5oPoF-obHqUo0zQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-05_08:2020-05-04,2020-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005050109
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Jann,

On Tue, 2020-05-05 at 02:15 +0200, Jann Horn wrote:
> On Mon, May 4, 2020 at 11:18 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > Files can be mmap'ed read/write and later changed to execute to circumvent
> > IMA's mmap appraise policy rules.  Due to locking issues (mmap semaphore
> > would be taken prior to i_mutex), files can not be measured or appraised at
> > this point.  Eliminate this integrity gap, by denying the mprotect
> > PROT_EXECUTE change, if an mmap appraise policy rule exists.
> 
> Just keep in mind that there are other ways to create executable
> mappings containing controlled code; e.g. PROT_EXEC with
> MAP_ANONYMOUS, or writing to /proc/self/mem (which is a debugging API
> that works entirely without ever making the VMA writable - I had an
> old series to provide LSM hooks for that stuff at
> <https://lore.kernel.org/lkml/1478142286-18427-3-git-send-email-jann@thejh.net/>,
> but I guess I must have forgotten about it or something...).

Sure.  These sound like memory attacks, which should be closed, but
are probably out of scope for IMA.

thanks,

Mimi
