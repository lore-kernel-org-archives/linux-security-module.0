Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826929;
	b=pedab+AAvJqMJm3IgDkVHtXIf7UKFu7anCCdky96mywMub5H8TUPfCxzhJViydm00VYo
	 LPQS4W71of2yQqhFhsHvkDJr/z5ASKJRLUSViQ9hL0alVm1i9fQH5FoW4QkEwP3q0etsi
	 Glz43AAyROPcUiKu2DAh2MNPJS2EFj0Hbr3rsXMlEgtFT6SZ6IXCu9SaJCL6uThyS95Ss
	 ZCxg57K8MH076A8cXBM4Y4K2m/Fp/Lwep1NQJNDwYAMF0IthCNEQwFLbPx/y4EKjxLCxS
	 v7ZjTGF/RNXSxSJsmlV5uIg9CG2k3mQ29z0CS4MupLy8k3vy65gl4orh/Ei4BNqqyGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826929;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eqHYmUdCs3CUi8F8VjopQiM3fL0ElQ9HNeUha1FuAIo=;
	b=WbfljuUOtRJazLW4pgAHlviHMFl0tOj1fpYhBR7ToBqnPh9JOG40HqQmJsg+Hvv9hUTH
	 kvnSBY/gVZH7lEj+wKoUCKhmNCxb3OnaGDIpGx7zLAN4K0xpbBKsaMw4IbKYyKBklZHrT
	 4rNayqPnxKKBN/cLcOM1am0m8KOF+GVEh1eV8fY+NJDXQopwHqxBWvgkUuSzW36E3cWuW
	 LGTtp8PMYe5DE7rQwHUV8fWjCN8+p8YILRAT3e85fvjaNPMU7coVe8FKHo9rAa76tQA22
	 MrMDpP8sF9rkLen2yHuRNX8FKA694R8X7kY+WhsTIzEYTP1atO1IkB4MXYSOK9QnW9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYDclCJC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47776072FA1
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYDclCJC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE8E1F00A15
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826928;
	bh=eqHYmUdCs3CUi8F8VjopQiM3fL0ElQ9HNeUha1FuAIo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=AYDclCJCoTZtVnlEIiiULoCwyTC6NoSOn9B2gSmagVORU6SOiEVMDBfMY6miA0JbL
	 a8z/gLnzJhJeR5eBh8LPdGdqYnpcGmICc5F2+AiwtYnH1hF9X8TZdIPim2VT3/Y9hv
	 u2Elqf00qNTrDSGP9y/3j8euIz17/lMLZD32Ft8cK6V+Pe1hzb3fL7rx14ZpdgGfBi
	 zwFKp2iZXC8al5ot4MBkFFMl1Cf9rU0XelJ0Nekxw/HIdcZUPiueH/b2+Kc6yXSAPD
	 pAXyfHZl/9ZZlSvYvD+2Shm9dL97eCR0D8yTrEtQDGsoMPhtKDFrW2Z8+ZdnRl8q31
	 eeo/j3Ueo9c8A==
Message-ID: <sashiko-outbox-198080@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/27] selftests/landlock: Make audit_message large
 enough for any exe filter
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-14-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-14-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:15:28 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> audit_filter_exe() copies the filtered executable path after the
> audit_rule_data header in struct audit_message.  The message buffer was
> sized as PATH_MAX + 200 bytes with received records in mind, but
> struct audit_rule_data alone takes 1040 bytes.  That leaves only 3256
> bytes for the path, while the kernel accepts up to PATH_MAX bytes, so a
> long path overflows the message.
>=20
> Size the buffer for an audit_rule_data followed by a PATH_MAX string.
> This only makes the buffer larger, so received records still fit.
>=20
> Also check that the request fits in the message and return -E2BIG
> otherwise, in case exe_len does not match the filter's buffer.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D14

