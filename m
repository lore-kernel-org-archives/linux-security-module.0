Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21AE44CAC6
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791367800; cv=none; b=GxfACTGmpz+N12Kr5mmHC8EtFNFSmQl+dXBHBj1/r5d497DPXG/YGGRkw6SwjqdV0QNRE5YnLy4zwXCnSEXSIEgU15/RcleyuLr1wl/PLRduMAF/jh/UZ0JscMQTtKQh/nVSTaXbF3LnPz0IMlsVlHE0jc5MN1pgVEBmYZs2nZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791367800; c=relaxed/simple;
	bh=A1FL7QZLuG2LfWs2A7BDFlrPtYkTdOGbrHwKCPItGmc=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=lmOOKMvzROlS/1lRHzKAK3dvmVbe+DKwiKjyelUdxu9dcz+QVMsqEXvwr9SoOIGZoP7hs+Az7YDPtgVoqk5MJ2ZlVnFAHvEWuZA3HtAbFr0wLft1qgqJn7nDrMJQX6oOOjadBLsuKJu3SEXlfeqBuu+cL2lClmD3iNHDU/1oqAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFpTmbLY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFpTmbLY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0F71F008A0
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 10:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791367791;
	bh=g+vDrcNETmge1AaglIYcl3kzu055MWCInLNBjFIzBKQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=WFpTmbLYoDWutT4fpOl4A0LqJQwhS8NUJJ6BTE/epERE1AedtNUhHImGHc0s9UbKl
	 /i7OGJfBS6+EzZrOsAwjYHCGLZAkVmO8DZoPA/927N/jTbYp2bsoIfRrINpIEuSLAV
	 ZVGDp4EpOYj1Co0n+TGkQJ0FK+GOuZa5nHQYiMnw1BcPZJd3M+EpX/K5aFDHRvf4zr
	 TZ8LB8FbNK3O+fdtsut0pkpXwIzOxs3+vShTYTPhDYo+yptcjKm8HPAXdi8yG0gX6t
	 r78poX8dlthtvB2fQXbVBMLHO4MIiqIf8l4BtKg9FatyVqU37Jysjw04UNFDez4SVl
	 YtAtTCibCeMVA==
Message-ID: <sashiko-outbox-162840@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/8] landlock: Rename quiet_masks to quiet_access
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261007100255.1333386-2-mic@digikod.net>
References: <20261007100255.1333386-1-mic@digikod.net>
 <20261007100255.1333386-2-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 10:09:50 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007100255.1333=
386-1-mic@digikod.net?part=3D1

