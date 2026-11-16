Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822802;
	b=TK6kHXdmPd01/ShtsrAjGlOdk1NNOgGZhMugFI0RPoXLMnmzC4lE8AlE+9uHGjetbUo2
	 j/jmzWwsd95TbKCKmt95ZSto+2USCTqjHR8KjNh6RKPctuySqZWWpOBgV+jHaOubam/Zw
	 ShoKG+3y6xSJ0RoBpiV002Ay+hTp1FG3QCbFnyfn/naf4Xf182rd4lKyP0vT8YmnK73fq
	 Q2INw6ahDVAX6MzK/kMTvP+PAYcI0rro2YZ5S/dyWlkfnBDtG6klKvfoISadL7k2etuXp
	 Gu5AlT5PQf/sny0fxXv+BJgB1sEThKoBYmbGDPF8+OgRpTOzJt+Vbnpq4tgdHaIijPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822802;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XWuPHZZNQLyzrbhIYN0oISdy9fQIaoRVJT+F9g9FlGs=;
	b=Am+7WyCVZGccyFLdvvo7FIG1ilcND+QIrq+QYUMfmS4rayPFhCKsZXMJKvHdU+uzfGQb
	 asCtOtEwD70bPpByYu6/lr2NKUKwEyBhsgoP0xThxcC0MG2F6xgnXESzQZhPmX7hyPStN
	 mgkThT0d+ux9SqfEFcKqxHqVZUMeQUd0nYalHSeA1VtAZooa0d1749k2SAODTOX0+F7ib
	 hjR0yv3s9JSRjorB61uv5bpONxa7tdYCwDrxT6oLu6ir6Z78GLn/N/Qu8z5WE0OMryXgi
	 udDR0dZjmrifQrPIW/BhHLM2vQsVyRphbA9dBXkkzft1ZdFu1chs1u+XRSrPYqtI5+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GKT1+TmS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591F7606A323
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GKT1+TmS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1674D1F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822802;
	bh=XWuPHZZNQLyzrbhIYN0oISdy9fQIaoRVJT+F9g9FlGs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=GKT1+TmS41X80BfZWI8ZJO+BDo8hPM/ZnjpgcM8O/0RMeYKCNTFp1xg7fCryWgfhj
	 /i9vz1+FqAVJYaKH4PsGhVHWXRTx8rz6uURwX/Wbxsh5InxjNuZwyaWX1vWuCz4BAG
	 skCtvijYYML2X7xUCMasMBWHlykbFVBrk3dWn1mzePJvH7J40CLHy3U1LHFIz/gYBa
	 ThhgR1KVlQVtpSF5bsRtaGqErFTOXuk1uK3NK3vLXFWBLR/80P+ZNiakvVq0tyY0f8
	 dh6B8G1i8FP6L7DcdJqVRYUwrc9KdkdbE7mlHG9k+bEXzXIMOpMK5TnIdry559s+Pq
	 CKgR0nIup08iw==
Message-ID: <sashiko-outbox-216662@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/13] selftests/ftrace: add uprobe tests on
 overlayfs
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261116-work-ovl-d_real-v2-12-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
 <20261116-work-ovl-d_real-v2-12-90564c4ae347@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:53:21 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Add uprobe tests on overlayfs with a data-only layer:
>=20
> - a metacopy file whose redirect points at nothing: creating the probe
>   fails, the error log has the new message and nothing gets tainted by a
>   WARN
>=20
> - a metacopy file whose data lives in the data-only layer: the data is
>   looked up when the probe is created and the probe hits when the file
>   is executed
>=20
> None of the existing tests puts a uprobe on overlayfs.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-ovl-d=
_real-v2-0-90564c4ae347@kernel.org?part=3D12

