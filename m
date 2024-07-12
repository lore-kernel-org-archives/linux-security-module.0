Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE86C172BAE
	for <linux-security-module@vger.kernel.org>; Fri, 12 Jul 2024 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720796125; cv=none; b=pPKB6q6Nbm2DnZ6OzhVZivKgXuTqzBr0iWN54A3IbjjFd1VpOxHKOWSvu1SwvQ0Pg3P9TfjuKUnV7Jo/eWLNCkX+BHd4lHrfOqFJ3gQNVu6z3eprKEcZFvk6W14U1yB0vUsorrMVyIgac/nsuH4KlLqRaHkeaLuI6vrmUd1t7Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720796125; c=relaxed/simple;
	bh=73F18xIA3vDI+ZmMawEj1EVW+eDWAP9vK2MCOHI734E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NC3uZwTLlqKj/zV+n2NsFFz7VeF9KoSY7rgiBq0cDEM8os/lZylaj3Hcf5TUSDUEooPnT1+LakFvNlQdmQREa59rKjCxPw8w/INse/1cz9sh0+G6CZY/JYFoxnkPZfv+Id/rAwYyX2VIrBxTeZ2EwMFV+PKjcJ4h7M2CN0xTJmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EuwfydU0; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EuwfydU0"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-65ecc02c606so3740407b3.1
        for <linux-security-module@vger.kernel.org>; Fri, 12 Jul 2024 07:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720796123; x=1721400923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+w0ThLzwl4n5JC8vmDZjECC7gppb/LdI/W8aReQd8fE=;
        b=EuwfydU0qQx2EH5nFQG0ClX9oBPsLIUMgs8dfYfSmCkmPlFa3WmweA7nF+eYOFte1g
         GQ0pX/d2DHUSiTAHPYkqZRucY6l8wR1UqL1Ojz2xrd02Fbq4bP+JKVxu0OsTbmUBE3VQ
         aGhfbbTR3Z8HqWxYr7yAWF3yvSoXRDB+iy8Dnhp/M+lI0e33i7dWsIrF9XFzgC/Rv4E8
         p+riLr08VQCNE7z2gkXb3/xOzpO4lueGsjYKj/Y2q5DF0ijr5KTXAnGSQDJGJCV0nXBJ
         rgn+gAM8mPjloMoFzE6fCttDmkigijYmeTaipJye6PEtxfOyY8AXi216+xnwoyqFJqtO
         OT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720796123; x=1721400923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+w0ThLzwl4n5JC8vmDZjECC7gppb/LdI/W8aReQd8fE=;
        b=MX8mWnmqX74RRhHv22ogKPO3R9YuvpjGzlkCUf9lNmkT9IG52Y3RtCfibvn+WVug5I
         ojaLHhTJ64yhuubez1CkRGxsxUoHqWwGts1Jb5V5UxZybEwzPzOsGh3BX6TOS4F8A9dX
         lRNUXjF+Hibs42Ga4woFRPRsNfD82UbqT3/t4NvMWpduitmOQQjoRohsRY2jkKHG6nlP
         IZ8mIuls+ylgdADodkVJJkyZRNQQj3u2UfYEA1MLaId9H6jzKBf8F2TRdYFrg+9jRN0o
         HcLCL4DAU3rwax4jGATBTe/2GKmsJXyoH5qOJFnnS4Bs+ZEdK+3nV6yXWVb6RGU4TKFu
         SOxg==
X-Forwarded-Encrypted: i=1; AJvYcCVg+9ZQm7LtjSdNGGM4O2S/GFMMJEcz8elcDHiz7i8vtiHxelOZGIM9qoIldQt40cJzoaDtKjhsYJNbJDBTfb+DTqQ6/PW6PNVO8FjPngNbijfm8626
X-Gm-Message-State: AOJu0Yw53in8M+42VMFGVH6gPALMkv7OGQwZsDGZl5Iwq2VwrhGIV52n
	LAWV1ikbVIXXJS9Clx+8r+2G+2bpSOzHAApXnBLLgTmicwAeWat47ZUL9Wwolj0slhCsIwCLXf7
	vfruSnV2qY+XTrqKsxPW2xrWADeY0lhcdrQH+GIzV1PAcEJAUjA==
X-Google-Smtp-Source: AGHT+IGtTJfKjxJFBMAT3WhbKFh9iKNbitKZrRcvtSjKO3EbB6yzB+X89ynWybhr/PmImBWmBCV15sArfXJOZr1B98k=
X-Received: by 2002:a05:690c:30f:b0:64b:b7e:3313 with SMTP id
 00721157ae682-65dfd56ddf2mr26316757b3.13.1720796122674; Fri, 12 Jul 2024
 07:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000a65b35061cffca61@google.com>
In-Reply-To: <000000000000a65b35061cffca61@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 12 Jul 2024 10:55:11 -0400
Message-ID: <CAHC9VhT_XpUeaxtkz0+4+YbWgK6=NDeDQikmPVYZ=RXDt+NOgw@mail.gmail.com>
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

I'll let Micka=C3=ABl answer this for certain, but based on a quick look it
appears that the fs object being moved has a umode_t that Landlock is
not setup to handle?

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

--=20
paul-moore.com
