Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792774006;
	b=NhCt6FJnrENYHYp00WlJ1u1EztjCSa/IJ9ayQYOB/4hxMR+K4JY/h7VqoIQiMpajkRod
	 H3v3o2n7bRSiMNc1x9yS6WOQOANequgvldGnvghC+Yak+gygbp/joCBX//iVljgvT7fgz
	 5FT8k8m8Q3sTghaOGEHOomJkSEJIKuQ11O15pnO9z3/l9UuNZ5A/A7rinTquvs/75ziba
	 MOfKpE2TuCHGgbGDzushkm0Si3lg4tVDxIyV/G69bYxkf8h8G3FegCDNMazn9WjBRTz07
	 jmTfOi1iiu5c//KVhIzPkIEoFypb+pyphjKMyBifyPAhmLoYs245EDDyJ86NNH89JDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792774006;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=amLtFUDpBhC/5R9fsjzUKRyVPYQJcbxXn3w0LEuHB1w=;
	b=fUriv6S9Aj4uYCqkaCyXmLKwwAaRbIB/oJRBp8FH4iIGL9fbAyORXOQ74M+cb8x1i/ti
	 TbXOQR+mgiTK6vclE2GPx+NAlR1gCwaOhP9qZN6v1A0lvGsRxCPak7vM/NQ5Qdbg7PBX4
	 6c7SOY9IU1y6lU1Kaqsm2gOhE1t9b6iJlw2J/udMDdXQjBiImEkF21tIv98R5lg9cJdkg
	 5xPhgXVdrjxIZ187gMovsU0UIBRuuxsYrUmUFgyeiL1X8ZfCkK5lbSEQwhCrx1uibN1XB
	 w3yT/SfTSCI9IHxyyW2AzD64TIXCRXXoZzikkgJXIimD5Z7HsWr2O9Q44RAFhhZjw9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T4Fg+0XV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD92A60A2600
	for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T4Fg+0XV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DF11F01829
	for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 16:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792774005;
	bh=amLtFUDpBhC/5R9fsjzUKRyVPYQJcbxXn3w0LEuHB1w=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=T4Fg+0XVDYNgAzQSHO3D6YbwGs9xosTTz9YvZ909aV/lW3O/e3ZQSPRbZkOOz741d
	 Z0eGKI869jU6CZttqPXXQWMYjNIAsHbt5yqX1HsKdLy0HCsydev/g0Y5hC3vfyfUWk
	 z81leRUQBB3vzb+aKOpLMeFYKsuK16fabNRjJIolw7nLTuaRmtujtItHO9QXPpfYW6
	 8aFOsnI6mnn6jthouwRjxz4JsfSECVs3DgigOcrZCTq8s0K6knDmO5/zwlWp3KcWK5
	 +hsEGWvV46haEkAv9ZF7/SjfFxeMr28N+h920bp5fTeAGFA68aU4BFAoQfkGCadWyi
	 R4cbBZ/JbsVTQ==
Message-ID: <sashiko-outbox-182967@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/5] userns: don't let setns() lend CAP_SETFCAP
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261023-b4-setfcap-userns-v5-2-0620223be951@toxicpanda.com>
References: <20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com>
 <20261023-b4-setfcap-userns-v5-2-0620223be951@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 16:46:45 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Mapping uid 0 of the parent into a user namespace requires CAP_SETFCAP,
> because a task in such a namespace can write file capabilities that are
> honoured in the parent.  A task that is already in the namespace has a
> full capability set there and can't be asked any more, so
> verify_root_map() goes by what the creator had, now ns->setfcap_level.
>=20
> But setns() lets other tasks in, and they get the full set as well:
>=20
>   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
>   unshare(CLONE_NEWUSER)
>                                     setns(A's user ns)
>                                       allowed, euid =3D=3D ns->owner
>                                     write "0 0 1" to /proc/self/uid_map
>                                       ns->setfcap_level is A's -> allowed
>=20
> [ ... ]
>=20
> Link: https://lore.kernel.org/all/20261021-bioenergie-allheilmittel-undur=
chdringlichen-35666eb62cff@brauner/
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-b4-setfcap=
-userns-v5-0-0620223be951@toxicpanda.com?part=3D2

