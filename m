Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA34328B7A
	for <linux-security-module@vger.kernel.org>; Wed, 22 Apr 2026 21:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776893370; cv=none; b=iWL6mIzI//rtwWcpa5xrQLXyTwBrhznMQJ8Nd35gjzdF0KPf6HG2sos/52Rnb+JJmVe/R7knBv9oXyljflXbbTM4alf1b9Vgh0fnG+VeYgue8s0XXRpRAYw4BY/JUjKfMUcvsuqJeWOupf6QTa+gfAmgBZnVHL5/KqNMOiq+o2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776893370; c=relaxed/simple;
	bh=RUZ/zMeLjRhbG9xUJPUmI/VRQF8B3sOxv6i8nbEGZdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9pwknyeR66ZyZd/VxIo5PBpEo1ipn+sFOgHqEVkFNf2S8jd0YfiIG9/TsSj9SJthnRw4QmS8Nou/5+b08YhwlX+6/C86QTDKLlhphi+gwQH4lYkmEeTcGtMPRzbudd9Sq5cOV87Doh1RXsuecTKwwlEZCClFrXjyvZXAUhrKuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M95FFfdC; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M95FFfdC"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d03db7f87so4064157f8f.3
        for <linux-security-module@vger.kernel.org>; Wed, 22 Apr 2026 14:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776893367; x=1777498167; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1+oS369ZiRMRkQ0mx6kGQVTJIslbFkhb7uBXwwRCMxA=;
        b=M95FFfdC9wgB5bTXtCy2T0QbPh9GJmKxx95WDCoq/F+Xm5Yv6xSzwdmdPZbr0fnIw3
         Uu5j/cCjCF4CFUK8hBDIx8uHpQE45RQsdBqfPwDkC+wZIoQFqEnFct5WKti3NuLNSYae
         4a0KIcMjqX3hRdAFn7gMC0ZxoFjnJmpKqezK0bF6lt1KR8nkEVQaaEBA+ZoUSS9gxKGi
         +tpOsD4VNBRBXYpJUo9YpHaGhlHJhvzm8wkU25IxUctLaCbkB51Rz6uEK686f9KoiRWL
         Kqyk//POcSlWYQ5MpKSyuBMzDno7rxkWw4eMOF6SgNQreTDyUh/k+N8sqHoyW7liN9nd
         ZBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776893367; x=1777498167;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+oS369ZiRMRkQ0mx6kGQVTJIslbFkhb7uBXwwRCMxA=;
        b=KgVCE+UF/2HGlmCrDWtUZnFFB/IavmwTh8lGGutwCKFCwm/YmfjhjvVdFpAZDiBcLv
         gvitMABd7Ymb5CuduqX7H/P5zUgu/G9lnlUSDuJEvH8vBZzQAZPhwKHIdR21qMix2JVp
         s9/YFn+vScQ6NiuSsGf5tvMi8YeFQ+HL5EJt7PUspjCdJ8kBfIyF/73UZJCya3hYjwP0
         dOHugb8QYemAqGEq5eQK60Dx7pxXxvlhi8zokOAM7ZMyw/coY6+eBFDGdi+aqsllw49B
         G2U4GL2KScIZFA8kwP4L71DtDYQRdIQ2zh1+VebXFhCZVHVPvTv8mukOfwixJevo+veq
         GOgw==
X-Forwarded-Encrypted: i=1; AFNElJ9MvVFnaK4yjZx75FXe76xfQpiFRGqpRsJGTTrdYCBLvfIXQkLTM+rV+v5yDshbxworQkg2eNlyCdCSKmaEna0rlaUwZJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhvLDFdlZvd2OxD7CZ3fUSfU5xgS8xNVkf522lNizlt8tap6uk
	qom1uH8Sjb94yYgLK+xjnPL3EAD1o/3P4dMVGwKXfyYQVGaMoDO1linod16laLE/
