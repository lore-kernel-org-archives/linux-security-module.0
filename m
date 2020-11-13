Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2A8C388F7
	for <linux-security-module@archiver.kernel.org>; Fri, 13 Nov 2020 10:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EDBE207DE
	for <linux-security-module@archiver.kernel.org>; Fri, 13 Nov 2020 10:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgKMKuO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 13 Nov 2020 05:50:14 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:53122 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKMKuN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Nov 2020 05:50:13 -0500
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0ADAo0r7031485;
        Fri, 13 Nov 2020 19:50:00 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp);
 Fri, 13 Nov 2020 19:50:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0ADAo0bh031480
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 13 Nov 2020 19:50:00 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: general protection fault in tomoyo_socket_sendmsg_permission
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>
References: <000000000000647eff05b3f7e0d4@google.com>
Cc:     syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+95ce4b142579611ef0a9@syzkaller.appspotmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <2dd4a96c-991f-3fb6-744d-28cd308b91cf@i-love.sakura.ne.jp>
Date:   Fri, 13 Nov 2020 19:49:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <000000000000647eff05b3f7e0d4@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

syzbot reported that LSM module which inspects "struct socket"->sk experiences
NULL pointer dereference because vdev->ud.tcp_socket was set to NULL while
vdev->ud.tcp_tx kernel thread is still running.
Is serialization between attach_store() and vhci_shutdown_connection() correct?

[ 1151.164402][T23363] vhci_hcd: connection closed
[ 1151.167346][  T240] vhci_hcd: stop threads
[ 1151.178329][T26761] usb 17-1: new low-speed USB device number 2 using vhci_hcd
[ 1151.181245][  T240] vhci_hcd: release socket
[ 1151.195480][T23364] general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
[ 1151.207194][T23364] KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
[ 1151.215600][T23364] CPU: 0 PID: 23364 Comm: vhci_tx Not tainted 5.10.0-rc2-syzkaller #0
[ 1151.223740][T23364] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[ 1151.233909][T23364] RIP: 0010:tomoyo_socket_sendmsg_permission+0x80/0x340
[ 1151.240845][T23364] Code: c7 40 0c f3 f3 f3 f3 65 48 8b 04 25 28 00 00 00 48 89 84 24 a0 00 00 00 31 c0 e8 0b 70 f1 fd 48 8d 7d 18 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 7d 02 00 00 48 b8 00 00 00 00 00 fc ff df 4c
[ 1151.260448][T23364] RSP: 0018:ffffc90016f77ad0 EFLAGS: 00010206
[ 1151.260802][  T240] vhci_hcd: disconnect device

static void vhci_shutdown_connection(struct usbip_device *ud)
{
	struct vhci_device *vdev = container_of(ud, struct vhci_device, ud);

	/* need this? see stub_dev.c */
	if (ud->tcp_socket) {
		pr_debug("shutdown tcp_socket %d\n", ud->sockfd);
		kernel_sock_shutdown(ud->tcp_socket, SHUT_RDWR);
	}

	/* kill threads related to this sdev */
	if (vdev->ud.tcp_rx) {
		kthread_stop_put(vdev->ud.tcp_rx);
		vdev->ud.tcp_rx = NULL;
	}
	if (vdev->ud.tcp_tx) {
		kthread_stop_put(vdev->ud.tcp_tx);
		vdev->ud.tcp_tx = NULL;
	}
	pr_info("stop threads\n");

	/* active connection is closed */
	if (vdev->ud.tcp_socket) {
		sockfd_put(vdev->ud.tcp_socket);
		vdev->ud.tcp_socket = NULL;
		vdev->ud.sockfd = -1;
	}
	pr_info("release socket\n");

On 2020/11/13 16:21, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9dbc1c03 Merge tag 'xfs-5.10-fixes-3' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10453034500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1735b7978b1c3721
> dashboard link: https://syzkaller.appspot.com/bug?extid=95ce4b142579611ef0a9
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+95ce4b142579611ef0a9@syzkaller.appspotmail.com
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
> CPU: 0 PID: 23364 Comm: vhci_tx Not tainted 5.10.0-rc2-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:tomoyo_socket_sendmsg_permission+0x80/0x340 security/tomoyo/network.c:762
> Code: c7 40 0c f3 f3 f3 f3 65 48 8b 04 25 28 00 00 00 48 89 84 24 a0 00 00 00 31 c0 e8 0b 70 f1 fd 48 8d 7d 18 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 7d 02 00 00 48 b8 00 00 00 00 00 fc ff df 4c
> RSP: 0018:ffffc90016f77ad0 EFLAGS: 00010206
> RAX: 0000000000000003 RBX: 1ffff92002deef5b RCX: ffffffff83b3789e
> RDX: ffff8880186c8000 RSI: ffffffff837e9945 RDI: 0000000000000018
> RBP: 0000000000000000 R08: 0000000000000030 R09: ffffc90016f77d97
> R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
> R13: ffffc90016f77ce8 R14: ffffc90016f77ce8 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000562623b70868 CR3: 000000002af19000 CR4: 00000000001526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  security_socket_sendmsg+0x50/0xb0 security/security.c:2140
>  sock_sendmsg+0x3f/0x120 net/socket.c:668
>  vhci_send_cmd_submit+0x897/0xf90 drivers/usb/usbip/vhci_tx.c:139
>  vhci_tx_loop+0xfc/0x370 drivers/usb/usbip/vhci_tx.c:241
>  kthread+0x3af/0x4a0 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
> Modules linked in:
> ---[ end trace 535369ec3e6ef304 ]---
> RIP: 0010:tomoyo_socket_sendmsg_permission+0x80/0x340 security/tomoyo/network.c:762
> Code: c7 40 0c f3 f3 f3 f3 65 48 8b 04 25 28 00 00 00 48 89 84 24 a0 00 00 00 31 c0 e8 0b 70 f1 fd 48 8d 7d 18 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 7d 02 00 00 48 b8 00 00 00 00 00 fc ff df 4c
> RSP: 0018:ffffc90016f77ad0 EFLAGS: 00010206
> RAX: 0000000000000003 RBX: 1ffff92002deef5b RCX: ffffffff83b3789e
> RDX: ffff8880186c8000 RSI: ffffffff837e9945 RDI: 0000000000000018
> RBP: 0000000000000000 R08: 0000000000000030 R09: ffffc90016f77d97
> R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
> R13: ffffc90016f77ce8 R14: ffffc90016f77ce8 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f0c3a930740 CR3: 000000002af19000 CR4: 00000000001526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 

