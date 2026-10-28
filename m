Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194858;
	b=zKt4429jlM9XES4mhqufHEN3cruPdkS2E0srug9pbcl+s5/3OpQFdi3XfJRTbeZ8dttp
	 J3zxuNjAe+wm50JLAlcLA3vcJyqPT+UNpruo+7JLvOVZ06zMW22kMaeP3XQ4R6nkDOd0s
	 GhpALTkV9zVkR+zvVyafggz969ud9SwLu6m6heyMXk2AL8C4kR1Bg3StqnLeCxujBGXPI
	 GZgNBTrB2ZS8u+58vPb75CchRbDfYCJNUklTZmDeimb4reeqH4VMZC7d+oGcv6GEWrBNR
	 JCWeMhZQcyqeK17gqlZ+jze68RynX7EFlnM+K+Bmw2m/Y+WIeTrVy4MoUSsFXVOUtaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194858;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nC7lFALYXL/VRVj2KifROfLcS1Bi5nwnXq9Ts2GXoMI=;
	b=oNYJUmh8ZsKLRLpympDGBACI+8elq72m/Z4cuwxC6Q0oOfyFjMUfMCrbNoznVgUZAL/A
	 jXEwXilKXFTd351G1ozCHEA/9Em4eqW5LitpufPwcZA7N6nNltz6y8FpcC0eO8yIsYriI
	 sBg9X85ulihBMfYyKj/XnM6RXLW15qe3VVULsxQ7docTJCwtj6l+X24kK2IL7F9voJUd/
	 HRP9xk/eHoB8oJNr8Muih4iuFNaxm1tkYzV2euyQdg9ib+LWs/Y6BkvFwj11/l5UOjCuL
	 IQ+9we0j+DTpMJdZfYstN21V6BCmMdGF22Dm3FRoj1HJh5AMeEukqVS1GSJ/iF6buyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bDaYgSNa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBA6606A31A
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bDaYgSNa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271371F01825
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 13:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793194857;
	bh=nC7lFALYXL/VRVj2KifROfLcS1Bi5nwnXq9Ts2GXoMI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=bDaYgSNa6bKn9ZTAysDnQ6aKZQdbnx3ggyO5dMWXaJD3mWR8ZR1p/FUOP4on3MHdx
	 rNQkGOwt5+3tUoD2uJJqgUo0YGQODW2Qvrd4rUTs7lT1BWY2j8gO71Rezp7NE30WU2
	 JxBgug2jWZB62bnLOK1lyK7L5XNp+cvM7hWXVTSGzo2/KvHJkVpQgOxG7R3H3zf8J4
	 HInUuP3t77a3f4CiXgWVOwFXciTZoPSAFSe/jJkNr+GjQX+1heZvs6SRBrvjfjnEu6
	 SSa9vpHC6EaRUXQAfDJeMSQOSAuCbs/kReHdL8i/56Ts1Ck9GXB6GIk9vfwJWZaizO
	 SWTNzLTvMehpw==
Message-ID: <sashiko-outbox-187935@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 5/6] kernel: add KAP checks for unshare and setns
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261028133335.75899-6-ketan@armoriq.io>
References: <20261028133335.75899-1-ketan@armoriq.io>
 <20261028133335.75899-6-ketan@armoriq.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 13:40:56 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Check unshare and setns against the bound task's authority. Neither
> has an LSM hook, so they call KAP directly. Every namespace type is
> checked, and setns checks the type of the namespace it is given.
>=20
> Unbound tasks are not checked.
>=20
> Assisted-by: Claude
> Co-developed-by: HARIHARA SUDHAN. R <harisudhan@armoriq.io>
> Signed-off-by: HARIHARA SUDHAN. R <harisudhan@armoriq.io>
> Assisted-by: Codex
> Signed-off-by: Ketan Bhardwaj <ketan@armoriq.io>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028133335.7589=
9-1-ketan@armoriq.io?part=3D5

