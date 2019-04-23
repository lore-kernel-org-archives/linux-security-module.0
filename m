Return-Path: <SRS0=iQUf=SZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F2DC10F14
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Apr 2019 10:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56AD7206A3
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Apr 2019 10:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfDWKo5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:44:57 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63029 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDWKo5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Apr 2019 06:44:57 -0400
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x3NAio2v083716;
        Tue, 23 Apr 2019 19:44:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp);
 Tue, 23 Apr 2019 19:44:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x3NAikP0083558
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 23 Apr 2019 19:44:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH (resend)] tomoyo: Add a kernel config option for fuzzing
 testing.
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org
References: <1555067094-9861-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <49c5ae17-86fb-e4d3-0e06-c205cf324c1d@I-love.SAKURA.ne.jp>
 <alpine.LRH.2.21.1904230851460.15541@namei.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <4b80cba5-2a7b-93ac-3f4a-41d31c6c58fc@i-love.sakura.ne.jp>
Date:   Tue, 23 Apr 2019 19:44:47 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1904230851460.15541@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019/04/23 7:52, James Morris wrote:
> On Mon, 22 Apr 2019, Tetsuo Handa wrote:
> 
>> James, will you apply this patch and
>> "[PATCH 3/3] tomoyo: Check address length before reading address family" and
>> "[PATCH] tomoyo: Change pathname calculation for read-only filesystems." ?
> 
> On the 2nd one, did we see any feedback from Al?
> 

Not yet. I wonder he has any comment...

But I believe there is no reason to delay this patch and
"[PATCH 3/3] tomoyo: Check address length before reading address family" patch
because these two patches are needed for avoiding crashes by syzbot's testing.
