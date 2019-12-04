Return-Path: <SRS0=6Zdz=Z2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30650C43603
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Dec 2019 12:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4442077B
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Dec 2019 12:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfLDMuz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:50:55 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:52492 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbfLDMuz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Dec 2019 07:50:55 -0500
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xB4Cogn6080765;
        Wed, 4 Dec 2019 21:50:42 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp);
 Wed, 04 Dec 2019 21:50:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xB4CoYgJ080585
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 4 Dec 2019 21:50:42 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] tomoyo: Don't check open/getattr permission on
 sockets.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     James Morris <jmorris@namei.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-security-module@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <0000000000004f43fa058a97f4d3@google.com>
 <1b5722cc-adbc-035d-5ca1-9aa56e70d312@I-love.SAKURA.ne.jp>
 <a4ed1778-8b73-49d1-0ff0-59d9c6ac0af8@I-love.SAKURA.ne.jp>
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
Message-ID: <579b10bb-990f-ae4c-8098-b39e56a4c475@i-love.sakura.ne.jp>
Date:   Wed, 4 Dec 2019 21:50:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <b7263da2-d56d-0f27-a7e5-03541ff8a0c1@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019/11/21 22:59, Tetsuo Handa wrote:
> On 2019/11/21 19:18, Tetsuo Handa wrote:
>> On 2019/11/21 16:21, James Morris wrote:
>>> On Wed, 13 Nov 2019, Tetsuo Handa wrote:
>>>
>>>> Hello, Andrew and James.
>>>>
>>>> I have difficulty setting up environments for sending pull request to linux.git
>>>> (nobody around me knows Linux kernel maintainer's workflow at the command line level).
>>>> Can you pick up the following commit via mmotm or linux-security.git tree?
>>>
>>> Not sure if your fix is complete.
>>>
>>> Are there other potential paths to trigger this via tomoyo_path_perm() ?
>>>
>>> e.g. call unlink(2) on /proc/pid/fd/sockfd
>>
>> I think they are safe. For example, unlink(2) checks that
>> inode is valid before calling security_path_unlink().
> 
> Hmm, since unlink(2) locks parent's inode instead of inode to be removed itself,
> there is indeed possibility that tomoyo_path_perm() races with __sock_release().
> We need another patch...
> 

I decided to drop tomoyo_get_socket_name(). Will you pick up the following commit?

commit c39593ab0500fcd6db290b311c120349927ddc04
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Mon Nov 25 10:46:51 2019 +0900

    tomoyo: Don't use nifty names on sockets.
