Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69231325499
	for <linux-security-module@vger.kernel.org>; Wed, 15 Oct 2025 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760555242; cv=none; b=JmVJWfg+N9GwtsgCKy5XO1lorYxz5FGcIrd3t5T6uExOMgaHl9o68uTcAox5WVWVjH3zoAlke7FQRvcMYraVUcRDJslBdZVqilLBjEABaQ9N6CTAYombKl7WqdEbnVshIj6yRXjYP3P+6zK987qoZH7xXw7zIp81w40N1u4kSwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760555242; c=relaxed/simple;
	bh=+c6YAe6mGL9vreHO47f4KCpcVEOVeXE9PfP84fj2y/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXcWAjs8wsoTUwF2baKVOyyIy80iUIaztTNBN22E+V2kc9Sor5YCjC+dEHYOlaQg8HzAPQ+Tk/+5fhdPQQw0sbz/vE+DXv7zwDPj3lrm+czkiLutdAYtFNW+JLtf/uTk714KdK7XnkMXSFYU+FaAZ66EyG7nrInVVUirvKBuyeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0ckMwa42; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0ckMwa42"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cn0vN03NbzQx3;
	Wed, 15 Oct 2025 21:07:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1760555231;
	bh=qKurJ9gGEoydVhoRUvxTfxDOya4OPcQQsi6tOBuiSl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0ckMwa42aayGY/woGmm1PWgn3+MN+ESAFPaVNzWzjXYBRGfIujm8kLYKOkxClIPHf
	 5K01GMQEG5QwtK7wdwr00uLguhlc+3tZrAtbu6fwIyPxkqPZK4v2+iIpeAmaP1BXRv
	 MD4TOiNDPRSq0pHLV8ZjiDJxfCnpP0wHLb8VDVrQ=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4cn0vM32j6zRyg;
	Wed, 15 Oct 2025 21:07:11 +0200 (CEST)
Date: Wed, 15 Oct 2025 21:07:10 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/6] landlock: Add a place for flags to layer rules
Message-ID: <20251015.ohliegae4Phi@digikod.net>
References: <cover.1759686613.git.m@maowtm.org>
 <feccc42da1c32b81e07ccd7387564d4bba8a06c1.1759686613.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <feccc42da1c32b81e07ccd7387564d4bba8a06c1.1759686613.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Sun, Oct 05, 2025 at 06:55:24PM +0100, Tingmao Wang wrote:
