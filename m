Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A49246783
	for <linux-security-module@vger.kernel.org>; Tue,  4 Aug 2026 00:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785802176; cv=none; b=kFYMGzRoMmAJr2io3Cs6s5uZj82p8RqRqsXL41htt/AxhaCbUzboWoFSdfnOwhwp4H7eBG7YWySQpgFnDKZs8SSXiOE1fx4pG3raxdc3K/ByTE+uWUUenlazius/evZ3NspXijbombnuMmV4s5SUGO6k8eT1wzvW9vhwCWvyVMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785802176; c=relaxed/simple;
	bh=71VsQAIVxUGPxHKeP3UBBbp1Lk99gQjrKIOXDWlJvnI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YST6BUMfH48QE1Sh3vPMHqkJeUokG68mE/6lxJ0fQl+KpDX1AZDB//6eSQX0ZQ0LjzIxIHVaNxUOkvL8KhJ6GaAQ+tECQdTSM+G+iQr6yTwp7lMdGcyuQ/OI4JJPGA5RGl6C4LgpGHCy3Q43sLJcHNXO3mOC9408+Puia3/bcu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4a43d32fa9fso5542696b6e.2
        for <linux-security-module@vger.kernel.org>; Mon, 03 Aug 2026 17:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785802174; x=1786406974;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FFUnk8XXN6rMqX/A5gun+tR1e8c+1vrRhURKsjCc+8o=;
        b=JYjv1ssF/VVxfQIjErCvY0sVfIBaWFxUM9fCzgjLo9jvnJyGMNXSAujsNdg8vNifGt
         zT9/mVnj7Mp2CrVl1Nm9QP4NP3mmEza5fcKHA+9/G9TWNZR9U8wUVtdoedUM5L/G/v1M
         /tL/L+Fwpe8vSk2DzXbvt3EG/ElbxrJlY1tgjSYWU3dpRnzqSvy9S6Uv9tTZckMjNqmH
         AbfDd3gHMc1GnMfYPyUoM9yNSv5gcZg5oWdcT7cQwJ86Bn9TOjeiRzrDUOOXF8Y1T0+V
         OU3Ri8DgVSt0CiF6YCCwLrC/Pa8NrLor4Ryxo1epH5iYj1Bk5Enk/cisc5aUd2OBphfi
         FFvg==
X-Forwarded-Encrypted: i=1; AHgh+Rqaingijq3pFMEkKky968A3yQ/1HxC/SM2+/dCignlyaBY388RR+3/MXZS/AuP9C4lWVIDQxW/GEvr3Oz4PYN3W8vqVWLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ5jSvvRA1M+Tv0A3kcVNTz6Jq81rgcQDwOlB9gcX8VdXFbV9G
	KJbgnqhjOqIxXNguzT5Qa5UoZIdyWu1ILQ4SOQGEbSdl8bxbox36qPP605JBBVcCM20+ahcO14F
	dses0dIv5MpzkGIYEgNYk+gMhPTEJ6iWB99ehY8yfgdj0k8nEhZPV2QC8Nuw=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:180d:b0:487:61da:70fb with SMTP id
 5614622812f47-4af5e1ce58amr20025013b6e.10.1785802173932; Mon, 03 Aug 2026
 17:09:33 -0700 (PDT)
Date: Mon, 03 Aug 2026 17:09:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a712dbd.9511d2ce.1fc5b9.032a.GAE@google.com>
Subject: [syzbot] [lsm?] memory leak in prepare_creds (7)
From: syzbot <syzbot+53515d23498d641e21ea@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com, sergeh@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    11028ab62899 Merge tag 'probes-fixes-v7.2-rc5' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=140471b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba7c2d1679fb08a2
dashboard link: https://syzkaller.appspot.com/bug?extid=53515d23498d641e21ea
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1759d9b9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122d4aea580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b677b453b580/disk-11028ab6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eec6e520d498/vmlinux-11028ab6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/03c59bb4309c/bzImage-11028ab6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+53515d23498d641e21ea@syzkaller.appspotmail.com

