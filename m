Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1996DC6379D
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Nov 2020 12:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1E2A206E5
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Nov 2020 12:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgKYMZ7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 25 Nov 2020 07:25:59 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:59539 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbgKYMZ7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Nov 2020 07:25:59 -0500
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0APCPaGY003175;
        Wed, 25 Nov 2020 21:25:36 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp);
 Wed, 25 Nov 2020 21:25:36 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0APCPa0Z003171
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Nov 2020 21:25:36 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] tomoyo: Avoid potential null pointer access
To:     Zheng Zengkai <zhengzengkai@huawei.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org, serge@hallyn.com
References: <20201125121043.107662-1-zhengzengkai@huawei.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <cfc96d99-adff-6eb9-9685-422587830eb8@i-love.sakura.ne.jp>
Date:   Wed, 25 Nov 2020 21:25:37 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201125121043.107662-1-zhengzengkai@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello, Zheng.

Thank you for a patch, but I won't apply this patch.
Expected behavior is that tomoyo_warn_oom() is called
if tomoyo_memory_ok() is called with entry == NULL.

Adding __GFP_NOWARN might be OK, but returning without tomoyo_warn_oom() is NG.

On 2020/11/25 21:10, Zheng Zengkai wrote:
> Calls to kzalloc() should be null-checked in order to avoid
> any potential failures or unnecessary code execution.
> Fix this by adding null checks for _entry_ right after allocation.
> 
> Fixes: 57c2590fb7fd ("TOMOYO: Update profile structure")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>

Nacked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

> ---
>  security/tomoyo/common.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
> index 4bee32bfe16d..99b4fafcb100 100644
> --- a/security/tomoyo/common.c
> +++ b/security/tomoyo/common.c
> @@ -499,6 +499,8 @@ static struct tomoyo_profile *tomoyo_assign_profile
>  	if (ptr)
>  		return ptr;
>  	entry = kzalloc(sizeof(*entry), GFP_NOFS);
> +	if (!entry)
> +		return NULL;
>  	if (mutex_lock_interruptible(&tomoyo_policy_lock))
>  		goto out;
>  	ptr = ns->profile_ptr[profile];
> 

