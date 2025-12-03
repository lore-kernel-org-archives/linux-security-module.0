Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FF3281503
	for <linux-security-module@vger.kernel.org>; Wed,  3 Dec 2025 21:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796358; cv=none; b=bp7FZhkX2iADBC3GpIK6rUQWzMPpEbKADZacmUmENCg1/ecqbmAfzBv74zrvKgpvLEz0xMtdPd4ZIoZ7s0LFtR3hAVEQspl9a5Sg2zukiSMg9MYJ1+6I5jCWSibOJPTZz1ebnqMLgKqWSZeFKPW51Ep1CA8KxXWC9b4Urkeljxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796358; c=relaxed/simple;
	bh=WUPKxYRqiXwYjenggofNIgwSDLjgld8FvLTAkUAb26g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfAQHEo5OffIxOtf2YMeTOVo4rJlhmHgjx03hNZMggj9Xruzi8xP2gFzmE4tUjDNkT2a7EWltKd1zrq7jrAMXFrYzBb65CWcCCDOpNngbLQirlJc4ObNiMhB50MEv209oKFq48CcwRQgGCYN4UxuvC99UpPACEGGBRRduf40U8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=o1nSDfjt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=buEhejNI; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="o1nSDfjt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="buEhejNI"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 4C108EC004C;
	Wed,  3 Dec 2025 16:12:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 03 Dec 2025 16:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764796354;
	 x=1764882754; bh=q0bWjXLEKUu/pOasUPVrhXBtw3XOmv1IscEkN2ldbIQ=; b=
	o1nSDfjtuc4lt12wYMwbZ0ZCtz+sUz9N9R+xmeWKYIikvkalAllA3t4ratidSGB7
	2nzbCJJhvy3eKda4xYDlyWp7rN9wpWYquTsnbM6VLwE4JH62/GFhKJfPQShzSeEp
	r3wWahyepzm2WdE7p3QJlX6T0qd7zAK9YPeAVvTE6ehr9Fh56Yoomlic+PKFF7N1
	SVxHaGSSDf0ARFNsgL8exlYRYWou1ZL+iPzPfpjkpEjS67srpUMwCNifoHhEvq41
	gRK7sBOBlJrlZVOmVnFSf9L6WRrArZ1FZbnkGZuixDk/Cpejv4LLhf2XI/KDrC/r
	xbVIrk4n8b0FJF8WUVRh4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764796354; x=
	1764882754; bh=q0bWjXLEKUu/pOasUPVrhXBtw3XOmv1IscEkN2ldbIQ=; b=b
	uEhejNIv0kQkTKrl8d6l6HVqoCP4byGSeIM8dkloYzfq7neDMW9dOHOCC9RAjSOh
	P29PrrTzA33EuBfBOZQaGf8P8P+LWyr6qtEMfq/FGX+BgsIV0HiKHqjIh352wu4a
	Hg4AoRXiSJdCNAn5GCi6e7y6TMV/bG3v0QndG8OT9KOUGIF5ze2CmnyElh0JClg2
	npcys5kkz8rQhtw5slRi+ZYVgT7kZlWfBE9yV0rd71t/QMaFYnc7B3w7/K+djka2
	lSM/kc51Ll49a6AkLO77cEHBp933UbefTxBuR7b0Ji/mH6p9ek3VGxVLDtiEa849
	nvip/DKqGOtFB+kSSzT/g==
X-ME-Sender: <xms:wacwaT9OfHL2E54HfIux_ha244tgd35D37MYI51HpIdCMBa1LCLFPg>
    <xme:wacwaTYsvyicXxoSW28Rwgo3k4g-LQaSCz7d3TEBj_IIk_JAiv40F1qQg3fXZszZY
    2DyUI19ecC8VQdVKhNJY-0OAJV8CJmNQHvc_GlsnGIC6sdeb0omJdU>
X-ME-Received: <xmr:wacwaa2xqflQHI6SJtuQe1KWMRKcfNd_1SsXHuBEQWG97rCA9b5mTT0Ln3rgUPnOaGOF31oTuUySsgxHNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepudekve
    fhgeevvdevieehvddvgefhgeelgfdugeeftedvkeeigfeltdehgeeghffgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehuthhilhhithihvghmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinh
    hugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhgrtg
    hksehsuhhsvgdrtgiipdhrtghpthhtohepgigrnhgufhhurhihsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvth
X-ME-Proxy: <xmx:wacwaWaES3hzFFrEMER2C0vvmyz24QZJkApsiCU5CtDOxmuVop3H8w>
    <xmx:wacwaaLSmPkqpAL5RCQ145idABGfS4ImY8ntNRHLC6PbCGp5g3aNUA>
    <xmx:wacwadFZ18viyDoPdOcX_GwQbs-I-MXvuPT-mlLemuC5OUDO1RBYlw>
    <xmx:wacwaZt6F14Urssi9iHGhUpCLsRWGB9GCLRFW9-xKsQ8kQJHWT8dIg>
    <xmx:wqcwaVDEqZCToOZnp9H4Vpr3n4ywWqBeOcMT9xLhWc64hMptpdBOQ9pu>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 16:12:32 -0500 (EST)
Message-ID: <c314e302-d4ca-4a39-81ba-d4a1e21b9391@maowtm.org>
Date: Wed, 3 Dec 2025 21:12:29 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT
To: Justin Suess <utilityemal77@gmail.com>,
 linux-security-module@vger.kernel.org
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Jan Kara <jack@suse.cz>, Abhinav Saxena <xandfury@gmail.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
References: <20251126122039.3832162-1-utilityemal77@gmail.com>
 <20251126122039.3832162-2-utilityemal77@gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20251126122039.3832162-2-utilityemal77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi!

