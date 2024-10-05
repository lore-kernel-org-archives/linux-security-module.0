Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6509F288B1;
	Sat,  5 Oct 2024 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728147481; cv=none; b=LpL92Pw+r4teS4uPgT5Rs16R8RlZyQG1tweIeXcPVRP2WKKNtYcXLtyJR5u5SQ1xTcTcsmdwRt91GJqHCBaxiy0VkocyTCaTjy6Ibu5ENhyjHH9uP75ajfX6nchnVHCqLiT3nYKzI5ZmXLn5XUgnocdfo2fSxYIjhAZcxTTn0g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728147481; c=relaxed/simple;
	bh=due5SQ2j6U3xIJr5gu+myfsTPiEqDeRAIQo/FDpWkgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8cYZSMatQZgjLwDqzLb32d/r4wi8fE12lRoT4lACDQzTPf2J8SLfXX6717e6fHbwwezCWyXW0bd61gOABislP5f+sz+LcZFBSMWF7RvDHre8r9kF4CFHqhzG2mHGZGdaGg/uv2Zi/0vFmm8XDmhBf6jpVRl7xKVqVZVNQBB7rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6yE633t; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6yE633t"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a843bef98so415852866b.2;
        Sat, 05 Oct 2024 09:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728147478; x=1728752278; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZDWWsz2khXbQTvMlHQeJanQS8tzrDuFeehA3yCCxqP4=;
        b=L6yE633t3DAlvha+Ras0aY/f6HbuCtm5Kmt5WNbewvoSCTvKvt6MZzglhbarDUzd/+
         H6lFMpE5bSFBZJpYWuQ2rLW5bnT3CA3rl98Q6LZTxgSj8adv6uzn6nP5ptAMNgwRfdO2
         CHsM6UIPEaNtIZKKrx4ltw/qJIy25qOyuswNsOzvtPJR3irY8IJcrMDJ2Bt1zIc+hKiO
         lFx9tdQob99hHa6BJsHmNmMdcY4bErLovVzE22+hqDLCbze9aueo9SLUX4rqzZ2eB9sT
         GH6Kgx62x4rGTwDTvCI4sFnpUJTJzwITVuhLMaaHQEIuO00Qm+8xL4gEutvWaNwB3Sf+
         90kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728147478; x=1728752278;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDWWsz2khXbQTvMlHQeJanQS8tzrDuFeehA3yCCxqP4=;
        b=M0JkF0/xThAXzpQq0SK0ZhFwZzKi1O1zL/Ud6ubf8WfVezjM/xCHYhMCxM+CgKlGjw
         PcSXEduyQtoRYHaDtG3BiHKw+e+xQ1KqHwT716T+GnvLfTW8BpTG48K8jpewQDt7TL8Q
         ri35sAkTbpFKzZI8RHoU8UZpwvdK//OLm0o3QPR6ZPIpQmavoVrO5UGq3Tdzt0WLZm8R
         gIdczGvgqCaxRq8m8pA328ekLxrUtrQG7D+NO9/pyW+bwsekX7qTEgRV2oB/iyj2fEhO
         t9H9ER2mWhXFbroW/9qGutdbFI4xT5hs7VVwTTODJv++qu61iqKukb7HhgVPrQ4Y/vXr
         0slw==
X-Forwarded-Encrypted: i=1; AJvYcCUGIh0MqYEKViio45uHqSY+08X143d3aVhL0bmv4nWuUX8cTp0CBoiJwMVtM+pVfMV+K1peAQhyMhx86dxZIovLSliZpnm/@vger.kernel.org, AJvYcCVKbbL4KXG4GR2NKpnJH/5uOr6xGQ6iT7IziVAfDWEPC44L3j39NqliYFvef2nXUsEzacy3jqp7MgCo2Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAzq++pjYZ+vJTmdfKHsog43LSVStJUEaxTzKc0CaDd/0bmli5
	jWEOyYuv3lpH/TNh9cD1kgDoi7o3cgHZN9lhoRAtaUB87FDN4O/O
