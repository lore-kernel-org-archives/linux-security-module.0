Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F54341042
	for <linux-security-module@vger.kernel.org>; Fri, 21 Nov 2025 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763740361; cv=none; b=VBv99Qywe9ozFe/bpZ30KiQQ06Hue9hHRIVCBPCrS6wsiOeww4jh5W8p3LqOPYW+7dRQJCAXZBGG7To7vwOI8Lri7e7I2PIKgeqG19zWu4ktNhEZemYIMS0YogXAxA24IBvXusDW30MhPwEnLcY9iql5X4kBWUvxgQ8n6o0NkMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763740361; c=relaxed/simple;
	bh=odxaQHvKqKYzrJ8yFG9LprI6GNHFxP+4pl6X007qxbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5Le+6Isw3yvaN9eg0QPyMAAUcZ3BN4MifIicFHL/m5jqSqa7RVK9dbLBtWFbxnF7LFQC/+b+y6F/VRWe94r96pFAIs3y6vbRuTNHWxicM9wN7pazMayLy7Gq3L/FO92z5QqudZ9Qupk0D02OApA68Yk6ytOQLHZendAIWeOdNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0fkSzEh4; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0fkSzEh4"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dCfGd32HZzCCB;
	Fri, 21 Nov 2025 16:27:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1763738841;
	bh=UaGRmQ6olq3DUVs//kGNdLCeOqgFXRqc51P99rALZiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0fkSzEh4D8zRJQilW76SXBR9jZnKOnUySmqUq/cmTO34nbGTdz9R5P0zpTLInV8Eo
	 ndnJcRdJQHKhMDV+GNAxGWMWNQk0Mbkty1iVetMlGSzuCvyZoRGG9OiGINEU0GVm3q
	 HhpE89vcAm58Y43sl2ktPfGW+vxFbNh6VSicNI68=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dCfGc5d5qz9fp;
	Fri, 21 Nov 2025 16:27:20 +0100 (CET)
Date: Fri, 21 Nov 2025 16:27:14 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Justin Suess <utilityemal77@gmail.com>, Jan Kara <jack@suse.cz>, Abhinav Saxena <xandfury@gmail.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 03/10] landlock: Suppress logging when quiet flag is
 present
Message-ID: <20251120.eoghapeeGh7i@digikod.net>
References: <cover.1763330228.git.m@maowtm.org>
 <5c0de8ee7e00aff1aceb3a80f5af162eeaaa06db.1763330228.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c0de8ee7e00aff1aceb3a80f5af162eeaaa06db.1763330228.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Sun, Nov 16, 2025 at 09:59:33PM +0000, Tingmao Wang wrote:
