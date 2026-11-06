Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793993601;
	b=KEgsqcyvk/dLA3AT9gtPYEfJz/ejSZaPU66QPu0V7yhusd8skzjJ1NvSQUQHDlsbnG8w
	 ALCRWRFzTbgU8qtVx51a0HVylHSm0GLgtZ/u1lcp9g/Fm8Hu7jbPTO0ruK+qDX7GlnJIc
	 OHmcjFQ822Cofj4sK00Kr1znIyJ0qiVfpAZr/Zg08tzKTdMlpnvdfwk0I4iTr1Z4NJwPw
	 cbAQ8nbvaaUvHbaBntuGhtgVcAlhGccvx7bxyCyB7QSXvlugbzbqegBpVPpNhRCIPaJZL
	 bDDJFF1s8IORewSblW+8KJKkLMJG7hqVIXxxAE1DxbXnFypgQ5hvnCMVofpEotsSsiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=WASkhr+Unco/i3EllWy4fEDfIef6kYtQba3wH4Yi4vg=;
	b=voK44r/tVeZImJs7csVDgD6wKRwI8KZgn1s67GFs3w/dikEsjUwKUiiK/hg51y0f5AdI
	 sPrg4EzaE9UeB7Fv011A2R5tjO/nxN347PQPIZoo9b4GHqs+9c8qEjhdzQNW/S1OgOgD6
	 Xd1hnWQSqIGy4mZbuvwrjyCcFBC2RxevPSivVt+pHMIe9r+75CMyYe9/SSTQTorK41BLr
	 BtwvWnzFm+PBYA5vMrpe2zfRhDA6Sg9IOeGo3M6Q3v5Mj1Oje+uBMHnS8ARphEfc0Kgpl
	 2MFGoIqtU6C/hOew6ckKdcQgELlBVuOqIphyrd0fR4sMExTUcuGGAZm9twMtSJ1aHDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="PTOVU/vt";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C989D606A326
	for <linux-security-module@vger.kernel.org>; Fri,  6 Nov 2026 19:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C989D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PTOVU/vt
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b0e61a4decso653811a91.2
        for <linux-security-module@vger.kernel.org>; Fri, 06 Nov 2026 11:33:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793993600; cv=none;
        d=google.com; s=arc-20260327;
        b=CeoZtmSYrgTWznh5CnZAtwI4lGh/AhQjeh/XJVOTs7SeM0NOzwJEelA1dvoeEgpQBe
         cvgfpNRB9IEgPcxkseg3FR9QrC5HXvrcztOxToJbQ1Gb1TB8hVbEMvAlcISp0x4aq4gv
         KERxSTJYH/DX7Pdml0wU1t+WwqfBKBG7ASON/5YqWoa0S3TdD9EsH9Udd4ih/bbbdGJp
         nJLzNEWIAB8a28rZHP8UhEvKms+YwoWc9o2keuy4cbGzxhjeWMBCic7s9JHvIU/w4NqQ
         nePA1e1CL7tKDrBrNw+o5b01qgenGxOLXQ/sVjhhP8uD/6ZpypVS+DcUKIyASYihj3W5
         mqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WASkhr+Unco/i3EllWy4fEDfIef6kYtQba3wH4Yi4vg=;
        fh=UH0GN96WpU8iYTX3X4uqNDnc/WgWr151d+re0pv7eMA=;
        b=b5TrvgDANq6wdZJAWikMVjJoOPNVXQ4AvOYDUVvTjums6pj15a+O51+zWaHX6SuzHP
         /B3nb9cBvPgER0xAuyBN87vjtLTiELPhPYSRmYOtSDWqAslm15fz8ab9o+3XfSmXfBuS
         QkdPLRPfYa2L2ibpsUFPuqLJpI/nWePUJzNgsCPY+U5cpdoyUdnSVcE7zyCMxqEziz9s
         F6g4D3d5ceN9Y76EgIhShDg/AdPyxwec5CqA8yTg64MKSe300EH9YJyJP17bhKSye7eU
         3+7bwblF3MTjEatsZ52iJEXcdBoeypNeUJSpKsYgsS9eqwfrJcFx+O3p6VDfd6n/DaGG
         lNOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793993600; x=1794598400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WASkhr+Unco/i3EllWy4fEDfIef6kYtQba3wH4Yi4vg=;
        b=PTOVU/vtLVZodS0aOcFhbpPojR0zuZKWzH68M+LgwxhUiMUUV3OwAyiTQVlrcMUxnw
         5JHwdxmXVMsluwjPwApczHspB1hZrE0pKL/8rrvoFqdMiAAIy/MuK/FDLY/YlGrgdoOY
         jxkOm4zP18LMj/UG5TtK2Sbm6RkPSaVEOsrTsblHURQnq9i+o8BdEGcq0vnh65KC4pua
         t8qO68S7cQUlzZGrCjEamaURGUFfAElVnw+yN5jGhpynX4i2G4J6wYWvFEyWHFgm6twr
         X1h0Mzbrfv9Aol8EK2bqGug92Yy85UqYnHSA3uCYJGOwgKYOYLZQImW0f6cOgC9KFbL1
         gmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793993600; x=1794598400;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WASkhr+Unco/i3EllWy4fEDfIef6kYtQba3wH4Yi4vg=;
        b=kSy2Q7+rvTeAz8qtQaJjsFSvFdqG8T0XyTRLnl5tYffm91i1QbugK83D1MiIUhJC8x
         FlaugQEEahUHvhF7MqiQiccdZnWkoiB0q0vRXdsOr6/hJKdkSAXAQ44MKwVH9lJ/x2ua
         bLRu4JpRMVvPN2r/xrB1t9+gnVdHiIRgWy+EVSFjmH6th7JT87hhHlmLBKKA2uw3lQDc
         a4IaT551W6lsyRd6mZL/g88yTzfjSmbYBx+bEJmZdzWHYhxyrQvyStLWiLXIe6y90GVq
         xOhZBiXuFDRjT8CjYvRD5MBwFx9JSzcNlav3X46dT2BGtC6uLvnCoPPoNmX962OsRXVV
         dMVw==
