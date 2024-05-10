Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EB01391
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299322; cv=none; b=T/JR/HlkCWLAqS6Y7WCe5IpJD+UJNFshjEtuDrFAHTAGHrrjfFo3plqwaa2ZSs92FQct5q+Lm9k49YDdU6tdIjak9IA0I6PUXlI+UOP/VXy9K0E695bF/6kCmt1NRaiRTgtjxmWWj3wVDx4eCpA6V1Ft5w7mVEtUf0HcK0woNzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299322; c=relaxed/simple;
	bh=OlAITSwVfVGwfbVP8ZkkJm+w/eV7SN9Ioh/iFkWSAaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJmXJxyKAh/kwlXP/Pr8WkUBEcOzX8LmUdQSZu/Y/cqaC5nvXdEOt+nIn8hxSkH/Wcfvxxk3KkuLsW3B2hIHV8m/e9B/fjuEtDa/v7iG9LmzjOaSau7mCX3I2MASjU6wVb0HSFhSquUw+ioikFE2XEXUm83qBbJ09ksNaQKUtls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RHyJUuvm; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RHyJUuvm"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de603e3072dso1697810276.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715299320; x=1715904120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CcBKlmciLpmvNHCsy7hLP5Lu9KrCDmkSJsbPPcO9nI=;
        b=RHyJUuvmxgglJQt5oHNUcyONhDWEl6fVIoRo9ze3BIK0bxoPSX3p6y3vYELmNBovaj
         NiKh+6ugldjcpeQueoy9x5bAbZvo2bYQ2c6ROjHNkk1dTejagIqDhWTLJ14NwJKNnZcl
         nJUX36m6Kh8j+0BHepT0wftrVmrX4OuoCdPdg9grI4AOejIgBytvZxhcVr18GOQHPH2X
         +O0/V/rRE2WG9+Lv9FR7N3tR0PQ19VcjBEgqEFQHRb9xW6h+Ls5GPaXz5KygLHsx4Ok3
         K7j2v1kaJdK2UEpV6FW8tue/ENkdrhJv85JILwtr2Pwf1VjDg6mSxhFZKWVjx+MHkMls
         kkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299320; x=1715904120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CcBKlmciLpmvNHCsy7hLP5Lu9KrCDmkSJsbPPcO9nI=;
        b=syJVPcEFGhp59HqOCi2EC/hNqarlosKGObk88FxdZTrMGopi6S36+38K+4bCKedJoP
         VP9moTUVDJUeGKXlPVaE16b2PY55vIGcMi+s4g3SA7+W2e3VUTFAPy9fHSR1uHLlMB3p
         HUP6vzTYFAMHzAyO2b8qYrqLyZBxbO5Dsud6PSmdxZ0k0bcVLwLr/vjfWDAPk5YKTMJ3
         6sqzVuyPvGdTSqdJXdbNbnghVGIy6Zwy5aJdHf57c+GdoJvmEcWid1D3qEBYq2jOgVjF
         ySMtpn0ISmFRxPdqHLIGPaFFCGUna7gJ4GgY+c+TN550RS7Jujtbbj2mG9k7Cjf07dvX
         NsEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7Y01vBd1aiIl0yOq2w2y5fqoq9K0Ki8tP/sOFlgYpN3rfJn41seBHeNBeQLBV5oWL30UvxEnrsNLqQI5TEa3cFMl1nTqcRyWyay/em52FWMRZ2D++
X-Gm-Message-State: AOJu0Ywfx06PZ9Df3Xo619+LHGJ2DaJkJGHxNfQBPz81I6SVTFjTX660
	feT4OCbrDE5ID3lhlT/DQNv9yg/7EDl3gAV5IhDLslkYU7IPIhum3wdr0XVLgrtUuMrasEh6V5q
	3IfXaJNB1cgQcq5l6kCW/ukljTeUp6wWEOSqj
X-Google-Smtp-Source: AGHT+IE18PXcU1Zk0HonLutuj4iXiCiY3rmdMI/HJHdA3NXYauV2mPvHIlo4wNvQLCqg/6HjtJ/weA7nVqy+dwfsn5k=
X-Received: by 2002:a25:8109:0:b0:dcd:3663:b5e5 with SMTP id
 3f1490d57ef6-dee4f2e38eemr984971276.25.1715299320168; Thu, 09 May 2024
 17:02:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000076ba3b0617f65cc8@google.com>
