Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1BD2D6E7D
	for <linux-security-module@vger.kernel.org>; Fri,  7 Nov 2025 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762524330; cv=none; b=mVCawqlEEx3ffKYaQ2zpMT6NyZU9giqL0rpisKgv2X5wXNCGOhIM68dNzi50upphppTV0uFM02oFnbRZZbWlzmS5My+LNRNtqznfw9CcXFaEgpd8R9dgR4SDc+A5xUaiovkvpaETxbjMdKlZGwC/RJ4Gc3a10pIBLhly60W4THs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762524330; c=relaxed/simple;
	bh=+eg5rgqvvqQRDh9bSJOkOyHmd669+LeORpwf4MYrJ+Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tFva5H8jDzTGgfUx/tLZLlvV6QSESlNyHRjAFAKStSw+Tf+km35fm5en/w7LB1B1QwnJgcYnylvuAbSBdfFZbOd6z92GPPFV9fmN9xtgkJdB7ut33xWu7WNXo7XHEu+61oe/qrmecB6oAd8a8xWlHjuc6lQzsJtzCh+Hp5dSkLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-43330d77c3aso26373445ab.3
        for <linux-security-module@vger.kernel.org>; Fri, 07 Nov 2025 06:05:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762524327; x=1763129127;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MYkT91vt2XPJFVUyQz2u0UsSW8PzePp2mrpqmJb+mT8=;
        b=rVXT7P15nxQjkFYbg/O3ehhXhQwe27a0x3FNvI3WcOwfrgF+PyFk0LzLqUPFnBt5/G
         shEtkFRAEagulTuLeqrCxUPwqzea0D+Z1h1U37xYQAseFtB4bHlZ0pv9jGNzNF0CJeJj
         VMxCLdPBa+qH8gqsVvZ36m0wxXkfgX4FaCiC9AKQZSjyWRpaMGsn+eCrM8G432jsqBBg
         GfK5ddLvmqaoY2oHkCshFSwWyXjfAjCXUbzpLsWm/cYJ0dYApPzlBFQ18yL9PiLntm9X
         xrb9ZzxKgaR5shmzy4rwH1UAAYXPnfCKfTB4QNwhPG33oskArskuVtlCiZ1uGVkLDwqt
         H87g==
X-Forwarded-Encrypted: i=1; AJvYcCWDAD5OSLY6zsSmuZu5GXgXe7QBydHvOpFOW2HBJq5hARFCG0jdl/rUQecp3RZGx/LBP87K0KVlacXcNh7RqWrtIFwVR94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZRVlwIK18+D9unY9i/+4irc0RU0t5BgPy1ePR9vvKd0xqbKHF
	Jggylk22iT7NfCAW/bsanomyahzym9VbHwOTQA2MQiuv4VaOXHcbcfqiRDfY/BRoOYLtDE2vnFg
	uPAppY7+v1pTvbcJPSp/wY1IXfSROo2wfBWREF3910HCrC+XMRGq7AW1HXGM=
X-Google-Smtp-Source: AGHT+IE/A+Ffp/YzI+RN0H9GaXsH5Nlu8qvIPAVIJbrhc4qF+x+rqqfp1HSDE8Xj7cA4PMjesyU75tlo80aAhovdlFzLFYZ5aUEm
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdaf:0:b0:433:4fb4:edc9 with SMTP id
 e9e14a558f8ab-4335f3f9656mr50244275ab.11.1762524327513; Fri, 07 Nov 2025
 06:05:27 -0800 (PST)
