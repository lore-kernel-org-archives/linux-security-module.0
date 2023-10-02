Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3F2E7849A
	for <linux-security-module@archiver.kernel.org>; Mon,  2 Oct 2023 10:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbjJBK4v (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 2 Oct 2023 06:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236520AbjJBK4u (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 2 Oct 2023 06:56:50 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65847BF
        for <linux-security-module@vger.kernel.org>; Mon,  2 Oct 2023 03:56:46 -0700 (PDT)
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 392AuiCr096873;
        Mon, 2 Oct 2023 19:56:44 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Mon, 02 Oct 2023 19:56:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 392AuigO096870
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 2 Oct 2023 19:56:44 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f739db5c-7d76-7a86-c4b5-794eeffd6a2d@I-love.SAKURA.ne.jp>
Date:   Mon, 2 Oct 2023 19:56:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/5] security: Count the LSMs enabled at compile time
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, keescook@chromium.org, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org,
        Kui-Feng Lee <sinquersw@gmail.com>
References: <20230918212459.1937798-1-kpsingh@kernel.org>
 <20230918212459.1937798-3-kpsingh@kernel.org>
 <cb67f607-3a9d-34d2-0877-a3ff957da79e@I-love.SAKURA.ne.jp>
 <CACYkzJ5GFsgc3vzJXH34hgoTc+CEf+7rcktj0QGeQ5e8LobRcw@mail.gmail.com>
 <dde20522-af01-c198-5872-b19ef378f286@I-love.SAKURA.ne.jp>
 <CACYkzJ5M0Bw9S_mkFkjR_-bRsKryXh2LKiurjMX9WW-d0Mr6bg@mail.gmail.com>
 <ed785c86-a1d8-caff-c629-f8a50549e05b@I-love.SAKURA.ne.jp>
 <CACYkzJ4TLCMFEa5h-iEVC-58cakjduw44c-ct64SgBe0_jFKuQ@mail.gmail.com>
 <6a80711e-edc4-9fab-6749-f1efa9e4231e@I-love.SAKURA.ne.jp>
 <CACYkzJ4AGRcqLPqWY65OC778EPaUwTBpyOMfiVBXa4EmnHTXGQ@mail.gmail.com>
 <c1683052-aa5a-e0d5-25ae-40316273ed1b@I-love.SAKURA.ne.jp>
 <d9765991-45bb-ba9a-18d4-d29eab3e29b9@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <d9765991-45bb-ba9a-18d4-d29eab3e29b9@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/10/02 0:00, Casey Schaufler wrote:
> On 10/1/2023 3:51 AM, Tetsuo Handa wrote:
>> On 2023/09/25 20:22, KP Singh wrote:
>>>> It is Casey's commitment that the LSM infrastructure will not forbid LKM-based LSMs.
>>>> We will start allowing LKM-based LSMs. But it is not clear how we can make it possible to
>>>> allow LKM-based LSMs.
>>> I think this needs to be discussed if and when we allow LKM based LSMs.
>> It is *now* (i.e. before your proposal is accepted) that we need to discuss.
>>
>>> One needs to know MAX_LSM_COUNT at compile time (not via kernel
>>> command line), I really suggest you try out your suggestions before
>>> posting them. I had explained this to you earlier, you still chose to
>>> ignore and keep suggesting stuff that does not work.
>> Your proposal needs to know MAX_LSM_COUNT at compile time, that's why
>> we need to discuss now.
>>
>>> We will see when this happens. I don't think it's a difficult problem
>>> and there are many ways to implement this:
>>>
>>> * Add a new slot(s) for modular LSMs (One can add up to N fast modular LSMs)
>>> * Fallback to a linked list for modular LSMs, that's not a complexity.
>>> There are serious performance gains and I think it's a fair trade-off.
>>> This isn't even complex.
>> That won't help at all.
> 
> This is exactly the solution I have been contemplating since this
> discussion began. It will address the bulk of the issue. I'm almost
> mad/crazy enough to produce the patch to demonstrate it. Almost.

Yes, please show us one. I'm fine if the mechanism which allows LKM-based LSMs
cannot be disabled via the kernel configuration options.

I really want a commitment that none of the LSM community objects revival of
LKM-based LSMs. I'm worrying that some of the LSM community objects revival of
LKM-based LSMs because adding extra slots and/or linked list is e.g. an overhead,
increases attack surface etc.

Let's consider the Microsoft Windows operating system. Many security vendors are
offering security software which can run without recompiling the Windows OS.

But what about Linux? Security vendors cannot trivially add a security mechanism
because LKM-based LSMs are not supported since 2.6.24. As a result, some chose
hijacking LSM hooks, and others chose overwriting system call tables.

The Linux kernel is there for providing what the user needs. What about the LSM
infrastructure? The LSM infrastructure is too much evolving towards in-tree and
built-in security mechanisms.

The consequence of such evolving will be "Limited Security Modes" where users cannot
use what they need. New ideas cannot be easily tried if rebuild of vmlinux is
inevitable, which will also prevent a breath of fresh ideas from reaching the LSM
community.

Never "discussed *if* we allow LKM based LSMs", for the LSM community cannot
afford accepting whatever LSMs and the Linux distributors cannot afford enabling
whatever LSMs.

I'm not speaking for the security vendors. I'm speaking from the point of view of
minority/out-of-tree users.

> There are still a bunch of details (e.g. shared blobs) that it doesn't
> address. On the other hand, your memory management magic doesn't
> address those issues either.

Security is always trial-and-error. Just give all Linux users chances to continue
trial-and-error. You don't need to forbid LKM-based LSMs just because blob management
is not addressed. Please open the LSM infrastructure to anyone.

