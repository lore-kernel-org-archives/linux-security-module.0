Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D8F55D889
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791997161; cv=none; b=urXmqIsW/Ef9TpiIpe/23vpFlTDCjH7vsYQaf6ZhQc/W/lRV9WTYOkVhzpf71Zfxe4yjj0qonpw6rMYVV9NoULrtltgX7S/Ta3suQvC0q1T9DR3t13hu9TQ3HQBqdXnqo9trpacjHaXGm0URoT7Xuo5IyvD+oWbMvkzbfSPV3Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791997161; c=relaxed/simple;
	bh=7dQuPFhHKidliZbblWQqZBQedo9g1TbcLWW3ehPDHEQ=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MI8psMqU1/kEE3/1MRHab4d20UDZWAEwSUAUJu7FV+dUb7z+wpBmhEV/PJT83LNeHaF0rwrqK59w7kyLva7AwoAUEXgC+BLuTYpwHqeilNCGcJjPG+gr2gF0lPpuHKYZY3kQSTVYbiww87iL4WGTZbGlEIGqvlYntegTGsyjwwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh6FDclq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh6FDclq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646B41F000C4
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 16:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791997160;
	bh=7dQuPFhHKidliZbblWQqZBQedo9g1TbcLWW3ehPDHEQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Dh6FDclqSNuaWLkE0+SALk/kLODNuizGguE3D82alfmz/pYn6ezZDbSkY2vAlrxkl
	 8lmz97N1QzKlAKBlI/rTGxfrSu1JKHRiGMuibz1ZLOuvXDey+ILnD3RkXIBsNMmcU8
	 ya2iu77a4YSau65bsTNxVBljHgCcpnEKrkJQae9nzcq0QeFV+/rLW/1DyX2z+IZ3JB
	 +VO66jTjNWaxGAgtuZuXdDvcJBGs5Oud762HQtGdpje33yBrdrR6s6UX2MOk1eefHB
	 SnIRknp+sWr2dQlr0sqYKIsRuInEexGsnZVozsKJ4ffiw6UzdN9QVii/67IY8lsQr8
	 xHWurw6i6HrBw==
Message-ID: <sashiko-outbox-171559@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tomoyo: Use isdigit() in tomoyo_numscan()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261014165532.329933-2-blum@kernel.org>
References: <20261014165532.329933-2-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 16:59:20 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Use isdigit() to replace the open-coded implementation.
>=20
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014165532.3299=
33-2-blum@kernel.org?part=3D1

