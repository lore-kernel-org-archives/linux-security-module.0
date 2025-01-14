Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A071022DC20
	for <linux-security-module@vger.kernel.org>; Tue, 14 Jan 2025 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736846741; cv=none; b=WCetGIgN/Cfcm8aLc2v3lrsMUg0Xy5GXLB9Uo5cKMDp/hYwmwmHsg0ASZQQqEx0AW9oNrzIT0io+ftSGgW0fOB9r6RTop3KPIB0UHZgIVoYNKfuHL8FaOHDicGga3pnFo/XNvWWSwzPehJBj8xYmoBBDqbwN4lSNXBDgdfYrDig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736846741; c=relaxed/simple;
	bh=K/V897iSpejcNiIMrRoETuDz7SLKwQfh0/JSUn9578I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M/y3zH9xgPNS4ccgEaIjTYa/Qszf5OUY++U1ITSCC0XJsefy5Gb1ilOYVyuztNhyiE+VGumTPcjIGiXly0vohL7g5s+XX68N9erWQl80B97G1jZRzw26cDDZiIQP1U1yrba1PnFgmZ4ojj++21GTdalql6O0FjccdUxjjxs0ELQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JWz/nUnE; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JWz/nUnE"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-aa68203d288so503182866b.1
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jan 2025 01:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736846738; x=1737451538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFZoN9ErMMhTuwLK4G5zwzSGNAcqEwgtL+qnKMtIgCg=;
        b=JWz/nUnESDd8kSiqnmC3nqcyPUDb0VgO+0bC3Y4lhpX8OL0eEzuPSt66pko+npEMU7
         FCjqeLiKbj32XhIVNVLpBuSf5rNF0uEjjcCPuJ7vBEeDBKAIDaervgl3sze1kVBoeWZ2
         Dw2UJZcc/8yv08GqdMC+QXvIKfAA87xHhbnrrbAOH/bfgWupr4a/6IkL99ohUKeQcyDK
         RUFCL/rnfCgXjpUgjYu9+KjEBRBV2ZrX8Ka9GDmj3m1OEftfWgyOMw7GfU++4Lg/b7DD
         KJuabZ5PxBY8vUBNIChl+VWskLV4LpDcZCj+0uuotV0prPqMYFYfkPNUDdIFkRL53vec
         PImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736846738; x=1737451538;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qFZoN9ErMMhTuwLK4G5zwzSGNAcqEwgtL+qnKMtIgCg=;
        b=teVPf017sy68jMWFsBeyKqxUeXmBeX5RtR7ICfJrtPBZg1gP1w+P54s2LjTZjcCyQU
         mMy0xP3xQKPgqoab6beMwUdFxYaIsuyM81MqjsJeVtWISyPVPfuVCVoVQM5P4RPNAl9+
         xwjW5MUyXfCi882rEgDiXq1z+pNtxQOIUi6eOEgazhGHstb7vPxl6gRgFdOtKnYha64p
         rNydFQ99CRx4Vl4KQlXo6kxs0Yn2BUc/oca6wFnxhc7Z8XaHsnNlynqHIUpsi+HuibWy
         SLPUdxAna7FVqMqpzfy9LVVqiv+n7pVEphoHZc92CiC5N4o+DtLrdAP7VMDRPZu/9vg3
         kEkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYGBpQfWk1RDMSOwwwRalYcfh9H4DkYFVJkW3BwcKUGb7Lx0p8VwFctSVw4TD2en+Y6rxfCBL15tnOmJQIfxgeNEEm7G8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ZwSh0VXm18z2JfvdyHahggIWjbg3GoCpETP6Y4RJTw1VUeKu
	3CDYi5ZcVYB/nOAExlj4dDgQ5o9fbsB7I/P/w2HLer9xYyGdlMMp6c3q7WtVzoDFv1FAbCQF1qh
	aJw==
X-Google-Smtp-Source: AGHT+IEtOghqwQjtkgcS6NMuR+HcDggY1VyvHNWutdK9iNUqnp4GdSZKjFLwZ7LwrLbHHHo64u9w5wz4Ch0=
X-Received: from ejbox12.prod.google.com ([2002:a17:907:100c:b0:aae:fdbf:5dc2])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:2cc2:b0:aaf:123a:e4f0
 with SMTP id a640c23a62f3a-ab2ab6c002fmr2005166666b.6.1736846738196; Tue, 14
 Jan 2025 01:25:38 -0800 (PST)
