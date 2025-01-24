Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C8D15530C
	for <linux-security-module@vger.kernel.org>; Fri, 24 Jan 2025 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737738117; cv=none; b=GhADBUdWzRHSIbfp0UdKud3HGLdKOPvAx42LtouLPLSgPcBpJoPOHz3XXnUe67c/cnyeW6Si9FRCQavXNZ3zjmt0+q1H3k3gS+3rK7Kuebx9VeklSR7EckhEMW7b8ofemwa6DGhXdPEKrW3rW61PDvljVbjkq6nWpAgMCBDkgys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737738117; c=relaxed/simple;
	bh=KyvB074LKY4pZXyNHHxIB2JUc1etSzsqguXdZ9CwFr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rCCkSf3EesrvwxZkEH+Wm/ddp2AiMe3HpuZExVJ2U8M8n0sF5JHkaZXMiUc3CnRS5REE4LlkYfbFTIeHHFa6KpucZtUvZqeel+TYMgsz9fpkfiDAaxXqzaHTrAAm6hrmld1ZdQ0BKyd24GRhTRwOvJfLRA0ZJibSH0rBDu2178g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Z0tf2Z8b; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Z0tf2Z8b"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e53a91756e5so4167285276.1
        for <linux-security-module@vger.kernel.org>; Fri, 24 Jan 2025 09:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1737738114; x=1738342914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cjmSuIoOMZZENNHRMSvP3Ks+k7N6X68Q98F9+tN/Ro=;
        b=Z0tf2Z8b5cMQQukybuU4LOJsbYBShjwCu8Bs5gsHaN6ZCGOifsnpPWAUHmd62igq8P
         GnVtBprMtZHWcGlobMNDFv4BjkEAuoo4UH+9lby4Faye+L895rFdGY+YlXhzN8qwmU9O
         YF1nbRc8uXtD27fRwQ1SqRjGjONnFII+WZRQYftZCmVxrCogHbg6RjOyPxXtBDc5e08x
         fjYcwKFlnIduk2VWKj38bY/txWUh0H/GoGQt+6yDvqQgxg+tJwC1ptn1zYrLefcCFPkS
         uaKx8XpORf3wyztCx0aQ0OS5sNsXKjAwyShAeSpXwVVZIWB/EJxX86dbDQgkQFHffvm2
         XxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737738114; x=1738342914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cjmSuIoOMZZENNHRMSvP3Ks+k7N6X68Q98F9+tN/Ro=;
        b=JAWY9TPhuFNQl1tE5ysMpiSis2HbOB7koBM3qwk8CijvwbAfAvxh27xud8x4FQgcX0
         4+VvcQv9jt2zoa6cYvvn6hYleACHFdL/2LiWTjVB6iGRvJOljkgzg4338d69wTmgo3Wp
         b/QNe+dM87Ut5d+yNvE+Og0QorOhSTXoj3sq+Uu8AuM87HMOSKv/g1B8aRiqHS5WkrHl
         erbjztWHWjTpcpWRF0fkrWyKd8yx0AM86GLPOovQSUnPZ5LW8hcatJBWI6YtgtMNmcrY
         56W4UzeRd+5aDTff0TjaW9biBxeB0LHbgzNJbS+vhOOpsxu3klz+9E2XjIXQqWFer6Nj
         hTcg==
X-Forwarded-Encrypted: i=1; AJvYcCWg9YPwtoZOpcJoYRnPE0PGPg5KfGlwNuJbTlVEG1bbam00JzfIPgg+KXTzbhadnDd7czqk/g8Ot4HR8j/uE754z5Rg2wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZhwxEdStYnzaHdgcO7TT/SXMmzsJdNK8PVEvK5mvMiIeKyyKb
	7Caq7Pa7XGCKx1yg9M1tA5J/NTNKaISRFHMvNNgd4Q8ckPhLS2eRgRUs61UYNXb6LM4aduwSvSv
	jLZlZnPLFlX3E0mkAwFhzI0lsbbMXRpPK1v42
X-Gm-Gg: ASbGncvnhWNvMJ30+yhT0wWaBvupmYpWuw+ApBsoQi6OESLxm8sb3+0Vl6qor5VLTOs
	eNt5bTaGj9SM9lEk+j9YNwXQ3+yAuCLHAGhk9JkjL/fAzjainZ5TUxCcWmh1S
