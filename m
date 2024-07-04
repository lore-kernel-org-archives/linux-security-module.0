Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E497B1A00EE
	for <linux-security-module@vger.kernel.org>; Thu,  4 Jul 2024 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720079367; cv=none; b=jUQEkSgGwg/haLOf8/7KthPQHx/co78A1g1b3c6a17VUXhhDeRehNEWIDCh67JecXrKKHbrX9h4PIWWVJxoIp6txD/s0mABIRvYvKaPBeAN9Noxd9VIWw9P2W+DfoOoQ5YhE6gizQb5xcVvucgoT3nGY4o4u62WfSMBBSk/WDXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720079367; c=relaxed/simple;
	bh=fRJ9mdCf/yjl1pTE76e0G5Tx9++NOezYN6PapUoXc+I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mj1h4vmFSKk9TKV9K4oaOLsY9f7xTyg+TN8ZJ3Gp71S39X10JPUkNWZUXKkZIktjiIZsFyk4Oi013FJzeVKLp6U1Z2awecfJh0EbYS7QhIYz2UKIBrgApFfY7vrYpzc10TqkTTw+ddNwGSk38e6cNkwmayROkqukLYMjdhwKsLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f3d2fd6ad6so53089839f.1
        for <linux-security-module@vger.kernel.org>; Thu, 04 Jul 2024 00:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720079365; x=1720684165;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XNcvIG+a7ieD4+d4PFj/wmMwJNYqJKim7sgKIcFXUdk=;
        b=WnPTjv8ykThk4bPfYWzcMJpp9hIeg7Fm3xaUFxfY6UF93nOOncHmv6oVoA/Ed2dpI2
         ZuKPySj3y6iOK/GigLpsfPx80yUnbOT2Wx3mRuqnyPXeLVEOr3pJ/AGU9Baq12ooHmkF
         pmsiIDFYSX1AgDlM/YI1R3ekgdTR/iVcyUGWmcBfoKaptWSu7t5XItsBQaz8eY35+OD2
         bHp/MLSAHfIxeQhZ1w/ESKGE/hF7kzGmAyyu00NPHlqX1TRdlUZ3tPB9Toa2llqV9vjW
         IDN597dz7YaQpXHQc8mvYwcOE68iHW1jPlsOH6HrmftLYOSGa6kMXy+JMYU7bbQ/ZRN5
         VI8g==
X-Forwarded-Encrypted: i=1; AJvYcCUq9T13XmHeEXqEIfMlLIzWTWs9kuW7GQvoxqYLITDVe64znpEHg74S3KFd3OnvHoqRFDfhpIYdGWKiMC9TtbUYfnzAuy6CKbpHD4UdusKoJN/lYxja
X-Gm-Message-State: AOJu0YwMojpyFpMDONjXLVLvTDRy/R1U3BRWaePWvhII4Tiw/8P2NHQr
	K5nJ7vol7YsOjpVS6f45bNDCIlxeci9TADkTKiyVyKxVtEuTlyxPr5flZQhRx/vAGvNU32FcM7D
	BtGhWrNPsTWwhreARBIm57uQ6SxZFMrwt5FkAxFvp5xa6R8YwEXLylDA=
X-Google-Smtp-Source: AGHT+IEDVkVNlNtEo+/+qLpMXqGS0qbZqRtg0fySo+o+isLfqFM0A+dR184HBtSolMGT/bhAFiCsXmK5rZqueVnxBxNJd9nz9vb1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13cf:b0:4b9:3703:4adf with SMTP id
 8926c6da1cb9f-4bf610d223emr68590173.3.1720079365092; Thu, 04 Jul 2024
 00:49:25 -0700 (PDT)
Date: Thu, 04 Jul 2024 00:49:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008acfcf061c672fba@google.com>
Subject: [syzbot] [lsm?] KASAN: slab-use-after-free Read in smack_socket_sock_rcv_skb
From: syzbot <syzbot+4ca2868197c9747dca53@syzkaller.appspotmail.com>
To: casey@schaufler-ca.com, jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8282d5af7be8 Merge tag 'nfs-for-6.10-3' of git://git.linux..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1235ae99980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67463c0717b8d4ca
dashboard link: https://syzkaller.appspot.com/bug?extid=4ca2868197c9747dca53
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0501bcb3ee43/disk-8282d5af.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a0f124c04344/vmlinux-8282d5af.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1d5690d55f9c/bzImage-8282d5af.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4ca2868197c9747dca53@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in smack_socket_sock_rcv_skb+0xec/0x13a0 security/smack/smack_lsm.c:4142
Read of size 8 at addr ffff888023db9498 by task kworker/u9:7/5088

