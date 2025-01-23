Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B7914831C
	for <linux-security-module@vger.kernel.org>; Thu, 23 Jan 2025 19:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661411; cv=none; b=QxCowypqVRdjOKbdSrAdlVkB6KyE4OlXYJ4XHCog3kvTUAcyJJx31PqzRQlcH4dYMl+K97D8A1P7f3rgEqZqwAdfsrwK/A2dNKDaW8WRK5X4wZA23KyEzJ87pDPqye8agwCBFoPlAssWZxcR7fxUmvs3xL3aD2AOd5es0C3r6sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661411; c=relaxed/simple;
	bh=osFgS1FPrdyhcOqKyG8ns3tnqrPedisXTV0jl6rcItQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkkaO4JH4GZ+a4vHMCITBhztPH0bREpDP2PrG2Iksi8AiYcvvcSxj7BsET1ZWqlo80vUMvUEHmANloJqit5z/hFvx0IZh5SUH2KTXEc39KwLkpXLTB9C1frqR6cMfw0u7dwdSey8Ir0tYxjMA5j5BRuwBsBSrWNtldpNAkWJ59I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=H1wQljX9; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="H1wQljX9"
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BB0363FB64
	for <linux-security-module@vger.kernel.org>; Thu, 23 Jan 2025 19:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1737661405;
	bh=MFEb+jSUKHGrACcVDUQEDS+ei4EXcNiR2sfKcmdnXzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=H1wQljX9ivUxDcmcuGIQggiIc8m5iPTVJWuJwuV0VXKSj12gQKScfhGYwWyU0lfxC
	 yG5jNIEbkw/ChdcmW1EcD4diXxdQfRdr5qcM2I6o1QeQU2g3Fvl4ryCuNTdJeGzwv+
	 BXz2RAJA3QoSmNQfM0qftEpPx2MruPfbD/uiWF/0QOqDFuCCtNZrqCqiYqz2ZRVC/Y
	 3Fd76TvlZCQ5eRs2a++yFhg16w6D2dkWIK5+wIc5KLAPuG08MpU1wpEAC9mpjw3jq8
	 or5/WLBy3SFXA8CxwFvphC5havQlG/JXa608UPF5E2rwkzqkA7ylLMx+Qiq9s2mrXN
	 YXsVZ9tAanl+A==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa6704ffcaeso131988666b.2
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jan 2025 11:43:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737661402; x=1738266202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFEb+jSUKHGrACcVDUQEDS+ei4EXcNiR2sfKcmdnXzc=;
        b=RWcrK4+6FD9knjZbGkTGaQjcg1HSwwNkUuilx/RS5YjoJsNM8z53Dl+rWyPe/c62HA
         OeLG/ehRijsQZqjDSfvIZAvMi11/qE/Vvl2a/I7y4AlvJIfpgcj772Svx5V5zVOq/3BS
         90l10BcD20WrMfwEhpjDY/bkj0uX7mGVo2YtfRSJXY1tLtKUP3jWO8gdRGJRnd9iKNRi
         WaoaWyk6WBAnBtJ7ow/vpWbStddHycLDTNZUv5N7ShIG+qKEHNWwhCib0iqGgCVaJoDp
         QB4EHOIVNjhYkwZ4/4rISOWWFBBbSDmsATwZ0+DM99MFy4UxNfJwZmmcBTONtuyNsbKH
         4TUA==
X-Forwarded-Encrypted: i=1; AJvYcCXEGxbv/J6P8eaQk81T0LXzID+lbVtd8Ngy7GWjdwKiVOY7CiDKT3ELnFTf3HeHgAYTn8p+HZif3uCWIw56D09QvPiPpfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxiZ4LE1SD5xbGbcCevHXhf9+q/SXvw0+LYeoJfI2EW/fY9uai
	+EQAQE4qN1PRG0eWEJSXCJD815oWyJYDcZKMhKVWzK2Meee2HTUZoK7cWeraxGCR4TPrN0HhP9z
	C+2H2VWaGS3NC2SUZo/XJz6DUvK7XU5KdMo/hx8RvL7cmdgZmX+hUfogyLZd5dUbbzegpq+7yjY
	bIynYuPMsxrMCRAxuNK+FS289FudZO9MtEla1Pd3moqrj1x9AeVzlbfQ8S6O0rjjiY