X-Google-Smtp-Source: AGHT+IHb9sk3ehKTGRS08Y1U9SLW8s+yiotTzqIKMznFmNeJ8QH8S31jCxV0VVB+WIJ7OzYnjmFpmAhMyrC1eDXziqs=
X-Received: by 2002:a05:690c:7349:b0:6ef:7312:d05e with SMTP id
 00721157ae682-6f6eb6b2551mr282243987b3.19.1737738114642; Fri, 24 Jan 2025
 09:01:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124091209.4013832-1-chenhuacai@loongson.cn>
In-Reply-To: <20250124091209.4013832-1-chenhuacai@loongson.cn>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 24 Jan 2025 12:01:44 -0500
X-Gm-Features: AWEUYZlTgfUHKpay17LlycDcW6N6nI-YGw3SJS2gEnVUm_kORtJVEFqmp2Yiys0
Message-ID: <CAHC9VhTZAMrGhNxHS52ua2g-sX_Q=qtmqZ1QgLXLyu2wufY81A@mail.gmail.com>
Subject: Re: [PATCH] audit: Initialize lsmctx to avoid memory allocation error
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Eric Paris <eparis@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 4:12=E2=80=AFAM Huacai Chen <chenhuacai@loongson.cn=
> wrote:
>
> Initialize the local variable lsmctx in audit_receive_msg(), so as to
> avoid memory allocation errors like:
>
> [  258.074914] WARNING: CPU: 2 PID: 443 at mm/page_alloc.c:4727 __alloc_p=
ages_noprof+0x4c8/0x1040
> [  258.074994] Hardware name: Loongson Loongson-3A5000-7A1000-1w-CRB/Loon=
gson-LS3A5000-7A1000-1w-CRB, BIOS vUDK2018-LoongArch-V2.0.0-prebeta9 10/21/=
2022
> [  258.074997] pc 900000000304d588 ra 9000000003059644 tp 900000010777400=
0 sp 9000000107777890
> [  258.075000] a0 0000000000040cc0 a1 0000000000000012 a2 000000000000000=
0 a3 0000000000000000
> [  258.075003] a4 9000000107777bd0 a5 0000000000000280 a6 000000000000001=
0 a7 0000000000000000
> [  258.075006] t0 9000000004b4c000 t1 0000000000000001 t2 1f3f37829c264c8=
0 t3 000000000000002e
> [  258.075009] t4 0000000000000000 t5 00000000000003f6 t6 90000001066b631=
0 t7 000000000000002f
> [  258.075011] t8 000000000000003c u0 00000000000000b4 s9 900000010006f88=
0 s0 9000000004a4b000
> [  258.075014] s1 0000000000000000 s2 9000000004a4b000 s3 900000010667340=
0 s4 9000000107777af0
> [  258.075017] s5 90000001066b6300 s6 0000000000000012 s7 fffffffffffff00=
0 s8 0000000000000004
> [  258.075019]    ra: 9000000003059644 ___kmalloc_large_node+0x84/0x1e0
> [  258.075026]   ERA: 900000000304d588 __alloc_pages_noprof+0x4c8/0x1040
> [  258.075030]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DCC -WE)
> [  258.075040]  PRMD: 00000004 (PPLV0 +PIE -PWE)
> [  258.075045]  EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
> [  258.075051]  ECFG: 00071c1d (LIE=3D0,2-4,10-12 VS=3D7)
> [  258.075056] ESTAT: 000c0000 [BRK] (IS=3D ECode=3D12 EsubCode=3D0)
> [  258.075061]  PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
> [  258.075064] CPU: 2 UID: 0 PID: 443 Comm: auditd Not tainted 6.13.0-rc1=
+ #1899
> [  258.075068] Hardware name: Loongson Loongson-3A5000-7A1000-1w-CRB/Loon=
gson-LS3A5000-7A1000-1w-CRB, BIOS vUDK2018-LoongArch-V2.0.0-prebeta9 10/21/=
2022
> [  258.075070] Stack : ffffffffffffffff 0000000000000000 9000000002debf5c=
 9000000107774000
> [  258.075077]         90000001077774f0 0000000000000000 90000001077774f8=
 900000000489e480
> [  258.075083]         9000000004b380e8 9000000004b380e0 9000000107777380=
 0000000000000001
> [  258.075089]         0000000000000001 9000000004a4b000 1f3f37829c264c80=
 90000001001a9b40
> [  258.075094]         9000000107774000 9000000004b080e8 00000000000003d4=
 9000000004b080e8
> [  258.075100]         9000000004a580e8 000000000000002d 0000000006ebc000=
 900000010006f880
