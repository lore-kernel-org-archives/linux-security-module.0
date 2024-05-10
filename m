Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6E35339E
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715347702; cv=none; b=HbJNEY4tuKGpqxfVTH0b9V8mDkKM7RdBMhz1Tit3uUn43TRMjdw28fN08CUldsZdlGB37P+Vixu4d50fdnnoJwCV4MMFCfSyUIwvP3ouwOuiZbLciw7c+ujEmPDvS+SQPt8jVrUFzdcycmP9KzvGsOSnsyNCf6cSsx4uoe7ieOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715347702; c=relaxed/simple;
	bh=EGfMHM/e17V+TY+MO2iQIR8Vb263lScsvwNmu7geQ/U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uVnFOacXfkCt4MagPM8rPSfBxUAN66OvES9aUwQRfyOndmBffb8mjmb7dTkCHbZkDkG7k6bhM9zFFq94k4Wiy2YyhDZPVmwyXNmGj9IzZaoUxLfpFQIRNxa/TLp6fQSy9gLfFaoIbKN61OMduKKhjI1XzNvCUbufc1gzgfWXUn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7e1849aee8cso212289539f.1
        for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 06:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715347700; x=1715952500;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSQQY9/6Se3eHqOviSCpoULuEJvdI1rJKRpLPKQqSqs=;
        b=YPVFUCa4XLkbj5B12adJWCiAxepPO3iLPcN25k0BJyD1SubhwqNfISkRSzGWD4+ysG
         OQapV0K2VOSOxKJ7h/Ia1QwZ1nLfh3UDFa8nE/hYjzpge+m76CjAWjlmc5tr7InB2GvN
         BvH25Nr+8qMLYvmvbY+rwndyGCFGuxy7cRelfoPetQBqOyaSG6EyA/uY8QqgtfTp8wMT
         LtVp8Vx7/T0URFr0HJcTOkhX1YIQuZ0B+yFJfHMrp1W/QH/9n0CbvCcPADELv/7ceWbd
         DlWU27ujQSGbdxv3UAe69eDrA2Gn7LIGmp0zxBWQgi6VKSWbeV7b7iGRPxMjcsvBP3Ig
         EEKg==
X-Forwarded-Encrypted: i=1; AJvYcCXsYbmhwOpIiat89zl0qNiPD3qQGs+lJeLxWau0OeWRVCGy94GeVTEev+Fs9FJOIPKQiORIlfw/ntJAvzEBRecgc7VkfUDUNJDThO1J2nHamujefXzP
X-Gm-Message-State: AOJu0Yzdrt4QyZTM6M7wO4Fp4/QIf9f1lu9PaVIxy5UmISeeNLwQCLU+
	bK6m/XX8WpPlTw4StRgAsHzKj/4F83S/jC/l2ltABOSh4aFI31zJJ0ErnBqA0Gx5tMQ7Sh7mXeM
	VIAMYgZu9WsBYBGRw3w7tDKStydpCaHjtmsxO/GEuxwr73h4orMy9Y/c=
X-Google-Smtp-Source: AGHT+IGJExUYxPd8CAMlcFIKliveeAPDQDmtcHqv89Yk0eRnA0U9mdSOPqI9n4OdirQM58m7o0JcYEebkVFXSk/X+fJJM5SrBQRp
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8523:b0:488:59cc:eb41 with SMTP id
 8926c6da1cb9f-48959eb6a06mr177842173.3.1715347700133; Fri, 10 May 2024
 06:28:20 -0700 (PDT)
Date: Fri, 10 May 2024 06:28:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000553d3f0618198200@google.com>
Subject: [syzbot] [lsm?] WARNING in collect_domain_accesses
From: syzbot <syzbot+bf4903dc7e12b18ebc87@syzkaller.appspotmail.com>
To: gnoack3000@gmail.com, jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, llvm@lists.linux.dev, mic@digikod.net, 
	nathan@kernel.org, ndesaulniers@google.com, paul@paul-moore.com, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    45db3ab70092 Merge tag '6.9-rc7-ksmbd-fixes' of git://git..=
.
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D13b36604980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6d14c12b661fb43
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dbf4903dc7e12b18eb=
c87
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D100235b898000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10d57c5c980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/580d5c8a46be/disk-=
45db3ab7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9f8c7366d3dc/vmlinux-=
45db3ab7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3207c810f03e/bzI=
mage-45db3ab7.xz

The issue was bisected to:

commit 55e55920bbe3ccf516022c51f5527e7d026b8f1d
Author: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Date:   Wed Aug 31 20:38:40 2022 +0000

    landlock: Fix file reparenting without explicit LANDLOCK_ACCESS_FS_REFE=
R

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D109badd49800=
00
final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D129badd49800=
00
console output: https://syzkaller.appspot.com/x/log.txt?x=3D149badd4980000

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+bf4903dc7e12b18ebc87@syzkaller.appspotmail.com
Fixes: 55e55920bbe3 ("landlock: Fix file reparenting without explicit LANDL=
OCK_ACCESS_FS_REFER")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5081 at security/landlock/fs.c:880 collect_domain_acce=
sses+0x251/0x2b0 security/landlock/fs.c:880
Modules linked in:
CPU: 0 PID: 5081 Comm: syz-executor216 Not tainted 6.9.0-rc7-syzkaller-0005=
6-g45db3ab70092 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 04/02/2024
RIP: 0010:collect_domain_accesses+0x251/0x2b0 security/landlock/fs.c:880
Code: e8 b4 e0 a1 fd eb 08 e8 bd c2 25 fd 40 b5 01 89 e8 48 83 c4 08 5b 41 =
5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 a0 c2 25 fd 90 <0f> 0b 90 31 ed 4=
9 89 df eb c9 e8 90 c2 25 fd 90 0f 0b 90 eb cd 44
RSP: 0018:ffffc900035f7ba0 EFLAGS: 00010293
RAX: ffffffff847045e0 RBX: ffff88801d6be178 RCX: ffff88801fc28000
RDX: 0000000000000000 RSI: 0000000000003fff RDI: ffff88801d6be1c8
RBP: 0000000000000000 R08: ffffffff846fccdb R09: 1ffffffff1f51f15
R10: dffffc0000000000 R11: fffffbfff1f51f16 R12: ffffc900035f7c80
R13: 0000000000003fff R14: ffff88807f4542f0 R15: ffff88801d6be178
FS:  000055555cfaa380(0000) GS:ffff8880b9400000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066c7e0 CR3: 000000002c1b4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 current_check_refer_path+0x9b6/0xe70 security/landlock/fs.c:1001
 security_path_link+0xc5/0x120 security/security.c:1894
 do_linkat+0x2db/0x760 fs/namei.c:4673
 __do_sys_linkat fs/namei.c:4704 [inline]
 __se_sys_linkat fs/namei.c:4701 [inline]
 __x64_sys_linkat+0xdd/0xf0 fs/namei.c:4701
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7eff2d2bb329
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff0aacff18 EFLAGS: 00000246 ORIG_RAX: 0000000000000109
RAX: ffffffffffffffda RBX: 00007fff0aad00e8 RCX: 00007eff2d2bb329
RDX: 00000000ffffff9c RSI: 0000000020000000 RDI: 00000000ffffff9c
RBP: 00007eff2d32e610 R08: 0000000000000000 R09: 00007fff0aad00e8
R10: 0000000020000700 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff0aad00d8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n

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
