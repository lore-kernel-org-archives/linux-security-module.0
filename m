Return-Path: <SRS0=tIjr=X4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B135AC10F14
	for <linux-security-module@archiver.kernel.org>; Thu,  3 Oct 2019 10:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBF1217D7
	for <linux-security-module@archiver.kernel.org>; Thu,  3 Oct 2019 10:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfJCKAW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:00:22 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59034 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729155AbfJCKAW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Oct 2019 06:00:22 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x93A04ZN016716;
        Thu, 3 Oct 2019 19:00:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Thu, 03 Oct 2019 19:00:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x939xvg5016659
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 3 Oct 2019 19:00:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] tomoyo: Don't check open/getattr permission on
 sockets.
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <0000000000004f43fa058a97f4d3@google.com>
 <201906060520.x565Kd8j017983@www262.sakura.ne.jp>
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
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <b175f451-4e76-84aa-48fa-e3ee9490c579@i-love.sakura.ne.jp>
Date:   Thu, 3 Oct 2019 18:59:56 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191003082543.5e1e25dd@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello.

On 2019/10/03 7:25, Stephen Rothwell wrote:
> Hi Tetsuo,
> 
> On Wed, 2 Oct 2019 19:50:48 +0900 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> On 2019/09/14 16:36, Stephen Rothwell wrote:
>>>
>>> I am on vacation until after the merge window closes, so I will add it then.
>>> Please remind me if I don't.  
>>
>> Did you return from the vacation?
> 
> I knew I'd missed one (but I have too much email :-().

Thank you for adding my tree.

> 
> I don't think the back merges of Linus' tree add anything useful to
> your tree.  At this point it probably makes sense to just rebase the
> single patch onto v5.4-rc1 and then not back merge Linus' tree at all
> (unless some really complex conflict arises).
> 

This is my first time using persistent git tree.
I made my tree using the sequence shown below.

  # Upon initialization
  git clone https://scm.osdn.net/gitroot/tomoyo/tomoyo-test1.git
  cd tomoyo-test1/
  git remote add upstream git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  git remote update upstream
  git merge upstream/master
  git push -u origin master

According to
https://lkml.kernel.org/r/CAHk-=wg=io4rX2qzupdd4XdYy6okMx5jjzEwXe_UvLQgLsSUFA@mail.gmail.com
I should not try "git rebase" and "git merge" because I don't understand what they do. But
I guess I need to use "git merge" in order to update my tree before making changes.
Is the sequence shown below appropriate?

  # When making changes
  git remote update upstream
  git merge upstream/master
  edit files
  git commit
  git push -u origin master

Since I'm not familiar with git management, I want to use only master branch.
Do I need to make branches or another git tree for asking Linus to pull for linux.git ?