> [  258.075106]         00000000000000b4 0000000000000000 0000000000000004=
 0000000000001277
> [  258.075112]         900000000489e480 90000001066b6300 0000000000000012=
 fffffffffffff000
> [  258.075118]         0000000000000004 900000000489e480 9000000002def6a8=
 00007ffff2ba4065
> [  258.075124]         00000000000000b0 0000000000000004 0000000000000000=
 0000000000071c1d
> [  258.075129]         ...
> [  258.075132] Call Trace:
> [  258.075135] [<9000000002def6a8>] show_stack+0x30/0x148
> [  258.075146] [<9000000002debf58>] dump_stack_lvl+0x68/0xa0
> [  258.075152] [<9000000002e0fe18>] __warn+0x80/0x108
> [  258.075158] [<900000000407486c>] report_bug+0x154/0x268
> [  258.075163] [<90000000040ad468>] do_bp+0x2a8/0x320
> [  258.075172] [<9000000002dedda0>] handle_bp+0x120/0x1c0
> [  258.075178] [<900000000304d588>] __alloc_pages_noprof+0x4c8/0x1040
> [  258.075183] [<9000000003059640>] ___kmalloc_large_node+0x80/0x1e0
> [  258.075187] [<9000000003061504>] __kmalloc_noprof+0x2c4/0x380
> [  258.075192] [<9000000002f0f7ac>] audit_receive_msg+0x764/0x1530
> [  258.075199] [<9000000002f1065c>] audit_receive+0xe4/0x1c0
> [  258.075204] [<9000000003e5abe8>] netlink_unicast+0x340/0x450
> [  258.075211] [<9000000003e5ae9c>] netlink_sendmsg+0x1a4/0x4a0
> [  258.075216] [<9000000003d9ffd0>] __sock_sendmsg+0x48/0x58
> [  258.075222] [<9000000003da32f0>] __sys_sendto+0x100/0x170
> [  258.075226] [<9000000003da3374>] sys_sendto+0x14/0x28
> [  258.075229] [<90000000040ad574>] do_syscall+0x94/0x138
> [  258.075233] [<9000000002ded318>] handle_syscall+0xb8/0x158
> [  258.075239]
> [  258.075241] ---[ end trace 0000000000000000 ]---
>
> Cc: stable@vger.kernel.org
> Fixes: 6fba89813ccf333d ("lsm: ensure the correct LSM context releaser")
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  kernel/audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

[NOTE: dropping the stable mailing list and adding the LSM list]

Thanks for the problem report.

First a bit of metadata feedback: the stable tagging isn't necessary
as the commit this patch claims to fix was first introduced during the
current merge window just a few days ago; as long as we fix this in
Linus' tree before v6.14 is release a stable tag isn't necessary and
will result in some extra work/noise.  You generally only need to add
a stable tag to a patch when the problematic commit occurs in a kernel
that has already been released.

Back to the issue at hand, without line numbers in your problem report
I can't be certain, but it looks like you have audit enabled but have
disabled the LSM, can you confirm that?  If that isn't the case, can
you please provide the line numbers in the backtrace above?  I'd like
to better understand the root cause of the problem.

Finally, if you do have audit enabled without the LSM, I would suggest
that you rewrite the commit description to mention that explicitly and
drop the backtrace splat as it is large/noisy, isn't line wrapped, and
generally isn't very helpful without a specific kernel revision and
line numbers.  Explaining the root cause, in this case the
audit-without-LSM Kconfig, and perhaps an explanation that in the
AUDIT_SIGNAL_INFO case an allocation can happen using an uninitialized
length when the LSM is disabled, is much more useful in understanding
the problem.  Oftentimes, including a backtrace in a commit
description is a good thing, but only when the backtrace is put in the
proper context so it can be interpreted by others without your kernel
build at some point in the future.

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 13d0144efaa3..5f5bf85bcc90 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1221,7 +1221,7 @@ static int audit_receive_msg(struct sk_buff *skb, s=
truct nlmsghdr *nlh,
>         struct audit_buffer     *ab;
>         u16                     msg_type =3D nlh->nlmsg_type;
>         struct audit_sig_info   *sig_data;
> -       struct lsm_context      lsmctx;
> +       struct lsm_context      lsmctx =3D { NULL, 0, 0 };
>
>         err =3D audit_netlink_ok(skb, msg_type);
>         if (err)
> --
> 2.47.1

--=20
paul-moore.com