> The quietness behaviour is as documented in the previous patch.
> 
> For optional accesses, since the existing deny_masks can only store 2x4bit
> of layer index, with no way to represent "no layer", we need to either
> expand it or have another field to correctly handle quieting of those.
> This commit uses the latter approach - we add another field to store which
> optional access (of the 2) are covered by quiet rules in their respective
> layers as stored in deny_masks.
> 
> We can avoid making struct landlock_file_security larger by converting the
> existing fown_layer to a 4bit field.  This commit does that, and adds test
> to ensure that it is large enough for LANDLOCK_MAX_NUM_LAYERS-1.
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
> 
> Changes since v2:
> - Renamed patch title from "Check for quiet flag in landlock_log_denial"
>   to this given the growth.
> - Moved quiet bit check after domain_exec check
> - Rename, style and comment fixes suggested by Mickaël.
> - Squashed patch 6/6 from v2 "Implement quiet for optional accesses" into
>   this one.  Changes to that below:
> - Refactor the quiet flag setting in get_layer_from_deny_masks() to be
>   more clear.
> - Add KUnit tests
> - Fix comments, add WARN_ON_ONCE, use __const_hweight64() as suggested by
>   review
> - Move build_check_file_security to fs.c
> - Use a typedef for quiet_optional_accesses, add static_assert, and
>   improve docs on landlock_get_quiet_optional_accesses.
> 
> Changes since v1:
> - Supports the new quiet access masks.
> - Support quieting scope requests (but not ptrace and attempted mounting
>   for now)
> 
>  security/landlock/access.h  |   5 +
>  security/landlock/audit.c   | 255 +++++++++++++++++++++++++++++++++---
>  security/landlock/audit.h   |   4 +-
>  security/landlock/domain.c  |  33 +++++
>  security/landlock/domain.h  |   5 +
>  security/landlock/fs.c      |  45 +++++--
>  security/landlock/fs.h      |  17 ++-
>  security/landlock/net.c     |   3 +-
>  security/landlock/ruleset.h |   5 +
>  security/landlock/task.c    |  12 +-
>  10 files changed, 344 insertions(+), 40 deletions(-)
> 
> diff --git a/security/landlock/access.h b/security/landlock/access.h
> index 7961c6630a2d..db47edc88afa 100644
> --- a/security/landlock/access.h
> +++ b/security/landlock/access.h
> @@ -97,4 +97,9 @@ landlock_upgrade_handled_access_masks(struct access_masks access_masks)
>  	return access_masks;
>  }
>  
> +/* A bitmask that is large enough to hold set of optional accesses. */
> +typedef u8 optional_access_t;
> +static_assert(BITS_PER_TYPE(optional_access_t) >=
> +	      HWEIGHT(_LANDLOCK_ACCESS_FS_OPTIONAL));
> +
>  #endif /* _SECURITY_LANDLOCK_ACCESS_H */
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index c52d079cdb77..505b13c8f4c2 100644
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
> @@ -285,18 +285,29 @@ get_layer_from_deny_masks(access_mask_t *const access_request,
>  	/* This will require change with new object types. */
>  	WARN_ON_ONCE(access_opt != _LANDLOCK_ACCESS_FS_OPTIONAL);
>  
> +	*quiet = false;

I'd prefer to have a local variable and just at before returning,
setting the quiet parameter, similar to access_request.

>  	for_each_set_bit(access_bit, &access_opt,
>  			 BITS_PER_TYPE(access_mask_t)) {
>  		if (access_req & BIT(access_bit)) {
>  			const size_t layer =
>  				(deny_masks >> (access_index * 4)) &
>  				(LANDLOCK_MAX_NUM_LAYERS - 1);
> +			const bool layer_has_quiet =
> +				!!(quiet_optional_accesses & BIT(access_index));
>  
>  			if (layer > youngest_layer) {
>  				youngest_layer = layer;
> +				*quiet = layer_has_quiet;
>  				missing = BIT(access_bit);
>  			} else if (layer == youngest_layer) {
>  				missing |= BIT(access_bit);
> +				/*
> +				 * Whether the layer has rules with quiet flag covering
> +				 * the file accessed does not depend on the access, and so
> +				 * if this fails, quiet_optional_accesses is corrupted.
> +				 */
> +				WARN_ON_ONCE(*quiet && !layer_has_quiet);
> +				*quiet = layer_has_quiet;

In this case, why update *quiet?

>  			}
>  		}
>  		access_index++;
> @@ -312,42 +323,188 @@ static void test_get_layer_from_deny_masks(struct kunit *const test)
>  {
>  	deny_masks_t deny_mask;
>  	access_mask_t access;
> +	u8 quiet_optional_accesses;
> +	bool quiet;
>  
>  	/* truncate:0 ioctl_dev:2 */
>  	deny_mask = 0x20;
> +	quiet_optional_accesses = 0;
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
> +	KUNIT_EXPECT_EQ(test, quiet, false);
> +
> +	access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
> +	KUNIT_EXPECT_EQ(test, 2,
> +			get_layer_from_deny_masks(
> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
> +				deny_mask, quiet_optional_accesses, &quiet));
> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
> +	KUNIT_EXPECT_EQ(test, quiet, false);
> +
> +	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
> +	KUNIT_EXPECT_EQ(test, 2,
> +			get_layer_from_deny_masks(
> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
> +				deny_mask, quiet_optional_accesses, &quiet));
> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
> +	KUNIT_EXPECT_EQ(test, quiet, false);
> +
> +	/* layer denying truncate: quiet, ioctl: not quiet */
> +	quiet_optional_accesses = 0b01;
> +
> +	access = LANDLOCK_ACCESS_FS_TRUNCATE;
> +	KUNIT_EXPECT_EQ(test, 0,
> +			get_layer_from_deny_masks(
> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
> +				deny_mask, quiet_optional_accesses, &quiet));
> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
> +	KUNIT_EXPECT_EQ(test, quiet, true);
> +
> +	access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
> +	KUNIT_EXPECT_EQ(test, 2,
> +			get_layer_from_deny_masks(
> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
> +				deny_mask, quiet_optional_accesses, &quiet));
> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
> +	KUNIT_EXPECT_EQ(test, quiet, false);
> +
> +	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
> +	KUNIT_EXPECT_EQ(test, 2,
> +			get_layer_from_deny_masks(
> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
> +				deny_mask, quiet_optional_accesses, &quiet));
> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
> +	KUNIT_EXPECT_EQ(test, quiet, false);
> +
> +	/* Reverse order - truncate:2 ioctl_dev:0 */
> +	deny_mask = 0x02;
> +	quiet_optional_accesses = 0;
> +
> +	access = LANDLOCK_ACCESS_FS_TRUNCATE;
> +	KUNIT_EXPECT_EQ(test, 2,
> +			get_layer_from_deny_masks(
> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
> +				deny_mask, quiet_optional_accesses, &quiet));
> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
> +	KUNIT_EXPECT_EQ(test, quiet, false);
> +
> +	access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
> +	KUNIT_EXPECT_EQ(test, 0,
> +			get_layer_from_deny_masks(
> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
> +				deny_mask, quiet_optional_accesses, &quiet));
> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
> +	KUNIT_EXPECT_EQ(test, quiet, false);
> +
> +	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
> +	KUNIT_EXPECT_EQ(test, 2,
> +			get_layer_from_deny_masks(
> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
> +				deny_mask, quiet_optional_accesses, &quiet));
> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
> +	KUNIT_EXPECT_EQ(test, quiet, false);
> +
> +	/* layer denying truncate: quiet, ioctl: not quiet */
> +	quiet_optional_accesses = 0b01;
> +
> +	access = LANDLOCK_ACCESS_FS_TRUNCATE;
> +	KUNIT_EXPECT_EQ(test, 2,
> +			get_layer_from_deny_masks(
> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
> +				deny_mask, quiet_optional_accesses, &quiet));
> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
> +	KUNIT_EXPECT_EQ(test, quiet, true);
> +
> +	access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
> +	KUNIT_EXPECT_EQ(test, 0,
> +			get_layer_from_deny_masks(
> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
> +				deny_mask, quiet_optional_accesses, &quiet));
> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
> +	KUNIT_EXPECT_EQ(test, quiet, false);
>  
>  	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
>  	KUNIT_EXPECT_EQ(test, 2,
> -			get_layer_from_deny_masks(&access,
> -						  _LANDLOCK_ACCESS_FS_OPTIONAL,
> -						  deny_mask));
> +			get_layer_from_deny_masks(
> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
> +				deny_mask, quiet_optional_accesses, &quiet));
> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
> +	KUNIT_EXPECT_EQ(test, quiet, true);
> +
> +	/* layer denying truncate: not quiet, ioctl: quiet */
> +	quiet_optional_accesses = 0b10;
> +
> +	access = LANDLOCK_ACCESS_FS_TRUNCATE;
> +	KUNIT_EXPECT_EQ(test, 2,
> +			get_layer_from_deny_masks(
> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
> +				deny_mask, quiet_optional_accesses, &quiet));
> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
> +	KUNIT_EXPECT_EQ(test, quiet, false);
> +
> +	access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
> +	KUNIT_EXPECT_EQ(test, 0,
> +			get_layer_from_deny_masks(
> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
> +				deny_mask, quiet_optional_accesses, &quiet));
>  	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
> +	KUNIT_EXPECT_EQ(test, quiet, true);
> +
> +	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
> +	KUNIT_EXPECT_EQ(test, 2,
> +			get_layer_from_deny_masks(
> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
> +				deny_mask, quiet_optional_accesses, &quiet));
> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
> +	KUNIT_EXPECT_EQ(test, quiet, false);
>  
>  	/* truncate:15 ioctl_dev:15 */
>  	deny_mask = 0xff;
> +	quiet_optional_accesses = 0;
> +
> +	access = LANDLOCK_ACCESS_FS_TRUNCATE;
> +	KUNIT_EXPECT_EQ(test, 15,
> +			get_layer_from_deny_masks(
> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
> +				deny_mask, quiet_optional_accesses, &quiet));
> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
> +	KUNIT_EXPECT_EQ(test, quiet, false);
> +
> +	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
> +	KUNIT_EXPECT_EQ(test, 15,
> +			get_layer_from_deny_masks(
> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
> +				deny_mask, quiet_optional_accesses, &quiet));
> +	KUNIT_EXPECT_EQ(test, access,
> +			LANDLOCK_ACCESS_FS_TRUNCATE |
> +				LANDLOCK_ACCESS_FS_IOCTL_DEV);
> +	KUNIT_EXPECT_EQ(test, quiet, false);
> +
> +	/* Both quiet (same layer so quietness must be the same) */
> +	quiet_optional_accesses = 0b11;
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
> +	KUNIT_EXPECT_EQ(test, quiet, true);
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
> +	KUNIT_EXPECT_EQ(test, quiet, true);
>  }
>  
>  #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
> @@ -381,19 +538,39 @@ static bool is_valid_request(const struct landlock_request *const request)
>  	return true;
>  }
>  
> +static access_mask_t
> +pick_access_mask_for_request_type(const enum landlock_request_type type,
> +				  const struct access_masks access_masks)
> +{
> +	switch (type) {
> +	case LANDLOCK_REQUEST_FS_ACCESS:
> +		return access_masks.fs;
> +	case LANDLOCK_REQUEST_NET_ACCESS:
> +		return access_masks.net;
> +	default:
> +		WARN_ONCE(1, "Invalid request type %d passed to %s", type,
> +			  __func__);
> +		return 0;
> +	}
> +}
> +
>  /**
>   * landlock_log_denial - Create audit records related to a denial
>   *
>   * @subject: The Landlock subject's credential denying an action.
>   * @request: Detail of the user space request.
> + * @rule_flags: The flags for the matched rule, or no_rule_flags (zero) if
> + * this is a scope request (no particular object involved).
>   */
>  void landlock_log_denial(const struct landlock_cred_security *const subject,
> -			 const struct landlock_request *const request)
> +			 const struct landlock_request *const request,
> +			 const struct collected_rule_flags rule_flags)

