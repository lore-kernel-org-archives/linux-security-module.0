Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1137C433E0
	for <linux-security-module@archiver.kernel.org>; Sat, 30 Jan 2021 09:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CE4E64DE2
	for <linux-security-module@archiver.kernel.org>; Sat, 30 Jan 2021 09:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhA3Jh7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 30 Jan 2021 04:37:59 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56219 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhA3DKA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 29 Jan 2021 22:10:00 -0500
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 10U2PK6q001042;
        Sat, 30 Jan 2021 11:25:20 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav301.sakura.ne.jp);
 Sat, 30 Jan 2021 11:25:20 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav301.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 10U2PJX8001039
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 30 Jan 2021 11:25:20 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: general protection fault in tomoyo_socket_sendmsg_permission
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+95ce4b142579611ef0a9@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzkaller-bugs@googlegroups.com
References: <000000000000647eff05b3f7e0d4@google.com>
 <20201113120055.11748-1-hdanton@sina.com>
 <5f71e0c1-d387-6d72-d8e4-edb11cf57f72@linuxfoundation.org>
 <ea4028b7-53f2-aeaf-76e7-69874efcdec5@I-love.SAKURA.ne.jp>
 <2b70d360-a293-4acb-ea6c-2badda5e8b8b@linuxfoundation.org>
 <9bdd3f10-bddb-bd87-d7ad-b4b706477006@i-love.sakura.ne.jp>
 <6b8da36f-a994-7604-77f4-52e29434605f@linuxfoundation.org>
 <5f9ec159-77d8-ffba-21d1-2810e059f998@i-love.sakura.ne.jp>
 <a06093f1-22b3-7d72-bc6c-f99f4e0d0de9@linuxfoundation.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <40617d66-1334-13a0-de9b-bd7cc1155ce5@i-love.sakura.ne.jp>
Date:   Sat, 30 Jan 2021 11:25:20 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <a06093f1-22b3-7d72-bc6c-f99f4e0d0de9@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2021/01/30 6:18, Shuah Khan wrote:
> In this console log:

It seems "this console log" refers to https://syzkaller.appspot.com/x/log.txt?x=10453034500000 .

> 
> 06:57:50 executing program 1:
> socketpair$tipc(0x1e, 0x2, 0x0, &(0x7f00000000c0)={<r0=>0xffffffffffffffff})
> sendmsg$BATADV_CMD_GET_TRANSTABLE_LOCAL(r0, &(0x7f00000002c0)={&(0x7f00000001c0), 0xc, &(0x7f0000000280)={0x0, 0xd001010000000000}}, 0x0)
> 
> [ 1151.090883][T23361] vhci_hcd vhci_hcd.0: pdev(4) rhport(0) sockfd(4)
> [ 1151.097445][T23361] vhci_hcd vhci_hcd.0: devid(0) speed(1) speed_str(low-speed)
> 06:57:50 executing program 0:
> r0 = syz_open_dev$binderN(&(0x7f0000000680)='/dev/binder#\x00', 0x0, 0x0)
> ioctl$BINDER_WRITE_READ(r0, 0xc0306201, &(0x7f0000000cc0)={0x88, 0x0, &(0x7f0000000b80)=[@transaction={0x40406300, {0x2, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}}, @transaction={0x40406300, {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}}], 0x0, 0x0, 0x0})
> 
> [ 1151.164402][T23363] vhci_hcd: connection closed
> [ 1151.167346][  T240] vhci_hcd: stop threads
> 
> 
> [ 1151.178329][T26761] usb 17-1: new low-speed USB device number 2 using vhci_hcd
> 
> 
> SK: Looking at the console log, it looks like while connection is being
>     torn down,

Excuse me, but it looks like (what comes here) while connection is being torn down ?
I'm not familiar with driver code.

> 
> 
> [ 1151.181245][  T240] vhci_hcd: release socket
> 
> 
> Can you share your your test code for this program:
> "executing program 1"

I don't think program 1 is relevant. I think program 4

  06:57:50 executing program 4:
  r0 = socket$tipc(0x1e, 0x2, 0x0)
  syz_usbip_server_init(0x1)
  close_range(r0, 0xffffffffffffffff, 0x0)

which calls syz_usbip_server_init() as with other duplicates is relevant.

> 
> Also your setup? Do you run usbip_host and vhci_hcd both?

Who are you referring to with "you/your" ? I'm not running syzkaller in my setup
and I don't have test code.

I'm just proposing printing more messages in order to confirm the ordering of
events and member values in structures.
