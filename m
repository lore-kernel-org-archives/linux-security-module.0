Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2524E784AF
	for <linux-security-module@archiver.kernel.org>; Mon,  2 Oct 2023 10:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbjJBKEg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 2 Oct 2023 06:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjJBKEe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 2 Oct 2023 06:04:34 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABDFA7
        for <linux-security-module@vger.kernel.org>; Mon,  2 Oct 2023 03:04:30 -0700 (PDT)
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 392A4SNN079265;
        Mon, 2 Oct 2023 19:04:28 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Mon, 02 Oct 2023 19:04:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 392A4RDD079262
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 2 Oct 2023 19:04:28 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <51d6c605-25cc-71fc-9c11-707b78297b38@I-love.SAKURA.ne.jp>
Date:   Mon, 2 Oct 2023 19:04:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 1/2] LSM: Allow dynamically appendable LSM modules.
Content-Language: en-US
To:     Kees Cook <kees@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Paul Moore <paul@paul-moore.com>, bpf <bpf@vger.kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
 <57295dac-9abd-3bac-ff5d-ccf064947162@schaufler-ca.com>
 <b2cd749e-a716-1a13-6550-44a232deac25@I-love.SAKURA.ne.jp>
 <06BC106C-E0FD-4ACA-83A8-DFD1400B696E@kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <06BC106C-E0FD-4ACA-83A8-DFD1400B696E@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/10/02 0:44, Kees Cook wrote:
> On October 1, 2023 4:31:05 AM PDT, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>> Kees Cook said there is no problem if the policy of assigning LSM ID value were
>>
>>  1) author: "Hello, here is a new LSM I'd like to upstream, here it is. I assigned
>>              it the next LSM ID."
>>     maintainer(s): "Okay, sounds good. *review*"
>>
>>  2) author: "Hello, here is an LSM that has been in active use at $Place,
>>              and we have $Xxx many userspace applications that we cannot easily
>>              rebuild. We used LSM ID $Value that is far away from the sequential
>>              list of LSM IDs, and we'd really prefer to keep that assignment."
>>    maintainer(s): "Okay, sounds good. *review*"
>>
>> and I agreed at https://lkml.kernel.org/r/6e1c25f5-b78c-8b4e-ddc3-484129c4c0ec@I-love.SAKURA.ne.jp .
>>
>> But Paul Moore's response was
>>
>>  No LSM ID value is guaranteed until it is present in a tagged release
>>  from Linus' tree, and once a LSM ID is present in a tagged release
>>  from Linus' tree it should not change.  That's *the* policy.
>>
>> which means that the policy is not what Kees Cook has said.
> 
> These don't conflict at all! Paul is saying an ID isn't guaranteed in upstream
> until it's in upstream. I'm saying the id space is large enough that you could
> make a new out of tree LSM every second for the next billion years. The upstream
> assignment process is likely sequential, but that out of sequence LSMs that show
> a need to be upstream could make a case for their existing value.

Excuse me? If the LSM community wants the assignment sequential, the LSM community
cannot admit the LSM value assigned to a not-yet-in-tree LSM.

If "Okay, sounds good." does not imply that the LSM community admits the LSM value
assigned to a not-yet-in-tree LSM, what did "Okay, sounds good." mean?

