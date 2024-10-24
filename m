Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA7B1E412E
	for <linux-security-module@vger.kernel.org>; Thu, 24 Oct 2024 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729781918; cv=none; b=fB1ghRfoQL0CyKbWAg5rdwQL1Z2Jl2BdnEqTWBB5lXg4R7MNZ9YK2Q90rpdhx657j+bD58ahvDJkObRPLk4nM4iJrNmq5N6Ois9q2I8c9aFX7n3wcFlCq9eCLTBM0sQGwzCM9LyH2Zm5CYGjcYMoYEEBtOw2ftrbVmlBtgSQmss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729781918; c=relaxed/simple;
	bh=fsWJLXzguoQoCr3yaxOj7+mbnEd4fEJTPdNcV3+Ugeo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O3bHUTh331cguVCI6FWSijqa8HavxrY5y5xfBuq1pOMIYA2gfGh8A8QIUIdpue2s2laWHNFTrqlYuSeFI7mSB29YVfzv5sKMH04/wR6Z1Ee/Cdzi1mDRPMW6LAXeDL3JEa2ib2A4kqyCkA6aU3SN3lEk5c/iPlmgJN3pPhSjJHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DLgFdxXw; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DLgFdxXw"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a99efc7d881so67969666b.1
        for <linux-security-module@vger.kernel.org>; Thu, 24 Oct 2024 07:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729781912; x=1730386712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UTNMhqkx79/8cayypEH8/H2I1TzVOUDuVBtmGQ2SYBM=;
        b=DLgFdxXwfCc1Eo1QooYYdD8vK/95EAvXc//sdADHxEsMDTrJZhga0O56auFmSJR411
         zRlJWWF/CM10sVQezYTpZoOZySg6PX3WFa/ndsYsBw4TU58msp3ecef+48cTxioqLyjz
         Nc7NUFoA8TJMLCx0C7yLSkd5+14FLFbIulmhAGC0y/MosuTUAHsiHVuyLgDSddwglHg/
         DI9JGygcQk4st3wgAFlc577v4+1mLCdBzAdo0KohnM+KmOCMZzCufAGwWGekt4d++F0n
         dkPywCXdCUfkd3vG+3OoEW5wNj+v40Traz2x5B/ccNTMe2kArkU3OEOAgCLgLVm1EteF
         uYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729781912; x=1730386712;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UTNMhqkx79/8cayypEH8/H2I1TzVOUDuVBtmGQ2SYBM=;
        b=U/lRiWgdhJ3/uB+RpTVH/WLxzsngiodKRJEHILwM9vUa/c2RuXL6yRHRRUZYGSppR4
         KFEQ/1+F1gV/MAU3TKXuxLRbvq5wXFtYAiVOqLip6+8Dj4KIdYXMAZXg8h09avP0f2BQ
         x4y6GkKJffOCQ4AXovpNcfQXcqQ3hjVedWrAwG2YEGrJfAf1qwrG5waUXrnymZbjaIxT
         7fdijUNZmRr8pmpsBaKgz0r1+BbmLjm//d17ZeFWRS8OfgZJRdIKivB0A47XtwQCVvTv
         vrWfjNYgm2ZbPN6BPIwqc7BZodvxsNkZzRtn7f2uRaJsJ0bG16YQqF0fQtSSg0UYPx17
         IIMg==
X-Forwarded-Encrypted: i=1; AJvYcCV4ax/GEQuVOp2YcjBvHO7LXgI6rPsngc7RJEpCpi4Co2ofJnmDSUn4N1qjnTELmDxDm6vjGcBYInuhVwFCjZU3tQErTyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXazUWc/enXgBZR8JA1Xu2ZDT4A2bnbdbChi92s2nCU/gOvBjY
	v51e07aiICPftKeSYsLg5ZB+4LSFkownpFLl5P5JiLiQGu3VkA+sqJzmGxGK86xQBHUNpbZ55YR
	3yA==
X-Google-Smtp-Source: AGHT+IGmu5i1FD/eNUbn5nM80TkcwoIM/8Ad2/KRDXorbucrGPREOhyLWbgFSPRk+xOZedNn6+2om3KiMa4=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:f24c:b0:a89:ee2b:e2dd with SMTP id
 a640c23a62f3a-a9ad283dbb5mr58466b.12.1729781912197; Thu, 24 Oct 2024 07:58:32
 -0700 (PDT)
Date: Thu, 24 Oct 2024 16:58:29 +0200
In-Reply-To: <20241022151144.872797-2-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022151144.872797-1-mic@digikod.net> <20241022151144.872797-2-mic@digikod.net>
Message-ID: <ZxpglWaGWN-BUVHB@google.com>
Subject: Re: [PATCH v3 1/3] landlock: Refactor filesystem access mask management
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Paul Moore <paul@paul-moore.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The approach of only using the union locally to the merging functions is mu=
ch
nicer. =F0=9F=91=8D  Still some documentation/wording remarks, but overall =
looks good.

