Return-Path: <SRS0=FAtl=TH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7FAC004C9
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 20:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5540620656
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 20:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfEGUy2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 May 2019 16:54:28 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:51009 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbfEGUy2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 May 2019 16:54:28 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x47KsI4Z096284;
        Wed, 8 May 2019 05:54:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Wed, 08 May 2019 05:54:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x47KsAgr096217
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 8 May 2019 05:54:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] tomoyo: Don't emit WARNING: string while fuzzing testing.
To:     James Morris <jmorris@namei.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
References: <1557228862-9277-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <alpine.LRH.2.21.1905080244530.13589@namei.org>
 <CACT4Y+ZGMHbJjNfA_jO_KDVxaa6eVVkhxdyr-EkH3Umy8v_p_w@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <dd8ac53a-5e0e-59d8-1533-b1f211d230e8@i-love.sakura.ne.jp>
Date:   Wed, 8 May 2019 05:54:09 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZGMHbJjNfA_jO_KDVxaa6eVVkhxdyr-EkH3Umy8v_p_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Here is updated description.

Commit cff0e6c3ec3e6230 ("tomoyo: Add a kernel config option for fuzzing
testing.") enabled the learning mode, but syzkaller is detecting any
"WARNING:" string as a crash. Thus, disable TOMOYO's quota warning if
built for fuzzing testing.

On 2019/05/08 1:49, Dmitry Vyukov wrote:
> From: James Morris <jmorris@namei.org>
> Date: Tue, May 7, 2019 at 6:45 PM
> To: Tetsuo Handa
> Cc: <linux-security-module@vger.kernel.org>, Dmitry Vyukov
> 
>> On Tue, 7 May 2019, Tetsuo Handa wrote:
>>
>>> Commit cff0e6c3ec3e6230 ("tomoyo: Add a kernel config option for fuzzing
>>> testing.") enabled the learning mode, and syzbot started crashing by
>>> encountering this warning message. Disable this warning if built for
>>> fuzzing testing; otherwise syzbot can't start fuzzing testing.
>>
>> syzbot crashed? Sounds like a bug in syzbot which should be fixed rather
>> than this approach.
> 
> syzbot did not crash, it detected this as kernel crash.
> 
>>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>> Cc: Dmitry Vyukov <dvyukov@google.com>
>>> ---
>>>  security/tomoyo/util.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/security/tomoyo/util.c b/security/tomoyo/util.c
>>> index 0517cbd..52752e1 100644
>>> --- a/security/tomoyo/util.c
>>> +++ b/security/tomoyo/util.c
>>> @@ -1076,8 +1076,10 @@ bool tomoyo_domain_quota_is_ok(struct tomoyo_request_info *r)
>>>               domain->flags[TOMOYO_DIF_QUOTA_WARNED] = true;
>>>               /* r->granted = false; */
>>>               tomoyo_write_log(r, "%s", tomoyo_dif[TOMOYO_DIF_QUOTA_WARNED]);
>>> +#ifndef CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING
>>>               pr_warn("WARNING: Domain '%s' has too many ACLs to hold. Stopped learning mode.\n",
>>>                       domain->domainname->name);
>>> +#endif
>>>       }
>>>       return false;
>>>  }
>>>
>>
>> --
>> James Morris
>> <jmorris@namei.org>
>>
> 

