Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC18175A86
	for <linux-security-module@vger.kernel.org>; Mon, 25 May 2026 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741618; cv=none; b=gJOw1O//Cv1H3Lss//07SbIPuu3/V1draBNm0fZw0F1fARBc+4rGcapNpcJomaKp0hcqrMwXya3hti125jjaAD/xE3rE4gzJe+CeOT5Uk5GM+QttF3EeO/7m7KOHMxGzPc0b+RA/VIEzA22JpaGkEVHi6W7MlRbQcUPW1m6DuHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741618; c=relaxed/simple;
	bh=jWqLgxXvHExfeOAkEqPPFyain6tmPZ2VybaH15ZWUr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oL6JNAY+IN6RYjv9MT32ojvQpDaczr/vshF1Vp0rwB1UHeuDaDHoR7O5hpBFnzaF07DnaQM4ywFeQQF6HEIClkW7K+7eFLjgzRzGKJCluZ8wzYQBOiSS0Obw6UcWI+D1gAflWk+nZUsVr47G8NZkHCROlowVgaEI+O76WDXkKAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=DfM9c8ol; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="DfM9c8ol"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gPSS64WDMzYMd;
	Mon, 25 May 2026 22:40:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1779741606;
	bh=NUoNHhnGobSh5dwJyhDTxZpzbQ3UWb+bG/6EHW3JuEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DfM9c8olxH5zRkoiMxK+rXOqWhxoqlR9QykBZhrbRXAi9k1qqm7SQHFcyfWpSy4ql
	 0eXZMVDRksFftUAEnTUhjObYX+d3T4wtWjSyKCIC/gSu+ms1gMXYPCmI9K/vyM0dGj
	 nGE3pJlk97T5XPGJRDV5KXulyvK6lpkvkviGfvKM=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gPSS60Tw7zpcx;
	Mon, 25 May 2026 22:40:06 +0200 (CEST)
Date: Mon, 25 May 2026 22:40:05 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	Justin Suess <utilityemal77@gmail.com>, Jan Kara <jack@suse.cz>, Abhinav Saxena <xandfury@gmail.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v8 3/9] landlock: Suppress logging when quiet flag is
 present
Message-ID: <20260525.xoh3Queurofu@digikod.net>
References: <cover.1775490344.git.m@maowtm.org>
 <5a253279ddbc797fa320849e46f7c88d7578a581.1775490344.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a253279ddbc797fa320849e46f7c88d7578a581.1775490344.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Mon, Apr 06, 2026 at 04:52:16PM +0100, Tingmao Wang wrote:
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
>  security/landlock/audit.c  | 255 +++++++++++++++++++++++++++++++++++--
>  security/landlock/audit.h  |   3 +
>  security/landlock/domain.c |  33 +++++
>  security/landlock/domain.h |   5 +
>  security/landlock/fs.c     |  35 +++++
>  security/landlock/fs.h     |  17 ++-
>  security/landlock/net.c    |  16 +--
>  8 files changed, 340 insertions(+), 29 deletions(-)
> 
> diff --git a/security/landlock/access.h b/security/landlock/access.h
> index c19d5bc13944..2775df80c7da 100644
> --- a/security/landlock/access.h
> +++ b/security/landlock/access.h
> @@ -120,4 +120,9 @@ static inline bool access_mask_subset(access_mask_t subset,
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
> index 8d0edf94037d..2941b6d88688 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -246,7 +246,8 @@ static void test_get_denied_layer(struct kunit *const test)
>  static size_t
>  get_layer_from_deny_masks(access_mask_t *const access_request,
>  			  const access_mask_t all_existing_optional_access,
> -			  const deny_masks_t deny_masks)
> +			  const deny_masks_t deny_masks,
> +			  u8 quiet_optional_accesses, bool *quiet)

optional_access_t quiet_optional_accesses

This type should be used everywhere.

>  {
>  	const unsigned long access_opt = all_existing_optional_access;
>  	const unsigned long access_req = *access_request;
> @@ -254,6 +255,7 @@ get_layer_from_deny_masks(access_mask_t *const access_request,
>  	size_t youngest_layer = 0;
>  	size_t access_index = 0;
>  	unsigned long access_bit;
> +	bool should_quiet = false;
>  
>  	/* This will require change with new object types. */
>  	WARN_ON_ONCE(access_opt != _LANDLOCK_ACCESS_FS_OPTIONAL);
> @@ -264,18 +266,29 @@ get_layer_from_deny_masks(access_mask_t *const access_request,
>  			const size_t layer =
>  				(deny_masks >> (access_index * 4)) &
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
> @@ -285,42 +298,188 @@ static void test_get_layer_from_deny_masks(struct kunit *const test)
>  {
>  	deny_masks_t deny_mask;
>  	access_mask_t access;
> +	u8 quiet_optional_accesses;

ditto

> diff --git a/security/landlock/audit.h b/security/landlock/audit.h
> index 56778331b58c..c2da854d4405 100644
> --- a/security/landlock/audit.h
> +++ b/security/landlock/audit.h
> @@ -48,6 +48,9 @@ struct landlock_request {
>  	/* Required fields for requests with deny masks. */
>  	const access_mask_t all_existing_optional_access;
>  	deny_masks_t deny_masks;
> +	u8 quiet_optional_accesses;

ditto, use optional_access_t

> +
> +	struct collected_rule_flags rule_flags;
>  };
>  
>  #ifdef CONFIG_AUDIT
> diff --git a/security/landlock/domain.c b/security/landlock/domain.c
> index 06b6bd845060..f365721050b7 100644
> --- a/security/landlock/domain.c
> +++ b/security/landlock/domain.c
> @@ -156,6 +156,39 @@ get_layer_deny_mask(const access_mask_t all_existing_optional_access,
>  	       << ((access_weight - 1) * HWEIGHT(LANDLOCK_MAX_NUM_LAYERS - 1));
>  }
>  
> +/**
> + * landlock_get_quiet_optional_accesses - Get optional accesses which are
> + * "covered" by quiet rule flags.
> + *
> + * Returns a bitmask of which optional access are denied by layers for
> + * which rule_flags.quiet_masks has the corresponding bit set.
> + */
> +optional_access_t landlock_get_quiet_optional_accesses(
> +	const access_mask_t all_existing_optional_access,
> +	const deny_masks_t deny_masks,
> +	const struct collected_rule_flags rule_flags)
> +{
> +	const unsigned long access_opt = all_existing_optional_access;
> +	size_t access_index = 0;
> +	unsigned long access_bit;
> +	optional_access_t quiet_optional_accesses = 0;

It's only correct here.

> +
> +	/* This will require change with new object types. */
> +	WARN_ON_ONCE(access_opt != _LANDLOCK_ACCESS_FS_OPTIONAL);
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
>  static void test_get_layer_deny_mask(struct kunit *const test)
