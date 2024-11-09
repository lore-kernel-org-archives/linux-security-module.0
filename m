Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19174154449
	for <linux-security-module@vger.kernel.org>; Sat,  9 Nov 2024 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731152715; cv=none; b=rcZDLiwZKr74Va4axgRsNYzhsmlYgKGX/RhfWVYWIUf9EX5zljLEuJ2CRTbNTf04069LHI6ocCV6I9fR6vZ/2pEuzpg5YAhYLDM9wxtSyKNm2Y5v7MVjPmfk2KC9EXqrGZyTSZbYUcaputjsw2nh0pDqaa0rEYHMY11p4GChf5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731152715; c=relaxed/simple;
	bh=g1IVTlUa9EykcUKUVbkv1IE9FvsOuBg8WKDH2tS7Aew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCs7uCdnOPluNxuz03nFtD+CUDQWuDGDPy0sfIlWFFUm3bTb3vZMY6qeA8YaFKmacBAI835pMuHqNkFduaOfKR3M01Ps58XrCR91+LN4w0olYVclcnOLu1RF8+wfg7bgIKP8/3c03im134kzQpuERo4rFdMth7QzeaG/VU5eL1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=r0on4HRX; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="r0on4HRX"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XltMg5d0kz8MK;
	Sat,  9 Nov 2024 12:08:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1731150495;
	bh=Ter0OqnQZbSjHBP/cP4KFC34pYhPDUc7LUvjKXyXVHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r0on4HRXijw5RR1fSBgSRZlLsoC5sHME+7VMXKQEBH9njQ5U0FO/iy55tMLxw8ehL
	 Eqf2Bw/uIqjFaDus5V4NI4rVXZkCOuWxlytFqGywXm5KCymWMC26lTB0YPPvgWYIno
	 yD1FVyKWCYQ12YBfuFBQmA/V5Sxivuc91vVlyAWM=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XltMf3gJqz7xh;
	Sat,  9 Nov 2024 12:08:14 +0100 (CET)
Date: Sat, 9 Nov 2024 12:08:06 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Paul Moore <paul@paul-moore.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 1/3] landlock: Refactor filesystem access mask
 management
Message-ID: <20241108.aph1Ojaiv7He@digikod.net>
References: <20241022151144.872797-1-mic@digikod.net>
 <20241022151144.872797-2-mic@digikod.net>
 <ZxpglWaGWN-BUVHB@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxpglWaGWN-BUVHB@google.com>
X-Infomaniak-Routing: alpha