X-Gm-Gg: AeBDiesnvcpdaf44e5c+9le9NG4tEwWuAGHnO/vYiTWAsy0DN8JWwTJ//b2zReuAIne
	c0ygPTbXtQUscLiai5EBrcs5vXztXUGnjpPtrD1zsKfS5xqTBEMEzcMhCRYVi+y5/hhuMs/ogmj
	UbI3p1zs/kiF6hfd1ch2KZa17bmqdBGFChrH2IU2RN25k3tIA93CpOyGQmH3/z0OT1Vck9gbu5i
	erhd19fKjQg8PQQeNYkiY7C4dP9I1Kb6QdO35yAGCfRM6nzg2bSRSts3S2MwNShQjhDv6k6rT4u
	AG95fR/CaMR3T+NOrMUt85LPwY66KdJWmhRCJuTCEfwCzu8Z4BYDnlS400kQVMFDu6+kEpEidO4
	nZGGVy+MzjRbhQMUuMh4iqmufA4fVjrBX93deiVpUjhEx4Q9nwZax9b4QD3B1QRAdkUIz6Mayoe
	ZfqZrUtvglFS2BPeljRRYSlhc/mDPxDjO4Uj14cBrm+Hlr7+g1lXsEkN1eyFE=
X-Received: by 2002:a05:6000:186c:b0:43b:4136:1e6f with SMTP id ffacd0b85a97d-43fe3e0af4amr38280849f8f.38.1776893367033;
        Wed, 22 Apr 2026 14:29:27 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb13a0sm48317665f8f.8.2026.04.22.14.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 14:29:26 -0700 (PDT)
Date: Wed, 22 Apr 2026 23:29:25 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Shervin Oloumi <enlightened@google.com>,
	Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 04/11] landlock: Wrap per-layer access masks in
 struct layer_rights
Message-ID: <20260422.9749ad05346f@gnoack.org>
References: <20260312100444.2609563-1-mic@digikod.net>
 <20260312100444.2609563-5-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260312100444.2609563-5-mic@digikod.net>