Date: Tue, 14 Jan 2025 10:25:35 +0100
In-Reply-To: <20250113161112.452505-5-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250113161112.452505-1-mic@digikod.net> <20250113161112.452505-5-mic@digikod.net>
Message-ID: <Z4Ytjx26uiwqnVRN@google.com>
Subject: Re: [PATCH v1 4/4] landlock: Use scoped guards for mutex
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Peter Zijlstra <peterz@infradead.org>, 
	Shervin Oloumi <enlightened@chromium.org>, Waiman Long <longman@redhat.com>, 
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 05:11:12PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> Simplify error handling by replacing goto statements with automatic
> calls to mutex_unlock() when going out of scope.
>=20
> Do not initialize the err variable for compiler/linter to warn us about
> inconsistent use, if any.
>=20
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20250113161112.452505-5-mic@digikod.net
> ---
>  security/landlock/ruleset.c | 52 +++++++++++++++----------------------
>  1 file changed, 21 insertions(+), 31 deletions(-)
>=20
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index f27b7bdb19b9..f1c3104aea6c 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -367,7 +367,7 @@ static int merge_tree(struct landlock_ruleset *const =
dst,
>  static int merge_ruleset(struct landlock_ruleset *const dst,
>  			 struct landlock_ruleset *const src)
>  {
> -	int err =3D 0;
> +	int err;
> =20
>  	might_sleep();
>  	/* Should already be checked by landlock_merge_ruleset() */
> @@ -378,32 +378,28 @@ static int merge_ruleset(struct landlock_ruleset *c=
onst dst,
>  		return -EINVAL;
> =20
>  	/* Locks @dst first because we are its only owner. */
> -	mutex_lock(&dst->lock);
> -	mutex_lock_nested(&src->lock, SINGLE_DEPTH_NESTING);
> +	guard(mutex)(&dst->lock);
> +	guard(mutex_nest_1)(&src->lock);
> =20
>  	/* Stacks the new layer. */
> -	if (WARN_ON_ONCE(src->num_layers !=3D 1 || dst->num_layers < 1)) {
> -		err =3D -EINVAL;
> -		goto out_unlock;
> -	}
> +	if (WARN_ON_ONCE(src->num_layers !=3D 1 || dst->num_layers < 1))
> +		return -EINVAL;
> +
>  	dst->access_masks[dst->num_layers - 1] =3D src->access_masks[0];
> =20
>  	/* Merges the @src inode tree. */
>  	err =3D merge_tree(dst, src, LANDLOCK_KEY_INODE);
>  	if (err)
> -		goto out_unlock;
> +		return err;
> =20
>  #if IS_ENABLED(CONFIG_INET)
>  	/* Merges the @src network port tree. */
>  	err =3D merge_tree(dst, src, LANDLOCK_KEY_NET_PORT);
>  	if (err)
> -		goto out_unlock;
> +		return err;
>  #endif /* IS_ENABLED(CONFIG_INET) */
> =20
> -out_unlock:
> -	mutex_unlock(&src->lock);
> -	mutex_unlock(&dst->lock);
> -	return err;
> +	return 0;
>  }
> =20
>  static int inherit_tree(struct landlock_ruleset *const parent,
> @@ -441,47 +437,41 @@ static int inherit_tree(struct landlock_ruleset *co=
nst parent,
>  static int inherit_ruleset(struct landlock_ruleset *const parent,
>  			   struct landlock_ruleset *const child)
>  {
> -	int err =3D 0;
> +	int err;
> =20
>  	might_sleep();
>  	if (!parent)
>  		return 0;
> =20
>  	/* Locks @child first because we are its only owner. */
> -	mutex_lock(&child->lock);
> -	mutex_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
> +	guard(mutex)(&child->lock);
> +	guard(mutex_nest_1)(&parent->lock);
> =20
>  	/* Copies the @parent inode tree. */
>  	err =3D inherit_tree(parent, child, LANDLOCK_KEY_INODE);
>  	if (err)
> -		goto out_unlock;
> +		return err;
> =20
>  #if IS_ENABLED(CONFIG_INET)
>  	/* Copies the @parent network port tree. */
>  	err =3D inherit_tree(parent, child, LANDLOCK_KEY_NET_PORT);
>  	if (err)
> -		goto out_unlock;
> +		return err;
>  #endif /* IS_ENABLED(CONFIG_INET) */
> =20
> -	if (WARN_ON_ONCE(child->num_layers <=3D parent->num_layers)) {
> -		err =3D -EINVAL;
> -		goto out_unlock;
> -	}
> +	if (WARN_ON_ONCE(child->num_layers <=3D parent->num_layers))
> +		return -EINVAL;
> +
>  	/* Copies the parent layer stack and leaves a space for the new layer. =
*/
>  	memcpy(child->access_masks, parent->access_masks,
>  	       flex_array_size(parent, access_masks, parent->num_layers));
> =20
> -	if (WARN_ON_ONCE(!parent->hierarchy)) {
> -		err =3D -EINVAL;
> -		goto out_unlock;
> -	}
> +	if (WARN_ON_ONCE(!parent->hierarchy))
> +		return -EINVAL;
> +
>  	get_hierarchy(parent->hierarchy);
>  	child->hierarchy->parent =3D parent->hierarchy;
> -
> -out_unlock:
> -	mutex_unlock(&parent->lock);
> -	mutex_unlock(&child->lock);
> -	return err;
> +	return 0;
>  }
> =20
>  static void free_ruleset(struct landlock_ruleset *const ruleset)
> --=20
> 2.47.1
>=20

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>

(Assuming that the mutex_nest_1 guard from the previous commit is OK as wel=
l)

=E2=80=94G=C3=BCnther