I've done a "partial" review of this series (with most of the attention on
this patch).  Aside from the comments below, I think we might need to
think a bit more about the implications of things like hard links and bind
mounts, which makes the notion of "parent" non-trivial (as Mickaël also
pointed out on the GitHub thread).  However, I think it should mostly be
good.  My first pass of reasoning for bind mounts are:

A deny rule does not prevent access through a bind mount if the bind mount
points deep into the denied hierarchy (not to the denied dentry itself),
but does protect it if the bind mount points to the denied dentry itself
or its parent.  Therefore, to properly protect a directory that contains
children that might possibly be bind mounted to, a sandboxer just has to
attach deny rules to that directory, plus any bind mounts pointing toward
anything in it, which seems like a reasonable ask given that the sandboxed
application cannot make mounts itself.

Hopefully this review turns out to be useful :)

On 11/26/25 12:20, Justin Suess wrote:
> Implements a flag to prevent access grant inheritance within the filesystem hierarchy
> for landlock rules.
>
> If a landlock rule on an inode has this flag, any access grants on parent inodes will be
> ignored. Moreover, operations that involve altering the direct parent tree of the subject with

I feel like the wording "direct parent tree" is a bit unclear - I think
what you meant is "altering the parent of the subject or its ancestors",
right?

> LANDLOCK_ADD_RULE_NO_INHERIT will be denied up to the mountpoint.

Tbh I'm not entirely clear on why we only deny rename of parents up to the
mountpoint.

