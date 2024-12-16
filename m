Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F971201026
	for <linux-security-module@vger.kernel.org>; Mon, 16 Dec 2024 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734342923; cv=none; b=qHRkg9k+66mUY+k3VV9GsQcR4zV7CHDn4s1JTY35H0d4A2XxgEJqOumEOmWwnfibfmjRCgmH35FBQft/3D1n89Og0DJzA+LDf639kx2GAsoBd3IO6PzJetvT8RRBLP+kKx7ZIvtS8Tu0WYEwmnuCcJQdcoRQU951+xkdGgHMHkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734342923; c=relaxed/simple;
	bh=dHV/ZgWHFPAmXz+2JlTvxNjPV8275MuS6r+tMv6RFts=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=T2TKReSvPBKJCJaSRYuRN5rVeE1IxgpQNMXUB1x0wOyj2mZxsEP7M25CI5Kncjs2s4+QVNPO1NCOU5vsXMa1PDIAPxSabc1UBTRylJxXLEuqsV2C5OAG+g8Tq8iVMe3bv4U6MnLM/OfdK4JVxMQTardWpxQ9I6+7pI/3D7jsskU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a81754abb7so76109405ab.2
        for <linux-security-module@vger.kernel.org>; Mon, 16 Dec 2024 01:55:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734342921; x=1734947721;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G2dM8c7wOazd4HvHKBAOliKpjEEJQbu4B0++LR6egJo=;
        b=hkbibHQA2YAqUrFGhLUVpIIqQ6Ch1Kd9RKF8LssBsoDVHi31A7fklLanSTleUkw/BK
         H49SUXDk+wbMC25N7+iGxX+QdCJCNgcuI3/3YThSm3X1YxouElm4Vq6c0zCBlWNmC4QV
         RnQJCKfz93Bd9FCwR2aTwkBmus18SkaXdMenHiFwFtBo2Qg8kfTUezpte7MOYw6C2tN1
         0D44R+wikfcx19TT8UaUKDwZIunASMy+DDKLBp1v7hFmO7PxRvD9G4c1FTGKuoMIVcqE
         J5mcKOpOMq2bZByvZufufk4qeoaqt7AoimWDxZBt7fveAJ4zyhotumYcQapJK0uohRh6
         1UFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2xX/13tvx1ooM1YNu6BdLJVi4XuKhJLnH6YZ6N+OT2YAgexRQChqw6rs+n5TZUo7YM1aoeubNaM1RsJxGsr+ub6mYLRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ+SfopHlvLDGznC4S2m6/T33Wy6iOxIC4Fv+ueEKeQe0yqVYJ
	7d/TXnwhPQNDG2g29w7pY1MnExIBFJ4vYXYaCDtEtacOEig4P/oWowViIC2g0wp8jZRa9Jurvnc
	V4mtvjuCZcZiOs41Gu/DJyrzoKUc/TXkUfxEn02r2zdzLTgSbPT51DQ0=
X-Google-Smtp-Source: AGHT+IFg5RI5ZQe9ZHKRxgC3zzAb8krRBFJIxcogaqAOFViZsNEH/7VIEDIpfpxxDamX3hdhVg3KYGiEp/P0o/WO4lxuRnkm1j/F
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3288:b0:3a7:159d:2dd8 with SMTP id
 e9e14a558f8ab-3afedc1a255mr124360125ab.7.1734342921338; Mon, 16 Dec 2024
 01:55:21 -0800 (PST)
