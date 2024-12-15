Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CE81B4F3F
	for <linux-security-module@vger.kernel.org>; Sun, 15 Dec 2024 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734299964; cv=none; b=FuzN5S/coEXsRNpA9MgX9VPNcKWpumwyTCUY6tfwtWt93ZXOhbVotPtvB4OaZF/yWYmQsHVkwH+HzVNe/GbD0+oO/4FWDFp1m0ACsepWkmm8gNJx6PQ9rHAbCTCmuQUIjWq/vQvX+pvZ9+38U3AiVk4f6rkBfvVpe02F20WodLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734299964; c=relaxed/simple;
	bh=JtKkl0vLdu7Wka0xgaujTfSJ66Eo89eAHYs3iJ+aPX0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Hp9UlieQW6D6JsFCVaW4zM7Rm7NJHaKpe5D2eNAHipLu9uxj1IaocFSOQ3rXG6XJvCmlcDbt+G9twokc0PwUwL/GNPInPQ/433rVWjoJix9bEOzvtGvFTTteO2UhlrvR+Ztp2Rg/W/qzfhb6zXqeDIgivwLkyvigu/PMstmjVUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3abe7375ba6so74182595ab.3
        for <linux-security-module@vger.kernel.org>; Sun, 15 Dec 2024 13:59:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734299962; x=1734904762;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7EbX7fF8lmd0Q7j5a9UxfXPz76ch2RqY/1MK2FKj3oI=;
        b=frIQo8sEftioY+5O6Tmat1FSXSCmovIVixzVvVxdbZuNYgfRzCI4dDlJV80JGV6pUa
         IQGsQc1jtxojsx5v384P6zjiX17XjUNnFcQGHFI4RoHAkKZC09BYBL0iJm+N8PJAMQhF
         DMXfDuNOrscKNDK9DqQmevir0azhVulzGG8jtHXhGSfarEG03cLPBmE9Hvp9r9kBoY9y
         EKucYXGLoUNHOWw9bHR0QafNmncOzOQe5hZDba4qlqiJfGH5k+mBZAC/xyOmVX9rgwp0
         5xRwkqch83gTcdtHUFlSFkUaZ1qnk0KKl79drGDVHLWi5yEDAWCBNYauutF/BXNczOcs
         VRfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmuvNiGXNDFxEkCYmaKGix3fSFY+snDl1ohBhmrMemnL0wsN+yaG3YaR5KV7/3c6ZOAIR/Pws9dJvCgp7oR+54harQotg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+oe6LD3P6GlunxW98td5rXddeU5NZFlpCb/uBlEgvTeam9Yoq
	Y/3Pum3i8YZ5PDSmm4r9HP9U16A2XDPZaW1g1Utjp2qx/WHfCRt5EbtcOKvfXqVe1dHpF0wmsim
	t89VowQ/415jOXhThiXJWEipzzOZLPQ2zFVwmc4TV7+y4WOZ+ySFSB6o=
X-Google-Smtp-Source: AGHT+IGHWHFWcoyC1UDyBV8nKaRBzeNk08jfOdbWyP8o3I2rRj/RODX03lBXPU85SXcbJnAG3raCFRP2FRgKnmjuJOrd5b72IqmO
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c248:0:b0:3a7:a2c6:e6d1 with SMTP id
 e9e14a558f8ab-3aff0c4d94bmr103875515ab.16.1734299962447; Sun, 15 Dec 2024
 13:59:22 -0800 (PST)
Date: Sun, 15 Dec 2024 13:59:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675f513a.050a0220.37aaf.0106.GAE@google.com>
Subject: [syzbot] [lsm?] WARNING in handle_policy_update
From: syzbot <syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com>
To: jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, mortonm@chromium.org, 
	paul@paul-moore.com, serge@hallyn.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f932fb9b4074 Merge tag 'v6.13-rc2-ksmbd-server-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10892d44580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5586995ec03b2
dashboard link: https://syzkaller.appspot.com/bug?extid=4eb7a741b3216020043a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1696ea0f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16509cdf980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f0d0c95f5364/disk-f932fb9b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/201cf3c7a7b5/vmlinux-f932fb9b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fcb972084579/bzImage-f932fb9b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5827 at mm/page_alloc.c:4727 __alloc_pages_noprof+0xeff/0x25b0 mm/page_alloc.c:4727
Modules linked in:
CPU: 0 UID: 0 PID: 5827 Comm: syz-executor752 Not tainted 6.13.0-rc2-syzkaller-00159-gf932fb9b4074 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:__alloc_pages_noprof+0xeff/0x25b0 mm/page_alloc.c:4727
Code: 24 2c 00 00 00 00 89 cd 0f 84 8b f9 ff ff 8b 34 24 48 89 da 8b 7c 24 08 e8 0e b3 fe ff e9 69 f9 ff ff c6 05 e1 44 16 0e 01 90 <0f> 0b 90 31 db e9 9f f3 ff ff 89 14 24 e8 9f a2 0c 00 8b 14 24 e9
RSP: 0018:ffffc900015978e8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000013 RDI: 0000000000040cc0
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000100
R10: 0000000000000100 R11: ffffffff81fb9344 R12: 0000000000000013
R13: 0000000000040cc0 R14: 1ffff920002b2f31 R15: 00000000ffffffff
FS:  000055556162e380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000130 CR3: 0000000028cc2000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 ___kmalloc_large_node+0x84/0x1b0 mm/slub.c:4228
 __kmalloc_large_node_noprof+0x1c/0x70 mm/slub.c:4255
 __do_kmalloc_node mm/slub.c:4271 [inline]
 __kmalloc_node_track_caller_noprof.cold+0x5/0x5f mm/slub.c:4302
 memdup_user_nul+0x2b/0x110 mm/util.c:305
 handle_policy_update+0x188/0x11e0 security/safesetid/securityfs.c:153
 safesetid_gid_file_write+0x87/0xc0 security/safesetid/securityfs.c:260
 vfs_write+0x24c/0x1150 fs/read_write.c:677
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8b2d0d02e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd58b75818 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ffd58b759f8 RCX: 00007f8b2d0d02e9
RDX: 00000000fffffdef RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f8b2d143610 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd58b759e8 R14: 0000000000000001 R15: 0000000000000001
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
