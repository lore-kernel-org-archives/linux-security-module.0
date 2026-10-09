Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83708346766
	for <linux-security-module@vger.kernel.org>; Fri,  9 Oct 2026 17:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565467; cv=none; b=mXgvs+rQJSe9BZyd2M2Dvb+sc69unmUY7ioFb7n59AQuWZryJenDgKjdnMcIcaCftUfZy1sl1OKP4x8o7ti05EdGldVWkfvWhWD25fi2g0gR5iX2RnoHUBvLHBUKDCqbmvUnmw2fJOsASbA24pXlCnB20BXqO4lx6w8LWxrXT9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565467; c=relaxed/simple;
	bh=f3K6zxl+cZmb13QxyE8Na+fRXT2tB2FQ1hM17VnzNc0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZF8WagQp/bjPaG+4Bcd6c2bV+7evcWapSq0pkjtMiYHzxHELVVllg5iWbhmlADtzmU1hh32wizgl14XTJ4nIEIcnt9DRxOrcYCrVZoIg12SMKf/z7tN68qFY2CM5uH3SLd+0WTQhCG30JKTBS6x2Qex8uDA/w/Rl1dlr7MAzGqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4a41f46d629so12270566b6e.3
        for <linux-security-module@vger.kernel.org>; Fri, 09 Oct 2026 10:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791565464; x=1792170264;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ECKSX4VGb4hDmujnpvcN4dRf7mpNZH/ocfAWB20+LVI=;
        b=YWBRzw45l4FV+oB9NUQGhOao/z/3FC1KP46o0fUc5fVCIr+pl/jvJR3GnCTzMaSiqD
         vujBZIUu9TPGx40C/t3OG616iRYc4WMWUjVi47j85RSqaVJbgJLQv/y4t5HHP9520sbA
         S7ZB58Ll3oJwXdsIy4IjUIxvVqymM+cDxGuOqe2bEk9ViFZzchAUxzmtky1n0f8+zIsA
         zEI3t2sguCGTdETP+knZQNO9h+CPpwqGm4J9AFHWu/1QN6DVt/Vp/GpGxmRy+BLoRDII
         J2Rrq3lIE22zsc5V+R2U45nvepb3LaekaMw+GH02wWqWHve/kRJkXGIP/hhLksa1wdlt
         L4Xw==
X-Forwarded-Encrypted: i=1; AKwUvBxnD73xLEbrHugi5o/L+b8ah+DP9gCPcmXsu0/u455QSYyghigjN7arF17Ve80WhgQvX4f/ybEvfywTdSSlwfousKZJSCs=@vger.kernel.org
X-Gm-Message-State: AFuF++lOj2c+G3ZeYNCt1IN+X036qUsec3I4X7v7YgTBHyFt9ruNf9v2
	1DrtW63XygN+fyWALlPIOWmyvZ6cH3rvTfrIB+oz45udr9t8hf8sj1+uYfVs1tUlOjIxUpp/5Wo
	eZBsVgf0s2AAkUDdXncWWdUj3WOzwVsJzu769/CQPTYEQMdgE2mmGsxX44lk=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:15a6:b0:4c5:b120:9833 with SMTP id
 5614622812f47-50c45c69989mr2316907b6e.6.1791565464345; Fri, 09 Oct 2026
 10:04:24 -0700 (PDT)
Date: Fri, 09 Oct 2026 10:04:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ac91e98.bbc4c7f9.15faa7.0023.GAE@google.com>
Subject: [syzbot] [lsm?] WARNING in landlock_merge_ruleset
From: syzbot <syzbot+a0eecb22de4d821a9e5d@syzkaller.appspotmail.com>
To: gnoack@google.com, jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, mic@digikod.net, paul@paul-moore.com, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aac26bee2287 Add linux-next specific files for 20261008
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1772f715580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=814b0d31d59c294
dashboard link: https://syzkaller.appspot.com/bug?extid=a0eecb22de4d821a9e5d
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1305c8e1580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15497c3e580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/92e867ba9905/disk-aac26bee.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c4cc176072c1/vmlinux-aac26bee.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c603638afe28/bzImage-aac26bee.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a0eecb22de4d821a9e5d@syzkaller.appspotmail.com