> To avoid unnecessarily increasing the size of struct landlock_layer, we
> make the layer level a u8 and use the space to store the flags struct.
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
> 
> Note: conflict with 9a868cdbe6 ("landlock: Fix handling of disconnected
> directories") on mic/next but is not hard to fix - need to backup the
> collected rule flags too.
> 
> Changes since v1:
> - Comment changes
> 
>  security/landlock/fs.c      | 75 ++++++++++++++++++++++++-------------
>  security/landlock/net.c     |  3 +-
>  security/landlock/ruleset.c |  9 ++++-
>  security/landlock/ruleset.h | 26 ++++++++++++-
>  4 files changed, 82 insertions(+), 31 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index c04f8879ad03..e7eaf55093e9 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -756,10 +756,12 @@ static bool is_access_to_paths_allowed(
>  	const struct path *const path,
>  	const access_mask_t access_request_parent1,
>  	layer_mask_t (*const layer_masks_parent1)[LANDLOCK_NUM_ACCESS_FS],
> +	struct collected_rule_flags *const rule_flags_parent1,
>  	struct landlock_request *const log_request_parent1,
>  	struct dentry *const dentry_child1,
>  	const access_mask_t access_request_parent2,
>  	layer_mask_t (*const layer_masks_parent2)[LANDLOCK_NUM_ACCESS_FS],
> +	struct collected_rule_flags *const rule_flags_parent2,
>  	struct landlock_request *const log_request_parent2,
>  	struct dentry *const dentry_child2)
>  {
> @@ -810,22 +812,30 @@ static bool is_access_to_paths_allowed(
>  	}
>  
>  	if (unlikely(dentry_child1)) {
> +		/*
> +		 * The rule_flags for child1 should have been included in
> +		 * rule_flags_masks_parent1 already.  We do not bother about it

rule_flags_parent1

> +		 * for domain check.

The main point about not setting rule_flags_parent* here and below is
because the purpose of this few lines is to get the layer masks for the
potential child dentries and compare them.  Please improve the comment
with this explanation too.

> +		 */
>  		landlock_unmask_layers(
>  			find_rule(domain, dentry_child1),
>  			landlock_init_layer_masks(
>  				domain, LANDLOCK_MASK_ACCESS_FS,
>  				&_layer_masks_child1, LANDLOCK_KEY_INODE),
> -			&_layer_masks_child1, ARRAY_SIZE(_layer_masks_child1));
> +			&_layer_masks_child1, ARRAY_SIZE(_layer_masks_child1),
> +			NULL);
>  		layer_masks_child1 = &_layer_masks_child1;
>  		child1_is_directory = d_is_dir(dentry_child1);
>  	}
>  	if (unlikely(dentry_child2)) {
> +		/* See above comment for why NULL is passed as rule_flags_masks */
>  		landlock_unmask_layers(
>  			find_rule(domain, dentry_child2),
>  			landlock_init_layer_masks(
>  				domain, LANDLOCK_MASK_ACCESS_FS,
>  				&_layer_masks_child2, LANDLOCK_KEY_INODE),
> -			&_layer_masks_child2, ARRAY_SIZE(_layer_masks_child2));
> +			&_layer_masks_child2, ARRAY_SIZE(_layer_masks_child2),
> +			NULL);
>  		layer_masks_child2 = &_layer_masks_child2;
>  		child2_is_directory = d_is_dir(dentry_child2);
>  	}
> @@ -881,16 +891,18 @@ static bool is_access_to_paths_allowed(
>  		}
>  
>  		rule = find_rule(domain, walker_path.dentry);
> -		allowed_parent1 = allowed_parent1 ||
> -				  landlock_unmask_layers(
> -					  rule, access_masked_parent1,
> -					  layer_masks_parent1,
> -					  ARRAY_SIZE(*layer_masks_parent1));
> -		allowed_parent2 = allowed_parent2 ||
> -				  landlock_unmask_layers(
> -					  rule, access_masked_parent2,
> -					  layer_masks_parent2,
> -					  ARRAY_SIZE(*layer_masks_parent2));
> +		allowed_parent1 =
> +			allowed_parent1 ||
> +			landlock_unmask_layers(rule, access_masked_parent1,
> +					       layer_masks_parent1,
> +					       ARRAY_SIZE(*layer_masks_parent1),
> +					       rule_flags_parent1);
> +		allowed_parent2 =
> +			allowed_parent2 ||
> +			landlock_unmask_layers(rule, access_masked_parent2,
> +					       layer_masks_parent2,
> +					       ARRAY_SIZE(*layer_masks_parent2),
> +					       rule_flags_parent2);
>  
>  		/* Stops when a rule from each layer grants access. */
>  		if (allowed_parent1 && allowed_parent2)
> @@ -958,6 +970,7 @@ static int current_check_access_path(const struct path *const path,
>  	const struct landlock_cred_security *const subject =
>  		landlock_get_applicable_subject(current_cred(), masks, NULL);
>  	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
> +	struct collected_rule_flags rule_flags = {};

Why add it after the following variable?

>  	struct landlock_request request = {};
>  
>  	if (!subject)
> @@ -967,8 +980,8 @@ static int current_check_access_path(const struct path *const path,
>  						   access_request, &layer_masks,
>  						   LANDLOCK_KEY_INODE);
>  	if (is_access_to_paths_allowed(subject->domain, path, access_request,
> -				       &layer_masks, &request, NULL, 0, NULL,
> -				       NULL, NULL))
> +				       &layer_masks, &rule_flags, &request,
> +				       NULL, 0, NULL, NULL, NULL, NULL))
>  		return 0;
>  
>  	landlock_log_denial(subject, &request);
> @@ -1032,7 +1045,8 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
>  static bool collect_domain_accesses(
>  	const struct landlock_ruleset *const domain,
>  	const struct dentry *const mnt_root, struct dentry *dir,
> -	layer_mask_t (*const layer_masks_dom)[LANDLOCK_NUM_ACCESS_FS])
> +	layer_mask_t (*const layer_masks_dom)[LANDLOCK_NUM_ACCESS_FS],
> +	struct collected_rule_flags *const rule_flags)
>  {
>  	unsigned long access_dom;
>  	bool ret = false;
> @@ -1051,9 +1065,9 @@ static bool collect_domain_accesses(
>  		struct dentry *parent_dentry;
>  
>  		/* Gets all layers allowing all domain accesses. */
> -		if (landlock_unmask_layers(find_rule(domain, dir), access_dom,
> -					   layer_masks_dom,
> -					   ARRAY_SIZE(*layer_masks_dom))) {
> +		if (landlock_unmask_layers(
> +			    find_rule(domain, dir), access_dom, layer_masks_dom,
> +			    ARRAY_SIZE(*layer_masks_dom), rule_flags)) {
>  			/*
>  			 * Stops when all handled accesses are allowed by at
>  			 * least one rule in each layer.
> @@ -1140,6 +1154,8 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  	struct dentry *old_parent;
>  	layer_mask_t layer_masks_parent1[LANDLOCK_NUM_ACCESS_FS] = {},
>  		     layer_masks_parent2[LANDLOCK_NUM_ACCESS_FS] = {};
> +	struct collected_rule_flags rule_flags_parent1 = {},
> +				    rule_flags_parent2 = {};
>  	struct landlock_request request1 = {}, request2 = {};
>  
>  	if (!subject)
> @@ -1172,10 +1188,10 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  			subject->domain,
>  			access_request_parent1 | access_request_parent2,
>  			&layer_masks_parent1, LANDLOCK_KEY_INODE);
> -		if (is_access_to_paths_allowed(subject->domain, new_dir,
> -					       access_request_parent1,
> -					       &layer_masks_parent1, &request1,
> -					       NULL, 0, NULL, NULL, NULL))
> +		if (is_access_to_paths_allowed(
> +			    subject->domain, new_dir, access_request_parent1,
> +			    &layer_masks_parent1, &rule_flags_parent1,
> +			    &request1, NULL, 0, NULL, NULL, NULL, NULL))
>  			return 0;
>  
>  		landlock_log_denial(subject, &request1);
> @@ -1201,10 +1217,12 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  	/* new_dir->dentry is equal to new_dentry->d_parent */
>  	allow_parent1 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
>  						old_parent,
> -						&layer_masks_parent1);
> +						&layer_masks_parent1,
> +						&rule_flags_parent1);
>  	allow_parent2 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
>  						new_dir->dentry,
> -						&layer_masks_parent2);
> +						&layer_masks_parent2,
> +						&rule_flags_parent2);
>  
>  	if (allow_parent1 && allow_parent2)
>  		return 0;
> @@ -1217,8 +1235,9 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  	 */
>  	if (is_access_to_paths_allowed(
>  		    subject->domain, &mnt_dir, access_request_parent1,
> -		    &layer_masks_parent1, &request1, old_dentry,
> -		    access_request_parent2, &layer_masks_parent2, &request2,
> +		    &layer_masks_parent1, &rule_flags_parent1, &request1,
> +		    old_dentry, access_request_parent2, &layer_masks_parent2,
> +		    &rule_flags_parent2, &request2,
>  		    exchange ? new_dentry : NULL))
>  		return 0;
>  
> @@ -1616,6 +1635,7 @@ static bool is_device(const struct file *const file)
>  static int hook_file_open(struct file *const file)
>  {
>  	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
> +	struct collected_rule_flags rule_flags = {};

Ditto, please move after the other local variables.

>  	access_mask_t open_access_request, full_access_request, allowed_access,
>  		optional_access;
>  	const struct landlock_cred_security *const subject =
> @@ -1647,7 +1667,8 @@ static int hook_file_open(struct file *const file)
>  		    landlock_init_layer_masks(subject->domain,
>  					      full_access_request, &layer_masks,
>  					      LANDLOCK_KEY_INODE),
> -		    &layer_masks, &request, NULL, 0, NULL, NULL, NULL)) {
> +		    &layer_masks, &rule_flags, &request, NULL, 0, NULL, NULL,
> +		    NULL, NULL)) {
>  		allowed_access = full_access_request;
>  	} else {
>  		unsigned long access_bit;
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index 1f3915a90a80..fc6369dffa51 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -48,6 +48,7 @@ static int current_check_access_socket(struct socket *const sock,
>  {
>  	__be16 port;
>  	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_NET] = {};
> +	struct collected_rule_flags rule_flags = {};
>  	const struct landlock_rule *rule;
>  	struct landlock_id id = {
>  		.type = LANDLOCK_KEY_NET_PORT,
> @@ -179,7 +180,7 @@ static int current_check_access_socket(struct socket *const sock,
>  						   access_request, &layer_masks,
>  						   LANDLOCK_KEY_NET_PORT);
>  	if (landlock_unmask_layers(rule, access_request, &layer_masks,
> -				   ARRAY_SIZE(layer_masks)))
> +				   ARRAY_SIZE(layer_masks), &rule_flags))
>  		return 0;
>  
>  	audit_net.family = address->sa_family;
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index ce7940efea51..3aa4e33ac95b 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -616,7 +616,8 @@ landlock_find_rule(const struct landlock_ruleset *const ruleset,
>  bool landlock_unmask_layers(const struct landlock_rule *const rule,
>  			    const access_mask_t access_request,
>  			    layer_mask_t (*const layer_masks)[],
> -			    const size_t masks_array_size)
> +			    const size_t masks_array_size,
> +			    struct collected_rule_flags *const rule_flags)
>  {
>  	size_t layer_level;
>  
> @@ -643,6 +644,12 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
>  		unsigned long access_bit;
>  		bool is_empty;
>  
> +		if (rule_flags) {
> +			/* Collect rule flags for each layer */
> +			if (layer->flags.quiet)
> +				rule_flags->quiet_masks |= layer_bit;
> +		}
> +
>  		/*
>  		 * Records in @layer_masks which layer grants access to each
>  		 * requested access.
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index 5da9a64f5af7..eeee287a9508 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -29,7 +29,18 @@ struct landlock_layer {
>  	/**
>  	 * @level: Position of this layer in the layer stack.
>  	 */
> -	u16 level;
> +	u8 level;
> +	/**
> +	 * @flags: Bitfield for special flags attached to this rule.
> +	 */
> +	struct {
> +		/**
> +		 * @quiet: Suppresses denial audit logs for the object covered by
> +		 * this rule in this domain.  For filesystem rules, this inherits
> +		 * down the file hierarchy.
> +		 */
> +		bool quiet:1;
> +	} flags;
>  	/**
>  	 * @access: Bitfield of allowed actions on the kernel object.  They are
>  	 * relative to the object type (e.g. %LANDLOCK_ACTION_FS_READ).
> @@ -37,6 +48,16 @@ struct landlock_layer {
>  	access_mask_t access;
>  };
>  
> +/**
> + * struct collected_rule_flags - Hold accumulated flags for each layer
> + */
> +struct collected_rule_flags {
> +	/**
> +	 * @quiet_masks: Layers for which the quiet flag is effective.
> +	 */
> +	layer_mask_t quiet_masks;
> +};
> +
>  /**
>   * union landlock_key - Key of a ruleset's red-black tree
>   */
> @@ -304,7 +325,8 @@ landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
>  bool landlock_unmask_layers(const struct landlock_rule *const rule,
>  			    const access_mask_t access_request,
>  			    layer_mask_t (*const layer_masks)[],
> -			    const size_t masks_array_size);
> +			    const size_t masks_array_size,
> +			    struct collected_rule_flags *const rule_flags);
>  
>  access_mask_t
>  landlock_init_layer_masks(const struct landlock_ruleset *const domain,
> -- 
> 2.51.0
> 
