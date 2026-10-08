Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836FB39CCED
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470457; cv=none; b=ciPvf6xlJEppYMZ2ds60rBlY5XbRMnYwyJRuPDV3b4NbTQhMx1RMmF+srI5vH4Iwx931zucx8RNtzUUMTVgz+dgTTPhDafM1gGg+/FnaXzncZ0PhwLuZozyJquVNBF/u1/A5RygeHfPYfXwsaUpJE6oT6995t9w1BXmzx8hh6S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470457; c=relaxed/simple;
	bh=sGHdqCKqlgp2kf2H3RHTy7HJTC+dghR67UufOeGIRvo=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=cccaZV0mv7X4ScoWEgEMVLRIx4jR4d9sWNjWv/merEPFS3AMN61cbxDSZiezyqRYKf5WcZt4dutrgW5p8uUokQnBj1tinM0pmchiqwvoaH0JDY/fy7HIQLxaykk4tdaA4PMUzFHFiZeA34Arp0DeT5CK4Z+XV/L/rlSVftx4D2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRuyPLhE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRuyPLhE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092051F00893
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791470456;
	bh=bsOZ2SXRX0+oJALg66etMYDoc43PoVfYWOV+XgYOGoE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=bRuyPLhExDuw4jNaWfkUEwM2fAQaNP0tLO3g+VB7o2pi1fTfdP1dI5QRAO7dxdfzw
	 xwaHore8YcHoHd4RO8+GPNZ4bFtf67nXx3CJmIQ1FUTJKxd3uCWliI6n9kag/UZODy
	 E588DSUAHWSbpjkm+zwjZE8xbtatr92K3LpOiP0zmTz5ykDYHR12ebEmnbKLfhIKOV
	 T1/XkyXvLtfTV0TTtSHU4Uqlfy62xuCv9WD8FlNzfKd1ukAcTTq+QkuTcisj9LRqyN
	 M4Nb+kW4rhWQsT/188J/JPk7qgzWfenm8T9yWVG4YjgD1pndGSFulB0YH7vJfTtnAe
	 /tgk1DB+KnFmw==
Message-ID: <sashiko-outbox-164317@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 26/27] selftests/landlock: Use EXPECT for closing FDs
 and stopping threads
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-28-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-28-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:40:55 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Closing FDs and cancelling or joining threads whose results are not
> used is teardown, whether it happens at the end of a test or in the
> middle of it.  No later check depends on it, so a failure should be
> reported without aborting the test.  Use EXPECT for these calls, as
> most tests already do.  The same applies to removing the FIFO and
> reaping the child at the end of named_pipe_ioctl.
>=20
> The close(0) in ioctl_error() stays an ASSERT, as the following IOCTL
> relies on FD 0 being closed.
>=20
> Assisted-by: LLM
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D26

