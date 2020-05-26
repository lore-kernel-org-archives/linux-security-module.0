Return-Path: <SRS0=6tJK=7I=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F39C433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 26 May 2020 12:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EBFA204EF
	for <linux-security-module@archiver.kernel.org>; Tue, 26 May 2020 12:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgEZM6z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 May 2020 08:58:55 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53700 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbgEZM6z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 May 2020 08:58:55 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04QCwSiC030868;
        Tue, 26 May 2020 21:58:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp);
 Tue, 26 May 2020 21:58:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04QCwS9W030864
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 26 May 2020 21:58:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: general protection fault in tomoyo_check_acl
To:     syzbot <syzbot+cff8c4c75acd8c6fb842@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <000000000000e9f3e705a684ef9a@google.com>
Cc:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <fcbc5905-e507-6002-f5b2-95335c3d0083@i-love.sakura.ne.jp>
Date:   Tue, 26 May 2020 21:58:29 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <000000000000e9f3e705a684ef9a@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2020/05/26 12:46, syzbot wrote:
> general protection fault, probably for non-canonical address 0xe000026660000003: 0000 [#1] PREEMPT SMP KASAN
> KASAN: probably user-memory-access in range [0x0000333300000018-0x000033330000001f]
> CPU: 0 PID: 12489 Comm: systemd-rfkill Not tainted 5.7.0-rc6-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:tomoyo_check_acl+0xa9/0x3e0 security/tomoyo/domain.c:173

struct tomoyo_acl_info *ptr == 0x0000333300000000 is strange; such pointer
can't be linked into standard doubly linked list using list_add_tail_rcu().
Thus, this report would to be an victim of memory corruption.
