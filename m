Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D5B18C05
	for <linux-security-module@vger.kernel.org>; Thu, 13 Jun 2024 22:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718316950; cv=none; b=P60NufIvWXz2X/X5k4/8IhDcl32HgOZ108f3RzUEYF9NoN8PWi+MX7JwIvmD8VNdVR+b75fBF3k3doyVmij6diKiWPAHP7FF0SeSUN4z5KjoquSbktpFzPeCOwIi+CE24UhV5VZzsobZR3b9HVpZZl/sYq2T2CxqRcFasFg2ejs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718316950; c=relaxed/simple;
	bh=EAJ3SENSM/07EcTJygzvNoWfH/3JxZkNEhpv1Y2HDew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFeG7B1/vXJapX0L8F38W2HwSNX0MpycZIUEnbYwoFcvqYMEGHAVbCATjBbj8EH6gl0TCfkXFKxLLdbIGLzyB8zs51GAef4FOZXkfC5KnwZs2eY24UHHIL0CrtdK0dWWx2VAio0P0f0goHCi/ofIN5lLJFPlfG5nOQgh2c+zjPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=PZetHaSu; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="PZetHaSu"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4W0b1D1gGQzZSD;
	Thu, 13 Jun 2024 23:20:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1718313648;
	bh=bltrc3uzo8vS8jHwn/ulSkt54bkdWDw+gEreiF24kBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PZetHaSua0GDT6FnWrzTHczagBTrW+JoawqHDAM1bZq5PrTx0sMDZBVIEArhu481q
	 UxB/e7/l6SYqmvnS4tF47u2kbOaeSbQGbSLe6iM+tuIPW+dXIiYzZfxiiLzIrsxUag
	 cAOJJmbkMzLn/B0L0ClysJyECkpUgR1MnGtRT+Qo=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4W0b1C3HmCzFjy;
	Thu, 13 Jun 2024 23:20:47 +0200 (CEST)
Date: Thu, 13 Jun 2024 23:20:38 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH] landlock: Use bit-fields for storing handled layer
 access masks
Message-ID: <20240613.chiec1EeThe3@digikod.net>
References: <ZmazTKVNlsH3crwP@google.com>
 <20240610082115.1693267-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610082115.1693267-1-gnoack@google.com>
X-Infomaniak-Routing: alpha

Great!  Looking at the generated data structures with pahole, it doesn't
increase the whole size, and it should be fine with other (small) fields
too.

With this new struct, we don't need the landlock_get_* helpers anymore.
We might want to keep the landlock_add_*() helpers as safeguards
(because of the WARN_ON_ONCE) though.

On Mon, Jun 10, 2024 at 08:21:15AM +0000, Günther Noack wrote:
> When defined using bit-fields, the compiler takes care of packing the
> bits in a memory-efficient way and frees us from defining
> LANDLOCK_SHIFT_ACCESS_* by hand.  The exact memory layout does not
> matter in our use case.
> 
> The manual definition of LANDLOCK_SHIFT_ACCESS_* has resulted in bugs
> in at least two recent patch sets where new kinds of handled access
> rights were introduced.
> 
> Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> Cc: Tahera Fahimi <fahimitahera@gmail.com>
> Link: https://lore.kernel.org/all/ebd680cc-25d6-ee14-4856-310f5e5e28e4@huawei-partners.com/
> Link: https://lore.kernel.org/all/ZmLEoBfHyUR3nKAV@google.com/

Please add [1] and [2] at the end of each link to reference them in the
commit message.

> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  security/landlock/limits.h  |  2 --
>  security/landlock/ruleset.c |  4 ----
>  security/landlock/ruleset.h | 24 +++++++++---------------
>  3 files changed, 9 insertions(+), 21 deletions(-)
> 
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index 20fdb5ff3514..4eb643077a2a 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -21,12 +21,10 @@
>  #define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_IOCTL_DEV
>  #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
>  #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
> -#define LANDLOCK_SHIFT_ACCESS_FS	0
>  
>  #define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_TCP
>  #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
>  #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
> -#define LANDLOCK_SHIFT_ACCESS_NET	LANDLOCK_NUM_ACCESS_FS
>  
>  /* clang-format on */
>  
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index e0a5fbf9201a..6ff232f58618 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -169,13 +169,9 @@ static void build_check_ruleset(void)
>  		.num_rules = ~0,
>  		.num_layers = ~0,
>  	};
> -	typeof(ruleset.access_masks[0]) access_masks = ~0;
>  
>  	BUILD_BUG_ON(ruleset.num_rules < LANDLOCK_MAX_NUM_RULES);
>  	BUILD_BUG_ON(ruleset.num_layers < LANDLOCK_MAX_NUM_LAYERS);
> -	BUILD_BUG_ON(access_masks <
> -		     ((LANDLOCK_MASK_ACCESS_FS << LANDLOCK_SHIFT_ACCESS_FS) |
> -		      (LANDLOCK_MASK_ACCESS_NET << LANDLOCK_SHIFT_ACCESS_NET)));
>  }
>  
>  /**
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index c7f1526784fd..0f1b5b4c8f6b 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -39,10 +39,10 @@ static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_NET);
>  static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
>  
>  /* Ruleset access masks. */
> -typedef u32 access_masks_t;
> -/* Makes sure all ruleset access rights can be stored. */
> -static_assert(BITS_PER_TYPE(access_masks_t) >=
> -	      LANDLOCK_NUM_ACCESS_FS + LANDLOCK_NUM_ACCESS_NET);
> +struct access_masks {
> +	access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
> +	access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
> +};
>  
>  typedef u16 layer_mask_t;
>  /* Makes sure all layers can be checked. */
> @@ -226,7 +226,7 @@ struct landlock_ruleset {
>  			 * layers are set once and never changed for the
>  			 * lifetime of the ruleset.
>  			 */
> -			access_masks_t access_masks[];
> +			struct access_masks access_masks[];
>  		};
>  	};
>  };
> @@ -265,8 +265,7 @@ landlock_add_fs_access_mask(struct landlock_ruleset *const ruleset,
>  
>  	/* Should already be checked in sys_landlock_create_ruleset(). */
>  	WARN_ON_ONCE(fs_access_mask != fs_mask);
> -	ruleset->access_masks[layer_level] |=
> -		(fs_mask << LANDLOCK_SHIFT_ACCESS_FS);
> +	ruleset->access_masks[layer_level].fs |= fs_mask;
>  }
>  
>  static inline void
> @@ -278,17 +277,14 @@ landlock_add_net_access_mask(struct landlock_ruleset *const ruleset,
>  
>  	/* Should already be checked in sys_landlock_create_ruleset(). */
>  	WARN_ON_ONCE(net_access_mask != net_mask);
> -	ruleset->access_masks[layer_level] |=
> -		(net_mask << LANDLOCK_SHIFT_ACCESS_NET);
> +	ruleset->access_masks[layer_level].net |= net_mask;
>  }
>  
>  static inline access_mask_t
>  landlock_get_raw_fs_access_mask(const struct landlock_ruleset *const ruleset,
>  				const u16 layer_level)
>  {
> -	return (ruleset->access_masks[layer_level] >>
> -		LANDLOCK_SHIFT_ACCESS_FS) &
> -	       LANDLOCK_MASK_ACCESS_FS;
> +	return ruleset->access_masks[layer_level].fs;
>  }
>  
>  static inline access_mask_t
> @@ -304,9 +300,7 @@ static inline access_mask_t
>  landlock_get_net_access_mask(const struct landlock_ruleset *const ruleset,
>  			     const u16 layer_level)
>  {
> -	return (ruleset->access_masks[layer_level] >>
> -		LANDLOCK_SHIFT_ACCESS_NET) &
> -	       LANDLOCK_MASK_ACCESS_NET;
> +	return ruleset->access_masks[layer_level].net;
>  }
>  
>  bool landlock_unmask_layers(const struct landlock_rule *const rule,
> -- 
> 2.45.2.505.gda0bf45e8d-goog
> 
> 
