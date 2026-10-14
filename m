Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6546D4A0934
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 08:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966836; cv=none; b=suMFJ2cKI732N+dvwGTDz7tjixVhFSjcoxebC7eM95+G0FGPJoVrzhCl/U5qZ9803/py6rr41iBcUlpK2M/YDY8C0426+p2eQMPA7U/wLQEb8d5CmqR8+Gs/HAMM70yBV3lTy1dpi35vCo5grzRBZVPNaVQ8Fif8Lg5Y9n17h8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966836; c=relaxed/simple;
	bh=1DBRvJkW3B1EZILRRtWFcwpRargktFW8/Txc2bBtbCc=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hq3QCAcRKf3SJIsZa9hDqvNJg+OVUkq0sGVj4w7aVvS08vr+NdhQI5M07fPmtDdCc/65xfZN7z/U5ntN5MEs7liDFiFgtbmMCgd4tRFSiBE5qhz7efYVoL9SK2b/quVcDkjNMvLWqfXeQ/YEKn8H+cb6KhjRUKyfhv8y8Nh/kDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6Ixt71v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6Ixt71v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E431F00893
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 08:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791966835;
	bh=k3Kb+m8om1gb4Ggi+E5Hwsf+oXvRn3xL6jKBMirABS4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=G6Ixt71veteMWD5z9/flhzqqm0LBSAAS9Veb6sKPjgdMrOgdcTbblxA7oP8pPWLDb
	 4G9v4uoQqSOXeCiLXqbaCexfkb/6szS4iB5gZPZeEFmYsF/gycUfRTNGSQ0QAZThkj
	 gBj+uenYmrUom5KeTMv/NI56XgRwJGJ/Ov0d6eFr0TlhZDKnEhWLX9cRacDnKfBFWx
	 sOZWmZXQv/kpLL2/qcRA/cXTdJC8SvhxLr5qEX4vP+BAnLqIlVTdwkpwNMxzvcDhvj
	 2QbubUylnDUUJRwnq/HeiXbgopui4wDLcS6bq0naKqHHrl/dqjElZlH6NGreMZRpza
	 IhHYqFJofHbNw==
Message-ID: <sashiko-outbox-171018@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/8] landlock: Rename quiet_masks to quiet_access
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261014082718.1435842-2-mic@digikod.net>
References: <20261014082718.1435842-1-mic@digikod.net>
 <20261014082718.1435842-2-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 08:33:54 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The base stores the fs/net/scope quiet bitmasks in a struct access_masks
> field named quiet_masks.  A following commit adds the sibling struct
> permission_masks field quiet_permission for capabilities and namespaces.
> quiet_masks drops the access category and keeps the type half ("masks"),
> while quiet_permission keeps the category and drops the type half, so
> the two read as an inconsistent pair.
>=20
> Rename the base field to quiet_access, giving the symmetric,
> category-named pair quiet_access/quiet_permission that also matches the
> UAPI handled_access_*/quiet_access_* naming.  This is a
> no-functional-change rename.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Tingmao Wang <m@maowtm.org>
> Reviewed-by: Tingmao Wang <m@maowtm.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014082718.1435=
842-1-mic@digikod.net?part=3D1

