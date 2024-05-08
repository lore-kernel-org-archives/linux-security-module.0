Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4E1128829
	for <linux-security-module@vger.kernel.org>; Wed,  8 May 2024 19:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715196743; cv=none; b=YPXYl0z8Fj7XOKmwp5cz5oMgeUUBKr0VYOnHSF++Vdo1uzzRIHrqoEjOyBsx/Y8kPpuezlqAknCGiRZ1TE3c4T1af5ruXIx8ErmlMMJV0O3JDsqVj8wjwQa4dw7dMwVFS8q37g8Qy0E/jq8VtfyujGrYo2ZwneWC1ynlBllNsEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715196743; c=relaxed/simple;
	bh=+ySXkYc5QiwkJ0CeVRZu0/kwBzu8zL6y7flU962u6hw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=T82eGijV58u4xYY6aLQGAY3u4y9zv32hY2bodyxDtb+n2WZYQ8E+BLBVshC0HVknGeuU/8cjkzQtsHsbt8d2LIyiji4YAi4qSD6C6DQydZQtD5+vfCYLFT9DnRrBrOtg1N0vLOqUS2olCiM8UehFP1t+07cicCeQpxwRZ9eRhrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-36c6ad47565so1444155ab.0
        for <linux-security-module@vger.kernel.org>; Wed, 08 May 2024 12:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715196741; x=1715801541;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=io8+fYOvzjtMLOZbcmfcrk1vBoRPVdoezfG7Q0K1kV0=;
        b=l3bpPiQgZ+Ijohw94BX2S3D5RoK5GhRVhoDaY5BXem0IUQ4YQR7iBNSn7Vq4idTDq/
         a11hy+YnpJSe/pcjEvk3nN3HOhcq7tvEgdnuGgSrqVj877K08IDhCeLCWkwnJK8sHfmF
         zEbc9NldoTLs7kko4QQUQib15btvkG/eGIy5+PvK3DAR2JYSfXds7rjRDsAQPAD0r+p9
         N9g2Xx5N1FKBp2RTWRoz2zZn8Vb1pgZZB+dn5LA4gJbuSDhAZFd4532nIaFX+4PON4bA
         1yihlSpGLCg/rHFoowYZeSeSb2ux1whsEqFOuvn7bIzrMbnHaj0Q11a71lHL4IbBmd41
         hoqw==
X-Forwarded-Encrypted: i=1; AJvYcCV1ZxPeTPZ9sa9KNInexBlfJQ7PDYzbYke8aIj5mMW1TlYhpqT+gpzFMssW2THIaaXUqU4PaMkwhicShes+RClSyNbUKYjjrjcMWulT/2ZTpGpsD1BX
X-Gm-Message-State: AOJu0YwtaJnc1xAYYkiR9tc0xo/xk9YZeV5CquTVKpiyiiB5bQA8IlDr
	ooSlPaTlw9ZwI0IC4rQS11/RHsZpAQNTldozchRv3hlYCEDwXDDSdvZw873s80xMrU7Y/j6Fgub
	TzUwRwItGl/JZDcwSTn0jizSLWUHYlag0zqGGPpNnoc9WoKQfNJFoqf0=
X-Google-Smtp-Source: AGHT+IFF/ZEHm61uwGpMLqTumNcisBXc9baf1FbQ4sZFLvhtQCBQvcV1Gvt9UXF/OBsFZUNYeljvYXXepgrnK2C55XMPOpPQGVut
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1d:b0:36b:fbab:9f14 with SMTP id
 e9e14a558f8ab-36caecdd2cemr1572725ab.1.1715196740936; Wed, 08 May 2024
 12:32:20 -0700 (PDT)