X-Google-Smtp-Source: AGHT+IGW/zx9bax+mOi4lhthATqYDogDuv9FTXKJKyL0jn92NMBEMULizYg9oTLYeVf2ITebAbF6yA==
X-Received: by 2002:a17:907:f788:b0:a93:d5d1:e4d4 with SMTP id a640c23a62f3a-a991bd42f21mr619711766b.27.1728147477371;
        Sat, 05 Oct 2024 09:57:57 -0700 (PDT)
Received: from localhost ([2a02:168:59f0:1:b0ab:dd5e:5c82:86b0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e5bbc74sm153185666b.31.2024.10.05.09.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 09:57:57 -0700 (PDT)
Date: Sat, 5 Oct 2024 18:57:55 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 1/3] landlock: Refactor filesystem access mask
 management
Message-ID: <20241005.a69458234f74@gnoack.org>
References: <20241001141234.397649-1-mic@digikod.net>
 <20241001141234.397649-2-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001141234.397649-2-mic@digikod.net>

On Tue, Oct 01, 2024 at 04:12:32PM +0200, Mickaël Salaün wrote:
> Replace get_raw_handled_fs_accesses() with a generic
> landlock_merge_access_masks(), and replace the get_fs_domain()
> implementation with a call to the new landlock_filter_access_masks()
> helper.  These helpers will also be useful for other types of access.
> 
> Replace struct access_masks with union access_masks that includes a new
> "all" field to simplify mask filtering.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241001141234.397649-2-mic@digikod.net
> ---
>  security/landlock/fs.c       | 21 ++++-----------
>  security/landlock/ruleset.h  | 51 +++++++++++++++++++++++++++---------
>  security/landlock/syscalls.c |  2 +-
>  3 files changed, 44 insertions(+), 30 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 7d79fc8abe21..a2ef7d151c81 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -388,33 +388,22 @@ static bool is_nouser_or_private(const struct dentry *dentry)
>  		unlikely(IS_PRIVATE(d_backing_inode(dentry))));
>  }
>  
> -static access_mask_t
> -get_raw_handled_fs_accesses(const struct landlock_ruleset *const domain)
> -{
> -	access_mask_t access_dom = 0;
> -	size_t layer_level;
> -
> -	for (layer_level = 0; layer_level < domain->num_layers; layer_level++)
> -		access_dom |=
> -			landlock_get_raw_fs_access_mask(domain, layer_level);
> -	return access_dom;
> -}
> -
>  static access_mask_t
>  get_handled_fs_accesses(const struct landlock_ruleset *const domain)
>  {
>  	/* Handles all initially denied by default access rights. */
> -	return get_raw_handled_fs_accesses(domain) |
> +	return landlock_merge_access_masks(domain).fs |
>  	       LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
>  }
>  
>  static const struct landlock_ruleset *
>  get_fs_domain(const struct landlock_ruleset *const domain)
>  {
> -	if (!domain || !get_raw_handled_fs_accesses(domain))
> -		return NULL;
> +	const union access_masks all_fs = {
> +		.fs = ~0,
> +	};
>  
> -	return domain;
> +	return landlock_filter_access_masks(domain, all_fs);
>  }
>  
>  static const struct landlock_ruleset *get_current_fs_domain(void)
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index 61bdbc550172..a816042ca8f3 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -41,12 +41,19 @@ static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_SCOPE);
>  static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
>  
>  /* Ruleset access masks. */
> -struct access_masks {
> -	access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
> -	access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
> -	access_mask_t scope : LANDLOCK_NUM_SCOPE;
> +union access_masks {
> +	struct {
> +		access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
> +		access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
> +		access_mask_t scope : LANDLOCK_NUM_SCOPE;
> +	};
> +	u32 all;
>  };

More of a style remark:

I wonder whether it is worth turning this into a union.

If this is for performance, I do not think is buys you much.  With
optimization enabled, it does not make much of a difference whether
you are doing the & on .all or whether you are doing it on the
individual fields.  (I tried it out with gcc.  The only difference is
that the & on the individual fields will at the end mask only the bits
that belong to these fields.)

At the same time, in most places where struct access_masks is used,
the union is not necessary and might add to the confusion.


>  
> +/* Makes sure all fields are covered. */
> +static_assert(sizeof(((union access_masks *)NULL)->all) ==
> +	      sizeof(union access_masks));
> +
>  typedef u16 layer_mask_t;
>  /* Makes sure all layers can be checked. */
>  static_assert(BITS_PER_TYPE(layer_mask_t) >= LANDLOCK_MAX_NUM_LAYERS);
> @@ -229,7 +236,7 @@ struct landlock_ruleset {
>  			 * layers are set once and never changed for the
>  			 * lifetime of the ruleset.
>  			 */
> -			struct access_masks access_masks[];
> +			union access_masks access_masks[];
>  		};
>  	};
>  };
> @@ -260,6 +267,31 @@ static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
>  		refcount_inc(&ruleset->usage);
>  }
>  
> +static inline union access_masks
> +landlock_merge_access_masks(const struct landlock_ruleset *const domain)
> +{
> +	size_t layer_level;
> +	union access_masks matches = {};
> +
> +	for (layer_level = 0; layer_level < domain->num_layers; layer_level++)
> +		matches.all |= domain->access_masks[layer_level].all;
> +
> +	return matches;
> +}
> +
> +static inline const struct landlock_ruleset *
> +landlock_filter_access_masks(const struct landlock_ruleset *const domain,
> +			     const union access_masks masks)

