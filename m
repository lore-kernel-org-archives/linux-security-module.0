Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039EE20D511
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jan 2025 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513970; cv=none; b=kvQFRmamTFNbVWezf9q6OeZoyl/5IUypU0dNL5gd7e+OqTCankTIkDGxJeXzfyhvzLWAAOMp0e1y9wBR+GYlipG9Nsq4lXYENJKm1zigtT3WFWBjf/9HXTvbz3cn/Iso5PCKzG1+ipTXxMelHU90gVgVFVpOfT51ndLyAG/Ui2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513970; c=relaxed/simple;
	bh=N5Nwoip5xbeWvZVKWc7XpqHKBZo+r6HFEiCLqn4G52g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dj4ZrvtcSgO1r2F/T+OxU+OsiEtA+gJd6fMwBPhMWWrG9SqFnvIQNRzeXiofElh8/G62TSs0TFW3spJSOQPhnOvT5rtCtF5d5YJUHM18qwr/4j+MqDbk0rlQzxbxx9jH4ZKk2ZRHV0tvQ/yG2zCyoE755PMumIaLRCKNK8b3S1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a7d85ab308so16024255ab.3
        for <linux-security-module@vger.kernel.org>; Fri, 10 Jan 2025 04:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736513968; x=1737118768;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jwSEic0BY8r/N+t2umB/08iOI2Uv7pxcCMfwAJ3rZPo=;
        b=tbaeP2UkJZp6UDRqYhYw9Em52IG1h5AKbtTu/kJTQJTCBni7c/RctZqDyK975q3NlP
         gJo298tEVEApRdZOCHq2kuB1ioNl5wpZuw89DTrkvxsHABs0TM0OkBEClt7eL/3vnxb5
         UcdaSVsASPMbz3UBmh1DDnIGd/Fu9s45xNgaLHoRJ+7NlLbtmjJqWg355r8jazZRSoqs
         BkFn6xi26ZZJADHhMhTIrHvNjDlUWD8uXWX+sV2Q0IEfGvbxp0EAMlVpUhb5hveICkn2
         gvHvJwQacL6fbCoSvLstZrt2u8T8WdaexDeWu8vCpg0PmrdV3I7fHA9ejPf3DIiVDeIa
         x5VA==
X-Forwarded-Encrypted: i=1; AJvYcCUJkxXUrORxnGO4gfGAY8qclFEdocVbjXwpD1mUSIQBiS7No5h/p66Qan8AuHxoxDWHb+9xAvHxkSzPPRbOWj58niGywto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/gYCh9MUiJ6rbhO98ipB3NQBeaz119XCrM5IDGkWIsQ6ry4MA
	JS3J+9znxvN8haReqtsp1gssGTchgTSpMSG/oZLe7hEf6kuz1nCQro2uNP+DUmg6DcCFTgqjU9E
	qIQAQQ0I7b/qGDUdIdmZ0ZVc/xunY7CCApASe1yr1nzNM5vGC+FXrP48=
X-Google-Smtp-Source: AGHT+IHUwW4hNvKhlfoJazuKjSWv+jFDD8dEY84Obxi4Q9Je9dw4Jfo6aXdDB133F3RbAjbYnSZaqglz3eyVYGkZLubcJzmnLa34
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:509:b0:3ce:46e2:429b with SMTP id
 e9e14a558f8ab-3ce46e24583mr35779885ab.10.1736513968175; Fri, 10 Jan 2025
 04:59:28 -0800 (PST)
Date: Fri, 10 Jan 2025 04:59:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678119b0.050a0220.d0267.0029.GAE@google.com>
Subject: [syzbot] [lsm?] WARNING in vfs_writev
From: syzbot <syzbot+910965bf9c26c6936f34@syzkaller.appspotmail.com>
To: jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ab75170520d4 Merge tag 'linux-watchdog-6.13-rc6' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100fb9c4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86dd15278dbfe19f
dashboard link: https://syzkaller.appspot.com/bug?extid=910965bf9c26c6936f34
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11471edf980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15471edf980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/853d1f53edc7/disk-ab751705.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d2656ee9e47/vmlinux-ab751705.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a6ea69d61e24/bzImage-ab751705.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+910965bf9c26c6936f34@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5827 at mm/page_alloc.c:4729 __alloc_pages_noprof+0xeff/0x25b0 mm/page_alloc.c:4729
Modules linked in:
CPU: 1 UID: 0 PID: 5827 Comm: syz-executor324 Not tainted 6.13.0-rc5-syzkaller-00163-gab75170520d4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__alloc_pages_noprof+0xeff/0x25b0 mm/page_alloc.c:4729
Code: 24 2c 00 00 00 00 89 cd 0f 84 8b f9 ff ff 8b 34 24 48 89 da 8b 7c 24 08 e8 de b2 fe ff e9 69 f9 ff ff c6 05 54 6f 16 0e 01 90 <0f> 0b 90 31 db e9 9f f3 ff ff 89 14 24 e8 6f a4 0c 00 8b 14 24 e9
RSP: 0018:ffffc90003837928 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000013 RDI: 0000000000040cc0
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000013
R13: 0000000000040cc0 R14: 1ffff92000706f39 R15: 00000000ffffffff
FS:  0000555571e5d380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 0000000029fb0000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 ___kmalloc_large_node+0x84/0x1b0 mm/slub.c:4243
 __kmalloc_large_node_noprof+0x1c/0x70 mm/slub.c:4270
 __do_kmalloc_node mm/slub.c:4286 [inline]
 __kmalloc_node_track_caller_noprof.cold+0x5/0x5f mm/slub.c:4317
 memdup_user_nul+0x2b/0x110 mm/util.c:305
 lockdown_write+0x2d/0x290 security/lockdown/lockdown.c:128
 do_loop_readv_writev fs/read_write.c:843 [inline]
 do_loop_readv_writev fs/read_write.c:828 [inline]
 vfs_writev+0x6da/0xdd0 fs/read_write.c:1052
 do_writev+0x133/0x340 fs/read_write.c:1096
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f601de372e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcb4f253e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007ffcb4f255b8 RCX: 00007f601de372e9
RDX: 0000000000000001 RSI: 0000000020000580 RDI: 0000000000000003
RBP: 00007f601deaa610 R08: 0000000000000000 R09: 00007ffcb4f255b8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffcb4f255a8 R14: 0000000000000001 R15: 0000000000000001
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
