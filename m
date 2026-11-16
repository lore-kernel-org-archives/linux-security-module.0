Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822808;
	b=xPYLiJnL7xTIU3WgrKJfuvvW5FjjyyXEQxC7zQNIVtR9kxkWxJo0ZTHaBOkZy4abS8QY
	 MeGPRRE4SPyjyXL+Ugz/uBXsyUxiDX28Y1uqBvdJXf6uJTAQbu+tZVMnTabgzoD1J0HGd
	 56qp+ZA0lH54jcMfEqlxEs53EjGDOsH28iSPuJJmG3bLjiAiefnOcDL7v+ebXs16PPa+x
	 0B0j4hgb+rAP0VM+/cuHT9eN0EYM/E5LWbY9buOf3AVRcy8Aej/RJhaoAAKZXuEMpsuOu
	 FC+IxMy04y4bTFEiqYQXWZT4r+2pmK89fmVMUIMU7l6HWTwvUSP1QUSz+SMAleaWmbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822808;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K1JzSDj/opZoezSpewlsMkP2lauZOACdJoJeNm4OZ8c=;
	b=0nMaOu60KlIqqfswAlKqxnmWr4RcCQHsD+R4g6lU7toXIbjFOpUiNye76+unubihg1if
	 9EFARGh0OUBGCsBPW9RFheaReg5Os0cLFTZu2P2rU+5Cp5jV9oQMq4JAngAcf7ZP8kqin
	 C/7WBDuZJ0BAeDdY5kRLYAQtIvhuDTAr0AkbmiQn6hKoXowiEqtg16OLYpZIyThCNZppp
	 ywVHeW44n4qJ/x384h/Rxvu7ZFhu6rcFBeQmigZtdy0ZbeEMwudwFrs/pm/cAqK5uFSrn
	 nz7a5ZfR5lBmx4bhFYYO4zGOSgknyJ5UlBCcTVPyCbC0AXwzQ4sLEOLVL0fQxwr9niQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="D5aO3eb/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524E5606A323
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5aO3eb/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5861F000CA
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822807;
	bh=K1JzSDj/opZoezSpewlsMkP2lauZOACdJoJeNm4OZ8c=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=D5aO3eb/d8NnrlJNH2dxqjsMJPJG2G7JhtpB7VfrmhxTS8+ef+Z/kn07Me6tCEsDx
	 uapuCkNjWAi9ODu8lj55KZKMOxZ0U/n2YfWKhdyeAvEe93r5ZkpLephaaiPBBempsd
	 Bf0IIPZ1+odlEIN+0kw0diPNb0f7jYPvFt2/GWg26D4UTQDBnYGMOgwffO5hfnRw+F
	 BLTDGUpsOWga7CeOC0wC5wMrioFhnNXZ/0EdtvBBzMQ9bziUAh5HHgdcYEhNBQnxmF
	 mq19zzf0QxcIpeZlxjKg1bxImrRf6WJxHo9pHXbrk2tuRNeROy7fRNVKBSZOY7+V1g
	 5aEibAi52hiPg==
Message-ID: <sashiko-outbox-216663@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/13] selftests/bpf: add uprobe_multi test on
 overlayfs without data
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261116-work-ovl-d_real-v2-13-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
 <20261116-work-ovl-d_real-v2-13-90564c4ae347@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:53:27 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Add a uprobe_multi test that attaches to a metacopy file on overlayfs
> whose redirect into a data-only layer points at nothing:
>=20
> - the overlayfs is set up in a child in its own mount namespace
>=20
> - BPF_LINK_CREATE must fail with ENOENT from the lazy lowerdata lookup
>=20
> - skip if overlayfs with data-only layers isn't available
>=20
> Before d_real() could fail this got an EIO from uprobe_register().
>=20
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-ovl-d=
_real-v2-0-90564c4ae347@kernel.org?part=3D13