On Tue, Oct 22, 2024 at 05:11:42PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> Replace get_raw_handled_fs_accesses() with a generic
> landlock_merge_access_masks(), and replace get_fs_domain() with a
> generic landlock_match_ruleset().  These helpers will also be useful for
> other types of access.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241022151144.872797-2-mic@digikod.net
> ---
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
>  security/landlock/fs.c       | 31 ++++------------
>  security/landlock/ruleset.h  | 70 +++++++++++++++++++++++++++++++-----
>  security/landlock/syscalls.c |  2 +-
>  3 files changed, 70 insertions(+), 33 deletions(-)
>=20
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 7d79fc8abe21..dd9a7297ea4e 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -388,38 +388,21 @@ static bool is_nouser_or_private(const struct dentr=
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
> +	return landlock_merge_access_masks(domain).fs |
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
> +	return landlock_match_ruleset(landlock_get_current_domain(), any_fs);
>  }
> =20
>  /*
> @@ -1516,8 +1499,8 @@ static int hook_file_open(struct file *const file)
>  	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {};
>  	access_mask_t open_access_request, full_access_request, allowed_access,
>  		optional_access;
> -	const struct landlock_ruleset *const dom =3D
> -		get_fs_domain(landlock_cred(file->f_cred)->domain);
> +	const struct landlock_ruleset *const dom =3D landlock_match_ruleset(
> +		landlock_cred(file->f_cred)->domain, any_fs);
> =20
>  	if (!dom)
>  		return 0;
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index 61bdbc550172..e00edcb38c5b 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -47,6 +47,15 @@ struct access_masks {
>  	access_mask_t scope : LANDLOCK_NUM_SCOPE;
>  };
> =20
> +union access_masks_all {
> +	struct access_masks masks;
> +	u32 all;
> +};
> +
> +/* Makes sure all fields are covered. */
> +static_assert(sizeof(((union access_masks_all *)NULL)->masks) =3D=3D
> +	      sizeof(((union access_masks_all *)NULL)->all));

Nit: Could maybe be written as
sizeof(typeof_member(union access_masks_all, masks))

Nit 2: Should this be <=3D instead of =3D=3D?

> +
>  typedef u16 layer_mask_t;
>  /* Makes sure all layers can be checked. */
>  static_assert(BITS_PER_TYPE(layer_mask_t) >=3D LANDLOCK_MAX_NUM_LAYERS);
> @@ -260,6 +269,58 @@ static inline void landlock_get_ruleset(struct landl=
ock_ruleset *const ruleset)
>  		refcount_inc(&ruleset->usage);
>  }
> =20
> +/**
> + * landlock_merge_access_masks - Return the merge of a ruleset's access_=
masks

Documentation uses the same words as in the function name, and it's not
intuitively clear to me what "merge" means.  Would it be fair to describe i=
t
like this:

  landlock_merge_access_masks - Return all access rights handled in the rul=
eset

?

(To describe mathematical set operations, I'd normally say "a union" instea=
d of
"a merge", but that might be confusing given that we also use the C "union"
feature in the same function.)

> + *
> + * @ruleset: Landlock ruleset (used as a domain)
> + *
> + * Returns: an access_masks result of the OR of all the ruleset's access=
 masks.
> + */
> +static inline struct access_masks
> +landlock_merge_access_masks(const struct landlock_ruleset *const ruleset=
)
> +{
> +	union access_masks_all matches =3D {};
> +	size_t layer_level;
> +
> +	for (layer_level =3D 0; layer_level < ruleset->num_layers;
> +	     layer_level++) {
> +		union access_masks_all layer =3D {
> +			.masks =3D ruleset->access_masks[layer_level],
> +		};
> +
> +		matches.all |=3D layer.all;
> +	}
> +
> +	return matches.masks;
> +}
> +
> +/**
> + * landlock_match_ruleset - Return @ruleset if any @masks right matches

Same here; I think when I see a call for a function called
"landlock_match_ruleset" I might be confused about what is being matched ag=
ainst
what here.  Documentation uses the same wording as well.  Documentation
suggestion:

  landlock_match_ruleset - Return @ruleset iff any access right in @masks
                           is handled in the @ruleset.

This is why in [1], I suggested that this function could return a boolean
and be called differently, like:

  /* True if any access right in @masks is handled in @ruleset. */
  bool landlock_is_any_access_right_handled(
  	const struct landlock_ruleset *const ruleset,
  	struct access_masks masks);

Returning a boolean removes the (slightly unintuitive) semantics where a
function argument is returned under certain conditions, which are not clear=
 from
the function name, and then the function has the more conventional style of
returning a boolean that indicates whether some condition holds.  The funct=
ion
name would spell out more exactly what is matched against what.

Callers would have to check the boolean and return the ruleset themselves, =
but
this seems like a reasonable thing to do when the code is clearer to read, =
IMHO.

  if (landlock_is_any_access_right_handled(ruleset, masks))
  	return ruleset;
  return NULL;

Alternatively, how about wording it like this:

  /*
   * landlock_get_applicable_domain - Returns the @dom ruleset if it
   *                                  applies to (handles) the access
   *                                  rights specified in @masks.
   */
  const struct landlock_ruleset *landlock_get_applicable_domain(
  	const struct landlock_ruleset *const dom,
  	const struct access_masks masks);

[1] https://lore.kernel.org/all/20241005.a69458234f74@gnoack.org/


> + *
> + * @ruleset: Landlock ruleset (used as a domain)
> + * @masks: access masks
> + *
> + * Returns: @ruleset if @masks matches, or NULL otherwise.
> + */
> +static inline const struct landlock_ruleset *
> +landlock_match_ruleset(const struct landlock_ruleset *const ruleset,
> +		       const struct access_masks masks)
> +{
> +	const union access_masks_all masks_all =3D {
> +		.masks =3D masks,
> +	};
> +	union access_masks_all merge =3D {};
> +
> +	if (!ruleset)
> +		return NULL;
> +
> +	merge.masks =3D landlock_merge_access_masks(ruleset);
> +	if (merge.all & masks_all.all)
> +		return ruleset;
> +
> +	return NULL;
> +}
> +
>  static inline void
>  landlock_add_fs_access_mask(struct landlock_ruleset *const ruleset,
>  			    const access_mask_t fs_access_mask,
> @@ -295,19 +356,12 @@ landlock_add_scope_mask(struct landlock_ruleset *co=
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
