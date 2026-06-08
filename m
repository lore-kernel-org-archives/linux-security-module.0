Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B232B3B42ED
	for <linux-security-module@vger.kernel.org>; Mon,  8 Jun 2026 22:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780959066; cv=none; b=JtCLiaABe7n987TutPfD5/H2xQ6RM2/6SPMfvhcX3nW1RxBwMp2c0KaGQkVnCNPCunOiai5UNTBWbHX9yTFLKIfVnULJsohUVHjM8juZVVsUUOgfK3llgaStxcmNEv1n9HCnkuw8kngLO61N0yQVgoJSBBzky6eIDAUxwXZOPPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780959066; c=relaxed/simple;
	bh=rKSMj0+pzJYWjvKFZSB41mWe3LNO60rGuf/qrf1/ewc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hS0457DySsz9/CjZlFFDz9Ic042dBYyPFcim0u38EoZmC8B6uQx5Y/WJq6W3pT9P1DOGqy6NkUzdenxcboATRMatLHNspKMJgxUBIprxiIqAgacz5HYfZJtxirt89FkYiUGwMu7ZVdMkDRg5y2QzvHjqono20u0mLi0WA9532vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=dLc6gomP; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="dLc6gomP"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gZ6Tp0sZyzP3Q;
	Tue,  9 Jun 2026 00:41:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1780958493;
	bh=wpgC8LflMWCIN81591tC9j+TjzYoQbVyptFroZF9mzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dLc6gomPFHWhRx4izhGx8oe080MV6VOKxH7gliWUHtMlMBlpT+IQkVFjPVt9vXHi9
	 5ediHX42ij+AFS27RrDs0vDvrnw/Ic2hjJkuTkoeASiy14rnxkd6wx4rL9mc4NGDJ5
	 ZnH7WAAO0/+8+7vMUCaiemnHkEKlSfcg+r5qd4NQ=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gZ6Tn2ldgz53j;
	Tue,  9 Jun 2026 00:41:33 +0200 (CEST)
Date: Tue, 9 Jun 2026 00:41:32 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	Justin Suess <utilityemal77@gmail.com>, Jan Kara <jack@suse.cz>, Abhinav Saxena <xandfury@gmail.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v10 3/9] landlock: Suppress logging when quiet flag is
 present