Date: Fri, 07 Nov 2025 06:05:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690dfca7.a70a0220.22f260.004d.GAE@google.com>
Subject: [syzbot] [lsm?] WARNING in put_cred_rcu
From: syzbot <syzbot+553c4078ab14e3cf3358@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	luto@kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    17490bd0527f Add linux-next specific files for 20251104
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16c09bcd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9995c0d2611ab121
dashboard link: https://syzkaller.appspot.com/bug?extid=553c4078ab14e3cf3358
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1500a532580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e0a114580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a4d318147846/disk-17490bd0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/86641a470170/vmlinux-17490bd0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/35c008a540c8/bzImage-17490bd0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+553c4078ab14e3cf3358@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: ./include/linux/ns_common.h:255 at __ns_ref_put include/linux/ns_common.h:255 [inline], CPU#0: syz.1.27/6120
WARNING: ./include/linux/ns_common.h:255 at put_user_ns include/linux/user_namespace.h:189 [inline], CPU#0: syz.1.27/6120
WARNING: ./include/linux/ns_common.h:255 at put_cred_rcu+0x2c5/0x340 kernel/cred.c:61, CPU#0: syz.1.27/6120
Modules linked in:
CPU: 0 UID: 0 PID: 6120 Comm: syz.1.27 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__ns_ref_put include/linux/ns_common.h:255 [inline]
RIP: 0010:put_user_ns include/linux/user_namespace.h:189 [inline]
RIP: 0010:put_cred_rcu+0x2c5/0x340 kernel/cred.c:61
Code: 5c 41 5d 41 5e 41 5f 5d e9 b8 41 8d 00 e8 03 77 32 00 4c 89 e7 be 03 00 00 00 e8 d6 19 07 03 e9 b8 fe ff ff e8 ec 76 32 00 90 <0f> 0b 90 eb 9f e8 e1 76 32 00 4c 89 ff be 03 00 00 00 e8 b4 19 07
RSP: 0018:ffffc90000007ba8 EFLAGS: 00010246
RAX: ffffffff818ee5a4 RBX: ffff88801c3762a0 RCX: ffff888027350000
RDX: 0000000000000100 RSI: 0000000000000004 RDI: 0000000000000000
RBP: 0000000000000004 R08: ffff888073d31eab R09: 1ffff1100e7a63d5
R10: dffffc0000000000 R11: ffffed100e7a63d6 R12: dffffc0000000000
R13: ffff88801c376200 R14: ffff888073d31d18 R15: ffff888073d31ea8
FS:  00007fcce9f9d6c0(0000) GS:ffff888125a92000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555684fe808 CR3: 000000007ee2c000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xcab/0x1770 kernel/rcu/tree.c:2861
 handle_softirqs+0x286/0x870 kernel/softirq.c:626
 __do_softirq kernel/softirq.c:660 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:727
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:743
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1052
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:lock_acquire+0x175/0x360 kernel/locking/lockdep.c:5872
Code: 00 00 00 00 9c 8f 44 24 30 f7 44 24 30 00 02 00 00 0f 85 cd 00 00 00 f7 44 24 08 00 02 00 00 74 01 fb 65 48 8b 05 bb 94 1a 11 <48> 3b 44 24 58 0f 85 f2 00 00 00 48 83 c4 60 5b 41 5c 41 5d 41 5e
RSP: 0018:ffffc90002ec5f58 EFLAGS: 00000206
RAX: c3b7b02cbda44300 RBX: 0000000000000000 RCX: c3b7b02cbda44300
RDX: 0000000000000000 RSI: ffffffff8dc69c71 RDI: ffffffff8be0fc60
RBP: ffffffff817420d5 R08: 0000000000000000 R09: ffffffff817420d5
R10: ffffc90002ec6118 R11: ffffffff81ad6a10 R12: 0000000000000002
R13: ffffffff8e33b520 R14: 0000000000000000 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:867 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1195 [inline]
 unwind_next_frame+0xc2/0x2390 arch/x86/kernel/unwind_orc.c:479
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 save_stack+0xf5/0x1f0 mm/page_owner.c:165
 __set_page_owner+0x8d/0x4c0 mm/page_owner.c:341
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3920
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5214
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2479
 folio_alloc_mpol_noprof+0x39/0x70 mm/mempolicy.c:2498
 shmem_alloc_folio mm/shmem.c:1900 [inline]
 shmem_alloc_and_add_folio+0x423/0xf40 mm/shmem.c:1942
 shmem_get_folio_gfp+0x59d/0x1660 mm/shmem.c:2565
 shmem_get_folio mm/shmem.c:2671 [inline]
 shmem_write_begin+0xf7/0x2b0 mm/shmem.c:3320
 generic_perform_write+0x2c5/0x900 mm/filemap.c:4313
 shmem_file_write_iter+0xf8/0x120 mm/shmem.c:3495
 __kernel_write_iter+0x428/0x910 fs/read_write.c:619
 dump_emit_page fs/coredump.c:1298 [inline]
 dump_user_range+0x8a0/0xc90 fs/coredump.c:1372
 elf_core_dump+0x3369/0x3960 fs/binfmt_elf.c:2111
 coredump_write+0x116c/0x1900 fs/coredump.c:1049
 vfs_coredump+0x1db5/0x2a60 fs/coredump.c:1170
 get_signal+0x1108/0x1340 kernel/signal.c:3019
 arch_do_signal_or_restart+0xa0/0x790 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:40 [inline]
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 irqentry_exit_to_user_mode+0x7e/0x170 kernel/entry/common.c:73
 exc_page_fault+0xab/0x100 arch/x86/mm/fault.c:1535
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
RIP: 0033:0x7fcce918f6d1
Code: 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 48 3d 01 f0 ff ff 73 01 <c3> 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
RSP: 002b:0000000000000010 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007fcce93e5fa0 RCX: 00007fcce918f6c9
RDX: 0000000000000000 RSI: 0000000000000010 RDI: 498144ee5f62e049
RBP: 00007fcce9211f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 00007fcce93e6038 R14: 00007fcce93e5fa0 R15: 00007ffd4dc9bfc8
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	9c                   	pushf
   5:	8f 44 24 30          	pop    0x30(%rsp)
   9:	f7 44 24 30 00 02 00 	testl  $0x200,0x30(%rsp)
  10:	00
  11:	0f 85 cd 00 00 00    	jne    0xe4
  17:	f7 44 24 08 00 02 00 	testl  $0x200,0x8(%rsp)
  1e:	00
  1f:	74 01                	je     0x22
  21:	fb                   	sti
  22:	65 48 8b 05 bb 94 1a 	mov    %gs:0x111a94bb(%rip),%rax        # 0x111a94e5
  29:	11
* 2a:	48 3b 44 24 58       	cmp    0x58(%rsp),%rax <-- trapping instruction
  2f:	0f 85 f2 00 00 00    	jne    0x127
  35:	48 83 c4 60          	add    $0x60,%rsp
  39:	5b                   	pop    %rbx
  3a:	41 5c                	pop    %r12
  3c:	41 5d                	pop    %r13
  3e:	41 5e                	pop    %r14


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
