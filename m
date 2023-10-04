Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3126FE7B5E8
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Oct 2023 10:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjJDKtG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 4 Oct 2023 06:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjJDKtF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Oct 2023 06:49:05 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8167A1;
        Wed,  4 Oct 2023 03:49:01 -0700 (PDT)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 394Amoet011186;
        Wed, 4 Oct 2023 19:48:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Wed, 04 Oct 2023 19:48:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 394Amo2c011182
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 4 Oct 2023 19:48:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <80e720b6-3cae-ed56-bc7b-e3701b98f6b2@I-love.SAKURA.ne.jp>
Date:   Wed, 4 Oct 2023 19:48:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 1/2] LSM: Allow dynamically appendable LSM modules.
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
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
In-Reply-To: <36776914-189b-3f51-9b56-b4273a625005@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/10/04 19:40, Tetsuo Handa wrote:
> does not enable Smack/TOMOYO/AppArmor is "Smack/TOMOYO/AppArmor are not attractive".

does not enable Smack/TOMOYO/AppArmor is NOT "Smack/TOMOYO/AppArmor are not attractive".