With this function name, the return type of this function is
unintuitive to me.  Judging by the name, I would have expected a
function that returns a "access_masks" value as well, similar to the
function one above (the remaining access rights after filtering)?

In the places where the result of this function is returned directly,
I find myself jumping back to the function implementation to
understand what this means.

As a constructive suggestion, how about calling this function
differently, e.g.

bool landlock_any_access_rights_handled(
    const struct landlock_ruleset *const domain,
    struct access_masks masks);

Then the callers who previously did

   return landlock_filter_access_masks(dom, masks);

would now do

   if (landlock_any_access_rights_handled(dom, masks))
       return dom;
   return NULL;

This is more verbose, but IMHO verbose code is not inherently bad,
if it is also clearer.  And it's only two lines more.

> +{
> +	if (!domain)
> +		return NULL;
> +
> +	if (landlock_merge_access_masks(domain).all & masks.all)
> +		return domain;
> +
> +	return NULL;
> +}

Function documentation for both functions would be good :)

> +
>  static inline void
>  landlock_add_fs_access_mask(struct landlock_ruleset *const ruleset,
>  			    const access_mask_t fs_access_mask,
> @@ -295,19 +327,12 @@ landlock_add_scope_mask(struct landlock_ruleset *const ruleset,
>  	ruleset->access_masks[layer_level].scope |= mask;
>  }
>  
> -static inline access_mask_t
> -landlock_get_raw_fs_access_mask(const struct landlock_ruleset *const ruleset,
> -				const u16 layer_level)
> -{
> -	return ruleset->access_masks[layer_level].fs;
> -}
> -
>  static inline access_mask_t
>  landlock_get_fs_access_mask(const struct landlock_ruleset *const ruleset,
>  			    const u16 layer_level)
>  {
>  	/* Handles all initially denied by default access rights. */
> -	return landlock_get_raw_fs_access_mask(ruleset, layer_level) |
> +	return ruleset->access_masks[layer_level].fs |
>  	       LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
>  }
>  
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index f5a0e7182ec0..c097d356fa45 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -329,7 +329,7 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
>  		return -ENOMSG;
>  
>  	/* Checks that allowed_access matches the @ruleset constraints. */
> -	mask = landlock_get_raw_fs_access_mask(ruleset, 0);
> +	mask = ruleset->access_masks[0].fs;
>  	if ((path_beneath_attr.allowed_access | mask) != mask)
>  		return -EINVAL;
>  
> -- 
> 2.46.1
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

–Günther
