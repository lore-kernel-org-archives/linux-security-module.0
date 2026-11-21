Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795220447;
	b=y0FlAFTpj59FJB+mmujNzN+GicYIO22B4TzsehZZX7So8fHEHGZapUe/COB5/x2pGQbv
	 FdtCgUPa6gMGUpft6Q0jIwkzNJ/SchteXikgnyUxZMUVqQqDkkaS5g4XdUR663imJ1WgR
	 OlpScJNpXz6V8XIHIOOeWXyfPho8V08SzYb/JUrrxhshlE6KARVjIwD4IubBLXuVu1erU
	 1CsgxcaueLektJHBKZ9iMfdvhsw067bLBULmiQRAOlrp8yz4QAKn4S9HpSAeHlJuc+m17
	 TMsLN+d6X6IDFi+JkuGtwty7eLUDSyliMZkzmpBpOKXFXBtRNauB7grZVMLtCCLRKYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795220447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oTW1ECUqKZPFZMGwmFF0XG/dMWrRIOOKKmtz6Ts2T3U=;
	b=rIvx4XlmXNQVqcthWDSRWudrlx12/g3aBEtjY2T5wm4eJ/F+cQ/mnBGiGiAJSofLZLx8
	 noxJEQ4JS+MMV0yV0KTarHPoNDk5VZASdulAMIU26foYAsyOFEUmmvnTynJkBEig/SN+E
	 NBrR9dk4TdNZZqj+hLMxz0Iqr0m26nyCwJWOflvMT2STuIxTPs5oiVVh+MzpHwJdhmcII
	 BYogag0Cmj8dR/tcz/C66PgZT53yFlxe3Y0C0LtvHoRXyDm7pvYexCreYqNtomE+hoc9H
	 NRHBG9pVUK1nXUMZ1fLLuRenTAPe7I8m9wy4J8RdTsVJn3gujdfrbBGQ4IXFxVovyjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=LklpZjfD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5051A606A6A5
	for <linux-security-module@vger.kernel.org>; Sat, 21 Nov 2026 00:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5051A606A6A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=LklpZjfD
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f0481b35c9so7289745ad.0
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 16:20:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795220442; cv=none;
        d=google.com; s=arc-20260327;
        b=jTOJKNmck6GG+/FrQz2fSQNeg4MKNeXrpxSfIaki50rxR1TDg3s5Rv0QIvtc1zCV8E
         UEkPDV1HpIvBntQqERhJRmOb9Z8V51iyZl41/qQ5oTWGiG13/nlBFx6g23Cwz3fhzXSj
         SsxWBaJ5XZte5Bhp7p2naqdTFN5PcEgadgtu7Y8eeORdigmMz6g+h2sxoULr2lJHx73K
         mVyBArwGRgmXgULuBjGLdUIRPxdKqXhlgaY0y4arbshLIVgrLFqyG357nsC5cRkEWf5h
         VsRXRHWMLoRtuJ302Hezk1EXqPW1c44cS9lt+RvD4GjGVC+/wG64z21frfgoZ05uYmda
         n7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oTW1ECUqKZPFZMGwmFF0XG/dMWrRIOOKKmtz6Ts2T3U=;
        fh=J4vZsYgbKCpK1Zrpjclq+KVbaZxjgWWdTDHqdjGnAJ4=;
        b=T6iNJkH7HfAdudYXGPcpgfFGLZZuviGcGcdqi9V7F4JEqKHpnJsImZ36LEbPwjREFr
         +u7DvLwJHg7g1PMHsC83Q4AZyDn7DHPfOLUhgJOCD2qz/8y+xETarzdYJSWg+uNDPuPw
         wc51wayNVBfW0xPE33Ea1iEtzBA6MZ9Xu5hhtPIZitWFFIQxBwEbiTFFdI8sRInsG2aJ
         znR9BoTfZ5bZ8T1yCBYHnI3OpRxLC+FQflO/30ZBiUb/zbHOW1n0I+WQufZBas2opqef
         vvjSS7RhoCHvSYMZ64TwnIW95PX+JNTqgWw5a25zuy0tul3b+iGGVp2EXSwSyvKfLJsk
         olHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795220442; x=1795825242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oTW1ECUqKZPFZMGwmFF0XG/dMWrRIOOKKmtz6Ts2T3U=;
        b=LklpZjfDtnvNwzndHIjW8ZNQ8zMlt3I98Fdj6dWCKzaDJHMX2vBYb0r30EuTxy9M06
         eQGhuC7Yd00TmtaxH7l61w5nkPpoOIydtVskUsiv/RWg/4GHNeQZO7yXThSxIg/cMJvq
         s55skHl3XgM2Hjtfb2lXYxlXe5AyNPaWs8TDCRw2j2xcvkU6RSPUD6Qj2LEElOHa+vRt
         Ke+/y0j0acY9FV8MnSNLvTrorvLnJ9CFyO7xdWgnxq4unh+56/00JLLA9wfiUbOJAafX
         uJk0bi/Qov+0va5b24OMN8H+By8PZUz/+csFTkmKtGJ2Y66fsZIybqh8WSdpGQQaP42R
         PWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795220442; x=1795825242;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oTW1ECUqKZPFZMGwmFF0XG/dMWrRIOOKKmtz6Ts2T3U=;
        b=S7hh6BrdbxRhThbFTTUbngj2JO0bMe7/+z8PEkd9MedsUgrXgWW5Z9GxAmAVROa2D8
         AKKKMMCCs7GJk9ZbEMu2/bVREnzcoiH1uy6F4s9MwpNVw91RpkfoOEwwQ5Nsem+auTbc
         2mXgAtVNenRaxHwCgjrZOhAS4ncy57mXMTOQLzxG9RcwFEl7xadIXRUfM8l0pQYTrPdc
         XTuOkrJrXN7bt8yUIM0ttdUAlsowwwHLL3TP4TZ/sCW06k1VZEddczGnynOW3KaX60Ho
         VGSNGi+9frXrD3hJNazIzYGtcZA1Bv/fRBH4f7cM28ehAxLOixRBcVdthF2SrfnNHgaV
         bygw==
