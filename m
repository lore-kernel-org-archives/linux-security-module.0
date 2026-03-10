Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361F43AC0E8
	for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773147608; cv=none; b=okb8nIJxM8hrMO4WXZSStk+fAt2VtIZaP4SIW+q/KlXBzUQ4BczloaJWJQDgxW4W78rmoQVyp/sqykCWEu88s4bI/3QSBuClaxha8L3E9hwCiYbQy/xN7abSenlTfdB45R+7/3z8DWDPCh4m3v4qBnaSbOlZVcCIV6+n0wc8vOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773147608; c=relaxed/simple;
	bh=3Zd9egazAreKVbw3CgBV1Ekque51lAHc6BdIaLDdWR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWxO8Ak3gpiNlBCNP2SIfo6qYKNC/C6UQb9SGbIH/kL3s+T7EBKjYY77upDdpsXqKdekDJ//0nWhI8pv52YXIPSC9J0XQ9E5gom7KgjcVEUuu+azumkf/Teea9LTJMGlRU5VyDj+fTLc30ihJcYwoiY/AkRTBwb1l/m7PYsSxyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dzzvztif; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dzzvztif"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48538c5956bso23949675e9.0
        for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 06:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773147606; x=1773752406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W/9QICG0i6N0qMKANYrMNVd6a11sIuDIs7effYlII2s=;
        b=dzzvztifKsYt1LzidFrfOwVN4Xw4Cz0ah54SZfXZgDzaId/8wQ2AP05YYcABDIDctI
         c421aU4GUIdG9Spt9ax/KKdQnkD5kgXr4M3hrTbuq+nEX0yzmUWNcuGna3xs2nODmWXT
         LTe892Y7Tt9S+wahCXLye+n6AtVlH5YZ9crYqg2sEJLuorrwPYd6Mn946qkZ8QRq5BLV
         VwQefk5zBySdKfeakvxZzBJbd5u3DQA6PGY/s2cywsgAvSVOsOH36xpxNvaKC+2Qpiry
         KgAlFsGe8v47GYf6EYo6BT3HFccZYywEwBK/ONUb3vRhmYEk/VmLYSw/KoA6lp3iOxTY
         2fNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773147606; x=1773752406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/9QICG0i6N0qMKANYrMNVd6a11sIuDIs7effYlII2s=;
        b=G4VTCqXf4DEHikuJDi5MyOwidaM7W++V9T78uiyBPfh+UaehYqQWx9slXCE2MXvm3t
         k1TTJVikbYZOih6aFmhosr7dTmij8Wx/1PBSwsomfwqqFhLBTPHpp64ZClUZuvI7+tmo
         In+84MQdL3xQ0UckDFxPO8ftVaAwKluwFt5Cu4tKACqsVEfmaNearYFfsPFb7Lj4q/hk
         dyxZG1fw8FAeArxkOYnrTnk41X/PDUi1OHSFQarVB2gn4mMS1ZydAEabiPT/GI4a4rwD
         Nq/sNxXvK2/Jvf9q4l6z9sQMNX8gTTyPsLnJOy+eamYTzff+ANTTRX9+2NpSfgzBKZE/
         7I9w==
X-Forwarded-Encrypted: i=1; AJvYcCXHEl6j8pbLXgzvgDEqoyEgitqrTMNBBPb5vMOMs8sNsd822F9A4vI7b8U0hkc4sLujuzIfcYGFLE1ZYcfiBjC+e6r5HNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6TjnNuM7+9yzBdm7ZU3LG2Yq7J33PENFuEKb0orkpExYzUd+8
	jhOle8xLTJ3uuTeGjC54JOgL64zrd588Q0TDupVHmjkksQy6CwpTzm4jQQKjHFDoSg==
