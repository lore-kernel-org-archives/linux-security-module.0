Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D4537E5CB
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 08:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791967057; cv=none; b=Ph/sK8YTTuTuGeigx0R83Q23/v47mHnO+H4vir1UaWx9PMyYNTNv24J4QE5JHnv5m6h13rPxMJKatVwUyHg2dNunPyihzy37bCRGqCqgiXwIQZAl42Z+UwYLrXWnlE9P5ugi4O2HiKS9m27a3ze0t2RGuN+wNtTnB5bem/x9aKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791967057; c=relaxed/simple;
	bh=Z6T9vxtRiDAN6S3weuwesoy5grxA0ln/DGUgEqxPr+Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JnEkv29RFm76PybQ5ABeqsVmNyMDwxmXZlwrhntjj1uU7+SiPA1ocbRhJOTBli9UbhwDXTN7KXjw2hZhVBgGGZNO+ujaPuCj44zLPt+4L14q5wDNb6Oo92UPgFgKZY39NtUKAEXG5H+U9I906qdf0m9oa1dcmyHYfJNdm96Sy+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4b28d7ffab1so6097490b6e.1
        for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 01:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791967055; x=1792571855;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JzstWJngq+fbR8IpkjzdFf95Vm56G9Q5CCKAj6oODAY=;
        b=awIiyBtHwbe3N6/Yt7nYMpEWkn5hHeNRti/aD2BkwYItJhT5nh0Mrg0Z1WcJyFQH42
         UbVyQhA0LFdOesHo9fChvVBIGWq29paXxQb0VnPOf8TSX7iGEh436AAhWCe9n2D5OOPI
         lCpkBmAfqHJMkHqFIpqhCg5Rjb5vxzFt2bMf65AmjkmaOjfIzBMnHkDeXql5Ds9LM/ZR
         3MYdVlCYaGF0PSWwWJXb3+HHOYTZLXSr0ZHqzTv9ydXz9eMJhkBZfYIRF8zgbQJAVnWP
         RKZOFJ1MTspMPv1twoVgtshf1n/nTz6W1x67AcLIW/+QT2EHJ+5zZY3/Z7EdmtJbebio
         ScZg==
X-Forwarded-Encrypted: i=1; AKwUvByt/TGQNk9+B0E4aZ+h5NPCOQ4AdYNHPCUCn5ktG54+Yl/V5nuO0dSRmwnA5BFS1cLEKcMcsHPfdCeH1ifZReeb/6tMPXw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWgRvXU1EyMQYig3ubA+d66s1yUIrGW9LmT6QKFMbOCVbN1wIn
	JX6aF37f6Qq8BvC0oAEK2ADIl9D32+6uKv1w5Fkdt+q+L2ZB2+5SwqEvwagym6T+oWBFd7GKsrs
	Sn1rhwZKhYiL9htB6DyDznJ0hr4PlY1r3d7+uH9FZEadrEjaKgHeJhqpIN3Q=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:130e:b0:4e8:4a03:dfa3 with SMTP id
 5614622812f47-50b66f3009fmr11242365b6e.40.1791967055009; Wed, 14 Oct 2026
 01:37:35 -0700 (PDT)
