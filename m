Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC821339B1
	for <linux-security-module@vger.kernel.org>; Mon, 30 Mar 2026 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864612; cv=none; b=dtCwcq0mnPiplDLgCR2nbjSIcGO1Bkdfjm/pJKzvVh6U/tZ+T1iC+WaKC9qggsitXa1XElKeJsgC1uo6ove1UJ1XiTPT6FjLDZvU3MTF6mfXsfYdXVNkcCUfkKhr6qZF9iVF9ky5H1CMPQC6eI988PBeS4Vj8Ald59TLRFOzipo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864612; c=relaxed/simple;
	bh=0aRaLl0O/BbO6to9+ASX/SafUtuacTvxVbBOjgcVjMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aq2GtqcPWHm/fh661d/dAU77RJ04278H+5s9yO1NRYrCq7ytUAdyRS9GGAdVwi+CcNxf7ahKddS2X+B9hTjy2HnPpWLGiQUkFjbBoMomM+2s1GLJ8R9ytdK8YxJm7GbJK4iKsXvXxFc2+EJk5Ft3dYn9tuJlMVKtTUy0zs1Xl4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=BW7LdR7U; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="BW7LdR7U"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fkmqW6nfxzvJj;
	Mon, 30 Mar 2026 11:56:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1774864599;
	bh=+Euk6aUjyip/mMv4DEQmaqt+xSNocSevk6x0qI2ARUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BW7LdR7UvDAfFVvEkYkAZ8oI7A6CryiE0KRVEUHFb3cvQW5y8xBL61K9fLM05qTqj
	 XziD3vYqbe+0sZVF4k89yPafBwiK3yC6l6hgxYKn6yRttqs4U5nkT58rL/W24myGdC
	 Wrt+lz1yVHavq26H56/W/USP+jzbloYiToH2XFKU=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fkmqV4bfvzsLx;
	Mon, 30 Mar 2026 11:56:38 +0200 (CEST)
Date: Mon, 30 Mar 2026 11:56:33 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	kernel test robot <lkp@intel.com>, linux-security-module@vger.kernel.org, 
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Georgia Garcia <georgia.garcia@canonical.com>
Subject: Re: [PATCH v8 03/12] landlock: Replace union access_masks_all with
 helper functions
Message-ID: <20260330.ohsoe7vu2Nob@digikod.net>
References: <20260327164838.38231-1-gnoack3000@gmail.com>
 <20260327164838.38231-4-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260327164838.38231-4-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Mar 27, 2026 at 05:48:28PM +0100, Günther Noack wrote:
> * Stop using a union for access_masks_all.
> * Expose helper functions for intersection checks and union operations.
> 
> The memory layout of bitfields is only loosely defined by the C
> standard, so our static assertion that expects a fixed size was
> brittle, and it broke on some compilers when we attempted to add a
> 17th file system access right.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603261438.jBx2DGNe-lkp@intel.com/
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  security/landlock/access.h  | 21 ++++++++++++++-------
>  security/landlock/cred.h    | 10 ++--------
>  security/landlock/ruleset.h | 13 ++++---------
>  3 files changed, 20 insertions(+), 24 deletions(-)

I'd prefer this approach:

diff --git a/security/landlock/access.h b/security/landlock/access.h
index 89dc8e7b93da..bc9efbb5c900 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -50,7 +50,7 @@ struct access_masks {
        access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
        access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
        access_mask_t scope : LANDLOCK_NUM_SCOPE;
-};
+} __packed;

 union access_masks_all {
        struct access_masks masks;
@@ -58,7 +58,7 @@ union access_masks_all {
 };

 /* Makes sure all fields are covered. */
-static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
+static_assert(sizeof(typeof_member(union access_masks_all, masks)) <=
              sizeof(typeof_member(union access_masks_all, all)));

 /**


This keep the check and make sure new field will not introduce issues, but more
importantly it save memory, which was one of the goal of struct access_masks.

If that's good with you I'll replace your patch and squash this packed
annotation with the following patch.


> 
> diff --git a/security/landlock/access.h b/security/landlock/access.h
> index 42c95747d7bd..277b6ed7f7bb 100644
> --- a/security/landlock/access.h
> +++ b/security/landlock/access.h
> @@ -52,14 +52,21 @@ struct access_masks {
>  	access_mask_t scope : LANDLOCK_NUM_SCOPE;
>  };
>  
> -union access_masks_all {
> -	struct access_masks masks;
> -	u32 all;
> -};
> +/* Checks whether two access masks have any common bit set. */
> +static inline bool access_masks_intersect(const struct access_masks a,
> +					  const struct access_masks b)
> +{
> +	return (a.fs & b.fs) || (a.net & b.net) || (a.scope & b.scope);
> +}
>  
> -/* Makes sure all fields are covered. */
> -static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
> -	      sizeof(typeof_member(union access_masks_all, all)));
> +/* ORs the bits of @src into @dst. */
> +static inline void access_masks_merge(struct access_masks *dst,
> +				      const struct access_masks src)
> +{
> +	dst->fs |= src.fs;
> +	dst->net |= src.net;
> +	dst->scope |= src.scope;
> +}
>  
>  /**
>   * struct layer_access_masks - A boolean matrix of layers and access rights
> diff --git a/security/landlock/cred.h b/security/landlock/cred.h
> index f287c56b5fd4..207a6db1c086 100644
> --- a/security/landlock/cred.h
> +++ b/security/landlock/cred.h
> @@ -123,9 +123,6 @@ landlock_get_applicable_subject(const struct cred *const cred,
>  				const struct access_masks masks,
>  				size_t *const handle_layer)
>  {
> -	const union access_masks_all masks_all = {
> -		.masks = masks,
> -	};
>  	const struct landlock_ruleset *domain;
>  	ssize_t layer_level;
>  
> @@ -138,11 +135,8 @@ landlock_get_applicable_subject(const struct cred *const cred,
>  
>  	for (layer_level = domain->num_layers - 1; layer_level >= 0;
>  	     layer_level--) {
> -		union access_masks_all layer = {
> -			.masks = domain->access_masks[layer_level],
> -		};
> -
> -		if (layer.all & masks_all.all) {
> +		if (access_masks_intersect(domain->access_masks[layer_level],
> +					   masks)) {
>  			if (handle_layer)
>  				*handle_layer = layer_level;
>  
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index 889f4b30301a..9f8b33815c2c 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -229,18 +229,13 @@ static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
>  static inline struct access_masks
>  landlock_union_access_masks(const struct landlock_ruleset *const domain)
>  {
> -	union access_masks_all matches = {};
> +	struct access_masks matches = {};
>  	size_t layer_level;
>  
> -	for (layer_level = 0; layer_level < domain->num_layers; layer_level++) {
> -		union access_masks_all layer = {
> -			.masks = domain->access_masks[layer_level],
> -		};
> +	for (layer_level = 0; layer_level < domain->num_layers; layer_level++)
> +		access_masks_merge(&matches, domain->access_masks[layer_level]);
>  
> -		matches.all |= layer.all;
> -	}
> -
> -	return matches.masks;
> +	return matches;
>  }
>  
>  static inline void
> -- 
> 2.53.0
> 
> 
