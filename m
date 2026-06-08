Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BAB3B3894
	for <linux-security-module@vger.kernel.org>; Mon,  8 Jun 2026 22:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780959066; cv=none; b=OkE1pgJGgMpaKkCsGfeD/QDo95UWEmbPxogEVH6/IDnnak2Z1EwDaZtUNe6Wmj3gKJrMS7IN97OtouDYl3BrS7iTWgHryKVhq+APlDmFi2/yzgDDwII4ZwZP5EDxWep90HvHEQHnppak5/Klg4GEhF+m728pouz7GPbhdXEX0ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780959066; c=relaxed/simple;
	bh=Jy5QGZYj8gRHZU0jMMjIi49iysCWMlrW1oyzpZXsQqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyZUwrQDm5oH0tEK9S0gN4FSVAd4D9r8sr28tqfsP73+5VMCV16rBNESS9raTKHjpO5CGf/iC2kH77OZcS2WT/dLnH9htQmGEl2bHtseVAkmLUNYyC18QmZ0a8YdB3E+sOMQOEk3ZuNLSvyyryDCjVl5MJKe1Y0ru6JZgbKzeok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=CrZqjH8b; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="CrZqjH8b"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gZ6TD5z8DzMP7;
	Tue,  9 Jun 2026 00:41:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1780958464;
	bh=5BRSe3oL17nZdqqhu07VR8ovtBGu09TTdvhlL1P8Ng8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CrZqjH8bFug7E9KeD/qh+m43UKZTdf5qrPcuPOgPs/dHppMBm9O7OTCckvdHQYtE3
	 7JzhEugob5zTWwwi/2HUfJDsdnZ3cX33tc4fGh3/oGFL8ur79rAc1W4ILtkZE6DvTw
	 Bvq0RG7bE0BUlenfRN8z7SdfIbdoCV2sx1RGqaLw=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gZ6TD10vKzlWM;
	Tue,  9 Jun 2026 00:41:04 +0200 (CEST)
Date: Tue, 9 Jun 2026 00:40:59 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	Justin Suess <utilityemal77@gmail.com>, Jan Kara <jack@suse.cz>, Abhinav Saxena <xandfury@gmail.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v10 1/9] landlock: Add a place for flags to layer rules
Message-ID: <20260608.ni6daelae9Qu@digikod.net>
References: <cover.1780272022.git.m@maowtm.org>
 <676e38f1c2d3f6445bdcd45be043e514f6509a3a.1780272022.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <676e38f1c2d3f6445bdcd45be043e514f6509a3a.1780272022.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Mon, Jun 01, 2026 at 01:00:35AM +0100, Tingmao Wang wrote:
