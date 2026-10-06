Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0996F3CD8CC
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326778; cv=none; b=cc6IZ/mFpeA5yd+Y0Akf1Q9tno6hXCO8T9CPavsAdAwmKAJ+oi2i79fM1dSdS0UUF/RXJuI+j3BaqIjQgS6MInNpuSQdLQ4muX1dBHh9588+84+m1H6iyaFmmAq383elq3dBV4aLc3oYN8uzUKjeJd0ubfBNpC6xyL/H/ZHb7YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326778; c=relaxed/simple;
	bh=BZdtaEcNbYm0L7uopiOvb/GA5CHoytZ4KU2Yh6RYoR4=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HEeRDHRS340xYknBdzYNvlRXexZi4JoY7CwK19mXtvuY/TinzK+j40cXSyje5fPMg1WLoDOo/Krf/fMb8XyJzCvL+ESFE3nsOmMX6yUDufFlnNirt0NOnZCz7Y1DscxQa0CgXkCBWvKSWV1VI26X7hl/RrX+yFksyHAQk0eihdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kg1I1e/y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kg1I1e/y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B41B1F0089B
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 22:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791326777;
	bh=KjOs3jR2y2ulj9WpiDp0LVE8xmHru/IBC+mOJABPm5w=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=kg1I1e/y/KbznlwwlCEfgbl5wJLV+C5Yu4eZCfl2UUzAOBCS5CfjtumP6dA+Zn8Ci
	 9rR2D07mwoDFQpGt2DlyPCwd/cVVi7+TbEExHiOMjCai+Y8SDFdkPd6W/MHbvFadnr
	 76D3Aj2wrJ3/qwvPP1+9Kf9jyTqXEozap/ceRBHSzJGn39aZt+L3ZSQq9Z1b1zlVQP
	 UZgFracivrL3NRhlV98T+UqDKsxM3ET+kigCzQJI002kYO2a5jHbj2lB4lbXqRud3O
	 MbV70GKjqakzsy7sQzvc3UFwYcO+NV+3WPC4qLA6if5DgAR1VENV52yweajHIV6LSm
	 nHfP7T/GpMV3Q==
Message-ID: <sashiko-outbox-162495@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] keys: make keyring indexes independent of kernel
 addresses
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261006223746.48940-1-kylebot@openai.com>
References: <20261006223746.48940-1-kylebot@openai.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 22:46:17 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> KEYCTL_READ returns the serial numbers in a keyring in associative-array
> traversal order.  The first word of the index is a public, deterministic
> hash of the type pointer, domain pointer and description.  An unprivileged
> user can therefore insert keys with known descriptions, predict their
> order for each possible KASLR slide, and recover the kernel image address.
> On an x86-64 build with 16 MiB alignment, 45 user keys suffice to
> distinguish the candidate slides.
>=20
> Remove the addresses from the whole index, not just its first hash word.
> Assign each key type and domain a nonzero 64-bit ID and hash those IDs and
> the description with a once-initialized SipHash key.  Use the full IDs in
> the later index chunks as well.  Truncating or hashing the IDs there would
> lose the guarantee that distinct type/domain/description tuples have a
> differing index bit.
>=20
> Allocate IDs lazily since private key types need not be registered.  Cache
> them in the index key so tree walks and copies of an existing index do not
> need to dereference a type descriptor that may have been unregistered.
> Keep the 32-bit chunk layout and diff_objects() bit offsets consistent,
> and retain the separate root slot for keyrings used by recursive search.
> The key comparison, permissions and userspace data format are unchanged;
> only the address-dependent in-memory ordering is replaced.
>=20
> Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> Assisted-by: Codex:gpt-6-astra
> Signed-off-by: Kyle Zeng <kylebot@openai.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006223746.4894=
0-1-kylebot@openai.com?part=3D1

