Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1952D0C92
	for <linux-security-module@vger.kernel.org>; Sat,  6 Dec 2025 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765034793; cv=none; b=OmCWsz0fzIHt6KVivFtOtW7LH5llG81scWRoRZltmjbfyUvWtAoXHTI66eAXZLxx541FY7EQhzI6wI8wqoDzayaJ/ydT1rsVrlpPPYvj++Fkk2JSanFaMsb6vM680BqN8CoNwZ2hPAvHBCIS6CbYHWDs4dreHvD8bCU4Ap/x9TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765034793; c=relaxed/simple;
	bh=TOKb0MRqG29zYeeNjQ0obuUwMs0cfFI5ktQYYmBW28c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gaFp+PJp9wd4UF7UXRfg/KmiuVtl52d6EN3YXEtcgsRStw+UvTmv0hrNlsg/IkSobrijGDcKJQNQCH9gkoMLv2yjkSvXLdz04mHvvwiZ3xg54n5+qEsbso3tmPGjE9/qPiOAM0sZv0K1CtDubT3vOYEh/SP0qtcuY7tF0KdRX7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8OMNmkW; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8OMNmkW"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-641e942242cso2893129d50.1
        for <linux-security-module@vger.kernel.org>; Sat, 06 Dec 2025 07:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765034788; x=1765639588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCTJZ9QXkIzz0Sve3kVaYXzAuXj0yw3EIbSed6WNkk8=;
        b=g8OMNmkWcOY/GpcNdzET5azvOHoX/kUaM6hhcdkNsZSFYfgVwm40xYUJAVRWwcJHUk
         HuNCVt1Wfpi2zctk4a+wEKOK47pzqbJl4SCnlyBHO103qOaP0q8EbBmF/e3nSIK5Wjyz
         7woF37K8uJzmw3yL09N22e66sAqGzcGX3Tv9mSSafMokq73TqEqMe7l2P1epbzXQFZ//
         rQGbPRkEKbt4y8lXoy8YdDb1/DqT5lYhHIat3HtugWlfNO9f1i/UB5k0UG7dbxYf6ohD
         iAT/EXFUstEQJ6Na6HpXQ/R/leIgcJxmDLgxMKBeIql0wuDVvST4qfJ4gDTfv+X65Y4U
         5X9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765034788; x=1765639588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NCTJZ9QXkIzz0Sve3kVaYXzAuXj0yw3EIbSed6WNkk8=;
        b=G2KDsL/GXZeXw5FRm2BDtSdlb1gLxOumOMUtSLrwUSZfiPbrAOduTC8UbmjtUsIr7I
         JRPn4reipJQSXdg7hHkJ48+5qFwx4+0y8tL39FjkvjLtKhf/UhKUh/Ui9/i+gcaEyhsU
         oiyy1xwVHbglL/yH+7yVpTPYDzhG4fmKUTNS2/cY9YxLfgis9w2Ar6y0G00Q2VNkgFAm
         sMA9TOWUSW1qXckxjTROgp5QTJodxu/hx1OkOGRoSQ2aG+l84hNv6kxXw5/J9oJsf+Nw
         3kXSmkKcsl2IIg6GY6KkuH7jBHOAiNaOILJW6LjxcSF10z1H/UXe7+VZ5XDLOzrZstd1
         WY9g==
X-Forwarded-Encrypted: i=1; AJvYcCXXbTnF/3ovK7Eg5Qc0Lnsl2R8SiGnXcUFsNrjgn+2nLqbLlTQYHkuEnqNfx8tbENLRdRJ1qlGxnPc1szrCzkt1oYxEGSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvCLEC+cbNKuhkaDOXcV7ExUJpJ9pdKwxocSdm6MsczuHO7adf
	uSE17I/lVPYvcvipoSCSuL4wT2+AOuHlmnlg7FR3/rhI1vGjR7OB6CtW
X-Gm-Gg: ASbGncvTtqgeIKvTgHeAKEwkBCo8T+/28gLnhkkTbC/UTkGhCvC0Xz8FsumqgGpQztI
	MwT6E7rQ0X8SbGqnRhx/KZVPdn6CRgQBih2sIc1wELZkO6Rz4cflLL8NygtDCyzDDxu4WTe4/3U
	kEdRuWgt9G9jIkiZ/yp3iuG5QW859uenHjjXRZiWqMvsPGkfymU42pPFdp3A/SljGQfYi/1jqMw
	PtXgSVIce8Y+aq/fVzprZO85gXTDJa+MAPkisJwBwY2zUyf0IM4m1lGk6cPm7jIn5f5mST8smPo
	9IrImj9Ms/HUlmmmHO6Vkn6w6tZ1EfpJT76Ea614TqrQ6890BRupZj4rR5js/Jh9f/JiYIVh3aV
	GZl2Fa/LfG5UsBklVhup9Jicrq6KFXY1NXSk28vzYLfiYPASEgZy0USfBjZ2kn/MI5yJ7jF7gG7
	bIDhtHNCVPuLW0Bn3jmnl22B0dUTRyZL1Fl1VNdidmzQFgKJcTOtfNw6CkrmIO
X-Google-Smtp-Source: AGHT+IEd5VD1RDgjL7geREZ9aFfxu0g/Y/1iHfHTDNOPrk0ujnSNsb3z3THnm8ZK2qSTNrMOhyOoHQ==
X-Received: by 2002:a05:690c:4d48:b0:786:87b1:9633 with SMTP id 00721157ae682-78c33c07ccemr23978427b3.32.1765034788069;
        Sat, 06 Dec 2025 07:26:28 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b78e670sm28352607b3.45.2025.12.06.07.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 07:26:27 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: m@maowtm.org
Cc: gnoack@google.com,
	jack@suse.cz,
	linux-security-module@vger.kernel.org,
	mic@digikod.net,
	utilityemal77@gmail.com,
	xandfury@gmail.com
Subject: Re: [PATCH v3 1/5] landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT
Date: Sat,  6 Dec 2025 10:26:10 -0500
Message-ID: <20251206152611.442312-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <c314e302-d4ca-4a39-81ba-d4a1e21b9391@maowtm.org>
References: <c314e302-d4ca-4a39-81ba-d4a1e21b9391@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thank you for the review.

