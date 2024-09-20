Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D1E1442F4
	for <linux-security-module@vger.kernel.org>; Fri, 20 Sep 2024 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726851525; cv=none; b=R3SzFzNi/d/sDjFVBbjaIqSOLc6Puf9mo51bifQgbigrHUoyMqK4sjrqCG7NULXmG94DuyRWv4MSQ49X3W9/3Ybom9EJjE49ZA0dNkfMqpkiGQo69OQUpkDG5GAaCus1PgoExo3G4FuBJOmO1aD0X/rdwo0I9zE2bFtQl4xvT5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726851525; c=relaxed/simple;
	bh=GkyOJ/OlUlu/timXxU6QtBE6s88mkLrJPU+vCWjLrOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTN0UF4s6YOmzPrcdQFL97EqS6FO9jk7NZ9ZP6Qr4d2UkgxsDvjnrofKDsP+YVyu5RPv5eF6ma4URdZfEzS9PXUdID3ph/ZOBbyR8BpKMdpvoj3Vrs19IYs5y8qIgFsiBwfzcfuZZ/1eUAhodvY8ErCeeMFz9JnTVkI+oJFyuqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MfOhFd0d; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MfOhFd0d"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ddcd0b4c59so21757517b3.3
        for <linux-security-module@vger.kernel.org>; Fri, 20 Sep 2024 09:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726851522; x=1727456322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yuengg8SKuG258v3/BqxPdn3H/VM/Idwmrn82JID4+E=;
        b=MfOhFd0d1bv0ib7LefljJYDljD10bUcDMMfllfrvOKK3hVJaXhlCSoqt6+GXa++idx
         xtn6dLnDZ3bpS8q1MjHgTogGcwe7wEVDIPEAquZ/JuLB5xBa0rhSd5eDY6iTbFaG9A4K
         xhXGF0uk8YX5SRM3HEtPQh/gaqjHMoBeYgIE/vCRakncCCumKj9dFuONkmNW+5JX6Ui3
         HZ6+71uhmRAd5CLH/bN2SFd8fOjNlU/8c64o4oWHJXcbPgt33v8Qivu3tWOMX6oqqaBo
         2zenAWMhkBytlTo96yH30orYdtBUcssKXtE3Kq8tajsgt/I7l0p+2UEuZHyZIfobgrcs
         QzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726851522; x=1727456322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yuengg8SKuG258v3/BqxPdn3H/VM/Idwmrn82JID4+E=;
        b=J1gvkjjo9W58NxwfSepGfKinV3jl7gp7jImpp0cMN7KJsDQnhwlYva3cWM7CtLWFS4
         27VEdEDX2n3Lplnm2rlx4OaXt8VjUx6BbZCKWs5lBbnF0yUiSljHn5+MnuGKs7wrLQXP
         kmyit8CZ2uPi2Xinn6cX9l5+7AhC/LlhjHBXO7a4i2UhJWEBFBQb7WkTlnc/QEnr6mlO
         +bvKza63oitEhIC0xi4zgl+JdJYpjhmnk68Oyu9Sqj28phJZRsBidGzXaAQatjhUeovW
         Efy5Qln/3dLdf83N2B2AnJPogyiTUYV0K/a9qgW2kMbecoCQCeQPg4PntDtSJEspCBMg
         d6Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWhmYcpjzkt62zjPtupwBO2uVMWMTTU1fWK4Rvr4+8sxv3+WJ92qsvpE7JcAXCe8sf3oN9aWA5EdUxk/AhI7CHfY+irfNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YznZgVCoyK3IeGzzXroQttSPZpIR7htwlxHoH6YvgfUJh0svpYF
	ROuhUGrrwocSUTxr3QlO7wQa4gOxMZJy6H4LofZC86qndpTrxexeidYDIvo+CczSc86igvjDBHB
	WAplYOGwbZGuMtqqYMNd/XX744UsRto41z6f9
