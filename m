Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CE92264DB
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 20:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792011290; cv=none; b=ZGF0XXvYLvc+d2940upLVfbm3DfvnXATRy1aaRnc+Q+A6nVfu6SInXegVBYozo/1i8q6PUnMrX2nu5gGRLmHXhhmkEzgaRXbjzp1AgO+d8UvU06fPrQSL7lcYuzpYPy5BN+PYiS1a0UE2yc8Kex1JCMAZfuAYcjXbC3sIywG52o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792011290; c=relaxed/simple;
	bh=IRWazKYtjUs+a5TsxRVT/Y2RI7XETSD2ZlGJ3xliqII=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=f9giNtrukTubMQgq4k1uwGAH/jvsttruaMLATt/dtI9f7N2glb1aQttZVb+xpVPa4zzFfFSTH5FnucAE2xwIUE5PVIFYknHPrV6eLcrEIDvkpTho4PYyW8RaSa9VPM6iuKvbZ+fpmLTv37U8rMT+gRYVsDBYYHtQQ3o+Nd8XD+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O23ZOEaB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O23ZOEaB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FD51F000C4
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 20:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792011289;
	bh=3X3DtXob1Y4K9tuW8OVFgkaHg3LVLkCy0H9YMuDPaLk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=O23ZOEaBAIQNBbiqhweHPR4CvWYfQvtgmjRG/eksQ9a0qdb00YQ+81fFB3DTRXR7n
	 hScbArUhZfUcAqbEqiI8Nl7TZ/FHzQt1Ezj/a5mtGzzKg4EgvM1Nty1GUvjQkhKDfs
	 aG/kxL0DN7FtDs87S61A1NuXLWjgW3MCoxNNn+JL3mYMMqJreREhcqx+XV0anVbqti
	 PGP+lbjuecliax71DxDfJ2rosUDk2wdLuvqTYh3HtSabs6iE3AgtPsLnoEhs5sOrhP
	 USiKzZGMc79rgK/RnXW2ik4LvhvszYg/9O5WnL4iLIRhkF9ZEIYyxwPmRzrIQB+p1v
	 y8/hvVXOY5eGA==
Message-ID: <sashiko-outbox-171912@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] userns: record how far up CAP_SETFCAP reaches
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261014-b4-setfcap-userns-v2-1-fac4d19281d7@toxicpanda.com>
References: <20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com>
 <20261014-b4-setfcap-userns-v2-1-fac4d19281d7@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 20:54:48 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> create_user_ns() records in ns->parent_could_setfcap whether the creator
> had CAP_SETFCAP in its effective set, and verify_root_map() trusts that
> when a task in the new namespace maps the parent's uid 0.  A bool only
> describes the parent, though.  File capabilities belong to the kuid of a
> root user, and a namespace that maps the parent's uid 0 shares that kuid
> with the parent and possibly with ancestors further up, so what matters
> is how far up the creator's CAP_SETFCAP counted.
>=20
> Replace the bool with ns->setfcap_level: CAP_SETFCAP held in the
> namespace counts there and in its ancestors up to the one at that
> ->level.  cap_setfcap_level() computes it from the creator's cred.  A
> creator that holds CAP_SETFCAP passes on the setfcap_level of its own
> namespace, one that doesn't gets the new namespace's own level, and the
> initial namespace has 0.
>=20
> verify_root_map() keeps checking the same condition: the bool was false
> exactly when the level is the namespace's own.
>=20
> No functional change.
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-b4-setfcap=
-userns-v2-0-fac4d19281d7@toxicpanda.com?part=3D1

