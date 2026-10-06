Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241EA248867
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 03:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791259008; cv=none; b=Wwe/bVrQYWupYFCDjpdwLZEZVo38OhDCw/rtwaH2vzqmiRvl7oBVm4Hy9dZKfrY0WCkWUczaIdBAlZrVgsKDbggJ1wTzjkcrBg+2oP5eARtmbWgpL29u8MbRRglbnCHL2uvATFnr5T0MjGn9zb+JSoDqQajTCw76CsYvqoJcMDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791259008; c=relaxed/simple;
	bh=f7WqpfVilceSZxXkr7j1xfEMr9L/rcs1pMmpelo0laY=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J6PLAcY7C6snHJXXFIC0pT4Ot5s3chVYfuLC7spC/Gw6lYG59yauLivyvwA+rJWNPggdjbSOtLEvJ8uXqtr1NhWsRvhc3M2kzh05O+0VaxC+OtvHMeO4142Ib4mEmIvVDr64PemP88lnWHhDc2AlbIJlG42FOOkg1fs82PqyNno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwLGKgos; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwLGKgos"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46C71F00893
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 03:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791259007;
	bh=IVyy00QLDDzNfQwE9ZZDmCIVN1ZeZgsQ+VxdzevI9To=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=VwLGKgos075QaC5MxhJW3HgUyPuN6yi8p5yqAHo8nq7lZ59oi1pkBIcn1kf+drooM
	 vPHNy9/fNGT3CElSOFr0qVPKwKe5ZvM36t99ezRZIsFdjk+AQMC5SOG/s60HuOj7bV
	 DGZrg1+/Z2nMRR+h+lNjBXMErdxPo04n6IvPYRNuJjTQN8488N0zcvbe7S6Po/IhTn
	 UsECGnJvktj5iL8FkqkQtkdJdmlJE4idaIRT1/5VstF1Gy40WXDpaPym/Lif2jdpcv
	 qNDA2W/v8+YaNV8wyyDX8s6w/Ov2yYqtWwzZCRCY8jc4Uha6b5/dly3Iv85izQHuUp
	 GYc6g9CJabwew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] cipso: adjust cached option offsets when
 removing CIPSO
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261006035108.3101440-1-4ncienth@gmail.com>
References: <20261006035108.3101440-1-4ncienth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 03:56:46 +0000
Message-Id: <20261006035646.E46C71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> cipso_v4_skbuff_delattr() removes the CIPSO bytes but does not adjust
> cached offsets for options that follow them.
>=20
> For example, with a valid 10-byte CIPSO option followed by a seven-byte
> RR option, parsing records rr at offset 30.  Removing CIPSO moves RR to
> offset 20, while the cached offset remains 30.  Consumers such as
> ip_forward_options() and __ip_options_echo() then access the wrong bytes;
> the latter may interpret packet data as the option length and copy it into
> fixed-size option storage.
>=20
> Mirror cipso_v4_delopt() and subtract cipso_len from the srr, rr, ts and
> router_alert offsets when they follow CIPSO.  cipso_len is the distance
> the first memmove() shifts those options.  The later header move and
> network-header reset relocate the bytes and their offset base together.
>=20
> Fixes: 89aa3619d141 ("cipso: make cipso_v4_skbuff_delattr() fully remove =
the CIPSO options")
> Cc: stable@vger.kernel.org
> Reviewed-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006035108.3101=
440-1-4ncienth@gmail.com?part=3D1