In-Reply-To: <00000000000076ba3b0617f65cc8@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 9 May 2024 20:01:49 -0400
Message-ID: <CAHC9VhSmbAY8gX=Mh2OT-dkQt+W3xaa9q9LVWkP9q8pnMh+E_w@mail.gmail.com>
Subject: Re: [syzbot] [lsm?] general protection fault in hook_inode_free_security
To: syzbot <syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com>
Cc: jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, mic@digikod.net, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 3:32=E2=80=AFPM syzbot
<syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    dccb07f2914c Merge tag 'for-6.9-rc7-tag' of git://git.ker=
n..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D14a4676098000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6d14c12b661fb=
43
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D5446fbf332b0602=
ede0b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/39d66018d8ad/dis=
k-dccb07f2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c160b651d1bc/vmlinu=
x-dccb07f2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3662a33ac713/b=
zImage-dccb07f2.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com
>
> general protection fault, probably for non-canonical address 0xdffffc018f=
62f515: 0000 [#1] PREEMPT SMP KASAN NOPTI
> KASAN: probably user-memory-access in range [0x0000000c7b17a8a8-0x0000000=
c7b17a8af]
> CPU: 1 PID: 5102 Comm: syz-executor.1 Not tainted 6.9.0-rc7-syzkaller-000=
12-gdccb07f2914c #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 04/02/2024
> RIP: 0010:hook_inode_free_security+0x5b/0xb0 security/landlock/fs.c:1047

Possibly a Landlock issue, Micka=C3=ABl?

> Code: 8a fd 48 8b 1b 48 c7 c0 c4 4e d5 8d 48 c1 e8 03 42 0f b6 04 30 84 c=
0 75 3e 48 63 05 33 59 65 09 48 01 c3 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00=
 74 08 48 89 df e8 66 be 8a fd 48 83 3b 00 75 0d e8
> RSP: 0018:ffffc9000307f9a8 EFLAGS: 00010212
> RAX: 000000018f62f515 RBX: 0000000c7b17a8a8 RCX: ffff888027668000
> RDX: 0000000000000000 RSI: 0000000000000040 RDI: ffff88805c0bb270
> RBP: ffffffff8c01fb00 R08: ffffffff82132a15 R09: 1ffff1100b81765f
> R10: dffffc0000000000 R11: ffffffff846ff540 R12: dffffc0000000000
> R13: 1ffff1100b817683 R14: dffffc0000000000 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f43c42de000 CR3: 00000000635f8000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  security_inode_free+0x4a/0xd0 security/security.c:1613
>  __destroy_inode+0x2d9/0x650 fs/inode.c:286
>  destroy_inode fs/inode.c:309 [inline]
>  evict+0x521/0x630 fs/inode.c:682
>  dispose_list fs/inode.c:700 [inline]
>  evict_inodes+0x5f9/0x690 fs/inode.c:750
>  generic_shutdown_super+0x9d/0x2d0 fs/super.c:626
>  kill_block_super+0x44/0x90 fs/super.c:1675
>  deactivate_locked_super+0xc6/0x130 fs/super.c:472
>  cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267
>  task_work_run+0x251/0x310 kernel/task_work.c:180
>  exit_task_work include/linux/task_work.h:38 [inline]
>  do_exit+0xa1b/0x27e0 kernel/exit.c:878
>  do_group_exit+0x207/0x2c0 kernel/exit.c:1027
>  __do_sys_exit_group kernel/exit.c:1038 [inline]
>  __se_sys_exit_group kernel/exit.c:1036 [inline]
>  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f731567dd69
> Code: Unable to access opcode bytes at 0x7f731567dd3f.
> RSP: 002b:00007fff4f0804d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 00007f73156c93a3 RCX: 00007f731567dd69
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000002 R08: 00007fff4f07e277 R09: 00007fff4f081790
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff4f081790
> R13: 00007f73156c937e R14: 00000000000154d0 R15: 000000000000001e
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---

--=20
paul-moore.com