Date: Mon, 16 Dec 2024 01:55:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675ff909.050a0220.37aaf.012b.GAE@google.com>
Subject: [syzbot] [tomoyo?] general protection fault in tomoyo_check_acl (4)
From: syzbot <syzbot+2232f2316fe61cb50344@syzkaller.appspotmail.com>
To: jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp, 
	tomoyo-dev-en@lists.osdn.me
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2d8308bf5b67 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10507cdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5586995ec03b2
dashboard link: https://syzkaller.appspot.com/bug?extid=2232f2316fe61cb50344
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/66039e873a32/disk-2d8308bf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/60744ba3f743/vmlinux-2d8308bf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/25731ba013ad/bzImage-2d8308bf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2232f2316fe61cb50344@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 UID: 0 PID: 15160 Comm: scsi_id Not tainted 6.13.0-rc2-syzkaller-00362-g2d8308bf5b67 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:tomoyo_check_acl+0xb0/0x410 security/tomoyo/domain.c:173
Code: 00 0f 85 57 03 00 00 49 8b 5d 00 49 39 dd 0f 84 fc 01 00 00 e8 c1 0d 48 fd 48 8d 7b 18 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <0f> b6 04 28 38 d0 7f 08 84 c0 0f 85 cc 02 00 00 44 0f b6 7b 18 31
RSP: 0018:ffffc9000c087718 EFLAGS: 00010246
RAX: 0000000000000003 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff8451302f RDI: 0000000000000018
RBP: dffffc0000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffffc9000c087808
R13: ffff888028c55690 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f24ab591ba8 CR3: 000000003bf9a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tomoyo_path_permission security/tomoyo/file.c:586 [inline]
 tomoyo_path_permission+0x1ff/0x3b0 security/tomoyo/file.c:573
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
RIP: 0033:0x7f24ab607a46
Code: 10 00 00 00 44 8b 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 44 89 c2 4c 89 ce bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 0c f7 d8 89 05 0a 48 01 00 48 83 c8 ff c3 31
RSP: 002b:00007ffc0a43e228 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007ffc0a43e488 RCX: 00007f24ab607a46
RDX: 0000000000080000 RSI: 00007ffc0a43e2a0 RDI: 00000000ffffff9c
RBP: 00007ffc0a43e290 R08: 0000000000080000 R09: 00007ffc0a43e2a0
R10: 0000000000000000 R11: 0000000000000287 R12: 00007ffc0a43e2a0
R13: 0000000000000009 R14: 00007ffc0a43e46f R15: 00000000ffffffff
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:tomoyo_check_acl+0xb0/0x410 security/tomoyo/domain.c:173
Code: 00 0f 85 57 03 00 00 49 8b 5d 00 49 39 dd 0f 84 fc 01 00 00 e8 c1 0d 48 fd 48 8d 7b 18 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <0f> b6 04 28 38 d0 7f 08 84 c0 0f 85 cc 02 00 00 44 0f b6 7b 18 31
RSP: 0018:ffffc9000c087718 EFLAGS: 00010246
RAX: 0000000000000003 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff8451302f RDI: 0000000000000018
RBP: dffffc0000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffffc9000c087808
R13: ffff888028c55690 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32016ff8 CR3: 000000003bf9a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 0f                	add    %cl,(%rdi)
   2:	85 57 03             	test   %edx,0x3(%rdi)
   5:	00 00                	add    %al,(%rax)
   7:	49 8b 5d 00          	mov    0x0(%r13),%rbx
   b:	49 39 dd             	cmp    %rbx,%r13
   e:	0f 84 fc 01 00 00    	je     0x210
  14:	e8 c1 0d 48 fd       	call   0xfd480dda
  19:	48 8d 7b 18          	lea    0x18(%rbx),%rdi
  1d:	48 89 f8             	mov    %rdi,%rax
  20:	48 89 fa             	mov    %rdi,%rdx
  23:	48 c1 e8 03          	shr    $0x3,%rax
  27:	83 e2 07             	and    $0x7,%edx
* 2a:	0f b6 04 28          	movzbl (%rax,%rbp,1),%eax <-- trapping instruction
  2e:	38 d0                	cmp    %dl,%al
  30:	7f 08                	jg     0x3a
  32:	84 c0                	test   %al,%al
  34:	0f 85 cc 02 00 00    	jne    0x306
  3a:	44 0f b6 7b 18       	movzbl 0x18(%rbx),%r15d
  3f:	31                   	.byte 0x31


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
