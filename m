Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46B43D3498
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jun 2026 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313950; cv=pass; b=LL2eO8Kip47S21JDay62TFl0ai2ZrJPeLlNtjgDodqrkP9KSgTz7GQufs5QtYBr6LgZ56ZwVjiJ9ovz8mNloMi0FN37/0d0IU3yaWEtJ4ScxzqSKeTgtKz1/g/xa29W2FaCgSojIhw/n7wr6mvxXARXGZVBTaABOIAt8A+laWec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313950; c=relaxed/simple;
	bh=Vp8keKnwuVU25gbS2Lo25BsNMlW82wWYUgV18JLLcBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H35UC9v6BW58QuU/Qi20YOuv38+uI5W3DXPGvRf1S0cJzwZbxlAVzP/87MN0Fg+gj7roa1spq6EIG3ltkol1bJurym3D3tolVrTjT+UM9TYpfteXwcMU59grotfjSvi2Y5BaNlR31E5FbfQ5r5jbgvnGssdUgM2xvGrulwyOipE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=alFZs241; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="alFZs241"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37cab825ec9so945537a91.1
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jun 2026 08:12:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782313947; cv=none;
        d=google.com; s=arc-20240605;
        b=L1jwcLOtar+Jx8n7igWhi2mDwioujXm2L2/zpg8vGR460RlrziOYXefV7lXHZwLBBI
         WQpKaK6atKzl4p+eJoBGCuQAlKg2xzZLAkZAY5npl05S43sVGqjuas+zIiZPMutr1ZXg
         1DU2VV8RLg16dewHInsaBLDToFuGiely8O3jDYWLG2uYbu283x6oH8gwIRmBuN5t5dd+
         Al+6NJ46ICZo6Z+9Wr24BndxUgiJzqfy0vP34VP5aXrI00MbOhlLOU+aNysVIEwMiOTf
         a9qQICsE5aCZBJbkv78O7rZJaBbx9GD1f85SvhNMNDIM0LXyKbn53Qyvk05fteSfrxdA
         y6OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s3Rqo1v6hR+TdyWW7XUj7JPG85R7AE1P0AsDsVJK07E=;
        fh=ZBj0AVMkRlbs0bo2uwsupkwH4CA87aofo/MRqPJc7Xw=;
        b=iNU6G4CFlP9B9nkwPjISEjNSWkdY5UQAA6pVY5fnHiJNjxQRvoFtcD6UGZ9g/vUiUD
         kJigPoJwQu7wmhDEx3bIuRvPbYBFixTP/JbOmdgq4HDiZ36xIrnuhHioAwik2v1F1QFN
         d9LJqGQZan913Ye/XxUeDP2dWhxzkvhqD7vvmyRL+mf2A6Q7Vx7aXAnvAsAdqMFzq8ZD
         0BfqUUZuuvL6DTrNZcO4NDerM9LADsib1r6mAHIrupe7O60+JhCf32O1G1SMvJWNo+hA
         LFpWRpUTavTZPNU8um93PUrBi+/WZkTGQ3tLSIh+d6O784MBvzXlGNSCcMxqgNcr4cXn
         sHgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782313947; x=1782918747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3Rqo1v6hR+TdyWW7XUj7JPG85R7AE1P0AsDsVJK07E=;
        b=alFZs241whxcYE7zxCK7VJi5vgnIIyadeWg43vc0V1eTlcOHIpQ7gEXY51vVlYONFV
         BQ2UDYu8sOS3Xl2YESDkFuUQ6SyQHOyB/XSfHxAfugCW78AxxHYaRbRS77b1VDEaayJ9
         vVk2dpHOm0D1RVO9sRkzaS75iH8Ruq6eOa2wNxNHMpUtgU5G4NO0SWlWRb5WNGPZpW6v
         owx+SCl+7KnT69uw6ykSZq5Y+CF+HZGSbqIm3oBIEw5fldIIOy1qbbhOvYK+gUTJUXep
         Mk0FYXE5dZnUVQjIFrm9pJ8cR3ofrrQKpaJlQMPS+pVRFnmcaXFg5yrqXgW+cDevryiv
         15Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782313947; x=1782918747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s3Rqo1v6hR+TdyWW7XUj7JPG85R7AE1P0AsDsVJK07E=;
        b=P1Si/Ea4DW06ULlL8bBdCKRQFjwkfirhmS0jeoNEBxFLrB1FZrQSkyginWdPYAnWrv
         JDj4MBYTDNDiw7JdEpkX2rMzufrzH3ctW1Ist7XSus35TBYv6BMZFQLGzE1RhFdiaHDf
         V0rOAViWLDmAbXq7Eyuv3eaZPDoihMt1lTOzJbxHEvyVn+smoGoy04vf70ZdlL1SilrR
         LYUwXP7a+gx5eIW1BUiIrtGLiOWxXu2Y4nvIKwQUyNqdsf7TPyIjnnv+YbFi0Lzz1Scq
         LKFihyGjKGgkF5kVox9n3C3LLV6HxUp5OVimDlvpKlfK5/dc1WSGZ3IC64ddx4ekfVJ5
         UDuw==
