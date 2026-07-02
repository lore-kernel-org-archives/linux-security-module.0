Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAAB38D40B
	for <linux-security-module@vger.kernel.org>; Thu,  2 Jul 2026 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783029932; cv=pass; b=JoZjkxbEg39ihHHRrBd/kLJFFKWEamMyKGN+YxErDjzro/5s1jFOABFFllhhoN9LGQLgkoHnsxp1LbP0X34G7/xXBm0xOHlJYXSUx5rmqYJn3kwf6hEHL8/uPEU7FSuEQ+pqbggxSHlP7nB46/Y4UwoAgvGrUQ1XESaZ4uDDHx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783029932; c=relaxed/simple;
	bh=bXiGxNJabvOUzbO9jP373uIsGkgJEfxAsimA9dnMZUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ik2nM+N+2HYpAIvwpmX08ea3077bVCBwmV86ZyQNBpDVgUOBrqUrLb/KgNbSWTZa/NO/YJ3fozchWCoQBmRTErmZzt40pyID4Wjq0suM9t/vyhcLfC7FexrSWL5sXpZ9OESwMBNB34ezUJLHISL6QmRSsOaQK7bEbU8CCXHoRWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DgmFRc5x; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DgmFRc5x"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8478fe07f65so2201097b3a.0
        for <linux-security-module@vger.kernel.org>; Thu, 02 Jul 2026 15:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783029929; cv=none;
        d=google.com; s=arc-20260327;
        b=CGN8bBJIvmF7vIryYphR4MkP/DqVx1Qu3Umt7+dpFoVzxBWPBHOqk7vead980qZnB0
         Pa4fBUiEmgekvGMQdVq1QCRoGlC+RIHS3L83UXgQWji9twM/jQB1MCoFK5zNc/MF+A/q
         mRcV1qg3Ci2NR2iutCemB8bqte0ItTI6aWLwGD7JSvk1mUnUwWnQTdrUO1Y11XGBbTyE
         rg3rYyHsQ2pKyZEM5o2Ha2kL35JgBab0zWn9MJOWsGxWbd/Y+yOvXnw0dM4RiVegVVUS
         ymBtPvUWNCDxHO7+aal0JWRA9KgXpaVs/M3Xw7VP7DOk1vBPpb9NzqjwV5NP7RZqYi1e
         MJog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/8BylbGalzGrE/aYiP0aFX/AZnbs5Ex8F/epNxq5uCo=;
        fh=1EwYHxu+USQgaLw1y51qygvCyxBsLmf9gbMkTQzWWAA=;
        b=h1CuGw76Jr5OCvR+6zzU9bJz8iA8ml7jtDQ8h2ao0gmUyqMexqVhhpf/WNaePjVQSw
         EiCz2deLP8UF1ruSty/h+teaTVcbY2QsI1gyJy0jbn+7eARFq1BIPtiNiHNlbUT4NTNm
         CrkRix/POY8zZLTey7IVG87DOxGPCZcWyRodHFBGUObVP15wRW9+L9fKP9Izzo2fOxKE
         UOFyA0wPXlYZ55m3yNkiKoWTrGnavIG4rmG+Edh5ji1SXNdJw6wzJPwGJQIhx3IfTFQC
         Yv0IPQMRdPtA6U/fLCwskmiYhlKBLgT6JeVJuInfBx3Jqyy6R9X+p7fPfW+0UUG9wzrq
         KyLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783029929; x=1783634729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8BylbGalzGrE/aYiP0aFX/AZnbs5Ex8F/epNxq5uCo=;
        b=DgmFRc5xHXpUgqHCsug2QPS5w4P80SUMvB3ZtgIaZSr+PzJRHfMt1nx2v2+hWwbCmo
         N2bLAmFKhQp86Lusr54deFffNpdxbhnpq391froiRrrGyhKFOZxQ63aeshTNmPPnN9GC
         eNsds/oxXv1S0DfxRBvpiLbMHUPvwLSYXBhP2+nI+pRY0EYCADiX2kn79n4A6I6KxgDZ
         7M2fVjmqeMu7SxHNXb6gQQ5/7eJaGpKT+v2Yf149I4Whxv/LNhaOAtjcr1Ps9EzVE9Bt
         YsHm7OMnOlI7YPVMHk7eireaNnIeWT+ybHsNK63SeuTv7yjTKMWd5sRQDerTyo5phIkK
         H+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783029929; x=1783634729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/8BylbGalzGrE/aYiP0aFX/AZnbs5Ex8F/epNxq5uCo=;
        b=Uey51xrD7Mt/RZ0nt1BVC008IqMZcnmBHvF6G/F1rdK/07xeIjcpYD+t8uaOXm9kQ7
         W7pLWivmqIXOxp+6VodrlZCh67mYfrndEB4yvBzEDwJimmzIwze57SkireVnFCi9h+8k
         SBj8mRzQ5eX2P9ahydFJESNQJO+/wOzV08/7rb9Fz+gVZ5lYUKNLXjbGuW2upMziup+J
         yLcmqqI8wX5sLwpbPjpX0ZvXUsfRhqdfNqz3/Y/EhduYonR+qQAT31LTzcKX8AgC0X21
         CzK4gf08SmKPuSn8k5trGpeTM0OIZ+VnMHp206gf1Fp8FnSIsBsnhJA0MSBJ3AXUwyWt
         THlQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Myv/1uMX8egjnLAfWlgp9w6+OgeMj5MK1/A2LS6CuXhs0wxVFS8A/YuyhU4/ULCVCjstvAF51TfgBhemUxycyii8SdnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1VA/RiVPvFiJe+1FYPTS0Euvq7Vf4Ofsic/0zagnUQQou8i8L
	HzpCqc6HH9E2pOHmNN0RQ+joHpBmNnCy91YLoGk1T6QY78XHZpAxp+HlJZutZT2Vu3o/zfg1u9x
	WTRQYMg0FI+/CccjlIXJUL4dPFdWbmhZxdPIq+JLy