------------[ cut here ]------------
memcpy: detected buffer overflow: 16 byte read of buffer size 0
WARNING: lib/string_helpers.c:1037 at __fortify_report+0x6b/0xa0 lib/string_helpers.c:1036, CPU#0: syz-executor347/5624
Modules linked in:
CPU: 0 UID: 0 PID: 5624 Comm: syz-executor347 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/16/2026
RIP: 0010:__fortify_report+0x89/0xa0 lib/string_helpers.c:1036
Code: e8 ec f1 4b fd 48 8d 3d c5 7e d7 0c 45 84 e4 49 8b 37 48 c7 c0 40 8d 8d 8c 48 c7 c1 60 8d 8d 8c 48 0f 44 c8 4c 89 f2 49 89 d8 <67> 48 0f b9 3a 5b 41 5c 41 5e 41 5f 5d e9 45 84 14 07 cc cc cc cc
RSP: 0018:ffffc90003bb7dc8 EFLAGS: 00010246
RAX: ffffffff8c8d8d40 RBX: 0000000000000000 RCX: ffffffff8c8d8d40
RDX: 0000000000000010 RSI: ffffffff8c8d8c20 RDI: ffffffff91c743f0
RBP: 000000000000000e R08: 0000000000000000 R09: 1ffff11006d9ed01
R10: dffffc0000000000 R11: ffffed1006d9ed02 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000010 R15: ffffffff8c8d8a78
FS:  000055558b41f400(0000) GS:ffff888123429000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055c55f793000 CR3: 00000000359c2000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __fortify_panic+0x9/0x10 lib/string_helpers.c:1043
 fortify_memcpy_chk include/linux/fortify-string.h:547 [inline]
 inherit_ruleset security/landlock/domain.c:407 [inline]
 landlock_merge_ruleset+0xc46/0xc90 security/landlock/domain.c:468
 __do_sys_landlock_restrict_self security/landlock/syscalls.c:809 [inline]
 __se_sys_landlock_restrict_self+0x2bc/0xd40 security/landlock/syscalls.c:732
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc0d85c8c39
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff6fcb7858 EFLAGS: 00000246 ORIG_RAX: 00000000000001be
RAX: ffffffffffffffda RBX: 00007fff6fcb7988 RCX: 00007fc0d85c8c39
RDX: 00007fc0d85c8c39 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 0000000000000001 R08: 00007fff6fcb7988 R09: 00007fff6fcb7988
R10: 00007fff6fcb7988 R11: 0000000000000246 R12: 00007fff6fcb7978
R13: 0000000000000002 R14: 00007fc0d8659ca0 R15: 0000000000000002
 </TASK>
----------------
Code disassembly (best guess):
   0:	e8 ec f1 4b fd       	call   0xfd4bf1f1
   5:	48 8d 3d c5 7e d7 0c 	lea    0xcd77ec5(%rip),%rdi        # 0xcd77ed1
   c:	45 84 e4             	test   %r12b,%r12b
   f:	49 8b 37             	mov    (%r15),%rsi
  12:	48 c7 c0 40 8d 8d 8c 	mov    $0xffffffff8c8d8d40,%rax
  19:	48 c7 c1 60 8d 8d 8c 	mov    $0xffffffff8c8d8d60,%rcx
  20:	48 0f 44 c8          	cmove  %rax,%rcx
  24:	4c 89 f2             	mov    %r14,%rdx
  27:	49 89 d8             	mov    %rbx,%r8
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	5b                   	pop    %rbx
  30:	41 5c                	pop    %r12
  32:	41 5e                	pop    %r14
  34:	41 5f                	pop    %r15
  36:	5d                   	pop    %rbp
  37:	e9 45 84 14 07       	jmp    0x7148481
  3c:	cc                   	int3
  3d:	cc                   	int3
  3e:	cc                   	int3
  3f:	cc                   	int3


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
