Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87534337690
	for <linux-security-module@vger.kernel.org>; Wed, 28 Jan 2026 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769637103; cv=none; b=TBFOHi0S+y9WU4fwYtwnxLP6+sMbF7GnqjfRh30ElfjvtAInhOU1gG16I5zQAYoaPvS2YbQtOEJvVbjSGgBnbhNeLSKLKpw8IimFiUnEyPWMxSCzzXZFVvBhtSKwaTZyx58x+GAP5KWSGGIfR0DW6pspa0EjTB9BtrEF3Ux93jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769637103; c=relaxed/simple;
	bh=JqARSdK+ti1y94BY5JFtNZC69AEwWkEFlxPkpU/SLoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4JUvZ4vi9kXnx0dIaCoIFyRbUwrax3RaPl0ynMyxHyfOR9YGdbGdvusyoBR1N5gfKQRyGSrX5qlW6Qper1owIgIANW6e599w1U8b/pQI/KrI4//jLu/LQy+Z9MICkvWx6GddqIEp+Hwf1i43XyDQgSKE9gUDZJHpbGcHXZo6N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=cV6I1TIl; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="cV6I1TIl"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f1bBM3z9xzKNQ;
	Wed, 28 Jan 2026 22:34:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1769636043;
	bh=vqheEHGzsVzfkwaWMEfbiSPbPROnnw98ngT0NV8wwyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cV6I1TIlHrK6/h3J4TuE0OeeXl5pblDyYsi9bD04QQ6QozH9fTk1U8xf1Qq+vYPQQ
	 x1kdkERQ8qAnwHLuGnweJeNYllWHcFxU5y/DZUbJgBt7qDfSjVCFmFSgNrmzMb0W2Q
	 uarLQzksE8zAruXv1j5w7X8gqx5NrGOFn7Rnv+EQ=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4f1bBM05h3z2W3;
	Wed, 28 Jan 2026 22:34:03 +0100 (CET)
Date: Wed, 28 Jan 2026 22:34:02 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 3/3] landlock: transpose the layer masks data structure
Message-ID: <20260128.quaido7ia0Xu@digikod.net>
References: <20260125195853.109967-1-gnoack3000@gmail.com>
 <20260125195853.109967-4-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260125195853.109967-4-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

On Sun, Jan 25, 2026 at 08:58:53PM +0100, Günther Noack wrote:
> The layer masks data structure tracks the requested but unfulfilled
> access rights during an operation's security check.  It stores one bit
> for each combination of access right and layer index.  If the bit is
> set, that access right is not granted (yet) in the given layer and we
> have to traverse the path further upwards to grant it.
> 
> Previously, the layer masks were stored as arrays mapping from access
> right indices to layer_mask_t.  The layer_mask_t value then indicates
> all layers in which the given access right is still (tentatively)
> denied.
> 
> This patch introduces struct layer_access_masks instead: This struct
> contains an array with the access_mask_t of each (tentatively) denied
> access right in that layer.
> 
> The hypothesis of this patch is that this simplifies the code enough
> so that the resulting code will run faster:
> 
> * We can use bitwise operations in multiple places where we previously
>   looped over bits individually with macros.  (Should require less
>   branch speculation and lends itself to better loop unrolling.)
> 
> * Code is ~75 lines smaller.
> 
> Other noteworthy changes:
> 
> * In no_more_access(), call a new helper function may_refer(), which
>   only solves the asymmetric case.  Previously, the code interleaved
>   the checks for the two symmetric cases in RENAME_EXCHANGE.  It feels
>   that the code is clearer when renames without RENAME_EXCHANGE are
>   more obviously the normal case.
> 
> Tradeoffs:
> 
> This change improves performance, at a slight size increase to the
> layer masks data structure.
> 
> At the moment, for the filesystem access rights, the data structure
> has the same size as before, but once we introduce the 17th filesystem
> access right, it will double in size (from 32 to 64 bytes), as

...for all access rights (e.g. even if there is no new network one)

