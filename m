Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F5D25A623;
	Sat, 25 Jan 2025 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737797824; cv=none; b=C5mVMCsmsSi3oDQHwCTN8LZzUYH3vP/c2gQYnC0fUBZkGPLOOBweSztrNcddArCtPq7Y8HF5xpOVl+G4df8FoPqn+uGfNVddeU2B1Giu+f6yjvtjdGx6bbvJEZbp4l1hByIkU70xvYJn6Jixb/umVFeIKF4VqW76d+MOnBiDQuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737797824; c=relaxed/simple;
	bh=eTm57ZrO1hzp9DvmP2+O/Txp632cr4WMEZG1xcC02BY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVvqF3GImgON2ViXuJFeBj6hdP/TgeuoC07DihAYsmKBROVOR0tR37fgDJ6MjvHhGn/cohwmuY/ierHkCeLWHaH49oVOS5m2n2mF4kDz5gCRDiRKlH1jqGNpLKG3Ak/pknTErQ4PHdEIBfjgAp93u0h9fwCkCIcijsdmnc50adI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PC8W5GDy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PC8W5GDy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3BBC4CEE2;
	Sat, 25 Jan 2025 09:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737797823;
	bh=eTm57ZrO1hzp9DvmP2+O/Txp632cr4WMEZG1xcC02BY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PC8W5GDywMZ+87gT1/iss9zD+xm9ppxpSbvYkWGNKqQDrcAbIZmwi+7O5+tD4d4/N
	 hKLfm000n4oZ0svZGzK8gqcMFDG6mySno+rhDcND0JdJTjLuLuUDZgTQUsIqZe6CPH
	 EXjuUXkdX/0v+WTJ9V6SqCF0aUQ5VWg4Z2NJqZkurHQKdahcravlGIzu0tzVEmJNHG
	 U6cMlxC9ZiaOeVle4GWhWSdeo2j9PYxFfcxdS/q47DE/q6erJZd4dqQ5byCXkgkmcj
	 cEWlXubSY//zPAD8uwR22l9hFLjUKEVjwu9eF5U5hbydH7WmQzMmColemPfjWFvX3n
	 lpnKtCw13P8uQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3bdccba49so5254951a12.1;
        Sat, 25 Jan 2025 01:37:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVFvaGj6YN0duMC7YA0SwDIQs+Pc0yt4ZRekFn8NS6TypqwyhMrITGLlMCY+bYZR5PuxrSiq+cjybzI3nGJ@vger.kernel.org, AJvYcCVvmkKzffQYGhqhbCtiTkoLU9IRMefMHthXSWh13KO5PR0Z49e1gnGlhqebBMFn+6MN+bLqjw==@vger.kernel.org, AJvYcCWHd89rHAxnGf/ufzuuKMW3vNT44xBDLKjTOQDubB/iLV9bBaaxKm5o71ZsVvTEvSJ+vKWUnAJ4/ktrE+o8wBauh0pqv9Cu@vger.kernel.org
X-Gm-Message-State: AOJu0YwfONNGTwqJQLRpTlR26w1Z6sCBDQxM4WpsY8aFgcqYTCvcYXKI
	ABGbILLzSzI4cO13Gur2R/ZgKHeRFr6UoyRi+T6zdxaGdBgDBP/E9cwCeDTOuTx1W25AWgZWxLC
	ikO8GzN4DlKWd2cucACey1o79H+E=
X-Google-Smtp-Source: AGHT+IFsSC0NJ1t7XMhe3ppWYUnc811yUhs/NxwU767cwnO2CyqenTGxR6P1gpZqsvAQ8Gtv0xvhLQW3E2TUpqHEsXM=
X-Received: by 2002:a05:6402:51d3:b0:5d1:22c2:6c56 with SMTP id
 4fb4d7f45d1cf-5db7d318a90mr29314394a12.17.1737797821809; Sat, 25 Jan 2025
 01:37:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124091209.4013832-1-chenhuacai@loongson.cn> <CAHC9VhTZAMrGhNxHS52ua2g-sX_Q=qtmqZ1QgLXLyu2wufY81A@mail.gmail.com>