X-Gm-Gg: ATEYQzyV3pWmc+ae5RlHsjDb3BMcQHdeHzzX/xbO0/zHr82J22CbPQsdaO+a89LHAyt
	ydIYulpbsCC3/cwCL2J1qvIrdTbxJmfKA64ULbzOJIJdi/OM+cQd3dMTfwDT6hw/78jjMx/jXp/
	lzahWirAxlaGDAV0a8hQwd7ZVjf0u7Lh332VY1AYsGKVO+8vbAYnLmo2fCfTyNHEw/HHdypBFtJ
	EnU1xhKVcdiQRhUyYw+Hx10XVtkdHRzzXy0qU9nfq7vX0dCGAFALy+Zfee3aU8HUTsdwccH8Dl2
	aT5ok5oNfQDSUByUGVB7ES/fANcSQIpACdKuayhHfL4r+ZPxutOB1r4yBiiSkWguFaDPebonjwF
	SM0kRDBQ3M2HzLPkS6I/zLXxBcsVnY+7D9rskCTkhiUI3xUrTY+kHp29NpIPdayGV1qSoCh4IiR
	Tcmv5ENTr4sbqhlmObKV2w41MsB5J9VfQMFq/dXm5ASe+nL+yho7CfZg==
X-Received: by 2002:a05:600c:138e:b0:485:3e00:944a with SMTP id 5b1f17b1804b1-485419d759amr56148725e9.9.1773147604978;
        Tue, 10 Mar 2026 06:00:04 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:43dd:a0ed:65ba:bc74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541a6bc3bsm82523515e9.2.2026.03.10.06.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 06:00:04 -0700 (PDT)
Date: Tue, 10 Mar 2026 13:59:59 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: syzbot <syzbot+741e2278ef71fef03a10@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, mic@digikod.net,
	miklos@szeredi.hu, penguin-kernel@i-love.sakura.ne.jp,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fuse?] general protection fault in task_work_cancel
Message-ID: <abAVz4YsnCkGT2_H@google.com>
References: <69abb4e3.050a0220.13f275.003d.GAE@google.com>
 <69acf111.050a0220.310d8.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69acf111.050a0220.310d8.0003.GAE@google.com>

