Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5ADC4332F
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Nov 2023 10:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346659AbjKBKaJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Nov 2023 06:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346112AbjKBKaI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Nov 2023 06:30:08 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE5F13A
        for <linux-security-module@vger.kernel.org>; Thu,  2 Nov 2023 03:30:04 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3A2AU3gr097599;
        Thu, 2 Nov 2023 19:30:03 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Thu, 02 Nov 2023 19:30:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3A2AU3Hh097595
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Nov 2023 19:30:03 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <cdd87907-e75a-46fd-884f-29fc07f62c32@I-love.SAKURA.ne.jp>
Date:   Thu, 2 Nov 2023 19:30:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/5] Reduce overhead of LSMs with static calls
Content-Language: en-US
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        renauld@google.com, pabeni@redhat.com
References: <20231102005521.346983-1-kpsingh@kernel.org>
 <b0186178-0338-4db1-9065-b6bbda10d58f@I-love.SAKURA.ne.jp>
 <CACYkzJ48EOFEgeWyX=mTwPhZk2Wb=LzngPGCo8Hn=KoBcgCJHg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CACYkzJ48EOFEgeWyX=mTwPhZk2Wb=LzngPGCo8Hn=KoBcgCJHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/11/02 19:01, KP Singh wrote:
> On Thu, Nov 2, 2023 at 10:42 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> I didn't get your response on https://lkml.kernel.org/r/c588ca5d-c343-4ea2-a1f1-4efe67ebb8e3@I-love.SAKURA.ne.jp .
>>
>> Do you agree that we cannot replace LKM-based LSMs with eBPF-based access control mechanisms,
>> and do you admit that this series makes LKM-based LSMs more difficult to use?
> 
> If you want to do a proper in-tree version of dynamic LSMs. There can
> be an exported symbol that allocates a dynamic slot and registers LSM
> hooks to it. This is very doable, but it's not my use case so, I am
> not going to do it.
> 
> No it does not make LKM based LSMs difficult to use. I am not ready to
> have that debate again.  I suggested multiple extensions in my replies
> which you chose to ignore.

You said

  I think this needs to be discussed if and when we allow LKM based LSMs."

as a response to

  It is Casey's commitment that the LSM infrastructure will not forbid LKM-based LSMs.
  We will start allowing LKM-based LSMs. But it is not clear how we can make it possible to
  allow LKM-based LSMs.

, and you suggested combination of static calls (for built-in LSMs) and
linked list (for LKM-based LSMs).

So, what is your answer to

  Until I hear the real limitations of using BPF, it's a NAK from me.

? Do you agree to allow dynamically appendable LSM modules?

