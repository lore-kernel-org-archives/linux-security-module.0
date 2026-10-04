Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BBD3B4432
	for <linux-security-module@vger.kernel.org>; Sun,  4 Oct 2026 02:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791082049; cv=none; b=ooLgZlxz62hiCZGe8Ip1/cMeqp0UTtmcOQcbNd5GtaJfJS9c0HDNZfemsp0Ut8PyXxg8ZcZXk5C7byvyjgmoYYZRRlcy/KkrAXHG8xhxnDtfMz9oLiNoHL+ajjtiyDByCBHPzlptzq6qetCIj7GMmNxDpillzv8J+FqsDZwtZRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791082049; c=relaxed/simple;
	bh=ZLXh7kAVslpGfEMmAwHtBJofllnliT+RC5CpD6EaVXE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uWOqeUzuNJrwfRT7TKljbfK8Q3952w9aR67B6K+br9Zdll2d7QLOE4C+4vU/L8Hxstci9jDtVTqdwvw7Fj1XcZuF8sFjKT357qBpr/4gBeWImeKPCg0HORiROgtK+yn3Ro6QY7r67CStNmd/rV3Y26xTMHQB1msZuYmyvjmoY/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4a45b3f0bdfso1174256b6e.1
        for <linux-security-module@vger.kernel.org>; Sat, 03 Oct 2026 19:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791082047; x=1791686847;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qm/OpLOEFODefzF9z/W5ckklxGnVbnPi8612Pj9dd2Q=;
        b=g9afM9cAzJDnZf++VJR4JSak/koxmAX69M/qbz43uqGBkWH+EgzTdm1fsIJjqCURWT
         4XA6a5FVOLg9JcKgPlhllLkf47uf6qxhXa6F31FjGRZnD7b+cF1Cghj6WhYqyYpjz9CC
         VX3h/7vlPJQo+R+tw1ssd3fbeUcKzJV6DAyunpeCrjssuWcjPhvxK+2zQJbecTd51gh/
         ogzaz8tkW+KyJhP0vFG3cM1BTrr3KbHoH19m6jjsSjtHUlyGzzQpcXQ882RHoKWjfYZc
         Wss4La7yojq7pZdRLwGyv33AHDDtUCv00+OqgP6RbQSW6LILCvzSHwDMZ+YUzTOYM5yK
         xAmg==
X-Forwarded-Encrypted: i=1; AKwUvByJ71zSAgBcn3FWB1ehBXv0z59XMrODV9P7Z+jzYvg/HJvepSVFRojtSFZVnqDi8vC811lGoDjtpa/Oo3bO9qtCxcsAMCM=@vger.kernel.org
X-Gm-Message-State: AFuF++lZsN1VmcRIHQINpPxHJDil8FrpLwjhuMB3HB535O9pHz8IfDQS
	abxPQo68hsHOuvCGh2Y+75fbO4oSOakzRcfIb1WdVzrVLFVaxSgdjPcjKF9CXXUeCJNr0I1GvsY
	Tw0zauHORtDmWoL4N7fCoMvA8m2Rm6H2orPMbegsGBJ84z22Cb6uibyHpHW4=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3c46:b0:4c0:12f3:6007 with SMTP id
 5614622812f47-4f67703d6edmr4252671b6e.4.1791082046673; Sat, 03 Oct 2026
 19:47:26 -0700 (PDT)
Date: Sat, 03 Oct 2026 19:47:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ac1be3e.9ad129c8.3858c0.0025.GAE@google.com>
Subject: [syzbot] [lsm?] general protection fault in smack_inode_permission (4)
From: syzbot <syzbot+fc1d5d9a7ebabbc27458@syzkaller.appspotmail.com>
To: casey@schaufler-ca.com, jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ce1e0223d8ad Merge tag 'devicetree-fixes-for-7.3-2' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12555b15580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=718e346eb0b8f38
dashboard link: https://syzkaller.appspot.com/bug?extid=fc1d5d9a7ebabbc27458
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4167e1ad25c1/disk-ce1e0223.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a0a74c8dec59/vmlinux-ce1e0223.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f6caa72edd70/bzImage-ce1e0223.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fc1d5d9a7ebabbc27458@syzkaller.appspotmail.com

