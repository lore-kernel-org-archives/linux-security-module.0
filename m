Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C945B18DB1F
	for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 20:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779569809; cv=none; b=J8y8Li/AexZvzCbavNoR3DY8MsFlgWS/MNcOvnOql06HNTxdJ2yUZmVt1uxF64v3T8wd9qelWvFxLqsiPitgElqsPyo4rhoaBSnyRbtFCHB0v7tYYy60YW8l7keBFQRVYatqZ2ExtZgI7dZc5nZDbokfKNYi4fzMer1fsMkpZNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779569809; c=relaxed/simple;
	bh=cDmIH5Q/jHbbYv8HoHx/eBPJ+j1wb4BrT/UAoWW+phM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkKa3v2YstCpThBqspfw/ZA+4AnCdTqmR9n/a78bNQFB4Qx/DPLvCbz254qBhFMdWLgkO1+2RB+eA4pzsNb+GAtN66P8HiZK57sZckwKTj5xFyVTR/G8oTVZ63SYlTe+gzwl/DANEOmIdEGUaucRM378SaflD173ePms8dgpWwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=bVXBgfue; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="bVXBgfue"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gNDl603bLz7vG;
	Sat, 23 May 2026 22:48:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1779569329;
	bh=wsZwefc/VDPy+AK049lhJJNd1ms8RoQOpccQNM1ofh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bVXBgfuefn9uQBpxOz8BLkre6ztRHOXN+VXdedLdEomhxE2DlB7+83oXgUHJyRGNV
	 NUGUldK6zc+If7dOQKMpr8p1LtrxCXV3BtBdg44cJQimcTMjOe72MzFCzk280b9zha
	 e8Xo8P3S0mG3T0IuIFu32PZaRpngmFkFYmX3sBeY=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gNDl52Q06z8F;
	Sat, 23 May 2026 22:48:49 +0200 (CEST)
Date: Sat, 23 May 2026 22:48:45 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: Justin Suess <utilityemal77@gmail.com>, Jan Kara <jack@suse.cz>, 
	Abhinav Saxena <xandfury@gmail.com>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v8 1/9] landlock: Add a place for flags to layer rules
Message-ID: <20260523.Uephughee8as@digikod.net>
References: <cover.1775490344.git.m@maowtm.org>
 <6f418b431ccf88636ea3a1b930d14bfdcd420233.1775490344.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f418b431ccf88636ea3a1b930d14bfdcd420233.1775490344.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

This patch doesn't build.

