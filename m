Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F60F1E0DF7
	for <linux-security-module@vger.kernel.org>; Thu, 17 Oct 2024 20:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196622; cv=none; b=fog7AQTuTboEUccXmF4XAp5kHz0khVvg6nrVqJqSkGeDy4N5ajSq2jJIN74Kl9wdNCGXthnyZQTgV2uTbTwR1zbOYVnXqoiSGk8JNRutvcsl5SXdIcK+shzcNqxrhPGogPW65wfDP3/6mGGZz1AwaRG4/F2pxk+X/w0ezEyfsLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196622; c=relaxed/simple;
	bh=hcsE0LiOTegajmlJXAhGOfNg+xOWr/Ev+60+fHhm2k0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ia8CYMqXTobhDWPkegXlXwoDZoX5HY/1lDO6JiaSVwcjdCcJy/5KrIWkZ2R/7apJcacjzzLhi921Ad7P47g3zbidGCXfMopiIhAh6IBcGY7fZmb4ejDr1DAAZxykKnjVTH3vfLLMW76YUtsR3xxtNB2ajhGcnBi3V1Z6N2rZL7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3cc9fa12dso11113615ab.1
        for <linux-security-module@vger.kernel.org>; Thu, 17 Oct 2024 13:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729196617; x=1729801417;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CxbiwOteHWPoPbxM5rsq2oZhAuu4aEAjoIm7YkNQfrI=;
        b=q3m9cIEQ8ds/cYATeKXppzZVPg7raofkBT3oCvcCvdizKZsFOuNeDiMtUvRrF/yuDM
         YNkltb7i3TNOpc2UwieyL+muvCuxqWQ46A/2MFQD8HDW5xNMf0oI9nun0eW+MIf5Jy55
         k3jbkJAp28nGMYH54SubWAclJQH7l5xQLbdmAiC1n9sHlJL/UfPE4tiYjJbRHapXmhJ3
         j6vOlJp+a+kLCwUHEUSliXHkVsN7JDIE8TU6SQo1RGDw1nMYgFeOUVF6fao92p/VViMi
         aIyX56D9nLNysi5RQIEjwAu3mcKsx2ZN+xzKwufGlCiE/q7WsEJWK1cqoyhlVkRKuVLe
         0B6g==
X-Forwarded-Encrypted: i=1; AJvYcCWqs8UeIX/tLCrnavr2HPYxm7jzdwkRl8iRxIzP7/huv0u/Ul1JS+L1flecnI/+HKhueBf7mXVaIeqZoWYUcLpdWvkxws0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyUYEbZo+68ZM5fsz8JdFk3L7zZ2A7rPVaB1boxZINBY3MZPEh
	GKMozhnV1/9DPHmFPIGaML88ilozHMcjZxWgAMFna8bUHu8UIZ+DEWc7vYF9iki2Qz7lqD0xvoP
	bMmDCVzetzTBVb4aSvTO9/zmWcFPd4M71td3L8TJ0wMp8hBUeqEFCvoY=
X-Google-Smtp-Source: AGHT+IG6APDy/4ShZRU+McqwBzAlybwz0GR99v3xihi+KjcHEIPiiocZqDS/1pox5s8QSCq9WDC3vRnV3gkskwVZTlgkBcsgQDom
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4f:0:b0:3a0:909c:812d with SMTP id
 e9e14a558f8ab-3a3f406242fmr697665ab.11.1729196617182; Thu, 17 Oct 2024
 13:23:37 -0700 (PDT)
Date: Thu, 17 Oct 2024 13:23:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67117249.050a0220.10f4f4.0002.GAE@google.com>
Subject: [syzbot] [apparmor?] KASAN: slab-use-after-free Read in apparmor_sk_free_security
From: syzbot <syzbot+e8ffa1bcc1cc3240f4de@syzkaller.appspotmail.com>
To: apparmor@lists.ubuntu.com, jmorris@namei.org, john.johansen@canonical.com, 
	john@apparmor.net, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    36c254515dc6 Merge tag 'powerpc-6.12-4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1330ffd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=667b897270c8ae6
dashboard link: https://syzkaller.appspot.com/bug?extid=e8ffa1bcc1cc3240f4de
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-36c25451.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0a357f9d2448/vmlinux-36c25451.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fba8311d450b/bzImage-36c25451.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e8ffa1bcc1cc3240f4de@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in apparmor_sk_free_security+0x19a/0x1a0 security/apparmor/lsm.c:1065
Read of size 8 at addr ffff888000847780 by task ksoftirqd/3/34

