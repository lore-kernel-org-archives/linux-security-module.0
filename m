Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F7C155726
	for <linux-security-module@vger.kernel.org>; Sat,  9 Nov 2024 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731176469; cv=none; b=BHxR7vwlbo+6nfGxXIMg5Sh3FYgQ6xGUNe5STtzKhLTnBcdrL+UF5fPnDKxa6G3oGHdSxIru0nC4fh8+1VRgxyvc0+Xj0je748FtwW7pqlgRROlqobaAlRtj4/KpPxidRXK2zgtDOMCgPSr0pbNkP1sN1tWZqzgjffraG4citk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731176469; c=relaxed/simple;
	bh=031V61GOOuZQ6f4yzTT/RVvJGhBxzStp7hjGCx2mZ1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QjTbtmbA6jLKMpWk2hxKhRauVN5Om4q5REwydbCANtWh/xmfQtPd17Qu9gQ91itN2zV1rLQqEU7XuQ5gcRMPWvO4n67Tidc12N67/ASwHroUmkVOHyhauwxd3NbhMIFCkvfYkHMoc0uHX7ZyNi+rZBO7tIoLrmQlBBnAVkJ9jho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sxg6nde7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sxg6nde7"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3705b2883so59547267b3.3
        for <linux-security-module@vger.kernel.org>; Sat, 09 Nov 2024 10:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731176467; x=1731781267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WZm4zOdQPk/gl5Fm+rWhsvSV6lR1UrJEcLk8HK/YaY8=;
        b=Sxg6nde7K2Qa/NYscsQp9qPUur5eZR4BT+PHdXS+Eeh7Ji30bHynPXboVjfFXdSKKB
         MHWkM3nkxBiJ9j8/gAbPH3oGb5lJZDtNsSCxigd56sEQG+xg5FR3PAGszCXyQa1XOV56
         LU/IETJ483sG3H5mP57EtnJYZpUHu/zRlq+Ht7082m+qLbuDGbApr3MwqCGtp0kj/xrl
         bkBGzzWI4qr5r1jc3zA70LoQI+b4lXgqEvSfdm5ulyfPcYDJAD2oqsJEA2lKYXuo5aMA
         Pw2ZrkXaJmPJjQNrT3SYH7WE5KsWY0cH9nKYtR3PTMQ3+QCdD4ZhGZq19wD2XIvxoMW1
         gkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731176467; x=1731781267;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WZm4zOdQPk/gl5Fm+rWhsvSV6lR1UrJEcLk8HK/YaY8=;
        b=uTphakgsqOYPcMwam159H4cEy5rbn+UiA3apOBErL7aH4yCWhJVae3atj7Dkb6QBTb
         Kj1EYhvJfW6KENYhF8/Pq3t6vlLcMvb6AKD4OTdhMEqIdZk72HJ8Nqsqmr88pxg9xxsg
         Dun0PB5w0TNhLPf5y+cN+emMiKGKokR/tWicIBfEAv/sVjjJHTn5ZTbW7VjfzykJ75yf
         G90j8cLJNNOSsmtwi5mVAB7UVikfhW1yGVhOm8Pe3vHr3AFbJuVHXxSmOP1S3XGWp1Gy
         KtoHXNZeXxRMFjAf07rwoZUDMYPBnSGMCnAB+I0XyOEvjV/axi9HPGy2R958vFLT52Ti
         CYng==
X-Forwarded-Encrypted: i=1; AJvYcCUvgARKYy9cBXZQSQopE9DBFblrLQCCDVdo9qGH+1b9b7MX57s/tQKDci478KNbG6ogUaRHy+wvG9kmI3PGqeOilorBFac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrUNKDODGFGt+aiuEm98gpSptp8SwHB5ogpkE2gvpezC76utYd
	mKkm8sIppHIIyDdeKF7k0Z+21cDV1JNbVP8Ng/L8gHvmxG+h/ftPChwiF2BaWzbYgEIyYoUMmPN
	nxA==
X-Google-Smtp-Source: AGHT+IHwZgcUvCEqWT+9ZrzZsKLKKfE4/kNAK2Bhx/AU5XfEfIKoXR+BK5HdcT6VG6auFJBvp6yVki8isfc=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:690c:338e:b0:6dd:fda3:6568 with SMTP id
 00721157ae682-6eaddf7e61emr582317b3.3.1731176466828; Sat, 09 Nov 2024
 10:21:06 -0800 (PST)
