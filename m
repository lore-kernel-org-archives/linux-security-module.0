Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA49D29B8DB
	for <linux-security-module@vger.kernel.org>; Sat,  7 Feb 2026 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770459470; cv=none; b=MUvUdw/9N5xDQS5dC2R94b1zOl1ryk86UiK66hL/uWSzMReWsbL1AfDv07zhat7k9Yixy20ToIWjrH1hcBjekArg1nOj9o+dZGC8f/2o7myU5jjjOqx2DuHOh+ZafxBbluH1vT/0ArmCX8Q+TLeSQQEa/cWnR1z0JN1zEyi54tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770459470; c=relaxed/simple;
	bh=mdLl1QAXilenY7HrELp/mxeeSEAagIBnvVb0bYXdJRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khTXMgim3AYfhsLb2F14ox3hJg6m4GDsmI/eNRP+2piWLGTiL3R4LCl/UMs/uRdPtAqLT4KY14sor/jvHfdLgxhUe/8yVriFmm2dX7hO6CKU3Nr+DVDiC7pnjX+uCwxbwIz1Cp7+OOrLferLtyA62CAigLW3CCrWmkDZ0DD14Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=famEz9J6; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="famEz9J6"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f7RjJ43y1z5D1;
	Sat,  7 Feb 2026 11:17:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1770459460;
	bh=RgORwdt/dQ1+eRjwA7IiLaKL19T+WUec98i5vYhqbrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=famEz9J6X15mqYQmKY/cTi2XyvpduFHGzQW2VFE0NWWTf38poStt2oU9J1BPV8Prb
	 pHdVwAaj5iWh5Mhf/ROdQQwFZ53lEVU7KcFe5njF10lpNiqB3KTjrwHw2vNjqgWErj
	 Ts/H2afGFkGwN4mycALCIOxNH/CjB5BfYCZ7N20M=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4f7RjH4k88zksx;
	Sat,  7 Feb 2026 11:17:39 +0100 (CET)
Date: Sat, 7 Feb 2026 11:17:34 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 3/3] landlock: transpose the layer masks data structure
Message-ID: <20260207.zolaiy1ail8H@digikod.net>
References: <20260206151154.97915-2-gnoack3000@gmail.com>
 <20260206151154.97915-5-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206151154.97915-5-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Feb 06, 2026 at 04:11:55PM +0100, Günther Noack wrote:
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
> This fixes the size of the data structure at 32 bytes for all types of
> access rights. (64, once we introduce a 17th filesystem access right).
> 
> For filesystem access rights, at the moment, the data structure has
> the same size as before, but once we introduce the 17th filesystem
> access right, it will double in size (from 32 to 64 bytes), as
> access_mask_t grows from 16 to 32 bit. [1]
> 
> Link: https://lore.kernel.org/all/20260120.haeCh4li9Vae@digikod.net/ [1]
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  security/landlock/access.h  |  15 +-
>  security/landlock/audit.c   |  81 +++------
>  security/landlock/audit.h   |   3 +-
>  security/landlock/domain.c  |  45 ++---
>  security/landlock/domain.h  |   4 +-
>  security/landlock/fs.c      | 348 ++++++++++++++++--------------------
>  security/landlock/net.c     |   9 +-
>  security/landlock/ruleset.c |  89 ++++-----
>  security/landlock/ruleset.h |  21 ++-
>  9 files changed, 274 insertions(+), 341 deletions(-)
> 
> diff --git a/security/landlock/access.h b/security/landlock/access.h
> index bab403470a6c..f0a9afeb4a2a 100644
> --- a/security/landlock/access.h
> +++ b/security/landlock/access.h
> @@ -61,14 +61,15 @@ union access_masks_all {
>  static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
>  	      sizeof(typeof_member(union access_masks_all, all)));
>  
> -typedef u16 layer_mask_t;
> -
> -/* Makes sure all layers can be checked. */
> -static_assert(BITS_PER_TYPE(layer_mask_t) >= LANDLOCK_MAX_NUM_LAYERS);
> -
>  /*
> - * Tracks domains responsible of a denied access.  This is required to avoid
> - * storing in each object the full layer_masks[] required by update_request().
> + * Tracks domains responsible of a denied access.  This avoids storing in each
> + * object the full matrix of per-layer unfulfilled access rights, which is
> + * required by update_request().
> + *
> + * Each nibble represents the layer index of the newest layer which denied a
> + * certain access right.  For file system access rights, the upper four bits are
> + * the index of the layer which denies LANDLOCK_ACCESS_FS_IOCTL_DEV and the
> + * lower nibble represents LANDLOCK_ACCESS_FS_TRUNCATE.
>   */
>  typedef u8 deny_masks_t;
>  

> diff --git a/security/landlock/domain.c b/security/landlock/domain.c
> index a647b68e8d06..d2a4354feeb4 100644
> --- a/security/landlock/domain.c
> +++ b/security/landlock/domain.c
> @@ -7,6 +7,7 @@
>   * Copyright © 2024-2025 Microsoft Corporation
>   */
>  
> +#include "ruleset.h"

To avoid this new include (which makes a dependency on ruleset
definitions for domain-specific definitions), I moved the struct
layer_access_masks definition to access.h, which makes more sense
anyway.


>  #include <kunit/test.h>
>  #include <linux/bitops.h>
>  #include <linux/bits.h>

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

> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index 1a78cba662b2..1ceb5fd674c9 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -301,15 +301,28 @@ landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
>  	return ruleset->access_masks[layer_level].scope;
>  }
>  
> +/**
> + * struct layer_access_masks - A boolean matrix of layers and access rights
> + *
> + * This has a bit for each combination of layer numbers and access rights.
> + * During access checks, it is used to represent the access rights for each
> + * layer which still need to be fulfilled.  When all bits are 0, the access
> + * request is considered to be fulfilled.
> + */
> +struct layer_access_masks {
> +	/**
> +	 * @access: The unfulfilled access rights for each layer.
> +	 */
> +	access_mask_t access[LANDLOCK_MAX_NUM_LAYERS];
> +};
> +
>  bool landlock_unmask_layers(const struct landlock_rule *const rule,
> -			    const access_mask_t access_request,
> -			    layer_mask_t (*const layer_masks)[],
> -			    const size_t masks_array_size);
> +			    struct layer_access_masks *masks);
>  
>  access_mask_t
>  landlock_init_layer_masks(const struct landlock_ruleset *const domain,
>  			  const access_mask_t access_request,
> -			  layer_mask_t (*const layer_masks)[],
> +			  struct layer_access_masks *masks,
>  			  const enum landlock_key_type key_type);
>  
>  #endif /* _SECURITY_LANDLOCK_RULESET_H */
> -- 
> 2.52.0
> 
> 