X-Gm-Gg: ASbGncu+/6cjjrHV3/H8h0ml0+phSk8E/kND2SGDEJgEDIO+0CD92Pfj6qirxinFDjC
	kRft0zHsBKd0tp5kPsUmFGXFggT+U4VXRzZErmzsHRb8avb78Mg==
X-Received: by 2002:a17:907:7ba8:b0:aa6:7c8e:8087 with SMTP id a640c23a62f3a-ab38b1b4669mr2508907866b.12.1737661401636;
        Thu, 23 Jan 2025 11:43:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaQlMp5FTCYi/neDeOQYo+So63fMDIzARzvqiMW7urZaWlrE67uGrWBic3XOHPgZ/MwwBQbNDR539YPrdquIw=
X-Received: by 2002:a17:907:7ba8:b0:aa6:7c8e:8087 with SMTP id
 a640c23a62f3a-ab38b1b4669mr2508905366b.12.1737661401267; Thu, 23 Jan 2025
 11:43:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123192058.2558-1-tanyaagarwal25699@gmail.com>
In-Reply-To: <20250123192058.2558-1-tanyaagarwal25699@gmail.com>
From: Ryan Lee <ryan.lee@canonical.com>
Date: Thu, 23 Jan 2025 11:43:09 -0800
X-Gm-Features: AWEUYZngTXPGMoeyAfN22iSJQ2hdBPmkPmu8W9oGAU2fHIWnuUexnzyL8gzKv7U
Message-ID: <CAKCV-6swo49thNAsmBWPwM-foK=L2CFphLJxePC+WE5Ou1oBbg@mail.gmail.com>
Subject: Re: [PATCH] apparmor: fix typos and spelling errors
To: Tanya Agarwal <tanyaagarwal25699@gmail.com>
Cc: john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	anupnewsmail@gmail.com, Mimi Zohar <zohar@linux.ibm.com>, 
	apparmor <apparmor@lists.ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Ryan Lee <ryan.lee@canonical.com>