ERROR: (device loop4): jfs_readdir: JFS:Dtree error: ino = 2, bn=0, index = 3
ERROR: (device loop4): jfs_readdir: JFS:Dtree error: ino = 2, bn=0, index = 5
ERROR: (device loop4): jfs_readdir: JFS:Dtree error: ino = 2, bn=0, index = 6
Oops: general protection fault, probably for non-canonical address 0xdffffc018bd1a30b: 0000 [#1] SMP KASAN PTI
KASAN: probably user-memory-access in range [0x0000000c5e8d1858-0x0000000c5e8d185f]
CPU: 1 UID: 0 PID: 5607 Comm: syz-executor Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:smk_of_inode security/smack/smack.h:411 [inline]
RIP: 0010:smack_inode_permission+0x265/0x320 security/smack/smack_lsm.c:1260
Code: 83 c5 38 4c 89 e8 48 c1 e8 03 80 3c 18 00 74 08 4c 89 ef e8 1d 99 ab fd 44 8b 3d 66 df 2c 09 4d 03 7d 00 4c 89 f8 48 c1 e8 03 <80> 3c 18 00 74 08 4c 89 ff e8 fd 98 ab fd 49 8b 3f 44 89 f6 48 8d
RSP: 0018:ffffc900058c7920 EFLAGS: 00010202
RAX: 000000018bd1a30b RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc900058c7978
RBP: ffffc900058c7a28 R08: ffffc900058c79af R09: 0000000000000000
R10: ffffc900058c7980 R11: fffff52000b18f36 R12: 1ffff92000b18f28
R13: ffff888040368e20 R14: 0000000000000001 R15: 0000000c5e8d1858
FS:  0000555564dc7500(0000) GS:ffff888125cc3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc8c0efcf0 CR3: 000000002ad9e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 security_inode_permission+0xf4/0x2e0 security/security.c:1842
 lookup_inode_permission_may_exec fs/namei.c:696 [inline]
 may_lookup fs/namei.c:1961 [inline]
 link_path_walk+0xc30/0x1910 fs/namei.c:2604
 path_lookupat+0xe4/0x8c0 fs/namei.c:2812
 filename_lookup+0x265/0x5d0 fs/namei.c:2842
 user_path_at+0x40/0x160 fs/namei.c:3641
 ksys_umount fs/namespace.c:2067 [inline]
 __do_sys_umount fs/namespace.c:2075 [inline]
 __se_sys_umount fs/namespace.c:2073 [inline]
 __x64_sys_umount+0xf6/0x170 fs/namespace.c:2073
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fabd8aaf397
Code: a2 c7 05 5c 43 25 00 00 00 00 00 eb 96 e8 e1 12 00 00 90 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffc8c0f0348 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: ffffffffffffffda RBX: 00007fabd8b444bb RCX: 00007fabd8aaf397
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffc8c0f0400
RBP: 00007ffc8c0f0400 R08: 00007ffc8c0f1400 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc8c0f14f0
R13: 00007fabd8b444bb R14: 00000000000345b3 R15: 00007ffc8c0f25c0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:smk_of_inode security/smack/smack.h:411 [inline]
RIP: 0010:smack_inode_permission+0x265/0x320 security/smack/smack_lsm.c:1260
Code: 83 c5 38 4c 89 e8 48 c1 e8 03 80 3c 18 00 74 08 4c 89 ef e8 1d 99 ab fd 44 8b 3d 66 df 2c 09 4d 03 7d 00 4c 89 f8 48 c1 e8 03 <80> 3c 18 00 74 08 4c 89 ff e8 fd 98 ab fd 49 8b 3f 44 89 f6 48 8d
RSP: 0018:ffffc900058c7920 EFLAGS: 00010202
RAX: 000000018bd1a30b RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc900058c7978
RBP: ffffc900058c7a28 R08: ffffc900058c79af R09: 0000000000000000
R10: ffffc900058c7980 R11: fffff52000b18f36 R12: 1ffff92000b18f28
R13: ffff888040368e20 R14: 0000000000000001 R15: 0000000c5e8d1858
FS:  0000555564dc7500(0000) GS:ffff888125cc3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc8c0efcf0 CR3: 000000002ad9e000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	83 c5 38             	add    $0x38,%ebp
   3:	4c 89 e8             	mov    %r13,%rax
   6:	48 c1 e8 03          	shr    $0x3,%rax
   a:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
   e:	74 08                	je     0x18
  10:	4c 89 ef             	mov    %r13,%rdi
  13:	e8 1d 99 ab fd       	call   0xfdab9935
  18:	44 8b 3d 66 df 2c 09 	mov    0x92cdf66(%rip),%r15d        # 0x92cdf85
  1f:	4d 03 7d 00          	add    0x0(%r13),%r15
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	4c 89 ff             	mov    %r15,%rdi
  33:	e8 fd 98 ab fd       	call   0xfdab9935
  38:	49 8b 3f             	mov    (%r15),%rdi
  3b:	44 89 f6             	mov    %r14d,%esi
  3e:	48                   	rex.W
  3f:	8d                   	.byte 0x8d


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
