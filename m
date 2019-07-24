Return-Path: <SRS0=855y=VV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF92C76186
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Jul 2019 03:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAEA227BF
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Jul 2019 03:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbfGXDTG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Jul 2019 23:19:06 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:51551 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfGXDTG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Jul 2019 23:19:06 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x6O3IhEK045162;
        Wed, 24 Jul 2019 12:18:43 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Wed, 24 Jul 2019 12:18:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x6O3IhVJ045159
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 24 Jul 2019 12:18:43 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: Reminder: 2 open syzbot bugs in "security/tomoyo" subsystem
To:     Eric Biggers <ebiggers@kernel.org>
References: <20190724024251.GF643@sol.localdomain>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Message-ID: <7800c28f-bf1c-56cd-c82e-b1ff174ccbc8@i-love.sakura.ne.jp>
Date:   Wed, 24 Jul 2019 12:18:47 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724024251.GF643@sol.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019/07/24 11:42, Eric Biggers wrote:
> --------------------------------------------------------------------------------
> Title:              KASAN: use-after-free Read in tomoyo_realpath_from_path
> Last occurred:      28 days ago
> Reported:           48 days ago
> Branches:           Mainline and others
> Dashboard link:     https://syzkaller.appspot.com/bug?id=73d590010454403d55164cca23bd0565b1eb3b74
> Original thread:    https://lkml.kernel.org/lkml/0000000000004f43fa058a97f4d3@google.com/T/#u

A patch is available, but I can't find a chance to setup my git tree for sending
a pull request for the patch.

> --------------------------------------------------------------------------------
> Title:              KASAN: invalid-free in tomoyo_realpath_from_path
> Last occurred:      57 days ago
> Reported:           56 days ago
> Branches:           net-next
> Dashboard link:     https://syzkaller.appspot.com/bug?id=e9e5a1d41c3fb5d0f79aeea0e4cd535f160a6702
> Original thread:    https://lkml.kernel.org/lkml/000000000000785e9d0589ec359a@google.com/T/#u

This cannot be a TOMOYO's bug. We are waiting for a reproducer but
no crash occurred since then. Maybe it is time to close as invalid.
