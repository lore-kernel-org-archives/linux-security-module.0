Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81294B95A6
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 23:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791934025; cv=none; b=UEL30OB686iMj8+tQ4m8ZmYn6tx4DLukbQZPAbOfNvsb1qelDEXRnZ7B3CnoIzMtk1MzN553fxFX2GDPZiONG0Tc8Vlc0SWa0sLRgMfQF4ZaKPa05096WK/w71DwUHB7SAyLb6XmuptK1rJHhQEb/OKX8eY2lqxeBYi4WctJa8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791934025; c=relaxed/simple;
	bh=IwzplrZhUM2e0ddlP+DyDcLnxsgohztH1uai8e9eo8M=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HyI3dYevBeVEGKg4Rcf/qndRGXXCGEG/bKhUueAnKBNzTRGzZaN6xquaowUA2H8uEv9o3MSA1leSqatjsznf8hI8+weyuBoABKVlRVnlEx/0Ugo3GKcoTTZ1BMk4hIpooP5szfTD09UQKGe3c6FITnoHk9ZYtJMV4Db1hAiHGtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXF6OZtR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXF6OZtR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC391F000FF
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 23:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791934024;
	bh=BOIxFo7+jj1T9uPm1StBywNsLNG6VsQNl6OZty8JUeQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=NXF6OZtR2NJa/AzcDFE3d7eH5bOY+5tKOQV2czq/UxW9bNt/g+jrCjvBpzsftNCMu
	 4rdGOqzZtsT1fZjx5kcsjlTzaln6GfCdp+3WAYYFhx6VfeCdBvuQCgzU8ShnkmWyzv
	 V25pyVEWRdXDBL3HGuzx/dJ7ab0zjF7SZSHiYiXfz5q5O3UHaDSWmAHTS6fExO/WTX
	 MrAQJQQKhcReNWGWOqkldcoIlhqCW1mAmfit5nURbWX//w0nMaKaUxbrD9A/dWepgp
	 5omoLEe2IRyZ1MncVNZcmmTg7Pi8Mg+ts5qJW220QgY1ILJIYhRc0xm7QlcmARpsD9
	 wkFOGeMv3bhnQ==
Message-ID: <sashiko-outbox-170638@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] keys: make keyring indexes independent of kernel
 addresses
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261013231251.56170-1-kylebot@openai.com>
References: <20261013231251.56170-1-kylebot@openai.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 23:27:03 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013231251.5617=
0-1-kylebot@openai.com?part=3D1