> To avoid unnecessarily increasing the size of struct landlock_layer, we
> make the layer level a u8 and use the space to store the flags struct.
> 
> struct layer_access_masks is renamed to struct layer_masks, and a new
> field is added to track whether a quiet flag rule is seen for each
> layer.  Through use of bitfields, this does not increase the size of the
> struct.
> 
> Cc: Justin Suess <utilityemal77@gmail.com>
> Assisted-by: GitHub Copilot:claude-opus-4.7 copilot-review
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> Co-developed-by: Justin Suess <utilityemal77@gmail.com>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> Tested-by: Justin Suess <utilityemal77@gmail.com>
> ---
> 
> Changes in v10:
> - Doc for struct layer_mask members
> - clang-format header file changes
> - Add Tested-by for Justin Suess
> 
> Changes in v9:
> - Move a hunk from patch 2 to here
> - Fix comment and format
> - Renamed struct layer_access_masks to struct layer_masks, and moved the
>   content of struct collected_rule_flags into this struct, getting rid
>   of the extra struct collected_rule_flags and function parameters.
>   This is following a discussion in [3].  The flag is now initialized in
>   landlock_init_layer_masks as false.
> - Thus also removed now unnecessary layer_mask_t
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
> [3]: https://lore.kernel.org/all/20260524.eFiz4hahrami@digikod.net/
> 
>  security/landlock/access.h  |  39 +++++++---
>  security/landlock/audit.c   |  20 ++---
>  security/landlock/audit.h   |   2 +-
>  security/landlock/domain.c  |  19 ++---
>  security/landlock/domain.h  |   2 +-
>  security/landlock/fs.c      | 147 +++++++++++++++++++-----------------
>  security/landlock/limits.h  |   3 +
>  security/landlock/net.c     |   2 +-
>  security/landlock/ruleset.c |  33 +++++---
>  security/landlock/ruleset.h |  17 ++++-
>  10 files changed, 173 insertions(+), 111 deletions(-)
> 
> diff --git a/security/landlock/access.h b/security/landlock/access.h
> index c19d5bc13944..42d8b5134358 100644
> --- a/security/landlock/access.h
> +++ b/security/landlock/access.h
> @@ -62,18 +62,39 @@ static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
>  	      sizeof(typeof_member(union access_masks_all, all)));
>  
>  /**
> - * struct layer_access_masks - A boolean matrix of layers and access rights
> - *
> - * This has a bit for each combination of layer numbers and access rights.
> - * During access checks, it is used to represent the access rights for each
> - * layer which still need to be fulfilled.  When all bits are 0, the access
> - * request is considered to be fulfilled.
> + * struct layer_mask - The unfulfilled access rights and rule flags for

This struct could be used to store "fulfilled" access rights too.  The
previous description is more accurate.  Please keep most of the previous
description too and adjust as needed.

> + * a layer.
> + */
> +struct layer_mask {
> +	/**
> +	 * @access: During access checks, this is used to represent the access
> +	 * rights for each layer which still need to be fulfilled.  When all
> +	 * bits are 0, the access request is allowed by this layer.
> +	 */
> +	access_mask_t access : LANDLOCK_NUM_ACCESS_MAX;
> +#ifdef CONFIG_AUDIT
> +	/**
> +	 * @quiet: Whether we have encountered a rule with the quiet flag for
> +	 * this layer.  Used to control audit logging.
> +	 */
> +	bool quiet : 1;

According to compiler specifications, to make sure the struct is the
size of access_masks_t, we need:

access_masks_t quiet : 1;

> +#endif /* CONFIG_AUDIT */
> +};

Like for struct access_masks, please use
__packed __aligned(sizeof(access_mask_t)) attributes.

