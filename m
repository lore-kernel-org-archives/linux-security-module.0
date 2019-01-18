Return-Path: <SRS0=wNUX=P2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336C1C07EBF
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Jan 2019 17:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10AB720850
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Jan 2019 17:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfARRRP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:17:15 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:52760 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbfARRRP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 18 Jan 2019 12:17:15 -0500
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0IHHAaH098390;
        Sat, 19 Jan 2019 02:17:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp);
 Sat, 19 Jan 2019 02:17:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0IHHASp098382
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 19 Jan 2019 02:17:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] tomoyo: Swicth from cred->security to
 task_struct->security.
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
References: <1547806711-13571-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <ae8a9cbb-bca6-f850-d4c4-6abe61a4d9bf@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c1455a86-2444-9e60-23be-a98a77f87fa5@i-love.sakura.ne.jp>
Date:   Sat, 19 Jan 2019 02:17:10 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <ae8a9cbb-bca6-f850-d4c4-6abe61a4d9bf@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019/01/19 2:01, Casey Schaufler wrote:
>> -/**
>> - * tomoyo_real_domain - Get "struct tomoyo_domain_info" for specified thread.
>> - *
>> - * @task: Pointer to "struct task_struct".
>> + * @task - Pointer to "struct task_struct".
>>   *
>>   * Returns pointer to "struct tomoyo_security" for specified thread.
>>   */
>> -static inline struct tomoyo_domain_info *tomoyo_real_domain(struct task_struct
>> -							    *task)
>> +static inline struct tomoyo_security *tomoyo_security(struct task_struct *task)
> 
> Could you use tomoyo_task() instead of tomoyo_security()?

Possible. But tomoyo_task() might be more confusing because it sounds like
"struct task_struct" when it actually returns "struct task_struct"->security.

Isn't tomoyo_task_security() better if I rename?

> To the extent that it's been possible I've worked to add
> consistency in the security modules, and this breaks it.

Do you want me to rename

/* Structure for "struct task_struct"->security. */
struct tomoyo_security {
	struct tomoyo_domain_info *domain_info;
	struct tomoyo_domain_info *old_domain_info;
};

to "struct tomoyo_task" or "struct tomoyo_task_security" as well?
