Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B34304BD8
	for <linux-security-module@vger.kernel.org>; Wed, 15 Oct 2025 19:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760555385; cv=none; b=loZ6p09+SaU6qH6q3iTHJlkESEQwVL2fNqzeJ/s0DCUNq31tHWMtjPAHyycIOIeskoo4xnCvWLk9gqj3oGT/Lo0ldmLA+6NqFOtlZe8NPFUtSg7M1AGbx6CIBfilQH5v6b1B+uiz2lRPEvtObR6SnMSRRDQy4AnWBDPLKCrSLZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760555385; c=relaxed/simple;
	bh=9ql+s2+btdMH0LXeQzxPwcYKVdF9+KT2HJIl+OrHtZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCSU1/NcOUaATfTmpvz0H5tzgQwo2/AIM2r7EusGgfZpzBLg4260ZmoLEL+lpJOxfKDwCdI+P4TIX1uOMt4YPgpikczHvAjUnC4veBJXd9chi3PfPyS+o69ix2ZdWqW6JbzFOxCraZkJmC9wCw/E7adcjOC1ugMNEV0ZyfP5YGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Q9m8WJxk; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Q9m8WJxk"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cn0yC4yFDzSMS;
	Wed, 15 Oct 2025 21:09:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1760555379;
	bh=pgW7F9cJuoRQtLiYvt3P3l+iPtOzcE0s7otTABOBMbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q9m8WJxkzgAFpPPE0ryQ0sbBg7yTQIApM/a6NrXlduZfwsxI3LO24Dfjw8v4C0NGO
	 LLUMB7TU95nfFBFqjP4Zb1civoDzy1fHH/aPmq08Ae/lhaEI9o5W/ow4+RgS9a+Iul
	 hVH/9qGEYNpRJDc6hlhTAnENw+pN4BqsTpdB7gfM=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4cn0yC19gLzJMY;
	Wed, 15 Oct 2025 21:09:39 +0200 (CEST)
Date: Wed, 15 Oct 2025 21:09:38 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 6/6] Implement quiet for optional accesses
Message-ID: <20251015.sohxe1NohFei@digikod.net>
References: <cover.1759686613.git.m@maowtm.org>
 <d9a05ea8fe3b825087351f22c550854dcad02555.1759686613.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9a05ea8fe3b825087351f22c550854dcad02555.1759686613.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

This extra patch makes the review easier, but it should be squashed into
the others if possible.

