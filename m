Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A46261B95
	for <linux-security-module@vger.kernel.org>; Fri, 19 Sep 2025 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758298822; cv=none; b=JLYR6t/2KgxKy8wZMWO9ycApLfqRvbgI5E8Mx+QyAMo9CyWoxtKNnPdtKhrb+TNixhY+Ur8mAZ3g501+EHgjvaDNMPsH6SdZbCD0USPVnL3NIOcNN1nybuWytPyjr1NSvZsRgDB4ggUgXL/0N7ABR8Rpj8ZUbcXvYPIOYheMYaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758298822; c=relaxed/simple;
	bh=9c6dc23TiMu3y6l2LwwvkagTIX0wo8v2+7qDJ8i0vog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoybVIxVo6QRKqL+MO5y2ejMqoF8rgYvkQdj+/UwA3kYTA9T3bAz6gdliF44ePb+WZt6XnOWooo/Tmv8dshGvRfrC3Pd4t8yZNrMflJw2BpRpjFw3uOXIjk2RdssGyhkHI9qUo4bqnGAew5odJU3B0tu9yjOW904+dKWfkHmGfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=qYEPp+EJ; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="qYEPp+EJ"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cSy224V8dzYxp;
	Fri, 19 Sep 2025 18:02:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1758297738;
	bh=9ve5GBw/xRvGb6xIVHHTFK39dan6/7AEyoQjSs/4jj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qYEPp+EJ7+B9hwLHlqAsnYmdMvtcnlVvC2aFpSPMh0oXozlabqVnMNO3Rt4pijfHk
	 QDv2Mf7YPleMcMlULY+kwXjW1370oRcU2a8VpkFBRXLC2JOANz0cqkfM+cJWQaUw62
	 C4HaktDoksaJvI4poNkKxpwRdQfjeEroDonsMUMs=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4cSy216kCbzGH;
	Fri, 19 Sep 2025 18:02:17 +0200 (CEST)
Date: Fri, 19 Sep 2025 18:02:17 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] landlock: Add a place for flags to layer rules
Message-ID: <20250919.oanahnoon2Za@digikod.net>
References: <cover.1757376311.git.m@maowtm.org>
 <841550c5d7bbc7ffcd74f85ee659caf1e29cff67.1757376311.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <841550c5d7bbc7ffcd74f85ee659caf1e29cff67.1757376311.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Tue, Sep 09, 2025 at 01:06:35AM +0100, Tingmao Wang wrote:
> To avoid unnecessarily increasing the size of struct landlock_layer, we
> make the layer level a u8 and use the space to store the flags struct.
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
>  security/landlock/fs.c      | 75 ++++++++++++++++++++++++-------------
>  security/landlock/net.c     |  3 +-
>  security/landlock/ruleset.c |  9 ++++-
>  security/landlock/ruleset.h | 27 ++++++++++++-
>  4 files changed, 83 insertions(+), 31 deletions(-)
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
> +		 * for domain check.
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

This patch makes quiet flags related to on object, but not tied to the
rule access rights (as explained in the next patch's doc). To tie it to
rule access rights would require to duplicate the access bits for each
rule (because multiple rules can be tied to the same object for the same
layer/ruleset).

So, the question is, what do we really need to mute?

I think the current approach is enough. We could still add a new flag in
the future, or maybe even a new field to each rule type.  However, we
should rename the flag to make it clear that the it's related to the
rule's object which is muted instead of the whole rule.  Maybe something
like LANDLOCK_ADD_RULE_QUIET_OBJECT?

If we want to have a more fine-grained control, a complementary patch
could add a bitfield for each access right type to quiet a denied access
right iff the object is also quiet (where rules are possible).  That
could be a follow up to complete this quiet feature, but this patch
series is good on its own.

> +		}
> +
>  		/*
>  		 * Records in @layer_masks which layer grants access to each
>  		 * requested access.
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index 5da9a64f5af7..d4b70b6af137 100644
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
> +		 * this rule in this domain.  For fs rules, this inherits down the

Please use filesystem instead of fs.

> +		 * file hierarchy.
> +		 */
> +		bool quiet:1;
> +	} flags;
>  	/**
>  	 * @access: Bitfield of allowed actions on the kernel object.  They are
>  	 * relative to the object type (e.g. %LANDLOCK_ACTION_FS_READ).
> @@ -37,6 +48,17 @@ struct landlock_layer {
>  	access_mask_t access;
>  };
>  
> +

Extra new line.

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
> @@ -304,7 +326,8 @@ landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
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
> 
