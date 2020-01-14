Return-Path: <SRS0=gHeC=3D=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62D0C33CB1
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jan 2020 14:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8080A24680
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jan 2020 14:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgANO51 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:57:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62576 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727092AbgANO50 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Jan 2020 09:57:26 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EEsCbr146643
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jan 2020 09:57:25 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xhfens101-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jan 2020 09:57:24 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 14 Jan 2020 14:56:59 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Jan 2020 14:56:55 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00EEusPu65208380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 14:56:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C0F552051;
        Tue, 14 Jan 2020 14:56:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.223.52])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 47F0A5204F;
        Tue, 14 Jan 2020 14:56:53 +0000 (GMT)
Subject: Re: inconsistent lock state in ima_process_queued_keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+a4a503d7f37292ae1664@syzkaller.appspotmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Date:   Tue, 14 Jan 2020 09:56:52 -0500
In-Reply-To: <CACT4Y+av-ipjsdtsXs4d55w=inNHJqho3s3XKfU0Jo7f98yi8w@mail.gmail.com>
References: <000000000000486474059c19f4d7@google.com>
         <CACT4Y+av-ipjsdtsXs4d55w=inNHJqho3s3XKfU0Jo7f98yi8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20011414-0020-0000-0000-000003A09735
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011414-0021-0000-0000-000021F80C57
Message-Id: <1579013812.12230.21.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_04:2020-01-14,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001140128
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 2020-01-14 at 14:58 +0100, Dmitry Vyukov wrote:
> On Tue, Jan 14, 2020 at 2:56 PM syzbot
> <syzbot+a4a503d7f37292ae1664@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    1b851f98 Add linux-next specific files for 20200114
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12bcbb25e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3e7d9cf7ebfa08ad
> > dashboard link: https://syzkaller.appspot.com/bug?extid=a4a503d7f37292ae1664
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+a4a503d7f37292ae1664@syzkaller.appspotmail.com
> 
> +Lakshmi, you seem to have submitted a number of changes to this file recently.
> 
> This completely breaks linux-next testing for us, every kernel crashes
> a few minutes after boot.
> 
> 2020/01/14 14:45:00 vm-26: crash: inconsistent lock state in
> ima_process_queued_keys

Yikes!  Are you running with an IMA policy?  I assume this is being
caused by commit 8f5d2d06f217 ("IMA: Defined timer to free queued
keys".  Does reverting it prevent this from happening?

Mimi

