Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB993BBE5
	for <linux-security-module@vger.kernel.org>; Sat, 13 Jul 2024 08:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720858886; cv=none; b=jUVvYKviu4z7k9eQc7EeQ4Ve1QCNx3btaKfrmcRlKxt6G0LBoVJndZ35+Abaxdc6HBUlGWzwCz2ipFKRx23d/R8DOcZ6gAPiumElyKrydo6c2k4wA19au4wbg50NLUDD+oFgeC+Y3JUuu9YeYj9uSXl5keCPaWu1ysFs2OLnhEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720858886; c=relaxed/simple;
	bh=xctafCIz09k4Ew0L2XCOTCa/hJ05EIdNhWmBFccHwkA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ChK6CXS0woCphCMClKVVbvtPsM5BYpHR68a5Dy717abfuhQjYuZ8spt3/qtFeNuap11zFX5Berze3maeVyYXTclA4+m3tuGFguWgn7aR9YNENxO7RuYEQHMVV+ZDYzhu1tmBlaf1kED+VC1tjR1JLdxI3yAMG9Mbd1TSajMTqOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7fb15d52c5cso308252339f.3
        for <linux-security-module@vger.kernel.org>; Sat, 13 Jul 2024 01:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720858884; x=1721463684;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pHcFln8j5JUFwqmr33UhFWzq5QLUVLRuKMyc3/eRyY0=;
        b=gVUo3wOKW9BX38f3oMsMui9JxnQDJvscKCTQ0yhk/ZTHa9YTEiBkhetVtwdK9RaaPe
         Ud9kAkOEx1/lhb1Ob+6gFY4diHWaH+Se+8rXgGTCT2TCim5qz+6d6mBS/tRVTUgaQiI8
         WKgqUmAkAoGaY6wAQak6q52q9+nV5Wc24mdLiYXzmNQwU2FBHTAmx3NsiZ5A1wh/2xbJ
         pttli0V0WOyfJEPNA0Qz2zapf0fGwWgvj0dIHiJeG8wWoqLgdhsWgxV8VoOiT0mk3rwl
         0UsEFM5rXaIVf+kGYXC28imGBfdgq8+gblbAIwC5l1L8N0OF8jp3uL4jIMLXjzVdW9Bp
         ekMw==
X-Forwarded-Encrypted: i=1; AJvYcCWbqMPU+1Fzcop61DqJ1jhhekKdJUzQ7jB4wBojSLu6PmmrHtJUKIFzcYH3KtkUEaym4hOLVvco6QO1ci/YKg4OpSdtc2i2D6yGviP9F3Q0Fdq2xpIH
X-Gm-Message-State: AOJu0YznQY0aaVCRor1ns+DkKmVmFja2bvOjA+vfUKIZHn0Vacurrpyz
	KHbFY95XLDJCgG9oCZl87LIajDlLjEO6fxohKAGLww+81o2MbC6idP82Xb+PYZrVU0JlqQOlpj+
	Huozz6/0VDiA/BQedlBvKP4NCHuLmzi/vlZdCmWmJRApAfo+33nupF48=
X-Google-Smtp-Source: AGHT+IFOJKrGfV5Fyn38OKb4xPzZ3gO/pFFyTv2ojc6Fu4aDEkkhECgQXXhHBdcpANJRB6jtsg5WHF4Q/Wx+6HOnn0pkAOx1CbcI
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:340f:b0:7f9:3fd9:ccf with SMTP id
 ca18e2360f4ac-800036e6deemr103957339f.2.1720858883877; Sat, 13 Jul 2024
 01:21:23 -0700 (PDT)