X-Forwarded-Encrypted: i=1; AHgh+RoCY345xaIeg5feQUnINX/MSaNN9MG71MhetpAJlNqw77mpg02aMgJpGeRV63HcD9fzJ6bUjqmOWJ1TeQf/WswRwIeWGDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF8fCKcrrn9NAR3jQBOkXGFG6meEdPwiF8oZ8oyRT2cD6cDS0z
	L5uqcbn4Qf3CHOetKAodK57RDJRw74bLO4GiP3g563XZ4MStKWS7RbW/npoSHM3WekCvd2Qms8z
	KWvgBwDw/cwM6hRbgP4E8kVHBKrfYKuwWt7ddwZqg9OiSLZiOpF5pew==
X-Gm-Gg: AfdE7cnsEgmnUn6W2PhMjJbGlcoCqus8tsjhPUe09Vx61JGhBOH/9Y8y9aWWoJayUVh
	X0jH6KkLLpiMGSsMErDbWF6Rq82iQzSBxrK5o9ATrBbTeiv2YIjxjDvMPzZeuMqJP4NI58f+fjM
	aDcX9EddYOWxcbKRo1XUf8mYG5QU8/Utb8ZihOSAzR/NksEel8jujHs+EeRJfyVtQTzvAgTkeWS
	83hWzPJqtBkcFcF+jglSub/ZYPTR/6VLVqMdgaLda3t58BMkrTZ/YlEdPl5qEX9lydUcX3W
X-Received: by 2002:a17:90b:5343:b0:368:b724:6d53 with SMTP id
 98e67ed59e1d1-37de429f69bmr3852431a91.4.1782313946844; Wed, 24 Jun 2026
 08:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624140301.93421-1-daniel@iogearbox.net> <20260624140301.93421-2-daniel@iogearbox.net>
In-Reply-To: <20260624140301.93421-2-daniel@iogearbox.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 24 Jun 2026 11:12:15 -0400
X-Gm-Features: AVVi8CcBJpd-Njskh1XOODL-o6qJSUPZuS3j9bS26ldP6j8TVq--D1Lg4wJzJqU
Message-ID: <CAHC9VhRar1x7kyjhgdmJ=Mfz4Msarv=wQ1821v723CaVdk1uTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Verify signed loader metadata at
 load time
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, kpsingh@kernel.org, James.Bottomley@hansenpartnership.com, 
	bboscaccy@linux.microsoft.com, memxor@gmail.com, 
	torvalds@linux-foundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 10:03=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
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
>
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
>  kernel/bpf/syscall.c         |  76 +---------------
>  kernel/bpf/verifier.c        | 163 ++++++++++++++++++++++++++++++++++-
>  3 files changed, 165 insertions(+), 75 deletions(-)

...

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index b44106c8ea75..026b61d78bdb 100644
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

We must preserve the existing location of the call into the
security_bpf_prog_load() hook as some users rely on this hook being
called *before* the verifier runs.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2abc79dbf281..9cd2b62da380 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19758,11 +19895,28 @@ int bpf_check(struct bpf_prog **prog, union bpf=
_attr *attr, bpfptr_t uattr,
>         ret =3D bpf_vlog_init(&env->log, attr_log->level, attr_log->ubuf,=
 attr_log->size);
>         if (ret)
>                 goto err_unlock;
> +       if (env->check_signature) {
> +               ret =3D bpf_prog_calc_tag(env->prog);
> +               if (ret < 0)
> +                       goto skip_full_check;
> +       }
>
>         ret =3D process_fd_array(env, attr, uattr);
>         if (ret)
>                 goto skip_full_check;
>
> +       if (env->check_signature) {
> +               ret =3D bpf_prog_verify_signature(env, attr, uattr.is_ker=
nel);
> +               if (ret)
> +                       goto skip_full_check;
> +               signed_map_cnt =3D env->used_map_cnt;
> +       }
> +
> +       ret =3D security_bpf_prog_load(env->prog, attr, env->prog->aux->t=
oken,
> +                                    uattr.is_kernel);
> +       if (ret)
> +               goto skip_full_check;

We can always create a new LSM hook for this call site, e.g.
security_bpf_prog_verify_signature(...).

>         mark_verifier_state_clean(env);
>
>         if (IS_ERR(btf_vmlinux)) {

--=20
paul-moore.com
