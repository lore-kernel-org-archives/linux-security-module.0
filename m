Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45890C433FE
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Nov 2022 10:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbiKHKUf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 8 Nov 2022 05:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbiKHKUS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Nov 2022 05:20:18 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD37326F9
        for <linux-security-module@vger.kernel.org>; Tue,  8 Nov 2022 02:20:04 -0800 (PST)
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2A8AJTXW056434;
        Tue, 8 Nov 2022 19:19:30 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Tue, 08 Nov 2022 19:19:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2A8AIEdQ056183
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Nov 2022 19:18:14 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <133ffb84-551e-866d-5597-e62a5a39bc05@I-love.SAKURA.ne.jp>
Date:   Tue, 8 Nov 2022 19:18:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 04/10] CaitSith: Add header file.
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <kees@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20221102171025.126961-4-penguin-kernel@I-love.SAKURA.ne.jp>
 <ef5fa206-4e7f-3c23-07d4-8591c4315d20@schaufler-ca.com>
 <20221105024345.GA15957@mail.hallyn.com>
 <5d31873f-f477-ef5a-591f-6f0195f258a8@I-love.SAKURA.ne.jp>
 <20221105234614.GA23523@mail.hallyn.com>
 <52fdbbe4-cad5-6cd0-9574-2e5efb88a478@I-love.SAKURA.ne.jp>
 <4ead148f-1629-22ec-91f3-44c71f70fce4@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <4ead148f-1629-22ec-91f3-44c71f70fce4@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2022/11/08 3:59, Casey Schaufler wrote:
> On 11/5/2022 5:56 PM, Tetsuo Handa wrote:
>> On 2022/11/06 8:46, Serge E. Hallyn wrote:
>>> On Sat, Nov 05, 2022 at 01:05:44PM +0900, Tetsuo Handa wrote:
>>>> On 2022/11/05 11:43, Serge E. Hallyn wrote:
>>>>> On Wed, Nov 02, 2022 at 10:57:48AM -0700, Casey Schaufler wrote:
>>>>>> On 11/2/2022 10:10 AM, Tetsuo Handa wrote:
>>>>>>> The main point of this submission is to demonstrate how an LSM module
>>>>>>> which can be loaded using /sbin/insmod can work, and to provide
>>>>>>> consideration points for making changes for LSM stacking in a way that
>>>>>>> will not lock out LSM modules which can be loaded using /sbin/insmod .
>>>>>> CaitSith could readily be done as an in-tree LSM. The implementation
>>>>>> of loadable module infrastructure is unnecessary.
>>>>> Sorry, I'm getting confused.  But in-tree and loadable are not related,
>>>>> right?
>>>> Very much related. My goal is to get CaitSith in-tree as a loadable LSM module
>>>> which can be loaded using /sbin/insmod .
>>> Great.  I support that.  But the sentence
>> Thank you.
>>
>>>>>> CaitSith could readily be done as an in-tree LSM. The implementation
>>>>>> of loadable module infrastructure is unnecessary.
>>> suggests that because CaitSith could be done in-tree, it doesn't need
>>> to be loadable.  I'm saying that is a non sequitur.  It sounded like
>>> that setence was meant to say "Because CaitSith could be in-tree, it
>>> doesn't need to be =m.  Only out of tree modules need to be loadable."
>> Unfortunately, I don't think that my intended Linux distributor (namely, Red Hat)
>> will support LSMs other than SELinux.
> 
> I also doubt that even if you came up with a 100% perfect implementation
> of loadable module support it would be accepted upstream. If you somehow
> got it upstream I really, really think it would be required to be optional.
> There's no way Redhat would enable loadable module support if were available.
> I am perfectly willing to be corrected if I've made a statement here that
> isn't true, but I'll bet a refreshing beverage on it.
> 
>>
>>   https://bugzilla.redhat.com/show_bug.cgi?id=542986
>>
>> Therefore, not only out of tree modules but also in-tree modules which cannot be
>> enabled by Linux distributors need to be implemented as loadable kernel modules.
> 
> Today you cannot use SELinux and AppArmor together on Redhat. Someday
> "soon ;)" you won't be allowed to run them together on Redhat. If there's
> market demand (I'm not holding my breath) it could happen in the future.
> But that's up to Redhat to decide. I don't see Redhat as the customer for
> LSM improvements. They are happy with what they have.
> 
> You have to take a different approach. Find a distribution that does want
> loadable modules. You'll need a viable implementation to convince them to
> help with the effort. Even then, you'll have a tough row to hoe.
> 

You are proving yourself that you are completely trapped into
"only in-tree and supported by distributors is correct" crap.

I am an individual who don't belong to specific distribution. Most of Linux users
in companies I relate with are using RHEL. Company's financial support for TOMOYO
terminated in March 2012 because I was not able to establish support/consult business
because I was not able to get TOMOYO enabled in RHEL (even in Fedora).

My support for TOMOYO is still continued, but unless loadable LSMs becomes legally
possible, I can't introduce TOMOYO/CaitSith to Linux users in companies I relate with.

Even if your LSM stacking work completes some day, I can imagine that there will be
no LSMs I can stack (unless loadable LSMs becomes legally possible).
Finding a distribution who want loadable LSMs does not help.
Only that loadable LSMs becomes legally possible without kernel config option helps.

What I'm asking you are that:

  Please don't lock out out-of-tree LSM modules (by requiring an LSM id integer value
  which are assigned to only in-tree LSM modules) because we can't accept whatever LSM
  modules as in-tree.

  Please don't lock out loadable LSM modules (by using fixed sized array) because
  locking out loadable LSM modules reduces the value of your LSM stacking work.

Quite simple.

