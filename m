Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92111433D9
	for <linux-security-module@vger.kernel.org>; Fri, 27 Dec 2024 20:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735331484; cv=none; b=Vfw9ADRBUmrGsc+bFXBa1GTTH9M6JcqbKDkl11xNDOoukaJUYEOlTMv1fUigB48/Z+PwJiuyLkZ/cTOHPajo1xnTmBhaNyMuMb90j8vd/731gch8hhSOQNHjLklV2fYHIKhZNgBd5PNvX5bGhwmIKwQs0sR4JcBmeOpyg3M5sKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735331484; c=relaxed/simple;
	bh=ZtRS6d5Z2J8PXdtFTYVMvTT3LJcYOpOV48KJ3LzL4aA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cIHBvTq7IEdLszcoHYlbooVNkk/IWGohbHliYc2hNI/k7ogcKXUHewXmThlfYrDeqoR+mrcBg46IqqbUohjVHd3v1QBiyyonMHaML5U/ZVsdLNH0oNM5XP8dAubmHg3TiN0qpaXONlZaaAsfTW50WSMbMiCb1XV5QsyPMmOHAco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a7e0d7b804so63290835ab.0
        for <linux-security-module@vger.kernel.org>; Fri, 27 Dec 2024 12:31:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735331482; x=1735936282;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j4Tj3bDPQ5kf+ElrjEKr/Rk1UNm8hmCIGpLxpsCvsSI=;
        b=oNu2iv2/S1aMfPWrAwU0XrFRJkZ1ybu4H2YHw4lH0yPfdBbfAhDndiPXhNjL/D6EAh
         0A5st7Ikr/4LtPDxpvBIpYT71IzeYokmqpO2u662VaSFbqVeM5YLQHercN8t77ft8sFG
         2MBRds1DyV5mnfXH+JtwfUEmkL5S1/j4uhEKk8B6/JUTk2KF2Im7rkhVXEQ1vKSi+NZo
         wCn7Yo7cn/d6e0NQZ7phlLP7oFgG5QiQmq91p6zC74RI67+vib3GcSQIXT9RR0W7aiAU
         FSLdcp2zPDetB5Zw6oG6SDNDoEycOWTF9gs9hWOa04YTkN51WFnf86SD875KYMiZn67d
         vIcg==
X-Forwarded-Encrypted: i=1; AJvYcCXAftfDWgEgkqfNxeAII8lrFmbMXli3kbeEylegPT9iSACpMix/B8pK8//4fXydNxLUpWZoy7Hf0/ffGUmFp9Y8N2cdlvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyICfhlm0Q7G3F4OCIvIxbNPW8/ehJ+y5808DE9prEpx19kt0Hr
	GelBfek1nSgzGrGMVx3yPmwPfrprG+6whhov57a3hy2NeO+55UF+33/sBaovMuIPk5TReEiWr7G
	tsJmnNtm/whG9JeVjEseyt5BoyUtjEoiUcUGLva3EzaY4MVgMyQ0jjJo=
X-Google-Smtp-Source: AGHT+IEdVcdYICWemAn2Op4Msphyv3P0o7VeBnl9WzVbpvzxOERLRgtcIWqJfpjF7V76tB/d7yI4j3kwTeIZkarPytENnJr71vtd
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3d03:b0:3a7:d84c:f2a0 with SMTP id
 e9e14a558f8ab-3c2d25669e3mr210690155ab.7.1735331481900; Fri, 27 Dec 2024
 12:31:21 -0800 (PST)
