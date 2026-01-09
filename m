Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7802E21D3F0
	for <linux-security-module@vger.kernel.org>; Fri,  9 Jan 2026 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975534; cv=none; b=CS8PyHfVNPlfRx1CLn2oNaOYmPFhlRfA+wDpEShgrLTZUCOHVz7/iB82xE86+DTQbvp5Vz91T7IdxyBH1uxqvhsu+yfQ32+TWqVgGkyX2gTysEYtL0EfaEXHoeYc4TRhrRlYmI93dX3yYuFfzdOrHqGVe5LiUwIhS6AJmk4ew0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975534; c=relaxed/simple;
	bh=PkCmJ1+qnhRRRA+/dc6O5Z8iWpoKHKuDdtbgHgQkiTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2slpHssXQwvy/fKRYZ6KviDnLJlYM+u7Q8r0Z2d5LDwyPtJIq2jeeLWgQ10HERT7qug8zntj14BK8pAxnOZjZQXo864YHDftRoHw+mSJLXA2TBONEwcUrIBnhItuLWCoQOuUl6QJgaudukjoh415wQRO+6F85FlvdWk9zbl1oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=WZ0g/KU3; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="WZ0g/KU3"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dnn5K3VHQz6jH;
	Fri,  9 Jan 2026 17:18:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1767975525;
	bh=fZi73oODV2Y/c0QQiqQHzaA0KlIAv5evmbc0WnB9vbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZ0g/KU3JK6wn3Ike3AvKKyWO30B27UIfsvBVeoWsfJN7GIP9LDNqLWR6eC2elp2N
	 Shk/6tdzp9v32S0yFFpD4knnGe9yYGwVtWCqj6cqc61BLIvN2D3QephhZGd2ZgdQG/
	 ZhY82OHnREXZPLY400EsBBGkku5dyy+TfwuRsBMg=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dnn5J3VdkzwyK;
	Fri,  9 Jan 2026 17:18:44 +0100 (CET)
Date: Fri, 9 Jan 2026 17:18:43 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com
Subject: Re: [RFC PATCH 2/2] landlock: transpose the layer masks data
 structure
Message-ID: <20260109.hie6Teis2ha9@digikod.net>
References: <20251230103917.10549-3-gnoack3000@gmail.com>
 <20251230103917.10549-7-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251230103917.10549-7-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

This looks good overall but I need to spend more time reviewing it.

Because this changes may impact other ongoing patch series, I think I'll
take this patch first to ease potential future fix backports.

On Tue, Dec 30, 2025 at 11:39:21AM +0100, Günther Noack wrote:
> The layer masks data structure tracks the requested but unfulfilled
> access rights during an operations security check.  It stores one bit
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
>   branch speculation)
> 
> * Code is ~160 lines smaller.

What about the KUnit test lines?

> 
> Other noteworthy changes:
> 
> * Clarify deny_mask_t and the code assembling it.
>   * Document what that value looks like
>   * Make writing and reading functions specific to file system rules.
>     (It only worked for FS rules before as well, but going all the way
>     simplifies the code logic more.)
> * In no_more_access(), call a new helper function may_refer(), which
>   only solves the asymmetric case.  Previously, the code interleaved
>   the checks for the two symmetric cases in RENAME_EXCHANGE.  It feels
>   that the code is clearer when renames without RENAME_EXCHANGE are
>   more obviously the normal case.

It would be interesting to check the stackframe diff.  You can use
scripts/stackdelta for that, see
https://git.kernel.org/mic/c/602acfb541195eb35584d7a3fc7d1db676f059bd

> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  security/landlock/access.h  |  10 +-
>  security/landlock/audit.c   | 155 ++++++----------
>  security/landlock/audit.h   |   3 +-
>  security/landlock/domain.c  | 120 +++----------
>  security/landlock/domain.h  |   6 +-
>  security/landlock/fs.c      | 350 ++++++++++++++++--------------------
>  security/landlock/net.c     |  10 +-
>  security/landlock/ruleset.c |  78 +++-----
>  security/landlock/ruleset.h |  18 +-
>  9 files changed, 290 insertions(+), 460 deletions(-)

> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index dfcdc19ea2683..d20e28d38e9c9 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -622,49 +622,24 @@ landlock_find_rule(const struct landlock_ruleset *const ruleset,
>   * request are empty).
>   */
>  bool landlock_unmask_layers(const struct landlock_rule *const rule,
> -			    const access_mask_t access_request,
> -			    layer_mask_t (*const layer_masks)[],
> -			    const size_t masks_array_size)
> +			    struct layer_access_masks *masks)
>  {
> -	size_t layer_level;
> -
> -	if (!access_request || !layer_masks)
> +	if (!masks)
>  		return true;
>  	if (!rule)
>  		return false;
>  
> -	/*
> -	 * An access is granted if, for each policy layer, at least one rule
> -	 * encountered on the pathwalk grants the requested access,
> -	 * regardless of its position in the layer stack.  We must then check
> -	 * the remaining layers for each inode, from the first added layer to
> -	 * the last one.  When there is multiple requested accesses, for each
> -	 * policy layer, the full set of requested accesses may not be granted
> -	 * by only one rule, but by the union (binary OR) of multiple rules.
> -	 * E.g. /a/b <execute> + /a <read> => /a/b <execute + read>
> -	 */

Why removing this comment?

> -	for (layer_level = 0; layer_level < rule->num_layers; layer_level++) {
> -		const struct landlock_layer *const layer =
> -			&rule->layers[layer_level];
> -		const layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
> -		const unsigned long access_req = access_request;
> -		unsigned long access_bit;
> -		bool is_empty;
> +	for (int i = 0; i < rule->num_layers; i++) {
> +		const struct landlock_layer *l = &rule->layers[i];
>  
> -		/*
> -		 * Records in @layer_masks which layer grants access to each requested
> -		 * access: bit cleared if the related layer grants access.
> -		 */
> -		is_empty = true;
> -		for_each_set_bit(access_bit, &access_req, masks_array_size) {
> -			if (layer->access & BIT_ULL(access_bit))
> -				(*layer_masks)[access_bit] &= ~layer_bit;
> -			is_empty = is_empty && !(*layer_masks)[access_bit];
> -		}
> -		if (is_empty)
> -			return true;
> +		masks->access[l->level - 1] &= ~l->access;
>  	}
> -	return false;
> +
> +	for (int i = 0; i < LANDLOCK_MAX_NUM_LAYERS; i++) {
> +		if (masks->access[i])
> +			return false;
> +	}
> +	return true;
>  }
>  
>  typedef access_mask_t