X-Gm-Gg: AfdE7cmmUvmYTvJZjQTnFoheUdHN2z28fyBNwkrzlc8z6TxjNxBf9ntBjAlEfgJgYM6
	keElUfgUoEVRqQIjTzHQ7kg/gh1/a//7156fgbMVLtSCRlzczO5u3yq7KUB5uyCEFnGtiT/0/Fu
	miIUPTMUh78+NBm0ffbRhZ0PqmLcZzicEDOchE1DFsfFX5pPZivN3xffnzRz/vYWdCZ2flmQnNU
	J5CN++tNlECoG89svt2UTw2E4csFzK6CVPMUVj8TOhiZvuIIV0+0VMXnb+yoUad8KDjBnlH
X-Received: by 2002:a05:6300:2211:b0:3bf:ba2a:6a8e with SMTP id
 adf61e73a8af0-3bfed1f7000mr8977414637.21.1783029929236; Thu, 02 Jul 2026
 15:05:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702143605.252797-1-daniel@iogearbox.net> <20260702143605.252797-3-daniel@iogearbox.net>
In-Reply-To: <20260702143605.252797-3-daniel@iogearbox.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 2 Jul 2026 18:05:17 -0400
X-Gm-Features: AVVi8CcgHlbLJBJKhpshKVmWNVeIUgi3gl9hCKKqGwCDey9KQz69ULWdnY7SM0E
Message-ID: <CAHC9VhQD4RHsGiTMVCCTN+eB71-Ueopke8XghExpNJ2PSNa_jQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] bpf: Verify signed loader metadata at
 load time
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, kpsingh@kernel.org, James.Bottomley@hansenpartnership.com, 
	bboscaccy@linux.microsoft.com, memxor@gmail.com, 
	torvalds@linux-foundation.org, a.s.protopopov@gmail.com, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 10:36=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> A signed gen_loader program carries the programs, maps and relocations it
> installs in a metadata array map. The loader instructions are covered by
> the PKCS#7 signature, but the metadata map is not: Today the loader
> compares the map contents from within BPF against a hash baked into its
> (signed) instructions, using the kernel-cached map hash. The kernel itsel=
f
> never actually attests that the metadata the loader installs is the
> metadata that was signed.
>
> This split is the core of the long-standing objection to the BPF signing
> scheme from the LSM / integrity side: the integrity check of a light
> skeleton only completes once the loader program runs, that is, after the
> security_bpf_prog_load() hook, so at admission time an LSM observes a
> program whose payload has not yet been verified [0]. Auditing the chain
> link is also not a purely cryptographic operation: whoever signs or revie=
ws
> an lskel has to disassemble the loader's preamble to convince themselves
> that the embedded hash check is present and correct [1][2]. Two acceptabl=
e
> fixes were identified in those threads: Complete the integrity check
> before the admission hook fires, or add a second hook that collects the
> verification result after the loader ran [3]. Let's implement the former,
> without growing the UAPI.

While you've documented some of the objections from the LSM side,
you've missed the largest objection to the existing BPF signing
scheme: KP's scheme runs the PKCS7 signature over the lskel loader,
while the scheme that Blaise proposed (in multiple forms, not just
Hornet), runs the PKCS7 signature over both the lskel loader and the
associated maps, just as you are doing in this patchset.  Moving
towards a scheme where the PKCS7 signature encompasses both the lskel
loader and the maps is a good thing, I'm happy to see that.  However,
I do have other issues with this patch that I've mentioned previously
(more below).