X-Forwarded-Encrypted: i=1; AL+hErHxqj2ie75Hq4aDFLpet1pBBKfnd0qKIgXUSvschJuLcinjFnN93gY4OavWHBT5vR9MJJ1MTJ/NaPmVINIDhZayUoZa0FI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9eB4YN0Jhz+FtMhtmEjcJr2FiZrlj2+xLnxKZ05QDer5/hZvpL
	8d4BWHdVHf3S6fUYuySlgom/eyoZsrg7Vj1xF/fd5nSn+7qoPH8k1p9ZTCf0SghEWXIE1L8KLLX
	jo7han06EVjNEyr8JrPlK2+YmTtZUSwrbzrA40qbQ
X-Gm-Gg: AZFdTZcGwxrTxDyhfbmd0UQVucA6xuMm8SZ0Sjxt8KMU3tjGMfpr0cYbs+R+95qgFU7
	xGuPn14ALoMrEXI0GvH/mm4DeXbOvaMNVaPg0rvRDr185H/Y0+W97f74A92XVgvS3grpge+JowH
	vX+iqs5AtumJNdikB+PTN8QPHvOwuS4TGHz8sRa1C+1XdZtaBOeUzxTU6Tdslr7xRCnyfvKh52k
	R4S5asBPIHHNQdcEjRDyQ3ZbbY/PHez4/bE14J02pnXPKx85hOZUIVpLMtj/vnNqFEbFpxCPtIu
	jeGLvuooBYsyxq5QICU3QBbGZyUjfSuLURH5zZ3q63imJYWTJyDYJXmRaqObmo6dnLb5NMwX/yv
	CA0G6ChiqKKnDKv3J4BXha14GML6g2ml8BqwJ8fgLiwNLYNoo7Z7zsW22nWUobbp8lxM+
X-Received: by 2002:a17:902:e811:b0:2f0:22b2:bfe2 with SMTP id
 d9443c01a7336-2f03f201151mr45499255ad.31.1795220442596; Fri, 20 Nov 2026
 16:20:42 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120-work-ns-mount_subtree-v1-0-06337377f94a@kernel.org> <20261120-work-ns-mount_subtree-v1-2-06337377f94a@kernel.org>
In-Reply-To: <20261120-work-ns-mount_subtree-v1-2-06337377f94a@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 20 Nov 2026 19:20:30 -0500
X-Gm-Features: Aa3M54rUKAyhudO_NMmwLoQSP6nA25xTN_t_G9kBgfIIkvZyJM13Qz-1vfwego8
Message-ID: <CAHC9VhQrbBEX7tHtCUSPGgUqLLObCdBCRPkNLgDdtcgxTC3V_w@mail.gmail.com>
Subject: Re: [PATCH 2/2] ns: don't call the namespace LSM hooks for
 kernel-internal namespaces
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, bpf@vger.kernel.org, 
	Zhiqi Zhang <zhiqizhangg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 7:30=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> mount_subtree() allocates a private anonymous mount namespace so that
