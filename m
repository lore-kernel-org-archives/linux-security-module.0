Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFCC272E45
	for <linux-security-module@vger.kernel.org>; Thu, 11 Dec 2025 06:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765434145; cv=none; b=BYsOzpDyrT1KOj7pUh7zHwRYmjG2xl3UgPjWMOzPv1FfQVm7YO4eWYnHgQmt+iJu9DOI9Szz2HaG7mOC64BWJr9WSF2F0AP4CCjqQs+TZ4skuYTiRHboiFUTKHH3YNKCyWuZ5nMDex9yM7qSq8Ov00iMFtCOHs/Awkv5ieFpcZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765434145; c=relaxed/simple;
	bh=txdiaXN3fSiUx2tseUGJJAP9R9fThEkNHZ6NZFxtrtM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=p3ktqvkUGSNhs/nnSgS3gGnOncIdKSrr7pW/NsAQKY/4BNMPZwWHByH999qpcv65njUpBDQ+WDyNODWz6McmW+Bhdq8W0SLDBvROy6xKVteub7hiZAP8Jz8iG6x3f3MjcusQPOpK9lqRRcNN2hh8ZlXbz8OPUo7Qae2skizLZeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-3ed1784353eso876018fac.3
        for <linux-security-module@vger.kernel.org>; Wed, 10 Dec 2025 22:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765434142; x=1766038942;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g3jMzuCmzIx45UFZttO+h3poiFAZk3xlJ8MVAr61lh0=;
        b=WCtVy5Ic/ZHvxN5ezmAuXOmT8RaAaRiIAFyWGaxoN4CtWREgRXghSJ4QkidBrk6jgI
         wh8OotS7XKcxkxoJWBpjcb+lQ4wf6oztYYSuk2fQNJnjvbJbJ1JLrYCfFap9J1sD55AQ
         xZnS4G+uCsjFZ2zTMBIniPIB8B0Yn6XyfIZJiAHc9KqV7xdWzdhNkfAi72u046vqVmk3
         m9+kkKhPV5Etn9+/IOOEdiDT+XnM6YjT6eBMQgRVyUoKEiY/e1F16Uwk2E1oyBZnw5Dx
         cD4ergT6Nq/Rr68YdpSp5+CkZK3r0y1hqWmEWvzLzxoMjyHePAL2Y/e1vUj6mcchrf17
         8AVw==
X-Forwarded-Encrypted: i=1; AJvYcCWc4QHrHkbcs+/rWDeDc5kZFh1J9PrREcWeVXuQ+ndavX2Yliv36yA5Wsd6Q+NsOpnXSN8/V8D3NJs2IZY+4LLtDaqE4ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH1M2pSIhmNWLqfPJrIkfLBYq2bzPb4p6b7XSlzimvN55j4txZ
	8t5LOTQwsHcJpQCELtUq1CydDSQVxcMC+ao7GAiUTHJQHE4iUyf71+EtRH5dbNBmRNsYYeHGZro
	RQzI6TtdVuPgiv1TK1DhouKlLJSnRaBIJHS26bT9EIqFSbsmfHBfFJ4gkhqk=
X-Google-Smtp-Source: AGHT+IEGo9+3zXJX7UvFLVQnLgAtYH19dW0RrFdp1lKTbdXvhZGotcZDFIqVN6TwHmVZ+ZL4/UU9DyUvjvRgmTInihhiv8Tl23/m
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2019:b0:659:9a49:8f96 with SMTP id
 006d021491bc7-65b2abc175fmr3017577eaf.15.1765434142525; Wed, 10 Dec 2025
 22:22:22 -0800 (PST)
Date: Wed, 10 Dec 2025 22:22:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693a631e.a70a0220.33cd7b.0026.GAE@google.com>
Subject: [syzbot] [lsm?] WARNING in collect_domain_accesses (2)
From: syzbot <syzbot+d818ec6483755ab6b0c0@syzkaller.appspotmail.com>
To: gnoack@google.com, jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, mic@digikod.net, paul@paul-moore.com, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    05c93f3395ed Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1077da1a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b5338ad1e59a06c
dashboard link: https://syzkaller.appspot.com/bug?extid=d818ec6483755ab6b0c0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1518b992580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1212deb4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6b5c913e373c/disk-05c93f33.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/15e75f1266ef/vmlinux-05c93f33.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dd930129c578/Image-05c93f33.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d818ec6483755ab6b0c0@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6724 at security/landlock/fs.c:1066 collect_domain_accesses+0x208/0x258 security/landlock/fs.c:-1
Modules linked in:
CPU: 0 UID: 0 PID: 6724 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : collect_domain_accesses+0x208/0x258 security/landlock/fs.c:-1
lr : collect_domain_accesses+0x204/0x258 security/landlock/fs.c:1066
sp : ffff8000a0fc7830
x29: ffff8000a0fc7830 x28: ffff0000ed05d608 x27: ffff8000a0fc7c48
x26: ffff7000141f8f20 x25: dfff800000000000 x24: ffff0000ed01aeb0
x23: 0000000000002004 x22: ffff0000ed01aeb0 x21: ffff0000eb595700
x20: ffff0000ed05d608 x19: 0000000000000000 x18: 0000000000000000
x17: 0000000000000000 x16: ffff800082defd48 x15: 0000000000000001
x14: 0000000000000000 x13: 0000000000000002 x12: 0000000000ff0100
x11: ffff0000c66f0000 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000c66f0000 x7 : ffff800082a23b24 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000010
x2 : ffff8000a0fc7920 x1 : 0000000000002004 x0 : ffff0000ed01af00
Call trace:
 collect_domain_accesses+0x208/0x258 security/landlock/fs.c:-1 (P)
 current_check_refer_path+0x4e8/0xaec security/landlock/fs.c:1202
 hook_path_rename+0x4c/0x60 security/landlock/fs.c:1524
 security_path_rename+0x1dc/0x444 security/security.c:2065
 do_renameat2+0x4b4/0x8a0 fs/namei.c:5352
 __do_sys_renameat2 fs/namei.c:5398 [inline]
 __se_sys_renameat2 fs/namei.c:5395 [inline]
 __arm64_sys_renameat2+0xd8/0xf4 fs/namei.c:5395
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:724
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
irq event stamp: 2148
hardirqs last  enabled at (2147): [<ffff800080dcd64c>] seqcount_lockdep_reader_access+0x7c/0xf8 include/linux/seqlock.h:74
hardirqs last disabled at (2148): [<ffff80008adf99f4>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:412
softirqs last  enabled at (1234): [<ffff8000803d9408>] softirq_handle_end kernel/softirq.c:468 [inline]
softirqs last  enabled at (1234): [<ffff8000803d9408>] handle_softirqs+0xaf8/0xc88 kernel/softirq.c:650
softirqs last disabled at (1127): [<ffff800080022024>] __do_softirq+0x14/0x20 kernel/softirq.c:656
---[ end trace 0000000000000000 ]---


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
