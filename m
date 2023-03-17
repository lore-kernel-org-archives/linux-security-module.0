Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC0FC74A5B
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Mar 2023 15:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjCQPVl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 Mar 2023 11:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCQPVk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Mar 2023 11:21:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359DB52924
        for <linux-security-module@vger.kernel.org>; Fri, 17 Mar 2023 08:21:39 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HEktei003656;
        Fri, 17 Mar 2023 15:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=wl8zH3ZF1CNo4CqmReSzmoRkoYnprhLy7oZRp3HsQJk=;
 b=Mwo+gYfnuHSJ81oDYHMBjQCyucM/yFWLUAZS6SFhM4Ru+OYcOgOksfkZ6AuvJI21lToP
 5P6SsYD5YGpHG2jLsF+z7+0cpYuQ6fy3Mc2Zk6J4QxzuxZ2Valt7SQchCxVdF+1Hy20Q
 Jzis9OSc0dDDz/C69I+HYSvf9wdZpSawGVQY4lcHvBXO6MCHAKG6Tu8QR0pnQGx0YvcB
 Iqb5WEOOoXcdP1u2Zv/QN+8lhQu4Hz4Z+/3p81iFSN/ppmc9GVkyW8sMkZvGlIR1Z3VP
 R6Nxak9nrerKMRF8VoXWujsf6EIK9lGuobrhz79Kd1uCy+/QRKSahWpZVodCcETCE4zs Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pct8yh45d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 15:21:00 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32HF0o8S007384;
        Fri, 17 Mar 2023 15:20:59 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pct8yh454-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 15:20:59 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32HElT3i005425;
        Fri, 17 Mar 2023 15:20:58 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3pbswp90tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 15:20:58 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32HFKvsC57672074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 15:20:57 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0C6C5805E;
        Fri, 17 Mar 2023 15:20:57 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81B005805B;
        Fri, 17 Mar 2023 15:20:57 +0000 (GMT)
Received: from localhost (unknown [9.163.4.251])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Mar 2023 15:20:57 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>, jmorris@namei.org,
        mjg59@srcf.ucam.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: LOCK_DOWN_FORCE_INTEGRITY_FOR_FUZZING?
In-Reply-To: <CACT4Y+Z-9KCgKwkktvdJwNJZxxeA1f74zkP7KD6c=OmKXxXfjw@mail.gmail.com>
References: <CACT4Y+Z-9KCgKwkktvdJwNJZxxeA1f74zkP7KD6c=OmKXxXfjw@mail.gmail.com>
Date:   Fri, 17 Mar 2023 10:20:57 -0500
Message-ID: <87y1nv76au.fsf@linux.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tgR9hKeucj2xHmuDH2yr9K59Qa8QoG0i
X-Proofpoint-GUID: y3SzL4SAWn7ZTjL6B2hHSMI36g12aXkW
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_10,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=534 impostorscore=0
 suspectscore=0 adultscore=0 mlxscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170103
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Dmitry,

Dmitry Vyukov <dvyukov@google.com> writes:
> Hi Lockdown maintainers,

I'm not a lockdown maintainer, but I feel like I can respond to a couple
things here.

> We don't enable Lockdown integrity mode on syzbot during fuzzing, but
> we would like to. The main problem is the restriction of debugfs,
> which we need for fuzzing. But we do duplicate some of its
> restrictions (e.g. DEVKMEM=n).
>
> It come up again recently in the context of discussion of memory
> corruptions when a mounted blocked device is being written to by root:
> https://lore.kernel.org/all/CACT4Y+b1vGfe0Uvp6YmKahK4GfCfvdBLCh0SAQzGgWN1s6A+0Q@mail.gmail.com/
> It looks like this restriction of writing to mounted block devices
> should be part of integrity lockdown (but I am not an expert).

I'm not sure, I'll leave that question to others.

> What do you think about the addition of a new level that is integrity
> but with debug fs access?
> LOCKDOWN_RTAS_ERROR_INJECTION also looks like it's in the same bucket
> of "fine for testing".

Thanks for checking. Error injection via RTAS (pseries partition
firmware) can cause unrecoverable cache and memory corruption. Right now
I don't think including LOCKDOWN_RTAS_ERROR_INJECTION in a relaxed
integrity mode for fuzzing would yield useful results.

> At least for us it is OK if it can be enabled only via kernel config
> (no cmd line) and named accordingly
> (TEST_ONLY_DONT_ENABLE_IN_PRODUCTION).
>
> If we have it, we could restrict writing to mounted devices in
> integrity mode and enable this mode on syzbot.

So I understand the proposal to involve something like:

--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -120,11 +120,12 @@ enum lockdown_reason {
 	LOCKDOWN_TIOCSSERIAL,
 	LOCKDOWN_MODULE_PARAMETERS,
 	LOCKDOWN_MMIOTRACE,
-	LOCKDOWN_DEBUGFS,
 	LOCKDOWN_XMON_WR,
 	LOCKDOWN_BPF_WRITE_USER,
 	LOCKDOWN_DBG_WRITE_KERNEL,
 	LOCKDOWN_RTAS_ERROR_INJECTION,
+	LOCKDOWN_INTEGRITY_FUZZING_MAX,
+	LOCKDOWN_DEBUGFS,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_KCORE,
 	LOCKDOWN_KPROBES,

Is that right?

I don't have a specific example at hand, but I suspect that enabling all
of debugfs would allow syzbot to reach code that integrity mode
ordinarily would prevent. Which doesn't seem like what you would want?

I wonder if the debugfs-hosted facilities needed by syzbot could be
identified in a finer-grained way that could be incorporated into the
lockdown reason list for this purpose. So that way only the things
syzbot needs would be exposed.
