Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356DE53C3AE
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 22:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930147; cv=none; b=FZU3kfgKghQcVAWH6lfLNR5SftfG2zKysZ4s3PJetA/plFfkIzjjzvucuG4EaVe0RQULCMlZezv36TdAFVTIoXORVS9xaB+HTGQ5kJfr6x344UkjndYL0S8fTH89+lyVA6xRPh3UTnAEz9tfUEpDbJlpnIeI9BLIceqJbLM5rYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930147; c=relaxed/simple;
	bh=NwIvVIq01Hapz/mS8aATUvaJJsZ0UfcFyYw2G5vyO2c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=d8lIXfkW6AAW6qefr8/xcmWq6Og0gL7y3szoSR0ju4QoEnmEr9pR22jDaKikbg2CJC+kD+zX2rDfUFPPgE0Mg1ooG7KhHPyTDp8Citsy+HRxxRbztFl3YZyJVdiDCDLNjff0bTn3i4yr0bhUKzszm1YOiCuiaSHAlCKuYwRnOKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4f9b643ae53so3325228b6e.3
        for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 15:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791930145; x=1792534945;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nC9Y66AUbwP61dNcn7uCl9o6jCbcJ0Xkk9MXOm+DELQ=;
        b=UK2sjl8afkYllBzumsOYPkrVeGhoAUFSBeR2wXetSu9cFP/ABQp3sxO/CU2OwTAMY0
         NjGvmtetWfWGSpCVZ+CkLADUEeIv8E8aUxfQEmFip0DcNqD5ZrQxyP8umksQMAp3kYaG
         MmFOOhMx9/5bblbtNLbr4zMo4siTn/FqyYC+OMvB3sofH6/v3BXL45IUBfxGBAoWWC7D
         8osuZIhDulUZXByvGRrDZq6T4bVLd7tH9PjXHyPF6HyWSxDMphrS7fq5Ngn1AZXS+RUN
         jPA7vhlfEEL+KBFDwKWAtdfFnI96Qentneug3Zy1g1UWMZ5dtuhw6Cav+4ZisEB/HQEc
         ZfuQ==
X-Forwarded-Encrypted: i=1; AKwUvBx33MtG1QqVD8ApL8+c1IZXMTRa21O+wR+eEanIWicah8Inz6LXuDBybArMCztuhDoM3LMyE9xOwK9H1egrNydsc6mpths=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8VkJyZ8U7ZSwwWFbX6rimcMS0bCevilZ/Ru44/fdLXkRpf4e3
	C1eQch/3rfOBKsT39sWUzZHBXzpuvsOZ8KtDeyucnp+EZecJUCRgZN/aEieAjJF6q+Mbn2Jb916
	xtUmCOdY32c40SPNZRCH9PUO/4TpwwluuxotgfdpZST3bi43bvC97+8Rm8hk=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2e4d:b0:4e7:978b:ad91 with SMTP id
 5614622812f47-50c57695625mr13025422b6e.49.1791930145279; Tue, 13 Oct 2026
 15:22:25 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:22:25 -0700
In-Reply-To: <6a6aad2e.57649fcc.360844.000d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aceaf21.8cdf6287.1eb53.0174.GAE@google.com>
Subject: Re: [syzbot] [integrity?] [lsm?] possible deadlock in
 __configfs_open_file (2)
From: syzbot <syzbot+c87014f645f2fd24312e@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    24a19b953e2a Linux 7.3-rc7
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=165f3c35580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=129d675874dbf896
dashboard link: https://syzkaller.appspot.com/bug?extid=c87014f645f2fd24312e
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10cf93d1580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c87014f645f2fd24312e@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz-executor387/5997 is trying to acquire lock:
ffff888035be1570 (&p->frag_sem){.+.+}-{4:4}, at: __configfs_open_file+0xe8/0x9c0 fs/configfs/file.c:304

