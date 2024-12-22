Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAF686250
	for <linux-security-module@vger.kernel.org>; Sun, 22 Dec 2024 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734895947; cv=none; b=a1cYuItcpmvlvHLkuRuBo0NQJsEkvDFc6Wsc4sZkDioCfXGeo/1bW6oS/zfdIteR1wH6fMtJWlZWcIJkq8ylLBl+ouRTVBVIlzMRXLAMIknaWmTqb38tABGU6w0pRNxn10oX0ZgthAL7jJFGIVWCaRmQ429GjoTVXLfonHTswic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734895947; c=relaxed/simple;
	bh=cHFBaJEIlU0sdjEESE3D2Yc/gmf3xMuXR7oktuijocc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Hwqwg8zHkYBlVOVVxXwBRALaAOnAX/8zLr5GAoPaB0M/g5a2eCEvbkamQNP4ANuyMXHb9M0Zy7Qnxmq+GmR7ZbMW4kQwbBrZ01bu5T41nInu6PEM5FEksRM5qxxE3n04BKcb6EkYF+ehXDFw7Ur5qW29ZRD8r/JueilZ+XCn0NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3abe7375ba6so66552555ab.3
        for <linux-security-module@vger.kernel.org>; Sun, 22 Dec 2024 11:32:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734895944; x=1735500744;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fPGGNM8fyCSnY7gLpJmwZ9EXwmxm1TR3YqA346xxr0o=;
        b=XSsO7Z2QrqghojT0s8YxmCpedmS6AVz4rK64JoMLutiYcjo91izOwrSHsb5hbu5zos
         Ih+1wZfOSGa5j6b2L25c5byGZXWpHjOEMzK3/845ViHyT0fMMp7vW9iYEMoZqHOxYQnm
         J7lMXWLS0wKSfgkviOlYjNTe3lkMtlHe/Mn/CzZv5sQD0oMNUdiCQgzfDf2cVzsVWjcH
         +ZC8xmaR2fhZbQ6AsUwnoAPmPjgzamnJsleBv+WwVedKTRsXqdrf9FOiCupy10aC9Iv7
         CdIFADCzlp1aAB7bbsuUl95zPhZmTA8f3G2xtfvGdHm3AyH3x2ng9a9jzTcWMQX5SO1H
         jA1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGtokYGfxqQ4EauFARwJeMirGCJu4k9AGVZwuHIafhsVRz1fWqAldcUa13BDkLTUauL+UF2uLRfvS4Tp8whR+2hAzJPps=@vger.kernel.org
X-Gm-Message-State: AOJu0YySc8Dr+zkOdspyT2B56uL1RclsqTH9mhqCnTEKNTwwRiaLuxbO
	lywAxr1wcplUb/+r68Qtboos0BIqpTHVjoH2Qpf8u8307k1iSscDah5r7t7DKFXPcSCVJ06l+8X
	R7RzbwtS9DTutxJL2G5BvhF3QpM5aooAXPKNliG+iM3dERrp/SkmoOjY=
X-Google-Smtp-Source: AGHT+IFMTHqHyxvU9v8CNCXzTLFHrKEsvC8THKznn1YhooSnYtRGr/8tj1zM3Sn2WjcMp5douUqV1FhaZZMelLLXCgoOtXiwei/O
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc4:b0:3a7:70a4:6877 with SMTP id
 e9e14a558f8ab-3c2d25669eemr85323485ab.7.1734895944556; Sun, 22 Dec 2024
 11:32:24 -0800 (PST)
Date: Sun, 22 Dec 2024 11:32:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67686948.050a0220.2f3838.0009.GAE@google.com>
Subject: [syzbot] [tomoyo?] general protection fault in tomoyo_init_request_info
From: syzbot <syzbot+7eb588c75c6a184272af@syzkaller.appspotmail.com>
To: jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp, 
	tomoyo-dev-en@lists.osdn.me
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aef25be35d23 hexagon: Disable constant extender optimizati..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13c28cf8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c22efbd20f8da769
dashboard link: https://syzkaller.appspot.com/bug?extid=7eb588c75c6a184272af
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102dc2df980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c28cf8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/aa655a321f64/disk-aef25be3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/222a3010db12/vmlinux-aef25be3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7eab659ce042/bzImage-aef25be3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7eb588c75c6a184272af@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000a: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000050-0x0000000000000057]
CPU: 0 UID: 0 PID: 7300 Comm: syz-executor176 Not tainted 6.13.0-rc3-syzkaller-00044-gaef25be35d23 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:tomoyo_init_request_info+0x6f/0x370 security/tomoyo/util.c:1028
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 98 02 00 00 48 8d 7d 50 48 89 6b 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 06 0f 8e 5d 02 00 00 48 8d 7b 4b 44 0f b6 6d
RSP: 0018:ffffc900057e7790 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffffc900057e7808 RCX: 0000000000000000
RDX: 000000000000000a RSI: ffffffff8452d677 RDI: 0000000000000050
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: ffffc900057e7808 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000109002 R14: ffff88802ede1580 R15: 0000000000000006
FS:  00007fea9dad26c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffd27aa9d8 CR3: 0000000030f1a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tomoyo_check_open_permission+0x27a/0x3c0 security/tomoyo/file.c:769
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
RIP: 0033:0x7fea9db23ee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fea9dad2218 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fea9dba8408 RCX: 00007fea9db23ee9
RDX: 0000000000189002 RSI: 0000000020000100 RDI: ffffffffffffff9c
RBP: 00007fea9dba8400 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fea9db74ed0
R13: 8000000000000000 R14: 00004000000000df R15: 006e716e5f797265
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:tomoyo_init_request_info+0x6f/0x370 security/tomoyo/util.c:1028
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 98 02 00 00 48 8d 7d 50 48 89 6b 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 06 0f 8e 5d 02 00 00 48 8d 7b 4b 44 0f b6 6d
RSP: 0018:ffffc900057e7790 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffffc900057e7808 RCX: 0000000000000000
RDX: 000000000000000a RSI: ffffffff8452d677 RDI: 0000000000000050
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: ffffc900057e7808 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000109002 R14: ffff88802ede1580 R15: 0000000000000006
FS:  00007fea9dad26c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fea9db732c8 CR3: 0000000030f1a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 89 fa             	mov    %rdi,%rdx
   3:	48 c1 ea 03          	shr    $0x3,%rdx
   7:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   b:	0f 85 98 02 00 00    	jne    0x2a9
  11:	48 8d 7d 50          	lea    0x50(%rbp),%rdi
  15:	48 89 6b 10          	mov    %rbp,0x10(%rbx)
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	74 06                	je     0x38
  32:	0f 8e 5d 02 00 00    	jle    0x295
  38:	48 8d 7b 4b          	lea    0x4b(%rbx),%rdi
  3c:	44                   	rex.R
  3d:	0f                   	.byte 0xf
  3e:	b6 6d                	mov    $0x6d,%dh


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