Date: Wed, 14 Oct 2026 01:37:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6acf3f4e.38256f13.2006af.00d7.GAE@google.com>
Subject: [syzbot] [lsm?] general protection fault in smack_inode_getattr
From: syzbot <syzbot+ce678add490179a73d5a@syzkaller.appspotmail.com>
To: casey@schaufler-ca.com, jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fc1c25014ff8 Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13dce1d1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df4bbab1c2172b9f
dashboard link: https://syzkaller.appspot.com/bug?extid=ce678add490179a73d5a
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c451e123dc02/disk-fc1c2501.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2b4864696d50/vmlinux-fc1c2501.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e549beefcba6/bzImage-fc1c2501.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ce678add490179a73d5a@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc018c69ac03: 0000 [#1] SMP KASAN PTI
KASAN: probably user-memory-access in range [0x0000000c634d6018-0x0000000c634d601f]
CPU: 0 UID: 0 PID: 5591 Comm: syz-executor Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:smk_of_inode security/smack/smack.h:411 [inline]
RIP: 0010:smack_inode_getattr+0x1ac/0x240 security/smack/smack_lsm.c:1306
Code: 48 bb 00 00 00 00 00 fc ff df 80 3c 18 00 74 08 4c 89 e7 e8 66 4e ab fd 44 8b 35 ef d7 30 09 4d 03 34 24 4c 89 f0 48 c1 e8 03 <80> 3c 18 00 74 08 4c 89 f7 e8 46 4e ab fd 49 8b 3e be 04 00 00 00
RSP: 0018:ffffc9000595fa80 EFLAGS: 00010206
RAX: 000000018c69ac03 RBX: dffffc0000000000 RCX: ffffc9000595fc80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc9000595fad8
RBP: ffffc9000595fb98 R08: ffffc9000595fb0f R09: 0000000000000000
R10: ffffc9000595fae0 R11: fffff52000b2bf62 R12: ffff888063d04810
R13: 1ffff92000b2bf54 R14: 0000000c634d6018 R15: 1ffff92000b2bf91
FS:  0000555580366500(0000) GS:ffff8881249bb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc903e3ff0 CR3: 0000000056faa000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 security_inode_getattr+0x152/0x310 security/security.c:1895
 vfs_getattr+0x23/0x70 fs/stat.c:259
 vfs_statx_path+0x2b/0x230 fs/stat.c:299
 vfs_statx+0x12e/0x200 fs/stat.c:356
 vfs_fstatat+0x11b/0x170 fs/stat.c:373
 __do_sys_newfstatat fs/stat.c:538 [inline]
 __se_sys_newfstatat fs/stat.c:532 [inline]
 __x64_sys_newfstatat+0x151/0x200 fs/stat.c:532
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff49529c81a
Code: 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 41 89 ca b8 06 01 00 00 0f 05 <3d> 00 f0 ff ff 77 07 31 c0 c3 0f 1f 40 00 48 c7 c2 e8 ff ff ff f7
RSP: 002b:00007ffc903e4178 EFLAGS: 00000286 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 00007ff495334ccb RCX: 00007ff49529c81a
RDX: 00007ffc903e41a0 RSI: 00007ffc903e4230 RDI: 00000000ffffff9c
RBP: 00007ffc903e4230 R08: 00007ffc903e5230 R09: 00000000ffffffff
R10: 0000000000000100 R11: 0000000000000286 R12: 00007ffc903e52c0
R13: 00007ff495334ccb R14: 0000000000018d1f R15: 00007ffc903e5300
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:smk_of_inode security/smack/smack.h:411 [inline]
RIP: 0010:smack_inode_getattr+0x1ac/0x240 security/smack/smack_lsm.c:1306
Code: 48 bb 00 00 00 00 00 fc ff df 80 3c 18 00 74 08 4c 89 e7 e8 66 4e ab fd 44 8b 35 ef d7 30 09 4d 03 34 24 4c 89 f0 48 c1 e8 03 <80> 3c 18 00 74 08 4c 89 f7 e8 46 4e ab fd 49 8b 3e be 04 00 00 00
RSP: 0018:ffffc9000595fa80 EFLAGS: 00010206
RAX: 000000018c69ac03 RBX: dffffc0000000000 RCX: ffffc9000595fc80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc9000595fad8
RBP: ffffc9000595fb98 R08: ffffc9000595fb0f R09: 0000000000000000
R10: ffffc9000595fae0 R11: fffff52000b2bf62 R12: ffff888063d04810
R13: 1ffff92000b2bf54 R14: 0000000c634d6018 R15: 1ffff92000b2bf91
FS:  0000555580366500(0000) GS:ffff888124abb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6b90b0a000 CR3: 0000000056faa000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	48 bb 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbx
   7:	fc ff df
   a:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
   e:	74 08                	je     0x18
  10:	4c 89 e7             	mov    %r12,%rdi
  13:	e8 66 4e ab fd       	call   0xfdab4e7e
  18:	44 8b 35 ef d7 30 09 	mov    0x930d7ef(%rip),%r14d        # 0x930d80e
  1f:	4d 03 34 24          	add    (%r12),%r14
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	4c 89 f7             	mov    %r14,%rdi
  33:	e8 46 4e ab fd       	call   0xfdab4e7e
  38:	49 8b 3e             	mov    (%r14),%rdi
  3b:	be 04 00 00 00       	mov    $0x4,%esi


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
