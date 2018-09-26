From: dvyukov@google.com (Dmitry Vyukov)
Date: Wed, 26 Sep 2018 09:53:02 +0200
Subject: general protection fault in integrity_inode_free
In-Reply-To: <0000000000009581bf0576c16d3a@google.com>
References: <0000000000009581bf0576c16d3a@google.com>
Message-ID: <CACT4Y+asi3NLZFCLVibcQAPEJn8ZkuaRopm+Eh8eFsW7PGLVWw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Sep 26, 2018 at 9:47 AM, syzbot
<syzbot+4c0fa7d385ea5af34e91@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    846e8dd47c26 Merge tag 'scsi-fixes' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12a59d56400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=dfb440e26f0a6f6f
> dashboard link: https://syzkaller.appspot.com/bug?extid=4c0fa7d385ea5af34e91
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+4c0fa7d385ea5af34e91 at syzkaller.appspotmail.com

This was misattributed to net, +IMA maintainers.

>  __do_sys_sendmsg net/socket.c:2163 [inline]
>  __se_sys_sendmsg net/socket.c:2161 [inline]
>  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> RIP: 0033:0x457579
> CPU: 0 PID: 8727 Comm: syz-executor3 Not tainted 4.19.0-rc5+ #33
> Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RSP: 002b:00007f07f2e4bc78 EFLAGS: 00000246
> RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:168 [inline]
> RIP: 0010:rb_erase+0x306/0x3710 lib/rbtree.c:459
>  ORIG_RAX: 000000000000002e
> Code: c7 81 28 01 00 00 f2 f2 f2 f2 c7 81 2c 01 00 00 00 f2 f2 f2 48 89 f9
> 65 48 8b 1c 25 28 00 00 00 48 89 5d d0 31 db 48 c1 e9 03 <42> 80 3c 01 00 0f
> 85 41 1c 00 00 4c 8d 48 10 4c 8b 78 08 48 b9 00
> RAX: ffffffffffffffda RBX: 00007f07f2e4bc90 RCX: 0000000000457579
> RSP: 0018:ffff88018620e918 EFLAGS: 00010202
> RDX: 0000000000000000 RSI: 000000002000b000 RDI: 0000000000000003
> RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f07f2e4c6d4
> RDX: 1ffff10030c41d2b RSI: ffffffff8b5a08a0 RDI: 0000000000000008
> R13: 00000000004c38e1 R14: 00000000004d5730 R15: 0000000000000004
> RBP: ffff88018620f320 R08: dffffc0000000000 R09: fffffbfff135d5c8
> kobject: 'loop5' (00000000eac6d22a): kobject_uevent_env
> R10: fffffbfff135d5c8 R11: ffffffff89aeae43 R12: ffff8801bacb38f0
> R13: dffffc0000000000 R14: ffff88018620f2f8 R15: ffff88018620f438
> overlayfs: unrecognized mount option "smackfstransmute=upperdir" or missing
> value
> FS:  00007ff9677ec700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b31324000 CR3: 00000001c2773000 CR4: 00000000001406f0
> Call Trace:
>  integrity_inode_free+0x12f/0x320 security/integrity/iint.c:150
>  security_inode_free+0x19/0x90 security/security.c:453
>  __destroy_inode+0x328/0x820 fs/inode.c:238
>  destroy_inode+0xda/0x200 fs/inode.c:265
>  evict+0x5e0/0x980 fs/inode.c:575
>  iput_final fs/inode.c:1547 [inline]
>  iput+0x679/0xa90 fs/inode.c:1573
>  swap_inode_boot_loader fs/ext4/ioctl.c:188 [inline]
>  ext4_ioctl+0x236f/0x4210 fs/ext4/ioctl.c:865
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:501 [inline]
>  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
>  __do_sys_ioctl fs/ioctl.c:709 [inline]
>  __se_sys_ioctl fs/ioctl.c:707 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x457579
> Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ff9677ebc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 0000000000457579
> RDX: 0000000000000000 RSI: 0000000000006611 RDI: 0000000000000003
> RBP: 000000000072c040 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff9677ec6d4
> R13: 00000000004bf626 R14: 00000000004cf4c0 R15: 00000000ffffffff
> Modules linked in:
> ---[ end trace 6d41a32e43d56085 ]---
> RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:168 [inline]
> RIP: 0010:rb_erase+0x306/0x3710 lib/rbtree.c:459
> Code: c7 81 28 01 00 00 f2 f2 f2 f2 c7 81 2c 01 00 00 00 f2 f2 f2 48 89 f9
> 65 48 8b 1c 25 28 00 00 00 48 89 5d d0 31 db 48 c1 e9 03 <42> 80 3c 01 00 0f
> 85 41 1c 00 00 4c 8d 48 10 4c 8b 78 08 48 b9 00
> RSP: 0018:ffff88018620e918 EFLAGS: 00010202
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
> RDX: 1ffff10030c41d2b RSI: ffffffff8b5a08a0 RDI: 0000000000000008
> RBP: ffff88018620f320 R08: dffffc0000000000 R09: fffffbfff135d5c8
> R10: fffffbfff135d5c8 R11: ffffffff89aeae43 R12: ffff8801bacb38f0
> R13: dffffc0000000000 R14: ffff88018620f2f8 R15: ffff88018620f438
> FS:  00007ff9677ec700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b31324000 CR3: 00000001c2773000 CR4: 00000000001406f0
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller at googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe at googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/0000000000009581bf0576c16d3a%40google.com.
> For more options, visit https://groups.google.com/d/optout.
