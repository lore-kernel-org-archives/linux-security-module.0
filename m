Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B84433D6
	for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2024 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727093208; cv=none; b=t4jAWHC/BuvLiJR3Zh+Umyig6LKWlAHEsLKybLdDQITMQHGd+WPgncEJaP8WpxrDFjFQBMU85NqiTiTsGfsbFigx9ERmnmZSapNPnvGugarZ7mddzEqSGAx1G0sn7+Bj2L22wQ+OtsJzjqKyIW1Qrga8L/hhqTLFHMU7HvN5kAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727093208; c=relaxed/simple;
	bh=BiBDj75ftrTq6rIR7utajjB2o0OXi1PY9PkosIUOwl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCTqVVRxGY4WXO9a2qMyZdVRBC9lwNuLjvPJcn1HuxQw7S5WLt8x+r4+srCox1VnpAFy3uaoqTPHTPcfI4NIiy1pI1yYzn0AKLmPAhp6LsWw+YT0FqtqbdfPNM58CNKtJvv7HkHtPDFAUfmb9NuRzOa07wBuT/rpfOUOiYLYqN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XcGQyxFt; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XcGQyxFt"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6dbb24ee34dso34925237b3.2
        for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2024 05:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727093203; x=1727698003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVb28Yan9WQ43phlTHlO+jwzz2IrQVXfDu6Uf/Zlxa8=;
        b=XcGQyxFtR2/DmJoimbC7e1JjPtT4lWRPKGtlIN+sWLzIlHMGpzD7XhKmb2ByqBKczV
         Zn4kLr4bD59VfX+6mcyDRdKh8kcirnLYzqCwbkT+OnexqcBzdrtpk09yKCD6rqLi6Euj
         GfWD10U4eHWbwKczKZ3JuTgycuKgy8j73pwCCbUuDCZ+TKIDMvuz6h5HmP3GtJlmoE3Z
         F4hWCUEvUfu+lDQUWzWo1G4oCRsb73leKZgJT/UapYpmphLpsUfhCo7SwKeRxtNK1mhZ
         ZqCDYFZDl3kyNqr6ktU0rG2U07AklSO3xl6aGOnfm7JAEHSW7SPAfIq6GDhVAitsfYpu
         b0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727093203; x=1727698003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVb28Yan9WQ43phlTHlO+jwzz2IrQVXfDu6Uf/Zlxa8=;
        b=l5EdOsUx1SyK8TJvrrfy4rgSESSpQCrluaRSa3Ps1CFtaJIOY+4lfL3MXYvYKqBOFF
         z9WWCSkBYP51aWTaqlPaD+UFt2TU8tmAjUf38J6HsGfQW8H20KsExceTmV6jO7EUz3Iy
         fVH5ZCaz9PVFuKD+YVWaKqXtWRZTSR9zpMFO/QcQlPTLIzzAPRKhmd1Sq6KFpjKeetU+
         NDqwKMxXwCHV8/0YJqLzkmdZ9rdODSNQzzQR1fatdHkNnBUbpc1FpuMlbLlUGnKdbYyh
         qPHb1RbmUNDfb/DpNDwEP57M7krYTVaodpuLWEYjxxqQswR47Nj7AIMTKHBUok8Xsyii
         QADQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+JXgcmuhGVX7yn5mPUntfM2tlmwL6PTwsh0AfbsQAuo7jznmdDgLdYrVZqEwqN3UxKQ/VUTbRGjISbi9J5S1eklVSeFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxunjACGufYnk1Xid3KxTwCecnXj84qkaPa1j4MdnQ6XU0Fbyrc
	7MSZE7nO3dqE/fiCuvDuh1Tg3DVy2ouLTUq83xmMbjtE8HZCxrcabwVnXKVI1NUhPyUnl7mHJEX
	4QMUmMbnx+wCHqx1tiLPBQjAroUhlmdKfCpJD0cGcYV+mjLjv8w==
X-Google-Smtp-Source: AGHT+IGAdcvYIbKWvhfObMEatJFBnx2+Y8M5iBaI0Laakv3POF8WW0ad5LoZadMXBDxzPM6Vsz4zceqV5RNgCawukhU=
X-Received: by 2002:a05:690c:85:b0:6db:4536:85b9 with SMTP id
 00721157ae682-6dfeed5edcdmr100310537b3.23.1727093202851; Mon, 23 Sep 2024
 05:06:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000a65b35061cffca61@google.com>
