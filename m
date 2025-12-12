Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF5614F125
	for <linux-security-module@vger.kernel.org>; Fri, 12 Dec 2025 22:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765576986; cv=none; b=L1UmQf7kTnDREQzT3GTSYMr2Ai+/mbLyaYExSiXVtUHlGDzwQOtYTMmOuxVuyf706JJtypnwrK2vnxfBDHPd4pCm6XkCpeWXN9c5U8usskaRaR6KsLqgmRsxsl5abiPs9qtETNQYCGCwy0rGjlOxFtbviGBALe0M240fgYI7H3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765576986; c=relaxed/simple;
	bh=W9rfPLxbS0r9QC7FiFE65dvP66OharCdRAJtvH8p+ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/AfGxPFFs4lVAfD/ZNZ/Bh/fOW9S4wTFsadeJEBLdIufEpmzTw0CgMxeTvSICoN7BfcXeXoxkLoo0NVcsA4VEs83Z5MmdbR5NbjZqfgfzk4U9Sez3MPMvT8iF3CGa2nxZ9tl2MfVRlJ7rC6RsaTYn62hJHpbh9Akm5tFmzDLYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UX8TZyjn; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UX8TZyjn"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-640e065991dso1387982d50.3
        for <linux-security-module@vger.kernel.org>; Fri, 12 Dec 2025 14:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765576983; x=1766181783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrooMgEeok1Mv3iCdclDFskm5fAmgQekMuu1O2t6zeM=;
        b=UX8TZyjn8mVOAo0vpWA9BzN7GsUxKRy6L2kQxJ5xVf1X4IkPW8so38fRYSZUusq3VT
         geKyH7Fhzqpu0vTu+f6J/2f6wDst/0rydZn7Pz5jTZQB1MLHs8RJJq98wTe3uKwdaJf7
         W1SoKYoyuu2PDdUx9DwktGqbISTpxKzP3SKMS0ploz9fgXTcvL2KIzKctW5sKBeSoXZZ
         31KXYF8TPaOdHPeFtfKTy5rHdg90b/gGjgdtft2nAyjACgcqXu7Y/AHCT1I/FX3Oh7gR
         V8r5HPGSopqjpFMOdvTrxsV84SXNCeJwn2QnX5t3wCiWn3LJPN2VoWKLW2f8TQ4s8vzD
         f3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765576983; x=1766181783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RrooMgEeok1Mv3iCdclDFskm5fAmgQekMuu1O2t6zeM=;
        b=pnwkeokuvllAFyxDKSCi98teOhVMZsJdJRTDAk4pFxhBSXufSu/jvVnX06s7qtyo8u
         YMsMDz8NlxiwRUQ6P/Wn2Hj5eCMBAwb9Cu3jATABgFH0auma092RVDlUw5sNVTx7fNrO
         XHKUeFiXAzM9TyyugH+XVZSRonkr2GvXwzMibxFypTFYte29DTM6WgOFDfkqWk+A4L/x
         GAEz4JEs/kP8Qh0XvdwtYsU34SzqrUBifEQGFiGklk1XP7tUsKFsnLDwAmFmFh2izwi/
         dteEPJE7JFYzI/bKWftECX7P22nQAgE24r/zLI/wIPUVEqr28PFlKWFQacUoLOw7ypTB
         CbLg==
X-Forwarded-Encrypted: i=1; AJvYcCXGNWh2nCtHLKmSAHVwtaBrfxhG2tu724utD1tHx8cBkEL3G1IH1RIusG9a2gztN3EB+gAwgY7ufXxA3jt4Fg8OzADcD3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIyOrobI1fwZx5XCF70zNblKSO51odGKczF/z9rrj9x1uFIr35
	Mkwn/xILeW/9XXKDAzp+ToMC7iKSz4EmVQO8s1BeFGlkrHU7Q4zYjM+I
X-Gm-Gg: AY/fxX7uGuk0GFmuAQ2fo+/QCulKTw2VkpvvLUEdatNwlPaAuV2m09LmeFyDb2PEwjn
	+uyT60bqL5DyqS9qnQTWZacqKtJCGyy49A71NSXHUgblw+XXksHKn4C3IiOFks1blC2QjMsTMuB
	pLSyslaNC6M2uS1r0k3zj9d5zp4dajIYWOljz7dWGWAjKh5as2Ov1z2aZCc1m7sjTL3tkLn+k0i
	hnl0aHtW1o6yvKMGWdeT0orTIWq372aNBRCauurEioxw82bbxZKtxx0KQsDGom54n2ZXWu+a935
	OFSbndxI9wp9/RKZZltxU/bJ5NqlQteXfv7s9r0TKcoaAmR4XT0Q6d4u2FdN9Gm83NfDij3fGEl
	V6EkTL8pJjhedg22DZ2NR6e1kCXG14mPewWhuEK8t4KNxm0GBEUD8PSp33Zj6arPYVgcEo13Paf
	P/cLGmEWduXm93cN1GeFLMsYSQ9jPPc4Aiy5xzpGQukC4+HbNzKuOJG/nd7+2F