> +
> +/*
> + * Make sure that we don't increase the size of struct layer_mask when
> + * storing rule flags.
> + */
> +static_assert(sizeof(struct layer_mask) == sizeof(access_mask_t));
> +
> +/**
> + * struct layer_masks - An array of struct layer_mask, one per layer.
>   */
> -struct layer_access_masks {
> +struct layer_masks {
>  	/**
> -	 * @access: The unfulfilled access rights for each layer.
> +	 * @layers: The unfulfilled access rights for each layer.
>  	 */
> -	access_mask_t access[LANDLOCK_MAX_NUM_LAYERS];
> +	struct layer_mask layers[LANDLOCK_MAX_NUM_LAYERS];
>  };
>  
>  /*
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index 851647197a01..8c56f7f6467a 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -187,11 +187,11 @@ static void test_get_hierarchy(struct kunit *const test)
>  /* Get the youngest layer that denied the access_request. */
>  static size_t get_denied_layer(const struct landlock_ruleset *const domain,
>  			       access_mask_t *const access_request,
> -			       const struct layer_access_masks *masks)
> +			       const struct layer_masks *masks)
>  {
> -	for (ssize_t i = ARRAY_SIZE(masks->access) - 1; i >= 0; i--) {
> -		if (masks->access[i] & *access_request) {
> -			*access_request &= masks->access[i];
> +	for (ssize_t i = ARRAY_SIZE(masks->layers) - 1; i >= 0; i--) {
> +		if (masks->layers[i].access & *access_request) {
> +			*access_request &= masks->layers[i].access;
>  			return i;
>  		}
>  	}
> @@ -208,12 +208,12 @@ static void test_get_denied_layer(struct kunit *const test)
>  	const struct landlock_ruleset dom = {
>  		.num_layers = 5,
>  	};
> -	const struct layer_access_masks masks = {
> -		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE |
> -			     LANDLOCK_ACCESS_FS_READ_DIR,
> -		.access[1] = LANDLOCK_ACCESS_FS_READ_FILE |
> -			     LANDLOCK_ACCESS_FS_READ_DIR,
> -		.access[2] = LANDLOCK_ACCESS_FS_REMOVE_DIR,
> +	const struct layer_masks masks = {
> +		.layers[0].access = LANDLOCK_ACCESS_FS_EXECUTE |
> +				    LANDLOCK_ACCESS_FS_READ_DIR,
> +		.layers[1].access = LANDLOCK_ACCESS_FS_READ_FILE |
> +				    LANDLOCK_ACCESS_FS_READ_DIR,
> +		.layers[2].access = LANDLOCK_ACCESS_FS_REMOVE_DIR,
>  	};
>  	access_mask_t access;
>  
> diff --git a/security/landlock/audit.h b/security/landlock/audit.h
> index 56778331b58c..b85d752273ac 100644
> --- a/security/landlock/audit.h
> +++ b/security/landlock/audit.h
> @@ -43,7 +43,7 @@ struct landlock_request {
>  	access_mask_t access;
>  
>  	/* Required fields for requests with layer masks. */
> -	const struct layer_access_masks *layer_masks;
> +	const struct layer_masks *layer_masks;
>  
>  	/* Required fields for requests with deny masks. */
>  	const access_mask_t all_existing_optional_access;
> diff --git a/security/landlock/domain.c b/security/landlock/domain.c
> index 5dd06f7c2312..d1a4d8b33ee1 100644
> --- a/security/landlock/domain.c
> +++ b/security/landlock/domain.c
> @@ -184,7 +184,7 @@ static void test_get_layer_deny_mask(struct kunit *const test)
>  deny_masks_t
>  landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
>  			const access_mask_t optional_access,
> -			const struct layer_access_masks *const masks)
> +			const struct layer_masks *const masks)
>  {
>  	const unsigned long access_opt = optional_access;
>  	unsigned long access_bit;
> @@ -201,8 +201,9 @@ landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
>  	if (WARN_ON_ONCE(!access_opt))
>  		return 0;
>  
> -	for (ssize_t i = ARRAY_SIZE(masks->access) - 1; i >= 0; i--) {
> -		const access_mask_t denied = masks->access[i] & optional_access;
> +	for (ssize_t i = ARRAY_SIZE(masks->layers) - 1; i >= 0; i--) {
> +		const access_mask_t denied = masks->layers[i].access &
> +					     optional_access;
>  		const unsigned long newly_denied = denied & ~all_denied;
>  
>  		if (!newly_denied)
> @@ -222,12 +223,12 @@ landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
>  
>  static void test_landlock_get_deny_masks(struct kunit *const test)
>  {
> -	const struct layer_access_masks layers1 = {
> -		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE |
> -			     LANDLOCK_ACCESS_FS_IOCTL_DEV,
> -		.access[1] = LANDLOCK_ACCESS_FS_TRUNCATE,
> -		.access[2] = LANDLOCK_ACCESS_FS_IOCTL_DEV,
> -		.access[9] = LANDLOCK_ACCESS_FS_EXECUTE,
> +	const struct layer_masks layers1 = {
> +		.layers[0].access = LANDLOCK_ACCESS_FS_EXECUTE |
> +				    LANDLOCK_ACCESS_FS_IOCTL_DEV,
> +		.layers[1].access = LANDLOCK_ACCESS_FS_TRUNCATE,
> +		.layers[2].access = LANDLOCK_ACCESS_FS_IOCTL_DEV,
> +		.layers[9].access = LANDLOCK_ACCESS_FS_EXECUTE,
>  	};
>  
>  	KUNIT_EXPECT_EQ(test, 0x1,
> diff --git a/security/landlock/domain.h b/security/landlock/domain.h
> index 35cac8f6daee..af100a8cd939 100644
> --- a/security/landlock/domain.h
> +++ b/security/landlock/domain.h
> @@ -119,7 +119,7 @@ struct landlock_hierarchy {
>  deny_masks_t
>  landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
>  			const access_mask_t optional_access,
> -			const struct layer_access_masks *const masks);
> +			const struct layer_masks *const masks);
>  
>  int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy);
>  
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index edaa52572cbd..f7c1bc64de20 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -406,15 +406,15 @@ static const struct access_masks any_fs = {
>   * src_parent would result in having the same or fewer access rights if it were
>   * moved under new_parent.
>   */
> -static bool may_refer(const struct layer_access_masks *const src_parent,
> -		      const struct layer_access_masks *const src_child,
> -		      const struct layer_access_masks *const new_parent,
> +static bool may_refer(const struct layer_masks *const src_parent,
> +		      const struct layer_masks *const src_child,
> +		      const struct layer_masks *const new_parent,
>  		      const bool child_is_dir)
>  {
> -	for (size_t i = 0; i < ARRAY_SIZE(new_parent->access); i++) {
> -		access_mask_t child_access = src_parent->access[i] &
> -					     src_child->access[i];
> -		access_mask_t parent_access = new_parent->access[i];
> +	for (size_t i = 0; i < ARRAY_SIZE(new_parent->layers); i++) {
> +		access_mask_t child_access = src_parent->layers[i].access &
> +					     src_child->layers[i].access;
> +		access_mask_t parent_access = new_parent->layers[i].access;
>  
>  		if (!child_is_dir) {
>  			child_access &= ACCESS_FILE;
> @@ -436,11 +436,11 @@ static bool may_refer(const struct layer_access_masks *const src_parent,
>   * that child2 may be used from parent2 to parent1 without increasing its access
>   * rights), false otherwise.
>   */
> -static bool no_more_access(const struct layer_access_masks *const parent1,
> -			   const struct layer_access_masks *const child1,
> +static bool no_more_access(const struct layer_masks *const parent1,
> +			   const struct layer_masks *const child1,
>  			   const bool child1_is_dir,
> -			   const struct layer_access_masks *const parent2,
> -			   const struct layer_access_masks *const child2,
> +			   const struct layer_masks *const parent2,
> +			   const struct layer_masks *const child2,
>  			   const bool child2_is_dir)
>  {
>  	if (!may_refer(parent1, child1, parent2, child1_is_dir))
> @@ -459,25 +459,25 @@ static bool no_more_access(const struct layer_access_masks *const parent1,
>  
>  static void test_no_more_access(struct kunit *const test)
>  {
> -	const struct layer_access_masks rx0 = {
> -		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE |
> -			     LANDLOCK_ACCESS_FS_READ_FILE,
> +	const struct layer_masks rx0 = {
> +		.layers[0].access = LANDLOCK_ACCESS_FS_EXECUTE |
> +				    LANDLOCK_ACCESS_FS_READ_FILE,
>  	};
> -	const struct layer_access_masks mx0 = {
> -		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE |
> -			     LANDLOCK_ACCESS_FS_MAKE_REG,
> +	const struct layer_masks mx0 = {
> +		.layers[0].access = LANDLOCK_ACCESS_FS_EXECUTE |
> +				    LANDLOCK_ACCESS_FS_MAKE_REG,
>  	};
> -	const struct layer_access_masks x0 = {
> -		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE,
> +	const struct layer_masks x0 = {
> +		.layers[0].access = LANDLOCK_ACCESS_FS_EXECUTE,
>  	};
> -	const struct layer_access_masks x1 = {
> -		.access[1] = LANDLOCK_ACCESS_FS_EXECUTE,
> +	const struct layer_masks x1 = {
> +		.layers[1].access = LANDLOCK_ACCESS_FS_EXECUTE,
>  	};
> -	const struct layer_access_masks x01 = {
> -		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE,
> -		.access[1] = LANDLOCK_ACCESS_FS_EXECUTE,
> +	const struct layer_masks x01 = {
> +		.layers[0].access = LANDLOCK_ACCESS_FS_EXECUTE,
> +		.layers[1].access = LANDLOCK_ACCESS_FS_EXECUTE,
>  	};
> -	const struct layer_access_masks allows_all = {};
> +	const struct layer_masks allows_all = {};
>  
>  	/* Checks without restriction. */
>  	NMA_TRUE(&x0, &allows_all, false, &allows_all, NULL, false);
> @@ -565,9 +565,13 @@ static void test_no_more_access(struct kunit *const test)
>  #undef NMA_TRUE
>  #undef NMA_FALSE
>  
> -static bool is_layer_masks_allowed(const struct layer_access_masks *masks)
> +static bool is_layer_masks_allowed(const struct layer_masks *masks)
>  {
> -	return mem_is_zero(&masks->access, sizeof(masks->access));
> +	for (size_t i = 0; i < ARRAY_SIZE(masks->layers); i++) {
> +		if (masks->layers[i].access)
> +			return false;
> +	}
> +	return true;
>  }
>  
>  /*
> @@ -576,16 +580,16 @@ static bool is_layer_masks_allowed(const struct layer_access_masks *masks)
>   * Returns true if the request is allowed, false otherwise.
>   */
>  static bool scope_to_request(const access_mask_t access_request,
> -			     struct layer_access_masks *masks)
> +			     struct layer_masks *masks)
>  {
>  	bool saw_unfulfilled_access = false;
>  
>  	if (WARN_ON_ONCE(!masks))
>  		return true;
>  
> -	for (size_t i = 0; i < ARRAY_SIZE(masks->access); i++) {
> -		masks->access[i] &= access_request;
> -		if (masks->access[i])
> +	for (size_t i = 0; i < ARRAY_SIZE(masks->layers); i++) {
> +		masks->layers[i].access &= access_request;
> +		if (masks->layers[i].access)
>  			saw_unfulfilled_access = true;
>  	}
>  	return !saw_unfulfilled_access;
> @@ -596,41 +600,46 @@ static bool scope_to_request(const access_mask_t access_request,
>  static void test_scope_to_request_with_exec_none(struct kunit *const test)
>  {
>  	/* Allows everything. */
> -	struct layer_access_masks masks = {};
> +	struct layer_masks masks = {};
>  
>  	/* Checks and scopes with execute. */
>  	KUNIT_EXPECT_TRUE(test,
>  			  scope_to_request(LANDLOCK_ACCESS_FS_EXECUTE, &masks));
> -	KUNIT_EXPECT_EQ(test, 0, masks.access[0]);
> +	KUNIT_EXPECT_EQ(test, 0, (access_mask_t)masks.layers[0].access);
>  }
>  
>  static void test_scope_to_request_with_exec_some(struct kunit *const test)
>  {
>  	/* Denies execute and write. */
> -	struct layer_access_masks masks = {
> -		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE,
> -		.access[1] = LANDLOCK_ACCESS_FS_WRITE_FILE,
> +	struct layer_masks masks = {
> +		.layers[0].access = LANDLOCK_ACCESS_FS_EXECUTE,
> +		.layers[1].access = LANDLOCK_ACCESS_FS_WRITE_FILE,
>  	};
>  
>  	/* Checks and scopes with execute. */
>  	KUNIT_EXPECT_FALSE(test, scope_to_request(LANDLOCK_ACCESS_FS_EXECUTE,
>  						  &masks));
> -	KUNIT_EXPECT_EQ(test, LANDLOCK_ACCESS_FS_EXECUTE, masks.access[0]);
> -	KUNIT_EXPECT_EQ(test, 0, masks.access[1]);
> +	/*
> +	 * These casts to access_mask_t are needed because typeof(), used in
> +	 * KUNIT_EXPECT_EQ(), does not work on bitfields.
> +	 */
> +	KUNIT_EXPECT_EQ(test, LANDLOCK_ACCESS_FS_EXECUTE,
> +			(access_mask_t)masks.layers[0].access);
> +	KUNIT_EXPECT_EQ(test, 0, (access_mask_t)masks.layers[1].access);
>  }
>  
>  static void test_scope_to_request_without_access(struct kunit *const test)
>  {
>  	/* Denies execute and write. */
> -	struct layer_access_masks masks = {
> -		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE,
> -		.access[1] = LANDLOCK_ACCESS_FS_WRITE_FILE,
> +	struct layer_masks masks = {
> +		.layers[0].access = LANDLOCK_ACCESS_FS_EXECUTE,
> +		.layers[1].access = LANDLOCK_ACCESS_FS_WRITE_FILE,
>  	};
>  
>  	/* Checks and scopes without access request. */
>  	KUNIT_EXPECT_TRUE(test, scope_to_request(0, &masks));
> -	KUNIT_EXPECT_EQ(test, 0, masks.access[0]);
> -	KUNIT_EXPECT_EQ(test, 0, masks.access[1]);
> +	KUNIT_EXPECT_EQ(test, 0, (access_mask_t)masks.layers[0].access);
> +	KUNIT_EXPECT_EQ(test, 0, (access_mask_t)masks.layers[1].access);
>  }
>  
>  #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
> @@ -639,15 +648,15 @@ static void test_scope_to_request_without_access(struct kunit *const test)
>   * Returns true if there is at least one access right different than
>   * LANDLOCK_ACCESS_FS_REFER.
>   */
> -static bool is_eacces(const struct layer_access_masks *masks,
> +static bool is_eacces(const struct layer_masks *masks,
>  		      const access_mask_t access_request)
>  {
>  	if (!masks)
>  		return false;
>  
> -	for (size_t i = 0; i < ARRAY_SIZE(masks->access); i++) {
> +	for (size_t i = 0; i < ARRAY_SIZE(masks->layers); i++) {
>  		/* LANDLOCK_ACCESS_FS_REFER alone must return -EXDEV. */
> -		if (masks->access[i] & access_request &
> +		if (masks->layers[i].access & access_request &
>  		    ~LANDLOCK_ACCESS_FS_REFER)
>  			return true;
>  	}
> @@ -661,7 +670,7 @@ static bool is_eacces(const struct layer_access_masks *masks,
>  
>  static void test_is_eacces_with_none(struct kunit *const test)
>  {
> -	const struct layer_access_masks masks = {};
> +	const struct layer_masks masks = {};
>  
>  	IE_FALSE(&masks, 0);
>  	IE_FALSE(&masks, LANDLOCK_ACCESS_FS_REFER);
> @@ -671,8 +680,8 @@ static void test_is_eacces_with_none(struct kunit *const test)
>  
>  static void test_is_eacces_with_refer(struct kunit *const test)
>  {
> -	const struct layer_access_masks masks = {
> -		.access[0] = LANDLOCK_ACCESS_FS_REFER,
> +	const struct layer_masks masks = {
> +		.layers[0].access = LANDLOCK_ACCESS_FS_REFER,
>  	};
>  
>  	IE_FALSE(&masks, 0);
> @@ -683,8 +692,8 @@ static void test_is_eacces_with_refer(struct kunit *const test)
>  
>  static void test_is_eacces_with_write(struct kunit *const test)
>  {
> -	const struct layer_access_masks masks = {
> -		.access[0] = LANDLOCK_ACCESS_FS_WRITE_FILE,
> +	const struct layer_masks masks = {
> +		.layers[0].access = LANDLOCK_ACCESS_FS_WRITE_FILE,
>  	};
>  
>  	IE_FALSE(&masks, 0);
> @@ -743,11 +752,11 @@ static bool
>  is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
>  			   const struct path *const path,
>  			   const access_mask_t access_request_parent1,
> -			   struct layer_access_masks *layer_masks_parent1,
> +			   struct layer_masks *layer_masks_parent1,
>  			   struct landlock_request *const log_request_parent1,
>  			   struct dentry *const dentry_child1,
>  			   const access_mask_t access_request_parent2,
> -			   struct layer_access_masks *layer_masks_parent2,
> +			   struct layer_masks *layer_masks_parent2,
>  			   struct landlock_request *const log_request_parent2,
>  			   struct dentry *const dentry_child2)
>  {
> @@ -755,9 +764,9 @@ is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
>  	     child1_is_directory = true, child2_is_directory = true;
>  	struct path walker_path;
>  	access_mask_t access_masked_parent1, access_masked_parent2;
> -	struct layer_access_masks _layer_masks_child1, _layer_masks_child2;
> -	struct layer_access_masks *layer_masks_child1 = NULL,
> -				  *layer_masks_child2 = NULL;
> +	struct layer_masks _layer_masks_child1, _layer_masks_child2;
> +	struct layer_masks *layer_masks_child1 = NULL,
> +			   *layer_masks_child2 = NULL;
>  
>  	if (!access_request_parent1 && !access_request_parent2)
>  		return true;
> @@ -797,6 +806,10 @@ is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
>  	}
>  
>  	if (unlikely(dentry_child1)) {
> +		/*
> +		 * Get the layer masks for the child dentries for use by domain
> +		 * check later.
> +		 */
>  		if (landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
>  					      &_layer_masks_child1,
>  					      LANDLOCK_KEY_INODE))
> @@ -952,7 +965,7 @@ static int current_check_access_path(const struct path *const path,
>  	};
>  	const struct landlock_cred_security *const subject =
>  		landlock_get_applicable_subject(current_cred(), masks, NULL);
> -	struct layer_access_masks layer_masks;
> +	struct layer_masks layer_masks;
>  	struct landlock_request request = {};
>  
>  	if (!subject)
> @@ -1029,7 +1042,7 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
>  static bool collect_domain_accesses(const struct landlock_ruleset *const domain,
>  				    const struct dentry *const mnt_root,
>  				    struct dentry *dir,
> -				    struct layer_access_masks *layer_masks_dom)
> +				    struct layer_masks *layer_masks_dom)
>  {
>  	bool ret = false;
>  
> @@ -1135,8 +1148,7 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  	access_mask_t access_request_parent1, access_request_parent2;
>  	struct path mnt_dir;
>  	struct dentry *old_parent;
> -	struct layer_access_masks layer_masks_parent1 = {},
> -				  layer_masks_parent2 = {};
> +	struct layer_masks layer_masks_parent1 = {}, layer_masks_parent2 = {};
>  	struct landlock_request request1 = {}, request2 = {};
>  
>  	if (!subject)
> @@ -1202,7 +1214,6 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  	allow_parent2 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
>  						new_dir->dentry,
>  						&layer_masks_parent2);
> -
>  	if (allow_parent1 && allow_parent2)
>  		return 0;
>  
> @@ -1580,7 +1591,7 @@ static int hook_path_truncate(const struct path *const path)
>   */
>  static void unmask_scoped_access(const struct landlock_ruleset *const client,
>  				 const struct landlock_ruleset *const server,
> -				 struct layer_access_masks *const masks,
> +				 struct layer_masks *const masks,
>  				 const access_mask_t access)
>  {
>  	int client_layer, server_layer;
> @@ -1621,9 +1632,9 @@ static void unmask_scoped_access(const struct landlock_ruleset *const client,
>  		server_walker = server_walker->parent;
>  
>  	for (; client_layer >= 0; client_layer--) {
> -		if (masks->access[client_layer] & access &&
> +		if (masks->layers[client_layer].access & access &&
>  		    client_walker == server_walker)
> -			masks->access[client_layer] &= ~access;
> +			masks->layers[client_layer].access &= ~access;
>  
>  		client_walker = client_walker->parent;
>  		server_walker = server_walker->parent;
> @@ -1635,7 +1646,7 @@ static int hook_unix_find(const struct path *const path, struct sock *other,
>  {
>  	const struct landlock_ruleset *dom_other;
>  	const struct landlock_cred_security *subject;
> -	struct layer_access_masks layer_masks;
> +	struct layer_masks layer_masks;
>  	struct landlock_request request = {};
>  	static const struct access_masks fs_resolve_unix = {
>  		.fs = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> @@ -1739,7 +1750,7 @@ static bool is_device(const struct file *const file)
>  
>  static int hook_file_open(struct file *const file)
>  {
> -	struct layer_access_masks layer_masks = {};
> +	struct layer_masks layer_masks = {};
>  	access_mask_t open_access_request, full_access_request, allowed_access,
>  		optional_access;
>  	const struct landlock_cred_security *const subject =
> @@ -1780,8 +1791,8 @@ static int hook_file_open(struct file *const file)
>  		 * are still unfulfilled in any of the layers.
>  		 */
>  		allowed_access = full_access_request;
> -		for (size_t i = 0; i < ARRAY_SIZE(layer_masks.access); i++)
> -			allowed_access &= ~layer_masks.access[i];
> +		for (size_t i = 0; i < ARRAY_SIZE(layer_masks.layers); i++)
> +			allowed_access &= ~layer_masks.layers[i].access;
>  	}
>  
>  	/*
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index a4d908b240a2..08d5f2f6d321 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -31,6 +31,9 @@
>  #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
>  #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
>  
> +#define LANDLOCK_NUM_ACCESS_MAX \
> +	MAX(MAX(LANDLOCK_NUM_ACCESS_FS, LANDLOCK_NUM_ACCESS_NET), LANDLOCK_NUM_SCOPE)
> +
>  #define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_TSYNC
>  #define LANDLOCK_MASK_RESTRICT_SELF	((LANDLOCK_LAST_RESTRICT_SELF << 1) - 1)
>  
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index db2046a89a9a..981a362c24db 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -48,7 +48,7 @@ static int current_check_access_socket(struct socket *const sock,
>  				       bool connecting)
>  {
>  	__be16 port;
> -	struct layer_access_masks layer_masks = {};
> +	struct layer_masks layer_masks = {};
>  	const struct landlock_rule *rule;
>  	struct landlock_id id = {
>  		.type = LANDLOCK_KEY_NET_PORT,
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index 181df7736bb9..91948e406e69 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -628,7 +628,7 @@ landlock_find_rule(const struct landlock_ruleset *const ruleset,
>   * remaining unfulfilled access rights and masks has no leftover set bits).
>   */
>  bool landlock_unmask_layers(const struct landlock_rule *const rule,
> -			    struct layer_access_masks *masks)
> +			    struct layer_masks *masks)
>  {
>  	if (!masks)
>  		return true;
> @@ -649,11 +649,17 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
>  		const struct landlock_layer *const layer = &rule->layers[i];
>  
>  		/* Clear the bits where the layer in the rule grants access. */
> -		masks->access[layer->level - 1] &= ~layer->access;
> +		masks->layers[layer->level - 1].access &= ~layer->access;
> +
> +#ifdef CONFIG_AUDIT
> +		/* Collect rule flags for each layer. */
> +		if (layer->flags.quiet)
> +			masks->layers[layer->level - 1].quiet = true;
> +#endif /* CONFIG_AUDIT */
>  	}
>  
> -	for (size_t i = 0; i < ARRAY_SIZE(masks->access); i++) {
> -		if (masks->access[i])
> +	for (size_t i = 0; i < ARRAY_SIZE(masks->layers); i++) {
> +		if (masks->layers[i].access)
>  			return false;
>  	}
>  	return true;
> @@ -668,6 +674,7 @@ get_access_mask_t(const struct landlock_ruleset *const ruleset,
>   *
>   * Populates @masks such that for each access right in @access_request,
>   * the bits for all the layers are set where this access right is handled.
> + * Rule flags are also zeroed.
>   *
>   * @domain: The domain that defines the current restrictions.
>   * @access_request: The requested access rights to check.
> @@ -680,7 +687,7 @@ get_access_mask_t(const struct landlock_ruleset *const ruleset,
>  access_mask_t
>  landlock_init_layer_masks(const struct landlock_ruleset *const domain,
>  			  const access_mask_t access_request,
> -			  struct layer_access_masks *const masks,
> +			  struct layer_masks *const masks,
>  			  const enum landlock_key_type key_type)
>  {
>  	access_mask_t handled_accesses = 0;
> @@ -709,11 +716,19 @@ landlock_init_layer_masks(const struct landlock_ruleset *const domain,
>  	for (size_t i = 0; i < domain->num_layers; i++) {
>  		const access_mask_t handled = get_access_mask(domain, i);
>  
> -		masks->access[i] = access_request & handled;
> -		handled_accesses |= masks->access[i];
> +		masks->layers[i].access = access_request & handled;
> +		handled_accesses |= masks->layers[i].access;
> +#ifdef CONFIG_AUDIT
> +		masks->layers[i].quiet = false;
> +#endif /* CONFIG_AUDIT */
> +	}
> +	for (size_t i = domain->num_layers; i < ARRAY_SIZE(masks->layers);
> +	     i++) {
> +		masks->layers[i].access = 0;
> +#ifdef CONFIG_AUDIT
> +		masks->layers[i].quiet = false;
> +#endif /* CONFIG_AUDIT */
>  	}
> -	for (size_t i = domain->num_layers; i < ARRAY_SIZE(masks->access); i++)
> -		masks->access[i] = 0;
>  
>  	return handled_accesses;
>  }
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index 889f4b30301a..f80ca487d125 100644
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
> +		bool quiet : 1;

In struct, we should use architecture-independent sizes, so `u8 quiet : 1;`
seems more appropriate.

> +	} flags;
>  	/**
>  	 * @access: Bitfield of allowed actions on the kernel object.  They are
>  	 * relative to the object type (e.g. %LANDLOCK_ACTION_FS_READ).
> @@ -302,12 +313,12 @@ landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
>  }
>  
>  bool landlock_unmask_layers(const struct landlock_rule *const rule,
> -			    struct layer_access_masks *masks);
> +			    struct layer_masks *masks);
>  
>  access_mask_t
>  landlock_init_layer_masks(const struct landlock_ruleset *const domain,
>  			  const access_mask_t access_request,
> -			  struct layer_access_masks *masks,
> +			  struct layer_masks *masks,
>  			  const enum landlock_key_type key_type);
>  
>  #endif /* _SECURITY_LANDLOCK_RULESET_H */
> -- 
> 2.54.0
> 