On Thu, Jan 23, 2025 at 11:30=E2=80=AFAM Tanya Agarwal
<tanyaagarwal25699@gmail.com> wrote:
>
> From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
>
> Fix typos and spelling errors in apparmor module comments that were
> identified using the codespell tool.
> No functional changes - documentation only.
>
> Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> This patch set is split into individual patches for each LSM
> to facilitate easier review by respective maintainers.
>
> Original discussion:
> https://lore.kernel.org/all/20250112072925.1774-1-tanyaagarwal25699@gmail=
.com
>
>  security/apparmor/apparmorfs.c | 6 +++---
>  security/apparmor/domain.c     | 4 ++--
>  security/apparmor/label.c      | 2 +-
>  security/apparmor/lsm.c        | 2 +-
>  security/apparmor/policy.c     | 4 ++--
>  5 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorf=
s.c
> index 2c0185ebc900..0c2f248d31bf 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -43,7 +43,7 @@
>   * The interface is split into two main components based on their functi=
on
>   * a securityfs component:
>   *   used for static files that are always available, and which allows
> - *   userspace to specificy the location of the security filesystem.
> + *   userspace to specify the location of the security filesystem.
>   *
>   *   fns and data are prefixed with
>   *      aa_sfs_
> @@ -204,7 +204,7 @@ static struct file_system_type aafs_ops =3D {
>  /**
>   * __aafs_setup_d_inode - basic inode setup for apparmorfs
>   * @dir: parent directory for the dentry
> - * @dentry: dentry we are seting the inode up for
> + * @dentry: dentry we are setting the inode up for
>   * @mode: permissions the file should have
>   * @data: data to store on inode.i_private, available in open()
>   * @link: if symlink, symlink target string
> @@ -2244,7 +2244,7 @@ static void *p_next(struct seq_file *f, void *p, lo=
ff_t *pos)
>  /**
>   * p_stop - stop depth first traversal
>   * @f: seq_file we are filling
> - * @p: the last profile writen
> + * @p: the last profile written
>   *
>   * Release all locking done by p_start/p_next on namespace tree
>   */
> diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
> index 5939bd9a9b9b..d959931eac28 100644
> --- a/security/apparmor/domain.c
> +++ b/security/apparmor/domain.c
> @@ -755,7 +755,7 @@ static int profile_onexec(const struct cred *subj_cre=
d,
>                 /* change_profile on exec already granted */
>                 /*
>                  * NOTE: Domain transitions from unconfined are allowed
> -                * even when no_new_privs is set because this aways resul=
ts
> +                * even when no_new_privs is set because this always resu=
lts
>                  * in a further reduction of permissions.
>                  */
>                 return 0;
> @@ -926,7 +926,7 @@ int apparmor_bprm_creds_for_exec(struct linux_binprm =
*bprm)
>          *
>          * NOTE: Domain transitions from unconfined and to stacked
>          * subsets are allowed even when no_new_privs is set because this
> -        * aways results in a further reduction of permissions.
> +        * always results in a further reduction of permissions.
>          */
>         if ((bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS) &&
>             !unconfined(label) &&
> diff --git a/security/apparmor/label.c b/security/apparmor/label.c
> index 91483ecacc16..8bcff51becb8 100644
> --- a/security/apparmor/label.c
> +++ b/security/apparmor/label.c
> @@ -1456,7 +1456,7 @@ bool aa_update_label_name(struct aa_ns *ns, struct =
aa_label *label, gfp_t gfp)
>
>  /*
>   * cached label name is present and visible
> - * @label->hname only exists if label is namespace hierachical
> + * @label->hname only exists if label is namespace hierarchical
>   */
>  static inline bool use_label_hname(struct aa_ns *ns, struct aa_label *la=
bel,
>                                    int flags)
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 1edc12862a7d..04bf5d2f6e00 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -2006,7 +2006,7 @@ static int __init alloc_buffers(void)
>          * two should be enough, with more CPUs it is possible that more
>          * buffers will be used simultaneously. The preallocated pool may=
 grow.
>          * This preallocation has also the side-effect that AppArmor will=
 be
> -        * disabled early at boot if aa_g_path_max is extremly high.
> +        * disabled early at boot if aa_g_path_max is extremely high.
>          */
>         if (num_online_cpus() > 1)
>                 num =3D 4 + RESERVE_COUNT;
> diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
> index d0244fab0653..5cec3efc4794 100644
> --- a/security/apparmor/policy.c
> +++ b/security/apparmor/policy.c
> @@ -463,7 +463,7 @@ static struct aa_policy *__lookup_parent(struct aa_ns=
 *ns,
>  }
>
>  /**
> - * __create_missing_ancestors - create place holders for missing ancesto=
res
> + * __create_missing_ancestors - create place holders for missing ancesto=
rs
>   * @ns: namespace to lookup profile in (NOT NULL)
>   * @hname: hierarchical profile name to find parent of (NOT NULL)
>   * @gfp: type of allocation.
> @@ -1068,7 +1068,7 @@ ssize_t aa_replace_profiles(struct aa_ns *policy_ns=
, struct aa_label *label,
>                 goto out;
>
>         /* ensure that profiles are all for the same ns
> -        * TODO: update locking to remove this constaint. All profiles in
> +        * TODO: update locking to remove this constraint. All profiles i=
n
>          *       the load set must succeed as a set or the load will
>          *       fail. Sort ent list and take ns locks in hierarchy order
>          */
> --
> 2.39.5
>
>
