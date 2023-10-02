Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776EBE784B8
	for <linux-security-module@archiver.kernel.org>; Mon,  2 Oct 2023 14:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbjJBOfK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 2 Oct 2023 10:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237810AbjJBOfC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 2 Oct 2023 10:35:02 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C52BD
        for <linux-security-module@vger.kernel.org>; Mon,  2 Oct 2023 07:34:56 -0700 (PDT)
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 392EYtHl047040;
        Mon, 2 Oct 2023 23:34:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Mon, 02 Oct 2023 23:34:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 392EYtSw047032
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 2 Oct 2023 23:34:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <29ada58d-29e1-14ef-a59e-1d099c1dd301@I-love.SAKURA.ne.jp>
Date:   Mon, 2 Oct 2023 23:34:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/5] security: Count the LSMs enabled at compile time
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, keescook@chromium.org, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org,
        Kui-Feng Lee <sinquersw@gmail.com>,
        KP Singh <kpsingh@kernel.org>
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
 <f739db5c-7d76-7a86-c4b5-794eeffd6a2d@I-love.SAKURA.ne.jp>
In-Reply-To: <f739db5c-7d76-7a86-c4b5-794eeffd6a2d@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/10/02 19:56, Tetsuo Handa wrote:
>> This is exactly the solution I have been contemplating since this
>> discussion began. It will address the bulk of the issue. I'm almost
>> mad/crazy enough to produce the patch to demonstrate it. Almost.
> 
> Yes, please show us one.

If "[PATCH v15 01/11] LSM: Identify modules by more than name" does not allow LKM-based
LSMs (which are likely out-of-tree) to have stable LSM ID values, lsm_list_modules()
provided by "[PATCH v15 05/11] LSM: Create lsm_list_modules system call" cannot report
stable string names. And "[PATCH v15 11/11] LSM: selftests for Linux Security Module
syscalls" cannot work on LKM-based LSMs.

Then, how are LKM-based LSMs activated? LKM-based LSMs can use LSM hooks but cannot use
(or show up in) lsm_get_self_attr()/lsm_set_self_attr()/lsm_list_modules() syscalls?
That looks quite strange, for the title of "[PATCH v15 01/11]" is not "LSM: Identify only
built-in and in-tree modules by more than name".

If you think about allowing LKM-based LSMs a bit, you will find that how can the current policy
be compatible. We cannot introduce lsm_get_self_attr()/lsm_set_self_attr()/lsm_list_modules()
syscalls without admitting stable LSM ID values being assigned to any publicly available LSMs.

Simple notification to the LSM community has to be the only requirement for assigning
stable LSM ID values. You should not distinguish in-tree and not-in-tree LSMs regarding
"[PATCH v15 00/11] LSM: Three basic syscalls". Otherwise, the attempt to introduce these
syscalls is a regression that will harm LKM-based LSMs.

