Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC954C0032E
	for <linux-security-module@archiver.kernel.org>; Sat, 21 Oct 2023 12:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjJUMVS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 21 Oct 2023 08:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUMVR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 21 Oct 2023 08:21:17 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A07D7B;
        Sat, 21 Oct 2023 05:21:15 -0700 (PDT)
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 39LCL2s6088155;
        Sat, 21 Oct 2023 21:21:02 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Sat, 21 Oct 2023 21:21:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 39LCKoIx088106
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 21 Oct 2023 21:21:02 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9b006dfe-450e-4d73-8117-9625d2586dad@I-love.SAKURA.ne.jp>
Date:   Sat, 21 Oct 2023 21:21:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] LSM: Allow dynamically appendable LSM modules.
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Paul Moore <paul@paul-moore.com>, bpf <bpf@vger.kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
 <57295dac-9abd-3bac-ff5d-ccf064947162@schaufler-ca.com>
 <b2cd749e-a716-1a13-6550-44a232deac25@I-love.SAKURA.ne.jp>
 <1b9f0e3f-0ff3-5b2d-19fa-dfa83afab8a6@schaufler-ca.com>
 <36776914-189b-3f51-9b56-b4273a625005@I-love.SAKURA.ne.jp>
 <a47971c0-f692-4f48-92a0-4f15c73d05e7@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <a47971c0-f692-4f48-92a0-4f15c73d05e7@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/10/21 5:40, Casey Schaufler wrote:
>>> You can make something that will work. Whether you can sell it upstream will
>>> depend on any number of factors. But working code is always a great start.
>> Selling a code to the upstream is not sufficient for allowing end users to use
>> that code.
>>
>> For https://bugzilla.redhat.com/show_bug.cgi?id=542986 case, the reason that Red Hat
>> does not enable Smack/TOMOYO/AppArmor is NOT "Smack/TOMOYO/AppArmor are not attractive".
> 
> And YAMA is enabled because it *is* attractive to RedHat's support based business
> model. Even if we did have loadable LSM support I doubt RedHat would even consider
> enabling it. Their model is based on selling support.

I don't expect that Red Hat will enable other LSMs as soon as we made it possible to use
other LSMs via LKM. But making it possible to use other LSMs at user's own risk via LKM
(like device/filesystem drivers) is the first step towards enabling other LSMs.

Somebody other than Red Hat can establish a business model for supporting other LSMs. But
current situation (i.e. requiring replacement of vmlinux ) can not allow such somebody to
establish a business model for supporting other LSMs. What is important is "don't make
LKM-based LSMs conditional (e.g. don't require kernel config option to enable LKM-based
LSMs, unlike device/filesystem drivers can be loaded as long as CONFIG_MODULES=y ).