> access_mask_t grows from 16 to 32 bit.  See the link below for
> measurements.
> 
> Link: https://lore.kernel.org/all/20260120.haeCh4li9Vae@digikod.net/
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  security/landlock/access.h  |  10 +-
>  security/landlock/audit.c   |  84 +++------
>  security/landlock/audit.h   |   3 +-
>  security/landlock/domain.c  |  45 +++--
>  security/landlock/domain.h  |   4 +-
>  security/landlock/fs.c      | 352 ++++++++++++++++--------------------
>  security/landlock/net.c     |  11 +-
>  security/landlock/ruleset.c |  88 ++++-----
>  security/landlock/ruleset.h |  21 ++-
>  9 files changed, 274 insertions(+), 344 deletions(-)
> 
> diff --git a/security/landlock/access.h b/security/landlock/access.h
> index 5c0caef9eaf6..1c911fa3555d 100644
> --- a/security/landlock/access.h
> +++ b/security/landlock/access.h
> @@ -61,14 +61,14 @@ union access_masks_all {
>  static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
>  	      sizeof(typeof_member(union access_masks_all, all)));
>  
> -typedef u16 layer_mask_t;
> -
> -/* Makes sure all layers can be checked. */
> -static_assert(BITS_PER_TYPE(layer_mask_t) >= LANDLOCK_MAX_NUM_LAYERS);
> -
>  /*
>   * Tracks domains responsible of a denied access.  This is required to avoid
>   * storing in each object the full layer_masks[] required by update_request().
> + *
> + * Each nibble represents the layer index of the newest layer which denied a
> + * certain access right.  For file system access rights, the upper four bits are
> + * the index of the layer which denies LANDLOCK_ACCESS_FS_IOCTL_DEV and the
> + * lower nibble represents LANDLOCK_ACCESS_FS_TRUNCATE.
>   */
>  typedef u8 deny_masks_t;
>  
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index e899995f1fd5..979a33f480aa 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -180,38 +180,21 @@ static void test_get_hierarchy(struct kunit *const test)
>  
>  #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
>  
> +/* get_denied_layer - get the youngest layer that denied the access_request */

/* Get the youngest layer that denied the access_request. */

