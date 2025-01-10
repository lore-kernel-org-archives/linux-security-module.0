Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5AE205ABD
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jan 2025 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736518887; cv=none; b=XIkTae01F6KcdU8esx99kuwQDN2uKa+7IkzpFs+xmV2apHRUEthjNQ6x8a5ZzFIUPq6s7FQ5tvJl3qPgGSReKulnOi5Zj6BV7xcabRHSwyc5t0H2f7vuF3Zt0iMWhrtX9AQsB7pZuVY/G0AqJ6CloZwZJGtVv3nsgLhkIggmFnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736518887; c=relaxed/simple;
	bh=wqMhPKGplOmiVOjT1mlmud088tUu91QfPl2Gl0Fd+AE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TRKUCg7u7PQ+dGFGTvFg9HYdYPkrQsSSJUdN135wYZBmoNcoUCW+4Kqez74krx0uJRJhVLxddi0iEj/pToXRUE6Stjz0q3iQje9fynw/RyuUvRtmwl43pD5xjQceQo2H8F0c9aNAD+AHefAqchd5aIQeJCxGwDy3RWHXoACRI30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a9d57cff85so36114655ab.2
        for <linux-security-module@vger.kernel.org>; Fri, 10 Jan 2025 06:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736518885; x=1737123685;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LyyVnA6+3/YFBTWckn399GiIxk7QdVP6OvZUgXS/2Mw=;
        b=l4CkQaKs2Xge1w6hUgPvgtqQlP/e7Wr0zFcO/gOa2wOj1MZkpRAF5KeU3Hn0TNYuBZ
         I4feqoQUKRMHlFuynIdgdAhfpnIahz86yEpWtmzc2WMQfx3KynNzMgivQGQZ6TSxM9jr
         Xr29ynEumZInmG0w66TpV9AykaNjfwavTcG0j1+oD+AiflT4OgUH5Re4zQccbQ0vi6XG
         jDlEmQnlmXe+VmSz0k1NvRLc4sVHPq7BlfhCuXBPQ5Ccq4Yz7CM8X6z6x11O8K/F84E5
         Q/BGditbeRuNtU07fh5XNp5OE/O0WQOvuQU0oKUK7FgY07+mHEUn4ceprXYOOEpeN4Hh
         RSbA==
X-Forwarded-Encrypted: i=1; AJvYcCVv0Iis+FNoJ1IC57mL6rjnabD8ITGzECtDGiduwyl2GNFsDIquRbXUDAC7sNeBBbseXOdRDJtvW1ERaS6xxX22l04YahA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyshuABj0TZrGgbeAWMQNqwHREIk7Ez+377cQyOkc4do/INATV7
	WBwqrXab+VKsZJY+yK1CMCcb3oTQQYRSWFo9tssiQTRNip4yhd00NeZVxiRFt5pHCYWiCURQlTH
	XLBGMWEgflDToP7+psnb0IFxcPcbhjbK4W0lj1RnHFjp52UTQEiblgjQ=
X-Google-Smtp-Source: AGHT+IHnkG675ZjmFnspSgACDOa2of6Pd9pb46r6Nub4ULc4mLXQ4d3tWYsV5sTh5svEbcIvRvSZxINFa/qgFS5Ozd6LEeb2k2T6
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f8a:b0:3cb:f2e6:5590 with SMTP id
 e9e14a558f8ab-3ce3a7abde0mr94958235ab.0.1736518885447; Fri, 10 Jan 2025
 06:21:25 -0800 (PST)
Date: Fri, 10 Jan 2025 06:21:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67812ce5.050a0220.d0267.002d.GAE@google.com>
Subject: [syzbot] [tomoyo?] general protection fault in tomoyo_flush
From: syzbot <syzbot+9ad93776d062020fdeae@syzkaller.appspotmail.com>
To: jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp, 
	tomoyo-dev-en@lists.osdn.me
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0bc21e701a6f MAINTAINERS: Remove Olof from SoC maintainers
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c198b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86dd15278dbfe19f
dashboard link: https://syzkaller.appspot.com/bug?extid=9ad93776d062020fdeae
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0ddf8c394b52/disk-0bc21e70.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e1f9219449bc/vmlinux-0bc21e70.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bd6fd63b12da/bzImage-0bc21e70.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9ad93776d062020fdeae@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 27185 Comm: syz.2.4308 Not tainted 6.13.0-rc5-syzkaller-00012-g0bc21e701a6f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:strlen+0x1e/0xa0 lib/string.c:413
Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 89 fd 48 c1 ea 03 53 48 83 ec 08 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 50 80 7d 00 00
RSP: 0018:ffffc9000d6679f0 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: dffffc0000000000 RCX: ffffffff845000d4
RDX: 0000000000000000 RSI: ffffffff84500115 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000003 R12: 0000000000000000
R13: 0000000000000000 R14: 1ffff1100867ae16 R15: 0000000000000002
FS:  00007fa57d3f66c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000007000 CR3: 000000003289e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tomoyo_flush+0xb1/0x4b0 security/tomoyo/common.c:209
 tomoyo_set_string+0xaf/0xe0 security/tomoyo/common.c:255
 tomoyo_print_condition security/tomoyo/common.c:1292 [inline]
 tomoyo_print_entry+0xef8/0x2720 security/tomoyo/common.c:1570
 tomoyo_read_domain2+0xa3/0x380 security/tomoyo/common.c:1596
 tomoyo_read_domain security/tomoyo/common.c:1649 [inline]
 tomoyo_read_domain+0x3d2/0x9c0 security/tomoyo/common.c:1610
 tomoyo_read_control+0x281/0x510 security/tomoyo/common.c:2591
 vfs_read+0x1df/0xbe0 fs/read_write.c:563
 ksys_read+0x12b/0x250 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa57f585d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa57d3f6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007fa57f775fa0 RCX: 00007fa57f585d29
RDX: 000000000000b4d3 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fa57f601b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fa57f775fa0 R15: 00007ffdc9ebbd58
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strlen+0x1e/0xa0 lib/string.c:413
Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 89 fd 48 c1 ea 03 53 48 83 ec 08 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 50 80 7d 00 00
RSP: 0018:ffffc9000d6679f0 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: dffffc0000000000 RCX: ffffffff845000d4
RDX: 0000000000000000 RSI: ffffffff84500115 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000003 R12: 0000000000000000
R13: 0000000000000000 R14: 1ffff1100867ae16 R15: 0000000000000002
FS:  00007fa57d3f66c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c824cf7 CR3: 000000003289e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	f3 0f 1e fa          	endbr64
  10:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  17:	fc ff df
  1a:	48 89 fa             	mov    %rdi,%rdx
  1d:	55                   	push   %rbp
  1e:	48 89 fd             	mov    %rdi,%rbp
  21:	48 c1 ea 03          	shr    $0x3,%rdx
  25:	53                   	push   %rbx
  26:	48 83 ec 08          	sub    $0x8,%rsp
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	48 89 fa             	mov    %rdi,%rdx
  31:	83 e2 07             	and    $0x7,%edx
  34:	38 d0                	cmp    %dl,%al
  36:	7f 04                	jg     0x3c
  38:	84 c0                	test   %al,%al
  3a:	75 50                	jne    0x8c
  3c:	80 7d 00 00          	cmpb   $0x0,0x0(%rbp)


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
