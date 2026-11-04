Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759145;
	b=2+tEp5y4bDGi3C+vIS3GIEcRtZ16eR15q76AXFAqwOVdNJ/Se9S9GbE5pl6DfYj5f9XO
	 wS4fpMajTyAMwhcW2UHmLtK2wRDzpJdF5IBI5fBu9xblLt2t37nKTviSXq/DOLFVg57n7
	 v3rU8G3C7osH0esh0ONp3kSPb3vsz+L3TdqVhq+TNrb+RqXBjG09GasQpjD5PxtG1CG+O
	 n2qKBeKfW3rXRk4nmPOPUD9MMSHUdxbjKndDp4RZLlk5iAwT0eFnqswAVvjfy75Sdr6Y/
	 IKBbMzvinwadSq/EpGwPAT88zuyyinnIDfdZYaDupvWKf5D7Hadr7miKge9Ev+Fr7Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759145;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PBYFO4AYpTrwSHZzLQU4sSsZDKei7z/HmWGlC5rAOIk=;
	b=noZXk28tu52yPz4ajCPVAB1QawxqsNH+Pth715j5VzVqgrXeqMHyLXOdYNiuQ3yHCJLj
	 2d4OUluEuzDWjKaWmGLQsudw1vuSPETv6qHRpB6fBqbmsDu3jgewju35LWbvjr0M3cjUG
	 vBzlIxUDuFBeCuYnYgjuxua4DsJ9eMjFVyPgzjazwwhRsAcEgbsY0rUalhcrw8KcBlfA5
	 ehARXdMGKdmwhUY1N+spOWEKdP5TbUY6lyafF3AT7oV0F1FUySAoAvJLMEuN5gRIeizhU
	 f/h5At1nApP2KVlGtcvVrjRnrUcPYSH32I4hwgrI4dog/gXbv+USIFh90NTCptNfelw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBiEdCX9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2F2606A31B
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 02:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBiEdCX9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354811F000C1
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 02:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793759145;
	bh=PBYFO4AYpTrwSHZzLQU4sSsZDKei7z/HmWGlC5rAOIk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=aBiEdCX9v8zn8idhtf6WKM/iXVsddV5ozY8M34ddcp9CO/GoiPh8mzO/GCdXo8KUe
	 YqE7+N0+FxoxD4aag66AYuzhtA3odBHQReRiQOIqUh3UEdnBM3w98oZkRctnbEUIK3
	 6JxnjqrloQi8a5t9Neb13B7AC5lblYjEsEmkmyTP7nJu+2cboCeAnha35BDatufuh/
	 sRKZtZCQ/9hdSnjJQlS6lO+oSOWTgxlx+daPnFyj+ZYr5Ay9mW7Iz3b5RYLTmANFcK
	 oY4d2QnxiSaCYWk8ruoojn9pchvwFI1ooeeekh5fag5YliwstyeGfOZPErJcjqTrE6
	 wdxhLjQAENjGw==
Message-ID: <sashiko-outbox-196456@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KEYS: Protect pkey method checks against type
 removal
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104021414.50696-1-0xbeac@gmail.com>
References: <aun7J2NGn57RGS5J@kernel.org>
 <20261104021414.50696-1-0xbeac@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:25:44 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> keyctl_pkey_params_get() looks up the key, and keyctl_pkey_query(),
> keyctl_pkey_e_d_s() and keyctl_pkey_verify() then dereference
> key->type->asym_* outside key->sem.  A reference keeps the key alive, but
> does not pin the module providing its type.
>=20
> unregister_key_type() calls key_gc_keytype(), which retypes every
> remaining key of the type to key_type_dead under key->sem for writing.
> The pkey paths read key->type again after their checks, so a concurrent
> module unload can turn the checked callback into the NULL key_type_dead
> member and call through a NULL function pointer, e.g.:
>=20
>   KEYCTL_PKEY_SIGN task              Module unload and key GC
>   ------------------------           ------------------------
>   keyctl_pkey_e_d_s()
>     if (!key->type->asym_eds_op)     unregister_key_type()
> [ ... ]
> (925c84e3cc21) and update (aef3a8a4f988) methods.
>=20
> Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops=
 for asymmetric keys [ver #2]")
> Cc: stable@vger.kernel.org
> Signed-off-by: BeaCox <0xbeac@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104021414.5069=
6-1-0xbeac@gmail.com?part=3D1