but task is already holding lock:
ffffffff91d84848 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (cb_lock){++++}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       down_read+0x99/0x4c0 kernel/locking/rwsem.c:1574
       genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
       netlink_unicast_kernel net/netlink/af_netlink.c:1338 [inline]
       netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1364
       netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1919
       sock_sendmsg_nosec net/socket.c:800 [inline]
       __sock_sendmsg net/socket.c:815 [inline]
       sock_sendmsg+0x394/0x410 net/socket.c:838
       splice_to_socket+0xb3c/0x11a0 fs/splice.c:884
       do_splice_from fs/splice.c:936 [inline]
       do_splice+0x109c/0x1fa0 fs/splice.c:1349
       __do_splice+0x33b/0x370 fs/splice.c:1431
       __do_sys_splice fs/splice.c:1634 [inline]
       __se_sys_splice fs/splice.c:1616 [inline]
       __x64_sys_splice+0x187/0x250 fs/splice.c:1616
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&pipe->mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       fifo_open+0x139/0xb40 fs/pipe.c:1235
       do_dentry_open+0x6ab/0x14d0 fs/open.c:996
       vfs_open+0x82/0x3f0 fs/open.c:1101
       do_open fs/namei.c:4866 [inline]
       path_openat+0x19fa/0x2440 fs/namei.c:5029
       do_file_open+0x20e/0x430 fs/namei.c:5058
       file_open_name+0x1c3/0x3e0 fs/open.c:1375
       filp_open+0x2e/0x50 fs/open.c:1392
       fsg_lun_open+0x6b/0x7b0 drivers/usb/gadget/function/storage_common.c:194
       fsg_store_file+0x1e7/0x450 drivers/usb/gadget/function/storage_common.c:455
       flush_write_buffer fs/configfs/file.c:207 [inline]
       configfs_write_iter+0x302/0x4e0 fs/configfs/file.c:229
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6af/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&common->filesem){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       down_write+0x8b/0x1f0 kernel/locking/rwsem.c:1631
       fsg_store_file+0x264/0x450 drivers/usb/gadget/function/storage_common.c:452
       flush_write_buffer fs/configfs/file.c:207 [inline]
       configfs_write_iter+0x302/0x4e0 fs/configfs/file.c:229
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6af/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&p->frag_sem){.+.+}-{4:4}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       down_read+0x99/0x4c0 kernel/locking/rwsem.c:1574
       __configfs_open_file+0xe8/0x9c0 fs/configfs/file.c:304
       do_dentry_open+0x6ab/0x14d0 fs/open.c:996
       vfs_open+0x82/0x3f0 fs/open.c:1101
       do_open fs/namei.c:4866 [inline]
       path_openat+0x19fa/0x2440 fs/namei.c:5029
       do_file_open+0x20e/0x430 fs/namei.c:5058
       file_open_name+0x1c3/0x3e0 fs/open.c:1375
       filp_open+0x2e/0x50 fs/open.c:1392
       kernel_read_file_from_path_initns+0xec/0x240 fs/kernel_read_file.c:159
       fw_get_filesystem_firmware drivers/base/firmware_loader/main.c:549 [inline]
       _request_firmware+0x733/0x13c0 drivers/base/firmware_loader/main.c:873
       request_firmware+0x35/0x50 drivers/base/firmware_loader/main.c:948
       reg_reload_regdb+0x85/0x460 net/wireless/reg.c:1067
       genl_family_rcv_msg_doit+0x214/0x300 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x560/0x800 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2575
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1338 [inline]
       netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1364
       netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1919
       sock_sendmsg_nosec net/socket.c:800 [inline]
       __sock_sendmsg net/socket.c:815 [inline]
       sock_sendmsg+0x394/0x410 net/socket.c:838
       splice_to_socket+0xb3c/0x11a0 fs/splice.c:884
       do_splice_from fs/splice.c:936 [inline]
       do_splice+0x109c/0x1fa0 fs/splice.c:1349
       __do_splice+0x33b/0x370 fs/splice.c:1431
       __do_sys_splice fs/splice.c:1634 [inline]
       __se_sys_splice fs/splice.c:1616 [inline]
       __x64_sys_splice+0x187/0x250 fs/splice.c:1616
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &p->frag_sem --> &pipe->mutex --> cb_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(cb_lock);
                               lock(&pipe->mutex);
                               lock(cb_lock);
  rlock(&p->frag_sem);

 *** DEADLOCK ***

