Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B208A1D90A5;
	Wed, 29 Jan 2025 08:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738137895; cv=none; b=kKQGZhYf3CYD7V1W4BzDnbIIjIwm7MwOuYRHdM+BeK4WOrGuuhXN7OZN3VwQmJqlsGQjtkIDkpFmcq0ug/M+BAF6WNHEcxBkLZ5URnksPPlcygwiOUSg63RuP9x2rErURsg9OWXF3XPDXu/e3BrSQB0IsQILrM6Ak4/48UKVUd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738137895; c=relaxed/simple;
	bh=vV8VC7gW1y4e7b9guBOCgv4che/eumlEj7H8rHa2JaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Suc25L9fHx5C5oS0umRJHDSRzWlT1FXXgSrJMlKQa8fZT6LXue1V4ykNJeGn4D6J/LTrXpvjCjfHndIuBs2qcqQ9SGIx7tY/OT30y+dIoSNzwlHwErG+uqXEHNMgZKJWF+BlZvcn6J1GzAc9O1BDr0bLwIfSWwXmP/Jk2UVEJoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sP4BH9lJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sP4BH9lJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922C0C4CEE4;
	Wed, 29 Jan 2025 08:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738137895;
	bh=vV8VC7gW1y4e7b9guBOCgv4che/eumlEj7H8rHa2JaA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sP4BH9lJsHYsp82CV3xFsEW17VGGWt3THwo0i117b5rL8XcWZDO006vtJYDs79jLy
	 gP9FmDe0X9HX1SI+KqKduNY8B6I82qXyik7vIQLJze/m8uPSFJ1CUNzUQ7CV5JrUS7
	 mLHMbwJwMc75UmJqTL+zE7fI1u+f5ptn0I+AZjMqAgdI1EhzwztRXVeM3563JSufY6
	 8UQNg8mBU8AXyDH5ifxXUSM0X89NqkyBPK8tkJ81NVLfN0aYiI9WyCAUh1vopLpypW
	 MfBtJAVYmARL4XfdHlqITXrT0evNE4MVfrHTubsveyrR3np8o3rliJAmqTVRMxW73n
	 QY76/YMhD22UA==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab2c9b8aecaso1176012466b.0;
        Wed, 29 Jan 2025 00:04:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUNKXiYRGJq9VKurjBhnztzhSAQwfL4Usiu4wctu6/5dxN24bcts4FQ7DSK3yNMlvlzcJJDa9+dtLDlWJB@vger.kernel.org, AJvYcCXD//MqgxVNzvS95Buuhwl4x70pSV5VJ0m/WB+TjuuNmsmNhLitRZJI5x905CmDhJ97ZvASUw==@vger.kernel.org, AJvYcCXX02ftn5hVrytDDrytBoN5icAmz0mkip/+9ipX8444geeztjz+Q3l1SDMQQyFlGKV0aeZOHUSx2IkfmBUcOKxR9kzWmqMO@vger.kernel.org
X-Gm-Message-State: AOJu0YwKOsQP+7oMMzL4SUQ4bmE9I1m1O+Y1oX3Bpdo1SZmbsWAtOqua
	+NF7VEBxjJdTGwMrUVwTcwY4kmMjorCSc7gZ/rz7FRDgvVuhX9SeDs7Zi6OzGQDaDTtn0yjlNdd
	Z2pF9kt6KM2qQ9XbFU2dnyCJIbEQ=
X-Google-Smtp-Source: AGHT+IEaSiuD+FqtqabhnWyUHm3RlZeN83OS2+fPJhG0JgPk5kmSxE2CDvWGC4KOp0VZLaO1TRlVSTNq8pWumZNCtHo=
X-Received: by 2002:a17:907:d88:b0:ab6:ce5e:5075 with SMTP id
 a640c23a62f3a-ab6cfcc508dmr226190366b.6.1738137893866; Wed, 29 Jan 2025
 00:04:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125141435.205096-1-chenhuacai@loongson.cn> <7c6419901a0f6958c58dc138fe5fd348@paul-moore.com>
In-Reply-To: <7c6419901a0f6958c58dc138fe5fd348@paul-moore.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 29 Jan 2025 16:04:42 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6cNu=3fXeD8h0s_NUcTAUv5jpAB48aqouOHCHN24M5Vg@mail.gmail.com>
X-Gm-Features: AWEUYZlLTRa-kzHQSAmDsjGeCUR_572L4k8_SfsIcI-aKyai6wSC-RLsmX2XyWs
Message-ID: <CAAhV-H6cNu=3fXeD8h0s_NUcTAUv5jpAB48aqouOHCHN24M5Vg@mail.gmail.com>
Subject: Re: [PATCH v2] audit: Initialize lsmctx to avoid memory allocation error
To: Paul Moore <paul@paul-moore.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Eric Paris <eparis@redhat.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Paul,

On Wed, Jan 29, 2025 at 7:41=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Jan 25, 2025 Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > Initialize the local variable lsmctx in audit_receive_msg(), so as to
> > avoid memory allocation errors like:
> >
> > [  258.074914] WARNING: CPU: 2 PID: 443 at mm/page_alloc.c:4727 __alloc=
_pages_noprof+0x4c8/0x1040
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
>
> If you are going to include the backtrace, please ensure that the lines
> do not wrap when viewing the commit using 'git log' in an 80 char wide
> terminal.
OK, this is easy by removing the timestamp.

>
> > Root cause: if we enable AUDIT but disable LSM, in the AUDIT_SIGNAL_INF=
O
> > case, lsmprop_is_set() returns false, then kmalloc() may try to allocat=
e
> > a large amount of memory with an uninitialized length.
>
> You shouldn't need to have a special "Root cause:" section, just work
> that into the commit description normally.  I would suggest that the
> commit description could simply be something like the following:
>
>   When audit is enabled in a kernel build, and there are no LSMs
>   active that support LSM labeling, it is possible that the lsmctx
>   variable in the AUDIT_SIGNAL_INFO handler in audit_receive_msg()
>   could be used before it is properly initialize.  This patch
>   corrects this problem by initializing the lsmctx to a safe value
>   when it is declared.
OK, I'll rewrite the commit message based on this.

Huacai

>
> > Fixes: 6fba89813ccf333d ("lsm: ensure the correct LSM context releaser"=
)
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> > V2: Update commit message and CC list.
> >
> >  kernel/audit.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index 13d0144efaa3..5f5bf85bcc90 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -1221,7 +1221,7 @@ static int audit_receive_msg(struct sk_buff *skb,=
 struct nlmsghdr *nlh,
> >       struct audit_buffer     *ab;
> >       u16                     msg_type =3D nlh->nlmsg_type;
> >       struct audit_sig_info   *sig_data;
> > -     struct lsm_context      lsmctx;
> > +     struct lsm_context      lsmctx =3D { NULL, 0, 0 };
> >
> >       err =3D audit_netlink_ok(skb, msg_type);
> >       if (err)
> > --
> > 2.47.1
>
> --
> paul-moore.com