> automounts triggered while it looks up the path have somewhere to go.
> That namespace never becomes anyone's namespace and it's gone again
> before mount_subtree() returns. btrfs goes through it on every mount:
>
>   btrfs_get_tree()
>   -> btrfs_get_tree_subvol()
>      -> mount_subvol()
>         -> mount_subtree()
>
> and NFS on every NFSv4 mount and whenever it follows a referral:
>
>   nfs4_try_get_tree() / nfs4_get_referral_tree()
>   -> do_nfs4_mount()
>      -> mount_subtree()
>
> But __ns_common_init() calls security_namespace_init() for it like for
> any other namespace. Since commit 15dd86021b57a ("landlock: Enforce
> namespace use restrictions") Landlock enforces
> LANDLOCK_PERMISSION_NAMESPACE_USE in its namespace_init hook. So a task
> in a domain that handles that permission without allowing CLONE_NEWNS
> can't mount btrfs or NFSv4 anymore. mount(2) fails with EPERM even
> though the caller never asked for a mount namespace.
>
> Mark such namespaces as kernel-internal and don't call the namespace
> LSM hooks for them at all. That includes namespace_free. Currently
> security_namespace_free() only calls the hook if an LSM requested a
> namespace blob and none does. But we shouldn't rely on that. Otherwise
> a bpf program attached to namespace_free would see namespaces go away
> that it never saw being created.
>
> The anonymous mount namespaces created by open_tree(OPEN_TREE_CLONE)
> and fsmount() are handed to userspace and keep going through the hooks.
> Landlock covers them on purpose.
>
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Reported-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
> Closes: https://lore.kernel.org/20261114141323.19029-1-zhiqizhangg@gmail.=
com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/namespace.c                     |  9 +++++++--
>  include/linux/ns/ns_common_types.h |  2 ++
>  include/linux/ns_common.h          | 20 +++++++++++++-------
>  kernel/nscommon.c                  |  9 ++++++---
>  4 files changed, 28 insertions(+), 12 deletions(-)

...

> diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> index 4438c6b663f91..20fc0d0e98212 100644
> --- a/kernel/nscommon.c
> +++ b/kernel/nscommon.c

...

> @@ -66,6 +66,7 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type,=
 const struct proc_ns_ope
>  #endif
>         ns->ops =3D ops;
>         ns->ns_type =3D ns_type;
> +       ns->ns_flags =3D flags;
>         ns_tree_node_init(&ns->ns_tree_node);
>         ns_tree_node_init(&ns->ns_unified_node);
>         ns_tree_node_init(&ns->ns_owner_node);
> @@ -85,7 +86,8 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type,=
 const struct proc_ns_ope
>         /* Allocate the id before the LSM hook so it can track the namesp=
ace by it. */
>         __ns_tree_gen_id(ns, ns_id);
>
> -       ret =3D security_namespace_init(ns);
> +       if (!(flags & NS_COMMON_KERNEL))
> +               ret =3D security_namespace_init(ns);

We try not to make calls into LSM hooks conditional whenever possible,
preferring to leave that up to the individual LSMs.  In some cases it
isn't possible due the state used for the decision not being visible
in all of the cases where it is needed inside the LSM, but in this
case the flags/NS_COMMON_KERNEL state should already be present in the
ns_common variable passed to the LSM hook so we should be able to drop
the flags check and always call security_namespace_init(), letting the
LSM decide how to handle NS_COMMON_KERNEL namespaces.

The LSM could make a similar decision in the security_namespace_free()
hook below.

The update to Landlock's hook_namespace_init() should be as trivial as
the check here.

>         if (ret) {
>                 if (!inum)
>                         proc_free_inum(ns->inum);
> @@ -106,7 +108,8 @@ int __ns_common_init(struct ns_common *ns, u32 ns_typ=
e, const struct proc_ns_ope
>
>  void __ns_common_free(struct ns_common *ns)
>  {
> -       security_namespace_free(ns);
> +       if (!(ns->ns_flags & NS_COMMON_KERNEL))
> +               security_namespace_free(ns);
>
>         if (ns->inum > MNT_NS_INO_SPECIAL_MAX)
>                 proc_free_inum(ns->inum);
>
> --
> 2.53.0

--=20
paul-moore.com
