Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE1035F19D
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344955; cv=none; b=c0JSd5Rl/QIvzdts1MLJryY3ECGpPQtgLbK9hmAcS9M8IAS+o82XWt+CYaW6QbflzGxwE+5FR7gltObb04i9whOJhOFEnuxURuiCPpikSQ9QEC8OIOrry0YgrvXuF1JnDqugBycDbE/C9icvpcCd19waIgE4hjxuH42M52lapoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344955; c=relaxed/simple;
	bh=0XGGeWS70L2SerBWTaZ18RxdjMO43HyEZ2u63bhi5yo=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=oIPE/9NTC2dbe6GTFax1UWY4ao4bHEZ2g8UkYCA9uJATeO4oS3by90NwHKhJB2ifc5Bxk64hpYAULCYX/eSEao4FuKYj0GYrUHmxnxKHRsztH22BES49d7akp59qzNgAOH1aN04Bfc78DDxGHZX/0QSuQ5afSaaQl85TJysniLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CT14DRhi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CT14DRhi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92101F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792344954;
	bh=2YcCEfAoA0dnli0+F5Nivs/WFVnr9EY+KpixsoVihF0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=CT14DRhi3miqR85k5tr0nlBE/c45izjF/TJZ2xbz7WHWJbRIBnlNDRYVDcYNBF5k9
	 OXMi7VtPs5xizV6MKvzQ5PEZ/zcAdM7tGzFDFZUolhvDmc9h/3QNMxXKESFh1d9xAN
	 K5+gLcyiLGSEJTVzcvPct/A786VavD29z0Mf4CTqRWGaIf3ylF/IhYK5sn+6RxpBra
	 YzXIfXwrTjUH3EHrdq+aJlp6RTEyihxXqqmmiSM3lqfQqaMN/gvJlqIib6TZ4MZgzi
	 Dp0q8DTKVn6uVc1WUS5xXmlvTQTB9T1n+j60AAAuSCtEsjsW5zhpFI0JZyQPXBzwLO
	 NIhSf6zTsNmjA==
Message-ID: <sashiko-outbox-176328@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/13] cred: gather the rules for acting on a task by
 uid
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261018-b4-cred-ids-v1-1-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
 <20261018-b4-cred-ids-v1-1-7bdf2db4ea9f@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 17:35:54 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> A number of operations let one task act on another without any capability,
> because the two belong to the same user: signals, scheduling attributes,
> priorities, resource limits, ptrace and more. Each of them compares the
> ids of the two credentials by hand. There are twelve such places, in six
> flavours that differ in which ids they look at, and nothing says that they
> belong together.
>=20
> That makes them hard to review and hard to change. Nobody can tell from
> one of them whether it differs from its neighbour on purpose. Whoever
> wants to know what an equal uid is good for has to find all twelve, and so
> does whoever has to change it. A place that is overlooked is a hole.
>=20
> Gather the rules in kernel/cred.c, side by side:
>=20
>  rule     of the subject    of the object      euid 0 used for
> [ ... ]
>=20
> The callers are converted one by one in the patches that follow.
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018-b4-cred-id=
s-v1-0-7bdf2db4ea9f@toxicpanda.com?part=3D1

