Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD743314B7
	for <linux-security-module@vger.kernel.org>; Mon, 12 Oct 2026 22:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791842788; cv=none; b=QqRwY4G47U8YkGdHAzX7jJ96eKNhKxOPanz9CI6SC+PaaqnkzCWF0j+nVdcQxqwd295eYie/c/gvLG6vxF9uq2TXygbsaTWRCt2WXpPeWynU4xrmIJz2bjVqSDCfrA5FVkiEvJN8iR5o3MyZQtXqjyt/uTzulWiKWMwRgbUJb/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791842788; c=relaxed/simple;
	bh=OHQOgrfxb6k9VnAbaU0KVDjflNGO6E0VnAomiOvAj7E=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=OPGFjBAIcg78IxXZpeWlWOYbttCnKXghHRP2PA8fZApEG2MNWqrI6O2HwYLp3ld+b+yVsbsKqRndtlzrYaXmxA0W8KbPDq4MC7FkoH8NzGB9ckPeP2CFUhgmuAN6iI5cM+MXtPvA2CFjg/q8x0mzoH5D6R+Ko/X21ksLRLkBWf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBIEUObd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBIEUObd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C53B1F0089B
	for <linux-security-module@vger.kernel.org>; Mon, 12 Oct 2026 22:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791842787;
	bh=VSVXUra5MG+CiNv6b1/Gw9fdDYqO9NwSVBNRu3a0LYQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=UBIEUObdYbefWGjovKpq482Tuer4JzG9RPU4gvmJQKsts5oAW5YSedbRiF5OJjnFt
	 IsxuxbRH3lbCy8j3Bd5ai4i5jQcwcbgaORt94jBG0sBlNJtw58jX5OfIpUk0d+4mhH
	 Tb7xCvI7FvqCpdpP6+YkvBcjt3uL7mwLiIKC55H1E55RS1EuC3O09oG5Ilfd7yfsUe
	 VuYXbClCSZysQv3pw4vrOelyskyvQVAniIDtKEctjYZqaxKysZjXK32ciRwqMcVaJm
	 GSepoWZIx+270ak+5m80/pkeyq5v0W98nLlb2blYz5qOsqY1lLzeYT/dzE3n4NWHKv
	 x8+T4CY3y55Cw==
Message-ID: <sashiko-outbox-168671@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] apparmor: fix query_data() output overlapping the
 lookup key
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261012215703.30592-1-cenzhang@linux.microsoft.com>
References: <20261012215703.30592-1-cenzhang@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 22:06:26 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> In query_data(), buf and query point into the same multi_transaction
> buffer: buf at the start, query a few bytes in, and the lookup key
> right after the label string that query points to. Reusing the buffer
> is by design and is safe as long as the query is fully parsed before
> buf is written to, but the key is not: it is dereferenced on every
> iteration of label_for_each_confined(), after output has already been
> written. So when the label has more than one profile with a data
> table, the data of the first matching profile is written to buf while
> the key is still needed, and overwrites it if the data is large enough.
> The later lookups then run on a corrupted key. Besides, if the data has
> no NUL byte from the key's position to the end of the allocation,
> strhash() -> strlen() -> jhash() reads past the 4096-byte slab object,
> triggering an out-of-bound read:
>=20
>   BUG: KASAN: slab-out-of-bounds in jhash+0x595/0x5e0
> [ ... ]
> Fixes: 317d9a054e1c ("apparmor: update query interface to support label q=
ueries")
> Cc: stable@vger.kernel.org # v4.13+
> Cc: Francis Perron <francis@akrites.dev>
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012215703.3059=
2-1-cenzhang@linux.microsoft.com?part=3D1

