Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F973C74A5B
	for <linux-security-module@archiver.kernel.org>; Sat, 18 Mar 2023 06:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCRGcR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 18 Mar 2023 02:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjCRGcP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 18 Mar 2023 02:32:15 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC14F6EB84
        for <linux-security-module@vger.kernel.org>; Fri, 17 Mar 2023 23:32:13 -0700 (PDT)
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 32I6WCpI059657;
        Sat, 18 Mar 2023 15:32:12 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Sat, 18 Mar 2023 15:32:12 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 32I6VvGj059592
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Mar 2023 15:32:12 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ce1f4f76-dc7a-2c68-c2ff-c7fc2e11e66e@I-love.SAKURA.ne.jp>
Date:   Sat, 18 Mar 2023 15:31:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: LOCK_DOWN_FORCE_INTEGRITY_FOR_FUZZING?
To:     Dmitry Vyukov <dvyukov@google.com>,
        Paul Moore <paul@paul-moore.com>, jmorris@namei.org,
        mjg59@srcf.ucam.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        nathanl@linux.ibm.com
Cc:     syzkaller <syzkaller@googlegroups.com>
References: <CACT4Y+Z-9KCgKwkktvdJwNJZxxeA1f74zkP7KD6c=OmKXxXfjw@mail.gmail.com>
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CACT4Y+Z-9KCgKwkktvdJwNJZxxeA1f74zkP7KD6c=OmKXxXfjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/03/14 19:02, Dmitry Vyukov wrote:
> At least for us it is OK if it can be enabled only via kernel config
> (no cmd line) and named accordingly
> (TEST_ONLY_DONT_ENABLE_IN_PRODUCTION).

3 years ago, there were several discussions on whether we can use build-time (i.e.
kernel config) options. There was a strong suggestion to use boot-time (i.e. kernel
command line) options for switching because Linux 5.6+ can handle very long kernel
command line using a boot-config file. 

  https://lkml.kernel.org/r/CAHk-=wiVQUo_RJAaivHU5MFdznNOX4GKgJH1xrFc83e9oLnuvQ@mail.gmail.com

But I think that the reality remains that build-time options is the better.
Since I think that syzbot/syzkaller got enough awareness and past record, maybe
it is time to retry persuading Linus about use of build-time options for fuzzing.

