Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E24E3081C6
	for <linux-security-module@vger.kernel.org>; Fri,  7 Nov 2025 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762500567; cv=none; b=h9hXYrMUmTQ7B9zSF9Q8Jpj5oiA8niBaHtJfU+9bani+rZ5SYvX4cKV8G11EwQKcHEXMUp9vFD1kLcdo5oYvjj7d7m6UWM2CrDfGBx0B6u+DsyY0NuM7EL80HO1KIPg6ZS3QMAX8G5SunZuB22tOobW6EOWMkusx0MP8xTRBO3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762500567; c=relaxed/simple;
	bh=T/6l23nZi52zglUNYwge3hIIaiT/4LeSIyGyn4yQr8A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=G37nGzCe5/S8jlBQIG9hnMqEwfxWOaefAZgbHjnR6/yhh8upKlM0C43Kb630Dy5TJyzIvrBNu25lc+fuH8jvwKD8za2+ETgDfH/PMuSVy5RcNH+lgqe/6ttgdT7GGzLzPFx/sRUEd79WlPBNOkXpaHuiIdMWpWE4xJy181pyDLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-4330bc0373bso3835295ab.0
        for <linux-security-module@vger.kernel.org>; Thu, 06 Nov 2025 23:29:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762500564; x=1763105364;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s5W+rFgUZ/uJudC5g+eSdKAW0wXp+cC7dSDBHEAlSa4=;
        b=GbPbculWo9kjd6ypNXgmMhzdDQplM5ImlRbPzmp93QBny9MfFEw521OAzYNj4mSaF2
         k9C6Cc//m61xuH8jU59zfoMOOT7cN2Sp6boclnXECSlwuv+r01oiHp53hT+WjcDP5mY8
         ulWdsQM01uBF5T4bP6qIksSFjX/jCDs8Za3oTbjNS4H0Ih9aG5gElAN2j0F2uZhOpjoO
         HY/pe6vPo2gkqutFVKNzasjVrPOx5F2XmgLZqIQY1d2GbgLdpt3NV1nMfwem8tSEdy/n
         WD7mWXRV7IwGckGOzPMWqaq1em4PNxMmnGJlwPFacN+ajgr5Owhz/L5PBV34TbW1qzsX
         ipVg==
X-Forwarded-Encrypted: i=1; AJvYcCVcJxJZMZvL0IidfpHiU5wWJz1YpZZV0ARFeoOhY+DIuOeTyl8wga830eTns+mPAvknMOqLA/5crUpn8pqZccbfN/rA//w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Z+d6owtQWT0Wct9GRP+ob/xEClLDQMAeWsD1zuuL2mMgJFBr
	Vq92uxogRQVJWqV4aThTWDMyEcDR4usntoIL/FSejMWGQBWEA8vCjGRmCaz2dZKRIYYj87hiE+M
	/H0cydzx1kCVYg4BotYnTqfq+l2oAoByiGe6xzGNJ5xCoPxsUd2cE5JAzqKA=
X-Google-Smtp-Source: AGHT+IGJzTWQwoZJc4ZKPxmx0SxA2vnLX7i5ExPqU93a6I8oqil7cn132KQRnvDTiYgs7hTyXDz4fidWzX1eaIFdHKsNdN5qTU4r
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:308d:b0:433:3498:6906 with SMTP id
 e9e14a558f8ab-4335f4b5c8emr35355525ab.32.1762500564354; Thu, 06 Nov 2025
 23:29:24 -0800 (PST)
Date: Thu, 06 Nov 2025 23:29:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690d9fd4.a70a0220.22f260.0023.GAE@google.com>
Subject: [syzbot] [lsm?] memory leak in prepare_creds (5)
From: syzbot <syzbot+099461f8558eb0a1f4f3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com, sergeh@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c2c2ccfd4ba7 Merge tag 'net-6.18-rc5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d6ca92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb128cd5cb439809
dashboard link: https://syzkaller.appspot.com/bug?extid=099461f8558eb0a1f4f3
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ac7012580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12aa10b4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b0451ba3fe41/disk-c2c2ccfd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d3e8c67119ab/vmlinux-c2c2ccfd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1d8e176e5054/bzImage-c2c2ccfd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+099461f8558eb0a1f4f3@syzkaller.appspotmail.com