Date: Sat, 9 Nov 2024 19:21:04 +0100
In-Reply-To: <20241109110856.222842-2-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109110856.222842-1-mic@digikod.net> <20241109110856.222842-2-mic@digikod.net>
Message-ID: <Zy-n_GtpJPV-5LrB@google.com>
Subject: Re: [PATCH v4 1/3] landlock: Refactor filesystem access mask management
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Paul Moore <paul@paul-moore.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 09, 2024 at 12:08:54PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> Replace get_raw_handled_fs_accesses() with a generic
> landlock_merge_access_masks(), and replace get_fs_domain() with a
> generic landlock_match_ruleset().  These helpers will also be useful for
> other types of access.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241109110856.222842-2-mic@digikod.net
> ---
>=20
> Changes since v3:
> * Rename landlock_merge_access_masks() to landlock_union_access_masks(),
>   suggested by G=C3=BCnther.
> * Rename landlock_match_ruleset() to landlock_get_applicable_domain(),
>   suggested by G=C3=BCnther.
> * Rename the "ruleset" arguments to "domain" for consistency with these
>   new helpers.
> * Use typeof_member(), suggested by G=C3=BCnther.  Also include kernel.h
>   (instead of the new container_of.h to ease backports).
>=20
> Changes since v2:
> * Create a new type union access_masks_all instead of changing struct
>   acces_masks.
> * Replace get_fs_domain() with an explicit call to
>   landlock_match_ruleset().
>=20
> Changes since v1:
> * Rename landlock_filter_access_masks() to landlock_match_ruleset().
> * Rename local variables from domain to ruleset to mach helpers'
>   semantic.  We'll rename and move these helpers when we'll have a
>   dedicated domain struct type.
> * Rename the all_fs mask to any_fs.
> * Add documentation, as suggested by G=C3=BCnther.
> ---
>  security/landlock/fs.c       | 31 ++++-----------
>  security/landlock/ruleset.h  | 73 ++++++++++++++++++++++++++++++++----
>  security/landlock/syscalls.c |  2 +-
>  3 files changed, 74 insertions(+), 32 deletions(-)
>=20
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 7d79fc8abe21..e31b97a9f175 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -388,38 +388,22 @@ static bool is_nouser_or_private(const struct dentr=
y *dentry)
>  		unlikely(IS_PRIVATE(d_backing_inode(dentry))));
>  }
> =20
> -static access_mask_t
> -get_raw_handled_fs_accesses(const struct landlock_ruleset *const domain)
> -{
> -	access_mask_t access_dom =3D 0;
> -	size_t layer_level;
> -
> -	for (layer_level =3D 0; layer_level < domain->num_layers; layer_level++=
)
> -		access_dom |=3D
> -			landlock_get_raw_fs_access_mask(domain, layer_level);
> -	return access_dom;
> -}
> -
>  static access_mask_t
>  get_handled_fs_accesses(const struct landlock_ruleset *const domain)
>  {
>  	/* Handles all initially denied by default access rights. */
> -	return get_raw_handled_fs_accesses(domain) |
> +	return landlock_union_access_masks(domain).fs |
>  	       LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
>  }
> =20
> -static const struct landlock_ruleset *
> -get_fs_domain(const struct landlock_ruleset *const domain)
> -{
> -	if (!domain || !get_raw_handled_fs_accesses(domain))
> -		return NULL;
> -
> -	return domain;
> -}
> +static const struct access_masks any_fs =3D {
> +	.fs =3D ~0,
> +};
> =20
>  static const struct landlock_ruleset *get_current_fs_domain(void)
>  {
> -	return get_fs_domain(landlock_get_current_domain());
> +	return landlock_get_applicable_domain(landlock_get_current_domain(),
> +					      any_fs);
>  }
> =20
>  /*
> @@ -1517,7 +1501,8 @@ static int hook_file_open(struct file *const file)
>  	access_mask_t open_access_request, full_access_request, allowed_access,
>  		optional_access;
>  	const struct landlock_ruleset *const dom =3D
> -		get_fs_domain(landlock_cred(file->f_cred)->domain);
> +		landlock_get_applicable_domain(
> +			landlock_cred(file->f_cred)->domain, any_fs);
> =20
>  	if (!dom)
>  		return 0;
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index 61bdbc550172..698fa3114cf4 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -11,6 +11,7 @@
> =20
>  #include <linux/bitops.h>
>  #include <linux/build_bug.h>
> +#include <linux/kernel.h>
>  #include <linux/mutex.h>
>  #include <linux/rbtree.h>
>  #include <linux/refcount.h>
> @@ -47,6 +48,15 @@ struct access_masks {
>  	access_mask_t scope : LANDLOCK_NUM_SCOPE;
>  };
> =20
> +union access_masks_all {
> +	struct access_masks masks;
> +	u32 all;
> +};
> +
> +/* Makes sure all fields are covered. */
> +static_assert(sizeof(typeof_member(union access_masks_all, masks)) =3D=
=3D
> +	      sizeof(typeof_member(union access_masks_all, all)));
> +
>  typedef u16 layer_mask_t;
>  /* Makes sure all layers can be checked. */
>  static_assert(BITS_PER_TYPE(layer_mask_t) >=3D LANDLOCK_MAX_NUM_LAYERS);
> @@ -260,6 +270,60 @@ static inline void landlock_get_ruleset(struct landl=
ock_ruleset *const ruleset)
>  		refcount_inc(&ruleset->usage);
>  }
> =20
> +/**
> + * landlock_union_access_masks - Return all access rights handled in the
> + *				 domain
> + *
> + * @domain: Landlock ruleset (used as a domain)
> + *
> + * Returns: an access_masks result of the OR of all the domain's access =
masks.
> + */
> +static inline struct access_masks
> +landlock_union_access_masks(const struct landlock_ruleset *const domain)
> +{
> +	union access_masks_all matches =3D {};
> +	size_t layer_level;
> +
> +	for (layer_level =3D 0; layer_level < domain->num_layers; layer_level++=
) {
> +		union access_masks_all layer =3D {
> +			.masks =3D domain->access_masks[layer_level],
> +		};
> +
> +		matches.all |=3D layer.all;
> +	}
> +
> +	return matches.masks;
> +}
> +
> +/**
> + * landlock_get_applicable_domain - Return @domain if it applies to (han=
dles)
> + *				    the access rights specified in @masks

Very minor wording suggestion: For clarity, I would suggest "at least one o=
f":

  Return @domain if it applies to (handles)
  at least one of the access rights specified in @masks

Otherwise this can be interpreted as "...all of the access rights specified=
 in
@masks".

> + *
> + * @domain: Landlock ruleset (used as a domain)
> + * @masks: access masks
> + *
> + * Returns: @domain if any access rights specified in @masks is handled,=
 or
> + * NULL otherwise.
> + */
> +static inline const struct landlock_ruleset *
> +landlock_get_applicable_domain(const struct landlock_ruleset *const doma=
in,
> +			       const struct access_masks masks)
> +{
> +	const union access_masks_all masks_all =3D {
> +		.masks =3D masks,
> +	};
> +	union access_masks_all merge =3D {};
> +
> +	if (!domain)
> +		return NULL;
> +
> +	merge.masks =3D landlock_union_access_masks(domain);
> +	if (merge.all & masks_all.all)
> +		return domain;
> +
> +	return NULL;
> +}
> +
>  static inline void
>  landlock_add_fs_access_mask(struct landlock_ruleset *const ruleset,
>  			    const access_mask_t fs_access_mask,
> @@ -295,19 +359,12 @@ landlock_add_scope_mask(struct landlock_ruleset *co=
nst ruleset,
>  	ruleset->access_masks[layer_level].scope |=3D mask;
>  }
> =20
> -static inline access_mask_t
> -landlock_get_raw_fs_access_mask(const struct landlock_ruleset *const rul=
eset,
> -				const u16 layer_level)
> -{
> -	return ruleset->access_masks[layer_level].fs;
> -}
> -
>  static inline access_mask_t
>  landlock_get_fs_access_mask(const struct landlock_ruleset *const ruleset=
,
>  			    const u16 layer_level)
>  {
>  	/* Handles all initially denied by default access rights. */
> -	return landlock_get_raw_fs_access_mask(ruleset, layer_level) |
> +	return ruleset->access_masks[layer_level].fs |
>  	       LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
>  }
> =20
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index f5a0e7182ec0..c097d356fa45 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -329,7 +329,7 @@ static int add_rule_path_beneath(struct landlock_rule=
set *const ruleset,
>  		return -ENOMSG;
> =20
>  	/* Checks that allowed_access matches the @ruleset constraints. */
> -	mask =3D landlock_get_raw_fs_access_mask(ruleset, 0);
> +	mask =3D ruleset->access_masks[0].fs;
>  	if ((path_beneath_attr.allowed_access | mask) !=3D mask)
>  		return -EINVAL;
> =20
> --=20
> 2.47.0
>=20

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>

Looks good, thanks! Names are much clearer now, IMHO. =F0=9F=91=8D

=E2=80=94G=C3=BCnther
