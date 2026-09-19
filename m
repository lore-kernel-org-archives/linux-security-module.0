Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC50F37E30C
	for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789822984; cv=none; b=Kd9DP4XJb43Q+ckKoiQCtccZ4XhUqA+adUFvLKdE2HWZlx3EeCCjM1Np5kdDoExUdWMkQm5EyGrdHBgmSMsvqpeYc6KB0aqsbzJuqvQCCx4JaGl7OFv5jhpvZW7kxXOg7uhjMiEpgG1ux+WO1mvrkTAW8n9zAAO88sDMPIi0lG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789822984; c=relaxed/simple;
	bh=FzZq0kd69DiZuCqkhJj+GgzP8Dq3NUch3OrEa9c7crs=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DhxoQbdWj55PGoZR30Mr0UsHFEKdA+d0mvuGzeKbTzzJwCJstJG7n4gTuoCPHljzXl16rgS8wTQE/IQ2W0xe123miLNX6yRy+zXfHztV0Ril4swaxRPik7iXZv8jsgowrEgzD9V5LRvuFT+rM8FG0Og1I0w7fUGC/gFSw+WM8xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FL4j8tIl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FL4j8tIl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2C71F000FF
	for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 13:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789822982;
	bh=FzZq0kd69DiZuCqkhJj+GgzP8Dq3NUch3OrEa9c7crs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=FL4j8tIlnLFrKMXKu8U8vyCHwwb5RyaAXLt14lzxZG1XJKTm4L5BoWWTJmAo0M0QL
	 wILrSuWCfpsDaKyqocRoZBu7wGKUsf+74DetTq/43Sc5E96QjEBfCoMvad7temWNHX
	 Pe3yj8iNzupgnYC0Kr8mdKjqVtxqXoOSeKaWYos9Ow6yjJKTrwYtqgSsfUVrZaSDij
	 rHcuBi8yr/hwRI73V5Awh09sk2U0RVK7jEGQ3UgQOehYWrTKHta/A2gXPQ+ShllWsv
	 4a1oRQ3x2qAKpI6a1pif5QhmVIfdvLp+I2Rgz4kbiVEt+00SaBeBxEQLy82tDD1sRh
	 h+bSlEeBqPUOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] security: commoncap: clarify CAP_FS_SET comment in
 cap_task_fix_setuid()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260919130112.849932-1-adrianox@gmail.com>
References: <20260919130112.849932-1-adrianox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 13:03:01 +0000
Message-Id: <20260919130302.6D2C71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> CAP_FS_SET is defined as exactly the capabilities an fsuid of 0
> historically granted (see CAP_FS_MASK in include/linux/capability.h),
> so dropping it when fsuid leaves 0 is correct by construction, not
> "too harsh". Replace the stale FIXME with this explanation.
>=20
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919130112.8499=
32-1-adrianox@gmail.com?part=3D1

