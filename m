Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0106CC41513
	for <linux-security-module@archiver.kernel.org>; Sat,  5 Aug 2023 12:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjHEMtj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 5 Aug 2023 08:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHEMti (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 5 Aug 2023 08:49:38 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F18E68;
        Sat,  5 Aug 2023 05:49:36 -0700 (PDT)
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 375CnPNG060277;
        Sat, 5 Aug 2023 21:49:26 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Sat, 05 Aug 2023 21:49:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 375CnP1d060274
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 5 Aug 2023 21:49:25 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6e480cac-6273-01e7-e6b9-03ade2f25280@I-love.SAKURA.ne.jp>
Date:   Sat, 5 Aug 2023 21:49:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] tomoyo: refactor deprecated strncpy
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20230803-security-tomoyo-v1-1-c53a17908d2f@google.com>
 <202308040039.D9B575B3F@keescook>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <202308040039.D9B575B3F@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Thank you.

Applied to https://scm.osdn.net/gitroot/tomoyo/tomoyo-test1.git . 

On 2023/08/04 16:40, Kees Cook wrote:
> On Thu, Aug 03, 2023 at 09:33:44PM +0000, Justin Stitt wrote:
>> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
>>
>> A suitable replacement is `strscpy` [2] due to the fact that it
>> guarantees NUL-termination on its destination buffer argument which is
>> _not_ the case for `strncpy`!
>>
>> It should be noted that the destination buffer is zero-initialized and
>> had a max length of `sizeof(dest) - 1`. There is likely _not_ a bug
>> present in the current implementation. However, by switching to
>> `strscpy` we get the benefit of no longer needing the `- 1`'s from the
>> string copy invocations on top of `strscpy` being a safer interface all
>> together.
>>
>> [1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
>> [2]: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
>>
>> Link: https://github.com/KSPP/linux/issues/90
>> Cc: linux-hardening@vger.kernel.org
>> Signed-off-by: Justin Stitt <justinstitt@google.com>
> 
> Thanks! This looks correct to me.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

