Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ECB1E00B6
	for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2025 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736805928; cv=none; b=tDqdF5LR+S+VBIn/IY/FXmaVRhbayZKtx1lcMHJOdJUlbkkTW1gWcs6pKnYY+FEL19MaXBpH1IY9zXzMFTU+ay83VayFY/ZO5M42YDu4xNVdvsL+jwffubB6TLTnWsP09LUul1NrDi6kU+x5kkN/Jx228cdDzvSRcwOoFizcjTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736805928; c=relaxed/simple;
	bh=NPWdJpaawLC+iUz3nJa0v8HUqatUfadkf5pBN4EOiGA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lhBhvCcg9dPF2ds/OLtpX6+VkDGMvxn2G4U+NbbKYlgJUWlf2Os7173coQ79h3h3+nog5b+AoyEppYSOzERpfazQzBV3T0vzDrvSjvrMI8hK/irGYE+EYvvi64x5OG0sQgV5mFElRHdWJDvZWgdvKhxpATLoBOFcc0Qg/lK0kuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jAzgjrao; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jAzgjrao"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d3e77fd3b3so6340951a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2025 14:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736805925; x=1737410725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A8jgvgN+7fcsX4Yh8+CmrC88M/buu8zVa9X73JSqsQw=;
        b=jAzgjrao8jzq6UwISaZWuMeYo7qGc0kTS6cQkwSUnyK3jcLABfZDg63u/ln8WHBdDA
         Gxc7I5DHqv5/3Q+YAKOfPfPnxH6GZ/kCi5L1g2CBM27UglM/EN3mtXz9/yerdjSjTevx
         AxYCgDHlGc5tca4UzaotttVW8UDrSBiSJH9OiUbz42o92Bdbshzpdz/3Cbr4KFXA85Vt
         h2tTulF45C6dpLaJcws0zMoH/Wp3XVsM8+PekQH0Lr/WHUYXGjG0+9uBtOY9Rv4SBf17
         hM9pKwyi5Ih2h2rpe9sv4x707raQqSta2Y5gDR1Y6muFA5gMD6Lg2Ug8lHnTA+/E6g1W
         CIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736805925; x=1737410725;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A8jgvgN+7fcsX4Yh8+CmrC88M/buu8zVa9X73JSqsQw=;
        b=Gk10iRggmA2VQQwijxip2s9xX9ouX6Ax2nTnP4frNJ8WpnqSfhDPr3Pdvb/W/hYkC7
         oB0TTdjVVnP1sZGcMAGES9YCLg0L9ui0gbYg/O3Aoz5Ac7PobA7uIGnlcPkHrdWB7W79
         jPW1nHDnmpWv4OYOshKXP3idpCZPe91TOM4ptbFVlnP8HnVihg1uLkIHJPdiPhikE3DW
         XRgF4jN7l1YQGJgpe75dEBrTVkQwangtQI4ppsYlwo0XFUwBiq13E/xgVyt1I0fVCasf
         Ryt6M1CmfvT008DEoYGwuOupH+vMpwLI9XChhbRiiK9GUrPejVJ3uiRXcRpxaeUy9Iro
         tQXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmdyL+iqT4T+/dFmTDyXVKIoS9SrCjX2i7Ls3EUZuHQoTf54jxxcCQcIZLkWLGr6ibZU/Vc6F5jSJJKhySdxdAoGIzA3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMUwmowx6Npyk+znEKG9Z6vnnJjUdAw9+/yROaC+q7eZcLopVX
	YVpICKTEmljr0dng0906LZJhg1cUkjqi/v27SSMX4RuAnbTu06MYdrwEmivCkarIVlHkxJ50A2B
	baQ==
X-Google-Smtp-Source: AGHT+IHYOxKI4j9GmHfs91D9iYKPns7VlYQCSnlIOdVOXDt7W0RrqiuFVl1UTo5If95o0BzKKc9dgPQF0iM=
X-Received: from edtj1.prod.google.com ([2002:aa7:ca41:0:b0:5d0:2139:dedd])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:3483:b0:5d3:e79b:3b4c
 with SMTP id 4fb4d7f45d1cf-5d972e6a395mr20222085a12.31.1736805924837; Mon, 13
 Jan 2025 14:05:24 -0800 (PST)
Date: Mon, 13 Jan 2025 23:05:21 +0100
In-Reply-To: <20250113161112.452505-2-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250113161112.452505-1-mic@digikod.net> <20250113161112.452505-2-mic@digikod.net>
Message-ID: <Z4WOISi2ZP5kbqcN@google.com>
Subject: Re: [PATCH v1 1/4] landlock: Use scoped guards for ruleset
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