X-Google-Smtp-Source: AGHT+IHdzpdMp4IjA99SMzli7V3Y5kLR6/exTEKpjjTukuZMinUsN29sqVguIdeLyOh/J2LJfnpTD8XwjYFIstv3Xpo=
X-Received: by 2002:a05:690c:67c5:b0:6d5:90f:d497 with SMTP id
 00721157ae682-6dfeed8a6a2mr36754917b3.19.1726851522519; Fri, 20 Sep 2024
 09:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66ed837a.050a0220.29194.0057.GAE@google.com>
In-Reply-To: <66ed837a.050a0220.29194.0057.GAE@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 20 Sep 2024 12:58:31 -0400
Message-ID: <CAHC9VhQF743KeHEULgA1hqq9OM3ttMmyhwFdavJLpgHT9j7uGw@mail.gmail.com>
Subject: Re: [syzbot] [lsm?] KASAN: slab-use-after-free Read in smk_access
To: syzbot <syzbot+a95cf48b5daf4bb16c29@syzkaller.appspotmail.com>
Cc: casey@schaufler-ca.com, jmorris@namei.org, john.johansen@canonical.com, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 10:15=E2=80=AFAM syzbot
<syzbot+a95cf48b5daf4bb16c29@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    a430d95c5efa Merge tag 'lsm-pr-20240911' of git://git.ker=
n..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D10469d0058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd9ab5893ec519=
1eb
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Da95cf48b5daf4bb=
16c29
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D110e6a77980=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10cee20798000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c27c9d8c6782/dis=
k-a430d95c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/73c62c975a0c/vmlinu=
x-a430d95c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/56164e51e333/b=
zImage-a430d95c.xz
>
> The issue was bisected to:
>
> commit 5f8d28f6d7d568dbbc8c5bce94894474c07afd4f
> Author: Casey Schaufler <casey@schaufler-ca.com>
> Date:   Wed Jul 10 21:32:26 2024 +0000
>
>     lsm: infrastructure management of the key security blob
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D10293fc798=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D12293fc798=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D14293fc798000=
0
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+a95cf48b5daf4bb16c29@syzkaller.appspotmail.com
> Fixes: 5f8d28f6d7d5 ("lsm: infrastructure management of the key security =
blob")
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-out-of-bounds in smk_access+0xae/0x4e0 security/smack/sm=
ack_access.c:147
> Read of size 8 at addr ffff8880202b03c0 by task syz-executor367/5216
>
> CPU: 0 UID: 60928 PID: 5216 Comm: syz-executor367 Not tainted 6.11.0-syzk=
aller-02574-ga430d95c5efa #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/06/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:93 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  smk_access+0xae/0x4e0 security/smack/smack_access.c:147
>  smack_watch_key+0x2f4/0x3a0 security/smack/smack_lsm.c:4656
>  security_watch_key+0x86/0x250 security/security.c:4448
>  keyctl_watch_key+0x2b7/0x480 security/keys/keyctl.c:1813
>  __do_sys_keyctl security/keys/keyctl.c:2021 [inline]
>  __se_sys_keyctl+0x106/0xa50 security/keys/keyctl.c:1874
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fbebbbc2fe9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 1d 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fbebbb74238 EFLAGS: 00000246 ORIG_RAX: 00000000000000fa
> RAX: ffffffffffffffda RBX: 00007fbebbc463e8 RCX: 00007fbebbbc2fe9
> RDX: 0000000000000004 RSI: 0000000016bf1cf5 RDI: 0000000000000020
> RBP: 00007fbebbc463e0 R08: 0000000000000000 R09: 00007fbebbb746c0
> R10: 0000000000000000 R11: 0000000000000246 R12: 00676e697279656b
> R13: 0000000000000002 R14: 00007ffe798160c0 R15: 00007ffe798161a8
>  </TASK>

...

> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report

#syz dup: [syzbot] [audit?] general protection fault in smack_log_callback

--=20
paul-moore.com