On Mon, Apr 06, 2026 at 04:52:14PM +0100, Tingmao Wang wrote:
> To avoid unnecessarily increasing the size of struct landlock_layer, we
> make the layer level a u8 and use the space to store the flags struct.
> 
> Cc: Justin Suess <utilityemal77@gmail.com>
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> Co-developed-by: Justin Suess <utilityemal77@gmail.com>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
> 
> Because the no inherit patchset [2] from Justin Suess will depend on
> this rule flags mechanism, I and Justin discussed a bit whether this
> patch should in fact be a standalone thing separate from quiet flags
> (i.e. add the infrastructure for rule flags, but don't actually add any
> rule flags in this commit), so that the two series can be developed and
> merged independently.  However in the end I decided to not do this and
> send this patch as-is.
> 
> Changes in v8:
> - Rebase on top of mic/next
> - Add Co-developed-by: Justin Suess for handling this rebase initially
> - layer_mask_t was removed in [1] but we still need it for the
>   collected_rule_flags.  Rather than using raw u16, I've chosen to
>   re-define it back in ruleset.h (it was in access.h).
> 
> Changes in v7:
> - Take rule_flags separately from landlock_request in
>   is_access_to_paths_allowed to avoid writing to the landlock_request
>   variable if CONFIG_AUDIT is disabled (to enable compiler elision).
> - Due to the above change, we don't need rule_flags in landlock_request in
>   this commit anymore (will be added later).
> 
> Changes in v6:
> - Rebased to include the revised disconnected directory handling changes
>   (without the "reverting" behaviour)
> 
> Changes in v5:
> - Move rule_flags into landlock_request.  This lets us get rid of the
>   extra parameters to is_access_to_paths_allowed (and later on,
>   landlock_log_denial), and thus less code changes.
> 
> Changes in v3:
> - Comment changes, move local variables, simplify if branch
> 
> Changes in v2:
> - Comment changes
> - Rebased to include disconnected directory handling changes on mic/next
>   and add backing up of collected_rule_flags.
> 
> [1]: https://lore.kernel.org/all/20260125195853.109967-1-gnoack3000@gmail.com/
> [2]: https://lore.kernel.org/all/20251221194301.247484-1-utilityemal77@gmail.com/
> 
>  security/landlock/fs.c      | 96 +++++++++++++++++++++++--------------
>  security/landlock/net.c     |  3 +-
>  security/landlock/ruleset.c |  8 +++-
>  security/landlock/ruleset.h | 32 ++++++++++++-
>  4 files changed, 99 insertions(+), 40 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index c1ecfe239032..6f63e0182ef0 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -717,6 +717,9 @@ static void test_is_eacces_with_write(struct kunit *const test)
>   *     those identified by @access_request_parent1).  This matrix can
>   *     initially refer to domain layer masks and, when the accesses for the
>   *     destination and source are the same, to requested layer masks.
> + * @rule_flags_parent1: Pointer to a collected_rule_flags struct
> + *     corresponding to the accumulated rule flags for parent1 to be read from
> + *     and filled as we traverse the path.
>   * @log_request_parent1: Audit request to fill if the related access is denied.
>   * @dentry_child1: Dentry to the initial child of the parent1 path.  This
>   *     pointer must be NULL for non-refer actions (i.e. not link nor rename).
> @@ -726,6 +729,7 @@ static void test_is_eacces_with_write(struct kunit *const test)
>   *     the source.  Must be set to 0 when using a simple path request.
>   * @layer_masks_parent2: Similar to @layer_masks_parent1 but for a refer
>   *     action.  This must be NULL otherwise.
> + * @rule_flags_parent2: Similar to @rule_flags_parent1 but for parent2.
>   * @log_request_parent2: Audit request to fill if the related access is denied.
>   * @dentry_child2: Dentry to the initial child of the parent2 path.  This
>   *     pointer is only set for RENAME_EXCHANGE actions and must be NULL
> @@ -739,17 +743,19 @@ static void test_is_eacces_with_write(struct kunit *const test)
>   *
>   * Return: True if the access request is granted, false otherwise.
>   */
> -static bool
> -is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
> -			   const struct path *const path,
> -			   const access_mask_t access_request_parent1,
> -			   struct layer_access_masks *layer_masks_parent1,
> -			   struct landlock_request *const log_request_parent1,
> -			   struct dentry *const dentry_child1,
> -			   const access_mask_t access_request_parent2,
> -			   struct layer_access_masks *layer_masks_parent2,
> -			   struct landlock_request *const log_request_parent2,
> -			   struct dentry *const dentry_child2)
> +static bool is_access_to_paths_allowed(
> +	const struct landlock_ruleset *const domain,
> +	const struct path *const path,
> +	const access_mask_t access_request_parent1,
> +	struct layer_access_masks *layer_masks_parent1,
> +	struct collected_rule_flags *const rule_flags_parent1,
> +	struct landlock_request *const log_request_parent1,
> +	struct dentry *const dentry_child1,
> +	const access_mask_t access_request_parent2,
> +	struct layer_access_masks *layer_masks_parent2,
> +	struct collected_rule_flags *const rule_flags_parent2,
> +	struct landlock_request *const log_request_parent2,
> +	struct dentry *const dentry_child2)
>  {
>  	bool allowed_parent1 = false, allowed_parent2 = false, is_dom_check,
>  	     child1_is_directory = true, child2_is_directory = true;
> @@ -797,20 +803,28 @@ is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
>  	}
>  
>  	if (unlikely(dentry_child1)) {
> +		/*
> +		 * Get the layer masks for the child dentries for use by domain
> +		 * check later.  The rule_flags for child1 should have been
> +		 * included in rule_flags_parent1 already (cf.
> +		 * collect_domain_accesses), and is not relevant for domain check,
> +		 * so we don't have to pass it to landlock_unmask_layers.
> +		 */
>  		if (landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
>  					      &_layer_masks_child1,
>  					      LANDLOCK_KEY_INODE))
>  			landlock_unmask_layers(find_rule(domain, dentry_child1),
> -					       &_layer_masks_child1);
> +					       &_layer_masks_child1, NULL);
>  		layer_masks_child1 = &_layer_masks_child1;
>  		child1_is_directory = d_is_dir(dentry_child1);
>  	}
>  	if (unlikely(dentry_child2)) {
> +		/* See above comment for why NULL is passed as rule_flags_masks. */

rule_flags_masks doesn't exist.

>  		if (landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
>  					      &_layer_masks_child2,
>  					      LANDLOCK_KEY_INODE))
>  			landlock_unmask_layers(find_rule(domain, dentry_child2),
> -					       &_layer_masks_child2);
> +					       &_layer_masks_child2, NULL);
>  		layer_masks_child2 = &_layer_masks_child2;
>  		child2_is_directory = d_is_dir(dentry_child2);
>  	}
> @@ -865,12 +879,14 @@ is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
>  		}
>  
>  		rule = find_rule(domain, walker_path.dentry);
> -		allowed_parent1 =
> -			allowed_parent1 ||
> -			landlock_unmask_layers(rule, layer_masks_parent1);
> -		allowed_parent2 =
> -			allowed_parent2 ||
> -			landlock_unmask_layers(rule, layer_masks_parent2);
> +		allowed_parent1 = allowed_parent1 ||
> +				  landlock_unmask_layers(rule,
> +							 layer_masks_parent1,
> +							 rule_flags_parent1);
> +		allowed_parent2 = allowed_parent2 ||
> +				  landlock_unmask_layers(rule,
> +							 layer_masks_parent2,
> +							 rule_flags_parent2);
>  
>  		/* Stops when a rule from each layer grants access. */
>  		if (allowed_parent1 && allowed_parent2)
> @@ -954,6 +970,7 @@ static int current_check_access_path(const struct path *const path,
>  		landlock_get_applicable_subject(current_cred(), masks, NULL);
>  	struct layer_access_masks layer_masks;
>  	struct landlock_request request = {};
> +	struct collected_rule_flags rule_flags = {};
>  
>  	if (!subject)
>  		return 0;
> @@ -962,8 +979,8 @@ static int current_check_access_path(const struct path *const path,
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
> @@ -1026,10 +1043,11 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
>   * Return: True if all the domain access rights are allowed for @dir, false if
>   * the walk reached @mnt_root.
>   */
> -static bool collect_domain_accesses(const struct landlock_ruleset *const domain,
> -				    const struct dentry *const mnt_root,
> -				    struct dentry *dir,
> -				    struct layer_access_masks *layer_masks_dom)
> +static bool
> +collect_domain_accesses(const struct landlock_ruleset *const domain,
> +			const struct dentry *const mnt_root, struct dentry *dir,
> +			struct layer_access_masks *layer_masks_dom,
> +			struct collected_rule_flags *const rule_flags)
>  {
>  	bool ret = false;
>  
> @@ -1048,7 +1066,7 @@ static bool collect_domain_accesses(const struct landlock_ruleset *const domain,
>  
>  		/* Gets all layers allowing all domain accesses. */
>  		if (landlock_unmask_layers(find_rule(domain, dir),
> -					   layer_masks_dom)) {
> +					   layer_masks_dom, rule_flags)) {
>  			/*
>  			 * Stops when all handled accesses are allowed by at
>  			 * least one rule in each layer.
> @@ -1138,6 +1156,8 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  	struct layer_access_masks layer_masks_parent1 = {},
>  				  layer_masks_parent2 = {};
>  	struct landlock_request request1 = {}, request2 = {};
> +	struct collected_rule_flags rule_flags_parent1 = {},
> +				    rule_flags_parent2 = {};
>  
>  	if (!subject)
>  		return 0;
> @@ -1169,10 +1189,10 @@ static int current_check_refer_path(struct dentry *const old_dentry,
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
> @@ -1198,11 +1218,12 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  	/* new_dir->dentry is equal to new_dentry->d_parent */
>  	allow_parent1 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
>  						old_parent,
> -						&layer_masks_parent1);
> +						&layer_masks_parent1,
> +						&rule_flags_parent1);
>  	allow_parent2 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
>  						new_dir->dentry,
> -						&layer_masks_parent2);
> -
> +						&layer_masks_parent2,
> +						&rule_flags_parent2);
>  	if (allow_parent1 && allow_parent2)
>  		return 0;
>  
> @@ -1214,8 +1235,9 @@ static int current_check_refer_path(struct dentry *const old_dentry,
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
> @@ -1745,6 +1767,7 @@ static int hook_file_open(struct file *const file)
>  	const struct landlock_cred_security *const subject =
>  		landlock_get_applicable_subject(file->f_cred, any_fs, NULL);
>  	struct landlock_request request = {};
> +	struct collected_rule_flags rule_flags = {};
>  
>  	if (!subject)
>  		return 0;
> @@ -1771,7 +1794,8 @@ static int hook_file_open(struct file *const file)
>  		    landlock_init_layer_masks(subject->domain,
>  					      full_access_request, &layer_masks,
>  					      LANDLOCK_KEY_INODE),
> -		    &layer_masks, &request, NULL, 0, NULL, NULL, NULL)) {
> +		    &layer_masks, &rule_flags, &request, NULL, 0, NULL, NULL,
> +		    NULL, NULL)) {
>  		allowed_access = full_access_request;
>  	} else {
>  		/*
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index c368649985c5..dc82ce4a2bd4 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -48,6 +48,7 @@ static int current_check_access_socket(struct socket *const sock,
>  {
>  	__be16 port;
>  	struct layer_access_masks layer_masks = {};
> +	struct collected_rule_flags rule_flags = {};
>  	const struct landlock_rule *rule;
>  	struct landlock_id id = {
>  		.type = LANDLOCK_KEY_NET_PORT,
> @@ -194,7 +195,7 @@ static int current_check_access_socket(struct socket *const sock,
>  	if (!access_request)
>  		return 0;
>  
> -	if (landlock_unmask_layers(rule, &layer_masks))
> +	if (landlock_unmask_layers(rule, &layer_masks, &rule_flags))
>  		return 0;
>  
>  	audit_net.family = address->sa_family;
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index 181df7736bb9..e4e6b730b581 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -628,7 +628,8 @@ landlock_find_rule(const struct landlock_ruleset *const ruleset,
>   * remaining unfulfilled access rights and masks has no leftover set bits).
>   */
>  bool landlock_unmask_layers(const struct landlock_rule *const rule,
> -			    struct layer_access_masks *masks)
> +			    struct layer_access_masks *masks,
> +			    struct collected_rule_flags *const rule_flags)
>  {
>  	if (!masks)
>  		return true;
> @@ -647,9 +648,14 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
>  	 */
>  	for (size_t i = 0; i < rule->num_layers; i++) {
>  		const struct landlock_layer *const layer = &rule->layers[i];
> +		const layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
>  

>  		/* Clear the bits where the layer in the rule grants access. */
>  		masks->access[layer->level - 1] &= ~layer->access;
> +
> +		/* Collect rule flags for each layer. */
> +		if (rule_flags && layer->flags.quiet)
> +			rule_flags->quiet_masks |= layer_bit;

Why not store the quiet bit in masks?  That would not only be "access"
bits anymore but it makes sense to store all this bits it the same
place.

We should then probably rename struct layer_access_masks to just struct
layer_masks.

We need to be careful to not increase too much the size of this struct
though while keeping the [LANDLOCK_MAX_NUM_LAYERS] approach if possible
(see Günther's commit that added it).

>  	}
>  
>  	for (size_t i = 0; i < ARRAY_SIZE(masks->access); i++) {
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index 889f4b30301a..3b31552f0c95 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -29,7 +29,18 @@ struct landlock_layer {
>  	/**
>  	 * @level: Position of this layer in the layer stack.  Starts from 1.
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
> @@ -37,6 +48,22 @@ struct landlock_layer {
>  	access_mask_t access;
>  };
>  
> +typedef u16 layer_mask_t;
> +
> +/* Makes sure this is enough to include all layers. */
> +static_assert(BITS_PER_TYPE(layer_mask_t) >= LANDLOCK_MAX_NUM_LAYERS);
> +
> +

Two new lines.

> +/**
> + * struct collected_rule_flags - Hold accumulated flags for each layer.
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
> @@ -302,7 +329,8 @@ landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
>  }
>  
>  bool landlock_unmask_layers(const struct landlock_rule *const rule,
> -			    struct layer_access_masks *masks);
> +			    struct layer_access_masks *masks,
> +			    struct collected_rule_flags *const rule_flags);
>  
>  access_mask_t
>  landlock_init_layer_masks(const struct landlock_ruleset *const domain,
> -- 
> 2.53.0
> 