On Thu, Oct 24, 2024 at 04:58:29PM +0200, Günther Noack wrote:
> The approach of only using the union locally to the merging functions is much
> nicer. 👍  Still some documentation/wording remarks, but overall looks good.
> 
> On Tue, Oct 22, 2024 at 05:11:42PM +0200, Mickaël Salaün wrote:
> > Replace get_raw_handled_fs_accesses() with a generic
> > landlock_merge_access_masks(), and replace get_fs_domain() with a
> > generic landlock_match_ruleset().  These helpers will also be useful for
> > other types of access.
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20241022151144.872797-2-mic@digikod.net
> > ---
> > 
> > Changes since v2:
> > * Create a new type union access_masks_all instead of changing struct
> >   acces_masks.
> > * Replace get_fs_domain() with an explicit call to
> >   landlock_match_ruleset().
> > 
> > Changes since v1:
> > * Rename landlock_filter_access_masks() to landlock_match_ruleset().
> > * Rename local variables from domain to ruleset to mach helpers'
> >   semantic.  We'll rename and move these helpers when we'll have a
> >   dedicated domain struct type.
> > * Rename the all_fs mask to any_fs.
> > * Add documentation, as suggested by Günther.
> > ---
> >  security/landlock/fs.c       | 31 ++++------------
> >  security/landlock/ruleset.h  | 70 +++++++++++++++++++++++++++++++-----
> >  security/landlock/syscalls.c |  2 +-
> >  3 files changed, 70 insertions(+), 33 deletions(-)
> > 
> > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > index 7d79fc8abe21..dd9a7297ea4e 100644
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > @@ -388,38 +388,21 @@ static bool is_nouser_or_private(const struct dentry *dentry)
> >  		unlikely(IS_PRIVATE(d_backing_inode(dentry))));
> >  }
> >  
> > -static access_mask_t
> > -get_raw_handled_fs_accesses(const struct landlock_ruleset *const domain)
> > -{
> > -	access_mask_t access_dom = 0;
> > -	size_t layer_level;
> > -
> > -	for (layer_level = 0; layer_level < domain->num_layers; layer_level++)
> > -		access_dom |=
> > -			landlock_get_raw_fs_access_mask(domain, layer_level);
> > -	return access_dom;
> > -}
> > -
> >  static access_mask_t
> >  get_handled_fs_accesses(const struct landlock_ruleset *const domain)
> >  {
> >  	/* Handles all initially denied by default access rights. */
> > -	return get_raw_handled_fs_accesses(domain) |
> > +	return landlock_merge_access_masks(domain).fs |
> >  	       LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
> >  }
> >  
> > -static const struct landlock_ruleset *
> > -get_fs_domain(const struct landlock_ruleset *const domain)
> > -{
> > -	if (!domain || !get_raw_handled_fs_accesses(domain))
> > -		return NULL;
> > -
> > -	return domain;
> > -}
> > +static const struct access_masks any_fs = {
> > +	.fs = ~0,
> > +};
> >  
> >  static const struct landlock_ruleset *get_current_fs_domain(void)
> >  {
> > -	return get_fs_domain(landlock_get_current_domain());
> > +	return landlock_match_ruleset(landlock_get_current_domain(), any_fs);
> >  }
> >  
> >  /*
> > @@ -1516,8 +1499,8 @@ static int hook_file_open(struct file *const file)
> >  	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
> >  	access_mask_t open_access_request, full_access_request, allowed_access,
> >  		optional_access;
> > -	const struct landlock_ruleset *const dom =
> > -		get_fs_domain(landlock_cred(file->f_cred)->domain);
> > +	const struct landlock_ruleset *const dom = landlock_match_ruleset(
> > +		landlock_cred(file->f_cred)->domain, any_fs);
> >  
> >  	if (!dom)
> >  		return 0;
> > diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> > index 61bdbc550172..e00edcb38c5b 100644
> > --- a/security/landlock/ruleset.h
> > +++ b/security/landlock/ruleset.h
> > @@ -47,6 +47,15 @@ struct access_masks {
> >  	access_mask_t scope : LANDLOCK_NUM_SCOPE;
> >  };
> >  
> > +union access_masks_all {
> > +	struct access_masks masks;
> > +	u32 all;
> > +};
> > +
> > +/* Makes sure all fields are covered. */
> > +static_assert(sizeof(((union access_masks_all *)NULL)->masks) ==
> > +	      sizeof(((union access_masks_all *)NULL)->all));
> 
> Nit: Could maybe be written as
> sizeof(typeof_member(union access_masks_all, masks))

yep

> 
> Nit 2: Should this be <= instead of ==?

This would be correct, but I prefer to be stricter to catch any
potential future change.

> 
> > +
> >  typedef u16 layer_mask_t;
> >  /* Makes sure all layers can be checked. */
> >  static_assert(BITS_PER_TYPE(layer_mask_t) >= LANDLOCK_MAX_NUM_LAYERS);
> > @@ -260,6 +269,58 @@ static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
> >  		refcount_inc(&ruleset->usage);
> >  }
> >  
> > +/**
> > + * landlock_merge_access_masks - Return the merge of a ruleset's access_masks
> 
> Documentation uses the same words as in the function name, and it's not
> intuitively clear to me what "merge" means.  Would it be fair to describe it
> like this:
> 
>   landlock_merge_access_masks - Return all access rights handled in the ruleset
> 
> ?

Sounds good.

> 
> (To describe mathematical set operations, I'd normally say "a union" instead of
> "a merge", but that might be confusing given that we also use the C "union"
> feature in the same function.)

landlock_union_access_masks() looks good to me.

> 
> > + *
> > + * @ruleset: Landlock ruleset (used as a domain)
> > + *
> > + * Returns: an access_masks result of the OR of all the ruleset's access masks.
> > + */
> > +static inline struct access_masks
> > +landlock_merge_access_masks(const struct landlock_ruleset *const ruleset)
> > +{
> > +	union access_masks_all matches = {};
> > +	size_t layer_level;
> > +
> > +	for (layer_level = 0; layer_level < ruleset->num_layers;
> > +	     layer_level++) {
> > +		union access_masks_all layer = {
> > +			.masks = ruleset->access_masks[layer_level],
> > +		};
> > +
> > +		matches.all |= layer.all;
> > +	}
> > +
> > +	return matches.masks;
> > +}
> > +
> > +/**
> > + * landlock_match_ruleset - Return @ruleset if any @masks right matches
> 
> Same here; I think when I see a call for a function called
> "landlock_match_ruleset" I might be confused about what is being matched against
> what here.  Documentation uses the same wording as well.  Documentation
> suggestion:
> 
>   landlock_match_ruleset - Return @ruleset iff any access right in @masks
>                            is handled in the @ruleset.
> 
> This is why in [1], I suggested that this function could return a boolean
> and be called differently, like:
> 
>   /* True if any access right in @masks is handled in @ruleset. */
>   bool landlock_is_any_access_right_handled(
>   	const struct landlock_ruleset *const ruleset,
>   	struct access_masks masks);
> 
> Returning a boolean removes the (slightly unintuitive) semantics where a
> function argument is returned under certain conditions, which are not clear from
> the function name, and then the function has the more conventional style of
> returning a boolean that indicates whether some condition holds.  The function
> name would spell out more exactly what is matched against what.

