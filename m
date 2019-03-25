Return-Path: <SRS0=q+Rt=R4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E02C43381
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 21:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB68E205C9
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 21:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfCYVKJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:10:09 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:27338 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbfCYVKI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Mar 2019 17:10:08 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2PL9vVr012040;
        Tue, 26 Mar 2019 06:09:57 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Tue, 26 Mar 2019 06:09:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126094122116.bbtec.net [126.94.122.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2PL9vse012035
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 26 Mar 2019 06:09:57 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH] tomoyo: Add a kernel config option for fuzzing testing.
To:     James Morris <jmorris@namei.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+29569ed06425fcf67a95@syzkaller.appspotmail.com>,
        syzbot <syzbot+e1b8084e532b6ee7afab@syzkaller.appspotmail.com>
References: <1551362770-8655-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <alpine.LRH.2.21.1903130519440.27366@namei.org>
 <5b69c819-eed4-1825-9e67-fff1206e9e3f@i-love.sakura.ne.jp>
 <alpine.LRH.2.21.1903130821250.2172@namei.org>
 <8c586ed0-e9ee-a450-df06-3257cdf657ad@i-love.sakura.ne.jp>
 <CAHC9VhRMcdk5yAc0xoJ1nMfj7KAcktKmQ1GSYP2C4yRzqS9PFA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <eaa4d0fa-19eb-f876-9c54-5ccb8d13e1b7@I-love.SAKURA.ne.jp>
Date:   Tue, 26 Mar 2019 06:09:55 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRMcdk5yAc0xoJ1nMfj7KAcktKmQ1GSYP2C4yRzqS9PFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

James,

I think that nothing prevents this patch.