>  static size_t get_denied_layer(const struct landlock_ruleset *const domain,
>  			       access_mask_t *const access_request,
> -			       const layer_mask_t (*const layer_masks)[],
> -			       const size_t layer_masks_size)
> +			       const struct layer_access_masks *masks)
>  {
> -	const unsigned long access_req = *access_request;
> -	unsigned long access_bit;
> -	access_mask_t missing = 0;
> -	long youngest_layer = -1;
> -
> -	for_each_set_bit(access_bit, &access_req, layer_masks_size) {
> -		const layer_mask_t mask = (*layer_masks)[access_bit];
> -		long layer;
> -
> -		if (!mask)
> -			continue;
> -
> -		/* __fls(1) == 0 */
> -		layer = __fls(mask);
> -		if (layer > youngest_layer) {
> -			youngest_layer = layer;
> -			missing = BIT(access_bit);
> -		} else if (layer == youngest_layer) {
> -			missing |= BIT(access_bit);
> +	for (int i = ARRAY_SIZE(masks->access) - 1; i >= 0; i--) {

size_t i

> +		if (masks->access[i] & *access_request) {
> +			*access_request &= masks->access[i];
> +			return i;
>  		}
>  	}
>  
> -	*access_request = missing;
> -	if (youngest_layer == -1)
> -		return domain->num_layers - 1;
> -
> -	return youngest_layer;
> +	/* Not found - fall back to default values */
> +	*access_request = 0;
> +	return domain->num_layers - 1;
>  }
>  
>  #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
> @@ -221,50 +204,39 @@ static void test_get_denied_layer(struct kunit *const test)
>  	const struct landlock_ruleset dom = {
>  		.num_layers = 5,
>  	};
> -	const layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {
> -		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT(0),
> -		[BIT_INDEX(LANDLOCK_ACCESS_FS_READ_FILE)] = BIT(1),
> -		[BIT_INDEX(LANDLOCK_ACCESS_FS_READ_DIR)] = BIT(1) | BIT(0),
> -		[BIT_INDEX(LANDLOCK_ACCESS_FS_REMOVE_DIR)] = BIT(2),
> +	const struct layer_access_masks masks = {
> +		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE |
> +			     LANDLOCK_ACCESS_FS_READ_DIR,
> +		.access[1] = LANDLOCK_ACCESS_FS_READ_FILE |
> +			     LANDLOCK_ACCESS_FS_READ_DIR,
> +		.access[2] = LANDLOCK_ACCESS_FS_REMOVE_DIR,
>  	};
>  	access_mask_t access;
>  
>  	access = LANDLOCK_ACCESS_FS_EXECUTE;
> -	KUNIT_EXPECT_EQ(test, 0,
> -			get_denied_layer(&dom, &access, &layer_masks,
> -					 sizeof(layer_masks)));
> +	KUNIT_EXPECT_EQ(test, 0, get_denied_layer(&dom, &access, &masks));
>  	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_EXECUTE);
>  
>  	access = LANDLOCK_ACCESS_FS_READ_FILE;
> -	KUNIT_EXPECT_EQ(test, 1,
> -			get_denied_layer(&dom, &access, &layer_masks,
> -					 sizeof(layer_masks)));
> +	KUNIT_EXPECT_EQ(test, 1, get_denied_layer(&dom, &access, &masks));
>  	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_READ_FILE);
>  
>  	access = LANDLOCK_ACCESS_FS_READ_DIR;
> -	KUNIT_EXPECT_EQ(test, 1,
> -			get_denied_layer(&dom, &access, &layer_masks,
> -					 sizeof(layer_masks)));
> +	KUNIT_EXPECT_EQ(test, 1, get_denied_layer(&dom, &access, &masks));
>  	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_READ_DIR);
>  
>  	access = LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_READ_DIR;
> -	KUNIT_EXPECT_EQ(test, 1,
> -			get_denied_layer(&dom, &access, &layer_masks,
> -					 sizeof(layer_masks)));
> +	KUNIT_EXPECT_EQ(test, 1, get_denied_layer(&dom, &access, &masks));
>  	KUNIT_EXPECT_EQ(test, access,
>  			LANDLOCK_ACCESS_FS_READ_FILE |
>  				LANDLOCK_ACCESS_FS_READ_DIR);
>  
>  	access = LANDLOCK_ACCESS_FS_EXECUTE | LANDLOCK_ACCESS_FS_READ_DIR;
> -	KUNIT_EXPECT_EQ(test, 1,
> -			get_denied_layer(&dom, &access, &layer_masks,
> -					 sizeof(layer_masks)));
> +	KUNIT_EXPECT_EQ(test, 1, get_denied_layer(&dom, &access, &masks));
>  	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_READ_DIR);
>  
>  	access = LANDLOCK_ACCESS_FS_WRITE_FILE;
> -	KUNIT_EXPECT_EQ(test, 4,
> -			get_denied_layer(&dom, &access, &layer_masks,
> -					 sizeof(layer_masks)));
> +	KUNIT_EXPECT_EQ(test, 4, get_denied_layer(&dom, &access, &masks));
>  	KUNIT_EXPECT_EQ(test, access, 0);
>  }
>  
> @@ -361,18 +333,15 @@ static bool is_valid_request(const struct landlock_request *const request)
>  		return false;
>  
>  	if (request->access) {
> -		if (WARN_ON_ONCE(!(!!request->layer_masks ^
> +		if (WARN_ON_ONCE(!(!!request->masks ^
>  				   !!request->all_existing_optional_access)))
>  			return false;
>  	} else {
> -		if (WARN_ON_ONCE(request->layer_masks ||
> +		if (WARN_ON_ONCE(request->masks ||
>  				 request->all_existing_optional_access))
>  			return false;
>  	}
>  
> -	if (WARN_ON_ONCE(!!request->layer_masks ^ !!request->layer_masks_size))
> -		return false;
> -
>  	if (request->deny_masks) {
>  		if (WARN_ON_ONCE(!request->all_existing_optional_access))
>  			return false;
> @@ -405,13 +374,12 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
>  	missing = request->access;
>  	if (missing) {
>  		/* Gets the nearest domain that denies the request. */
> -		if (request->layer_masks) {
> +		if (request->masks) {
>  			youngest_layer = get_denied_layer(
> -				subject->domain, &missing, request->layer_masks,
> -				request->layer_masks_size);
> +				subject->domain, &missing, request->masks);
>  		} else {
>  			youngest_layer = get_layer_from_deny_masks(
> -				&missing, request->all_existing_optional_access,
> +				&missing, _LANDLOCK_ACCESS_FS_OPTIONAL,
>  				request->deny_masks);
>  		}
>  		youngest_denied =
> diff --git a/security/landlock/audit.h b/security/landlock/audit.h
> index 92428b7fc4d8..104472060ef5 100644
> --- a/security/landlock/audit.h
> +++ b/security/landlock/audit.h
> @@ -43,8 +43,7 @@ struct landlock_request {
>  	access_mask_t access;
>  
>  	/* Required fields for requests with layer masks. */
> -	const layer_mask_t (*layer_masks)[];
> -	size_t layer_masks_size;
> +	const struct layer_access_masks *masks;
>  
>  	/* Required fields for requests with deny masks. */
>  	const access_mask_t all_existing_optional_access;
> diff --git a/security/landlock/domain.c b/security/landlock/domain.c
> index a647b68e8d06..5b11ddb22d3a 100644
> --- a/security/landlock/domain.c
> +++ b/security/landlock/domain.c
> @@ -7,6 +7,7 @@
>   * Copyright © 2024-2025 Microsoft Corporation
>   */
>  
> +#include "ruleset.h"
>  #include <kunit/test.h>
>  #include <linux/bitops.h>
>  #include <linux/bits.h>
> @@ -182,32 +183,36 @@ static void test_get_layer_deny_mask(struct kunit *const test)
>  deny_masks_t
>  landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
>  			const access_mask_t optional_access,
> -			const layer_mask_t (*const layer_masks)[],
> -			const size_t layer_masks_size)
> +			const struct layer_access_masks *const masks)
>  {
>  	const unsigned long access_opt = optional_access;
>  	unsigned long access_bit;
> +	access_mask_t all_denied = 0;
>  	deny_masks_t deny_masks = 0;
>  
>  	/* This may require change with new object types. */
> -	WARN_ON_ONCE(access_opt !=
> -		     (optional_access & all_existing_optional_access));
> +	WARN_ON_ONCE(!access_mask_subset(optional_access,
> +					 all_existing_optional_access));
>  
> -	if (WARN_ON_ONCE(!layer_masks))
> +	if (WARN_ON_ONCE(!masks))
>  		return 0;
>  
>  	if (WARN_ON_ONCE(!access_opt))
>  		return 0;
>  
> -	for_each_set_bit(access_bit, &access_opt, layer_masks_size) {
> -		const layer_mask_t mask = (*layer_masks)[access_bit];
> +	for (int i = ARRAY_SIZE(masks->access) - 1; i >= 0; i--) {

size_t i

> +		const access_mask_t denied = masks->access[i] & optional_access;
> +		const unsigned long newly_denied = denied & ~all_denied;
>  
> -		if (!mask)
> +		if (!newly_denied)
>  			continue;
>  
> -		/* __fls(1) == 0 */
> -		deny_masks |= get_layer_deny_mask(all_existing_optional_access,
> -						  access_bit, __fls(mask));
> +		for_each_set_bit(access_bit, &newly_denied,
> +				 8 * sizeof(access_mask_t)) {
> +			deny_masks |= get_layer_deny_mask(
> +				all_existing_optional_access, access_bit, i);
> +		}
> +		all_denied |= denied;
>  	}
>  	return deny_masks;
>  }
> @@ -216,28 +221,28 @@ landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
>  
>  static void test_landlock_get_deny_masks(struct kunit *const test)
>  {
> -	const layer_mask_t layers1[BITS_PER_TYPE(access_mask_t)] = {
> -		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT_ULL(0) |
> -							  BIT_ULL(9),
> -		[BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE)] = BIT_ULL(1),
> -		[BIT_INDEX(LANDLOCK_ACCESS_FS_IOCTL_DEV)] = BIT_ULL(2) |
> -							    BIT_ULL(0),
> +	const struct layer_access_masks layers1 = {
> +		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE |
> +			     LANDLOCK_ACCESS_FS_IOCTL_DEV,
> +		.access[1] = LANDLOCK_ACCESS_FS_TRUNCATE,
> +		.access[2] = LANDLOCK_ACCESS_FS_IOCTL_DEV,
> +		.access[9] = LANDLOCK_ACCESS_FS_EXECUTE,
>  	};
>  
>  	KUNIT_EXPECT_EQ(test, 0x1,
>  			landlock_get_deny_masks(_LANDLOCK_ACCESS_FS_OPTIONAL,
>  						LANDLOCK_ACCESS_FS_TRUNCATE,
> -						&layers1, ARRAY_SIZE(layers1)));
> +						&layers1));
>  	KUNIT_EXPECT_EQ(test, 0x20,
>  			landlock_get_deny_masks(_LANDLOCK_ACCESS_FS_OPTIONAL,
>  						LANDLOCK_ACCESS_FS_IOCTL_DEV,
> -						&layers1, ARRAY_SIZE(layers1)));
> +						&layers1));
>  	KUNIT_EXPECT_EQ(
>  		test, 0x21,
>  		landlock_get_deny_masks(_LANDLOCK_ACCESS_FS_OPTIONAL,
>  					LANDLOCK_ACCESS_FS_TRUNCATE |
>  						LANDLOCK_ACCESS_FS_IOCTL_DEV,
> -					&layers1, ARRAY_SIZE(layers1)));
> +					&layers1));
>  }
>  
>  #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
> diff --git a/security/landlock/domain.h b/security/landlock/domain.h
> index 621f054c9a2b..227066d667f7 100644
> --- a/security/landlock/domain.h
> +++ b/security/landlock/domain.h
> @@ -10,6 +10,7 @@
>  #ifndef _SECURITY_LANDLOCK_DOMAIN_H
>  #define _SECURITY_LANDLOCK_DOMAIN_H
>  
> +#include "ruleset.h"
>  #include <linux/limits.h>
>  #include <linux/mm.h>
>  #include <linux/path.h>
> @@ -122,8 +123,7 @@ struct landlock_hierarchy {
>  deny_masks_t
>  landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
>  			const access_mask_t optional_access,
> -			const layer_mask_t (*const layer_masks)[],
> -			size_t layer_masks_size);
> +			const struct layer_access_masks *const masks);
>  
>  int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy);
>  
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index bf8e37fcc7c0..cef0013c2cf6 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -398,57 +398,55 @@ static const struct access_masks any_fs = {
>  	.fs = ~0,
>  };
>  
> +/*
> + * Returns true iff the child file with the given src_child access rights under
> + * src_parent would result in having the same or fewer access rights if it were
> + * moved under new_parent.
> + */
> +static bool may_refer(const struct layer_access_masks *const src_parent,
> +		      const struct layer_access_masks *const src_child,
> +		      const struct layer_access_masks *const new_parent,
> +		      const bool child_is_dir)
> +{
> +	for (size_t i = 0; i < ARRAY_SIZE(new_parent->access); i++) {
> +		access_mask_t child_access = src_parent->access[i] &
> +					     src_child->access[i];
> +		access_mask_t parent_access = new_parent->access[i];
> +
> +		if (!child_is_dir) {
> +			child_access &= ACCESS_FILE;
> +			parent_access &= ACCESS_FILE;
> +		}
> +
> +		if (!access_mask_subset(child_access, parent_access))
> +			return false;
> +	}
> +	return true;
> +}
> +
>  /*
>   * Check that a destination file hierarchy has more restrictions than a source
>   * file hierarchy.  This is only used for link and rename actions.
>   *
> - * @layer_masks_child2: Optional child masks.
> + * Returns: true if child1 may be moved from parent1 to parent2 without
> + * increasing its access rights.  If child2 is set, an additional condition is
> + * that child2 may be used from parent2 to parent1 without increasing its access
> + * rights.
>   */
> -static bool no_more_access(
> -	const layer_mask_t (*const layer_masks_parent1)[LANDLOCK_NUM_ACCESS_FS],
> -	const layer_mask_t (*const layer_masks_child1)[LANDLOCK_NUM_ACCESS_FS],
> -	const bool child1_is_directory,
> -	const layer_mask_t (*const layer_masks_parent2)[LANDLOCK_NUM_ACCESS_FS],
> -	const layer_mask_t (*const layer_masks_child2)[LANDLOCK_NUM_ACCESS_FS],
> -	const bool child2_is_directory)
> +static bool no_more_access(const struct layer_access_masks *const parent1,
> +			   const struct layer_access_masks *const child1,
> +			   const bool child1_is_dir,
> +			   const struct layer_access_masks *const parent2,
> +			   const struct layer_access_masks *const child2,
> +			   const bool child2_is_dir)
>  {
> -	unsigned long access_bit;
> +	if (!may_refer(parent1, child1, parent2, child1_is_dir))
> +		return false;
>  
> -	for (access_bit = 0; access_bit < ARRAY_SIZE(*layer_masks_parent2);
> -	     access_bit++) {
> -		/* Ignores accesses that only make sense for directories. */
> -		const bool is_file_access =
> -			!!(BIT_ULL(access_bit) & ACCESS_FILE);
> +	if (!child2)
> +		return true;
>  
> -		if (child1_is_directory || is_file_access) {
> -			/*
> -			 * Checks if the destination restrictions are a
> -			 * superset of the source ones (i.e. inherited access
> -			 * rights without child exceptions):
> -			 * restrictions(parent2) >= restrictions(child1)
> -			 */
> -			if ((((*layer_masks_parent1)[access_bit] &
> -			      (*layer_masks_child1)[access_bit]) |
> -			     (*layer_masks_parent2)[access_bit]) !=
> -			    (*layer_masks_parent2)[access_bit])
> -				return false;
> -		}
> -
> -		if (!layer_masks_child2)
> -			continue;
> -		if (child2_is_directory || is_file_access) {
> -			/*
> -			 * Checks inverted restrictions for RENAME_EXCHANGE:
> -			 * restrictions(parent1) >= restrictions(child2)
> -			 */
> -			if ((((*layer_masks_parent2)[access_bit] &
> -			      (*layer_masks_child2)[access_bit]) |
> -			     (*layer_masks_parent1)[access_bit]) !=
> -			    (*layer_masks_parent1)[access_bit])
> -				return false;
> -		}
> -	}
> -	return true;
> +	return may_refer(parent2, child2, parent1, child2_is_dir);
>  }
>  
>  #define NMA_TRUE(...) KUNIT_EXPECT_TRUE(test, no_more_access(__VA_ARGS__))
> @@ -458,25 +456,25 @@ static bool no_more_access(
>  
>  static void test_no_more_access(struct kunit *const test)
>  {
> -	const layer_mask_t rx0[LANDLOCK_NUM_ACCESS_FS] = {
> -		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT_ULL(0),
> -		[BIT_INDEX(LANDLOCK_ACCESS_FS_READ_FILE)] = BIT_ULL(0),
> +	const struct layer_access_masks rx0 = {
> +		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE |
> +			     LANDLOCK_ACCESS_FS_READ_FILE,
>  	};
> -	const layer_mask_t mx0[LANDLOCK_NUM_ACCESS_FS] = {
> -		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT_ULL(0),
> -		[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_REG)] = BIT_ULL(0),
> +	const struct layer_access_masks mx0 = {
> +		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE |
> +			     LANDLOCK_ACCESS_FS_MAKE_REG,
>  	};
> -	const layer_mask_t x0[LANDLOCK_NUM_ACCESS_FS] = {
> -		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT_ULL(0),
> +	const struct layer_access_masks x0 = {
> +		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE,
>  	};
> -	const layer_mask_t x1[LANDLOCK_NUM_ACCESS_FS] = {
> -		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT_ULL(1),
> +	const struct layer_access_masks x1 = {
> +		.access[1] = LANDLOCK_ACCESS_FS_EXECUTE,
>  	};
> -	const layer_mask_t x01[LANDLOCK_NUM_ACCESS_FS] = {
> -		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT_ULL(0) |
> -							  BIT_ULL(1),
> +	const struct layer_access_masks x01 = {
> +		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE,
> +		.access[1] = LANDLOCK_ACCESS_FS_EXECUTE,
>  	};
> -	const layer_mask_t allows_all[LANDLOCK_NUM_ACCESS_FS] = {};
> +	const struct layer_access_masks allows_all = {};
>  
>  	/* Checks without restriction. */
>  	NMA_TRUE(&x0, &allows_all, false, &allows_all, NULL, false);
> @@ -564,31 +562,30 @@ static void test_no_more_access(struct kunit *const test)
>  #undef NMA_TRUE
>  #undef NMA_FALSE
>  
> -static bool is_layer_masks_allowed(
> -	layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
> +static bool is_layer_masks_allowed(const struct layer_access_masks *masks)
>  {
> -	return !memchr_inv(layer_masks, 0, sizeof(*layer_masks));
> +	return !memchr_inv(&masks->access, 0, sizeof(masks->access));
>  }
>  
>  /*
> - * Removes @layer_masks accesses that are not requested.
> + * Removes @masks accesses that are not requested.
>   *
>   * Returns true if the request is allowed, false otherwise.
>   */
> -static bool
> -scope_to_request(const access_mask_t access_request,
> -		 layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
> +static bool scope_to_request(const access_mask_t access_request,
> +			     struct layer_access_masks *masks)
>  {
> -	const unsigned long access_req = access_request;
> -	unsigned long access_bit;
> +	bool saw_unfulfilled_access = false;
>  
> -	if (WARN_ON_ONCE(!layer_masks))
> +	if (WARN_ON_ONCE(!masks))
>  		return true;
>  
> -	for_each_clear_bit(access_bit, &access_req, ARRAY_SIZE(*layer_masks))
> -		(*layer_masks)[access_bit] = 0;
> -
> -	return is_layer_masks_allowed(layer_masks);
> +	for (size_t i = 0; i < ARRAY_SIZE(masks->access); i++) {
> +		masks->access[i] &= access_request;
> +		if (masks->access[i])

{

> +			saw_unfulfilled_access = true;

break;
}

> +	}
> +	return !saw_unfulfilled_access;
>  }
>  
>  #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
