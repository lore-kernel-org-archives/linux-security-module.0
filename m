Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794665491;
	b=zTGHInksTAC3RkXzrk3zR9HAWCMSQ4XnA2EdMlV8JYtcp01gG9IGL56gA56LVG36B+bE
	 XgSrxp8j0YRrD5fZ6+yh7euUh1c7eeHpmoBfoqnEfMOucERoQr2iZGAnaUHy/MvD7j7Ws
	 jIxaFVuKT7w6fvi66rFdM/XLWdDIAzXlrpHbV8UhoDL/qMzgYa58RZeDyN+aDtYbvhVgM
	 mWpzUnllPRP8H2+WSC+1B3wesivhKfrx5O/uV7iL1T/xbUkDnOL/9ZB2hblx7IzXGCxvN
	 UMYh8lYK4K9A16TWcVqd587wk6c8NCa3FrNrDwkwHGKaKN3uApf+pYvmU0gGsneR2HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665491;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=L/gzc6cM8spTMzuU/OusNDAYp5kZ9jRYawr5B+a9Xys=;
	b=yUkdDo8yc1ZtEijvIjC1Pgnlv5gksccGmVpqFfeGC48ATEj3X7cQRNyK/oIuFrY7+Pn9
	 gfMsfZmBZSN4dO3L9VUpzHoxx9fghWknRnQ+WQjGLQPiFtjt2wOQNYI5emRr59gcfFp5e
	 pTFTo1+C/mjB2xiMwffh7ngvt6tQTM06A0oQhYS5QIW1zogbunIoIZhAh/PLL/5F+inzg
	 DA4AoLZfcOruOyanUEoX1olsqbZBXf1V62SgS2hX7HRYl4wY6o8/QcWx51f4o9xtOu4ww
	 9JgP9Z68AvNOv4jOCarUguOeRjTvJpwO3y63tyUP/PwTdlkqwU6QbTtwyixYrooAD6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7FD606A327
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 14:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE7FD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4e937c5bd4fso1416225b6e.2
        for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 06:11:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794665490; x=1795270290;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L/gzc6cM8spTMzuU/OusNDAYp5kZ9jRYawr5B+a9Xys=;
        b=FscBYhJmdZ1tAD8YpB6dBnYH3vectocq6ta1xvpgIQLbEQhl0CnJREuDbaIDRrcrl+
         uKUoAmBthkkYxtAg9XV72aAU9sAO2lduw2DxmDeA1eOliVsS7xttxYiGjxhbhBarX9mX
         Uw3eMCe10Qs6eAhHfCfw1GjDwYyKbgREQHlODjKMeL8hSNB5jHnjRvu/7H0kfpayz5aI
         Ng1nTT3JrZYPj9Ow0mwRmJu6iBbjGoXw2zB+UpI0pN9tGFvqXjurU2etn9o8pN/yGapV
         grYwiXsqmoclMgyOjCHd4hL/RstPzNdrCjOlUNbs5rlpyYVXSoYFa1ji3M3LmuT4imBD
         78MA==
X-Forwarded-Encrypted: i=1; AL+hErHwKyed6FA+fpLOYKKUiN08Uzn09kkS3mwyTh5iml0Dqv5ZSw3DlQ396YnjjwJ4qxuuzhyGQWU9HSA+T9voG8T+KINbLsM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9x02w6hyD0Fcx1hSg/cuC9U5LE0W6vKwDTA2nqvlZsW3NrEFL0
	hd48VZSvJUJxdwW284EYNGk55X+WhFcnJh6YEtwSw4HxqxcxaxKBOX66P5Cfx6kQuWkyRcIbsKB
	kyQkc6IjjzwUoPtINeiES/plJ5drePKKOo6GfTif8P7/q0fC491WqJvPMs0A=
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3186:b0:4b9:e5fa:8a17 with SMTP id
 5614622812f47-56e640ce1ffmr4462814b6e.28.1794665489930; Sat, 14 Nov 2026
 06:11:29 -0800 (PST)
Date: Sat, 14 Nov 2026 06:11:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6af86c11.aa201734.33d248.0004.GAE@google.com>
Subject: [syzbot] [lsm?] general protection fault in security_d_instantiate
From: syzbot <syzbot+d8a69701a6e796ad5d3e@syzkaller.appspotmail.com>
To: jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    84abb955b101 Add linux-next specific files for 20261113
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=139a103d580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9d5eeb0ba036071
dashboard link: https://syzkaller.appspot.com/bug?extid=d8a69701a6e796ad5d3e
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f2644d580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1592844d580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ffae1d4a717e/disk-84abb955.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fd2a35a63abf/vmlinux-84abb955.xz
kernel image: https://storage.googleapis.com/syzbot-assets/039ccf647778/bzImage-84abb955.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3aade0852b27/mount_0.gz