I agree with the bind mount limitations for this flag. I think it's
reasonable to expect the sandboxer to provide protections for pre-
existing bind mounts as opposed to the kernel.

This limitation is a tradeoff between safety and complexity.

I looked into doing in automatically, and it ends up being sort of a
mess, and you end up having to iterate through the bind mounts, and I
suspect it would be a major performance hit, especially if we have to
account for changes outside the sandbox after the policy is already
enforced.

We can note this limitation in the docs.

> On 11/26/25 12:20, Justin Suess wrote:
>> Implements a flag to prevent access grant inheritance within the filesys
tem hierarchy
>> for landlock rules.
>>
>> If a landlock rule on an inode has this flag, any access grants on paren
t inodes will be
>> ignored. Moreover, operations that involve altering the direct parent tr
ee of the subject with
> I feel like the wording "direct parent tree" is a bit unclear - I think
> what you meant is "altering the parent of the subject or its ancestors",
> right?
>

Yes. I think that wording is more clear and use that from now on.

It just means if we have /a/b/c, the protected ancestors are /a/b and /a,
but not /a/x/ for instance.

>> LANDLOCK_ADD_RULE_NO_INHERIT will be denied up to the mountpoint.
> Tbh I'm not entirely clear on why we only deny rename of parents up to th
e
> mountpoint.

I agree.

My initial reasoning for not doing so was the fact that a mountpoint
doesn't let you move any of its ancestors.

So I thought going past the mountpoint was redundant.


    $ sudo mount --bind test test2
    $ mv test2 test3
    mv: cannot move 'test2' to 'test3': Device or resource busy

But I did not consider the fact that you can still link to a parent and
bypass restrictions that way. So the next patch version will fix this issue.

I implemented protections beyond the mountpoint in my current tree using
follow_up.

>> Additionally (new in v3) parent flag inheritance is blocked by this flag
, allowing fine
>> grained access control over LANDLOCK_ADD_RULE_QUIET.
>>
>> For example, if /a/b/c/ = read only + LANDLOCK_ADD_RULE_NO_INHERIT and /
 = read write, writes to
>> files in /a/b/c will be denied. Moreover, moving /a to /bad, removing /a
/b/c, or creating links to
>> /a will be prohibited.
>>
>> And if / has LANDLOCK_ADD_RULE_QUIET, /a/b/c will still audit (handled)
>> accesses. This is because LANDLOCK_ADD_RULE_NO_INHERIT also
>> suppresses flag inheritance from parent objects.
>>
>> The parent directory restrictions mitigate sandbox-restart attacks. For 
example, if a sandboxed program
>> is able to move a LANDLOCK_ADD_RULE_NO_INHERIT restricted directory, upo
n sandbox restart, the policy
>> applied naively on the same filenames would be invalid. Preventing these
 operations mitigates these attacks.
