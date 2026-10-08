Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6964BD7B2
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470011; cv=none; b=jSfxU1EOGEWggWu5R/vmQQr0QZCKk8GIGfTZvutCBU4gPVrDRFdnDxMjdHutw4GCgpIZgqfdW6nOjSBFZ9zGPdVh3obAi5ro1gZ0je5Tey1XCt/u6VXrLP+UQ6VHV94grGFUn/xuF9u9BiVQYFMR6rTbplDu4Hnm6ucVG+YCwrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470011; c=relaxed/simple;
	bh=IcZYAuRGWrJkhd/EKZrs5S8ILssqkE6hmfG3rkD4UpA=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=SOMtayb8FWnC5O6rv28lgw6xlD5FmDWy66zNCg9xPc8/zV3K2hrfHPA/TwwTVd90bbkQadi6MrA3GhLypK8IKBJp+NVCtsnVUA15JE9ZZU+FyNJm5G/OHrZYx6fbMiapVAqOXC8Ha+1sz5sfv7SUvfgI722eTxKciQAleUpcQyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTZyvXaz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTZyvXaz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E89C1F000FF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791470008;
	bh=Eiqai9tAdvtROFhZkfr8PLFyAH93LofC1pk4SCQSCrw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=cTZyvXazdM34qRfHNK7ybzrTTRMLixCIWUanlkwcRNe8OLn0A9/8yYDuIWfSjye1R
	 X+BgEzjjiMmBurJoGNa1nfnl16QsOZSaysb9zPtu0b0l3G16l3TmOR683khl1o5XZH
	 CsjoF/FcfUvBgbQBHYgct6fQKN/UKb+mLQh5SHJ8+vAZ9D8ZCLFRzgwbU7DtiPyET0
	 AyluvaW2rbXj/qseWS2uCOn5hO5SDq4VDxdhDKAfZsSaquSU01vjUG+jXNaAEEBfRw
	 mBEVMGGOcwVcTXEXpAn0Lgk07ATB+5Y71hUc24cUJbZfqyZL5xkEcIj679hY+pJpL4
	 RyN27jxSyaSbA==
Message-ID: <sashiko-outbox-164292@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 22/27] selftests/landlock: Fix messages and comments in
 helper programs
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-24-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-24-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:33:28 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> * sandbox-and-launch: Describe the actual argument order.
> * sandbox-and-launch, wait-pipe, wait-pipe-sandbox: Report failed
>   read(2) calls as read failures, not write failures.
> * wait-pipe-sandbox: Terminate error messages with a newline, and fix
>   comments naming "." instead of the opened "/".
>=20
> Assisted-by: LLM
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D22