Date: Sat, 13 Jul 2024 01:21:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b7ce6061d1caec0@google.com>
Subject: [syzbot] [io-uring] general protection fault in tomoyo_socket_bind_permission
From: syzbot <syzbot+1e811482aa2c70afa9a0@syzkaller.appspotmail.com>
To: axboe@kernel.dk, io-uring@vger.kernel.org, jmorris@namei.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com, penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3fe121b62282 Add linux-next specific files for 20240712
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=149a439e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98dd8c4bab5cdce
dashboard link: https://syzkaller.appspot.com/bug?extid=1e811482aa2c70afa9a0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1746d385980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c2be31980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8c6fbf69718d/disk-3fe121b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/39fc7e43dfc1/vmlinux-3fe121b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0a78e70e4b4e/bzImage-3fe121b6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1e811482aa2c70afa9a0@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 UID: 0 PID: 5098 Comm: syz-executor321 Not tainted 6.10.0-rc7-next-20240712-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:tomoyo_socket_bind_permission+0xa5/0x340 security/tomoyo/network.c:727
Code: f3 f3 66 43 c7 44 2e 0e f3 f3 e8 e6 e6 2b fd ba 30 00 00 00 48 89 df 31 f6 e8 e7 6f 93 fd 49 8d 5c 24 18 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 fc 6c 93 fd 48 8b 03 48 89 44 24
RSP: 0018:ffffc9000348f860 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 0000000000000018 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc9000348f8d0
RBP: ffffc9000348f950 R08: ffffc9000348f8cf R09: 0000000000000000
R10: ffffc9000348f8a0 R11: fffff52000691f1a R12: 0000000000000000
R13: dffffc0000000000 R14: 1ffff92000691f10 R15: ffff88801e82bca0
FS:  000055558d6cc480(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 0000000078dee000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 security_socket_bind+0x75/0xb0 security/security.c:4460
 __sys_bind_socket+0x28/0xb0 net/socket.c:1830
 io_bind+0x8f/0x190 io_uring/net.c:1746
 io_issue_sqe+0x3cf/0x1570 io_uring/io_uring.c:1710
 io_queue_sqe io_uring/io_uring.c:1924 [inline]
 io_submit_sqe io_uring/io_uring.c:2180 [inline]
 io_submit_sqes+0xaff/0x1bf0 io_uring/io_uring.c:2295
 __do_sys_io_uring_enter io_uring/io_uring.c:3205 [inline]
 __se_sys_io_uring_enter+0x2d4/0x2670 io_uring/io_uring.c:3142
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f744e4d88f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc942a3638 EFLAGS: 00000216 ORIG_RAX: 00000000000001aa
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f744e4d88f9
RDX: 0000000000000000 RSI: 0000000000002d3e RDI: 0000000000000003
RBP: 00000000000024fa R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000216 R12: 0000000000000001
R13: 431bde82d7b634db R14: 00007ffc942a3690 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:tomoyo_socket_bind_permission+0xa5/0x340 security/tomoyo/network.c:727
Code: f3 f3 66 43 c7 44 2e 0e f3 f3 e8 e6 e6 2b fd ba 30 00 00 00 48 89 df 31 f6 e8 e7 6f 93 fd 49 8d 5c 24 18 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 fc 6c 93 fd 48 8b 03 48 89 44 24
RSP: 0018:ffffc9000348f860 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 0000000000000018 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc9000348f8d0
RBP: ffffc9000348f950 R08: ffffc9000348f8cf R09: 0000000000000000
R10: ffffc9000348f8a0 R11: fffff52000691f1a R12: 0000000000000000
R13: dffffc0000000000 R14: 1ffff92000691f10 R15: ffff88801e82bca0
FS:  000055558d6cc480(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 0000000078dee000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	f3 f3 66 43 c7 44 2e 	repz xrelease movw $0xf3f3,0xe(%r14,%r13,1)
   7:	0e f3 f3
   a:	e8 e6 e6 2b fd       	call   0xfd2be6f5
   f:	ba 30 00 00 00       	mov    $0x30,%edx
  14:	48 89 df             	mov    %rbx,%rdi
  17:	31 f6                	xor    %esi,%esi
  19:	e8 e7 6f 93 fd       	call   0xfd937005
  1e:	49 8d 5c 24 18       	lea    0x18(%r12),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 fc 6c 93 fd       	call   0xfd936d35
  39:	48 8b 03             	mov    (%rbx),%rax
  3c:	48                   	rex.W
  3d:	89                   	.byte 0x89
  3e:	44                   	rex.R
  3f:	24                   	.byte 0x24


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
