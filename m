Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAA351E459;
	Fri, 18 Sep 2026 18:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789757890; cv=none; b=bHwbjccJxbk06YortnoGHrUiWq0wpe28LBQlwUXZxFQ/Li9ZMVooA9omwHOS+CFutDax9l3fAN2FlJpex+M4ZD7EcIF3B/U7WeTs0eeiw8ZCj5DKB0fPaArp11h8C2o7yeom0O3+paV9KP3hI/GH9av1fsjEq70xKoL2GbPBits=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789757890; c=relaxed/simple;
	bh=86ypG4G5foBFRJ8Xrpgkd0n3/RwRSi3fzcXvrsVeIu4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KSD1vx7ZBKRs46nBY5cDi63YVVnKO8PObfYpc/p8ulHAfjENHMijZf2wNlXpktgCykFmPeANBL6GYrsvx8KlWo3y2di9tyr0x1DT2Dbk0UKxQEtA6d98l3Fgc+/tMrnZ/AqIINAIX+NZMScwHIXWlu2jNzER0RLyex/MurCeT9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfYz2Cvy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfYz2Cvy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA841F00898;
	Fri, 18 Sep 2026 18:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789757879;
	bh=86ypG4G5foBFRJ8Xrpgkd0n3/RwRSi3fzcXvrsVeIu4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OfYz2CvyjzLVb2IamhrLVWnaFCDqCyX31D5yyJE8aJ4kVbuzv+1RE4copfTXKJSZR
	 9iibopL3421UEfnjsSX7UZnSDhG1cD5VBVWKU15MrLxirNJHBb5kFFSu7L5EZhy7St
	 qFWA8uXnuM2UpfTZb+HNv82+rW1ThUQxKUYoW5JStML5u5IhfQDLasePrlR3lOsKYu
	 llfBAJ0keWEdjqx1S18IKYZgMuHmXfm++/R+hrVt21+iAWZWRsfUsQ7Yva3uPjzs2B
	 93Em5d901Br7DUOgQQAFyMeVwE6mf7Pa25/AnPuY6FRLkzW7pBiOT/ehaywti2iUKx
	 HKPO9Dg9dwG9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/9] landlock: Fix network denial trace context
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: linux-trace-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260918185036.608651-5-mic@digikod.net>
References: <20260918185036.608651-1-mic@digikod.net>
 <20260918185036.608651-5-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 18:57:58 +0000
Message-Id: <20260918185759.5BA841F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Network denial events report source and destination ports reconstructed
> from audit data. Their zero values are ambiguous, and neither identifies
> the complete endpoint that Landlock checked.
>=20
> Carry the checked sockaddr and its signed length in a private trace-only
> context. For an enabled event, validate the length and copy only the
> initialized prefix into zeroed local storage. This prevents a typed BPF
> program from reading uninitialized bytes while exposing the socket
> family, socket, address, and length.
>=20
> Replace the source and destination trace-record fields with one signed
> port derived from the checked address. A value of -1 means that no port
> was checked, zero is a valid port, and positive values use host
> endianness. Bind blockers select the bind address; connect and send
> blockers select the destination.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Fixes: 01ce260f5ccf ("landlock: Add landlock_deny_access_fs and landlock_=
deny_access_net")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918185036.6086=
51-1-mic@digikod.net?part=3D4