>>
>> v2..v3 changes:
>>
>>   * Parent directory topology protections now work by lazily
>>     inserting blank rules on parent inodes if they do not
>>     exist. This replaces the previous xarray implementation
>>     with simplified logic.
>>   * Added an optimization to skip further processing if all layers colle
cted
>>     no inherit.
>>   * Added support to block flag inheritance.
>>
>> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
>> ---
>>  security/landlock/audit.c   |   4 +-
>>  security/landlock/domain.c  |   4 +-
>>  security/landlock/fs.c      | 592 +++++++++++++++++++++++++++++++++++-
>>  security/landlock/ruleset.c |  27 +-
>>  security/landlock/ruleset.h |  36 ++-
>>  5 files changed, 645 insertions(+), 18 deletions(-)
>>
>> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
>> index d51563712325..4da97dd6985c 100644
>> --- a/security/landlock/audit.c
>> +++ b/security/landlock/audit.c
>> @@ -588,7 +588,9 @@ void landlock_log_denial(const struct landlock_cred_
security *const subject,
>>  				subject->domain, &missing, request->layer_m
asks,
>>  				request->layer_masks_size);
>>  			object_quiet_flag = !!(request->rule_flags.quiet_ma
sks &
>> -					       BIT(youngest_layer));
>> +				       BIT(youngest_layer)) &&
>> +				!(request->rule_flags.blocked_flag_masks &
>> +				  BIT(youngest_layer));
>>  		} else {
>>  			youngest_layer = get_layer_from_deny_masks(
>>  				&missing, request->all_existing_optional_ac
cess,
>> diff --git a/security/landlock/domain.c b/security/landlock/domain.c
>> index 8caf07250328..5bd83865c87d 100644
>> --- a/security/landlock/domain.c
>> +++ b/security/landlock/domain.c
>> @@ -236,7 +236,9 @@ optional_access_t landlock_get_quiet_optional_access
es(
>>  			 BITS_PER_TYPE(access_mask_t)) {
>>  		const u8 layer = (deny_masks >> (access_index * 4)) &
>>  				 (LANDLOCK_MAX_NUM_LAYERS - 1);
>> -		const bool is_quiet = !!(rule_flags.quiet_masks & BIT(layer
));
>> +		const layer_mask_t layer_bit = BIT(layer);
>> +		const bool is_quiet = !!(rule_flags.quiet_masks & layer_bit
) &&
>> +				  !(rule_flags.blocked_flag_masks & layer_b
it);
>>
>>  		if (is_quiet)
>>  			quiet_optional_accesses |= BIT(access_index);
>> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
>> index 29f10da32141..0a5c73f18f26 100644
>> --- a/security/landlock/fs.c
>> +++ b/security/landlock/fs.c
>> @@ -317,6 +317,206 @@ static struct landlock_object *get_inode_object(st
ruct inode *const inode)
>>  	LANDLOCK_ACCESS_FS_IOCTL_DEV)
>>  /* clang-format on */
>>
>> +static const struct landlock_rule *find_rule(const struct landlock_rule
set *const domain,
>> +					     const struct dentry *const den
try);
>> +
>> +/**
>> + * landlock_domain_layers_mask - Build a mask covering all layers of a 
domain
>> + * @domain: The ruleset (domain) to inspect.
>> + *
>> + * Return a layer mask with a 1 bit for each existing layer of @domain.
>> + * If @domain has no layers 0 is returned.  If the number of layers is
>> + * greater than or equal to the number of bits in layer_mask_t, all bit
s
>> + * are set.
>> + */
>> +static layer_mask_t landlock_domain_layers_mask(const struct landlock_r
uleset
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
>> + * rule_blocks_all_layers_no_inherit - check whether a rule disables in
heritance
>> + * @domain_layers_mask: Mask describing the domain's active layers.
>> + * @rule: Rule to inspect.
>> + *
>> + * Return true if every layer present in @rule has its no_inherit flag 
set
>> + * and the set of layers covered by the rule equals @domain_layers_mask
.
>> + * This indicates that the rule prevents inheritance on all layers of t
he
>> + * domain and thus further walking for inheritance checks can stop.
>> + */
>> +static bool rule_blocks_all_layers_no_inherit(const layer_mask_t domain
_layers_mask,
>> +					      const struct landlock_rule *c
onst rule)
>> +{
>> +	layer_mask_t rule_layers = 0;
>> +	u32 layer_index;
>> +
>> +	if (!domain_layers_mask || !rule)
>> +		return false;
>> +
>> +	for (layer_index = 0; layer_index < rule->num_layers; layer_index++
) {
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
>> + * landlock_collect_no_inherit_layers - Collects layers with no_inherit
 flags
>> + */
> Note likely misplaced comment here

Gotcha. Probably a mistake while rebasing.

>
>
>> +/**
>> + * landlock_collect_no_inherit_layers - collect effective no_inherit la
yers
>> + * @ruleset: Ruleset to consult.
>> + * @dentry: Dentry used as a starting point for the upward walk.
>> + *
>> + * Walk upwards from @dentry and return a layer mask containing the lay
ers
>> + * for which either a rule on the visited dentry has the no_inherit fla
g set
>> + * or where an ancestor was previously marked as having a descendant wi
th
>> + * a no_inherit rule.  The search prefers the closest matching dentry a
nd
>> + * stops once any relevant layer bits are found or the root is reached.
>> + *
>> + * Returns a layer_mask_t where each set bit corresponds to a layer wit
h an
>> + * effective no_inherit influence for @dentry.  Returns 0 if none apply
 or if
>> + * inputs are invalid.
>> + */
>> +static layer_mask_t landlock_collect_no_inherit_layers(const struct lan
dlock_ruleset
>> +						       *const ruleset,
>> +						       struct dentry *const
 dentry)
>> +{
>> +	struct dentry *cursor, *parent;
>> +	layer_mask_t layers = 0;
>> +	bool include_descendants = true;
>> +
>> +	if (!ruleset || !dentry || d_is_negative(dentry))
>> +		return 0;
>> +
>> +	cursor = dget(dentry);
>> +	while (true) {
>> +		const struct landlock_rule *rule;
>> +		u32 layer_index;
>> +
>> +		rule = find_rule(ruleset, cursor);
>> +		if (rule) {
>> +			for (layer_index = 0; layer_index < rule->num_layer
s; layer_index++) {
>> +				const struct landlock_layer *layer = &rule-
>layers[layer_index];
>> +
>> +				if (layer->flags.no_inherit ||
>> +				    (include_descendants &&
>> +				     layer->flags.has_no_inherit_descendant
))
>> +					layers |= BIT_ULL((layer->level ?
>> +						layer->level : layer_index 
+ 1) - 1);
>> +			}
>> +		}
>> +
>> +		if (layers) {
>> +			dput(cursor);
>> +			return layers;
>> +		}
>> +
>> +		if (IS_ROOT(cursor)) {
>> +			dput(cursor);
>> +			break;
>> +		}
>> +
>> +		parent = dget_parent(cursor);
>> +		dput(cursor);
>> +		if (!parent)
>> +			break;
>> +
>> +		cursor = parent;
>> +		include_descendants = false;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int mark_no_inherit_ancestors(struct landlock_ruleset *ruleset,
>> +				     struct dentry *dentry,
>> +				     layer_mask_t descendant_layers);
> Wouldn't you be able to avoid this declaration by moving the definition
> for ensure_rule_for_dentry and mark_no_inherit_ancestors up a bit, before
> mask_no_inherit_descendant_layers?

Good catch. I've fixed this in my working tree.

>
>
>> +
>> +/**
>> + * mask_no_inherit_descendant_layers - apply descendant no_inherit mask
ing
>> + * @domain: The ruleset (domain) to consult.
>> + * @dentry: The dentry whose descendants are considered.
>> + * @child_layers: Layers present on the child that may be subject to ma
sking.
>> + * @access_request: Accesses being requested (bitmask).
>> + * @layer_masks: Per-access layer masks to be modified in-place.
>> + * @rule_flags: Collected flags which will be updated accordingly.
>> + *
>> + * If descendant dentries have no_inherit, clear that
>> + * layer's bit from @layer_masks. Also updates @rule_flags to reflect
>> + * which layers were blocked.  Returns true if any of the @layer_masks 
were
>> + * modified, false otherwise.
>> + */
>> +static bool mask_no_inherit_descendant_layers(const struct landlock_rul
eset
>> +					      *const domain,
>> +					      struct dentry *const dentry,
>> +					      layer_mask_t child_layers,
>> +					      const access_mask_t access_re
quest,
>> +					      layer_mask_t
>> +					      (*const layer_masks)
>> +					      [LANDLOCK_NUM_ACCESS_FS],
>> +					      struct collected_rule_flags
>> +					      *const rule_flags)
>> +{
>> +	layer_mask_t descendant_layers;
>> +	const unsigned long access_req = access_request;
>> +	unsigned long access_bit;
>> +	bool changed = false;
>> +
>> +	if (!access_request || !layer_masks || !rule_flags || !dentry)
>> +		return false;
>> +	if (d_is_negative(dentry))
>> +		return false;
>> +
>> +	descendant_layers = landlock_collect_no_inherit_layers(domain, dent
ry);
>> +	{
>> +		layer_mask_t shared_layers = descendant_layers & child_laye
rs;
>> +
>> +		if (shared_layers) {
>> +			rule_flags->no_inherit_masks |= shared_layers;
>> +			rule_flags->no_inherit_desc_masks |= shared_layers;
>> +			rule_flags->blocked_flag_masks |= shared_layers;
>> +		}
>> +	}
>> +	descendant_layers &= ~child_layers;
>> +	descendant_layers &= ~rule_flags->no_inherit_masks;
>> +	if (!descendant_layers)
>> +		return false;
>> +
>> +	rule_flags->blocked_flag_masks |= descendant_layers;
>> +
>> +	for_each_set_bit(access_bit, &access_req,
>> +			 ARRAY_SIZE(*layer_masks)) {
>> +		layer_mask_t *const layer_mask = &(*layer_masks)[access_bit
];
>> +
>> +		if (*layer_mask & descendant_layers) {
>> +			*layer_mask &= ~descendant_layers;
>> +			changed = true;
>> +		}
>> +	}
>> +
>> +	if (!changed)
>> +		return false;
>> +
>> +	rule_flags->no_inherit_masks |= descendant_layers;
>> +	rule_flags->no_inherit_desc_masks |= descendant_layers;
>> +
>> +	return true;
>> +}
>> +
>>  /*
>>   * @path: Should have been checked by get_path_from_fd().
>>   */
>> @@ -325,12 +525,13 @@ int landlock_append_fs_rule(struct landlock_rulese
t *const ruleset,
>>  			    access_mask_t access_rights, const int flags)
>>  {
>>  	int err;
>> +	const bool is_dir = d_is_dir(path->dentry);
>>  	struct landlock_id id = {
>>  		.type = LANDLOCK_KEY_INODE,
>>  	};
>>
>>  	/* Files only get access rights that make sense. */
>> -	if (!d_is_dir(path->dentry) &&
>> +	if (!is_dir &&
>>  	    (access_rights | ACCESS_FILE) != ACCESS_FILE)
>>  		return -EINVAL;
>>  	if (WARN_ON_ONCE(ruleset->num_layers != 1))
>> @@ -344,13 +545,43 @@ int landlock_append_fs_rule(struct landlock_rulese
t *const ruleset,
>>  		return PTR_ERR(id.key.object);
>>  	mutex_lock(&ruleset->lock);
>>  	err = landlock_insert_rule(ruleset, id, access_rights, flags);
>> +	if (!err && (flags & LANDLOCK_ADD_RULE_NO_INHERIT)) {
>> +		const struct landlock_rule *rule;
>> +		layer_mask_t descendant_layers = 0;
>> +		u32 layer_index;
>> +
>> +		rule = find_rule(ruleset, path->dentry);
>> +		if (rule) {
>> +			for (layer_index = 0; layer_index < rule->num_layer
s; layer_index++) {
> This function is only called to add rules to an "unmerged" ruleset, which
> will always only have one layer.  So probably this can just be a
>
> 	err = landlock_insert_rule(ruleset, id, access_rights, flags);
> 	if (err)
> 		goto out_unlock;
> 	if (flags & LANDLOCK_ADD_RULE_NO_INHERIT) {
> 		err = mark_no_inherit_ancestors(ruleset, path->dentry);
> 		if (err)
> 			goto out_unlock;
> 	}
>
> And for a similar reason, you don't have to do a for(layer_index) in
> mark_no_inherit_ancestors either.  (Basically I think you would just set
> rule->layers[0].flags.has_no_inherit_descendant to true)
>
> It might be helpful to validate / document this reasoning by adding
> WARN_ONCE(rule->num_layers != 1, "unmerged rulesets should only have one
> layer") either here or in mark_no_inherit_ancestors.

Ah ok I see. I assume WARN_ONCE just is a kernel indicator of "hey this
state shouldn't happen".

And I got rid of the for loop and fixed it to use logic like the above,
and all tests passed. It will be in the next version.

>
>
>> +				const struct landlock_layer *layer =
>> +					&rule->layers[layer_index];
>> +
>> +				if (layer->flags.no_inherit ||
>> +				    layer->flags.has_no_inherit_descendant)
>> +					descendant_layers |=
>> +						BIT_ULL((layer->level ?
>> +							 layer->level : lay
er_index + 1) - 1);
>> +			}
>> +			if (descendant_layers) {
>> +				err = mark_no_inherit_ancestors(ruleset, pa
th->dentry,
>> +								descendant_
layers);
>> +				if (err)
>> +					goto out_unlock;
>> +			}
>> +		}
>> +	}
>>  	mutex_unlock(&ruleset->lock);
>> +out:
>>  	/*
>>  	 * No need to check for an error because landlock_insert_rule()
>>  	 * increments the refcount for the new object if needed.
>>  	 */
>>  	landlock_put_object(id.key.object);
>>  	return err;
>> +
>> +out_unlock:
>> +	mutex_unlock(&ruleset->lock);
>> +	goto out;
>>  }
>>
>>  /* Access-control management */
>> @@ -382,6 +613,134 @@ find_rule(const struct landlock_ruleset *const dom
ain,
>>  	return rule;
>>  }
>>
>> +/**
>> + * ensure_rule_for_dentry - ensure a ruleset contains a rule entry for 
dentry,
>> + * inserting a blank rule if needed.
>> + * @ruleset: Ruleset to modify/inspect.  Caller must hold @ruleset->loc
k.
>> + * @dentry: Dentry to ensure a rule exists for.
>> + *
>> + * If no rule is currently associated with @dentry, insert an empty rul
e
>> + * (with zero access) tied to the backing inode.  Returns a pointer to 
the
>> + * rule associated with @dentry on success, NULL when @dentry is negati
ve, or
>> + * an ERR_PTR()-encoded error if the rule cannot be created.
>> + *
>> + * This is useful for LANDLOCK_ADD_RULE_NO_INHERIT processing, where a 
rule
>> + * may need to be created for an ancestor dentry that does not yet have
 one
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
>> +	if (!ruleset || !dentry || d_is_negative(dentry))
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
>> +	return rule ? rule : ERR_PTR(-ENOENT);
> I feel like this deserves a WARN_ON_ONCE(!rule) before this line - we
> don't really expect to not find a rule right after adding it.
>
> On the other hand, the only reason why we need to re-lookup the rule seem
s
> to be because landlock_insert_rule() does not return the newly added rule
.
> We could change it to do so, and not have to do this extra lookup.
>
> This also nicely solves the constness issue - landlock_insert_rule could
> return the mutable pointer.

I agree, but I'll hold off on changing landlock_insert_rule to keep the
patch scoped. The mutable cast thing seemed like a hack to me too when I
was doing it. Maybe returning a pointer or an ERR_PTR in landlock_insert_rule?

I'll add the WARN_ON_ONCE too.

>> +}
>> +
>> +/**
>> + * mark_no_inherit_ancestors - mark ancestors as having no_inherit desc
endants
>> + * @ruleset: Ruleset to modify.  Caller must hold @ruleset->lock.
>> + * @dentry: Dentry representing the descendant that carries no_inherit 
bits.
>> + * @descendant_layers: Mask of layers from the descendant that should b
e
>> + *                     advertised to ancestors via has_no_inherit_desce
ndant.
>> + *
>> + * Walks upward from @dentry and ensures that any ancestor rule contain
s the
>> + * has_no_inherit_descendant marker for the specified @descendant_layer
s so
>> + * parent lookups can quickly detect descendant no_inherit influence.
>> + *
>> + * Returns 0 on success or a negative errno if ancestor bookkeeping fai
ls.
>> + */
>> +static int mark_no_inherit_ancestors(struct landlock_ruleset *ruleset,
>> +				     struct dentry *dentry,
>> +				     layer_mask_t descendant_layers)
>> +{
>> +	struct dentry *cursor;
>> +	u32 layer_index;
>> +	int err = 0;
>> +
>> +	if (!ruleset || !dentry || !descendant_layers)
>> +		return -EINVAL;
>> +
>> +	lockdep_assert_held(&ruleset->lock);
>> +
>> +	cursor = dget(dentry);
>> +	while (cursor) {
>> +		struct dentry *parent;
>> +
>> +		if (IS_ROOT(cursor)) {
>> +			dput(cursor);
>> +			break;
>> +		}
>> +
>> +		parent = dget_parent(cursor);
>> +		dput(cursor);
>> +		if (!parent)
>> +			break;
>> +
>> +		if (!d_is_negative(parent)) {
> My understanding is that if the child is not negative (which is required
> for us to actually get here), as long as we always have a reference to it
,
> none of its parents should be negative as well.  This should probably be 
a
> WARN_ON_ONCE(d_is_negative(parent)).
>
> I think some of the other d_is_negative() checks in this patch also have 
a
> similar argument (i.e. turn into WARN_ON_ONCE or be removed if not
> necessary), but I've not looked at them all.
>

I'll do a pass and see. Again some of my understanding of the code is still
in the "I think I know what it's doing but not why" stage so missing that
is on me.

>> +			const struct landlock_rule *rule;
>> +			/* Ensures a rule exists for the parent dentry,
>> +			 * inserting a blank one if needed
>> +			 */
>> +			rule = ensure_rule_for_dentry(ruleset, parent);
>> +			if (IS_ERR(rule)) {
>> +				err = PTR_ERR(rule);
>> +				dput(parent);
>> +				cursor = NULL;
>> +				break;
>> +			}
>> +			if (rule) {
>> +				struct landlock_rule *mutable_rule =
>> +					(struct landlock_rule *)rule;
>> +
>> +				for (layer_index = 0;
>> +				     layer_index < mutable_rule->num_layers
;
>> +				     layer_index++) {
>> +					struct landlock_layer *layer =
>> +						&mutable_rule->layers[layer
_index];
>> +					layer_mask_t layer_bit =
>> +						BIT_ULL((layer->level ?
>> +							layer->level : laye
r_index + 1) - 1);
>> +
>> +					if (descendant_layers & layer_bit)
>> +						layer->flags.has_no_inherit
_descendant = true;
>> +				}
>> +			}
>> +		}
>> +
>> +		cursor = parent;
>> +	}
>> +	return err;
>> +}
>> +
>>  /*
>>   * Allows access to pseudo filesystems that will never be mountable (e.
g.
>>   * sockfs, pipefs), but can still be reachable through
>> @@ -764,6 +1123,8 @@ static bool is_access_to_paths_allowed(
>>  	struct landlock_request *const log_request_parent2,
>>  	struct dentry *const dentry_child2)
>>  {
>> +	const layer_mask_t domain_layers_mask =
>> +		landlock_domain_layers_mask(domain);
>>  	bool allowed_parent1 = false, allowed_parent2 = false, is_dom_check
,
>>  	     is_dom_check_bkp, child1_is_directory = true,
>>  	     child2_is_directory = true;
>> @@ -778,6 +1139,13 @@ static bool is_access_to_paths_allowed(
>>  	struct collected_rule_flags *rule_flags_parent1 = &log_request_pare
nt1->rule_flags;
>>  	struct collected_rule_flags *rule_flags_parent2 = &log_request_pare
nt2->rule_flags;
>>  	struct collected_rule_flags _rule_flag_parent1_bkp, _rule_flag_pare
nt2_bkp;
>> +	layer_mask_t child1_layers = 0;
>> +	layer_mask_t child2_layers = 0;
>> +
>> +	if (dentry_child1)
>> +		child1_layers = landlock_collect_no_inherit_layers(domain, 
dentry_child1);
>> +	if (dentry_child2)
>> +		child2_layers = landlock_collect_no_inherit_layers(domain, 
dentry_child2);
>>
>>  	if (!access_request_parent1 && !access_request_parent2)
>>  		return true;
>> @@ -931,6 +1299,10 @@ static bool is_access_to_paths_allowed(
>>  					       ARRAY_SIZE(*layer_masks_pare
nt2),
>>  					       rule_flags_parent2);
>>
>> +		if (rule &&
>> +		    rule_blocks_all_layers_no_inherit(domain_layers_mask, r
ule))
>> +			break;
>> +
>>  		/* Stops when a rule from each layer grants access. */
>>  		if (allowed_parent1 && allowed_parent2) {
>>  			/*
>> @@ -976,8 +1348,13 @@ static bool is_access_to_paths_allowed(
>>  					memcpy(&_rule_flag_parent2_bkp,
>>  					       rule_flags_parent2,
>>  					       sizeof(_rule_flag_parent2_bk
p));
>> -					is_dom_check_bkp = is_dom_check;
>>  				}
>> +				is_dom_check_bkp = is_dom_check;
>> +				child1_layers = landlock_collect_no_inherit
_layers(domain,
>> +									
	   walker_path
>> +									
	   .dentry);
>> +				if (layer_masks_parent2)
>> +					child2_layers = child1_layers;
>>
>>  				/* Ignores hidden mount points. */
>>  				goto jump_up;
>> @@ -1001,15 +1378,50 @@ static bool is_access_to_paths_allowed(
>>  				break;
>>  			}
>>
>> -			/*
>> -			 * We reached a disconnected root directory from a 
bind mount, and
>> -			 * we need to reset the walk to the current mount r
oot.
>> -			 */
>> -			goto reset_to_mount_root;
>> -		}
>> -		parent_dentry = dget_parent(walker_path.dentry);
>> -		dput(walker_path.dentry);
>> -		walker_path.dentry = parent_dentry;
>> +		/*
>> +		 * We reached a disconnected root directory from a bind mou
nt, and
>> +		 * we need to reset the walk to the current mount root.
>> +		 */
> Accidental change of indentation?

I'll fix that. Guess checkpatch.pl didn't catch it.

>
>
>> +		goto reset_to_mount_root;
>> +	}
>> +	if (likely(!d_is_negative(walker_path.dentry))) {
>> +		child1_layers = landlock_collect_no_inherit_layers(domain,
>> +								   walker_p
ath.dentry);
>> +		if (layer_masks_parent2)
>> +			child2_layers = child1_layers;
>> +	} else {
>> +		child1_layers = 0;
>> +		if (layer_masks_parent2)
>> +			child2_layers = 0;
>> +	}
>> +	parent_dentry = dget_parent(walker_path.dentry);
>> +	dput(walker_path.dentry);
>> +	walker_path.dentry = parent_dentry;
>> +	/*
>> +	 * Apply descendant no-inherit masking now that we've moved to the
>> +	 * parent. This ensures the parent respects any no-inherit rules fr
om
>> +	 * the child we just left. Only applies to refer operations (rename
/link).
>> +	 */
>> +	if (unlikely(layer_masks_parent2)) {
>> +		if (mask_no_inherit_descendant_layers(domain, walker_path.d
entry,
>> +						      child1_layers,
>> +						      access_masked_parent1
,
>> +						      layer_masks_parent1,
>> +						      rule_flags_parent1))
>> +			allowed_parent1 =
>> +				allowed_parent1 ||
>> +				is_layer_masks_allowed(layer_masks_parent1)
;
>> +
>> +		if (rule_flags_parent2 &&
>> +		    mask_no_inherit_descendant_layers(domain, walker_path.d
entry,
>> +						      child2_layers,
>> +						      access_masked_parent2
,
>> +						      layer_masks_parent2,
>> +						      rule_flags_parent2))
>> +			allowed_parent2 =
>> +				allowed_parent2 ||
>> +				is_layer_masks_allowed(layer_masks_parent2)
;
>> +	}
> Maybe I'm missing something, but I can't tell what's the purpose of this
> block, or in fact what mask_no_inherit_descendant_layers and
> landlock_collect_no_inherit_layers is for.  The doc comment for
> mask_no_inherit_descendant_layers seems to suggest that it's supposed to
> walk descendents, but landlock_collect_no_inherit_layers is actually
> walking ancestors.  Removing these checks doesn't seem to break any tests
,
> and sandboxer still seems to work as expected wrt. no_inherit rules and
> denial of renaming denied dentries and its parents.
>
> Note that the special "reverting" style disconnected directory handling
> has been removed in Mickaël's next branch (i.e. the "backup" logic is
> removed), which should hopefully simplify reasoning about this.
>

Gotcha. I think this came from some of my initial confusion going
through the codebase and making multiple changes before testing. So I
would add checks to be sure before doing a rebuild, and had a fear of
breaking it and having to wait around for a recompile.

I am still figuring out kernel debugging so sometimes I wouldn't know
what code was actually breaking the tests.

This is a big catch and reduces the LOC considerably so thank you! I
removed the checks and all tests passed, so it seems  like these were
indeed redundant.

>>  		continue;
>>
>>  reset_to_mount_root:
>> @@ -1057,6 +1469,10 @@ static bool is_access_to_paths_allowed(
>>  		dput(walker_path.dentry);
>>  		walker_path.dentry = walker_path.mnt->mnt_root;
>>  		dget(walker_path.dentry);
>> +		child1_layers = landlock_collect_no_inherit_layers(domain,
>> +								   walker_p
ath.dentry);
>> +		if (layer_masks_parent2)
>> +			child2_layers = child1_layers;
>>  	}
>>  	path_put(&walker_path);
>>
>> @@ -1172,6 +1588,8 @@ static bool collect_domain_accesses(
>>  	struct collected_rule_flags *const rule_flags)
>>  {
>>  	access_mask_t access_dom;
>> +	const layer_mask_t domain_layers_mask =
>> +		landlock_domain_layers_mask(domain);
>>  	bool ret = false;
>>
>>  	if (WARN_ON_ONCE(!domain || !mnt_dir || !dir || !layer_masks_dom))
>> @@ -1187,9 +1605,11 @@ static bool collect_domain_accesses(
>>  	while (true) {
>>  		struct dentry *parent_dentry;
>>
>> +		const struct landlock_rule *rule = find_rule(domain, dir);
>> +
>>  		/* Gets all layers allowing all domain accesses. */
>>  		if (landlock_unmask_layers(
>> -			    find_rule(domain, dir), access_dom, layer_masks
_dom,
>> +			    rule, access_dom, layer_masks_dom,
>>  			    ARRAY_SIZE(*layer_masks_dom), rule_flags)) {
>>  			/*
>>  			 * Before allowing this side of the access request,
 checks that the
>> @@ -1206,6 +1626,10 @@ static bool collect_domain_accesses(
>>  			break;
>>  		}
>>
>> +		if (rule &&
>> +		    rule_blocks_all_layers_no_inherit(domain_layers_mask, r
ule))
>> +			break;
>> +
>>  		/* Stops at the mount point. */
>>  		if (dir == mnt_dir->dentry)
>>  			break;
>> @@ -1232,6 +1656,121 @@ static bool collect_domain_accesses(
>>  	return ret;
>>  }
>>
>> +/**
>> + * collect_topology_sealed_layers - collect layers sealed against topol
ogy changes
>> + * @domain: Ruleset to consult.
>> + * @dentry: Starting dentry for the upward walk.
>> + * @override_layers: Optional out parameter filled with layers that are
>> + *                   present on ancestors but considered overrides (not
>> + *                   sealing the topology for descendants).
>> + *
>> + * Walk upwards from @dentry and return a mask of layers where either t
he
>> + * visited dentry contains a no_inherit rule or ancestors were previous
ly
>> + * marked as having a descendant with no_inherit.  @override_layers, if
 not
>> + * NULL, is filled with layers that would normally be overridden by mor
e
>> + * specific descendant rules.
>> + *
>> + * Returns a layer mask where set bits indicate layers that are "sealed
"
>> + * (topology changes like rename/rmdir are denied) for the subtree root
ed at
>> + * @dentry.
>> + *
>> + * Useful for LANDLOCK_ADD_RULE_NO_INHERIT parent directory enforcement
 to ensure
>> + * that topology changes do not violate the no_inherit constraints.
>> + */
>> +static layer_mask_t
>> +collect_topology_sealed_layers(const struct landlock_ruleset *const dom
ain,
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
>> +	if (!domain || !dentry || d_is_negative(dentry))
>> +		return 0;
>> +
>> +	cursor = dget(dentry);
>> +	while (cursor) {
>> +		const struct landlock_rule *rule;
>> +		u32 layer_index;
>> +
>> +		rule = find_rule(domain, cursor);
>> +		if (rule) {
>> +			for (layer_index = 0; layer_index < rule->num_layer
s;
>> +			     layer_index++) {
>> +				const struct landlock_layer *layer =
>> +					&rule->layers[layer_index];
>> +				const int level = layer->level ? layer->lev
el :
>> +								 layer_inde
x + 1;
> Wouldn't layer->level always be >= 1 here?  Using layer_index doesn't mak
e
> sense since layer_index is just the index that the struct landlock_layer
> happened to be in that rule's array.

Hmm good catch. I was replicating logic from other places while sometimes not realizing 
exactly why the code is doing what it does and didn't make that realization. Seems to work
fine and pass after I fixed it in my working tree so it will be in the next version.

>
>> +				layer_mask_t layer_bit = BIT_ULL(level - 1)
;
>> +
>> +				if (include_descendants &&
>> +				    (layer->flags.no_inherit ||
>> +				     layer->flags.has_no_inherit_descendant
)) {
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
>> +
>> +/**
>> + * deny_no_inherit_topology_change - deny topology changes on sealed la
yers
>> + * @subject: Subject performing the operation (contains the domain).
>> + * @dentry: Dentry that is the target of the topology modification.
>> + *
>> + * Checks whether any domain layers are sealed against topology changes
 at
>> + * @dentry (via collect_topology_sealed_layers).  If so, emit an audit 
record
>> + * and return -EACCES.  Otherwise return 0.
>> + */
>> +static int deny_no_inherit_topology_change(const struct landlock_cred_s
ecurity
>> +					   *subject,
>> +					   struct dentry *dentry)
>> +{
>> +	layer_mask_t sealed_layers;
>> +	layer_mask_t override_layers;
>> +	unsigned long layer_index;
>> +
>> +	if (!subject || !dentry || d_is_negative(dentry))
>> +		return 0;
>> +	sealed_layers = collect_topology_sealed_layers(subject->domain,
>> +						       dentry, &override_la
yers);
>> +	sealed_layers &= ~override_layers;
>> +
>> +	if (!sealed_layers)
>> +		return 0;
>> +
>> +	layer_index = __ffs((unsigned long)sealed_layers);
>> +	landlock_log_denial(subject, &(struct landlock_request) {
>> +		.type = LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY,
>> +		.audit = {
>> +			.type = LSM_AUDIT_DATA_DENTRY,
>> +			.u.dentry = dentry,
>> +		},
>> +		.layer_plus_one = layer_index + 1,
>> +	});
>> +
>> +	return -EACCES;
>> +}
>> +
>>  /**
>>   * current_check_refer_path - Check if a rename or link action is allow
ed
>>   *
>> @@ -1316,6 +1855,16 @@ static int current_check_refer_path(struct dentry
 *const old_dentry,
>>  	access_request_parent2 =
>>  		get_mode_access(d_backing_inode(old_dentry)->i_mode);
>>  	if (removable) {
>> +		int err;
>> +
>> +		err = deny_no_inherit_topology_change(subject, old_dentry);
>> +		if (err)
>> +			return err;
>> +		if (exchange) {
>> +			err = deny_no_inherit_topology_change(subject, new_
dentry);
>> +			if (err)
>> +				return err;
>> +		}
>>  		access_request_parent1 |= maybe_remove(old_dentry);
>>  		access_request_parent2 |= maybe_remove(new_dentry);
>>  	}
>> @@ -1707,12 +2256,31 @@ static int hook_path_symlink(const struct path *
const dir,
>>  static int hook_path_unlink(const struct path *const dir,
>>  			    struct dentry *const dentry)
>>  {
>> +	const struct landlock_cred_security *const subject =
>> +		landlock_get_applicable_subject(current_cred(), any_fs, NUL
L);
>> +	int err;
>> +
>> +	if (subject) {
>> +		err = deny_no_inherit_topology_change(subject, dentry);
>> +		if (err)
>> +			return err;
>> +	}
>>  	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_FIL
E);
>>  }
>>
>>  static int hook_path_rmdir(const struct path *const dir,
>>  			   struct dentry *const dentry)
>>  {
>> +	const struct landlock_cred_security *const subject =
>> +		landlock_get_applicable_subject(current_cred(), any_fs, NUL
L);
>> +	int err;
>> +
>> +	if (subject) {
>> +		err = deny_no_inherit_topology_change(subject, dentry);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>>  	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR
);
>>  }
>>
>> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
>> index 750a444e1983..f7b6a48bbf39 100644
>> --- a/security/landlock/ruleset.c
>> +++ b/security/landlock/ruleset.c
>> @@ -255,8 +255,13 @@ static int insert_rule(struct landlock_ruleset *con
st ruleset,
>>  				return -EINVAL;
>>  			if (WARN_ON_ONCE(this->layers[0].level != 0))
>>  				return -EINVAL;
>> +			/* Merge the flags into the rules */
>>  			this->layers[0].access |= (*layers)[0].access;
>>  			this->layers[0].flags.quiet |= (*layers)[0].flags.q
uiet;
>> +			this->layers[0].flags.no_inherit |=
>> +				(*layers)[0].flags.no_inherit;
>> +			this->layers[0].flags.has_no_inherit_descendant |=
>> +				(*layers)[0].flags.has_no_inherit_descendan
t;
>>  			return 0;
>>  		}
>>
>> @@ -315,7 +320,10 @@ int landlock_insert_rule(struct landlock_ruleset *c
onst ruleset,
>>  		.level = 0,
>>  		.flags = {
>>  			.quiet = !!(flags & LANDLOCK_ADD_RULE_QUIET),
>> -		},
>> +			.no_inherit = !!(flags & LANDLOCK_ADD_RULE_NO_INHER
IT),
>> +			.has_no_inherit_descendant =
>> +				!!(flags & LANDLOCK_ADD_RULE_NO_INHERIT),
>> +		}
>>  	} };
>>
>>  	build_check_layer();
>> @@ -662,9 +670,22 @@ bool landlock_unmask_layers(const struct landlock_r
ule *const rule,
>>  		unsigned long access_bit;
>>  		bool is_empty;
>>
>> -		/* Collect rule flags for each layer. */
>> -		if (rule_flags && layer->flags.quiet)
>> +		/* Skip layers that already have no inherit flags. */
>> +		if (rule_flags &&
>> +		    (rule_flags->no_inherit_masks & layer_bit))
>> +			continue;
>> +
>> +		/* Collect rule flags for each layer.
>> +		 * We block flag inheritance if needed
>> +		 * because of a no_inherit rule.
>> +		 */
>> +		if (rule_flags && layer->flags.quiet &&
>> +		    !(rule_flags->blocked_flag_masks & layer_bit))
> I don't quite understand the purpose of blocked_flag_masks - wouldn't the
> "continue;" above naturally prevent flag inheritance?

Yes, initially I thought I needed to have special handling / a marker
for this. But as you pointed out the continue skips it anyways. I'll
remove that and add a comment saying it skips over the flag inheritance
as well as a side effect.

>
>
>>  			rule_flags->quiet_masks |= layer_bit;
>> +		if (rule_flags && layer->flags.no_inherit)
>> +			rule_flags->no_inherit_masks |= layer_bit;
>> +		if (rule_flags && layer->flags.has_no_inherit_descendant)
>> +			rule_flags->no_inherit_desc_masks |= layer_bit;
>>
>>  		/*
>>  		 * Records in @layer_masks which layer grants access to eac
h requested
>> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
>> index eb60db646422..8b46ab14e995 100644
>> --- a/security/landlock/ruleset.h
>> +++ b/security/landlock/ruleset.h
>> @@ -40,6 +40,21 @@ struct landlock_layer {
>>  		 * down the file hierarchy.
>>  		 */
>>  		bool quiet:1;
>> +		/**
>> +		 * @no_inherit: Prevents this rule from being inherited by
>> +		 * descendant directories in the filesystem layer.  Only us
ed
>> +		 * for filesystem rules.
>> +		 */
>> +		bool no_inherit:1;
>> +		/**
>> +		 * @has_no_inherit_descendant: Marker to indicate that this
 layer
>> +		 * has at least one descendant directory with a rule having
 the
>> +		 * no_inherit flag.  Only used for filesystem rules.
>> +		 * This "flag" is not set by the user, but by Landlock on
>> +		 * parent directories of rules when the child rule has
>> +		 * a rule with the no_inherit flag.
>> +		 */
>> +		bool has_no_inherit_descendant:1;
>>  	} flags;
>>  	/**
>>  	 * @access: Bitfield of allowed actions on the kernel object.  They
 are
>> @@ -49,13 +64,32 @@ struct landlock_layer {
>>  };
>>
>>  /**
>> - * struct collected_rule_flags - Hold accumulated flags for each layer.
>> + * struct collected_rule_flags - Hold accumulated flags and their marke
rs for each layer.
>>   */
>>  struct collected_rule_flags {
>>  	/**
>>  	 * @quiet_masks: Layers for which the quiet flag is effective.
>>  	 */
>>  	layer_mask_t quiet_masks;
>> +	/**
>> +	 * @no_inherit_masks: Layers for which the no_inherit flag is effec
tive.
>> +	 */
>> +	layer_mask_t no_inherit_masks;
>> +	/**
>> +	 * @no_inherit_desc_masks: Layers for which the
>> +	 * has_no_inherit_descendant tag is effective.
>> +	 * This is not a flag itself, but a marker set on ancestors
>> +	 * of rules with the no_inherit flag to deny topology changes
>> +	 * in the direct parent path.
>> +	 */
>> +	layer_mask_t no_inherit_desc_masks;
>> +	/**
>> +	 * @blocked_flag_masks: Layers where flag inheritance must be block
ed
>> +	 * because of a no_inherit rule. This is not a flag itself, but a m
arker
>> +	 * for layers that have their flags blocked due to no_inherit rule
>> +	 * propagation.
>> +	 */
>> +	layer_mask_t blocked_flag_masks;
>>  };
>>
>>  /**

Thank you for the review of the patch. Trimming the code was very
satisfying. I see that the disconnected directory handling was
simplified in linux-next, which is gonna make things easier but also
make rebasing require some more careful attention. I assume your next
patch series for LANDLOCK_ADD_RULE_QUIET is going to be rebased off
those disconnected directory changes as well.

I'll implement these fixes in my working tree and be ready when you drop
your next version to do a rebase on top of your series again. If you
have a base commit SHA you could give me that you are building your next
patch series version on top of already, that would be helpful.

Kind Regards,
Justin Suess