X-Google-Smtp-Source: AGHT+IH4GkSRn7QKT72/bB5Mz3EPVJWJlbwj1qsH/JQqS1PLfiqRVsMtb6ixACGPzX2p2YXFvj7ADw==
X-Received: by 2002:a05:690e:d84:b0:641:f5bc:697f with SMTP id 956f58d0204a3-64555658b56mr2475405d50.75.1765576982950;
        Fri, 12 Dec 2025 14:03:02 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e748edd38sm901957b3.21.2025.12.12.14.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 14:03:02 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: mic@digikod.net
Cc: gnoack@google.com,
	jack@suse.cz,
	linux-security-module@vger.kernel.org,
	m@maowtm.org,
	utilityemal77@gmail.com,
	xandfury@gmail.com
Subject: Re: [PATCH v4 1/5] landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT
Date: Fri, 12 Dec 2025 17:02:59 -0500
Message-ID: <20251212220300.542362-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251212.Iuracooqu0es@digikod.net>
References: <20251212.Iuracooqu0es@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/12/25 08:27, Mickaël Salaün wrote:
> Thanks for this patch series.  This feature would be useful, but the
> related patches add a lot of new code.  We should try to minimize that
> as much as possible, especially when similar/close logic already exist
> (e.g. path walk).

Agreed. I would like to get this patch much smaller. I'm glad you think the
feature is useful, it was a personal usecase that motivated me to make this
patch originally but I think having it would benefit a lot of downstream
projects.

I appreciate your patience and willingness to work with someone new to
kernel development and landlock. :)

> On Sat, Dec 06, 2025 at 08:51:27PM -0500, Justin Suess wrote:
>> Implements a flag to prevent access grant inheritance within the filesystem
>> hierarchy for landlock rules.
>>
>> If a landlock rule on an inode has this flag, any access grants on parent
>> inodes will be ignored. Moreover, operations that involve altering the
>> ancestors of the subject with LANDLOCK_ADD_RULE_NO_INHERIT will be
>> denied up to the VFS root (new in v4).
>>
>> For example, if /a/b/c/ = read only + LANDLOCK_ADD_RULE_NO_INHERIT and
>> / = read write, writes to files in /a/b/c will be denied. Moreover,
>> moving /a to /bad, removing /a/b/c, or creating links to /a will be
>> prohibited.
>>
>> Parent flag inheritance is automatically suppressed by the permission
>> harvesting logic, which will finish processing early if all relevant
>> layers are tagged with NO_INHERIT.
>>
>> And if / has LANDLOCK_ADD_RULE_QUIET, /a/b/c will still audit (handled)
>> accesses. This is because LANDLOCK_ADD_RULE_NO_INHERIT also
>> suppresses flag inheritance from parent objects.
>>
>> The parent directory restrictions mitigate sandbox-restart attacks. For
>> example, if a sandboxed program is able to move a
>> LANDLOCK_ADD_RULE_NO_INHERIT restricted directory, upon sandbox restart,
>> the policy applied naively on the same filenames would be invalid.
>> Preventing these operations mitigates these attacks.
>>
>
> Your Signed-off-by and Cc should be here, followed by "---", followed by
> the changelog (to exclude it from the git message e.g., when using
> git am).
>

Gotcha. I'll make sure to fix that.