On Thu, Mar 12, 2026 at 11:04:37AM +0100, Mickaël Salaün wrote:
> The per-layer FAM in struct landlock_ruleset currently stores struct
> access_masks directly, but upcoming permission features (capability
> and namespace restrictions) need additional per-layer data beyond the
> handled-access bitfields.
> 
> Introduce struct layer_rights as a wrapper around struct access_masks
> and rename the FAM from access_masks[] to layers[].  This makes room
> for future per-layer fields (e.g. allowed bitmasks) without modifying
> struct access_masks itself, which is also used as a lightweight
> parameter type for functions that only need the handled-access
> bitfields.
> 
> No functional change.
> 
> Cc: Günther Noack <gnoack@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/landlock/access.h   | 29 ++++++++++++++++++++++-------
>  security/landlock/cred.h     |  2 +-
>  security/landlock/ruleset.c  | 12 ++++++------
>  security/landlock/ruleset.h  | 28 +++++++++++++++-------------
>  security/landlock/syscalls.c |  2 +-
>  5 files changed, 45 insertions(+), 28 deletions(-)
> 
> diff --git a/security/landlock/access.h b/security/landlock/access.h
> index 42c95747d7bd..b3e147771a0e 100644
> --- a/security/landlock/access.h
> +++ b/security/landlock/access.h
> @@ -19,7 +19,7 @@
>  
>  /*
>   * All access rights that are denied by default whether they are handled or not
> - * by a ruleset/layer.  This must be ORed with all ruleset->access_masks[]
> + * by a ruleset/layer.  This must be ORed with all ruleset->layers[]
>   * entries when we need to get the absolute handled access masks, see
>   * landlock_upgrade_handled_access_masks().

Nit: It doesn't get ORed with the ruleset->layers[] entries, but with
the access field within them.  Suggestion:

  This must be ORed with the access field in all ruleset->layers[] entries...


>   */
> @@ -45,7 +45,7 @@ static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_SCOPE);
>  /* Makes sure for_each_set_bit() and for_each_clear_bit() calls are OK. */
>  static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
>  
> -/* Ruleset access masks. */
> +/* Handled access masks (bitfields only). */
>  struct access_masks {
>  	access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
>  	access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
> @@ -61,6 +61,21 @@ union access_masks_all {
>  static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
>  	      sizeof(typeof_member(union access_masks_all, all)));
>  
> +/**
> + * struct layer_rights - Per-layer access configuration
> + *
> + * Wraps the handled-access bitfields together with any additional per-layer
> + * data (e.g. allowed bitmasks added by future patches).  This is the element
> + * type of the &struct landlock_ruleset.layers FAM.
> + */
> +struct layer_rights {
> +	/**
> +	 * @handled: Bitmask of access rights handled (i.e. restricted) by
> +	 * this layer.
> +	 */
> +	struct access_masks handled;
> +};
> +
>  /**
>   * struct layer_access_masks - A boolean matrix of layers and access rights
>   *
> @@ -100,17 +115,17 @@ static_assert(BITS_PER_TYPE(deny_masks_t) >=
>  static_assert(HWEIGHT(LANDLOCK_MAX_NUM_LAYERS) == 1);
>  
>  /* Upgrades with all initially denied by default access rights. */
> -static inline struct access_masks
> -landlock_upgrade_handled_access_masks(struct access_masks access_masks)
> +static inline struct layer_rights
> +landlock_upgrade_handled_access_masks(struct layer_rights layer_rights)
                            ^^^^^^^^^^^^

Now that this is taking "layer_rights" not access_masks, is this still
the right function name?

>  {
>  	/*
>  	 * All access rights that are denied by default whether they are
>  	 * explicitly handled or not.
>  	 */
> -	if (access_masks.fs)
> -		access_masks.fs |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
> +	if (layer_rights.handled.fs)
> +		layer_rights.handled.fs |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
>  
> -	return access_masks;
> +	return layer_rights;
>  }
>  
>  /* Checks the subset relation between access masks. */
> diff --git a/security/landlock/cred.h b/security/landlock/cred.h
> index f287c56b5fd4..3e2a7e88710e 100644
> --- a/security/landlock/cred.h
> +++ b/security/landlock/cred.h
> @@ -139,7 +139,7 @@ landlock_get_applicable_subject(const struct cred *const cred,
>  	for (layer_level = domain->num_layers - 1; layer_level >= 0;
>  	     layer_level--) {
>  		union access_masks_all layer = {
> -			.masks = domain->access_masks[layer_level],
> +			.masks = domain->layers[layer_level].handled,
>  		};
>  
>  		if (layer.all & masks_all.all) {
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index 181df7736bb9..a7f8be37ec31 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -32,7 +32,7 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
>  {
>  	struct landlock_ruleset *new_ruleset;
>  
> -	new_ruleset = kzalloc_flex(*new_ruleset, access_masks, num_layers,
> +	new_ruleset = kzalloc_flex(*new_ruleset, layers, num_layers,
>  				   GFP_KERNEL_ACCOUNT);
>  	if (!new_ruleset)
>  		return ERR_PTR(-ENOMEM);
> @@ -48,7 +48,7 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
>  	/*
>  	 * hierarchy = NULL
>  	 * num_rules = 0
> -	 * access_masks[] = 0
> +	 * layers[] = 0
>  	 */
>  	return new_ruleset;
>  }
> @@ -381,8 +381,8 @@ static int merge_ruleset(struct landlock_ruleset *const dst,
>  		err = -EINVAL;
>  		goto out_unlock;
>  	}
> -	dst->access_masks[dst->num_layers - 1] =
> -		landlock_upgrade_handled_access_masks(src->access_masks[0]);
> +	dst->layers[dst->num_layers - 1] =
> +		landlock_upgrade_handled_access_masks(src->layers[0]);
>  
>  	/* Merges the @src inode tree. */
>  	err = merge_tree(dst, src, LANDLOCK_KEY_INODE);
> @@ -464,8 +464,8 @@ static int inherit_ruleset(struct landlock_ruleset *const parent,
>  		goto out_unlock;
>  	}
>  	/* Copies the parent layer stack and leaves a space for the new layer. */
> -	memcpy(child->access_masks, parent->access_masks,
> -	       flex_array_size(parent, access_masks, parent->num_layers));
> +	memcpy(child->layers, parent->layers,
> +	       flex_array_size(parent, layers, parent->num_layers));
>  
>  	if (WARN_ON_ONCE(!parent->hierarchy)) {
>  		err = -EINVAL;
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index 889f4b30301a..900c47eb0216 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -146,7 +146,7 @@ struct landlock_ruleset {
>  		 * section.  This is only used by
>  		 * landlock_put_ruleset_deferred() when @usage reaches zero.
>  		 * The fields @lock, @usage, @num_rules, @num_layers and
> -		 * @access_masks are then unused.
> +		 * @layers are then unused.
>  		 */
>  		struct work_struct work_free;
>  		struct {
> @@ -173,9 +173,10 @@ struct landlock_ruleset {
>  			 */
>  			u32 num_layers;
>  			/**
> -			 * @access_masks: Contains the subset of filesystem and
> -			 * network actions that are restricted by a ruleset.
> -			 * A domain saves all layers of merged rulesets in a
> +			 * @layers: Per-layer access configuration, including
> +			 * handled access masks and allowed permission
> +			 * bitmasks.  A domain saves all layers of merged
> +			 * rulesets in a
                           ^^^^^^^^^^^^^
Nit: Unconventional line break

>  			 * stack (FAM), starting from the first layer to the
>  			 * last one.  These layers are used when merging
>  			 * rulesets, for user space backward compatibility
> @@ -184,7 +185,7 @@ struct landlock_ruleset {
>  			 * layers are set once and never changed for the
>  			 * lifetime of the ruleset.
>  			 */
> -			struct access_masks access_masks[];
> +			struct layer_rights layers[] __counted_by(num_layers);

Thanks for adding __counted_by() 🏆

>  		};
>  	};
>  };
> @@ -224,7 +225,8 @@ static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
>   *
>   * @domain: Landlock ruleset (used as a domain)
>   *
> - * Return: An access_masks result of the OR of all the domain's access masks.
> + * Return: An access_masks result of the OR of all the domain's handled access
> + * masks.
>   */
>  static inline struct access_masks
>  landlock_union_access_masks(const struct landlock_ruleset *const domain)
> @@ -234,7 +236,7 @@ landlock_union_access_masks(const struct landlock_ruleset *const domain)
>  
>  	for (layer_level = 0; layer_level < domain->num_layers; layer_level++) {
>  		union access_masks_all layer = {
> -			.masks = domain->access_masks[layer_level],
> +			.masks = domain->layers[layer_level].handled,
>  		};
>  
>  		matches.all |= layer.all;
> @@ -252,7 +254,7 @@ landlock_add_fs_access_mask(struct landlock_ruleset *const ruleset,
>  
>  	/* Should already be checked in sys_landlock_create_ruleset(). */
>  	WARN_ON_ONCE(fs_access_mask != fs_mask);
> -	ruleset->access_masks[layer_level].fs |= fs_mask;
> +	ruleset->layers[layer_level].handled.fs |= fs_mask;
>  }
>  
>  static inline void
> @@ -264,7 +266,7 @@ landlock_add_net_access_mask(struct landlock_ruleset *const ruleset,
>  
>  	/* Should already be checked in sys_landlock_create_ruleset(). */
>  	WARN_ON_ONCE(net_access_mask != net_mask);
> -	ruleset->access_masks[layer_level].net |= net_mask;
> +	ruleset->layers[layer_level].handled.net |= net_mask;
>  }
>  
>  static inline void
> @@ -275,7 +277,7 @@ landlock_add_scope_mask(struct landlock_ruleset *const ruleset,
>  
>  	/* Should already be checked in sys_landlock_create_ruleset(). */
>  	WARN_ON_ONCE(scope_mask != mask);
> -	ruleset->access_masks[layer_level].scope |= mask;
> +	ruleset->layers[layer_level].handled.scope |= mask;
>  }
>  
>  static inline access_mask_t
> @@ -283,7 +285,7 @@ landlock_get_fs_access_mask(const struct landlock_ruleset *const ruleset,
>  			    const u16 layer_level)
>  {
>  	/* Handles all initially denied by default access rights. */
> -	return ruleset->access_masks[layer_level].fs |
> +	return ruleset->layers[layer_level].handled.fs |
>  	       _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
>  }
>  
> @@ -291,14 +293,14 @@ static inline access_mask_t
>  landlock_get_net_access_mask(const struct landlock_ruleset *const ruleset,
>  			     const u16 layer_level)
>  {
> -	return ruleset->access_masks[layer_level].net;
> +	return ruleset->layers[layer_level].handled.net;
>  }
>  
>  static inline access_mask_t
>  landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
>  			const u16 layer_level)
>  {
> -	return ruleset->access_masks[layer_level].scope;
> +	return ruleset->layers[layer_level].handled.scope;
>  }
>  
>  bool landlock_unmask_layers(const struct landlock_rule *const rule,
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 3b33839b80c7..2aa7b50d875f 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -341,7 +341,7 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
>  		return -ENOMSG;
>  
>  	/* Checks that allowed_access matches the @ruleset constraints. */
> -	mask = ruleset->access_masks[0].fs;
> +	mask = ruleset->layers[0].handled.fs;
>  	if ((path_beneath_attr.allowed_access | mask) != mask)
>  		return -EINVAL;
>  
> -- 
> 2.53.0
> 