2026/07/30 13:50:02 executed programs: 5
BUG: memory leak
unreferenced object 0xffff88810ab2c540 (size 184):
  comm "syz-executor", pid 5809, jiffies 4294943975
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 706c7ae4):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4597 [inline]
    slab_alloc_node mm/slub.c:4917 [inline]
    kmem_cache_alloc_noprof+0x34f/0x440 mm/slub.c:4931
    prepare_creds+0x22/0x570 kernel/cred.c:185
    copy_creds+0x44/0x290 kernel/cred.c:286
    copy_process+0x988/0x2d70 kernel/fork.c:2153
    kernel_clone+0x101/0x710 kernel/fork.c:2748
    __do_sys_clone+0x7f/0xb0 kernel/fork.c:2889
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf8/0x610 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff8881021256c0 (size 32):
  comm "syz-executor", pid 5809, jiffies 4294943975
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    f8 52 0a 00 81 88 ff ff 00 00 00 00 00 00 00 00  .R..............
  backtrace (crc 9ae86290):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4597 [inline]
    slab_alloc_node mm/slub.c:4917 [inline]
    __do_kmalloc_node mm/slub.c:5333 [inline]
    __kmalloc_noprof+0x3bf/0x550 mm/slub.c:5359
    _kmalloc_noprof include/linux/slab.h:992 [inline]
    _kzalloc_noprof include/linux/slab.h:1309 [inline]
    lsm_blob_alloc+0x4d/0x80 security/security.c:218
    lsm_cred_alloc security/security.c:235 [inline]
    security_prepare_creds+0x2d/0x290 security/security.c:2866
    prepare_creds+0x317/0x570 kernel/cred.c:215
    copy_creds+0x44/0x290 kernel/cred.c:286
    copy_process+0x988/0x2d70 kernel/fork.c:2153
    kernel_clone+0x101/0x710 kernel/fork.c:2748
    __do_sys_clone+0x7f/0xb0 kernel/fork.c:2889
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf8/0x610 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff8881068d2d00 (size 1272):
  comm "kworker/1:2", pid 2174, jiffies 4294943976
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    28 00 0b 40 00 00 00 00 00 00 00 00 00 00 00 00  (..@............
  backtrace (crc ff0fde65):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4597 [inline]
    slab_alloc_node mm/slub.c:4917 [inline]
    kmem_cache_alloc_noprof+0x34f/0x440 mm/slub.c:4931
    sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:2246
    sk_alloc+0x36/0x3d0 net/core/sock.c:2308
    __vsock_create.constprop.0+0x38/0x2f0 net/vmw_vsock/af_vsock.c:919
    virtio_transport_recv_listen net/vmw_vsock/virtio_transport_common.c:1721 [inline]
    virtio_transport_recv_pkt+0x8fa/0x16c0 net/vmw_vsock/virtio_transport_common.c:1847
    vsock_loopback_work+0x104/0x140 net/vmw_vsock/vsock_loopback.c:142
    process_one_work+0x277/0x5a0 kernel/workqueue.c:3322
    process_scheduled_works kernel/workqueue.c:3405 [inline]
    worker_thread+0x255/0x4a0 kernel/workqueue.c:3486
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x219/0x490 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff8881145bbb60 (size 32):
  comm "kworker/1:2", pid 2174, jiffies 4294943976
  hex dump (first 32 bytes):
    f8 52 0a 00 81 88 ff ff 00 00 00 00 00 00 00 00  .R..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 42a7bc0e):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4597 [inline]
    slab_alloc_node mm/slub.c:4917 [inline]
    __do_kmalloc_node mm/slub.c:5333 [inline]
    __kmalloc_noprof+0x3bf/0x550 mm/slub.c:5359
    _kmalloc_noprof include/linux/slab.h:992 [inline]
    _kzalloc_noprof include/linux/slab.h:1309 [inline]
    lsm_blob_alloc+0x4d/0x80 security/security.c:218
    lsm_sock_alloc security/security.c:4478 [inline]
    security_sk_alloc+0x2d/0x290 security/security.c:4494
    sk_prot_alloc+0x8f/0x1b0 net/core/sock.c:2255
    sk_alloc+0x36/0x3d0 net/core/sock.c:2308
    __vsock_create.constprop.0+0x38/0x2f0 net/vmw_vsock/af_vsock.c:919
    virtio_transport_recv_listen net/vmw_vsock/virtio_transport_common.c:1721 [inline]
    virtio_transport_recv_pkt+0x8fa/0x16c0 net/vmw_vsock/virtio_transport_common.c:1847
    vsock_loopback_work+0x104/0x140 net/vmw_vsock/vsock_loopback.c:142
    process_one_work+0x277/0x5a0 kernel/workqueue.c:3322
    process_scheduled_works kernel/workqueue.c:3405 [inline]
    worker_thread+0x255/0x4a0 kernel/workqueue.c:3486
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x219/0x490 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff88811573e0c0 (size 96):
  comm "kworker/1:2", pid 2174, jiffies 4294943976
  hex dump (first 32 bytes):
    00 2d 8d 06 81 88 ff ff 00 00 00 00 00 00 00 00  .-..............
    00 00 00 00 00 00 00 00 00 00 04 00 00 00 00 00  ................
  backtrace (crc af6af911):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4597 [inline]
    slab_alloc_node mm/slub.c:4917 [inline]
    __kmalloc_cache_noprof+0x356/0x440 mm/slub.c:5485
    _kmalloc_noprof include/linux/slab.h:988 [inline]
    _kzalloc_noprof include/linux/slab.h:1309 [inline]
    virtio_transport_do_socket_init+0x2b/0xf0 net/vmw_vsock/virtio_transport_common.c:1056
    vsock_assign_transport+0x3a3/0x460 net/vmw_vsock/af_vsock.c:670
    virtio_transport_recv_listen net/vmw_vsock/virtio_transport_common.c:1737 [inline]
    virtio_transport_recv_pkt+0x956/0x16c0 net/vmw_vsock/virtio_transport_common.c:1847
    vsock_loopback_work+0x104/0x140 net/vmw_vsock/vsock_loopback.c:142
    process_one_work+0x277/0x5a0 kernel/workqueue.c:3322
    process_scheduled_works kernel/workqueue.c:3405 [inline]
    worker_thread+0x255/0x4a0 kernel/workqueue.c:3486
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x219/0x490 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff8881068d2800 (size 1272):
  comm "kworker/1:2", pid 2174, jiffies 4294943977
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    28 00 0b 40 00 00 00 00 00 00 00 00 00 00 00 00  (..@............
  backtrace (crc e503b7a6):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4597 [inline]
    slab_alloc_node mm/slub.c:4917 [inline]
    kmem_cache_alloc_noprof+0x34f/0x440 mm/slub.c:4931
    sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:2246
    sk_alloc+0x36/0x3d0 net/core/sock.c:2308
    __vsock_create.constprop.0+0x38/0x2f0 net/vmw_vsock/af_vsock.c:919
    virtio_transport_recv_listen net/vmw_vsock/virtio_transport_common.c:1721 [inline]
    virtio_transport_recv_pkt+0x8fa/0x16c0 net/vmw_vsock/virtio_transport_common.c:1847
    vsock_loopback_work+0x104/0x140 net/vmw_vsock/vsock_loopback.c:142
    process_one_work+0x277/0x5a0 kernel/workqueue.c:3322
    process_scheduled_works kernel/workqueue.c:3405 [inline]
    worker_thread+0x255/0x4a0 kernel/workqueue.c:3486
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x219/0x490 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

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
