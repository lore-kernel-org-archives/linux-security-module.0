Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E5653C3A4
	for <linux-security-module@vger.kernel.org>; Tue, 29 Sep 2026 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710367; cv=none; b=PrpqE2ySx8Ry/HegvnhjIcHoJyZjjDUTngUnqtSrTFwnbBUFeggUAukd3IsLaB0ibeT9LJVvajqvJlQjsM/MDtM6ErayBQzsMALL/q8uL7hu7vt6fknfewhUDXOruG5kMNhO2QqbVM0tx5jj6dNTmQ7fm34i9/xPdd4RL+BVBrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710367; c=relaxed/simple;
	bh=7UGQt7/pQ8db3wfZS0/blKCE84nA0DT4IrRM64EExIc=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=siZAiWzQ9QZX33tttfp9wRphLUPd+Pmlia2djH3FYdS+k00Gy/H3CJpFhGqKvYNQW/iKlumot5jTMNDIA9rescShbxgzlA8Tz4L+6aTA8HWSpBl8YA733iqIGCcs09S6ilXIl3kD+aZvhyGM3ZmMfjeOPwEoHWtCy3xCTd2MIG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrTM4nQc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrTM4nQc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734091F00898
	for <linux-security-module@vger.kernel.org>; Tue, 29 Sep 2026 19:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710365;
	bh=7UGQt7/pQ8db3wfZS0/blKCE84nA0DT4IrRM64EExIc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=CrTM4nQcnNj2aW0Dk43E+S2qR/n5t/kBmqt0ge5eXBqn2hS4+FeFLPZUjeH1McVwY
	 52wIufoje0ibms4RPs3uzOcZ1vwlbLjFjg4ICj4MK+VzSxZm5ZIOsOtK9UMz/QY1pw
	 FwYG47pJULXTCdZTA6sCHD6jnfIm0rlM4wVMiz1zETsDqaD0trQS6dxJKB+5jEhkG2
	 ftVfKyMCJML1Q12G9JyQ4MCn+uvwFpbcZkadKeDWvJe3a1kgwFv9EBx3rmkVWwzwDW
	 xrypAM7TAY5vi5iKo57pWv25kReDsHhrppmWWA7qF5AlqpB+rMBRGvlNysqPZxisHa
	 QGSE4xhWvP1pA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/16 net-next v2] netlabel: cipso: introduce
 CONFIG_CIPSO to decouple IPv4 dependency
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260928193046.6698-16-fmancera@suse.de>
References: <20260928193046.6698-1-fmancera@suse.de>
 <20260928193046.6698-16-fmancera@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 19:32:45 +0000
Message-Id: <20260929193245.734091F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Currently, the Commercial IP Security Option (CIPSO) is unconditionally
> tied to CONFIG_NETLABEL. Because CIPSO is inherently an IPv4 protocol
> feature, this creates a transitive dependency where subsystems relying
> on NetLabel (such as Smack) are forced to depend on CONFIG_IPV4, even if
> the user only wants to utilize IPv6/CALIPSO.
>=20
> This patch introduces a new CONFIG_CIPSO boolean that is automatically
> enabled only when both NETLABEL and IPV4 are selected. It abstracts the
> CIPSO-specific Makefile targets, sysctls, and kernel APIs behind this
> new config.
>=20
> By safely stubbing out the CIPSO netlabel_kapi functions to return
> -ENOSYS when disabled, this allows NetLabel and Smack to be successfully
> built and used on IPv6-only kernels.
>=20
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928193046.6698=
-1-fmancera@suse.de?part=3D15

