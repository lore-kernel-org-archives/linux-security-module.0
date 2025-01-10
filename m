Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D88620D513
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jan 2025 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736518888; cv=none; b=rrR2UVRI7yM/GkmXrXvYZYFG+wlTxUE6qwRvTjyCNPH+KcEr090Hhs4lsa346Jzio0eyDarODevF8jf/XJzN2FlEq4ghDw6MwdKhCG2fCiUUd4JIf337av9JyaiB6U2tDs6IJWwlhXoPBwsHN4RPtV5uLZe8/XhRC5hVohmW81M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736518888; c=relaxed/simple;
	bh=mjIAj2CGKDgV/gh2xXwu83huOJGHtSiKZlYcluESCpg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=I8oTIP3zxyp6U6oX5Ig06QsWZnUMJzJklhZ2jzvt3WQQ/iJkIVF1xT6sRDHDVQ1Vgo5W6hHk4MzM4VxyMR/RwzkRm11Cx2/Sk7TjTtTDADIThHe5kLHJ0S1WxP83xK8bULnfMVnFdiJ7bPwSZHUjgv1+p9uiuuQPk2pp85YxMt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a7e0d5899bso40929835ab.0
        for <linux-security-module@vger.kernel.org>; Fri, 10 Jan 2025 06:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736518885; x=1737123685;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FwV/JgNmZqAzQiWUpKB2Jk68TmInVBwAYYodij69KIk=;
        b=GnHRDbXqA9weSzeX9kvkkbdpdKUuQx98rexsPQJ/oK2SbZLyorU4EBCzgosCt2TRGT
         5BV3H7l43oVr2oVjI1kZR8beSnnTvrqWrl3OGGSLK8SGGZWIxcgam05vAzNPGjsk7imn
         k8HiehWawRA7HrmPb8E+YLKNzFdWSijqIWIZ0Hi3oh/IPou4P69rc4aDfkdu5QU9qG9P
         dy7BLKtbDohU7FIEDUxeI2u4wZMvvmu1szwihBSHMuyC3/vE9cmJwRC3fm+dDK0TO+y1
         E1lOcs07SJ7Zqi7Bjxfyf4CRzMODQ0X8LFB02O4p7N3PPNr+3j/9KX181OBlYDTr3nge
         lUDg==
X-Forwarded-Encrypted: i=1; AJvYcCVlwY8aI4+Pxqh2d0BkiX91buMHNl6wvgvIUjsz0W+xekaqUETO+nIVHLs5r5JTMxtgSLxr8sIW6xCNaoEw3CNJGZz3UTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw12t4bgKr8a5N4MhnAQRV8YLrsXxsqSRsZ8KjqDBXsaB8R6v/h
	YE6LtO+8DA2C7d+ckyeoWkX4mxrgM7r9lI9PEarDtq4EZiS6S2zglkVVNYIhHaAGc1d5rFg9fkb
	Vlb4WljJwOUBJpTrAu7SbDDmDtNU863h7VNdDY0BZ+zo9rD0RfZEWaTA=
X-Google-Smtp-Source: AGHT+IHnhIXGMv/r55fB4F29iQnzQw3Nhr4nPbr3cbniSxV6frUvzJIP/IjBoXl00fAjze2UqQnfsWfmpv5/MTPooKq+0fdB2H31
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b44:b0:3a7:15aa:3fcc with SMTP id
 e9e14a558f8ab-3ce3a86a440mr96126615ab.1.1736518885664; Fri, 10 Jan 2025
 06:21:25 -0800 (PST)