Date: Wed, 08 May 2024 12:32:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076ba3b0617f65cc8@google.com>
Subject: [syzbot] [lsm?] general protection fault in hook_inode_free_security
From: syzbot <syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com>
To: jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, mic@digikod.net, paul@paul-moore.com, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dccb07f2914c Merge tag 'for-6.9-rc7-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a46760980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d14c12b661fb43
dashboard link: https://syzkaller.appspot.com/bug?extid=5446fbf332b0602ede0b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/39d66018d8ad/disk-dccb07f2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c160b651d1bc/vmlinux-dccb07f2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3662a33ac713/bzImage-dccb07f2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc018f62f515: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: probably user-memory-access in range [0x0000000c7b17a8a8-0x0000000c7b17a8af]
CPU: 1 PID: 5102 Comm: syz-executor.1 Not tainted 6.9.0-rc7-syzkaller-00012-gdccb07f2914c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:hook_inode_free_security+0x5b/0xb0 security/landlock/fs.c:1047
Code: 8a fd 48 8b 1b 48 c7 c0 c4 4e d5 8d 48 c1 e8 03 42 0f b6 04 30 84 c0 75 3e 48 63 05 33 59 65 09 48 01 c3 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 66 be 8a fd 48 83 3b 00 75 0d e8
RSP: 0018:ffffc9000307f9a8 EFLAGS: 00010212
RAX: 000000018f62f515 RBX: 0000000c7b17a8a8 RCX: ffff888027668000
RDX: 0000000000000000 RSI: 0000000000000040 RDI: ffff88805c0bb270
RBP: ffffffff8c01fb00 R08: ffffffff82132a15 R09: 1ffff1100b81765f
R10: dffffc0000000000 R11: ffffffff846ff540 R12: dffffc0000000000
R13: 1ffff1100b817683 R14: dffffc0000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f43c42de000 CR3: 00000000635f8000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 security_inode_free+0x4a/0xd0 security/security.c:1613
 __destroy_inode+0x2d9/0x650 fs/inode.c:286
 destroy_inode fs/inode.c:309 [inline]
 evict+0x521/0x630 fs/inode.c:682
 dispose_list fs/inode.c:700 [inline]
 evict_inodes+0x5f9/0x690 fs/inode.c:750
 generic_shutdown_super+0x9d/0x2d0 fs/super.c:626
 kill_block_super+0x44/0x90 fs/super.c:1675
 deactivate_locked_super+0xc6/0x130 fs/super.c:472
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267
 task_work_run+0x251/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa1b/0x27e0 kernel/exit.c:878
 do_group_exit+0x207/0x2c0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f731567dd69
Code: Unable to access opcode bytes at 0x7f731567dd3f.
RSP: 002b:00007fff4f0804d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f73156c93a3 RCX: 00007f731567dd69
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000002 R08: 00007fff4f07e277 R09: 00007fff4f081790
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff4f081790
R13: 00007f73156c937e R14: 00000000000154d0 R15: 000000000000001e
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hook_inode_free_security+0x5b/0xb0 security/landlock/fs.c:1047
Code: 8a fd 48 8b 1b 48 c7 c0 c4 4e d5 8d 48 c1 e8 03 42 0f b6 04 30 84 c0 75 3e 48 63 05 33 59 65 09 48 01 c3 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 66 be 8a fd 48 83 3b 00 75 0d e8
RSP: 0018:ffffc9000307f9a8 EFLAGS: 00010212
RAX: 000000018f62f515 RBX: 0000000c7b17a8a8 RCX: ffff888027668000
RDX: 0000000000000000 RSI: 0000000000000040 RDI: ffff88805c0bb270
RBP: ffffffff8c01fb00 R08: ffffffff82132a15 R09: 1ffff1100b81765f
R10: dffffc0000000000 R11: ffffffff846ff540 R12: dffffc0000000000
R13: 1ffff1100b817683 R14: dffffc0000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555587f03978 CR3: 0000000049876000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	8a fd                	mov    %ch,%bh
   2:	48 8b 1b             	mov    (%rbx),%rbx
   5:	48 c7 c0 c4 4e d5 8d 	mov    $0xffffffff8dd54ec4,%rax
   c:	48 c1 e8 03          	shr    $0x3,%rax
  10:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax
  15:	84 c0                	test   %al,%al
  17:	75 3e                	jne    0x57
  19:	48 63 05 33 59 65 09 	movslq 0x9655933(%rip),%rax        # 0x9655953
  20:	48 01 c3             	add    %rax,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 66 be 8a fd       	call   0xfd8abe9f
  39:	48 83 3b 00          	cmpq   $0x0,(%rbx)
  3d:	75 0d                	jne    0x4c
  3f:	e8                   	.byte 0xe8


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