>
> Additionally (new in v3) parent flag inheritance is blocked by this flag, allowing fine
> grained access control over LANDLOCK_ADD_RULE_QUIET.
>
> For example, if /a/b/c/ = read only + LANDLOCK_ADD_RULE_NO_INHERIT and / = read write, writes to
> files in /a/b/c will be denied. Moreover, moving /a to /bad, removing /a/b/c, or creating links to
> /a will be prohibited.
>
> And if / has LANDLOCK_ADD_RULE_QUIET, /a/b/c will still audit (handled)
> accesses. This is because LANDLOCK_ADD_RULE_NO_INHERIT also
> suppresses flag inheritance from parent objects.
>
> The parent directory restrictions mitigate sandbox-restart attacks. For example, if a sandboxed program
> is able to move a LANDLOCK_ADD_RULE_NO_INHERIT restricted directory, upon sandbox restart, the policy
> applied naively on the same filenames would be invalid. Preventing these operations mitigates these attacks.
>
> v2..v3 changes:
>
>   * Parent directory topology protections now work by lazily
>     inserting blank rules on parent inodes if they do not
>     exist. This replaces the previous xarray implementation
>     with simplified logic.
>   * Added an optimization to skip further processing if all layers collected
>     no inherit.
>   * Added support to block flag inheritance.
>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
>  security/landlock/audit.c   |   4 +-
>  security/landlock/domain.c  |   4 +-
>  security/landlock/fs.c      | 592 +++++++++++++++++++++++++++++++++++-
>  security/landlock/ruleset.c |  27 +-
>  security/landlock/ruleset.h |  36 ++-
>  5 files changed, 645 insertions(+), 18 deletions(-)
>
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index d51563712325..4da97dd6985c 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -588,7 +588,9 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
>  				subject->domain, &missing, request->layer_masks,
>  				request->layer_masks_size);
>  			object_quiet_flag = !!(request->rule_flags.quiet_masks &
> -					       BIT(youngest_layer));
> +				       BIT(youngest_layer)) &&
> +				!(request->rule_flags.blocked_flag_masks &
> +				  BIT(youngest_layer));
>  		} else {
>  			youngest_layer = get_layer_from_deny_masks(
>  				&missing, request->all_existing_optional_access,
> diff --git a/security/landlock/domain.c b/security/landlock/domain.c
> index 8caf07250328..5bd83865c87d 100644
> --- a/security/landlock/domain.c
> +++ b/security/landlock/domain.c
> @@ -236,7 +236,9 @@ optional_access_t landlock_get_quiet_optional_accesses(
>  			 BITS_PER_TYPE(access_mask_t)) {
>  		const u8 layer = (deny_masks >> (access_index * 4)) &
>  				 (LANDLOCK_MAX_NUM_LAYERS - 1);
> -		const bool is_quiet = !!(rule_flags.quiet_masks & BIT(layer));
> +		const layer_mask_t layer_bit = BIT(layer);
> +		const bool is_quiet = !!(rule_flags.quiet_masks & layer_bit) &&
> +				  !(rule_flags.blocked_flag_masks & layer_bit);
>
>  		if (is_quiet)
>  			quiet_optional_accesses |= BIT(access_index);
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 29f10da32141..0a5c73f18f26 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -317,6 +317,206 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
>  	LANDLOCK_ACCESS_FS_IOCTL_DEV)
>  /* clang-format on */
>
> +static const struct landlock_rule *find_rule(const struct landlock_ruleset *const domain,
> +					     const struct dentry *const dentry);
> +
> +/**
> + * landlock_domain_layers_mask - Build a mask covering all layers of a domain
> + * @domain: The ruleset (domain) to inspect.
> + *
> + * Return a layer mask with a 1 bit for each existing layer of @domain.
> + * If @domain has no layers 0 is returned.  If the number of layers is
> + * greater than or equal to the number of bits in layer_mask_t, all bits
> + * are set.
> + */
> +static layer_mask_t landlock_domain_layers_mask(const struct landlock_ruleset
> +						*const domain)
> +{
> +	if (!domain || !domain->num_layers)
> +		return 0;
> +
> +	if (domain->num_layers >= sizeof(layer_mask_t) * BITS_PER_BYTE)
> +		return (layer_mask_t)~0ULL;
> +
> +	return GENMASK_ULL(domain->num_layers - 1, 0);
> +}
> +
> +/**
> + * rule_blocks_all_layers_no_inherit - check whether a rule disables inheritance
> + * @domain_layers_mask: Mask describing the domain's active layers.
> + * @rule: Rule to inspect.
> + *
> + * Return true if every layer present in @rule has its no_inherit flag set
> + * and the set of layers covered by the rule equals @domain_layers_mask.
> + * This indicates that the rule prevents inheritance on all layers of the
> + * domain and thus further walking for inheritance checks can stop.
> + */
> +static bool rule_blocks_all_layers_no_inherit(const layer_mask_t domain_layers_mask,
> +					      const struct landlock_rule *const rule)
> +{
> +	layer_mask_t rule_layers = 0;
> +	u32 layer_index;
> +
> +	if (!domain_layers_mask || !rule)
> +		return false;
> +
> +	for (layer_index = 0; layer_index < rule->num_layers; layer_index++) {
> +		const struct landlock_layer *const layer =
> +			&rule->layers[layer_index];
> +		const layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
> +
> +		if (!layer->flags.no_inherit)
> +			return false;
> +
> +		rule_layers |= layer_bit;
> +	}
> +
> +	return rule_layers && rule_layers == domain_layers_mask;
> +}
> +
> +/**
> + * landlock_collect_no_inherit_layers - Collects layers with no_inherit flags
> + */

Note likely misplaced comment here

> +/**
> + * landlock_collect_no_inherit_layers - collect effective no_inherit layers
> + * @ruleset: Ruleset to consult.
> + * @dentry: Dentry used as a starting point for the upward walk.
> + *
> + * Walk upwards from @dentry and return a layer mask containing the layers
> + * for which either a rule on the visited dentry has the no_inherit flag set
> + * or where an ancestor was previously marked as having a descendant with
> + * a no_inherit rule.  The search prefers the closest matching dentry and
> + * stops once any relevant layer bits are found or the root is reached.
> + *
> + * Returns a layer_mask_t where each set bit corresponds to a layer with an
> + * effective no_inherit influence for @dentry.  Returns 0 if none apply or if
> + * inputs are invalid.
> + */
> +static layer_mask_t landlock_collect_no_inherit_layers(const struct landlock_ruleset
> +						       *const ruleset,
> +						       struct dentry *const dentry)
> +{
> +	struct dentry *cursor, *parent;
> +	layer_mask_t layers = 0;
> +	bool include_descendants = true;
> +
> +	if (!ruleset || !dentry || d_is_negative(dentry))
> +		return 0;
> +
> +	cursor = dget(dentry);
> +	while (true) {
> +		const struct landlock_rule *rule;
> +		u32 layer_index;
> +
> +		rule = find_rule(ruleset, cursor);
> +		if (rule) {
> +			for (layer_index = 0; layer_index < rule->num_layers; layer_index++) {
> +				const struct landlock_layer *layer = &rule->layers[layer_index];
> +
> +				if (layer->flags.no_inherit ||
> +				    (include_descendants &&
> +				     layer->flags.has_no_inherit_descendant))
> +					layers |= BIT_ULL((layer->level ?
> +						layer->level : layer_index + 1) - 1);
> +			}
> +		}
> +
> +		if (layers) {
> +			dput(cursor);
> +			return layers;
> +		}
> +
> +		if (IS_ROOT(cursor)) {
> +			dput(cursor);
> +			break;
> +		}
> +
> +		parent = dget_parent(cursor);
> +		dput(cursor);
> +		if (!parent)
> +			break;
> +
> +		cursor = parent;
> +		include_descendants = false;
> +	}
> +	return 0;
> +}
> +
> +static int mark_no_inherit_ancestors(struct landlock_ruleset *ruleset,
> +				     struct dentry *dentry,
> +				     layer_mask_t descendant_layers);

Wouldn't you be able to avoid this declaration by moving the definition
for ensure_rule_for_dentry and mark_no_inherit_ancestors up a bit, before
mask_no_inherit_descendant_layers?

> +
> +/**
> + * mask_no_inherit_descendant_layers - apply descendant no_inherit masking
> + * @domain: The ruleset (domain) to consult.
> + * @dentry: The dentry whose descendants are considered.
> + * @child_layers: Layers present on the child that may be subject to masking.
> + * @access_request: Accesses being requested (bitmask).
> + * @layer_masks: Per-access layer masks to be modified in-place.
> + * @rule_flags: Collected flags which will be updated accordingly.
> + *
> + * If descendant dentries have no_inherit, clear that
> + * layer's bit from @layer_masks. Also updates @rule_flags to reflect
> + * which layers were blocked.  Returns true if any of the @layer_masks were
> + * modified, false otherwise.
> + */
> +static bool mask_no_inherit_descendant_layers(const struct landlock_ruleset
> +					      *const domain,
> +					      struct dentry *const dentry,
> +					      layer_mask_t child_layers,
> +					      const access_mask_t access_request,
> +					      layer_mask_t
> +					      (*const layer_masks)
> +					      [LANDLOCK_NUM_ACCESS_FS],
> +					      struct collected_rule_flags
> +					      *const rule_flags)
> +{
> +	layer_mask_t descendant_layers;
> +	const unsigned long access_req = access_request;
> +	unsigned long access_bit;
> +	bool changed = false;
> +
> +	if (!access_request || !layer_masks || !rule_flags || !dentry)
> +		return false;
> +	if (d_is_negative(dentry))
> +		return false;
> +
> +	descendant_layers = landlock_collect_no_inherit_layers(domain, dentry);
> +	{
> +		layer_mask_t shared_layers = descendant_layers & child_layers;
> +
> +		if (shared_layers) {
> +			rule_flags->no_inherit_masks |= shared_layers;
> +			rule_flags->no_inherit_desc_masks |= shared_layers;
> +			rule_flags->blocked_flag_masks |= shared_layers;
> +		}
> +	}
> +	descendant_layers &= ~child_layers;
> +	descendant_layers &= ~rule_flags->no_inherit_masks;
> +	if (!descendant_layers)
> +		return false;
> +
> +	rule_flags->blocked_flag_masks |= descendant_layers;
> +
> +	for_each_set_bit(access_bit, &access_req,
> +			 ARRAY_SIZE(*layer_masks)) {
> +		layer_mask_t *const layer_mask = &(*layer_masks)[access_bit];
> +
> +		if (*layer_mask & descendant_layers) {
> +			*layer_mask &= ~descendant_layers;
> +			changed = true;
> +		}
> +	}
> +
> +	if (!changed)
> +		return false;
> +
> +	rule_flags->no_inherit_masks |= descendant_layers;
> +	rule_flags->no_inherit_desc_masks |= descendant_layers;
> +
> +	return true;
> +}
> +
>  /*
>   * @path: Should have been checked by get_path_from_fd().
>   */
> @@ -325,12 +525,13 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
>  			    access_mask_t access_rights, const int flags)
>  {
>  	int err;
> +	const bool is_dir = d_is_dir(path->dentry);
>  	struct landlock_id id = {
>  		.type = LANDLOCK_KEY_INODE,
>  	};
>
>  	/* Files only get access rights that make sense. */
> -	if (!d_is_dir(path->dentry) &&
> +	if (!is_dir &&
>  	    (access_rights | ACCESS_FILE) != ACCESS_FILE)
>  		return -EINVAL;
>  	if (WARN_ON_ONCE(ruleset->num_layers != 1))
> @@ -344,13 +545,43 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
>  		return PTR_ERR(id.key.object);
>  	mutex_lock(&ruleset->lock);
>  	err = landlock_insert_rule(ruleset, id, access_rights, flags);
> +	if (!err && (flags & LANDLOCK_ADD_RULE_NO_INHERIT)) {
> +		const struct landlock_rule *rule;
> +		layer_mask_t descendant_layers = 0;
> +		u32 layer_index;
> +
> +		rule = find_rule(ruleset, path->dentry);
> +		if (rule) {
> +			for (layer_index = 0; layer_index < rule->num_layers; layer_index++) {

This function is only called to add rules to an "unmerged" ruleset, which
will always only have one layer.  So probably this can just be a

	err = landlock_insert_rule(ruleset, id, access_rights, flags);
	if (err)
		goto out_unlock;
	if (flags & LANDLOCK_ADD_RULE_NO_INHERIT) {
		err = mark_no_inherit_ancestors(ruleset, path->dentry);
		if (err)
			goto out_unlock;
	}

And for a similar reason, you don't have to do a for(layer_index) in
mark_no_inherit_ancestors either.  (Basically I think you would just set
rule->layers[0].flags.has_no_inherit_descendant to true)

It might be helpful to validate / document this reasoning by adding
WARN_ONCE(rule->num_layers != 1, "unmerged rulesets should only have one
layer") either here or in mark_no_inherit_ancestors.

> +				const struct landlock_layer *layer =
> +					&rule->layers[layer_index];
> +
> +				if (layer->flags.no_inherit ||
> +				    layer->flags.has_no_inherit_descendant)
> +					descendant_layers |=
> +						BIT_ULL((layer->level ?
> +							 layer->level : layer_index + 1) - 1);
> +			}
> +			if (descendant_layers) {
> +				err = mark_no_inherit_ancestors(ruleset, path->dentry,
> +								descendant_layers);
> +				if (err)
> +					goto out_unlock;
> +			}
> +		}
> +	}
>  	mutex_unlock(&ruleset->lock);
> +out:
>  	/*
>  	 * No need to check for an error because landlock_insert_rule()
>  	 * increments the refcount for the new object if needed.
>  	 */
>  	landlock_put_object(id.key.object);
>  	return err;
> +
> +out_unlock:
> +	mutex_unlock(&ruleset->lock);
> +	goto out;
>  }
>
>  /* Access-control management */
> @@ -382,6 +613,134 @@ find_rule(const struct landlock_ruleset *const domain,
>  	return rule;
>  }
>
> +/**
> + * ensure_rule_for_dentry - ensure a ruleset contains a rule entry for dentry,
> + * inserting a blank rule if needed.
> + * @ruleset: Ruleset to modify/inspect.  Caller must hold @ruleset->lock.
> + * @dentry: Dentry to ensure a rule exists for.
> + *
> + * If no rule is currently associated with @dentry, insert an empty rule
> + * (with zero access) tied to the backing inode.  Returns a pointer to the
> + * rule associated with @dentry on success, NULL when @dentry is negative, or
> + * an ERR_PTR()-encoded error if the rule cannot be created.
> + *
> + * This is useful for LANDLOCK_ADD_RULE_NO_INHERIT processing, where a rule
> + * may need to be created for an ancestor dentry that does not yet have one
> + * to properly track no_inherit flags.
> + *
> + * The flags are set to zero if a rule is newly created, and the caller
> + * is responsible for setting them appropriately.
> + *
> + * The returned rule pointer's lifetime is tied to @ruleset.
> + */
> +static const struct landlock_rule *
> +ensure_rule_for_dentry(struct landlock_ruleset *const ruleset,
> +		       struct dentry *const dentry)
> +{
> +	struct landlock_id id = {
> +		.type = LANDLOCK_KEY_INODE,
> +	};
> +	const struct landlock_rule *rule;
> +	int err;
> +
> +	if (!ruleset || !dentry || d_is_negative(dentry))
> +		return NULL;
> +
> +	lockdep_assert_held(&ruleset->lock);
> +
> +	rule = find_rule(ruleset, dentry);
> +	if (rule)
> +		return rule;
> +
> +	id.key.object = get_inode_object(d_backing_inode(dentry));
> +	if (IS_ERR(id.key.object))
> +		return ERR_CAST(id.key.object);
> +
> +	err = landlock_insert_rule(ruleset, id, 0, 0);
> +	landlock_put_object(id.key.object);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	rule = find_rule(ruleset, dentry);
> +	return rule ? rule : ERR_PTR(-ENOENT);

I feel like this deserves a WARN_ON_ONCE(!rule) before this line - we
don't really expect to not find a rule right after adding it.

On the other hand, the only reason why we need to re-lookup the rule seems
to be because landlock_insert_rule() does not return the newly added rule.
We could change it to do so, and not have to do this extra lookup.

This also nicely solves the constness issue - landlock_insert_rule could
return the mutable pointer.

> +}
> +
> +/**
> + * mark_no_inherit_ancestors - mark ancestors as having no_inherit descendants
> + * @ruleset: Ruleset to modify.  Caller must hold @ruleset->lock.
> + * @dentry: Dentry representing the descendant that carries no_inherit bits.
> + * @descendant_layers: Mask of layers from the descendant that should be
> + *                     advertised to ancestors via has_no_inherit_descendant.
> + *
> + * Walks upward from @dentry and ensures that any ancestor rule contains the
> + * has_no_inherit_descendant marker for the specified @descendant_layers so
> + * parent lookups can quickly detect descendant no_inherit influence.
> + *
> + * Returns 0 on success or a negative errno if ancestor bookkeeping fails.
> + */
> +static int mark_no_inherit_ancestors(struct landlock_ruleset *ruleset,
> +				     struct dentry *dentry,
> +				     layer_mask_t descendant_layers)
> +{
> +	struct dentry *cursor;
> +	u32 layer_index;
> +	int err = 0;
> +
> +	if (!ruleset || !dentry || !descendant_layers)
> +		return -EINVAL;
> +
> +	lockdep_assert_held(&ruleset->lock);
> +
> +	cursor = dget(dentry);
> +	while (cursor) {
> +		struct dentry *parent;
> +
> +		if (IS_ROOT(cursor)) {
> +			dput(cursor);
> +			break;
> +		}
> +
> +		parent = dget_parent(cursor);
> +		dput(cursor);
> +		if (!parent)
> +			break;
> +
> +		if (!d_is_negative(parent)) {

My understanding is that if the child is not negative (which is required
for us to actually get here), as long as we always have a reference to it,
none of its parents should be negative as well.  This should probably be a
WARN_ON_ONCE(d_is_negative(parent)).

I think some of the other d_is_negative() checks in this patch also have a
similar argument (i.e. turn into WARN_ON_ONCE or be removed if not
necessary), but I've not looked at them all.

> +			const struct landlock_rule *rule;
> +			/* Ensures a rule exists for the parent dentry,
> +			 * inserting a blank one if needed
> +			 */
> +			rule = ensure_rule_for_dentry(ruleset, parent);
> +			if (IS_ERR(rule)) {
> +				err = PTR_ERR(rule);
> +				dput(parent);
> +				cursor = NULL;
> +				break;
> +			}
> +			if (rule) {
> +				struct landlock_rule *mutable_rule =
> +					(struct landlock_rule *)rule;
> +
> +				for (layer_index = 0;
> +				     layer_index < mutable_rule->num_layers;
> +				     layer_index++) {
> +					struct landlock_layer *layer =
> +						&mutable_rule->layers[layer_index];
> +					layer_mask_t layer_bit =
> +						BIT_ULL((layer->level ?
> +							layer->level : layer_index + 1) - 1);
> +
> +					if (descendant_layers & layer_bit)
> +						layer->flags.has_no_inherit_descendant = true;
> +				}
> +			}
> +		}
> +
> +		cursor = parent;
> +	}
> +	return err;
> +}
> +
>  /*
>   * Allows access to pseudo filesystems that will never be mountable (e.g.
>   * sockfs, pipefs), but can still be reachable through
> @@ -764,6 +1123,8 @@ static bool is_access_to_paths_allowed(
>  	struct landlock_request *const log_request_parent2,
>  	struct dentry *const dentry_child2)
>  {
> +	const layer_mask_t domain_layers_mask =
> +		landlock_domain_layers_mask(domain);
>  	bool allowed_parent1 = false, allowed_parent2 = false, is_dom_check,
>  	     is_dom_check_bkp, child1_is_directory = true,
>  	     child2_is_directory = true;
> @@ -778,6 +1139,13 @@ static bool is_access_to_paths_allowed(
>  	struct collected_rule_flags *rule_flags_parent1 = &log_request_parent1->rule_flags;
>  	struct collected_rule_flags *rule_flags_parent2 = &log_request_parent2->rule_flags;
>  	struct collected_rule_flags _rule_flag_parent1_bkp, _rule_flag_parent2_bkp;
> +	layer_mask_t child1_layers = 0;
> +	layer_mask_t child2_layers = 0;
> +
> +	if (dentry_child1)
> +		child1_layers = landlock_collect_no_inherit_layers(domain, dentry_child1);
> +	if (dentry_child2)
> +		child2_layers = landlock_collect_no_inherit_layers(domain, dentry_child2);
>
>  	if (!access_request_parent1 && !access_request_parent2)
>  		return true;
> @@ -931,6 +1299,10 @@ static bool is_access_to_paths_allowed(
>  					       ARRAY_SIZE(*layer_masks_parent2),
>  					       rule_flags_parent2);
>
> +		if (rule &&
> +		    rule_blocks_all_layers_no_inherit(domain_layers_mask, rule))
> +			break;
> +
>  		/* Stops when a rule from each layer grants access. */
>  		if (allowed_parent1 && allowed_parent2) {
>  			/*
> @@ -976,8 +1348,13 @@ static bool is_access_to_paths_allowed(
>  					memcpy(&_rule_flag_parent2_bkp,
>  					       rule_flags_parent2,
>  					       sizeof(_rule_flag_parent2_bkp));
> -					is_dom_check_bkp = is_dom_check;
>  				}
> +				is_dom_check_bkp = is_dom_check;
> +				child1_layers = landlock_collect_no_inherit_layers(domain,
> +										   walker_path
> +										   .dentry);
> +				if (layer_masks_parent2)
> +					child2_layers = child1_layers;
>
>  				/* Ignores hidden mount points. */
>  				goto jump_up;
> @@ -1001,15 +1378,50 @@ static bool is_access_to_paths_allowed(
>  				break;
>  			}
>
> -			/*
> -			 * We reached a disconnected root directory from a bind mount, and
> -			 * we need to reset the walk to the current mount root.
> -			 */
> -			goto reset_to_mount_root;
> -		}
> -		parent_dentry = dget_parent(walker_path.dentry);
> -		dput(walker_path.dentry);
> -		walker_path.dentry = parent_dentry;
> +		/*
> +		 * We reached a disconnected root directory from a bind mount, and
> +		 * we need to reset the walk to the current mount root.
> +		 */

Accidental change of indentation?

> +		goto reset_to_mount_root;
> +	}
> +	if (likely(!d_is_negative(walker_path.dentry))) {
> +		child1_layers = landlock_collect_no_inherit_layers(domain,
> +								   walker_path.dentry);
> +		if (layer_masks_parent2)
> +			child2_layers = child1_layers;
> +	} else {
> +		child1_layers = 0;
> +		if (layer_masks_parent2)
> +			child2_layers = 0;
> +	}
> +	parent_dentry = dget_parent(walker_path.dentry);
> +	dput(walker_path.dentry);
> +	walker_path.dentry = parent_dentry;
> +	/*
> +	 * Apply descendant no-inherit masking now that we've moved to the
> +	 * parent. This ensures the parent respects any no-inherit rules from
> +	 * the child we just left. Only applies to refer operations (rename/link).
> +	 */
> +	if (unlikely(layer_masks_parent2)) {
> +		if (mask_no_inherit_descendant_layers(domain, walker_path.dentry,
> +						      child1_layers,
> +						      access_masked_parent1,
> +						      layer_masks_parent1,
> +						      rule_flags_parent1))
> +			allowed_parent1 =
> +				allowed_parent1 ||
> +				is_layer_masks_allowed(layer_masks_parent1);
> +
> +		if (rule_flags_parent2 &&
> +		    mask_no_inherit_descendant_layers(domain, walker_path.dentry,
> +						      child2_layers,
> +						      access_masked_parent2,
> +						      layer_masks_parent2,
> +						      rule_flags_parent2))
> +			allowed_parent2 =
> +				allowed_parent2 ||
> +				is_layer_masks_allowed(layer_masks_parent2);
> +	}

Maybe I'm missing something, but I can't tell what's the purpose of this
block, or in fact what mask_no_inherit_descendant_layers and
landlock_collect_no_inherit_layers is for.  The doc comment for
mask_no_inherit_descendant_layers seems to suggest that it's supposed to
walk descendents, but landlock_collect_no_inherit_layers is actually
walking ancestors.  Removing these checks doesn't seem to break any tests,
and sandboxer still seems to work as expected wrt. no_inherit rules and
denial of renaming denied dentries and its parents.

Note that the special "reverting" style disconnected directory handling
has been removed in Mickaël's next branch (i.e. the "backup" logic is
removed), which should hopefully simplify reasoning about this.

>  		continue;
>
>  reset_to_mount_root:
> @@ -1057,6 +1469,10 @@ static bool is_access_to_paths_allowed(
>  		dput(walker_path.dentry);
>  		walker_path.dentry = walker_path.mnt->mnt_root;
>  		dget(walker_path.dentry);
> +		child1_layers = landlock_collect_no_inherit_layers(domain,
> +								   walker_path.dentry);
> +		if (layer_masks_parent2)
> +			child2_layers = child1_layers;
>  	}
>  	path_put(&walker_path);
>
> @@ -1172,6 +1588,8 @@ static bool collect_domain_accesses(
>  	struct collected_rule_flags *const rule_flags)
>  {
>  	access_mask_t access_dom;
> +	const layer_mask_t domain_layers_mask =
> +		landlock_domain_layers_mask(domain);
>  	bool ret = false;
>
>  	if (WARN_ON_ONCE(!domain || !mnt_dir || !dir || !layer_masks_dom))
> @@ -1187,9 +1605,11 @@ static bool collect_domain_accesses(
>  	while (true) {
>  		struct dentry *parent_dentry;
>
> +		const struct landlock_rule *rule = find_rule(domain, dir);
> +
>  		/* Gets all layers allowing all domain accesses. */
>  		if (landlock_unmask_layers(
> -			    find_rule(domain, dir), access_dom, layer_masks_dom,
> +			    rule, access_dom, layer_masks_dom,
>  			    ARRAY_SIZE(*layer_masks_dom), rule_flags)) {
>  			/*
>  			 * Before allowing this side of the access request, checks that the
> @@ -1206,6 +1626,10 @@ static bool collect_domain_accesses(
>  			break;
>  		}
>
> +		if (rule &&
> +		    rule_blocks_all_layers_no_inherit(domain_layers_mask, rule))
> +			break;
> +
>  		/* Stops at the mount point. */
>  		if (dir == mnt_dir->dentry)
>  			break;
> @@ -1232,6 +1656,121 @@ static bool collect_domain_accesses(
>  	return ret;
>  }
>
> +/**
> + * collect_topology_sealed_layers - collect layers sealed against topology changes
> + * @domain: Ruleset to consult.
> + * @dentry: Starting dentry for the upward walk.
> + * @override_layers: Optional out parameter filled with layers that are
> + *                   present on ancestors but considered overrides (not
> + *                   sealing the topology for descendants).
> + *
> + * Walk upwards from @dentry and return a mask of layers where either the
> + * visited dentry contains a no_inherit rule or ancestors were previously
> + * marked as having a descendant with no_inherit.  @override_layers, if not
> + * NULL, is filled with layers that would normally be overridden by more
> + * specific descendant rules.
> + *
> + * Returns a layer mask where set bits indicate layers that are "sealed"
> + * (topology changes like rename/rmdir are denied) for the subtree rooted at
> + * @dentry.
> + *
> + * Useful for LANDLOCK_ADD_RULE_NO_INHERIT parent directory enforcement to ensure
> + * that topology changes do not violate the no_inherit constraints.
> + */
> +static layer_mask_t
> +collect_topology_sealed_layers(const struct landlock_ruleset *const domain,
> +			       struct dentry *dentry,
> +			       layer_mask_t *const override_layers)
> +{
> +	struct dentry *cursor, *parent;
> +	bool include_descendants = true;
> +	layer_mask_t sealed_layers = 0;
> +
> +	if (override_layers)
> +		*override_layers = 0;
> +
> +	if (!domain || !dentry || d_is_negative(dentry))
> +		return 0;
> +
> +	cursor = dget(dentry);
> +	while (cursor) {
> +		const struct landlock_rule *rule;
> +		u32 layer_index;
> +
> +		rule = find_rule(domain, cursor);
> +		if (rule) {
> +			for (layer_index = 0; layer_index < rule->num_layers;
> +			     layer_index++) {
> +				const struct landlock_layer *layer =
> +					&rule->layers[layer_index];
> +				const int level = layer->level ? layer->level :
> +								 layer_index + 1;

Wouldn't layer->level always be >= 1 here?  Using layer_index doesn't make
sense since layer_index is just the index that the struct landlock_layer
happened to be in that rule's array.

> +				layer_mask_t layer_bit = BIT_ULL(level - 1);
> +
> +				if (include_descendants &&
> +				    (layer->flags.no_inherit ||
> +				     layer->flags.has_no_inherit_descendant)) {
> +					sealed_layers |= layer_bit;
> +				} else if (override_layers) {
> +					*override_layers |= layer_bit;
> +				}
> +			}
> +		}
> +
> +		if (sealed_layers || IS_ROOT(cursor))
> +			break;
> +
> +		parent = dget_parent(cursor);
> +		dput(cursor);
> +		if (!parent)
> +			return sealed_layers;
> +
> +		cursor = parent;
> +		include_descendants = false;
> +	}
> +	dput(cursor);
> +	return sealed_layers;
> +}
> +
> +/**
> + * deny_no_inherit_topology_change - deny topology changes on sealed layers
> + * @subject: Subject performing the operation (contains the domain).
> + * @dentry: Dentry that is the target of the topology modification.
> + *
> + * Checks whether any domain layers are sealed against topology changes at
> + * @dentry (via collect_topology_sealed_layers).  If so, emit an audit record
> + * and return -EACCES.  Otherwise return 0.
> + */
> +static int deny_no_inherit_topology_change(const struct landlock_cred_security
> +					   *subject,
> +					   struct dentry *dentry)
> +{
> +	layer_mask_t sealed_layers;
> +	layer_mask_t override_layers;
> +	unsigned long layer_index;
> +
> +	if (!subject || !dentry || d_is_negative(dentry))
> +		return 0;
> +	sealed_layers = collect_topology_sealed_layers(subject->domain,
> +						       dentry, &override_layers);
> +	sealed_layers &= ~override_layers;
> +
> +	if (!sealed_layers)
> +		return 0;
> +
> +	layer_index = __ffs((unsigned long)sealed_layers);
> +	landlock_log_denial(subject, &(struct landlock_request) {
> +		.type = LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY,
> +		.audit = {
> +			.type = LSM_AUDIT_DATA_DENTRY,
> +			.u.dentry = dentry,
> +		},
> +		.layer_plus_one = layer_index + 1,
> +	});
> +
> +	return -EACCES;
> +}
> +
>  /**
>   * current_check_refer_path - Check if a rename or link action is allowed
>   *
> @@ -1316,6 +1855,16 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  	access_request_parent2 =
>  		get_mode_access(d_backing_inode(old_dentry)->i_mode);
>  	if (removable) {
> +		int err;
> +
> +		err = deny_no_inherit_topology_change(subject, old_dentry);
> +		if (err)
> +			return err;
> +		if (exchange) {
> +			err = deny_no_inherit_topology_change(subject, new_dentry);
> +			if (err)
> +				return err;
> +		}
>  		access_request_parent1 |= maybe_remove(old_dentry);
>  		access_request_parent2 |= maybe_remove(new_dentry);
>  	}
> @@ -1707,12 +2256,31 @@ static int hook_path_symlink(const struct path *const dir,
>  static int hook_path_unlink(const struct path *const dir,
>  			    struct dentry *const dentry)
>  {
> +	const struct landlock_cred_security *const subject =
> +		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
> +	int err;
> +
> +	if (subject) {
> +		err = deny_no_inherit_topology_change(subject, dentry);
> +		if (err)
> +			return err;
> +	}
>  	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_FILE);
>  }
>
>  static int hook_path_rmdir(const struct path *const dir,
>  			   struct dentry *const dentry)
>  {
> +	const struct landlock_cred_security *const subject =
> +		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
> +	int err;
> +
> +	if (subject) {
> +		err = deny_no_inherit_topology_change(subject, dentry);
> +		if (err)
> +			return err;
> +	}
> +
>  	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR);
>  }
>
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index 750a444e1983..f7b6a48bbf39 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -255,8 +255,13 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
>  				return -EINVAL;
>  			if (WARN_ON_ONCE(this->layers[0].level != 0))
>  				return -EINVAL;
> +			/* Merge the flags into the rules */
>  			this->layers[0].access |= (*layers)[0].access;
>  			this->layers[0].flags.quiet |= (*layers)[0].flags.quiet;
> +			this->layers[0].flags.no_inherit |=
> +				(*layers)[0].flags.no_inherit;
> +			this->layers[0].flags.has_no_inherit_descendant |=
> +				(*layers)[0].flags.has_no_inherit_descendant;
>  			return 0;
>  		}
>
> @@ -315,7 +320,10 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
>  		.level = 0,
>  		.flags = {
>  			.quiet = !!(flags & LANDLOCK_ADD_RULE_QUIET),
> -		},
> +			.no_inherit = !!(flags & LANDLOCK_ADD_RULE_NO_INHERIT),
> +			.has_no_inherit_descendant =
> +				!!(flags & LANDLOCK_ADD_RULE_NO_INHERIT),
> +		}
>  	} };
>
>  	build_check_layer();
> @@ -662,9 +670,22 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
>  		unsigned long access_bit;
>  		bool is_empty;
>
> -		/* Collect rule flags for each layer. */
> -		if (rule_flags && layer->flags.quiet)
> +		/* Skip layers that already have no inherit flags. */
> +		if (rule_flags &&
> +		    (rule_flags->no_inherit_masks & layer_bit))
> +			continue;
> +
> +		/* Collect rule flags for each layer.
> +		 * We block flag inheritance if needed
> +		 * because of a no_inherit rule.
> +		 */
> +		if (rule_flags && layer->flags.quiet &&
> +		    !(rule_flags->blocked_flag_masks & layer_bit))

I don't quite understand the purpose of blocked_flag_masks - wouldn't the
"continue;" above naturally prevent flag inheritance?

>  			rule_flags->quiet_masks |= layer_bit;
> +		if (rule_flags && layer->flags.no_inherit)
> +			rule_flags->no_inherit_masks |= layer_bit;
> +		if (rule_flags && layer->flags.has_no_inherit_descendant)
> +			rule_flags->no_inherit_desc_masks |= layer_bit;
>
>  		/*
>  		 * Records in @layer_masks which layer grants access to each requested
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index eb60db646422..8b46ab14e995 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -40,6 +40,21 @@ struct landlock_layer {
>  		 * down the file hierarchy.
>  		 */
>  		bool quiet:1;
> +		/**
> +		 * @no_inherit: Prevents this rule from being inherited by
> +		 * descendant directories in the filesystem layer.  Only used
> +		 * for filesystem rules.
> +		 */
> +		bool no_inherit:1;
> +		/**
> +		 * @has_no_inherit_descendant: Marker to indicate that this layer
> +		 * has at least one descendant directory with a rule having the
> +		 * no_inherit flag.  Only used for filesystem rules.
> +		 * This "flag" is not set by the user, but by Landlock on
> +		 * parent directories of rules when the child rule has
> +		 * a rule with the no_inherit flag.
> +		 */
> +		bool has_no_inherit_descendant:1;
>  	} flags;
>  	/**
>  	 * @access: Bitfield of allowed actions on the kernel object.  They are
> @@ -49,13 +64,32 @@ struct landlock_layer {
>  };
>
>  /**
> - * struct collected_rule_flags - Hold accumulated flags for each layer.
> + * struct collected_rule_flags - Hold accumulated flags and their markers for each layer.
>   */
>  struct collected_rule_flags {
>  	/**
>  	 * @quiet_masks: Layers for which the quiet flag is effective.
>  	 */
>  	layer_mask_t quiet_masks;
> +	/**
> +	 * @no_inherit_masks: Layers for which the no_inherit flag is effective.
> +	 */
> +	layer_mask_t no_inherit_masks;
> +	/**
> +	 * @no_inherit_desc_masks: Layers for which the
> +	 * has_no_inherit_descendant tag is effective.
> +	 * This is not a flag itself, but a marker set on ancestors
> +	 * of rules with the no_inherit flag to deny topology changes
> +	 * in the direct parent path.
> +	 */
> +	layer_mask_t no_inherit_desc_masks;
> +	/**
> +	 * @blocked_flag_masks: Layers where flag inheritance must be blocked
> +	 * because of a no_inherit rule. This is not a flag itself, but a marker
> +	 * for layers that have their flags blocked due to no_inherit rule
> +	 * propagation.
> +	 */
> +	layer_mask_t blocked_flag_masks;
>  };
>
>  /**