2025/11/07 06:07:22 executed programs: 5
BUG: memory leak
unreferenced object 0xffff888101ad8900 (size 184):
  comm "syz-executor", pid 5986, jiffies 4294942797
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 45b79b1):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    kmem_cache_alloc_noprof+0x397/0x5a0 mm/slub.c:5287
    prepare_creds+0x22/0x4f0 kernel/cred.c:212
    copy_creds+0x44/0x290 kernel/cred.c:312
    copy_process+0x706/0x27d0 kernel/fork.c:2046
    kernel_clone+0x119/0x6c0 kernel/fork.c:2609
    __do_sys_clone+0x7b/0xb0 kernel/fork.c:2750
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88810096ace0 (size 32):
  comm "syz-executor", pid 5986, jiffies 4294942797
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    f8 f2 85 00 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace (crc 894df7a1):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    __do_kmalloc_node mm/slub.c:5641 [inline]
    __kmalloc_noprof+0x3e3/0x6b0 mm/slub.c:5654
    kmalloc_noprof include/linux/slab.h:961 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    lsm_blob_alloc+0x4d/0x70 security/security.c:690
    lsm_cred_alloc security/security.c:707 [inline]
    security_prepare_creds+0x30/0x270 security/security.c:3310
    prepare_creds+0x346/0x4f0 kernel/cred.c:242
    copy_creds+0x44/0x290 kernel/cred.c:312
    copy_process+0x706/0x27d0 kernel/fork.c:2046
    kernel_clone+0x119/0x6c0 kernel/fork.c:2609
    __do_sys_clone+0x7b/0xb0 kernel/fork.c:2750
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888128f3ca00 (size 1264):
  comm "kworker/1:1", pid 42, jiffies 4294942797
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    28 00 0b 40 00 00 00 00 00 00 00 00 00 00 00 00  (..@............
  backtrace (crc fdfa4398):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    kmem_cache_alloc_noprof+0x397/0x5a0 mm/slub.c:5287
    sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:2233
    sk_alloc+0x36/0x360 net/core/sock.c:2295
    __vsock_create.constprop.0+0x38/0x2f0 net/vmw_vsock/af_vsock.c:788
    virtio_transport_recv_listen net/vmw_vsock/virtio_transport_common.c:1527 [inline]
    virtio_transport_recv_pkt+0x7fd/0xf30 net/vmw_vsock/virtio_transport_common.c:1655
    vsock_loopback_work+0xfe/0x140 net/vmw_vsock/vsock_loopback.c:133
    process_one_work+0x26b/0x620 kernel/workqueue.c:3263
    process_scheduled_works kernel/workqueue.c:3346 [inline]
    worker_thread+0x2c4/0x4f0 kernel/workqueue.c:3427
    kthread+0x15b/0x310 kernel/kthread.c:463
    ret_from_fork+0x210/0x240 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888146540100 (size 32):
  comm "kworker/1:1", pid 42, jiffies 4294942797
  hex dump (first 32 bytes):
    f8 f2 85 00 81 88 ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc e7cc8a40):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    __do_kmalloc_node mm/slub.c:5641 [inline]
    __kmalloc_noprof+0x3e3/0x6b0 mm/slub.c:5654
    kmalloc_noprof include/linux/slab.h:961 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    lsm_blob_alloc+0x4d/0x70 security/security.c:690
    lsm_sock_alloc security/security.c:4922 [inline]
    security_sk_alloc+0x30/0x270 security/security.c:4938
    sk_prot_alloc+0x8f/0x1b0 net/core/sock.c:2242
    sk_alloc+0x36/0x360 net/core/sock.c:2295
    __vsock_create.constprop.0+0x38/0x2f0 net/vmw_vsock/af_vsock.c:788
    virtio_transport_recv_listen net/vmw_vsock/virtio_transport_common.c:1527 [inline]
    virtio_transport_recv_pkt+0x7fd/0xf30 net/vmw_vsock/virtio_transport_common.c:1655
    vsock_loopback_work+0xfe/0x140 net/vmw_vsock/vsock_loopback.c:133
    process_one_work+0x26b/0x620 kernel/workqueue.c:3263
    process_scheduled_works kernel/workqueue.c:3346 [inline]
    worker_thread+0x2c4/0x4f0 kernel/workqueue.c:3427
    kthread+0x15b/0x310 kernel/kthread.c:463
    ret_from_fork+0x210/0x240 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888109c274e0 (size 96):
  comm "kworker/1:1", pid 42, jiffies 4294942797
  hex dump (first 32 bytes):
    00 ca f3 28 81 88 ff ff 00 00 00 00 00 00 00 00  ...(............
    00 00 00 00 00 00 00 00 00 00 04 00 00 00 00 00  ................
  backtrace (crc 4f48ed20):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    __kmalloc_cache_noprof+0x3a6/0x5b0 mm/slub.c:5758
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    virtio_transport_do_socket_init+0x2b/0xf0 net/vmw_vsock/virtio_transport_common.c:910
    vsock_assign_transport+0x31b/0x3a0 net/vmw_vsock/af_vsock.c:537
    virtio_transport_recv_listen net/vmw_vsock/virtio_transport_common.c:1545 [inline]
    virtio_transport_recv_pkt+0x861/0xf30 net/vmw_vsock/virtio_transport_common.c:1655
    vsock_loopback_work+0xfe/0x140 net/vmw_vsock/vsock_loopback.c:133
    process_one_work+0x26b/0x620 kernel/workqueue.c:3263
    process_scheduled_works kernel/workqueue.c:3346 [inline]
    worker_thread+0x2c4/0x4f0 kernel/workqueue.c:3427
    kthread+0x15b/0x310 kernel/kthread.c:463
    ret_from_fork+0x210/0x240 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888101a80f00 (size 184):
  comm "syz-executor", pid 5986, jiffies 4294942798
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 51e903bf):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    kmem_cache_alloc_noprof+0x397/0x5a0 mm/slub.c:5287
    prepare_creds+0x22/0x4f0 kernel/cred.c:212
    copy_creds+0x44/0x290 kernel/cred.c:312
    copy_process+0x706/0x27d0 kernel/fork.c:2046
    kernel_clone+0x119/0x6c0 kernel/fork.c:2609
    __do_sys_clone+0x7b/0xb0 kernel/fork.c:2750
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


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
