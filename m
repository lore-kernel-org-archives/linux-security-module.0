Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4ED4AA416
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469962; cv=none; b=lVHF0vloF+jGVh/SZavRs+5pRABVEMf835jEAoLP+w2FELKwpD1siWr9uHpNGrRIWIDAaGE0FbZwor5jt5A70s7tV4l1a6hLKwyVbNYNzRwJa7etwbOFNGj7AN8R+ClYrJXyXlOeUeJzA+TVSaaC5pLDWmk/1NsSxbAYKPslsk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469962; c=relaxed/simple;
	bh=5Y18o4OS3cpn3LNnFd7OZFXRyMfC+SwqOBKOeOygImA=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pUzK1SWpyCyybYA3V1Z37uLl9D7/G/k4gtcHQiPgXiNznOJ1pSjPF3nOeRhtRUHIXI8oHD59m/akfNpgWnq3pz2gkfo0FB5yk90cG3VIygGx8azsqCON2LEApIHtA0Fof5Rz0i3HaowsABeZShxIls8iZhPTZYlGvZsoqbXMR9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoZQ/222; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoZQ/222"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EE51F000FF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791469961;
	bh=7wd9AULozZtHy4jz3QINjsyl86es59d43dIPeLs2CCo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=LoZQ/222JgGIG2oXmZMyQccGdZPT4ZPHdkEp4DyHEktFbs0GZT9VmwK/Mtvwz6iPh
	 vr4KF3+KirFYhaON8S682xx+aPYkzAADy6aH648IlMtfI4kk00lfVdQF6HMTTJL8MW
	 cCPsWdpTBEkFAg8DsM+243lk2N4wZkuM4gtlfgCWzsD6keZ71i6tpmPt84W7egVxdr
	 DboUYGi1kKEl4IkvClYpQ/eAwinl0cVcScZJG+WKiVgypYAW4CSlIQB3pXWp7zURHs
	 YUVFOMUQkKE0+KNFi+mVD1ovxRkz/DWgBIPMYyO7Ew9nusIwymMyEdqtBWqvQdd0+q
	 mexQIFd4re75A==
Message-ID: <sashiko-outbox-164290@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/27] selftests/landlock: Fix SIGURG handler setup in
 scoped_signal_test
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-19-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-19-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:32:41 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Drop SA_SIGINFO, and rename the function to setup_sigurg_handler()
> without the parameter.
>=20
> * Drop the SA_SIGINFO flag: This flag implies that we use the
>   three-argument sa_sigaction signal handlers, which is not the case
>   here. (c.f. sigaction(2))
> * Remove the "int signal" argument and rename the function:
>   The function was already specific to SIGURG and this is better
>   communicated through a different name.
>=20
> Assisted-by: LLM
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D17

