Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1FE19EEB5
	for <linux-security-module@vger.kernel.org>; Thu, 11 Jul 2024 21:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720734804; cv=none; b=hJkILqtOMFjmWUYyDFQtDMZgGYhaqPradF7u7+rXoFx0pPUQWAwHuWeKZx1okGM2WMBNv+rdRi1nIMm5FOlSQoy6OInusyKFeGvgVIbkU4dpKhE0avlfdy0/H2QBwGS0XSImsJE1IWjEjCxUqCfKps/RvEbDp4WE3Ak0VHQYfzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720734804; c=relaxed/simple;
	bh=goIEMmWra4VR/zk22neEfR4vdCzY0/UgpHk9a4hIxwU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UWSerX7dl1QMScVk5xPlSap7keUuIbJNHF4F0nRxYgQe9ZzIMx6Ek/FugRjBE8J/FX7247mK1mcCLsj0S6ivxTVu8vfOvVLPny+A/xZHy3C/NqX5VVmpODUz5i5kv2hWv5EH+cFYpAIwwBfOgMrYd/Psa0MPUWM06YlYCBx3Fig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ebd11f77d8so145104039f.1
        for <linux-security-module@vger.kernel.org>; Thu, 11 Jul 2024 14:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720734802; x=1721339602;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXJESV0WdNekAbfoHI/LlmU+KNikxwbt+E0/4D+3BZg=;
        b=GpLcS2ATMED9eNajibTevBuVQsmswBVQsQkGltywjZYHBalrUIK0gNW/lgOWfqskhA
         aKYUAXcOI5PH4ptdMa/64STFk2ZzK2DuPMcBaI1/edfLnPCUa0XXk/FBhx12MsmtWlbu
         /a248GxugYvPMI3dH5o4ZfnaEpzxdR3CwD4LMS3luSO6cXosRAaTvjABKsAAZh/SjJQk
         gPlg6zSvIKTTlIa1h0yXZDW1lurQGbWlulzglgaKjlO0fxm/zifc5xq6lpusbMHECmq0
         FjuyPyi81emRudBk8jK6vB4HOOkKyrD+KG2suRHsub03tB0etbDQS9kf+jyDYWRpqo/P
         UT9g==
X-Forwarded-Encrypted: i=1; AJvYcCWwL/wctHtq0p04l/VIRECZ6AL0OOIBaR+FAk95AqS3U04FJ+djYRbWmRwTEGVefjwjFAdG3d3az47u/XQOF2UsvXO6E+kPuiWwZjzzTDKaGsWT94Oa
X-Gm-Message-State: AOJu0YxhVOcLqtxco0oRNgRhOorV/KlFEzKk8wryaNanleHUcxCdshNb
	JLxU6Uzev1Ej7sI7hAv1vzeB6Xr1uvHr1ayQlQgJqbNUfXW+QxqIllRaQGR2X41fc7eT2YUyJGE
	tttzJn0RZ2NIEDnDZJjYkNX79wHFAmqJk2u2/Y7KDGVc8wSpmWUCE044=
X-Google-Smtp-Source: AGHT+IHVS/YlITEt2BXnTIL542JUTWdyivpk5UIPFWWjYA5LIpKxgrePwZfj+2S149fL/3tLEYZAxEiYs8lXYRiF5Ip4M4yCwrvE
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3416:b0:808:469:7072 with SMTP id
 ca18e2360f4ac-808046971bbmr16947439f.3.1720734802396; Thu, 11 Jul 2024
 14:53:22 -0700 (PDT)
Date: Thu, 11 Jul 2024 14:53:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a65b35061cffca61@google.com>
Subject: [syzbot] [lsm?] WARNING in current_check_refer_path
From: syzbot <syzbot+34b68f850391452207df@syzkaller.appspotmail.com>
To: gnoack@google.com, jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, mic@digikod.net, paul@paul-moore.com, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8a03d70c27fc Merge remote-tracking branch 'tglx/devmsi-arm..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=174b0e6e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15349546db652fd3
dashboard link: https://syzkaller.appspot.com/bug?extid=34b68f850391452207df
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13cd1b69980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12667fd1980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/efb354033e75/disk-8a03d70c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c747c205d094/vmlinux-8a03d70c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5641f4fb7265/Image-8a03d70c.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4e4d1faacdef/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+34b68f850391452207df@syzkaller.appspotmail.com

bcachefs (loop0): resume_logged_ops... done
bcachefs (loop0): delete_dead_inodes... done
bcachefs (loop0): done starting filesystem
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6284 at security/landlock/fs.c:971 current_check_refer_path+0x4e0/0xaa8 security/landlock/fs.c:1132
Modules linked in:
CPU: 0 PID: 6284 Comm: syz-executor169 Not tainted 6.10.0-rc6-syzkaller-g8a03d70c27fc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : current_check_refer_path+0x4e0/0xaa8 security/landlock/fs.c:1132
lr : get_mode_access security/landlock/fs.c:953 [inline]
lr : current_check_refer_path+0x4dc/0xaa8 security/landlock/fs.c:1132
sp : ffff80009bb47840
x29: ffff80009bb47980 x28: ffff80009bb478e0 x27: 0000000000000001
x26: 1fffe0001b7a831f x25: ffff0000d713ef00 x24: ffff700013768f14
x23: 000000000000f1ed x22: dfff800000000000 x21: ffff0000dbd418f8
x20: 0000000000000000 x19: 0000000000001fff x18: ffff80009bb46be0
x17: ffff800080b8363c x16: ffff80008afaca80 x15: 0000000000000004
x14: 1ffff00013768f24 x13: 0000000000000000 x12: 0000000000000000
x11: ffff700013768f28 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d6845ac0 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000020
x2 : 0000000000000000 x1 : 000000000000f1ed x0 : 000000000000d000
Call trace:
 current_check_refer_path+0x4e0/0xaa8 security/landlock/fs.c:1132
 hook_path_rename+0x4c/0x60 security/landlock/fs.c:1416
 security_path_rename+0x154/0x1f0 security/security.c:1918
 do_renameat2+0x724/0xe40 fs/namei.c:5031
 __do_sys_renameat2 fs/namei.c:5078 [inline]
 __se_sys_renameat2 fs/namei.c:5075 [inline]
 __arm64_sys_renameat2+0xe0/0xfc fs/namei.c:5075
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:131
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:150
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 67226
hardirqs last  enabled at (67225): [<ffff80008b1683b4>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (67225): [<ffff80008b1683b4>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
hardirqs last disabled at (67226): [<ffff80008b06e498>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
softirqs last  enabled at (66914): [<ffff8000800307e0>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (66912): [<ffff8000800307ac>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
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