In-Reply-To: <CAHC9VhTZAMrGhNxHS52ua2g-sX_Q=qtmqZ1QgLXLyu2wufY81A@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 25 Jan 2025 17:36:54 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6KaxgoQZU8YghR1qOF7DocoV2r5R8joWibvj-dJZAw=Q@mail.gmail.com>
X-Gm-Features: AWEUYZmg74S1_oazp_ka-wN_vzC11Hqbxbx-7HSwZYqFckhnShi1omi7RjsdhDU
Message-ID: <CAAhV-H6KaxgoQZU8YghR1qOF7DocoV2r5R8joWibvj-dJZAw=Q@mail.gmail.com>
Subject: Re: [PATCH] audit: Initialize lsmctx to avoid memory allocation error
To: Paul Moore <paul@paul-moore.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Eric Paris <eparis@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Paul,

On Sat, Jan 25, 2025 at 1:01=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Jan 24, 2025 at 4:12=E2=80=AFAM Huacai Chen <chenhuacai@loongson.=
cn> wrote:
> >
> > Initialize the local variable lsmctx in audit_receive_msg(), so as to
> > avoid memory allocation errors like:
> >
> > [  258.074914] WARNING: CPU: 2 PID: 443 at mm/page_alloc.c:4727 __alloc=
_pages_noprof+0x4c8/0x1040
> > [  258.074994] Hardware name: Loongson Loongson-3A5000-7A1000-1w-CRB/Lo=
ongson-LS3A5000-7A1000-1w-CRB, BIOS vUDK2018-LoongArch-V2.0.0-prebeta9 10/2=
1/2022
> > [  258.074997] pc 900000000304d588 ra 9000000003059644 tp 9000000107774=
000 sp 9000000107777890
> > [  258.075000] a0 0000000000040cc0 a1 0000000000000012 a2 0000000000000=
000 a3 0000000000000000
> > [  258.075003] a4 9000000107777bd0 a5 0000000000000280 a6 0000000000000=
010 a7 0000000000000000
> > [  258.075006] t0 9000000004b4c000 t1 0000000000000001 t2 1f3f37829c264=
c80 t3 000000000000002e
> > [  258.075009] t4 0000000000000000 t5 00000000000003f6 t6 90000001066b6=
310 t7 000000000000002f
> > [  258.075011] t8 000000000000003c u0 00000000000000b4 s9 900000010006f=
880 s0 9000000004a4b000
> > [  258.075014] s1 0000000000000000 s2 9000000004a4b000 s3 9000000106673=
400 s4 9000000107777af0
> > [  258.075017] s5 90000001066b6300 s6 0000000000000012 s7 fffffffffffff=
000 s8 0000000000000004
> > [  258.075019]    ra: 9000000003059644 ___kmalloc_large_node+0x84/0x1e0
> > [  258.075026]   ERA: 900000000304d588 __alloc_pages_noprof+0x4c8/0x104=
0
> > [  258.075030]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DCC -W=
E)
> > [  258.075040]  PRMD: 00000004 (PPLV0 +PIE -PWE)
> > [  258.075045]  EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
> > [  258.075051]  ECFG: 00071c1d (LIE=3D0,2-4,10-12 VS=3D7)
> > [  258.075056] ESTAT: 000c0000 [BRK] (IS=3D ECode=3D12 EsubCode=3D0)
> > [  258.075061]  PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
> > [  258.075064] CPU: 2 UID: 0 PID: 443 Comm: auditd Not tainted 6.13.0-r=
c1+ #1899
> > [  258.075068] Hardware name: Loongson Loongson-3A5000-7A1000-1w-CRB/Lo=
ongson-LS3A5000-7A1000-1w-CRB, BIOS vUDK2018-LoongArch-V2.0.0-prebeta9 10/2=
1/2022
> > [  258.075070] Stack : ffffffffffffffff 0000000000000000 9000000002debf=
5c 9000000107774000
> > [  258.075077]         90000001077774f0 0000000000000000 90000001077774=
f8 900000000489e480
> > [  258.075083]         9000000004b380e8 9000000004b380e0 90000001077773=
80 0000000000000001
> > [  258.075089]         0000000000000001 9000000004a4b000 1f3f37829c264c=
80 90000001001a9b40
> > [  258.075094]         9000000107774000 9000000004b080e8 00000000000003=
d4 9000000004b080e8
> > [  258.075100]         9000000004a580e8 000000000000002d 0000000006ebc0=
00 900000010006f880
> > [  258.075106]         00000000000000b4 0000000000000000 00000000000000=
04 0000000000001277
> > [  258.075112]         900000000489e480 90000001066b6300 00000000000000=
12 fffffffffffff000
> > [  258.075118]         0000000000000004 900000000489e480 9000000002def6=
a8 00007ffff2ba4065
> > [  258.075124]         00000000000000b0 0000000000000004 00000000000000=
00 0000000000071c1d
> > [  258.075129]         ...
> > [  258.075132] Call Trace:
> > [  258.075135] [<9000000002def6a8>] show_stack+0x30/0x148
> > [  258.075146] [<9000000002debf58>] dump_stack_lvl+0x68/0xa0
> > [  258.075152] [<9000000002e0fe18>] __warn+0x80/0x108
> > [  258.075158] [<900000000407486c>] report_bug+0x154/0x268
> > [  258.075163] [<90000000040ad468>] do_bp+0x2a8/0x320
> > [  258.075172] [<9000000002dedda0>] handle_bp+0x120/0x1c0
> > [  258.075178] [<900000000304d588>] __alloc_pages_noprof+0x4c8/0x1040
> > [  258.075183] [<9000000003059640>] ___kmalloc_large_node+0x80/0x1e0
> > [  258.075187] [<9000000003061504>] __kmalloc_noprof+0x2c4/0x380
> > [  258.075192] [<9000000002f0f7ac>] audit_receive_msg+0x764/0x1530
> > [  258.075199] [<9000000002f1065c>] audit_receive+0xe4/0x1c0
> > [  258.075204] [<9000000003e5abe8>] netlink_unicast+0x340/0x450
> > [  258.075211] [<9000000003e5ae9c>] netlink_sendmsg+0x1a4/0x4a0
> > [  258.075216] [<9000000003d9ffd0>] __sock_sendmsg+0x48/0x58
> > [  258.075222] [<9000000003da32f0>] __sys_sendto+0x100/0x170
> > [  258.075226] [<9000000003da3374>] sys_sendto+0x14/0x28
> > [  258.075229] [<90000000040ad574>] do_syscall+0x94/0x138
> > [  258.075233] [<9000000002ded318>] handle_syscall+0xb8/0x158
> > [  258.075239]
> > [  258.075241] ---[ end trace 0000000000000000 ]---
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 6fba89813ccf333d ("lsm: ensure the correct LSM context releaser"=
)
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  kernel/audit.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> [NOTE: dropping the stable mailing list and adding the LSM list]
OK, will do.

