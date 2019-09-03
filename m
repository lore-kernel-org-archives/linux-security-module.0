Return-Path: <SRS0=NhOO=W6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D223C3A5A5
	for <linux-security-module@archiver.kernel.org>; Tue,  3 Sep 2019 06:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76296217D7
	for <linux-security-module@archiver.kernel.org>; Tue,  3 Sep 2019 06:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfICGwr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 3 Sep 2019 02:52:47 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61721 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfICGwq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Sep 2019 02:52:46 -0400
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x836qYwt069685;
        Tue, 3 Sep 2019 15:52:35 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp);
 Tue, 03 Sep 2019 15:52:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x836qXBa069676
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 3 Sep 2019 15:52:34 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] tomoyo: Don't check open/getattr permission on
 sockets.
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <0000000000004f43fa058a97f4d3@google.com>
 <201906060520.x565Kd8j017983@www262.sakura.ne.jp>
 <1b5722cc-adbc-035d-5ca1-9aa56e70d312@I-love.SAKURA.ne.jp>
 <a4ed1778-8b73-49d1-0ff0-59d9c6ac0af8@I-love.SAKURA.ne.jp>
 <20190618204933.GE17978@ZenIV.linux.org.uk>
 <8f874b03-b129-205f-5f05-125479701275@i-love.sakura.ne.jp>
 <bc146372-764d-93a9-af27-666d73ed3af5@i-love.sakura.ne.jp>
 <alpine.LRH.2.21.1907061944050.2662@namei.org>
 <alpine.LRH.2.21.1907061949040.2662@namei.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <289ebc65-8444-37e3-e54e-21b55d2c9192@i-love.sakura.ne.jp>
Date:   Tue, 3 Sep 2019 15:52:32 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1907061949040.2662@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019/07/07 11:50, James Morris wrote:
> On Sat, 6 Jul 2019, James Morris wrote:
> 
>> On Thu, 4 Jul 2019, Tetsuo Handa wrote:
>>
>>> Hello.
>>>
>>> Since it seems that Al has no comments, I'd like to send this patch to
>>> linux-next.git . What should I do? Do I need to set up a git tree?
>>
>> Yes, you can create one at github or similar.
> 
> Also notify Stephen Rothwell of the location of your -next branch, so it 
> gets pulled into his tree.
> 

I executed commands shown below. Since I'm not familiar with git management,
I want to use only master branch. Is this sequence correct?

# Upon initialization
git clone https://scm.osdn.net/gitroot/tomoyo/tomoyo-test1.git
cd tomoyo-test1/
git remote add upstream git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git remote update upstream
git merge upstream/master
git push -u origin master

# When making changes
git remote update upstream
git merge upstream/master
git am 0001-tomoyo-Don-t-check-open-getattr-permission-on-socket.patch
git push -u origin master