In-Reply-To: <000000000000a65b35061cffca61@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Sep 2024 08:06:31 -0400
Message-ID: <CAHC9VhTg3E2ECasYONNxNxp6RD_qayL+0DtPXojvsgBAb_3s1A@mail.gmail.com>
Subject: Re: [syzbot] [lsm?] WARNING in current_check_refer_path
To: syzbot <syzbot+34b68f850391452207df@syzkaller.appspotmail.com>
Cc: gnoack@google.com, jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, mic@digikod.net, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 5:53=E2=80=AFPM syzbot
<syzbot+34b68f850391452207df@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    8a03d70c27fc Merge remote-tracking branch 'tglx/devmsi-ar=
m..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux=
.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D174b0e6e98000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D15349546db652=
fd3
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D34b68f850391452=
207df
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D13cd1b69980=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12667fd198000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/efb354033e75/dis=
k-8a03d70c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c747c205d094/vmlinu=
x-8a03d70c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5641f4fb7265/I=
mage-8a03d70c.gz.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/4e4d1faacd=
ef/mount_0.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+34b68f850391452207df@syzkaller.appspotmail.com
>
> bcachefs (loop0): resume_logged_ops... done
> bcachefs (loop0): delete_dead_inodes... done
> bcachefs (loop0): done starting filesystem
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6284 at security/landlock/fs.c:971 current_check_ref=
er_path+0x4e0/0xaa8 security/landlock/fs.c:1132
> Modules linked in:
> CPU: 0 PID: 6284 Comm: syz-executor169 Not tainted 6.10.0-rc6-syzkaller-g=
8a03d70c27fc #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 06/07/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : current_check_refer_path+0x4e0/0xaa8 security/landlock/fs.c:1132
> lr : get_mode_access security/landlock/fs.c:953 [inline]
> lr : current_check_refer_path+0x4dc/0xaa8 security/landlock/fs.c:1132
> sp : ffff80009bb47840
> x29: ffff80009bb47980 x28: ffff80009bb478e0 x27: 0000000000000001
> x26: 1fffe0001b7a831f x25: ffff0000d713ef00 x24: ffff700013768f14
> x23: 000000000000f1ed x22: dfff800000000000 x21: ffff0000dbd418f8
> x20: 0000000000000000 x19: 0000000000001fff x18: ffff80009bb46be0
> x17: ffff800080b8363c x16: ffff80008afaca80 x15: 0000000000000004
> x14: 1ffff00013768f24 x13: 0000000000000000 x12: 0000000000000000
> x11: ffff700013768f28 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d6845ac0 x7 : 0000000000000000 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000020
> x2 : 0000000000000000 x1 : 000000000000f1ed x0 : 000000000000d000
> Call trace:
>  current_check_refer_path+0x4e0/0xaa8 security/landlock/fs.c:1132
>  hook_path_rename+0x4c/0x60 security/landlock/fs.c:1416
>  security_path_rename+0x154/0x1f0 security/security.c:1918
>  do_renameat2+0x724/0xe40 fs/namei.c:5031
>  __do_sys_renameat2 fs/namei.c:5078 [inline]
>  __se_sys_renameat2 fs/namei.c:5075 [inline]
>  __arm64_sys_renameat2+0xe0/0xfc fs/namei.c:5075
>  __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:131
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:150
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
> irq event stamp: 67226
> hardirqs last  enabled at (67225): [<ffff80008b1683b4>] __raw_spin_unlock=
_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
> hardirqs last  enabled at (67225): [<ffff80008b1683b4>] _raw_spin_unlock_=
irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
> hardirqs last disabled at (67226): [<ffff80008b06e498>] el1_dbg+0x24/0x80=
 arch/arm64/kernel/entry-common.c:470
> softirqs last  enabled at (66914): [<ffff8000800307e0>] local_bh_enable+0=
x10/0x34 include/linux/bottom_half.h:32
> softirqs last disabled at (66912): [<ffff8000800307ac>] local_bh_disable+=
0x10/0x34 include/linux/bottom_half.h:19
> ---[ end trace 0000000000000000 ]---
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

Based on the rest of the discussion with the bcachefs/xfs devs, moving
this to bcachefs since it still appears to be an open issue (at least
to syzkaller).

 #syz set subsystems: bcachefs

--=20
paul-moore.com
