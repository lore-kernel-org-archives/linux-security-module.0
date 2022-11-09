Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D1BC4332F
	for <linux-security-module@archiver.kernel.org>; Wed,  9 Nov 2022 10:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiKIKOS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 9 Nov 2022 05:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKIKOS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 Nov 2022 05:14:18 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2909E183A3
        for <linux-security-module@vger.kernel.org>; Wed,  9 Nov 2022 02:14:17 -0800 (PST)
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2A9ADrxQ048190;
        Wed, 9 Nov 2022 19:13:53 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Wed, 09 Nov 2022 19:13:53 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2A9ADrJP048183
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 9 Nov 2022 19:13:53 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f52e6e9f-5e95-8843-c2f5-c50bba48e5e4@I-love.SAKURA.ne.jp>
Date:   Wed, 9 Nov 2022 19:13:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 04/10] CaitSith: Add header file.
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
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
 <133ffb84-551e-866d-5597-e62a5a39bc05@I-love.SAKURA.ne.jp>
 <CAHC9VhS9RQdeCipSpSH3_LZyFfb-BDry=EsSmkt4OLVk=OZnEg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhS9RQdeCipSpSH3_LZyFfb-BDry=EsSmkt4OLVk=OZnEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2022/11/09 11:20, Paul Moore wrote:
> On Tue, Nov 8, 2022 at 5:20 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> What I'm asking you are that:
>>
>>   Please don't lock out out-of-tree LSM modules (by requiring an LSM id integer value
>>   which are assigned to only in-tree LSM modules) because we can't accept whatever LSM
>>   modules as in-tree.
>>
>>   Please don't lock out loadable LSM modules (by using fixed sized array) because
>>   locking out loadable LSM modules reduces the value of your LSM stacking work.
>>
>> Quite simple.
> 
> Tetsuo, at this point I think we all understand your concern and I
> appreciate and respect the passion you have for your argument.
> However, I think the rest of the developers, including myself, have
> also made our points very clear.  While there may still be revisions
> to the syscall patches, I believe identifying LSMs via a token value
> as opposed to a string value is the better option for the upstream
> Linux Kernel.

I'm not opposing to identifying LSMs via a token value. I'm opposing to who can
obtain a token value, for I haven't heard a clear promise that we shall allow
whatever LSM modules to obtain a token value.

>                This alone should not prevent dynamically loadable LSMs
> in the future, if we decide to pursue that, but I do recognize that it
> will present more of a challenge for the long term maintenance of
> out-of-tree LSMs.

Who can obtain a token value affects both built-in LSM modules and dynamically
loadable LSM modules. A "code that is being developed in the open with the
*intention* to be submitted to be in-tree" has to be able to obtain a token
value as soon as starting development (which is much earlier stage than getting
that code in-tree).

Do you remember that you said

  >> Currently anyone can start writing new LSM modules using name as identifier. But
  >> you are trying to forbid using name as identifier, and trying to force using integer
  >> as identifier, but that integer will not be provided unless new LSM modules get
  >> upstream.
  > 
  > That is correct.  In order to have a LSM identifier token the LSM must
  > be upstream.

at https://lkml.kernel.org/r/CAHC9VhT2Azg1F-G3RQ4xL7JgA3OAtHafzS1_nvUyEUFsCJ9+SA@mail.gmail.com ?

If in-tree kernel refuses to assign a token value, no new LSM module would be developed
in the open, for not-yet-in-tree code (in whatever stage) cannot use a token value for
registering into the LSM framework.

>                    I see no reason to trade off what I believe as a
> better API choice (LSM ID tokens) for something that is explicitly not
> supported by the Linux Kernel as a whole (out-of-tree kernel code).

And even if a "code is being developed in the open with the intention to be
submitted to be in-tree, and actually submitted for in-tree", we know that we
cannot accept all submitted LSM modules. LSM modules which were not accepted for
in-tree have to remain out-of-tree.

We don't make patches for out-of-tree code in order to catch up to upstream kernel
changes. But we didn't and must not try to forbid out-of-tree code to exist.

Although I'm not a fan of proprietary / closed source code, I have to resist
Casey's attempt to lock out out-of-tree code and new code.

> 
> Thank you for your comments, but I'm considering this settled.
> 

Never settled, unless you all promise that we shall assign a token value to whatever
LSM modules (regardless of whether that LSM module is already in-tree or not).