> A signed loader binds its metadata map(s) through the existing fd_array,
> and an exclusive map is already bound to a program digest (excl_prog_hash=
).
> So when a signature is present, collect the exclusive maps from fd_array
> and append their frozen contents to the instructions before verification:
> the signature now covers insns || metadata_0 || metadata_1 || [...] in th=
e
> fd_array order, and verification completes in bpf_check(), once the
> fd_array maps are resolved into used_maps, before the LSM admission hook
> and the rest of verification.
>
> A program is either BPF_SIG_UNSIGNED or BPF_SIG_VERIFIED, with nothing in
> between. While folding the fd_array maps, a non-exclusive map bound to
> a signed program is rejected, so every map folded into the signature is
> exclusive. A signed loader that fails to cover its metadata thus does not
> load, and BPF_SIG_VERIFIED always means the instructions and every
> exclusive map are authentic.
>
> The maps must be frozen so the hashed bytes cannot change before the
> loader runs; the map <-> program digest binding is enforced by the
> verifier for every used map. Binding maps through fd_array_cnt makes the
> verifier resolve and excl-check them (excl_prog_sha vs prog->digest)
> before it would otherwise compute the digest, so compute prog->digest
> up front in bpf_check(), over the unmodified instructions the
> signature covers, for a load that folds metadata.
>
> Unsigned programs are not affected. Note, signed loaders generated by
> older libbpf/bpftool versions need to be regenerated; some of the recent
> fixes we've had on the signed loader side require the latter already to
> close gaps.
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://lore.kernel.org/bpf/CAHC9VhSDkwGgPfrBUh7EgBKEJj_JjnY68c0YAm=
uuLT_i--GskQ@mail.gmail.com [0]
> Link: https://lore.kernel.org/bpf/2f71d6c03698eb17d51f7247efde777627ee578=
a.camel@HansenPartnership.com [1]
> Link: https://lore.kernel.org/lkml/ecf0521ed302db672672ebfbc670ecfba36a6e=
00.camel@HansenPartnership.com [2]
> Link: https://lore.kernel.org/bpf/88703f00d5b7a779728451008626efa45e42db3=
d.camel@HansenPartnership.com [3]
> ---
>  include/linux/bpf_verifier.h |   1 +
>  kernel/bpf/syscall.c         |  76 +--------------
>  kernel/bpf/verifier.c        | 175 +++++++++++++++++++++++++++++++++++
>  3 files changed, 178 insertions(+), 74 deletions(-)

...

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6db306d23b47..e898fad01aaf 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3189,10 +3121,6 @@ static int bpf_prog_load(union bpf_attr *attr, bpf=
ptr_t uattr, struct bpf_log_at
>         if (err < 0)
>                 goto free_prog;
>
> -       err =3D security_bpf_prog_load(prog, attr, token, uattr.is_kernel=
);
> -       if (err)
> -               goto free_prog;
> -
>         /* run eBPF verifier */
>         err =3D bpf_check(&prog, attr, uattr, attr_log);
>         if (err < 0)

As I mentioned previously, the security_bpf_prog_load() hook should
not be moved.  Its placement was deliberate, and moving it as you've
done in this patch creates a security regression.  Without this patch,
for processes where SELinux is preventing BPF programs from being
loaded, it is able to do so before the process allocates a potentially
very large chunk of kernel memory, up to one million BPF instructions.
With this patch, even in cases where SELinux will prevent the BPF
program load operation, it is not able to do so before the process
triggers a potential sizable memory allocation, opening the door for a
local DoS attack.

In an effort to work with you on this, I did bring up two alternative
solutions: a new LSM hook for the signature verification, or the use
of the existing security_bpf_prog() hook.  The latter option is
conceptually less clean than the former, but it should still work to
control access to the BPF program based on the signature results.
You've mentioned that you are not in favor of adding a new hook, but
you have ignored the other potential solution of using the
security_bpf_prog() hook.

You can (re)read my earlier comments at the lore link below:
https://lore.kernel.org/linux-security-module/CAHC9VhTtaT_8AXSfNKiq4cGq7T=
=3D6Dh=3DhuM8niBCwOP8kj+ugjQ@mail.gmail.com/

While I don't like to do this, you haven't given me much of a choice;
the security regression can not be ignored:

 Nacked-by: Paul Moore (don't move bpf_prog_load LSM hook) <paul@paul-moore=
.com>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 44bb6ce17a1c..1609053a0eeb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19901,11 +20060,27 @@ int bpf_check(struct bpf_prog **prog, union bpf=
_attr *attr, bpfptr_t uattr,
>         ret =3D bpf_vlog_init(&env->log, attr_log->level, attr_log->ubuf,=
 attr_log->size);
>         if (ret)
>                 goto err_unlock;
> +       if (env->signature) {
> +               ret =3D bpf_prog_calc_tag(env->prog);
> +               if (ret < 0)
> +                       goto skip_full_check;
> +       }
>
>         ret =3D process_fd_array(env, attr, uattr);
>         if (ret)
>                 goto skip_full_check;
>
> +       if (env->signature) {
> +               ret =3D bpf_prog_verify_signature(env, attr, uattr.is_ker=
nel);
> +               if (ret)
> +                       goto skip_full_check;
> +       }
> +
> +       ret =3D security_bpf_prog_load(env->prog, attr, env->prog->aux->t=
oken,
> +                                    uattr.is_kernel);
> +       if (ret)
> +               goto skip_full_check;
> +
>         mark_verifier_state_clean(env);
>
>         if (IS_ERR(btf_vmlinux)) {
> --
> 2.43.0

--=20
paul-moore.com
