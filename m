Return-Path: <SRS0=9ABi=3H=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A31C33CB7
	for <linux-security-module@archiver.kernel.org>; Sat, 18 Jan 2020 05:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31A724685
	for <linux-security-module@archiver.kernel.org>; Sat, 18 Jan 2020 05:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MyLM9F6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbgARFWK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 18 Jan 2020 00:22:10 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58510 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgARFWJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 18 Jan 2020 00:22:09 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id B73E12007679;
        Fri, 17 Jan 2020 21:22:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B73E12007679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1579324928;
        bh=seoXjZcBeW0pCKLw2Hln122p4fZMRx+skIRLz3V2mOE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=MyLM9F6YXQS87v5ppBsTJmH3gubmH8mPbuTpZWYFerF5DGubYPlTV3XZDDXhVw+VN
         Xq8TiAXdcU8crTs76NO2dTcaiVkc6BnIQHXTTpNC1E8dt7nlh27uGPV2LENaL7zjm+
         55EyjrT3/VEPRr6Qk4JDrAbg4zsTTF6PL3EDxtxc=
Subject: Re: inconsistent lock state in ima_process_queued_keys
To:     syzbot <syzbot+a4a503d7f37292ae1664@syzkaller.appspotmail.com>,
        dmitry.kasatkin@gmail.com, dvyukov@google.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, zohar@linux.ibm.com
References: <000000000000a1d91b059c6173c6@google.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <5264952c-6dae-47d8-9ee8-c837e69330be@linux.microsoft.com>
Date:   Fri, 17 Jan 2020 21:22:23 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <000000000000a1d91b059c6173c6@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 1/17/2020 7:14 PM, syzbot wrote:

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a4a503d7f37292ae1664@syzkaller.appspotmail.com
> 
> ================================
> WARNING: inconsistent lock state
> 5.5.0-rc6-next-20200116-syzkaller #0 Not tainted
> --------------------------------
> inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> kworker/u4:3/125 [HC0[0]:SC1[1]:HE1:SE0] takes:
> ffffffff8a03ce58 (ima_keys_lock){+.?.}, at: spin_lock include/linux/spinlock.h:338 [inline]
> ffffffff8a03ce58 (ima_keys_lock){+.?.}, at: ima_process_queued_keys+0x4f/0x320 security/integrity/ima/ima_asymmetric_keys.c:144
> {SOFTIRQ-ON-W} state was registered at:

The fix for this issue is in next-integrity branch. Should be merged to 
linux-next shortly.

  -lakshmi
