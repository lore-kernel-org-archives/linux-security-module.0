Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C5A126C10
	for <linux-security-module@vger.kernel.org>; Fri, 15 Nov 2024 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731697474; cv=none; b=LJ7fhCSydaudMwdAp6LnHEIfGla5yUJlEogH4A/LGOULzVEDOS8x5+HaxDoeZX2VGKtYX637xPdPj8a2sQphSSKemtLP0En0GYkNo205DF8qaocOjoSDxnhrQuJlXJSA53Ijcy8FjAgYkQBKVE+28WzhSOF6pEj2GU5hFlNlqoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731697474; c=relaxed/simple;
	bh=RqoaPyle6AhgXj44zMAywhohYrVIBDR1YleC07B2gzI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KbFN11Ypbtw79Y3P/Q3i0v1WgwUZyXaIl2oU9/ozKeKOj5KrcVITlsYISCEVTqpELNiaOrkOy9Uy05C56EGH0QGcZXiZ1+r0f3f/7hnNEif7Gd3/OFE4a25fkvi48b91UJdktP8pK+rIqnAZ65jvD/85tC3GMt2XS1XuaAqj9d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83adc5130e3so107382539f.0
        for <linux-security-module@vger.kernel.org>; Fri, 15 Nov 2024 11:04:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731697472; x=1732302272;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yp5h//oLzoC6374LvAAklgUbuPJM8OxXuxClcyxNTnk=;
        b=vI+WuE4P/eg7BqE/n2cQyEWo16XIMYju0dkgynexXbQ4grZAT3MrHzsVpCnU12ngUo
         ++1BWg2YZovlPAc6jxxjd1MDPHGEeo1LX6LNH6Z1y36V/umbGaZ+wYKRXv3gQKEdsagn
         aaWV2L/uWx9HO0JvfEUNh3Mkp66AQyCCQnX8nv9/Cxx7w9ABoS33G7QSNr1VkYpf3YDI
         I16prRPvRZjqP1kaQBhnBnQe1DkIgjhN++LmQjEk+ey8sKTg5ba8AkSDYSBYgQbyxIea
         OFUQBsXS+SSTuzhnPCv/WFiCYRMbIKmCpQ3APbqE+l6iplh5f6RbDrPHvOrzJBI1xh9z
         m4aA==
X-Forwarded-Encrypted: i=1; AJvYcCWx3downrezu+mpWAz5I9OAkfOqdYxyciPARiN1M0e4/7uxB+QiIF3Z1h0Yq/GM1ztvILbGitVFaCLlzx00fHj6B1S5ccc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuuvFJl9eZrxs/cYlfiIBSq7f0wmDrAWeMP7wfbRZVvs2obuWg
	f0EghMk3ecXIGTvjXBoqTlCzuZmX6ofJ8po1Qn3pgNi37tqfQimtL9SqlXwnKp0eL1WnwxVmMeq
	7C3EdE5pTntCK5kANsl/C5s+ZQAItAVpnAuFCym4reGoIyeUXU2Ib1Zc=
X-Google-Smtp-Source: AGHT+IFfsYlt4YiX3VHukn8Jmu357hVqEqTkJGzU/XPze01Kk/BIvCVPvVT2NjY6bEmFbr6a4/P+seFK6PbnCxvmG+vJq1DsGvFX
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218e:b0:3a4:e4d0:9051 with SMTP id
 e9e14a558f8ab-3a74808cc3emr41775455ab.24.1731697471800; Fri, 15 Nov 2024
 11:04:31 -0800 (PST)
Date: Fri, 15 Nov 2024 11:04:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67379b3f.050a0220.85a0.0001.GAE@google.com>
Subject: [syzbot] [lsm?] WARNING in get_mode_access
From: syzbot <syzbot+360866a59e3c80510a62@syzkaller.appspotmail.com>
To: gnoack@google.com, jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, mic@digikod.net, paul@paul-moore.com, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2d5404caa8c7 Linux 6.12-rc7
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1592d35f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c3a3896a92fb300b
dashboard link: https://syzkaller.appspot.com/bug?extid=360866a59e3c80510a62
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f0b8c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c87ea7980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f7fdf3a28c09/disk-2d5404ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/37016caab507/vmlinux-2d5404ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ee15f845ad51/bzImage-2d5404ca.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2518ff26b7ab/mount_0.gz

Bisection is inconclusive: the first bad commit could be any of:

385975dca53e landlock: Set up the security framework and manage credentials
afe81f754117 landlock: Add ptrace restrictions
1aea7808372e LSM: Infrastructure management of the superblock
ae271c1b14de landlock: Add ruleset and domain management
90945448e983 landlock: Add object management
cb2c7d1a1776 landlock: Support filesystem access-control
83e804f0bfee fs,security: Add sb_delete hook

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11f60ce8580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+360866a59e3c80510a62@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5839 at security/landlock/fs.c:971 get_mode_access security/landlock/fs.c:971 [inline]
WARNING: CPU: 0 PID: 5839 at security/landlock/fs.c:971 get_mode_access+0xae/0xc0 security/landlock/fs.c:951
Modules linked in:
CPU: 0 UID: 0 PID: 5839 Comm: syz-executor461 Not tainted 6.12.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:get_mode_access security/landlock/fs.c:971 [inline]
RIP: 0010:get_mode_access+0xae/0xc0 security/landlock/fs.c:951
Code: c2 66 81 fb 00 10 75 1c bd 00 04 00 00 eb b4 66 81 fb 00 80 75 0e bd 00 01 00 00 eb a6 bd 00 08 00 00 eb 9f e8 a3 0e 3c fd 90 <0f> 0b 90 31 ed eb 92 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90
RSP: 0018:ffffc900040d7b58 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 000000000000f000 RCX: ffffffff84516b24
RDX: ffff888034d40000 RSI: ffffffff84516bad RDI: 0000000000000003
RBP: 0000000000001000 R08: 0000000000000003 R09: 000000000000c000
R10: 000000000000f000 R11: 0000000000000000 R12: 0000000000000001
R13: ffff888075ce1478 R14: 0000000000400000 R15: ffff888079c0d608
FS:  000055558f349380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066c7e0 CR3: 0000000031b8c000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 current_check_refer_path+0x253/0x710 security/landlock/fs.c:1127
 security_path_rename+0x160/0x3c0 security/security.c:2022
 do_renameat2+0x7a0/0xdd0 fs/namei.c:5157
 __do_sys_renameat2 fs/namei.c:5204 [inline]
 __se_sys_renameat2 fs/namei.c:5201 [inline]
 __x64_sys_renameat2+0xe7/0x130 fs/namei.c:5201
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f48877e0679
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcbfbffbf8 EFLAGS: 00000246 ORIG_RAX: 000000000000013c
RAX: ffffffffffffffda RBX: 00007ffcbfbffdc8 RCX: 00007f48877e0679
RDX: 00000000ffffff9c RSI: 0000000020000780 RDI: 00000000ffffff9c
RBP: 00007f4887854610 R08: 0000000000000002 R09: 00007ffcbfbffdc8
R10: 00000000200007c0 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffcbfbffdb8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
