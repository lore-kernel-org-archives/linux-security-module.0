Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6246EC4332F
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Nov 2022 04:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiKJEOT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 9 Nov 2022 23:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiKJENo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 Nov 2022 23:13:44 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8863529346
        for <linux-security-module@vger.kernel.org>; Wed,  9 Nov 2022 20:12:35 -0800 (PST)
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2AA4CEmp054720;
        Thu, 10 Nov 2022 13:12:14 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Thu, 10 Nov 2022 13:12:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2AA4AxBx054426
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 10 Nov 2022 13:10:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ef585586-2436-8665-a5e1-475cdd5be5a2@I-love.SAKURA.ne.jp>
Date:   Thu, 10 Nov 2022 13:10:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH 04/10] CaitSith: Add header file.
To:     Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20221102171025.126961-4-penguin-kernel@I-love.SAKURA.ne.jp>
 <ef5fa206-4e7f-3c23-07d4-8591c4315d20@schaufler-ca.com>
 <20221105024345.GA15957@mail.hallyn.com>
 <5d31873f-f477-ef5a-591f-6f0195f258a8@I-love.SAKURA.ne.jp>
 <20221105234614.GA23523@mail.hallyn.com>
 <52fdbbe4-cad5-6cd0-9574-2e5efb88a478@I-love.SAKURA.ne.jp>
 <4ead148f-1629-22ec-91f3-44c71f70fce4@schaufler-ca.com>
 <133ffb84-551e-866d-5597-e62a5a39bc05@I-love.SAKURA.ne.jp>
 <CAHC9VhS9RQdeCipSpSH3_LZyFfb-BDry=EsSmkt4OLVk=OZnEg@mail.gmail.com>
 <f52e6e9f-5e95-8843-c2f5-c50bba48e5e4@I-love.SAKURA.ne.jp>
 <CAHC9VhS=0Ts8E647JJiJ6dwPmnuLuYTyOS0QEYJO_EmAb3yFcw@mail.gmail.com>
 <82e46552-54da-6df5-c451-485991dcb5c3@I-love.SAKURA.ne.jp>
 <7CED07F5-A6FC-46AD-8F9D-ECFC28FE23C9@kernel.org>
Content-Language: en-US
In-Reply-To: <7CED07F5-A6FC-46AD-8F9D-ECFC28FE23C9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2022/11/10 11:22, Kees Cook wrote:
> On November 9, 2022 3:57:06 PM PST, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>> On 2022/11/09 23:48, Paul Moore wrote:
>>>                                             If there is a significant
>>> change, e.g. the overall kernel policy towards out-of-tree code, we
>>> can reconsider this policy but as of right now only upstream LSMs will
>>> have LSM ID tokens assigned to them; in-development LSMs are free to
>>> temporarily assign themselves an ID token (which may change when the
>>> LSM is merged upstream), and out-of-tree LSMs are free to do whatever
>>> they like with respect to their code, just as they do now.
>>
>> If in-development LSMs and out-of-tree LSMs cannot get a stable ID token,
>> developers cannot write and publish userspace tools which make use of ID
>> token. If ID collision happens by use of temporarily ID token, this token
>> is no longer an identifier. That is a pointless and needless constraint
>> for getting LSM modules created / tested / used.
> 
> You have to let this go. You aren't hearing us: this ID reservation process
> is not a problem for anyone but you. It is the same for all the syscalls
> that get added, and all the prctls, etc etc. This isn't a problem for userspace
> tools using those, and there won't be a problem here either.
> 
> We will not support out of tree code, so needing ID stability for out-of-tree
> LSMs isn't a valid argument.
> 

This ID reservation process is very much a problem for you all.

In https://lkml.kernel.org/r/CAHC9VhQGnEcoYeGpwbbXbMrG1dOvJ=2ohd4zPYoqBJK9p1mSjQ@mail.gmail.com ,
Paul said that it is becoming increasingly difficult for people to find time to
review potential new LSMs.

  >> Many modules
  >>
  >>     SimpleFlow （ 2016/04/21 https://lwn.net/Articles/684825/ ）
  >>     HardChroot （ 2016/07/29 https://lwn.net/Articles/695984/ ）
  >>     Checmate （ 2016/08/04 https://lwn.net/Articles/696344/ ）
  >>     LandLock （ 2016/08/25 https://lwn.net/Articles/698226/ ）
  >>     PTAGS （ 2016/09/29 https://lwn.net/Articles/702639/ ）
  >>     CaitSith （ 2016/10/21 https://lwn.net/Articles/704262/ ）
  >>     SafeName （ 2016/05/03 https://lwn.net/Articles/686021/ ）
  >>     WhiteEgret （ 2017/05/30 https://lwn.net/Articles/724192/ ）
  >>     shebang （ 2017/06/09 https://lwn.net/Articles/725285/ ）
  >>     S.A.R.A. （ 2017/06/13 https://lwn.net/Articles/725230/ ）
  >>
  >> are proposed 5 or 6 years ago, but mostly became silent...
  > 
  > At least one of those, Landlock, has been merged upstream and is now
  > available in modern released Linux Kernels.  As far as the other LSMs
  > are concerned, I don't recall there ever being significant interest
  > among other developers or users to warrant their inclusion upstream.
  > If the authors believe that has changed, or is simply not true, they
  > are always welcome to post their patches again for discussion, review,
  > and potential upstreaming.  However, I will caution that it is
  > becoming increasingly difficult for people to find time to review
  > potential new LSMs so it may a while to attract sufficient comments
  > and feedback.

Actually, previous CaitSith proposal in 2016 at
https://lkml.kernel.org/r/1477054150-4772-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp
died because nobody except John Johansen showed interest, and John could not
find time to review.

We are getting more and more difficult to get new LSM module in-tree.
An in-development code being remaining out-of-tree shall happen. And you are
declaring that we ignore LSM modules which cannot get enough interests.
That's horrible and unacceptable.

What I'm repeating since
https://lkml.kernel.org/r/2225aec6-f0f3-d38e-ee3c-6139a7c25a37@I-love.SAKURA.ne.jp is that

  You are making LSM interface more and more unattractive. The consequence would be
  "The LSM interface is dead. We will give up implementing as LSMs."

Quite simple.