X-Forwarded-Encrypted: i=1; AL+hErEMWZOWHhby4Qy3arP6uCLhJQQhVOcj/+PM8B+HUN5IQ3yhEbTOQM5zaodE1AVYu8LY4cfq7HZJOX35H6aHIAHfNY03b4w=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VPsG5w3FJibdFDlCeuRyulHXmi9oaYnF0FWlOYG/Mp0DUI/kE
	4wFdDv+jx8Xi1JhRRaXNHClc7BL7GLkh5fdQ026kQpq0lkYKfu84TBizK8x15nO0SXq0HRAhM/O
	2ttLEPimb8glGW3IY/6nhv/C0+LnUFAg=
X-Gm-Gg: AYBFou2ZrdLwmOpNc1wGd3UkbXMVOX0YBNoUFF2jRsF1VDqWsWVU/l8KGjKMeRhtmOh
	qOrvAM8XBU96AVgUpUXAIf2TcQ+XmE1PahLrk61HvGlYBEw/SgKBnfRk05NyIac8OFX6eXT5uOM
	HxtvJ0V+2tKA9VR9BInZ6aD7fHBn9maEtrsPjbr2oTrJ7XFtcC8BgKQEnUrrOUYwkcbTR6tNz4l
	cSt6eP5wPnbSQFnyridpRJn52XaQTp6gYBxRsaFa/BluvPI8RHg1UgajNez1hjt0N4ycL789bye
	4mOLl+eqp78xvwuqb5hhJEu2zb6vf49RKZHddrUscr6A7W4S2kLYKOgpzsqXFx/P4n9YHyyn+6P
	gHa5HsiHKzluWTL6j1uYSA/Kt8CsmnpMhDBJZX5gNU8Lfgn28uMUyHPDGUahjhINM/A1mTTVBwu
	vcpvA=
X-Received: by 2002:a17:90b:39ac:b0:3b0:9cc6:62bc with SMTP id
 98e67ed59e1d1-3b0db6ebd52mr3469969a91.37.1793993600100; Fri, 06 Nov 2026
 11:33:20 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <d85ece6e-27f9-4d9f-83af-4101bc76fef6@app.fastmail.com>
 <356db94e-f5d6-4fb2-839a-b97aef72256b@app.fastmail.com> <CAHC9VhR9sjunJRnM9gy-BkBZkapQTrr8a8FtmaK7JkAmUqTrLA@mail.gmail.com>