>> v3..v4 changes:
>>
>>   * Rebased on v6 of Tingmao Wang's "quiet flag" series.
>>   * Removed unnecessary mask_no_inherit_descendant_layers and related
>>     code at Tingmao Wang's suggestion, simplifying patch.
>>   * Updated to use new disconnected directory handling.
>>   * Improved WARN_ON_ONCE usage. (Thanks Tingmao Wang!)
>>   * Removed redundant loop for single-layer rulesets (again thanks Tingmao
>>     Wang!)
>>   * Protections now apply up to the VFS root, not just the mountpoint.
>>   * Indentation fixes.
>>   * Removed redundant flag marker blocked_flag_masks.
>>
>> v2..v3 changes:
>>
>>   * Parent directory topology protections now work by lazily
>>     inserting blank rules on parent inodes if they do not
>>     exist. This replaces the previous xarray implementation
>>     with simplified logic.
>>   * Added an optimization to skip further processing if all layers
>>     collected have no inherit.
>>   * Added support to block flag inheritance.
>>
>> Cc: Tingmao Wang <m@maowtm.org>
>> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
>> ---
>>  security/landlock/fs.c      | 389 +++++++++++++++++++++++++++++++++++-
>>  security/landlock/ruleset.c |  19 +-
>>  security/landlock/ruleset.h |  29 ++-
>>  3 files changed, 433 insertions(+), 4 deletions(-)
>>
>> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
>> index 0b589263ea42..7b0b77859778 100644
>> --- a/security/landlock/fs.c
>> +++ b/security/landlock/fs.c
>> @@ -317,6 +317,207 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
>>  	LANDLOCK_ACCESS_FS_IOCTL_DEV)
>>  /* clang-format on */
>>  
>> +static const struct landlock_rule *find_rule(const struct landlock_ruleset *const domain,
>> +					     const struct dentry *const dentry);
>> +
>> +/**
>> + * landlock_domain_layers_mask - Build a mask covering all layers of a domain
>> + * @domain: The ruleset (domain) to inspect.
>> + *
>> + * Return a layer mask with a 1 bit for each existing layer of @domain.
>> + * If @domain has no layers 0 is returned.  If the number of layers is
>> + * greater than or equal to the number of bits in layer_mask_t, all bits
>> + * are set.
>> + */
>> +static layer_mask_t landlock_domain_layers_mask(const struct landlock_ruleset
>> +						*const domain)
>> +{
>> +	if (!domain || !domain->num_layers)
>> +		return 0;
>> +
>> +	if (domain->num_layers >= sizeof(layer_mask_t) * BITS_PER_BYTE)
>> +		return (layer_mask_t)~0ULL;
>> +
>> +	return GENMASK_ULL(domain->num_layers - 1, 0);
>> +}
>> +
>> +/**
>> + * rule_blocks_all_layers_no_inherit - check whether a rule disables inheritance
>> + * @domain_layers_mask: Mask describing the domain's active layers.
>> + * @rule: Rule to inspect.
>> + *
>> + * Return true if every layer present in @rule has its no_inherit flag set
>> + * and the set of layers covered by the rule equals @domain_layers_mask.
>> + * This indicates that the rule prevents inheritance on all layers of the
>> + * domain and thus further walking for inheritance checks can stop.
>> + */
>> +static bool rule_blocks_all_layers_no_inherit(const layer_mask_t domain_layers_mask,
>> +					      const struct landlock_rule *const rule)
>> +{
>> +	layer_mask_t rule_layers = 0;
>> +	u32 layer_index;
>> +
>> +	if (!domain_layers_mask || !rule)
>> +		return false;
>> +
>> +	for (layer_index = 0; layer_index < rule->num_layers; layer_index++) {
>> +		const struct landlock_layer *const layer =
>> +			&rule->layers[layer_index];
>> +		const layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
>> +
>> +		if (!layer->flags.no_inherit)
>> +			return false;
>> +
>> +		rule_layers |= layer_bit;
>> +	}
>> +
>> +	return rule_layers && rule_layers == domain_layers_mask;
>> +}
>> +
>> +/**
>> + * ensure_rule_for_dentry - ensure a ruleset contains a rule entry for dentry,
>> + * inserting a blank rule if needed.
>> + * @ruleset: Ruleset to modify/inspect.  Caller must hold @ruleset->lock.
>> + * @dentry: Dentry to ensure a rule exists for.
>> + *
>> + * If no rule is currently associated with @dentry, insert an empty rule
>> + * (with zero access) tied to the backing inode.  Returns a pointer to the
>> + * rule associated with @dentry on success, NULL when @dentry is negative, or
>> + * an ERR_PTR()-encoded error if the rule cannot be created.
>> + *
>> + * This is useful for LANDLOCK_ADD_RULE_NO_INHERIT processing, where a rule
>> + * may need to be created for an ancestor dentry that does not yet have one
>> + * to properly track no_inherit flags.
>> + *
>> + * The flags are set to zero if a rule is newly created, and the caller
>> + * is responsible for setting them appropriately.
>> + *
>> + * The returned rule pointer's lifetime is tied to @ruleset.
>> + */
>> +static const struct landlock_rule *
>> +ensure_rule_for_dentry(struct landlock_ruleset *const ruleset,
>> +		       struct dentry *const dentry)
>> +{
>> +	struct landlock_id id = {
>> +		.type = LANDLOCK_KEY_INODE,
>> +	};
>> +	const struct landlock_rule *rule;
>> +	int err;
>> +
>> +	if (WARN_ON_ONCE(!ruleset || !dentry || d_is_negative(dentry)))
>> +		return NULL;
>> +
>> +	lockdep_assert_held(&ruleset->lock);
>> +
>> +	rule = find_rule(ruleset, dentry);
>> +	if (rule)
>> +		return rule;
>> +
>> +	id.key.object = get_inode_object(d_backing_inode(dentry));
>> +	if (IS_ERR(id.key.object))
>> +		return ERR_CAST(id.key.object);
>> +
>> +	err = landlock_insert_rule(ruleset, id, 0, 0);
>> +	landlock_put_object(id.key.object);
>> +	if (err)
>> +		return ERR_PTR(err);
>> +
>> +	rule = find_rule(ruleset, dentry);
>> +	if (WARN_ON_ONCE(!rule))
>> +		return ERR_PTR(-ENOENT);
>> +	return rule;
>> +}
>> +
>> +/**
>> + * mark_no_inherit_ancestors - mark ancestors as having no_inherit descendants
>> + * @ruleset: Ruleset to modify.  Caller must hold @ruleset->lock.
>> + * @path: Path representing the descendant that carries no_inherit bits.
>> + * @descendant_layers: Mask of layers from the descendant that should be
>> + *                     advertised to ancestors via has_no_inherit_descendant.
>> + *
>> + * Walks upward from @dentry and ensures that any ancestor rule contains the
>> + * has_no_inherit_descendant marker for the specified @descendant_layers so
>> + * parent lookups can quickly detect descendant no_inherit influence.
>> + *
>> + * Returns 0 on success or a negative errno if ancestor bookkeeping fails.
>> + */
>> +static int mark_no_inherit_ancestors(struct landlock_ruleset *ruleset,
>> +				     const struct path *const path,
>> +				     layer_mask_t descendant_layers)
>> +{
>> +	struct dentry *cursor;
>> +	struct path walk_path;
>> +	int err = 0;
>> +
>> +	if (WARN_ON_ONCE(!ruleset || !path || !path->dentry || !path->mnt ||
>> +			 !descendant_layers))
>> +		return -EINVAL;
>> +
>> +	lockdep_assert_held(&ruleset->lock);
>> +
>> +	walk_path.mnt = path->mnt;
>> +	walk_path.dentry = path->dentry;
>> +	path_get(&walk_path);
>> +
>> +	cursor = dget(walk_path.dentry);
>> +	while (cursor) {
>> +		struct dentry *parent;
>> +		const struct landlock_rule *rule;
>> +
>> +		/* Follow mounts all the way up to the root. */
>> +		if (IS_ROOT(cursor)) {
>> +			dput(cursor);
>> +			if (!follow_up(&walk_path)) {
>
> This path walk is inconsistent and a duplicate of the (correct)
> is_access_to_paths_allowed() one.  Please add a patch to factor out the
> common parts as much as possible.  Ditto for the
> collect_domain_accesses() and collect_topology_sealed_layers().
>

Total agreement from me.

It makes sense to not duplicate the path traversal code. We could do
everything in is_access_to_paths_allowed but that function is already hairy
in my opinion. What do you think about a helper function for traversal?

        enum landlock_walk_result {
	        LANDLOCK_WALK_CONTINUE,
	        LANDLOCK_WALK_STOP_REAL_ROOT,
	        LANDLOCK_WALK_STOP_INTERNAL_ROOT,
        };

        static enum landlock_walk_result landlock_walk_path(struct path *const path)
        {
        jump_up:
        	if (path->dentry == path->mnt->mnt_root) {
        		if (follow_up(path))
        			goto jump_up;
        		return LANDLOCK_WALK_STOP_REAL_ROOT;
        	}
        
        	if (unlikely(IS_ROOT(path->dentry))) {
        		if (likely(path->mnt->mnt_flags & MNT_INTERNAL))
        			return LANDLOCK_WALK_STOP_INTERNAL_ROOT;
        		dput(path->dentry);
        		path->dentry = dget(path->mnt->mnt_root);
        		return LANDLOCK_WALK_CONTINUE;
        	}
        
        	{
        		struct dentry *const parent = dget_parent(path->dentry);
        
        		dput(path->dentry);
        		path->dentry = parent;
        	}
        	return LANDLOCK_WALK_CONTINUE;
        }

The caller gets a readable enum for where they are in the traversal. This
should centralize the logic and make it easier to
understand.

>> +				cursor = NULL;
>> +				continue;
>> +			}
>> +			cursor = dget(walk_path.dentry);
>> +		}
>> +
>> +		parent = dget_parent(cursor);
>> +		dput(cursor);
>> +		if (!parent)
>> +			break;
>> +
>> +		if (WARN_ON_ONCE(d_is_negative(parent))) {
>> +			dput(parent);
>> +			break;
>> +		}
>> +		/*
>> +		 * Ensures a rule exists for the parent dentry,
>> +		 * inserting a blank one if needed.
>> +		 */
>> +		rule = ensure_rule_for_dentry(ruleset, parent);
>> +		if (IS_ERR(rule)) {
>> +			err = PTR_ERR(rule);
>> +			dput(parent);
>> +			cursor = NULL;
>> +			break;
>> +		}
>> +		if (rule) {
>> +			struct landlock_rule *mutable_rule =
>> +				(struct landlock_rule *)rule;
>> +			/*
>> +			 * Unmerged rulesets should only have one layer.
>> +			 */
>> +			if (WARN_ON_ONCE(mutable_rule->num_layers != 1)) {
>> +				dput(parent);
>> +				err = -EINVAL;
>> +				cursor = NULL;
>> +				break;
>> +			}
>> +
>> +			if (descendant_layers & BIT_ULL(0))
>> +				mutable_rule->layers[0]
>> +					.flags.has_no_inherit_descendant = true;
>> +		}
>> +
>> +		cursor = parent;
>> +	}
>> +	path_put(&walk_path);
>> +	return err;
>> +}
>
>> +/**
>> + * collect_topology_sealed_layers - collect layers sealed against topology changes
>> + * @domain: Ruleset to consult.
>> + * @dentry: Starting dentry for the upward walk.
>> + * @override_layers: Optional out parameter filled with layers that are
>> + *                   present on ancestors but considered overrides (not
>> + *                   sealing the topology for descendants).
>> + *
>> + * Walk upwards from @dentry and return a mask of layers where either the
>> + * visited dentry contains a no_inherit rule or ancestors were previously
>> + * marked as having a descendant with no_inherit.  @override_layers, if not
>> + * NULL, is filled with layers that would normally be overridden by more
>> + * specific descendant rules.
>> + *
>> + * Returns a layer mask where set bits indicate layers that are "sealed"
>> + * (topology changes like rename/rmdir are denied) for the subtree rooted at
>> + * @dentry.
>> + *
>> + * Useful for LANDLOCK_ADD_RULE_NO_INHERIT parent directory enforcement to ensure
>> + * that topology changes do not violate the no_inherit constraints.
>> + */
>> +static layer_mask_t
>> +collect_topology_sealed_layers(const struct landlock_ruleset *const domain,
>> +			       struct dentry *dentry,
>> +			       layer_mask_t *const override_layers)
>> +{
>> +	struct dentry *cursor, *parent;
>> +	bool include_descendants = true;
>> +	layer_mask_t sealed_layers = 0;
>> +
>> +	if (override_layers)
>> +		*override_layers = 0;
>> +
>> +	if (WARN_ON_ONCE(!domain || !dentry || d_is_negative(dentry)))
>> +		return 0;
>> +
>> +	cursor = dget(dentry);
>> +	while (cursor) {
>> +		const struct landlock_rule *rule;
>> +		u32 layer_index;
>> +
>> +		rule = find_rule(domain, cursor);
>> +		if (rule) {
>> +			for (layer_index = 0; layer_index < rule->num_layers;
>> +			     layer_index++) {
>> +				const struct landlock_layer *layer =
>> +					&rule->layers[layer_index];
>> +				layer_mask_t layer_bit =
>> +					BIT_ULL(layer->level - 1);
>> +
>> +				if (include_descendants &&
>> +				    (layer->flags.no_inherit ||
>> +				     layer->flags.has_no_inherit_descendant)) {
>> +					sealed_layers |= layer_bit;
>> +				} else if (override_layers) {
>> +					*override_layers |= layer_bit;
>> +				}
>> +			}
>> +		}
>> +
>> +		if (sealed_layers || IS_ROOT(cursor))
>> +			break;
>> +
>> +		parent = dget_parent(cursor);
>> +		dput(cursor);
>> +		if (!parent)
>> +			return sealed_layers;
>> +
>> +		cursor = parent;
>> +		include_descendants = false;
>> +	}
>> +	dput(cursor);
>> +	return sealed_layers;
>> +}