Message-ID: <20260608.daeshu7Leequ@digikod.net>
References: <cover.1780272022.git.m@maowtm.org>
 <d208c793ac5d5f45bd1bbf87f57d9cc3ab47d6a7.1780272022.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d208c793ac5d5f45bd1bbf87f57d9cc3ab47d6a7.1780272022.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Mon, Jun 01, 2026 at 01:00:37AM +0100, Tingmao Wang wrote:
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
> Assisted-by: GitHub Copilot:claude-opus-4.7 copilot-review
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
> 
> Changes in v10:
> - clang-format header file changes too
> - Fix grammar in some comments
> 
> Changes in v9:
> - Fix conflict
> - Applied struct layer_masks changes to this as well.
> - Replace 4 with HWEIGHT(LANDLOCK_MAX_NUM_LAYERS - 1) in
>   landlock_get_quiet_optional_accesses()
> - Replace 4 with HWEIGHT in (existing) get_layer_from_deny_masks as
>   well.
> - Use optional_access_t typedef for all quiet_optional_accesses values
>   instead of u8
> 
> Changes in v8:
> - Rebase on top of mic/next
> - Populate request.rule_flags in hook_unix_find()
> 
> Changes in v7:
> - Following change in commit 1, now we need to copy rule_flags into
>   landlock_request before calling landlock_log_denial for relevant fs
>   denials
> - Remove left over param comment
> 
> Changes in v5:
> - Update code style and comment in get_layer_from_deny_masks() and
>   landlock_log_denial()
> - Now that rule_flags is moved into landlock_request, this version removes
>   the extra parameter for landlock_log_denial and gets rid of
>   no_rule_flags, simplifying some code.
> - Fix build failure without CONFIG_AUDIT (reported by Justin Suess)
> 
> Changes in v3:
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
> Changes in v2:
> - Supports the new quiet access masks.
> - Support quieting scope requests (but not ptrace and attempted mounting
>   for now)
> 
>  security/landlock/access.h |   5 +
>  security/landlock/audit.c  | 261 ++++++++++++++++++++++++++++++++++---
>  security/landlock/audit.h  |   1 +
>  security/landlock/domain.c |  33 +++++
>  security/landlock/domain.h |   4 +
>  security/landlock/fs.c     |  29 +++++
>  security/landlock/fs.h     |  17 ++-
>  security/landlock/net.c    |  15 +--
>  8 files changed, 335 insertions(+), 30 deletions(-)
> 
> diff --git a/security/landlock/access.h b/security/landlock/access.h
> index 42d8b5134358..8cc4ee3427e5 100644
> --- a/security/landlock/access.h
> +++ b/security/landlock/access.h
> @@ -141,4 +141,9 @@ static inline bool access_mask_subset(access_mask_t subset,
>  	return (subset | superset) == superset;
>  }
>  
> +/* A bitmask that is large enough to hold set of optional accesses. */
> +typedef u8 optional_access_t;
> +static_assert(BITS_PER_TYPE(optional_access_t) >=
> +	      HWEIGHT(_LANDLOCK_ACCESS_FS_OPTIONAL));
> +
>  #endif /* _SECURITY_LANDLOCK_ACCESS_H */
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index 8c56f7f6467a..2d8197cc8fe3 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -249,7 +249,9 @@ static void test_get_denied_layer(struct kunit *const test)
>  static size_t
>  get_layer_from_deny_masks(access_mask_t *const access_request,
>  			  const access_mask_t all_existing_optional_access,
> -			  const deny_masks_t deny_masks)
> +			  const deny_masks_t deny_masks,
> +			  optional_access_t quiet_optional_accesses,
> +			  bool *quiet)
>  {
>  	const unsigned long access_opt = all_existing_optional_access;
>  	const unsigned long access_req = *access_request;
> @@ -257,6 +259,7 @@ get_layer_from_deny_masks(access_mask_t *const access_request,
>  	size_t youngest_layer = 0;
>  	size_t access_index = 0;
>  	unsigned long access_bit;
> +	bool should_quiet = false;
>  
>  	/* This will require change with new object types. */
>  	WARN_ON_ONCE(access_opt != _LANDLOCK_ACCESS_FS_OPTIONAL);
> @@ -265,20 +268,33 @@ get_layer_from_deny_masks(access_mask_t *const access_request,
>  			 BITS_PER_TYPE(access_mask_t)) {
>  		if (access_req & BIT(access_bit)) {
>  			const size_t layer =
> -				(deny_masks >> (access_index * 4)) &
> +				(deny_masks >>
> +				 (access_index *
> +				  HWEIGHT(LANDLOCK_MAX_NUM_LAYERS - 1))) &
>  				(LANDLOCK_MAX_NUM_LAYERS - 1);
> +			const bool layer_has_quiet =
> +				!!(quiet_optional_accesses & BIT(access_index));
>  
>  			if (layer > youngest_layer) {
>  				youngest_layer = layer;
>  				missing = BIT(access_bit);
> +				should_quiet = layer_has_quiet;
>  			} else if (layer == youngest_layer) {
>  				missing |= BIT(access_bit);
> +				/*
> +				 * Whether the layer has rules with quiet flag covering
> +				 * the file accessed does not depend on the access, and so
> +				 * the following WARN_ON_ONCE() should not fail.
> +				 */
> +				WARN_ON_ONCE(should_quiet && !layer_has_quiet);

WARN_ON_ONCE(should_quiet != layer_has_quiet);

> +				should_quiet = layer_has_quiet;
>  			}
>  		}
>  		access_index++;
>  	}
>  
>  	*access_request = missing;
> +	*quiet = should_quiet;
>  	return youngest_layer;
>  }
>  
> @@ -288,42 +304,188 @@ static void test_get_layer_from_deny_masks(struct kunit *const test)
>  {
>  	deny_masks_t deny_mask;
>  	access_mask_t access;
> +	optional_access_t quiet_optional_accesses;
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
> @@ -354,6 +516,22 @@ static bool is_valid_request(const struct landlock_request *const request)
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
> @@ -367,6 +545,7 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
>  	struct landlock_hierarchy *youngest_denied;
>  	size_t youngest_layer;
>  	access_mask_t missing;
> +	bool object_quiet_flag = false, quiet_applicable_to_access = false;
>  
>  	if (WARN_ON_ONCE(!subject || !subject->domain ||
>  			 !subject->domain->hierarchy || !request))
> @@ -382,10 +561,15 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
>  			youngest_layer = get_denied_layer(subject->domain,
>  							  &missing,
>  							  request->layer_masks);
> +			object_quiet_flag =
> +				request->layer_masks->layers[youngest_layer]
> +					.quiet;
>  		} else {
>  			youngest_layer = get_layer_from_deny_masks(
>  				&missing, _LANDLOCK_ACCESS_FS_OPTIONAL,
> -				request->deny_masks);
> +				request->deny_masks,
> +				request->quiet_optional_accesses,
> +				&object_quiet_flag);
>  		}
>  		youngest_denied =
>  			get_hierarchy(subject->domain, youngest_layer);
> @@ -420,6 +604,53 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
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
> +		const access_mask_t quiet_mask =
> +			pick_access_mask_for_request_type(
> +				request->type, youngest_denied->quiet_masks);
> +
> +		quiet_applicable_to_access = (quiet_mask & missing) == missing;
> +	} else {
> +		/*
> +		 * Either the object is not quiet, or this is a scope request.  We
> +		 * check request->type to distinguish between the two cases.
> +		 */
> +		const access_mask_t quiet_mask =
> +			youngest_denied->quiet_masks.scope;
> +
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
> diff --git a/security/landlock/audit.h b/security/landlock/audit.h
> index b85d752273ac..620f8a24291d 100644
> --- a/security/landlock/audit.h
> +++ b/security/landlock/audit.h
> @@ -48,6 +48,7 @@ struct landlock_request {
>  	/* Required fields for requests with deny masks. */
>  	const access_mask_t all_existing_optional_access;
>  	deny_masks_t deny_masks;
> +	optional_access_t quiet_optional_accesses;

Please update is_valid_request() with the new invariant.

>  };
>  
>  #ifdef CONFIG_AUDIT
> diff --git a/security/landlock/domain.c b/security/landlock/domain.c
> index d1a4d8b33ee1..60c356dacc83 100644
> --- a/security/landlock/domain.c
> +++ b/security/landlock/domain.c
> @@ -157,6 +157,39 @@ get_layer_deny_mask(const access_mask_t all_existing_optional_access,
>  	       << ((access_weight - 1) * HWEIGHT(LANDLOCK_MAX_NUM_LAYERS - 1));
>  }
>  
> +/**
> + * landlock_get_quiet_optional_accesses - Get optional accesses which are
> + * "covered" by quiet rule flags.

Please try to add a non-wrapping description (still 80 columns), or
align it (see other kdoc).

Check the kernel doc warnings:
@all_existing_optional_access:
@...

> + *
> + * Returns a bitmask of which optional accesses are denied by layers for

Return: a bitmask...

> + * which the quiet flag was collected during the path walk.
> + */
> +optional_access_t landlock_get_quiet_optional_accesses(
> +	const access_mask_t all_existing_optional_access,
> +	const deny_masks_t deny_masks, const struct layer_masks *const masks)
> +{
> +	const unsigned long access_opt = all_existing_optional_access;
> +	size_t access_index = 0;
> +	unsigned long access_bit;
> +	optional_access_t quiet_optional_accesses = 0;
> +
> +	/* This will require change with new object types. */
> +	WARN_ON_ONCE(access_opt != _LANDLOCK_ACCESS_FS_OPTIONAL);
> +
> +	for_each_set_bit(access_bit, &access_opt,
> +			 BITS_PER_TYPE(access_mask_t)) {
> +		const u8 layer =
> +			(deny_masks >> (access_index *
> +					HWEIGHT(LANDLOCK_MAX_NUM_LAYERS - 1))) &
> +			(LANDLOCK_MAX_NUM_LAYERS - 1);
> +
> +		if (masks->layers[layer].quiet)
> +			quiet_optional_accesses |= BIT(access_index);
> +		access_index++;
> +	}
> +	return quiet_optional_accesses;
> +}
> +
>  #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
>  
>  static void test_get_layer_deny_mask(struct kunit *const test)
> diff --git a/security/landlock/domain.h b/security/landlock/domain.h
> index 9f560f3c3bd1..2a1660e3dea7 100644
> --- a/security/landlock/domain.h
> +++ b/security/landlock/domain.h
> @@ -126,6 +126,10 @@ landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
>  			const access_mask_t optional_access,
>  			const struct layer_masks *const masks);
>  
> +optional_access_t landlock_get_quiet_optional_accesses(
> +	const access_mask_t all_existing_optional_access,
> +	const deny_masks_t deny_masks, const struct layer_masks *const masks);
> +
>  int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy);
>  
>  static inline void
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index cc0852f77311..a8cb3179f815 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1727,8 +1727,31 @@ get_required_file_open_access(const struct file *const file)
>  	return access;
>  }
>  
> +static void build_check_file_security(void)
> +{
> +#ifdef CONFIG_AUDIT
> +	const struct landlock_file_security file_sec = {
> +		.quiet_optional_accesses = ~0,
> +		.fown_layer = ~0,
> +	};
> +
> +	/*
> +	 * Make sure quiet_optional_accesses has enough bits to cover all
> +	 * optional accesses.  The use of __const_hweight64() rather than
> +	 * HWEIGHT() is due to GCC erroring about non-constants in
> +	 * BUILD_BUG_ON call when using the latter, and the use of the 64bit
> +	 * version is for future-proofing.
> +	 */
> +	BUILD_BUG_ON(__const_hweight64((u64)file_sec.quiet_optional_accesses) <
> +		     __const_hweight64(_LANDLOCK_ACCESS_FS_OPTIONAL));
> +	/* Makes sure all layers can be identified. */
> +	BUILD_BUG_ON(file_sec.fown_layer < LANDLOCK_MAX_NUM_LAYERS - 1);
> +#endif /* CONFIG_AUDIT */
> +}
> +
>  static int hook_file_alloc_security(struct file *const file)
>  {
> +	build_check_file_security();
>  	/*
>  	 * Grants all access rights, even if most of them are not checked later
>  	 * on. It is more consistent.
> @@ -1805,6 +1828,10 @@ static int hook_file_open(struct file *const file)
>  #ifdef CONFIG_AUDIT
>  	landlock_file(file)->deny_masks = landlock_get_deny_masks(
>  		_LANDLOCK_ACCESS_FS_OPTIONAL, optional_access, &layer_masks);
> +	landlock_file(file)->quiet_optional_accesses =
> +		landlock_get_quiet_optional_accesses(
> +			_LANDLOCK_ACCESS_FS_OPTIONAL,
> +			landlock_file(file)->deny_masks, &layer_masks);
>  #endif /* CONFIG_AUDIT */
>  
>  	if (access_mask_subset(open_access_request, allowed_access))
> @@ -1841,6 +1868,7 @@ static int hook_file_truncate(struct file *const file)
>  		.access = LANDLOCK_ACCESS_FS_TRUNCATE,
>  #ifdef CONFIG_AUDIT
>  		.deny_masks = landlock_file(file)->deny_masks,
> +		.quiet_optional_accesses = landlock_file(file)->quiet_optional_accesses,
>  #endif /* CONFIG_AUDIT */
>  	});
>  	return -EACCES;
> @@ -1880,6 +1908,7 @@ static int hook_file_ioctl_common(const struct file *const file,
>  		.access = LANDLOCK_ACCESS_FS_IOCTL_DEV,
>  #ifdef CONFIG_AUDIT
>  		.deny_masks = landlock_file(file)->deny_masks,
> +		.quiet_optional_accesses = landlock_file(file)->quiet_optional_accesses,
>  #endif /* CONFIG_AUDIT */
>  	});
>  	return -EACCES;
> diff --git a/security/landlock/fs.h b/security/landlock/fs.h
> index cb7e654933ac..d0fca7da2466 100644
> --- a/security/landlock/fs.h
> +++ b/security/landlock/fs.h
> @@ -63,11 +63,20 @@ struct landlock_file_security {
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
> +	optional_access_t quiet_optional_accesses
> +		: HWEIGHT(_LANDLOCK_ACCESS_FS_OPTIONAL);
>  	/**
>  	 * @fown_layer: Layer level of @fown_subject->domain with
>  	 * LANDLOCK_SCOPE_SIGNAL.
>  	 */
> -	u8 fown_layer;
> +	u8 fown_layer : 4;

Please don't hardcode such size.

Anyway, fown_layer can be updated concurrently (holding a lock), so we
should not convert it to a bitfield.

>  #endif /* CONFIG_AUDIT */
>  
>  	/**

> @@ -82,12 +91,6 @@ struct landlock_file_security {
>  
>  #ifdef CONFIG_AUDIT
>  
> -/* Makes sure all layers can be identified. */
> -/* clang-format off */
> -static_assert((typeof_member(struct landlock_file_security, fown_layer))~0 >=
> -	      LANDLOCK_MAX_NUM_LAYERS);
> -/* clang-format off */
> -
>  #endif /* CONFIG_AUDIT */

Remaining useless ifdef/endif.

>  
>  /**
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index 71868289748a..60894cff973e 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -241,14 +241,13 @@ static int current_check_access_socket(struct socket *const sock,
>  
>  	audit_net.family = address->sa_family;
>  	audit_net.sk = sock->sk;
> -	landlock_log_denial(subject,
> -			    &(struct landlock_request){
> -				    .type = LANDLOCK_REQUEST_NET_ACCESS,
> -				    .audit.type = LSM_AUDIT_DATA_NET,
> -				    .audit.u.net = &audit_net,
> -				    .access = access_request,
> -				    .layer_masks = &layer_masks,
> -			    });
> +	landlock_log_denial(
> +		subject,
> +		&(struct landlock_request){ .type = LANDLOCK_REQUEST_NET_ACCESS,
> +					    .audit.type = LSM_AUDIT_DATA_NET,
> +					    .audit.u.net = &audit_net,
> +					    .access = access_request,
> +					    .layer_masks = &layer_masks });
>  	return -EACCES;
>  }
>  
> -- 
> 2.54.0