Date: Fri, 10 Jan 2025 06:21:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67812ce5.050a0220.d0267.002e.GAE@google.com>
Subject: [syzbot] [tomoyo?] general protection fault in tomoyo_get_name (2)
From: syzbot <syzbot+298f8ae1e0bde70f8e0d@syzkaller.appspotmail.com>
To: jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp, 
	tomoyo-dev-en@lists.osdn.me
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fc033cf25e61 Linux 6.13-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14146af8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86dd15278dbfe19f
dashboard link: https://syzkaller.appspot.com/bug?extid=298f8ae1e0bde70f8e0d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/667548f224c3/disk-fc033cf2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/66b97f5d4785/vmlinux-fc033cf2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b27868bf31d2/bzImage-fc033cf2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+298f8ae1e0bde70f8e0d@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000004: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
CPU: 1 UID: 0 PID: 20911 Comm: getty Not tainted 6.13.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:tomoyo_get_name+0xed/0x490 security/tomoyo/memory.c:167
Code: 48 8b 98 40 af 51 9a 48 39 dd 0f 84 53 01 00 00 49 bd 00 00 00 00 00 fc ff df e8 de 2c 47 fd 48 8d 7b 20 48 89 f8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 74 08 3c 03 0f 8e 00 03 00 00 44 8b 7b 20 44
RSP: 0018:ffffc9000c44f2d0 EFLAGS: 00010202
RAX: 0000000000000004 RBX: 0000000000000000 RCX: ffffffff8452230d
RDX: ffff888064da9e00 RSI: ffffffff845222e2 RDI: 0000000000000020
RBP: ffffffff9a51afa0 R08: 0000000000000004 R09: 0000000000000000
R10: 000000008332dfba R11: 0000000000000001 R12: 000000008332dfba
R13: dffffc0000000000 R14: ffff888029ad8d0a R15: 0000000000000000
FS:  00007f89fe493380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561fe8218cc8 CR3: 0000000030f66000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tomoyo_parse_name_union+0x121/0x1f0 security/tomoyo/util.c:260
 tomoyo_update_path_acl security/tomoyo/file.c:395 [inline]
 tomoyo_write_file+0x4d3/0x7f0 security/tomoyo/file.c:1022
 tomoyo_write_domain2+0x129/0x1f0 security/tomoyo/common.c:1144
 tomoyo_add_entry security/tomoyo/common.c:2034 [inline]
 tomoyo_supervisor+0x4ad/0x1180 security/tomoyo/common.c:2095
 tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
 tomoyo_path_permission security/tomoyo/file.c:587 [inline]
 tomoyo_path_permission+0x270/0x3b0 security/tomoyo/file.c:573
 tomoyo_check_open_permission+0x37d/0x3c0 security/tomoyo/file.c:777
 tomoyo_file_open+0x6b/0x90 security/tomoyo/tomoyo.c:334
 security_file_open+0x84/0x1e0 security/security.c:3105
 do_dentry_open+0x57e/0x1ea0 fs/open.c:928
 vfs_open+0x82/0x3f0 fs/open.c:1075
 do_open fs/namei.c:3828 [inline]
 path_openat+0x1e6a/0x2d60 fs/namei.c:3987
 do_filp_open+0x20c/0x470 fs/namei.c:4014
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1428
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f89fe5e79a4
Code: 24 20 48 8d 44 24 30 48 89 44 24 28 64 8b 04 25 18 00 00 00 85 c0 75 2c 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 60 48 8b 15 55 a4 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007fff57111b40 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f89fe5e79a4
RDX: 0000000000000000 RSI: 00007f89fe77bf2c RDI: 00000000ffffff9c
RBP: 00007f89fe77bf2c R08: 0000000000000008 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f89fe78d513 R14: 0000000000000001 R15: 0000000000000002
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:tomoyo_get_name+0xed/0x490 security/tomoyo/memory.c:167
Code: 48 8b 98 40 af 51 9a 48 39 dd 0f 84 53 01 00 00 49 bd 00 00 00 00 00 fc ff df e8 de 2c 47 fd 48 8d 7b 20 48 89 f8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 74 08 3c 03 0f 8e 00 03 00 00 44 8b 7b 20 44
RSP: 0018:ffffc9000c44f2d0 EFLAGS: 00010202
RAX: 0000000000000004 RBX: 0000000000000000 RCX: ffffffff8452230d
RDX: ffff888064da9e00 RSI: ffffffff845222e2 RDI: 0000000000000020
RBP: ffffffff9a51afa0 R08: 0000000000000004 R09: 0000000000000000
R10: 000000008332dfba R11: 0000000000000001 R12: 000000008332dfba
R13: dffffc0000000000 R14: ffff888029ad8d0a R15: 0000000000000000
FS:  00007f89fe493380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30d0dff8 CR3: 0000000030f66000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 8b 98 40 af 51 9a 	mov    -0x65ae50c0(%rax),%rbx
   7:	48 39 dd             	cmp    %rbx,%rbp
   a:	0f 84 53 01 00 00    	je     0x163
  10:	49 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%r13
  17:	fc ff df
  1a:	e8 de 2c 47 fd       	call   0xfd472cfd
  1f:	48 8d 7b 20          	lea    0x20(%rbx),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	74 08                	je     0x3b
  33:	3c 03                	cmp    $0x3,%al
  35:	0f 8e 00 03 00 00    	jle    0x33b
  3b:	44 8b 7b 20          	mov    0x20(%rbx),%r15d
  3f:	44                   	rex.R


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