On Sat, Mar 07, 2026 at 07:46:25PM -0800, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    4ae12d8bd9a8 Merge tag 'kbuild-fixes-7.0-2' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17dc475a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=779072223d02a312
> dashboard link: https://syzkaller.appspot.com/bug?extid=741e2278ef71fef03a10
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130b075a580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/010ac4052aed/disk-4ae12d8b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2aad8bef9031/vmlinux-4ae12d8b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/fd350ec4896a/bzImage-4ae12d8b.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+741e2278ef71fef03a10@syzkaller.appspotmail.com
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc000000013c: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x00000000000009e0-0x00000000000009e7]
> CPU: 1 UID: 0 PID: 13249 Comm: syz.1.1775 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
> RIP: 0010:task_work_pending include/linux/task_work.h:26 [inline]
> RIP: 0010:task_work_cancel_match kernel/task_work.c:124 [inline]
> RIP: 0010:task_work_cancel+0x8a/0x220 kernel/task_work.c:187
> Code: b8 f1 f1 f1 f1 f8 f3 f3 f3 4b 89 44 25 00 e8 ad b9 35 00 43 c6 44 25 04 00 49 89 de 48 81 c3 e0 09 00 00 49 89 df 49 c1 ef 03 <43> 80 3c 27 00 74 08 48 89 df e8 17 fe 9f 00 48 83 3b 00 75 51 e8
> RSP: 0018:ffffc9000ddffb20 EFLAGS: 00010216
> RAX: ffffffff818fdfc3 RBX: 00000000000009e0 RCX: ffff88805d5c3d00
> RDX: 0000000000000000 RSI: ffff888032f5c540 RDI: 0000000000000000
> RBP: ffffc9000ddffbd0 R08: ffffc9000ddffc97 R09: 1ffff92001bbff92
> R10: dffffc0000000000 R11: fffff52001bbff93 R12: dffffc0000000000
> R13: 1ffff92001bbff68 R14: 0000000000000000 R15: 000000000000013c
> FS:  00007f9c8a1cb6c0(0000) GS:ffff888125561000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000010000 CR3: 0000000059bf0000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  cancel_tsync_works security/landlock/tsync.c:415 [inline]
>  landlock_restrict_sibling_threads+0xdc4/0x11f0 security/landlock/tsync.c:533
>  __do_sys_landlock_restrict_self security/landlock/syscalls.c:574 [inline]
>  __se_sys_landlock_restrict_self+0x540/0x810 security/landlock/syscalls.c:482
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f9c8939c799
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f9c8a1cb028 EFLAGS: 00000246 ORIG_RAX: 00000000000001be
> RAX: ffffffffffffffda RBX: 00007f9c89616180 RCX: 00007f9c8939c799
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000003
> RBP: 00007f9c89432bd9 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f9c89616218 R14: 00007f9c89616180 R15: 00007ffee5d65d48
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:task_work_pending include/linux/task_work.h:26 [inline]
> RIP: 0010:task_work_cancel_match kernel/task_work.c:124 [inline]
> RIP: 0010:task_work_cancel+0x8a/0x220 kernel/task_work.c:187
> Code: b8 f1 f1 f1 f1 f8 f3 f3 f3 4b 89 44 25 00 e8 ad b9 35 00 43 c6 44 25 04 00 49 89 de 48 81 c3 e0 09 00 00 49 89 df 49 c1 ef 03 <43> 80 3c 27 00 74 08 48 89 df e8 17 fe 9f 00 48 83 3b 00 75 51 e8
> RSP: 0018:ffffc9000ddffb20 EFLAGS: 00010216
> RAX: ffffffff818fdfc3 RBX: 00000000000009e0 RCX: ffff88805d5c3d00
> RDX: 0000000000000000 RSI: ffff888032f5c540 RDI: 0000000000000000
> RBP: ffffc9000ddffbd0 R08: ffffc9000ddffc97 R09: 1ffff92001bbff92
> R10: dffffc0000000000 R11: fffff52001bbff93 R12: dffffc0000000000
> R13: 1ffff92001bbff68 R14: 0000000000000000 R15: 000000000000013c
> FS:  00007f9c8a1cb6c0(0000) GS:ffff888125561000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f810d34da08 CR3: 0000000059bf0000 CR4: 0000000000350ef0
> ----------------
> Code disassembly (best guess):
>    0:	b8 f1 f1 f1 f1       	mov    $0xf1f1f1f1,%eax
>    5:	f8                   	clc
>    6:	f3 f3 f3 4b 89 44 25 	repz repz xrelease mov %rax,0x0(%r13,%r12,1)
>    d:	00
>    e:	e8 ad b9 35 00       	call   0x35b9c0
>   13:	43 c6 44 25 04 00    	movb   $0x0,0x4(%r13,%r12,1)
>   19:	49 89 de             	mov    %rbx,%r14
>   1c:	48 81 c3 e0 09 00 00 	add    $0x9e0,%rbx
>   23:	49 89 df             	mov    %rbx,%r15
>   26:	49 c1 ef 03          	shr    $0x3,%r15
> * 2a:	43 80 3c 27 00       	cmpb   $0x0,(%r15,%r12,1) <-- trapping instruction
>   2f:	74 08                	je     0x39
>   31:	48 89 df             	mov    %rbx,%rdi
>   34:	e8 17 fe 9f 00       	call   0x9ffe50
>   39:	48 83 3b 00          	cmpq   $0x0,(%rbx)
>   3d:	75 51                	jne    0x90
>   3f:	e8                   	.byte 0xe8
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz fix: landlock: Fully release unused TSYNC work entries

(See https://github.com/google/syzkaller/blob/master/docs/syzbot.md#communication-with-syzbot)