AI-generated root cause summary:
In squashfs_read_inode(), validation checks for directory types
SQUASHFS_DIR_TYPE and SQUASHFS_LDIR_TYPE jump to failed_read when inode->i_size
< 3 without initializing err to a negative errno (-EINVAL). Consequently, err
retains the positive byte count returned by the preceding
squashfs_read_metadata() call (sizeof(struct squashfs_dir_inode) == 32 == 0x20,
or 40 == 0x28 for LDIR). When squashfs_iget() receives this positive return
value, it invokes ERR_PTR(err), yielding an invalid non-negative pointer (e.g.
(void *)0x20) that bypasses IS_ERR() and NULL checks in d_splice_alias_ops().
Passing this bogus inode pointer to security_d_instantiate() causes a
NULL-pointer dereference when reading inode->i_flags at offset 0x24.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=d8a69701a6e796ad5d3e

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d8a69701a6e796ad5d3e@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 8
SQUASHFS error: Unable to read inode 0x87
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000004: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
CPU: 1 UID: 0 PID: 5647 Comm: syz-executor337 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
RIP: 0010:security_d_instantiate+0x2f/0x1d0 security/security.c:3781
Code: 41 57 41 56 53 48 89 f3 49 89 fe e8 bb 2c 20 fd 48 85 db 74 42 4c 8d 7b 04 4c 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 0f 85 9d 00 00 00 41 8b 2f 89 ee 81 e6 00 02 00
RSP: 0018:ffffc90003b1f758 EFLAGS: 00010203
RAX: 0000000000000004 RBX: 0000000000000020 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000020 RDI: ffff888077497d40
RBP: ffffc90003b1f9b0 R08: ffffffff91bec8bf R09: 1ffffffff237d917
R10: dffffc0000000000 R11: fffffbfff237d918 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff888077497d40 R15: 0000000000000024
FS:  0000555576a8a400(0000) GS:ffff8881234cd000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000000000c0 CR3: 0000000034bb2000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 d_splice_alias_ops+0x72/0x440 fs/dcache.c:3458
 squashfs_lookup+0xc5e/0x14e0 fs/squashfs/namei.c:273
 finish_lookup fs/namei.c:1934 [inline]
 lookup_open+0x816/0x16e0 fs/namei.c:4644
 open_last_lookups fs/namei.c:4880 [inline]
 path_openat+0x7a5/0x20e0 fs/namei.c:5119
 do_file_open+0x23e/0x4a0 fs/namei.c:5151
 do_sys_openat2+0x115/0x200 fs/open.c:1492
 do_sys_open fs/open.c:1498 [inline]
 __do_sys_openat fs/open.c:1838 [inline]
 __se_sys_openat fs/open.c:1833 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1833
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x171/0x540 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x00007f101b51a909
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd8afc50d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f101b51a909
RDX: 0000000000040042 RSI: 00002000000000c0 RDI: 00000000ffffff9c
RBP: 0000000000000001 R08: 00000000ec776000 R09: 00000000ec776000
R10: 0000000000000001 R11: 0000000000000246 R12: 00007ffd8afc5110
R13: 0000000000000002 R14: 431bde82d7b634db R15: 00007f101b57a04b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:security_d_instantiate+0x2f/0x1d0 security/security.c:3781
Code: 41 57 41 56 53 48 89 f3 49 89 fe e8 bb 2c 20 fd 48 85 db 74 42 4c 8d 7b 04 4c 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 0f 85 9d 00 00 00 41 8b 2f 89 ee 81 e6 00 02 00
RSP: 0018:ffffc90003b1f758 EFLAGS: 00010203
RAX: 0000000000000004 RBX: 0000000000000020 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000020 RDI: ffff888077497d40
RBP: ffffc90003b1f9b0 R08: ffffffff91bec8bf R09: 1ffffffff237d917
R10: dffffc0000000000 R11: fffffbfff237d918 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff888077497d40 R15: 0000000000000024
FS:  0000555576a8a400(0000) GS:ffff8881234cd000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000000000c0 CR3: 0000000034bb2000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	41 57                	push   %r15
   2:	41 56                	push   %r14
   4:	53                   	push   %rbx
   5:	48 89 f3             	mov    %rsi,%rbx
   8:	49 89 fe             	mov    %rdi,%r14
   b:	e8 bb 2c 20 fd       	call   0xfd202ccb
  10:	48 85 db             	test   %rbx,%rbx
  13:	74 42                	je     0x57
  15:	4c 8d 7b 04          	lea    0x4(%rbx),%r15
  19:	4c 89 f8             	mov    %r15,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 9d 00 00 00    	jne    0xd3
  36:	41 8b 2f             	mov    (%r15),%ebp
  39:	89 ee                	mov    %ebp,%esi
  3b:	81                   	.byte 0x81
  3c:	e6 00                	out    %al,$0x0
  3e:	02 00                	add    (%rax),%al


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