On Mon, Jan 13, 2025 at 05:11:09PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> Simplify error handling by replacing goto statements with automatic
> calls to landlock_put_ruleset() when going out of scope.
>=20
> This change will be easy to backport to v6.6 if needed, only the
> kernel.h include line conflicts.  As for any other similar changes, we
> should be careful when backporting without goto statements.
>=20
> Add missing include file.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20250113161112.452505-2-mic@digikod.net
> ---
>  security/landlock/ruleset.c  | 22 ++++++++++------------
>  security/landlock/ruleset.h  |  5 +++++
>  security/landlock/syscalls.c | 25 ++++++++-----------------
>  3 files changed, 23 insertions(+), 29 deletions(-)
>=20
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index a93bdbf52fff..f27b7bdb19b9 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -8,11 +8,13 @@
> =20
>  #include <linux/bits.h>
>  #include <linux/bug.h>
> +#include <linux/cleanup.h>
>  #include <linux/compiler_types.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
>  #include <linux/lockdep.h>
> +#include <linux/mutex.h>
>  #include <linux/overflow.h>
>  #include <linux/rbtree.h>
>  #include <linux/refcount.h>
> @@ -537,7 +539,7 @@ struct landlock_ruleset *
>  landlock_merge_ruleset(struct landlock_ruleset *const parent,
>  		       struct landlock_ruleset *const ruleset)
>  {
> -	struct landlock_ruleset *new_dom;
> +	struct landlock_ruleset *new_dom __free(landlock_put_ruleset) =3D NULL;
>  	u32 num_layers;
>  	int err;
> =20
> @@ -557,29 +559,25 @@ landlock_merge_ruleset(struct landlock_ruleset *con=
st parent,
>  	new_dom =3D create_ruleset(num_layers);
>  	if (IS_ERR(new_dom))
>  		return new_dom;
> +
>  	new_dom->hierarchy =3D
>  		kzalloc(sizeof(*new_dom->hierarchy), GFP_KERNEL_ACCOUNT);
> -	if (!new_dom->hierarchy) {
> -		err =3D -ENOMEM;
> -		goto out_put_dom;
> -	}
> +	if (!new_dom->hierarchy)
> +		return ERR_PTR(-ENOMEM);
> +
>  	refcount_set(&new_dom->hierarchy->usage, 1);
> =20
>  	/* ...as a child of @parent... */
>  	err =3D inherit_ruleset(parent, new_dom);
>  	if (err)
> -		goto out_put_dom;
> +		return ERR_PTR(err);
> =20
>  	/* ...and including @ruleset. */
>  	err =3D merge_ruleset(new_dom, ruleset);
>  	if (err)
> -		goto out_put_dom;
> -
> -	return new_dom;
> +		return ERR_PTR(err);
> =20
> -out_put_dom:
> -	landlock_put_ruleset(new_dom);
> -	return ERR_PTR(err);
> +	return no_free_ptr(new_dom);
>  }
> =20
>  /*
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index 631e24d4ffe9..70e5b53d1c71 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -11,6 +11,8 @@
> =20
>  #include <linux/bitops.h>
>  #include <linux/build_bug.h>
> +#include <linux/cleanup.h>
> +#include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/mutex.h>
>  #include <linux/rbtree.h>
> @@ -252,6 +254,9 @@ landlock_create_ruleset(const access_mask_t access_ma=
sk_fs,
>  void landlock_put_ruleset(struct landlock_ruleset *const ruleset);
>  void landlock_put_ruleset_deferred(struct landlock_ruleset *const rulese=
t);
> =20
> +DEFINE_FREE(landlock_put_ruleset, struct landlock_ruleset *,
> +	    if (!IS_ERR_OR_NULL(_T)) landlock_put_ruleset(_T))
> +
>  int landlock_insert_rule(struct landlock_ruleset *const ruleset,
>  			 const struct landlock_id id,
>  			 const access_mask_t access);
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 4ed8e70c25ed..5a7f1f77292e 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -10,6 +10,7 @@
>  #include <linux/anon_inodes.h>
>  #include <linux/build_bug.h>
>  #include <linux/capability.h>
> +#include <linux/cleanup.h>
>  #include <linux/compiler_types.h>
>  #include <linux/dcache.h>
>  #include <linux/err.h>
> @@ -456,10 +457,10 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, rules=
et_fd,
>  SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u=
32,
>  		flags)
>  {
> -	struct landlock_ruleset *new_dom, *ruleset;
> +	struct landlock_ruleset *new_dom,
> +		*ruleset __free(landlock_put_ruleset) =3D NULL;
>  	struct cred *new_cred;
>  	struct landlock_cred_security *new_llcred;
> -	int err;
> =20
>  	if (!is_initialized())
>  		return -EOPNOTSUPP;
> @@ -483,10 +484,9 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, r=
uleset_fd, const __u32,
> =20
>  	/* Prepares new credentials. */
>  	new_cred =3D prepare_creds();
> -	if (!new_cred) {
> -		err =3D -ENOMEM;
> -		goto out_put_ruleset;
> -	}
> +	if (!new_cred)
> +		return -ENOMEM;
> +
>  	new_llcred =3D landlock_cred(new_cred);
> =20
>  	/*
> @@ -495,21 +495,12 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, =
ruleset_fd, const __u32,
>  	 */
>  	new_dom =3D landlock_merge_ruleset(new_llcred->domain, ruleset);
>  	if (IS_ERR(new_dom)) {
> -		err =3D PTR_ERR(new_dom);
> -		goto out_put_creds;
> +		abort_creds(new_cred);
> +		return PTR_ERR(new_dom);
>  	}
> =20
>  	/* Replaces the old (prepared) domain. */
>  	landlock_put_ruleset(new_llcred->domain);
>  	new_llcred->domain =3D new_dom;
> -
> -	landlock_put_ruleset(ruleset);
>  	return commit_creds(new_cred);
> -
> -out_put_creds:
> -	abort_creds(new_cred);
> -
> -out_put_ruleset:
> -	landlock_put_ruleset(ruleset);
> -	return err;
>  }
> --=20
> 2.47.1
>=20

Very nice :)

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>
