Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022347;
	b=t3BeySFoWQ5IGXPE536WOSaNIzvJgEe882QRIaVb6ksrp7GCuquo9R9mge+GrbaL+ObQ
	 MzlweVPGuWSRki/sUnlFYAsPY5od+7wQ6VkQQiSX/DZ5j6HJ/w+554uaihlH/a9Z8vL7a
	 od3asC05H7BPedbUxQSxq2V3VPvfctJJ+6IIX5UNYEAVNTuhPmDQzdDzoni+xaibPIm7p
	 qciFPHuhU+32nAZIDZM5jeenXhImMEnEeZPzgKJJeryFAWpLTEMi79Sw1UyO9SZ4u2wFU
	 PE534Djd8RTo6qXy8GHr7vN22On8Dhq/ODQfN5reb/UP4XsUTTwVXnQTXHOqtXHivGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022347;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tDqaLcbTN2OgaOmTuOKyz82rz8Tml/tD0giuJ5GNJco=;
	b=3+MTskxQn8Vga/iIu8EDVHjBc/j6F3FjL4k8Pwe4SutouChw/iwImIAlu4N2rsKUCvCZ
	 inNEj0jLxK6wdWlfwvnLBW52pwZK67lRDcwWw+YruDfhV4oFnSPKdYa9x0Cv9QqaLCcbT
	 uDUycD/UJDAE79e7RyjsQ2moGhIlLECoRaTfGwsFf3aK4/fotumYh/aENAsTRGKUx//Jh
	 5tSxwSfyC9en8UE7ZFQ8gQWo37zXf+3EutuEWefCf/HzkwtfG3JFeiNuwuQ14bYc2b1F6
	 GceAFAUqJNSi6RdkPV2a7qwtb8GSQPs0WAp9cmQh5BTvuPjH3pTFHRQtKP59sMmrahQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RA6/3Gvi";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08011606A31A
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RA6/3Gvi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC061F01825
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 13:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793022346;
	bh=tDqaLcbTN2OgaOmTuOKyz82rz8Tml/tD0giuJ5GNJco=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=RA6/3Gvimi/XRVmvmb5SzKO/MjyfcrfPGgbjAekdp6WFN8o/tooUqJlufR7fW0Obz
	 dEqtK/cE3LeSEZ9Df99im0J+FBg1IfKEh35YF5u3MIFCWEq4zqshrq1orSrARuWKP4
	 5rvqJZW8oPQku2ZD/3JFcMVNXDZ4u4EOkQ81tW/HeHyzg7Gh70GN4IPWWoRpvHZ/Xw
	 um/z5OxPyr0B1fimm48ciyv3pTPRC8HwMovHRZgZqFc9bKEnxNgQKOQpj4p4I7b/up
	 dSGApypCGttvYQTOoD29ahhwHBSLqxsaBtH2lsRrfXOytWDmpIxtVXRNiLMP9XUJOR
	 GYXeZHnq7/Zjw==
Message-ID: <sashiko-outbox-185335@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] apparmor: handle diff-encoded states in leftmatch_fb()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261026133600.11252-1-invarianztheorem@posteo.com>
References: <20261026133600.11252-1-invarianztheorem@posteo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 13:45:46 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> leftmatch_fb(), used by aa_dfa_leftmatch() and therefore by find_attach()
> to match profile attachments, open-codes the DFA transition and treats the
> default transition as final:
>=20
> 	if (check[pos] =3D=3D state)
> 		state =3D next[pos];
> 	else
> 		state =3D def[state];
>=20
> For a state flagged MATCH_FLAG_DIFF_ENCODE the default state must instead
> be tried again with the same input character, which is what match_char()
> does for every other matcher. apparmor_parser emits differentially encoded
> DFAs by default when the kernel advertises policy/diff_encode, so larger
> attachment patterns end in a non-accepting state and the exec silently
> stays unconfined. No conflict is detected, so nothing is audited.
> [ ... ]
> Fixes: 21f606610502 ("apparmor: improve overlapping domain attachment res=
olution")
> Cc: stable@vger.kernel.org
> Link: https://gitlab.com/apparmor/apparmor-kernel/-/issues/8
> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2172229
> Signed-off-by: Patrick Gr=C3=B6ssing <invarianztheorem@posteo.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026133600.1125=
2-1-invarianztheorem@posteo.com?part=3D1