It would be simpler and limit code change to move rule_flags/quiet_flags
into struct landlock_request, which means we can also remove
no_rule_flags.

>  {
>  	struct audit_buffer *ab;
>  	struct landlock_hierarchy *youngest_denied;
>  	size_t youngest_layer;
> -	access_mask_t missing;
> +	access_mask_t missing, quiet_mask;
> +	bool object_quiet_flag = false, quiet_applicable_to_access = false;
>  
>  	if (WARN_ON_ONCE(!subject || !subject->domain ||
>  			 !subject->domain->hierarchy || !request))
> @@ -409,10 +586,13 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
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
> @@ -447,6 +627,49 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
>  			return;
>  	}
>  
> +	/*
> +	 * Checks if the object is marked quiet by the layer that denied the
> +	 * request.  If it's a different layer that marked it as quiet, but
> +	 * that layer is not the one that denied the request, we should still
> +	 * audit log the denial.
> +	 */
> +	if (object_quiet_flag) {
> +		/*
> +		 * We now check if the denied requests are all covered by the
> +		 * layer's quiet access bits.
> +		 */
> +		quiet_mask = pick_access_mask_for_request_type(

This quiet_mask is only used in this branch, so we can declare it here
and make it const:

const access_mask_t quiet_mask = pick_access_mask_for_request_type(


> +			request->type, youngest_denied->quiet_masks);
> +		quiet_applicable_to_access = (quiet_mask & missing) == missing;

I think it should be:

  quiet_applicable_to_access = (quiet_mask & missing) == (handled_mask & missing);

We should have a test for this case: an access request (e.g. read-write)
is denied, half by one layer (e.g. read) and half by another (e.g.
write).  Tests should cover this matrix.

> +	} else {
> +		/*
> +		 * Either the object is not quiet, or this is a scope request.  We
> +		 * check request->type to distinguish between the two cases.
> +		 */
> +		quiet_mask = youngest_denied->quiet_masks.scope;

const access_mask_t quiet_mask = youngest_denied->quiet_masks.scope;

> +		switch (request->type) {
> +		case LANDLOCK_REQUEST_SCOPE_SIGNAL:
> +			quiet_applicable_to_access =
> +				!!(quiet_mask & LANDLOCK_SCOPE_SIGNAL);
> +			break;
> +		case LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET:
> +			quiet_applicable_to_access =
> +				!!(quiet_mask &
> +				   LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
> +			break;
> +		/*
> +		 * Leave LANDLOCK_REQUEST_PTRACE and
> +		 * LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY unhandled for now - they are
> +		 * never quiet.
> +		 */
> +		default:
> +			break;
> +		}
> +	}
> +
> +	if (quiet_applicable_to_access)
> +		return;
> +
>  	/* Uses consistent allocation flags wrt common_lsm_audit(). */
>  	ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
>  			     AUDIT_LANDLOCK_ACCESS);