I get your point but I prefer an helper that limits code verbosity and
potential misuse (which is subjective, but still).  With
landlock_match_ruleset(), I think it's easier to check that this
function is called whenever necessary to "match" access masks.  This
pattern is then used in almost every hook implementations.

> 
> Callers would have to check the boolean and return the ruleset themselves, but
> this seems like a reasonable thing to do when the code is clearer to read, IMHO.
> 
>   if (landlock_is_any_access_right_handled(ruleset, masks))
>   	return ruleset;
>   return NULL;

I understand but I prefer to simplify future contributions.

> 
> Alternatively, how about wording it like this:
> 
>   /*
>    * landlock_get_applicable_domain - Returns the @dom ruleset if it
>    *                                  applies to (handles) the access
>    *                                  rights specified in @masks.
>    */
>   const struct landlock_ruleset *landlock_get_applicable_domain(
>   	const struct landlock_ruleset *const dom,
>   	const struct access_masks masks);

OK, I'll go with that.

> 
> [1] https://lore.kernel.org/all/20241005.a69458234f74@gnoack.org/
> 
> 
> > + *
> > + * @ruleset: Landlock ruleset (used as a domain)
> > + * @masks: access masks
> > + *
> > + * Returns: @ruleset if @masks matches, or NULL otherwise.
> > + */
> > +static inline const struct landlock_ruleset *
> > +landlock_match_ruleset(const struct landlock_ruleset *const ruleset,
> > +		       const struct access_masks masks)
> > +{
> > +	const union access_masks_all masks_all = {
> > +		.masks = masks,
> > +	};
> > +	union access_masks_all merge = {};
> > +
> > +	if (!ruleset)
> > +		return NULL;
> > +
> > +	merge.masks = landlock_merge_access_masks(ruleset);
> > +	if (merge.all & masks_all.all)
> > +		return ruleset;
> > +
> > +	return NULL;
> > +}
> > +
> >  static inline void
> >  landlock_add_fs_access_mask(struct landlock_ruleset *const ruleset,
> >  			    const access_mask_t fs_access_mask,
> > @@ -295,19 +356,12 @@ landlock_add_scope_mask(struct landlock_ruleset *const ruleset,
> >  	ruleset->access_masks[layer_level].scope |= mask;
> >  }
> >  
> > -static inline access_mask_t
> > -landlock_get_raw_fs_access_mask(const struct landlock_ruleset *const ruleset,
> > -				const u16 layer_level)
> > -{
> > -	return ruleset->access_masks[layer_level].fs;
> > -}
> > -
> >  static inline access_mask_t
> >  landlock_get_fs_access_mask(const struct landlock_ruleset *const ruleset,
> >  			    const u16 layer_level)
> >  {
> >  	/* Handles all initially denied by default access rights. */
> > -	return landlock_get_raw_fs_access_mask(ruleset, layer_level) |
> > +	return ruleset->access_masks[layer_level].fs |
> >  	       LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
> >  }
> >  
> > diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> > index f5a0e7182ec0..c097d356fa45 100644
> > --- a/security/landlock/syscalls.c
> > +++ b/security/landlock/syscalls.c
> > @@ -329,7 +329,7 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
> >  		return -ENOMSG;
> >  
> >  	/* Checks that allowed_access matches the @ruleset constraints. */
> > -	mask = landlock_get_raw_fs_access_mask(ruleset, 0);
> > +	mask = ruleset->access_masks[0].fs;
> >  	if ((path_beneath_attr.allowed_access | mask) != mask)
> >  		return -EINVAL;
> >  
> > -- 
> > 2.47.0
> > 
