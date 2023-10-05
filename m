Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178D9E9270F
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Oct 2023 14:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbjJEOm0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 5 Oct 2023 10:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbjJEOgk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 Oct 2023 10:36:40 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EAE3F031
        for <linux-security-module@vger.kernel.org>; Thu,  5 Oct 2023 07:01:18 -0700 (PDT)
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 395DxTnc037452;
        Thu, 5 Oct 2023 22:59:29 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Thu, 05 Oct 2023 22:59:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 395DxSeT037448
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 5 Oct 2023 22:59:28 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9745237d-8cec-ce3b-1b3a-4068def7e3f4@I-love.SAKURA.ne.jp>
Date:   Thu, 5 Oct 2023 22:59:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 1/2] LSM: Allow dynamically appendable LSM modules.
Content-Language: en-US
To:     =?UTF-8?Q?Jos=c3=a9_Bollo?= <jobol@nonadev.net>,
        KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>, bpf <bpf@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
 <CACYkzJ5k7oYxFgWp9bz1Wmp3n6LcU39Mh-HXFWTKnZnpY-Ef7w@mail.gmail.com>
 <20231005114754.56c40a2f@d-jobol>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20231005114754.56c40a2f@d-jobol>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/10/05 18:47, José Bollo wrote:
>> Now, comes the question of whether we need dynamically loaded LSMs, I
>> am not in favor of this. Please share your limitations of BPF as you
>> mentioned and what's missing to implement dynamic LSMs. My question
>> still remains unanswered.
>>
>> Until I hear the real limitations of using BPF, it's a NAK from me.
> 
> Hi all,
> 
> I don't understand the reason why you want to enforce implementers to
> use your BPF?

Because if whatever LSM modules were implemented using BPF, we won't need
to support LKM-based LSM. Supporting LKM-based LSM is expected because
the LSM community cannot accept whatever LSMs and the Linux distributor
cannot accept whatever LSMs.

> 
> Even if it can do any possible thing that security implementer wants,
> why enforcing to use it? For experimenting? But then after successful
> experimentation the implementer must translate to real LSM and rewrite
> almost every thing.

Not for experimenting. The advantage of implementing an LSM module using
BPF is that we can load that LSM without making that LSM module in-tree (i.e.
accepted by the LSM community) and built-in (i.e. accepted by the Linux
distributor). That is, the implementer will not try to rewrite a BPF-based
LSM to non BPF-based LSM if the implementer succeed to write that LSM using BPF.

But remaining out-of-tree (i.e. not accepted by the LSM community) might have
disadvantage that the BPF-based LSM is not identified as a LSM because the LSM ID
value won't be assigned. (I don't know where BPF-based LSMs are located in the
kernel source tree. All BPF-based LSMs except trivial examples included in the
kernel source tree will remain out-of-tree ?)

> 
> And also why to use faty BPF for a tricky simple stuff?

