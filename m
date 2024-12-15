Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA90653
	for <linux-security-module@vger.kernel.org>; Sun, 15 Dec 2024 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734299305; cv=none; b=YyV4DOMU1X5VV6DleuRHl6EX2WxQFqi7M0Tm19r6IUeFPJ34E7aT4NV6qEKDXGxmCVK+NRDvmLqUmNulRoyzJ3HVSWihgrITm9XiVsRBQbSVsdamP99twR8CxU1kwDRTBk2hBAzyZgS/Jp8YYH3yiV/q1HA9NXRwztyNKD2NsWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734299305; c=relaxed/simple;
	bh=IpgbfIy2DuNdrJKBdvsgJ9iI8u2s/h1Eh+cHoqnnd2E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jQrmNIUt3Yp5gx9373LhLG7U92CL3D0cXMqzFxdLD0jlhHaOcfQcf5+86RRdj+eVO5sMGkC0+1hUN3k8qo+PIUKXjGGUCnhFhU/Gk2fvX/JOCRifX4nMLF6s/JsaYH9r5VexEt6Dd7f4nctumCHb/ZCdIs/ehJ6vKgAv8seLm4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a7e0d5899bso73616405ab.0
        for <linux-security-module@vger.kernel.org>; Sun, 15 Dec 2024 13:48:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734299303; x=1734904103;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TBYYRxyJG0IroxJFpY7nB6aCRT29iLvmJ30t7+ONrcI=;
        b=jRpD3AuEOw9vzxXH8r+zm89oYu358K349/FYevKTXgOjja7u5lOuGF2I5ENRCk/0Fj
         K5Qvx6tWfo435WQnYXDU2valBb42s7P/+kym4xPe8XpWiC6V6MaUQZ+D0RiIQV79FoNU
         W0j7Cy+owA/vxt9NAV7c8gYLI6vVsaGeAm8bkZBUNkzF1asbpGRHKL1gNuNiItNbRHvt
         Y6uuqla+0t1Sj8OD3WXNnpvXMs07JUdjyAjKzrP1l9keqDaYvSbcwUVkJtjvQ1SzNg/V
         /17Sj00zI+6pEfFgWQUieN2AAff7x18ZRg4bsgf/8lwIdb1It/Dn6LdeFgCp3JERuZUD
         7gVg==
X-Forwarded-Encrypted: i=1; AJvYcCWzmyLC+Gum3l4SsuRcR9Arc03uJW6Vqzf7Fmwy/C4lsjHDQ7NNoozlTzJt/eSx3ZuchTvAyJFjq59rgmEYxqERWf88Jc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhAmmZe6VLg6XsQI5LqlefBebAYiqdAPBlNrpmDadxrcYlnYcv
	NNJRypuv3LX4c/A7Iwsh7GF1PDf3OiiwD555EQ1+6CmZ+WpJZS98r5N4l8t8FlyrLxgbl4yqcuh
	6bb6jFa41k0AExHqGOKHQsSscJMI11wY8se9YRRNGMjDKH4ajTpf0Jso=
X-Google-Smtp-Source: AGHT+IFe7PGDa6k6xeGn37MxcJm13J2M+qzHemq2/qD+jLVqleWB1u+7ENhWDwmJKNcsXG5lQ5X/rOMRHG1BIeICYUvzKBaJd2nz
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1846:b0:3a3:4175:79da with SMTP id
 e9e14a558f8ab-3afeee7924emr114778165ab.13.1734299303473; Sun, 15 Dec 2024
 13:48:23 -0800 (PST)
Date: Sun, 15 Dec 2024 13:48:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675f4ea7.050a0220.37aaf.0105.GAE@google.com>
Subject: [syzbot] [tomoyo?] WARNING in tomoyo_write_control
From: syzbot <syzbot+7536f77535e5210a5c76@syzkaller.appspotmail.com>
To: jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp, 
	tomoyo-dev-en@lists.osdn.me
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f932fb9b4074 Merge tag 'v6.13-rc2-ksmbd-server-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17855be8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5586995ec03b2
dashboard link: https://syzkaller.appspot.com/bug?extid=7536f77535e5210a5c76
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a12d44580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11fc4730580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f0d0c95f5364/disk-f932fb9b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/201cf3c7a7b5/vmlinux-f932fb9b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fcb972084579/bzImage-f932fb9b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7536f77535e5210a5c76@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5829 at mm/page_alloc.c:4727 __alloc_pages_noprof+0xeff/0x25b0 mm/page_alloc.c:4727
Modules linked in:
CPU: 1 UID: 0 PID: 5829 Comm: syz-executor788 Not tainted 6.13.0-rc2-syzkaller-00159-gf932fb9b4074 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:__alloc_pages_noprof+0xeff/0x25b0 mm/page_alloc.c:4727
Code: 24 2c 00 00 00 00 89 cd 0f 84 8b f9 ff ff 8b 34 24 48 89 da 8b 7c 24 08 e8 0e b3 fe ff e9 69 f9 ff ff c6 05 e1 44 16 0e 01 90 <0f> 0b 90 31 db e9 9f f3 ff ff 89 14 24 e8 9f a2 0c 00 8b 14 24 e9
RSP: 0018:ffffc90003e1f918 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 000000000000000b RDI: 0000000000040d40
RBP: 0000000000000000 R08: 0000000000000006 R09: 00000000003fffff
R10: 00000000003fffff R11: 0000000000000003 R12: 000000000000000b
R13: 0000000000040d40 R14: 1ffff920007c3f37 R15: 00000000003fffff
FS:  0000555571ba8380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000003ff000 CR3: 000000007b498000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 ___kmalloc_large_node+0x84/0x1b0 mm/slub.c:4228
 __kmalloc_large_node_noprof+0x1c/0x70 mm/slub.c:4255
 __do_kmalloc_node mm/slub.c:4271 [inline]
 __kmalloc_noprof.cold+0xc/0x63 mm/slub.c:4295
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 tomoyo_write_control+0x267/0x13d0 security/tomoyo/common.c:2668
 vfs_write+0x24c/0x1150 fs/read_write.c:677
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f569c4ea2e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffddff422d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ffddff424b8 RCX: 00007f569c4ea2e9
RDX: 00000000fffffdef RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f569c55d610 R08: 0000000000008000 R09: 0000000000008000
R10: 0000000000008000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffddff424a8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


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
