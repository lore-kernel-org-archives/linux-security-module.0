Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12B0C433DB
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Mar 2021 01:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C30461992
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Mar 2021 01:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhCWBrP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Mar 2021 21:47:15 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54767 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhCWBrO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Mar 2021 21:47:14 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 12N1kuPx046795;
        Tue, 23 Mar 2021 10:46:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp);
 Tue, 23 Mar 2021 10:46:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 12N1kt3L046787
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 23 Mar 2021 10:46:55 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH 2/2] integrity: double check iint_cache was
 initialized
To:     Dmitry Vyukov <dvyukov@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
References: <20210319200358.22816-1-zohar@linux.ibm.com>
 <20210319200358.22816-2-zohar@linux.ibm.com>
 <8450c80a-104a-3f36-0963-0ae8fa69e0f2@i-love.sakura.ne.jp>
 <CACT4Y+bvakfNhVs29QvbY6Z8Pw0zmAUKGWM-DD5DcPZW5ny90A@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <1a2245c6-3cab-7085-83d3-55b083619303@i-love.sakura.ne.jp>
Date:   Tue, 23 Mar 2021 10:46:52 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bvakfNhVs29QvbY6Z8Pw0zmAUKGWM-DD5DcPZW5ny90A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2021/03/20 5:03, Mimi Zohar wrote:
> The integrity's "iint_cache" is initialized at security_init().  Only
> after an IMA policy is loaded, which is initialized at late_initcall,
> is a file's integrity status stored in the "iint_cache".
> 
> All integrity_inode_get() callers first verify that the IMA policy has
> been loaded, before calling it.  Yet for some reason, it is still being
> called, causing a NULL pointer dereference.
> 
> qemu-system-x86_64 (...snipped...) lsm=smack (...snipped...)

Hmm, why are you using lsm=smack instead of security=smack ?
Since use of lsm= overrides CONFIG_LSM="lockdown,yama,safesetid,integrity,tomoyo,smack,bpf" settings,
only smack is activated, which means that integrity_iintcache_init() will not be called by

  DEFINE_LSM(integrity) = {
  	.name = "integrity",
  	.init = integrity_iintcache_init,
  };

declaration. That's the reason iint_cache == NULL when integrity_inode_get() is called.