Date: Fri, 27 Dec 2024 12:31:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676f0e99.050a0220.226966.00a2.GAE@google.com>
Subject: [syzbot] [tomoyo?] general protection fault in tomoyo_print_entry
From: syzbot <syzbot+b189984e86625a050e68@syzkaller.appspotmail.com>
To: jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp, 
	tomoyo-dev-en@lists.osdn.me
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8379578b11d5 Merge tag 'for-v6.13-rc' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=150910b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c078001e66e4a17e
dashboard link: https://syzkaller.appspot.com/bug?extid=b189984e86625a050e68
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9d2ed0d9af52/disk-8379578b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a556191d6592/vmlinux-8379578b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9f261e0b28e6/bzImage-8379578b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b189984e86625a050e68@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 1 UID: 0 PID: 7293 Comm: syz.1.535 Not tainted 6.13.0-rc4-syzkaller-00069-g8379578b11d5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:tomoyo_print_entry+0x83/0x2720 security/tomoyo/common.c:1387
Code: f3 65 48 8b 04 25 28 00 00 00 48 89 84 24 38 01 00 00 31 c0 e8 3e f1 48 fd 48 8d 7d 19 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <0f> b6 04 18 38 d0 7f 08 84 c0 0f 85 2e 14 00 00 49 8d 8e f3 00 00
RSP: 0018:ffffc90002ef7a90 EFLAGS: 00010202
RAX: 0000000000000003 RBX: dffffc0000000000 RCX: ffffc9000c2b9000
RDX: 0000000000000001 RSI: ffffffff84505e12 RDI: 0000000000000019
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000003 R12: ffffed100436ba1a
R13: ffff8880280e2f90 R14: ffff888021b5d000 R15: 0000000000000001
FS:  00007fa7aef106c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020008000 CR3: 000000007b9ee000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tomoyo_read_domain2+0xa3/0x380 security/tomoyo/common.c:1596
 tomoyo_read_domain security/tomoyo/common.c:1649 [inline]
 tomoyo_read_domain+0x3d2/0x9c0 security/tomoyo/common.c:1610
 tomoyo_read_control+0x281/0x510 security/tomoyo/common.c:2591
 vfs_read+0x1df/0xbe0 fs/read_write.c:563
 ksys_read+0x12b/0x250 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa7ae185d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa7aef10038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007fa7ae375fa0 RCX: 00007fa7ae185d29
RDX: 000000020000074c RSI: 0000000020001080 RDI: 0000000000000004
RBP: 00007fa7ae201b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fa7ae375fa0 R15: 00007ffe481b5f38
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:tomoyo_print_entry+0x83/0x2720 security/tomoyo/common.c:1387
Code: f3 65 48 8b 04 25 28 00 00 00 48 89 84 24 38 01 00 00 31 c0 e8 3e f1 48 fd 48 8d 7d 19 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <0f> b6 04 18 38 d0 7f 08 84 c0 0f 85 2e 14 00 00 49 8d 8e f3 00 00
RSP: 0018:ffffc90002ef7a90 EFLAGS: 00010202
RAX: 0000000000000003 RBX: dffffc0000000000 RCX: ffffc9000c2b9000
RDX: 0000000000000001 RSI: ffffffff84505e12 RDI: 0000000000000019
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000003 R12: ffffed100436ba1a
R13: ffff8880280e2f90 R14: ffff888021b5d000 R15: 0000000000000001
FS:  00007fa7aef106c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5f63dd4f98 CR3: 000000007b9ee000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	f3 65 48 8b 04 25 28 	repz mov %gs:0x28,%rax
   7:	00 00 00
   a:	48 89 84 24 38 01 00 	mov    %rax,0x138(%rsp)
  11:	00
  12:	31 c0                	xor    %eax,%eax
  14:	e8 3e f1 48 fd       	call   0xfd48f157
  19:	48 8d 7d 19          	lea    0x19(%rbp),%rdi
  1d:	48 89 f8             	mov    %rdi,%rax
  20:	48 89 fa             	mov    %rdi,%rdx
  23:	48 c1 e8 03          	shr    $0x3,%rax
  27:	83 e2 07             	and    $0x7,%edx
* 2a:	0f b6 04 18          	movzbl (%rax,%rbx,1),%eax <-- trapping instruction
  2e:	38 d0                	cmp    %dl,%al
  30:	7f 08                	jg     0x3a
  32:	84 c0                	test   %al,%al
  34:	0f 85 2e 14 00 00    	jne    0x1468
  3a:	49                   	rex.WB
  3b:	8d                   	.byte 0x8d
  3c:	8e f3                	mov    %ebx,%?


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
