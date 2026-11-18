Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795043725;
	b=LRTbgV8cZMz+Y7FxyLq9jGVXnKqFlk3w19Ha9Sax590QX3EWjabpCl5C0CZHPne6Bpma
	 Pcm93wabd5DwiiPXDWw0vpuVqmM1/w/F0VDvMUsPcnvz2MWYEoOKm0aljNqpMMFxJ/9lB
	 nQ1IVBaTO/CwgLYR3phX5Ew3Sr+NHu4dcF+lu+1rmC26dVp/kGMPtoDWmv0x9TuF9C/7h
	 629cadh1zhTKyy4g2e8p4uICLHjrEqJUPjPPvRZgJbLF098BO+Y6LxNr4NF1hjKWy8PYD
	 wGod0BiPb22/4jby6kxfSGIo3RNcZyV0bIYgRKawCzujA4CaRwbRuLP4K1rOzPMbCBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795043725;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zQSxgWIe9gOOEtlA5ZWTDwslp4xBZUPvpUnyk2acfn0=;
	b=F7ZU7i9HLq83AwW41Vd6D9aZnGV4re6Zkd94H6B5yrbP9Ze/4U9vUFDN4bGYv//h+7bW
	 /pf5UMYaAmMJ/SB/tKGDuqUUByxeKZjP25SePh7igVbNMcqemHyKrO5s+fr58GkjVrus6
	 4BGkO+8fxsV/il11fdyFjhHUJUm6Gl/XRu9bvn8Ag2gwWDyeodI0YBblPdY8Q2AoNLfXv
	 OBZryAc51m46yeSpSNhCaqchD8Y08TboSRBNzoY5zhFVDWsJe690QxYbLWbNw2xnZpFQA
	 5DhsxSjR7NvAAR9l9+MrhvmtMkLEaSQ56Uht3nXgAYSRYAO1xS8LMWO57RuSA0I1hDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iNrUmPVd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780FD606A335
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 23:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iNrUmPVd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364C21F000C4
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 23:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795043725;
	bh=zQSxgWIe9gOOEtlA5ZWTDwslp4xBZUPvpUnyk2acfn0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=iNrUmPVd7S1ALGs/BhrvpkNPq45tTt5ddk3kW4ceYdBSveKzhUe4Ehj8gR2uZ1KNh
	 Ks2dlTsZ9AxVSh/aDjwUVrM5WZaEP/j/fUVEluCgooFn2Qt3ZciiZE7GhgLtlvsoyp
	 nfkBm4ZRj3l84N2TOL3JLeZmkeZ9BCBHUz1zaGVFscrDyfbO2rQoez3UU/G+/e29e6
	 B6n9UTI9mnYAKbwa9BBhsdi2vTCMR16Koe3WM3Q9F+C6jkLP2dS7igvxRM4Z2+ZQdX
	 tLDkxoaho7/GTOeIFVoAGHSFbX8HxAEjn9fvPOPKlfvbEG2wA87BAuk2g6PGNXjrkN
	 dvZGbWic98xOw==
Message-ID: <sashiko-outbox-222165@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 11/13] docs: Document root namespace uAPI
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261117231352.3816603-12-jarkko@kernel.org>
References: <20261117231352.3816603-1-jarkko@kernel.org>
 <20261117231352.3816603-12-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 23:15:24 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Userspace container managers need a clear specification of rootns state
> transitions, mount-tree construction, credential rules, and process
> creation semantics.
>=20
> Add Documentation/userspace-api/rootns.rst to include the kernel-doc
> sections and system call reference from kernel/rootns.c,
> include/uapi/linux/rootns.h, fs/fsopen.c, and fs/namespace.c.
>=20
> Co-developed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117231352.3816=
603-1-jarkko@kernel.org?part=3D11