locks held by syz-executor387/5997: 2, last CPU#0:
 #0: ffff888035fc7860 (&pipe->mutex){+.+.}-{4:4}, at: pipe_lock fs/pipe.c:91 [inline]
 #0: ffff888035fc7860 (&pipe->mutex){+.+.}-{4:4}, at: pipe_lock+0x69/0x80 fs/pipe.c:88
 #1: ffffffff91d84848 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217

stack backtrace:
CPU: 0 UID: 0 PID: 5997 Comm: syz-executor387 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1be kernel/locking/lockdep.c:2087
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2219
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
 check_prevs_add kernel/locking/lockdep.c:3328 [inline]
 validate_chain kernel/locking/lockdep.c:3952 [inline]
 __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
 lock_acquire kernel/locking/lockdep.c:5942 [inline]
 lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
 down_read+0x99/0x4c0 kernel/locking/rwsem.c:1574
 __configfs_open_file+0xe8/0x9c0 fs/configfs/file.c:304
 do_dentry_open+0x6ab/0x14d0 fs/open.c:996
 vfs_open+0x82/0x3f0 fs/open.c:1101
 do_open fs/namei.c:4866 [inline]
 path_openat+0x19fa/0x2440 fs/namei.c:5029
 do_file_open+0x20e/0x430 fs/namei.c:5058
 file_open_name+0x1c3/0x3e0 fs/open.c:1375
 filp_open+0x2e/0x50 fs/open.c:1392
 kernel_read_file_from_path_initns+0xec/0x240 fs/kernel_read_file.c:159
 fw_get_filesystem_firmware drivers/base/firmware_loader/main.c:549 [inline]
 _request_firmware+0x733/0x13c0 drivers/base/firmware_loader/main.c:873
 request_firmware+0x35/0x50 drivers/base/firmware_loader/main.c:948
 reg_reload_regdb+0x85/0x460 net/wireless/reg.c:1067
 genl_family_rcv_msg_doit+0x214/0x300 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x560/0x800 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2575
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1338 [inline]
 netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1364
 netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:800 [inline]
 __sock_sendmsg net/socket.c:815 [inline]
 sock_sendmsg+0x394/0x410 net/socket.c:838
 splice_to_socket+0xb3c/0x11a0 fs/splice.c:884
 do_splice_from fs/splice.c:936 [inline]
 do_splice+0x109c/0x1fa0 fs/splice.c:1349
 __do_splice+0x33b/0x370 fs/splice.c:1431
 __do_sys_splice fs/splice.c:1634 [inline]
 __se_sys_splice fs/splice.c:1616 [inline]
 __x64_sys_splice+0x187/0x250 fs/splice.c:1616
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7180644b5e
Code: 08 0f 85 f5 e2 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 90 41 57 41 56 4d 89 c6 41 55 4d 89 cd 41 54 55 53 48 83 ec 08
RSP: 002b:00007f717cde6f18 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00007f717cde76c0 RCX: 00007f7180644b5e
RDX: 0000000000000010 RSI: 0000000000000000 RDI: 0000000000000011
RBP: 00007f717cde6fe0 R08: 0000000000000014 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000012
R13: 00007f717cde6f80 R14: 000000000000017e R15: 0000000000000010
 </TASK>
faux_driver regulatory: loading /lib/firmware/regulatory.db failed with error -26
faux_driver regulatory: Direct firmware load for regulatory.db failed with error -26
faux_driver regulatory: Falling back to sysfs fallback for: regulatory.db


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
