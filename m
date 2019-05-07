Return-Path: <SRS0=FAtl=TH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA1AC004C9
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 11:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AB2206BF
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 11:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfEGLiA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 May 2019 07:38:00 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50391 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfEGLiA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 May 2019 07:38:00 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x47BbuAw099281;
        Tue, 7 May 2019 20:37:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Tue, 07 May 2019 20:37:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x47Bbte1099275
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 7 May 2019 20:37:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Fwd: Re: kernel panic: MAC Initialization failed. (3)
References: <CACT4Y+bm4fSXLjR-JQ5nbVLsvFCLAH03yMG=-8mYpafLho-vRw@mail.gmail.com>
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
X-Forwarded-Message-Id: <CACT4Y+bm4fSXLjR-JQ5nbVLsvFCLAH03yMG=-8mYpafLho-vRw@mail.gmail.com>
Message-ID: <6ba09635-28ab-da1e-8b61-e675428362ac@i-love.sakura.ne.jp>
Date:   Tue, 7 May 2019 20:37:54 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bm4fSXLjR-JQ5nbVLsvFCLAH03yMG=-8mYpafLho-vRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

James, please include

  [PATCH] tomoyo: Don't emit WARNING: string while fuzzing testing.

before sending to linux.git .

Regards.

-------- Forwarded Message --------
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date: Thu, May 2, 2019 at 2:16 AM
To: Dmitry Vyukov
Cc: syzbot

> The commit for avoiding this problem was sent to linux-next.git .
> Please add CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING=y into
> kernel configs with CONFIG_SECURITY_TOMOYO=y.
>
>
>
> By the way, does syzbot stop upon encountering any "WARNING" string?
> If yes, I guess I need to change
>
>   pr_warn("WARNING: Domain '%s' has too many ACLs to hold. Stopped learning mode.\n",
>
> string in security/tomoyo/util.c because
> CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING enables learning mode.

Yes, syzkaller detects all "WARNING:" strings as kernel bug. There
does not seem to be a better way to detect kernel bugs.
I've tried to enable the config, but all instances indeed immediately
detected as bugged:

2019/05/07 13:11:37 vm-10: crash: WARNING: Domain '<kernel> /sbin/init
/etc/init.d/rc /sbin/startpar /etc/init.d/ssh /sbin/start-stop-daemon
/usr/sbin/ssh [corrupted]

So we will need to wait until removal of the "WARNING:" messages
reaches linux-next.
Perhaps we may skip printing this warning if
CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING is set.