On Sun, Oct 05, 2025 at 06:55:29PM +0100, Tingmao Wang wrote:
> Since the existing deny_masks can only store 2x4bit of layer index, with
> no way to represent "no layer", we need to either expand it or have
> another field.  This commit uses the latter approach - we add another
> field to store which optional access (of the 2) are covered by quiet rules
> in their respective layers as stored in deny_masks.
> 
> We can avoid making struct landlock_file_security larger by converting the
> existing fown_layer to a 4bit field.  This commit does that, and adds test
> to ensure that it is large enough for LANDLOCK_MAX_NUM_LAYERS-1.
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
> 
> Changes since v1:
> - New patch
> 
>  security/landlock/audit.c  | 55 +++++++++++++++++++++++---------------
>  security/landlock/audit.h  |  1 +
>  security/landlock/domain.c | 23 ++++++++++++++++
>  security/landlock/domain.h |  5 ++++
>  security/landlock/fs.c     |  6 +++++
>  security/landlock/fs.h     | 34 ++++++++++++++++++-----
>  6 files changed, 96 insertions(+), 28 deletions(-)
> 
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index 4ba44fb1dccb..f183124755a4 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -273,7 +273,7 @@ static void test_get_denied_layer(struct kunit *const test)
>  static size_t
>  get_layer_from_deny_masks(access_mask_t *const access_request,
>  			  const access_mask_t all_existing_optional_access,
> -			  const deny_masks_t deny_masks)
> +			  const deny_masks_t deny_masks, u8 quiet_optional_accesses, bool *quiet)
>  {
>  	const unsigned long access_opt = all_existing_optional_access;
>  	const unsigned long access_req = *access_request;
> @@ -285,6 +285,7 @@ get_layer_from_deny_masks(access_mask_t *const access_request,
>  	/* This will require change with new object types. */
>  	WARN_ON_ONCE(access_opt != _LANDLOCK_ACCESS_FS_OPTIONAL);
>  
> +	*quiet = false;
>  	for_each_set_bit(access_bit, &access_opt,
>  			 BITS_PER_TYPE(access_mask_t)) {
>  		if (access_req & BIT(access_bit)) {
> @@ -298,6 +299,11 @@ get_layer_from_deny_masks(access_mask_t *const access_request,
>  			} else if (layer == youngest_layer) {
>  				missing |= BIT(access_bit);
>  			}
> +
> +			/* Make sure we set *quiet even if this is the first layer */

Missing final dot.

> +			if (layer >= youngest_layer)
> +				*quiet = !!(quiet_optional_accesses &
> +					    BIT(access_index));

This code is good but a bit confusing at first, especially without more
context than this patch provides, where we don't see the relation
between layer and youngest_layer.  Anyway, please extend the comment to
say that quiet is always overridden for the youngest layer.

>  		}
>  		access_index++;
>  	}
> @@ -312,42 +318,49 @@ static void test_get_layer_from_deny_masks(struct kunit *const test)
>  {
>  	deny_masks_t deny_mask;
>  	access_mask_t access;
> +	u8 quiet_optional_accesses = 0;
> +	bool quiet;
> +	bool expected_quiet = false;
>  
>  	/* truncate:0 ioctl_dev:2 */
>  	deny_mask = 0x20;
>  
>  	access = LANDLOCK_ACCESS_FS_TRUNCATE;
>  	KUNIT_EXPECT_EQ(test, 0,
> -			get_layer_from_deny_masks(&access,
> -						  _LANDLOCK_ACCESS_FS_OPTIONAL,
> -						  deny_mask));
> +			get_layer_from_deny_masks(
> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
> +				deny_mask, quiet_optional_accesses, &quiet));
>  	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
> +	KUNIT_EXPECT_EQ(test, quiet, expected_quiet);
>  
>  	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
>  	KUNIT_EXPECT_EQ(test, 2,
> -			get_layer_from_deny_masks(&access,
> -						  _LANDLOCK_ACCESS_FS_OPTIONAL,
> -						  deny_mask));
> +			get_layer_from_deny_masks(
> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
> +				deny_mask, quiet_optional_accesses, &quiet));
>  	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
> +	KUNIT_EXPECT_EQ(test, quiet, expected_quiet);
>  
>  	/* truncate:15 ioctl_dev:15 */
>  	deny_mask = 0xff;
>  
>  	access = LANDLOCK_ACCESS_FS_TRUNCATE;
>  	KUNIT_EXPECT_EQ(test, 15,
> -			get_layer_from_deny_masks(&access,
> -						  _LANDLOCK_ACCESS_FS_OPTIONAL,
> -						  deny_mask));
> +			get_layer_from_deny_masks(
> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
> +				deny_mask, quiet_optional_accesses, &quiet));
>  	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
> +	KUNIT_EXPECT_EQ(test, quiet, expected_quiet);
>  
>  	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
>  	KUNIT_EXPECT_EQ(test, 15,
> -			get_layer_from_deny_masks(&access,
> -						  _LANDLOCK_ACCESS_FS_OPTIONAL,
> -						  deny_mask));
> +			get_layer_from_deny_masks(
> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
> +				deny_mask, quiet_optional_accesses, &quiet));
>  	KUNIT_EXPECT_EQ(test, access,
>  			LANDLOCK_ACCESS_FS_TRUNCATE |
>  				LANDLOCK_ACCESS_FS_IOCTL_DEV);
> +	KUNIT_EXPECT_EQ(test, quiet, expected_quiet);
>  }
>  
>  #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
> @@ -413,7 +426,7 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
>  	struct landlock_hierarchy *youngest_denied;
>  	size_t youngest_layer;
>  	access_mask_t missing, quiet_mask;
> -	bool quiet_flag_on_rule = false, quiet_applicable_to_access = false;
> +	bool object_quiet_flag = false, quiet_applicable_to_access = false;
>  
>  	if (WARN_ON_ONCE(!subject || !subject->domain ||
>  			 !subject->domain->hierarchy || !request))
> @@ -429,10 +442,13 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
>  			youngest_layer = get_denied_layer(
>  				subject->domain, &missing, request->layer_masks,
>  				request->layer_masks_size);
> +			object_quiet_flag = !!(rule_flags.quiet_masks & BIT(youngest_layer));
>  		} else {
>  			youngest_layer = get_layer_from_deny_masks(
>  				&missing, request->all_existing_optional_access,
> -				request->deny_masks);
> +				request->deny_masks,
> +				request->quiet_optional_accesses,
> +				&object_quiet_flag);
>  		}
>  		youngest_denied =
>  			get_hierarchy(subject->domain, youngest_layer);
> @@ -462,13 +478,10 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
>  	 * that layer is not the one that denied the request, we should still
>  	 * audit log the denial.
>  	 */
> -	quiet_flag_on_rule = !!(rule_flags.quiet_masks & BIT(youngest_layer));
> -
> -	if (quiet_flag_on_rule) {
> +	if (object_quiet_flag) {
>  		/*
> -		 * This is not a scope request, since rule_flags is not zero.  We
> -		 * now check if the denied requests are all covered by the layer's
> -		 * quiet access bits.
> +		 * We now check if the denied requests are all covered by the
> +		 * layer's quiet access bits.
>  		 */
>  		quiet_mask = pick_access_mask_for_req_type(
>  			request->type, youngest_denied->quiet_masks);
> diff --git a/security/landlock/audit.h b/security/landlock/audit.h
> index 80cf085465e3..950365cd223d 100644
> --- a/security/landlock/audit.h
> +++ b/security/landlock/audit.h
> @@ -49,6 +49,7 @@ struct landlock_request {
>  	/* Required fields for requests with deny masks. */
>  	const access_mask_t all_existing_optional_access;
>  	deny_masks_t deny_masks;
> +	u8 quiet_optional_accesses;
>  };
>  
>  #ifdef CONFIG_AUDIT
> diff --git a/security/landlock/domain.c b/security/landlock/domain.c
> index a647b68e8d06..0f611ad516be 100644
> --- a/security/landlock/domain.c
> +++ b/security/landlock/domain.c
> @@ -212,6 +212,29 @@ landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
>  	return deny_masks;
>  }
>  

Just using u8 is confusing.  Please document what is the "type" of the
returned value, and use a dedicated typedef instead of u8 (see my other
comment about static_assert).  This typedef should probably be named
optional_access_t and have a size less or equal to access_t's one.

> +u8 landlock_get_quiet_optional_accesses(
> +	const access_mask_t all_existing_optional_access,
> +	const deny_masks_t deny_masks,
> +	const struct collected_rule_flags rule_flags)
> +{
> +	const unsigned long access_opt = all_existing_optional_access;
> +	size_t access_index = 0;
> +	unsigned long access_bit;
> +	u8 quiet_optional_accesses = 0;

As for deny_masks_t, we should define an "optional_access_t" type with
appropriate safeguard to guarantee that it can always hold all optional
access rights (see static_assert for deny_masks_t in access.h).

We should also copy the WARN_ON_ONCE() check from
get_layer_from_deny_masks().

> +
> +	for_each_set_bit(access_bit, &access_opt,
> +			 BITS_PER_TYPE(access_mask_t)) {
> +		const u8 layer = (deny_masks >> (access_index * 4)) &
> +				 (LANDLOCK_MAX_NUM_LAYERS - 1);
> +		const bool is_quiet = !!(rule_flags.quiet_masks & BIT(layer));
> +
> +		if (is_quiet)
> +			quiet_optional_accesses |= BIT(access_index);
> +		access_index++;
> +	}
> +	return quiet_optional_accesses;
> +}
> +
>  #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
>  
>  static void test_landlock_get_deny_masks(struct kunit *const test)
> diff --git a/security/landlock/domain.h b/security/landlock/domain.h
> index aadbf53505c0..ab9e5898776d 100644
> --- a/security/landlock/domain.h
> +++ b/security/landlock/domain.h
> @@ -130,6 +130,11 @@ landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
>  			const layer_mask_t (*const layer_masks)[],
>  			size_t layer_masks_size);
>  
> +u8 landlock_get_quiet_optional_accesses(
> +	const access_mask_t all_existing_optional_access,
> +	const deny_masks_t deny_masks,
> +	const struct collected_rule_flags rule_flags);
> +
>  int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy);
>  
>  static inline void
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 1ccef1c2959f..4a71b792c4e7 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1698,6 +1698,10 @@ static int hook_file_open(struct file *const file)
>  	landlock_file(file)->deny_masks = landlock_get_deny_masks(
>  		_LANDLOCK_ACCESS_FS_OPTIONAL, optional_access, &layer_masks,
>  		ARRAY_SIZE(layer_masks));
> +	landlock_file(file)->quiet_optional_accesses =
> +		landlock_get_quiet_optional_accesses(
> +			_LANDLOCK_ACCESS_FS_OPTIONAL,
> +			landlock_file(file)->deny_masks, rule_flags);
>  #endif /* CONFIG_AUDIT */
>  
>  	if ((open_access_request & allowed_access) == open_access_request)
> @@ -1734,6 +1738,7 @@ static int hook_file_truncate(struct file *const file)
>  		.access = LANDLOCK_ACCESS_FS_TRUNCATE,
>  #ifdef CONFIG_AUDIT
>  		.deny_masks = landlock_file(file)->deny_masks,
> +		.quiet_optional_accesses = landlock_file(file)->quiet_optional_accesses,
>  #endif /* CONFIG_AUDIT */
>  	}, no_rule_flags);
>  	return -EACCES;
> @@ -1773,6 +1778,7 @@ static int hook_file_ioctl_common(const struct file *const file,
>  		.access = LANDLOCK_ACCESS_FS_IOCTL_DEV,
>  #ifdef CONFIG_AUDIT
>  		.deny_masks = landlock_file(file)->deny_masks,
> +		.quiet_optional_accesses = landlock_file(file)->quiet_optional_accesses,
>  #endif /* CONFIG_AUDIT */
>  	}, no_rule_flags);
>  	return -EACCES;
> diff --git a/security/landlock/fs.h b/security/landlock/fs.h
> index cb7e654933ac..04708cf4ec0f 100644
> --- a/security/landlock/fs.h
> +++ b/security/landlock/fs.h
> @@ -63,11 +63,19 @@ struct landlock_file_security {
>  	 * _LANDLOCK_ACCESS_FS_OPTIONAL).
>  	 */
>  	deny_masks_t deny_masks;
> +	/**
> +	 * @quiet_optional_accesses: Stores which optional accesses are
> +	 * covered by quiet rules within the layer referred to in deny_masks,
> +	 * one access per bit.  Does not take into account whether the quiet
> +	 * access bits are actually set in the layer's corresponding
> +	 * landlock_hierarchy.
> +	 */
> +	u8 quiet_optional_accesses:2;
>  	/**
>  	 * @fown_layer: Layer level of @fown_subject->domain with
>  	 * LANDLOCK_SCOPE_SIGNAL.
>  	 */
> -	u8 fown_layer;
> +	u8 fown_layer:4;
>  #endif /* CONFIG_AUDIT */
>  
>  	/**
> @@ -80,13 +88,24 @@ struct landlock_file_security {
>  	struct landlock_cred_security fown_subject;
>  };
>  
> -#ifdef CONFIG_AUDIT
> +static void build_check_file_security(void)

You can move this function to fs.c and call it in
hook_file_alloc_security() instead.

> +{
> +	const struct landlock_file_security file_sec = {
> +		.quiet_optional_accesses = ~0,
> +		.fown_layer = ~0,
> +	};
> +
> +	/*
> +	 * Make sure quiet_optional_accesses has enough bits to cover all
> +	 * optional accesses
> +	 */
> +	BUILD_BUG_ON(__const_hweight8(file_sec.quiet_optional_accesses) <

We should be able to use HWEIGHT() instead.

> +		     __const_hweight64(_LANDLOCK_ACCESS_FS_OPTIONAL));
> +	/* Makes sure all layers can be identified. */
> +	BUILD_BUG_ON(file_sec.fown_layer < LANDLOCK_MAX_NUM_LAYERS - 1);
> +}
>  
> -/* Makes sure all layers can be identified. */
> -/* clang-format off */
> -static_assert((typeof_member(struct landlock_file_security, fown_layer))~0 >=
> -	      LANDLOCK_MAX_NUM_LAYERS);
> -/* clang-format off */
> +#ifdef CONFIG_AUDIT
>  
>  #endif /* CONFIG_AUDIT */
>  
> @@ -107,6 +126,7 @@ struct landlock_superblock_security {
>  static inline struct landlock_file_security *
>  landlock_file(const struct file *const file)
>  {
> +	build_check_file_security();
>  	return file->f_security + landlock_blob_sizes.lbs_file;
>  }
>  
> -- 
> 2.51.0
