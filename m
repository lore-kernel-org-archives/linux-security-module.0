Return-Path: <SRS0=PCLm=2A=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82CFC43603
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Dec 2019 10:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925F7207FF
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Dec 2019 10:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfLJKV2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:21:28 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:57290 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfLJKV2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Dec 2019 05:21:28 -0500
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xBAALDS9088324;
        Tue, 10 Dec 2019 19:21:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav305.sakura.ne.jp);
 Tue, 10 Dec 2019 19:21:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav305.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xBAAL8l2088215
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 10 Dec 2019 19:21:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] tomoyo: Don't check open/getattr permission on
 sockets.
To:     James Morris <jmorris@namei.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-security-module@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <0000000000004f43fa058a97f4d3@google.com>
 <20190618204933.GE17978@ZenIV.linux.org.uk>
 <8f874b03-b129-205f-5f05-125479701275@i-love.sakura.ne.jp>
 <bc146372-764d-93a9-af27-666d73ed3af5@i-love.sakura.ne.jp>
 <alpine.LRH.2.21.1907061944050.2662@namei.org>
 <alpine.LRH.2.21.1907061949040.2662@namei.org>
 <289ebc65-8444-37e3-e54e-21b55d2c9192@i-love.sakura.ne.jp>
 <a28f2680-bafc-5e23-4eea-6b432f561cd4@i-love.sakura.ne.jp>
 <A9CE5147-4047-4C42-B772-F0ED510FA283@canb.auug.org.au>
 <36906718-d2ae-3514-c6b2-371037c98da5@i-love.sakura.ne.jp>
 <20191003082543.5e1e25dd@canb.auug.org.au>
 <b175f451-4e76-84aa-48fa-e3ee9490c579@i-love.sakura.ne.jp>
 <d5cbd24b-531d-e9d0-f784-e6447129741d@i-love.sakura.ne.jp>
 <alpine.LRH.2.21.1911211818320.3625@namei.org>
 <cba33548-91dc-42b4-ef96-43642ebc3427@i-love.sakura.ne.jp>
 <b7263da2-d56d-0f27-a7e5-03541ff8a0c1@i-love.sakura.ne.jp>
 <579b10bb-990f-ae4c-8098-b39e56a4c475@i-love.sakura.ne.jp>
 <alpine.LRH.2.21.1912100837160.4379@namei.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <457927e7-2cec-3933-3e5c-67ebd29d8a52@i-love.sakura.ne.jp>
Date:   Tue, 10 Dec 2019 19:21:08 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1912100837160.4379@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019/12/10 6:37, James Morris wrote:
> On Wed, 4 Dec 2019, Tetsuo Handa wrote:
> 
>>
>> I decided to drop tomoyo_get_socket_name(). Will you pick up the following commit?
>>
>> commit c39593ab0500fcd6db290b311c120349927ddc04
>> Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Date:   Mon Nov 25 10:46:51 2019 +0900
>>
>>     tomoyo: Don't use nifty names on sockets.
>>
> 
>>From where?
> 
> Please send a patch.
> 

Patch is at https://scm.osdn.net/gitroot/tomoyo/tomoyo-test1 and was tested on linux-next.git .
But if you pick up c39593ab0500, what do I need to do (in order to avoid trying to apply the same
patch) ? Could you explain me (using command line) how I can send only c39593ab0500 to linux.git ?
https://osdn.net/projects/tomoyo/scm/git/tomoyo-test1/commits has only master branch.

c39593ab0500 (HEAD -> master, origin/master) tomoyo: Don't use nifty names on sockets.
cbf8353d474c Merge branch 'master' of https://scm.osdn.net/gitroot/tomoyo/tomoyo-test1
fd46afeac605 Revert "tomoyo: Don't check open/getattr permission on sockets."
19768fdc4025 Revert "printk: Monitor change of console loglevel."
07fca3f339d7 printk: Monitor change of console loglevel.
df8aec8cd8b2 tomoyo: Don't check open/getattr permission on sockets.
219d54332a09 (tag: v5.4, upstream/master) Linux 5.4
