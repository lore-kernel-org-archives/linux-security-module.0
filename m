Return-Path: <SRS0=855y=VV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A599C7618B
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Jul 2019 04:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67B6218DA
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Jul 2019 04:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbfGXEyo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 24 Jul 2019 00:54:44 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60121 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfGXEyo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 24 Jul 2019 00:54:44 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x6O4sbbD035015;
        Wed, 24 Jul 2019 13:54:37 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Wed, 24 Jul 2019 13:54:37 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x6O4saC9035012
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 24 Jul 2019 13:54:37 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: Reminder: 2 open syzbot bugs in "security/tomoyo" subsystem
To:     Eric Biggers <ebiggers@kernel.org>
References: <20190724024251.GF643@sol.localdomain>
 <7800c28f-bf1c-56cd-c82e-b1ff174ccbc8@i-love.sakura.ne.jp>
 <20190724043450.GZ643@sol.localdomain>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Message-ID: <737a46de-cfb0-6220-c796-563ffd3ff325@i-love.sakura.ne.jp>
Date:   Wed, 24 Jul 2019 13:54:40 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724043450.GZ643@sol.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019/07/24 13:34, Eric Biggers wrote:
> On Wed, Jul 24, 2019 at 12:18:47PM +0900, Tetsuo Handa wrote:
>>> --------------------------------------------------------------------------------
>>> Title:              KASAN: invalid-free in tomoyo_realpath_from_path
>>> Last occurred:      57 days ago
>>> Reported:           56 days ago
>>> Branches:           net-next
>>> Dashboard link:     https://syzkaller.appspot.com/bug?id=e9e5a1d41c3fb5d0f79aeea0e4cd535f160a6702
>>> Original thread:    https://lkml.kernel.org/lkml/000000000000785e9d0589ec359a@google.com/T/#u
>>
>> This cannot be a TOMOYO's bug. We are waiting for a reproducer but
>> no crash occurred since then. Maybe it is time to close as invalid.
> 
> Maybe.  Did you check for stack buffer overflows in the functions that
> tomoyo_realpath_from_path() calls?  Perhaps something is corrupting the 'buf'
> variable in the parent's stack frame.
> 

What do you mean? If this crash were a stack buffer overflow, this crash
should have already occurred again.

Since the "buf" variable is a local variable, it cannot be shared between
two threads. Since "buf" is assigned as

  buf = kmalloc(buf_len, GFP_NOFS);

and nobody else is reassigning "buf",

  kfree(buf);

can't become an invalid free.
