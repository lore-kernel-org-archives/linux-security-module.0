Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D631A5BBA
	for <linux-security-module@vger.kernel.org>; Sun, 30 Mar 2025 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743329730; cv=none; b=RQzLTh12NblKZ7r4YUJGbVX/RbjV/ApG1ieA81mOgd1ntodtYCoTYjETlvjjRAEYiL4uYxHojx+VXp7ulNPEkzuN6PCnFnD/O+K5QR29NO64EN3SHl6dJ3r8Tc8TVoRt04k8/Onp0xvv4kQx9qkmeKOozu+pcHdQJO4v8eVOOxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743329730; c=relaxed/simple;
	bh=ovrS+hhQ+D3Vdq+h1iQ2Te5xSJKALDA/V3W/wiq25qc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hJWHm9dJLAG8n3xGdWONizB+vnXUPcyL7Eh3ZVTCJqP2t8+QX0+pFIJ0G7by3lD2Y4XWjwvg4hfX+qJLiD6zN3DMDmmQ4dpiY1bcXUE9ISUvrCNJnEDxmra6I/d7Ir5YbEv7At6Fwx7pfEfIoUPmWl4H4Ml7KvHoOqms1vZa8NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d451ad5b2dso50482215ab.0
        for <linux-security-module@vger.kernel.org>; Sun, 30 Mar 2025 03:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743329728; x=1743934528;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k0cOCVQAoOK647p6NNI63RprUfbyFb3LGuBYJSCgOxg=;
        b=C+v1rnbzH/QaZNHFL8X8XLBbozjb+dGG7ORiQ3F931P9bNccqzj6Nf9KWwTyuzhOfn
         3OB07xhGMlTuruPM9Ok1Ist4sE2VhrJmz9FtChid3juTuijeZ7/hIJKLys8m0+irQ91F
         +/zwlPdr6ZccLhYfZiHG4j3Siqzk9/kWMVz5fkUPWoW+KZuPgXaQ4mGclU4yj6pE0em8
         2u19QgeImMIxe5OXTreIP4ctwAkfWQuepRmsKVLV1hVtVQ4ZzQrXmC6Lu4HEZN0AzYa7
         cIi7jZBh/4chlO1Uoy7zLCPFiDWGJuxiSSuV/PCtI2u8xO5p4L9fLYJLBV/neEXNR7nK
         R8oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSnjaSchfqd/1NTT77BSo8jOlxndCQAMfxzvsS3Tmbud/rO++syf23jYOiKFxSRypG1FZF2ufyOpS5d3O9tsCro/YbzMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFhD9swHwWFkL0GhXXQN+O9PPAbMhoIX/hiYuysIVrr6LkfQUL
	8weT7aSog/flYdqceBqDF+cvOVXoNI2zM+X0tt4DsWD03OMTFUuBVXLhfZmBlfyytzFBdvQaM6b
	jm8885ILz0qr0K5clgYeuuGRPNqbdkJwAbnCWUdChv0yv4pfK0I8r8Xw=
X-Google-Smtp-Source: AGHT+IHD8CiNJzu3epd+Ov9VwJ4+BaqGC0HPg8/F36dMJg9k35uR9gcPnFt2aEXepeTZ6aTPUTmUd6k1+aYCKmQjjHVnXhAA2IrP
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f04:b0:3d3:fa69:6755 with SMTP id
 e9e14a558f8ab-3d5e09366cemr53039315ab.5.1743329727878; Sun, 30 Mar 2025
 03:15:27 -0700 (PDT)
Date: Sun, 30 Mar 2025 03:15:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e919bf.050a0220.1547ec.00a0.GAE@google.com>
Subject: [syzbot] [lsm?] WARNING in free_ruleset
From: syzbot <syzbot+8bca99e91de7e060e4ea@syzkaller.appspotmail.com>
To: gnoack@google.com, jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, mic@digikod.net, paul@paul-moore.com, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7d06015d936c Merge tag 'pci-v6.15-changes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c4fbb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2dde96545058477
dashboard link: https://syzkaller.appspot.com/bug?extid=8bca99e91de7e060e4ea
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13380404580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174f764c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-7d06015d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a3714415ac07/vmlinux-7d06015d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/60a299508e73/Image-7d06015d.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8bca99e91de7e060e4ea@syzkaller.appspotmail.com

 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:151
 el0_svc+0x30/0xe0 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x10c/0x138 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:600