CPU: 3 UID: 0 PID: 34 Comm: ksoftirqd/3 Not tainted 6.12.0-rc2-syzkaller-00307-g36c254515dc6 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 apparmor_sk_free_security+0x19a/0x1a0 security/apparmor/lsm.c:1065
 security_sk_free+0xd7/0x1a0 security/security.c:4842
 sk_prot_free net/core/sock.c:2196 [inline]
 __sk_destruct+0x44b/0x720 net/core/sock.c:2292
 sk_destruct+0xc2/0xf0 net/core/sock.c:2307
 __sk_free+0xf4/0x3e0 net/core/sock.c:2318
 sk_free+0x6a/0x90 net/core/sock.c:2329
 deferred_put_nlk_sk+0x13f/0x2d0 net/netlink/af_netlink.c:740
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0x79d/0x14d0 kernel/rcu/tree.c:2823
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
 run_ksoftirqd kernel/softirq.c:927 [inline]
 run_ksoftirqd+0x3a/0x60 kernel/softirq.c:919
 smpboot_thread_fn+0x661/0xa30 kernel/smpboot.c:164
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 4839:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x1e8/0x410 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 lsm_blob_alloc+0x68/0x90 security/security.c:685
 lsm_sock_alloc security/security.c:4808 [inline]
 security_sk_alloc+0x30/0x270 security/security.c:4824
 sk_prot_alloc+0x1c7/0x2a0 net/core/sock.c:2167
 sk_alloc+0x36/0xb90 net/core/sock.c:2217
 __netlink_create+0x5e/0x2c0 net/netlink/af_netlink.c:646
 netlink_create+0x3a4/0x630 net/netlink/af_netlink.c:704
 __sock_create+0x32e/0x840 net/socket.c:1576
 sock_create net/socket.c:1632 [inline]
 __sys_socket_create net/socket.c:1669 [inline]
 __sys_socket+0x14f/0x260 net/socket.c:1716
 __do_sys_socket net/socket.c:1730 [inline]
 __se_sys_socket net/socket.c:1728 [inline]
 __x64_sys_socket+0x72/0xb0 net/socket.c:1728
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888000847780
 which belongs to the cache kmalloc-16 of size 16
The buggy address is located 0 bytes inside of
 freed 16-byte region [ffff888000847780, ffff888000847790)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880008479e0 pfn:0x847
flags: 0x7ff00000000200(workingset|node=0|zone=0|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 007ff00000000200 ffff88801ac42640 ffffea0000856f10 ffffea0000870d90
raw: ffff8880008479e0 000000000080007e 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5351, tgid 5351 (syz-executor), ts 41291513004, free_ts 41219292639
 create_dummy_stack mm/page_owner.c:94 [inline]
 register_dummy_stack+0x8a/0xd0 mm/page_owner.c:100
 init_page_owner+0x48/0xe40 mm/page_owner.c:118
 invoke_init_callbacks mm/page_ext.c:148 [inline]
 page_ext_init+0x6b8/0xab0 mm/page_ext.c:497
 mm_core_init+0x12d/0x220 mm/mm_init.c:2667
page last free pid 5341 tgid 5341 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
 skb_free_frag include/linux/skbuff.h:3399 [inline]
 skb_free_head+0xa0/0x1d0 net/core/skbuff.c:1096
 skb_release_data+0x560/0x730 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 __kfree_skb net/core/skbuff.c:1204 [inline]
 sk_skb_reason_drop+0x129/0x1a0 net/core/skbuff.c:1242
 kfree_skb_reason include/linux/skbuff.h:1262 [inline]
 kfree_skb include/linux/skbuff.h:1271 [inline]
 napi_free_frags include/linux/netdevice.h:3893 [inline]
 napi_get_frags_check+0x58/0xb0 net/core/skbuff.c:306
 netif_napi_add_weight+0x538/0xab0 net/core/dev.c:6672
 netif_napi_add include/linux/netdevice.h:2638 [inline]
 nsim_init_napi drivers/net/netdevsim/netdev.c:392 [inline]
 nsim_open+0x149/0x7b0 drivers/net/netdevsim/netdev.c:435
 __dev_open+0x2d4/0x4e0 net/core/dev.c:1476
 __dev_change_flags+0x561/0x720 net/core/dev.c:8841
 dev_change_flags+0x8f/0x160 net/core/dev.c:8913
 do_setlink+0x19dd/0x3ee0 net/core/rtnetlink.c:2929
 __rtnl_newlink+0xc3a/0x1920 net/core/rtnetlink.c:3725
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3772
 rtnetlink_rcv_msg+0x3c7/0xea0 net/core/rtnetlink.c:6675
 netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2551
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357

Memory state around the buggy address:
 ffff888000847680: 00 00 fc fc 00 00 fc fc 00 00 fc fc 00 00 fc fc
 ffff888000847700: 00 00 fc fc 00 00 fc fc 00 00 fc fc 00 00 fc fc
>ffff888000847780: fa fb fc fc 00 00 fc fc 00 07 fc fc 00 06 fc fc
                   ^
 ffff888000847800: 00 00 fc fc 00 00 fc fc 00 00 fc fc 00 00 fc fc
 ffff888000847880: 00 00 fc fc 00 04 fc fc 00 01 fc fc 00 00 fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
