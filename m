Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0CFEB64D9
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Jun 2023 10:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjF0KJn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Jun 2023 06:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjF0KJM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Jun 2023 06:09:12 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4E63593;
        Tue, 27 Jun 2023 03:07:07 -0700 (PDT)
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 35RA65lu033475;
        Tue, 27 Jun 2023 19:06:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Tue, 27 Jun 2023 19:06:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 35RA65wO033472
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 27 Jun 2023 19:06:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ecb32549-8b6f-4b8d-b832-4f86adb95183@I-love.SAKURA.ne.jp>
Date:   Tue, 27 Jun 2023 19:06:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [syzbot] [tomoyo?] [bpf?] INFO: rcu detected stall in
 security_file_open (6)
Content-Language: en-US
To:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
References: <0000000000001526c405ff196bc1@google.com>
Cc:     syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+bb11ad7bb33b56ca4d4b@syzkaller.appspotmail.com>,
        USB list <linux-usb@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000001526c405ff196bc1@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Ping?

How do you plan to avoid printk() flooding?

#syz dup: INFO: rcu detected stall in newfstatat (3)

On 2023/06/27 18:51, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8a28a0b6f1a1 Merge tag 'net-6.4-rc8' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1335a9db280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
> dashboard link: https://syzkaller.appspot.com/bug?extid=bb11ad7bb33b56ca4d4b
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16841cc0a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fc6e1f280000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/d02009a9822d/disk-8a28a0b6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f33ad4ef1182/vmlinux-8a28a0b6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f795a8ae7a8c/bzImage-8a28a0b6.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+bb11ad7bb33b56ca4d4b@syzkaller.appspotmail.com