In-Reply-To: <CAHC9VhR9sjunJRnM9gy-BkBZkapQTrr8a8FtmaK7JkAmUqTrLA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Nov 2026 11:33:07 -0800
X-Gm-Features: AclHuK9gXDhZeKl8Js7bG-wUcnzU8mjlehe58_riZeQRtc97_9zHpsNN_OoiZ0w
Message-ID: <CAEf4BzZKmn6g0SK8OddjKFj_vAmZFvpZv32Hs_S+GHgT7VNfrg@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: Paul Moore <paul@paul-moore.com>, Daan De Meyer <daan@amutable.com>
Cc: roblabla <linux@roblab.la>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul.mabileau@harfanglab.fr, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:41=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Fri, Nov 6, 2026 at 8:39=E2=80=AFAM roblabla <linux@roblab.la> wrote:
> >
> > Hello,
> > First of all, I'm sorry if I'm sending this email to the wrong mailing =
lists, it's my first time reporting a linux issue ^^'.
>
> Hi,
>
> It looks like you sent this email to the right people/lists, well done
> on the first hurdle :)
>
> > In commit 16959c469f232f5c76cfb628297cafbf6dbdba79 (lsm: expose mount i=
dmaps to inode hooks), merged in 7.4-rc1, a new argument was added in posit=
ion 0 of various inode-related `security_` functions. Specifically, it adde=
d this argument to inode_create, inode_link, inode_symlink, inode_mkdir, in=
ode_mknod and inode_permission.
> >
> > This has the immediate effect of breaking eBPF LSM programs relying on =
these hooks that were compiled with BPF CO-RE and using BPF_CORE_READ.
>
> ...
>
> > Now, I'm not sure how the Linux Kernel treats eBPF LSM hooks - if they'=
re considered part of the userspace that shouldn't be broken. My understand=
ing is that kprobes are not part of the Linux Kernel stability guarantees, =
for rather obvious reasons (they allow watching the internals of the kernel=
) - but I'm not sure if this extends to the LSM Hooks. I assume not. Still,=
 this kind of breakage is really painful for us, and I hope we can find a s=
olution.
>
> Like kprobes, the LSM hooks are intentionally not part of any stable
> API promise.  While we try not to needlessly churn the LSM hooks, we
> reserve the right to modify parameters, the LSM callbacks associated
> with a hook, and even the basic hook semantics from one kernel release
> to another.  The reasoning is very similar to that of kprobes: the LSM
> hooks are linked to kernel internals and thus need the ability to
> change as the kernel changes.
>
> LSMs that need to provide a stable API must provide an abstraction
> layer between the LSM hook callbacks and their stable API.  The LSM
> framework is not responsible for the stability of individual LSM APIs.
>
> > Could we fix this type of breakage by making sure new arguments are onl=
y added at the _end_ of the LSM hooks signatures,
>
> I'm sorry, but I can't make that promise at the LSM framework layer.
> It is impossible to predict how the kernel internals will continue to
> evolve and thus I can't promise how the LSM hooks and callbacks will
> need to change as a result.

Yeah, I think that's a reasonable stance and we went through similar
discussion about tracepoints not being stable APIs, no questions about
that. But I'm wondering if it's not too late (as far as I understand,
this hasn't gotten into final release just yet), would it be ok to
just move newly added argument to be the last ones? We had similar
problem in not too distant past with one of scheduler tracepoints,
where new argument was added in the middle of argument list, and that
causes just unnecessary friction when using BPF with old and new
kernels. We did move the argument to the end and resolved this
(without really mandating any stability guarantees).

So, in short, would it be possible to send a follow up to Daan's
commit and move `struct mnt_idmap *idmap` to the end of LSM argument
list?

>
> Regarding the specifics of how the BPF LSM has dealt with this in the
> past, and any plans for the future, I'll let others speak to that;
> hopefully they will have some tricks you can use to make these
> transitions easier.
>

(this is answer to roblabla, I don't think you, Paul, should care)

The answer here is nuanced. On one hand, libbpf and kernel (BPF
verifier) don't really know exactly what BPF program assumes argument
types are. libbpf-provided BPF_PROG() macro that everyone is using
with BPF LSM just assumes user specifies correct sequence and types of
arguments, and libbpf just provides a bit of syntactic sugar with
casting untyped input arguments (they are just "u64" types) into
expected types. So it's not easy to detect this automatically neither
in libbpf nor in BPF verifier.

Having said that, there is a way to handle this, although ugly and
*everyone* using specific LSMs would need to do this on their own.
Instead of using convenience BPF_PROG() macro to define BPF program,
you just use raw `u64 ctx[]` access, and then cast ctx[0] to either
`struct mnt_idmap *` on new kernel, or `struct dentry *` on old
kernel. And you do that for all arguments. E.g., something like this

SEC("...")
int my_prog(u64 ctx[])
{
    bool new_kernel =3D ...;
    struct mnt_idmap *idmap =3D new_kernel ? bpf_core_cast(ctx[0],
struct mnt_idmap) : NULL;
    struct dentry *old_dentry =3D bpf_core_cast(new_kernel ? ctx[1] : ctx[0=
]);
    ... and so on ...
}

How you determine "new_kernel" can be done in various ways as well, I
don't want to overburden this email with details, but it's doable as
well.


so, tl;dr, it's possible to handle this LSM signature change, but it's
painful and requires knowing about breakage and doing a bunch of extra
plumbing.

ideally, if it's just a new argument addition, it should go to the end
of arg list and then all these issues go away

> --
> paul-moore.com
