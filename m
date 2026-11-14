Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794673943;
	b=RKG2G4bmnlLnGV0rygzO3xU1UJnK4dpj4EXjycsKDMDW/J8VyzclQ5Wb1Jyf8ZAow2pq
	 E9Tw3QG/A05rKHpuX0Qsf2YR78gehBWw0ZsE/8cIYEb+Kn0v2CneF/V8C+Y2nmDu9x52e
	 9BE1J855ObO0OdrimmMsKSD+9wKeGYZ+lJmpS//YyMTYOYsrKOeLmhlfazih51yGpfLb/
	 EXWYcRgGigYT6TuHLbwSqXpL2g/bN3el2R+26m9W5lBw/gbG4YBfSi71+Po4VUNtZrzkG
	 e+icPg8ljmRtAdpF3pbQgdcmL2R//ybesfMjJcZbxrD37uz4y4NHgqeID4MSAOriySw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794673943;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=B/MVCMyCTRJPt2QB4fFi7WjSE4dXqZDToUN2gq3SUws=;
	b=yJevuWbkdodXOyjnwfQXFJRD4mCygwRAOtS0WFQohSXXUX09+qRY7KDPJmt79oxcneTU
	 7/RRXxT8Mh5QKSSLS6I8HY1+NQwmWueC49m8uSIGy+NzWoI273oWPwiSBPikJDwjxZgtk
	 IcTDK6pLkueuw0ipx30eTpim3JDF0tL0+x4Zpg4Xpjt/5MC8WnkhxbsIHSIQvXzoagELz
	 X63P+7t4syVc0VlKP/+dzQQCEcBbdpTLnAe2daWJ69T08ys0sMhF6NekYCSoXMTSPaIX9
	 a5ysVlzgIZL+sPNuMksNeAvwWq7mzqrJNnhM5YbhHf5IBZ83jr6IT+nRzDA+9KSLxIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LYJ/I+11";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4084606A323
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LYJ/I+11
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BB81F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 16:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794673942;
	bh=B/MVCMyCTRJPt2QB4fFi7WjSE4dXqZDToUN2gq3SUws=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=LYJ/I+11TDwelqe5EDmQIenV8WBssXiCRjPGuw76xgTy3zh040sncsXIpQxNVrg0E
	 3Y/pypcZ4oB8o8/7cZeLCvpTRv3hooVD8ZpQ1z23Kg2lKXw/7nkOZ06HAYVIer+JqS
	 DcQp1mY1GbRtJ+6FT51g9anQzHXGylQUagHsKSg20gAjafgC90RIXoupiFfd7u3n7M
	 rH+dlXK091vijwbEEHlDt7oY3/ccjE8BuDNtg3YeWPE44uTFF7ISo0mj6JX6ws6jf1
	 wSmCuzHGkOuoTqii+5XOaNCoP5me0fLcHHZnbmL06waCywSgt254onX+BBcb9s7Qp2
	 1yOPItbTqduxw==
Message-ID: <sashiko-outbox-214752@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 5/6] KEYS: Replace assoc_array with rhashtable
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261114161211.376859-6-jarkko@kernel.org>
References: <20261114161211.376859-1-jarkko@kernel.org>
 <20261114161211.376859-6-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:32:21 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The keyrings subsystem is the sole user of assoc_array. It has over 1700
> lines of code, no test suite, and a long history of bugs, with LLMs now
> finding more.
>=20
> This unfortunate outcome has evolved over time by large from the shortage
> of in-kernel callers, time bandwidth and 3rd party contributors.
>=20
> What the keyrings needs is just a generic key-value store, which performs
> well with sparse key sets.
>=20
> Replace struct assoc_array in struct key with struct keyring_index:
>=20
> - keyring_index: holds an rhashtable for direct lookups, an RCU-protected
>   list of keyring_link entries for stable walks, the active link count, a=
nd
>   an rcu_work item for deferred teardown.
> [ ... ]
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114161211.3768=
59-1-jarkko@kernel.org?part=3D5

