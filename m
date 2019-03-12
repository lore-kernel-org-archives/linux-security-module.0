Return-Path: <SRS0=08hy=RP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D997C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Mar 2019 21:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398FA2147C
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Mar 2019 21:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfCLVPP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:15:15 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:27892 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfCLVPP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Mar 2019 17:15:15 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2CLF5it097097;
        Wed, 13 Mar 2019 06:15:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Wed, 13 Mar 2019 06:15:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2CLF5c4097092
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 13 Mar 2019 06:15:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] tomoyo: Add a kernel config option for fuzzing testing.
To:     James Morris <jmorris@namei.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org
References: <19e3dbac-d3ac-53b2-6e98-faf927bc72b3@i-love.sakura.ne.jp>
 <05b05166-d24a-3c50-6556-472f50a239b9@tycho.nsa.gov>
 <201903042359.x24NxJwx065719@www262.sakura.ne.jp>
 <alpine.LRH.2.21.1903051431540.20560@namei.org>
 <72b3b8e1-fc34-f312-de12-cf42992bceb8@i-love.sakura.ne.jp>
 <alpine.LRH.2.21.1903130418580.24386@namei.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <770d8413-bd57-c379-21a0-acbbdf82241e@i-love.sakura.ne.jp>
Date:   Wed, 13 Mar 2019 06:15:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1903130418580.24386@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019/03/13 2:19, James Morris wrote:
> On Mon, 11 Mar 2019, Tetsuo Handa wrote:
> 
>> On 2019/03/05 12:32, James Morris wrote:
>>> On Tue, 5 Mar 2019, Tetsuo Handa wrote:
>>>
>>>> I guess that majority of TOMOYO users are now using the upstream version. But
>>>> pre-LSM version and/or AKARI will remain there until LKM-based LSMs becomes
>>>> officially supported
>>>
>>> You mean dynamically loadable LSMs?
>>
>> Yes. As long as upstream can't accept all LSM modules, and some people cannot afford
>> utilizing upstream LSM modules, LKM-based LSMs will be needed by such people.
> 
> What do you mean cannot afford ?
> 

Some people have to set SELINUX=disabled in /etc/selinux/config or pass security=none from
the kernel command line.