------------[ cut here ]------------
WARNING: CPU: 1 PID: 3298 at security/landlock/domain.h:133 __ll_sc_atomic_fetch_sub_release arch/arm64/include/asm/atomic_ll_sc.h:96 [inline]
WARNING: CPU: 1 PID: 3298 at security/landlock/domain.h:133 arch_atomic_fetch_sub_release arch/arm64/include/asm/atomic.h:51 [inline]
WARNING: CPU: 1 PID: 3298 at security/landlock/domain.h:133 raw_atomic_fetch_sub_release include/linux/atomic/atomic-arch-fallback.h:944 [inline]
WARNING: CPU: 1 PID: 3298 at security/landlock/domain.h:133 atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:401 [inline]
WARNING: CPU: 1 PID: 3298 at security/landlock/domain.h:133 __refcount_sub_and_test include/linux/refcount.h:264 [inline]
WARNING: CPU: 1 PID: 3298 at security/landlock/domain.h:133 __refcount_dec_and_test include/linux/refcount.h:307 [inline]
WARNING: CPU: 1 PID: 3298 at security/landlock/domain.h:133 refcount_dec_and_test include/linux/refcount.h:325 [inline]
WARNING: CPU: 1 PID: 3298 at security/landlock/domain.h:133 landlock_put_hierarchy security/landlock/domain.h:164 [inline]
WARNING: CPU: 1 PID: 3298 at security/landlock/domain.h:133 free_ruleset+0x144/0x174 security/landlock/ruleset.c:490
Modules linked in:
CPU: 1 UID: 0 PID: 3298 Comm: syz-executor356 Not tainted 6.14.0-syzkaller-09584-g7d06015d936c #0 PREEMPT 
Hardware name: linux,dummy-virt (DT)
pstate: 61402009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : landlock_free_hierarchy_details security/landlock/domain.h:133 [inline]
pc : landlock_put_hierarchy security/landlock/domain.h:168 [inline]
pc : free_ruleset+0x144/0x174 security/landlock/ruleset.c:490
lr : landlock_put_hierarchy security/landlock/domain.h:167 [inline]
lr : free_ruleset+0xdc/0x174 security/landlock/ruleset.c:490
sp : ffff800089483d30
x29: ffff800089483d30 x28: f7f0000005ba0000 x27: 0000000000000000
x26: 0000000000000000 x25: fcf000000415ca80 x24: fcf00000040a7438
x23: 00000000ffffffff x22: 0000000000000001 x21: fcf00000040a7420
x20: fcf00000040a7420 x19: f1f000000678ca00 x18: 00000000fffffffd
x17: 0000000000000000 x16: 0000000000000000 x15: ffff800089483270
x14: 00000000ffffffea x13: ffff800089483808 x12: ffff80008298eb10
x11: 0000000000000001 x10: 0000000000000001 x9 : 000000000002ffe8
x8 : f7f0000005ba0000 x7 : ffff800089483fd8 x6 : 00000000000affa8
x5 : fff000007f8e3588 x4 : ffff800089484000 x3 : 0000000000000000
x2 : fcf00000040a7458 x1 : 0000000000000001 x0 : 0000000000000000
Call trace:
 __ll_sc_atomic_fetch_sub_release arch/arm64/include/asm/atomic_ll_sc.h:96 [inline] (P)
 arch_atomic_fetch_sub_release arch/arm64/include/asm/atomic.h:51 [inline] (P)
 raw_atomic_fetch_sub_release include/linux/atomic/atomic-arch-fallback.h:944 [inline] (P)
 atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:401 [inline] (P)
 __refcount_sub_and_test include/linux/refcount.h:264 [inline] (P)
 __refcount_dec_and_test include/linux/refcount.h:307 [inline] (P)
 refcount_dec_and_test include/linux/refcount.h:325 [inline] (P)
 landlock_put_hierarchy security/landlock/domain.h:164 [inline] (P)
 free_ruleset+0x144/0x174 security/landlock/ruleset.c:490 (P)
 landlock_put_ruleset security/landlock/ruleset.c:498 [inline]
 landlock_put_ruleset security/landlock/ruleset.c:494 [inline]
 __free_landlock_put_ruleset security/landlock/ruleset.h:200 [inline]
 landlock_merge_ruleset+0x210/0x440 security/landlock/ruleset.c:534
 __do_sys_landlock_restrict_self security/landlock/syscalls.c:549 [inline]
 __se_sys_landlock_restrict_self security/landlock/syscalls.c:479 [inline]
 __arm64_sys_landlock_restrict_self+0xb0/0x250 security/landlock/syscalls.c:479
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x48/0x110 arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:151
 el0_svc+0x30/0xe0 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x10c/0x138 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:600
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
