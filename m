Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF95D3909B5
	for <linux-security-module@vger.kernel.org>; Sat, 26 Sep 2026 05:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790398893; cv=none; b=CYlnwuxKYSw+plfFWn1gqpoz0As/TzeTa3TOFfhRozQ7vfW328z6SOJVVw8kUTGHXRN7b+voJhjiGkCwm3TCwA53znXHuj/ZRf0oQ1miPjhJ98lkCINwcV4/8RE7ebtjj0DSAZ8J7oTXkVYwzE2Di6vq46W0ngIXd1s/PnxZ2AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790398893; c=relaxed/simple;
	bh=yhZkFIujFhIQBS18EW0K0unYFycVCZAyHeqlPJU9nwo=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d/3Jk1LNaMtFawviJvvNYVcHHOiRm1M4oauLFden7rz5gPL9SwJArI5m9uk109kJQTlr1NcvIwXSyu0zVOTFtjPXncawc8bG6VMXqHwjqJAzvEi9zoN4KKeg8qxTwRPTrnbBp80Zjt19PMbvrSinVgDqCHt29DrwFZt82ORf30g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QopAq8Tn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QopAq8Tn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A011F00898
	for <linux-security-module@vger.kernel.org>; Sat, 26 Sep 2026 05:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790398892;
	bh=tlgz/nr+1atpQxI3QYysDpz0uc8HzpT8sUb4IjwwMio=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=QopAq8Tnn0/qqyI3XuyCPPaHDN7WyWnMYQpj8+YgIr/UGuwCnK+jGG4BMEJfVRG1T
	 p8aLFx7FZPsHNveu5RzA7hKVdO7EGEh4QsbVuYIFou1Z2d5uH+gqy4ieINLZDUZc4w
	 2382PApNuumHsgjhXgJr6X9TyRBvOBpmJeuYf2mTf0lSaNXiAPE3beuRZ9pVzim5Lr
	 LQM5HIU0/iVDOzGoC+u/GHi/ihgrT2hU++eVwdHODsylCE9B8vN+TS0o3ZHvJmK3GA
	 Jzxv5SJUwWxcmDpwkjmrDhzsqbvofG7hAxzd/nEGZBrqQwompIoqtv/TuEfBaTkKx7
	 F8hhB9a5ECwSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH security v1] apparmor: fix a use-after-free in
 aa_lookupn_ns()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260926044724.4187-1-18983559317@163.com>
References: <20260926044724.4187-1-18983559317@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 05:01:31 +0000
Message-Id: <20260926050131.E6A011F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] apparmor: incorrect documentation for aa_get_ns_not0()
--

commit fda3772b41365651e2bf01f14c3712bb81c8786a
Author: Binbin Deng <18983559317@163.com>

apparmor: fix a use-after-free in aa_lookupn_ns()

This commit addresses a use-after-free bug in aa_lookupn_ns() caused by
concurrent removal of namespaces. It introduces aa_get_ns_not0() to safely
attempt incrementing the reference count only if the namespace is not alrea=
dy
being freed.

> diff --git a/security/apparmor/include/policy_ns.h b/security/apparmor/in=
clude/policy_ns.h
> index cc6e841518120..4f83598754764 100644
> --- a/security/apparmor/include/policy_ns.h
> +++ b/security/apparmor/include/policy_ns.h

[ ... ]

> @@ -117,6 +117,22 @@ static inline struct aa_ns *aa_get_ns(struct aa_ns *=
ns)
>  	return ns;
>  }
> =20
> +/**
> + * aa_get_ns_not0 - increment references count on @ns found via lookup
> + * @ns: namespace to increment reference count of (MAYBE NULL)
> + *
> + * Returns: pointer to @ns, if @ns is NULL returns NULL,
> + *          NULL if @ns is being freed
> + * Requires: @ns must be held with valid refcount when called

[Severity: Low]
Does this documentation contradict the purpose of the newly introduced func=
tion?

The function aa_get_ns_not0() is explicitly designed to safely handle
namespaces where the reference count might have already dropped to zero, wh=
ich
fixes the use-after-free bug. However, the documentation requires the caller
to already hold a valid refcount, which defeats the purpose of checking for
zero.

Should this state that an RCU read lock is required to protect the lookup
pointer instead?

> + */
> +static inline struct aa_ns *aa_get_ns_not0(struct aa_ns *ns)
> +{
> +	if (ns && aa_get_profile_not0(ns->unconfined))
> +		return ns;
> +
> +	return NULL;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926044724.4187=
-1-18983559317@163.com?part=3D1
