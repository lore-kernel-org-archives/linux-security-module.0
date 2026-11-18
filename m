Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013813;
	b=equUk5Vay7isRhhWxJuUeGCRzrZG0Ag4GOdRBeJFr1tWNOeggQrzO++BuUwOKlX+i34/
	 5EO+aIX+FbfxtEMrT/U9BzYuZbz1D/6QaeMVTUjcXM8cUz7ZIyuS/MYH3kjE/p39m2BfD
	 7+HGE3Pdg1Lbs/TdldgGLRvm31OUB1PFRsfoxKA1pZbXHGNJfBVWPxj0MKW08nN2ESMfc
	 tgzhoR2tI4uTX0Q1098AtZeA4OpzweoAJMOSiENPRIfiSSd1A2W4PFuenTvxMkuTRDZRS
	 jKfUgo9VzYcjo5bG58K0g1bBAIG7FfsfljYzf3U18z0H8ReYEjvXpTwGWEYCwn5b9ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013813;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9P0TSj8S2VsJbOHl89tepnumsjPU+oK4182rt7NR/MY=;
	b=Qv2+MAiEswAZQqiEU6dcpBhE7JDj7gRx+i6MJUBPosrXjNW/1tW7FpAFkgdbBea3nt5h
	 AadLmvZLWJHFLZA/KRfOnDP1HhYd2kA8AJN4UWzOczKhdhRBaI5OkzPuHR2LixWD78jx7
	 i+XHbIfVtXWSI+xZUvCAw5i5Kntlt/BDQml3HdiVFdqD1JJoiOLWDx5PZN4XRDldxhv49
	 a/5LQoJZQfrmxYXIk/SPyoofeScuJZoABXoE7Qd1FI6A8tW/2ep8WzK7iF1jsF2/Ft3AZ
	 RFp3VCwUUBOEhH9KTnxSdbdOXT11qox9VYFLFxtMq7ssK9eXMIRf68YZJfNDmiOJ+sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SB/Z5jJh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46677606A32A
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SB/Z5jJh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AA41F000C4
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795013812;
	bh=9P0TSj8S2VsJbOHl89tepnumsjPU+oK4182rt7NR/MY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=SB/Z5jJhvPje/GWgu6ao0Uxqhmdm1E8ctnZFZCLBeQNVGarin658RMHT1kMMstlT9
	 4gH1wcCWR5s5JbWiztszjyHS7pz5Icy/vnrs/iOov5SZBDsS9sEB/YPzHMHZ9uRFO/
	 xRSfjyJQ20klKvUPYakkIduTxeIPcfylH4JTdKuTVvgQStMWTBa5/ZcnbKspLxHGEX
	 3jrGhJu5DVNmeE8JmiSgzhn81duAXN0zXKUDyxc20wIXRk4E9ZonlGqbfAurIRhjNG
	 UptKs2wo5ZsnbYu6BWE1uVxxx9oy5ld/FyqWtzp2Hy9kBMIZdm3FKdOTGNbAm4K3LI
	 aLACoq5UAdPBA==
Message-ID: <sashiko-outbox-221271@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/6] landlock: Mediate CAP_SYS_ADMIN for the admin
 memory reserve
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261118145217.2551053-5-mic@digikod.net>
References: <20261118145217.2551053-1-mic@digikod.net>
 <20261118145217.2551053-5-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 14:56:52 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> With vm.overcommit_memory=3D2, __vm_enough_memory() keeps the admin
> reserve for callers with CAP_SYS_ADMIN, which cap_vm_enough_memory()
> checks with cap_capable(), so a domain denying CAP_SYS_ADMIN cannot
> withhold this reserve, meant for an administrator to recover from memory
> exhaustion.
>=20
> Add a Landlock vm_enough_memory hook that withholds the reserve when the
> domain denies CAP_SYS_ADMIN.  Like commoncap and SELinux, do not audit
> this check: it runs for every accounted mapping and only selects a
> limit.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
> Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>
> Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118145217.2551=
053-1-mic@digikod.net?part=3D4

