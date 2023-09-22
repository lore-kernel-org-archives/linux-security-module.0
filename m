Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8728CCD4F5B
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Sep 2023 11:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbjIVLZk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 22 Sep 2023 07:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbjIVLZk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Sep 2023 07:25:40 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2112191
        for <linux-security-module@vger.kernel.org>; Fri, 22 Sep 2023 04:25:32 -0700 (PDT)
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 38MBPQGE017411;
        Fri, 22 Sep 2023 20:25:26 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Fri, 22 Sep 2023 20:25:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 38MBPQGe017408
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Sep 2023 20:25:26 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <dde20522-af01-c198-5872-b19ef378f286@I-love.SAKURA.ne.jp>
Date:   Fri, 22 Sep 2023 20:25:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/5] security: Count the LSMs enabled at compile time
Content-Language: en-US
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        Kui-Feng Lee <sinquersw@gmail.com>
References: <20230918212459.1937798-1-kpsingh@kernel.org>
 <20230918212459.1937798-3-kpsingh@kernel.org>
 <cb67f607-3a9d-34d2-0877-a3ff957da79e@I-love.SAKURA.ne.jp>
 <CACYkzJ5GFsgc3vzJXH34hgoTc+CEf+7rcktj0QGeQ5e8LobRcw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CACYkzJ5GFsgc3vzJXH34hgoTc+CEf+7rcktj0QGeQ5e8LobRcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/09/21 22:58, KP Singh wrote:
> On Thu, Sep 21, 2023 at 3:21 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> On 2023/09/19 6:24, KP Singh wrote:
>>> These macros are a clever trick to determine a count of the number of
>>> LSMs that are enabled in the config to ascertain the maximum number of
>>> static calls that need to be configured per LSM hook.
>>
>> As a LKM-based LSM user, indirect function calls using a linked list have
>> an advantage which this series kills. There always is a situation where a
> 
> 
>> LSM cannot be built into vmlinux (and hence has to be loaded as a LKM-based
>> LSM) due to distributor's support policy. Therefore, honestly speaking,
>> I don't want LSM infrastructure to define the maximum number of "slots" or
>> "static calls"...
>>
> 
> Yeah, LSMs are not meant to be used from a kernel module. The data
> structure is actually __ro_after_init. So, I am not even sure how you
> are using it in kernel modules (unless you are patching this out).
> And, if you are really patching stuff to get your out of tree LSMs to
> work, then you might as well add your "custom" LSM config here or just
> override this count.

I'm using LKM-based LSM with any version between 2.6.0 and 6.6-rc2, without patching
__ro_after_init out. We can load LKM-based LSMs, without patching the original kernel.
And it seems to me that several proprietary security products for Linux are using
this trick, for LSMs for such products cannot be built into distributor's kernels...

----------
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-6.6.0-rc2+ root=/dev/sda1 ro vconsole.keymap=jp106 vconsole.font=latarcyrheb-sun16 security=none sysrq_always_enabled console=ttyS0,115200n8 console=tty0 LANG=en_US.UTF-8 init=/sbin/akari-init
(...snipped...)
[  147.238458] AKARI: 1.0.48   2023/05/27
[  147.244867] Access Keeping And Regulating Instrument registered.
[  147.261232] Calling /sbin/ccs-init to load policy. Please wait.
239 domains. 11807 ACL entries.
1938 KB used by policy.
[  147.768694] CCSecurity: 1.8.9   2021/04/01
[  147.768740] Mandatory Access Control activated.
----------

> 
> The performance benefits here outweigh the need for a completely
> unsupported use case.

LKM-based LSMs are not officially supported since 2.6.24. But people need LKM-based LSMs.
It is very sad that the LSM community is trying to lock out out of tree LSMs
( https://lkml.kernel.org/r/ec37cd2f-24ee-3273-c253-58d480569117@I-love.SAKURA.ne.jp ).
The LSM interface is a common property for *all* Linux users.

I'm not objecting the performance benefits by replacing with static calls.
I'm not happy that the LSM community ignores the Torvald's comment at https://lkml.org/lkml/2007/10/1/192
and does not listen to minority's voices.