CPU: 1 PID: 5088 Comm: kworker/u9:7 Not tainted 6.10.0-rc5-syzkaller-00282-g8282d5af7be8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 smack_socket_sock_rcv_skb+0xec/0x13a0 security/smack/smack_lsm.c:4142
 security_sock_rcv_skb+0x6d/0xa0 security/security.c:4603
 sk_filter_trim_cap+0x184/0xa80 net/core/filter.c:150
 sk_filter include/linux/filter.h:945 [inline]
 l2cap_sock_recv_cb+0x12d/0x4f0 net/bluetooth/l2cap_sock.c:1502
 l2cap_conless_channel net/bluetooth/l2cap_core.c:6774 [inline]
 l2cap_recv_frame+0x8d47/0x107d0 net/bluetooth/l2cap_core.c:6827
 hci_acldata_packet net/bluetooth/hci_core.c:3842 [inline]
 hci_rx_work+0x50f/0xca0 net/bluetooth/hci_core.c:4079
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 24593:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4123 [inline]
 __kmalloc_noprof+0x1f9/0x400 mm/slub.c:4136
 kmalloc_noprof include/linux/slab.h:664 [inline]
 sk_prot_alloc+0xe0/0x210 net/core/sock.c:2080
 sk_alloc+0x38/0x370 net/core/sock.c:2133
 bt_sock_alloc+0x3c/0x340 net/bluetooth/af_bluetooth.c:148
 l2cap_sock_alloc net/bluetooth/l2cap_sock.c:1869 [inline]
 l2cap_sock_create+0x13f/0x2d0 net/bluetooth/l2cap_sock.c:1909
 bt_sock_create+0x161/0x230 net/bluetooth/af_bluetooth.c:132
 __sock_create+0x490/0x920 net/socket.c:1571
 sock_create net/socket.c:1622 [inline]
 __sys_socket_create net/socket.c:1659 [inline]
 __sys_socket+0x150/0x3c0 net/socket.c:1706
 __do_sys_socket net/socket.c:1720 [inline]
 __se_sys_socket net/socket.c:1718 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1718
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 24593:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4438 [inline]
 kfree+0x149/0x360 mm/slub.c:4559
 sk_prot_free net/core/sock.c:2116 [inline]
 __sk_destruct+0x476/0x5f0 net/core/sock.c:2208
 l2cap_sock_release+0x15b/0x1d0 net/bluetooth/l2cap_sock.c:1417
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbc/0x240 net/socket.c:1421
 __fput+0x406/0x8b0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x360 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888023db9000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1176 bytes inside of
 freed 2048-byte region [ffff888023db9000, ffff888023db9800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x23db8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff888015042000 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000080008 00000001ffffefff 0000000000000000
head: 00fff00000000040 ffff888015042000 0000000000000000 dead000000000001
head: 0000000000000000 0000000000080008 00000001ffffefff 0000000000000000
head: 00fff00000000003 ffffea00008f6e01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 7400, tgid 7400 (kworker/u8:13), ts 897858391086, free_ts 897824765702
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1473
 prep_new_page mm/page_alloc.c:1481 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3425
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4683
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2265
 allocate_slab+0x5a/0x2f0 mm/slub.c:2428
 new_slab mm/slub.c:2481 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3667
 __slab_alloc+0x58/0xa0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3990 [inline]
 __do_kmalloc_node mm/slub.c:4122 [inline]
 kmalloc_node_track_caller_noprof+0x281/0x440 mm/slub.c:4143
 kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:597
 __alloc_skb+0x1f3/0x440 net/core/skbuff.c:666
 alloc_skb include/linux/skbuff.h:1308 [inline]
 alloc_skb_with_frags+0xc3/0x770 net/core/skbuff.c:6504
 sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2794
 sock_alloc_send_skb include/net/sock.h:1773 [inline]
 mld_newpack+0x1c3/0xa90 net/ipv6/mcast.c:1746
 add_grhead net/ipv6/mcast.c:1849 [inline]
 add_grec+0x1492/0x19a0 net/ipv6/mcast.c:1987
 mld_send_initial_cr+0x228/0x4b0 net/ipv6/mcast.c:2233
 ipv6_mc_dad_complete+0x88/0x490 net/ipv6/mcast.c:2244
page last free pid 5064 tgid 5064 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1093 [inline]
 free_unref_page+0xd19/0xea0 mm/page_alloc.c:2588
 skb_free_frag include/linux/skbuff.h:3354 [inline]
 skb_free_head net/core/skbuff.c:1079 [inline]
 skb_release_data+0x6b2/0x880 net/core/skbuff.c:1108
 skb_release_all net/core/skbuff.c:1173 [inline]
 __napi_kfree_skb net/core/skbuff.c:1451 [inline]
 kfree_skb_napi_cache net/core/skbuff.c:7007 [inline]
 skb_attempt_defer_free+0x42f/0x5c0 net/core/skbuff.c:7029
 tcp_eat_recv_skb net/ipv4/tcp.c:1520 [inline]
 tcp_recvmsg_locked+0x1500/0x2640 net/ipv4/tcp.c:2544
 tcp_recvmsg+0x25d/0x920 net/ipv4/tcp.c:2590
 inet_recvmsg+0x150/0x2d0 net/ipv4/af_inet.c:885
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg+0x1ae/0x280 net/socket.c:1068
 sock_read_iter+0x2ca/0x3e0 net/socket.c:1138
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x9c4/0xbd0 fs/read_write.c:476
 ksys_read+0x1a0/0x2c0 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888023db9380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888023db9400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888023db9480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888023db9500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888023db9580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