>
> Thanks for the problem report.
>
> First a bit of metadata feedback: the stable tagging isn't necessary
> as the commit this patch claims to fix was first introduced during the
> current merge window just a few days ago; as long as we fix this in
> Linus' tree before v6.14 is release a stable tag isn't necessary and
> will result in some extra work/noise.  You generally only need to add
> a stable tag to a patch when the problematic commit occurs in a kernel
> that has already been released.
I'm sorry for that, when I bisect I found the commit is based on
6.13-rc1 so in my brain it is merged in 6.13, this is my fault.

>
> Back to the issue at hand, without line numbers in your problem report
> I can't be certain, but it looks like you have audit enabled but have
> disabled the LSM, can you confirm that?  If that isn't the case, can
> you please provide the line numbers in the backtrace above?  I'd like
> to better understand the root cause of the problem.
I configured SELINUX but disabled it with "selinux=3D0".

>
> Finally, if you do have audit enabled without the LSM, I would suggest
> that you rewrite the commit description to mention that explicitly and
> drop the backtrace splat as it is large/noisy, isn't line wrapped, and
> generally isn't very helpful without a specific kernel revision and
> line numbers.  Explaining the root cause, in this case the
> audit-without-LSM Kconfig, and perhaps an explanation that in the
> AUDIT_SIGNAL_INFO case an allocation can happen using an uninitialized
> length when the LSM is disabled, is much more useful in understanding
> the problem.  Oftentimes, including a backtrace in a commit
> description is a good thing, but only when the backtrace is put in the
> proper context so it can be interpreted by others without your kernel
> build at some point in the future.
Yes, the error happens in the  AUDIT_SIGNAL_INFO case. I will rewrite
the commit message, but I want to keep the main backtrace (but remove
those long lines to avoid line wrap).

Huacai

>
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index 13d0144efaa3..5f5bf85bcc90 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -1221,7 +1221,7 @@ static int audit_receive_msg(struct sk_buff *skb,=
 struct nlmsghdr *nlh,
> >         struct audit_buffer     *ab;
> >         u16                     msg_type =3D nlh->nlmsg_type;
> >         struct audit_sig_info   *sig_data;
> > -       struct lsm_context      lsmctx;
> > +       struct lsm_context      lsmctx =3D { NULL, 0, 0 };
> >
> >         err =3D audit_netlink_ok(skb, msg_type);
> >         if (err)
> > --
> > 2.47.1
>
> --
> paul-moore.com
