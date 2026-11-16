Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822821;
	b=A8K0lkDD1MKMYAWcX98mv0cQKG9iawm8btVjWvVQ/axHUPVcAfQNCrUyohl9nzFiU3Hk
	 uTucldFqSvaFd6YCDbAaOfv5iFjws8rk2jZ2j2XNV55WS51OFklO65pc5NX3fLVDpo/Xd
	 1snYIOVpjMY1cbvMoXIXTjXwipt1nlNBWd7W3Y5s8ALhqBia/GJP0cI/9R87bY9hokieL
	 55VBhJf6jR5Y95wfyqrmN+E5DuDIRiDkSKCQm07Ikrao5ZXuWzm458LhJAMTohXzHgA9n
	 UkfUC8fbNcB7cdn210paESK8zhqX9lz0EDZWSJqBLn0AK43aBoCluyLnRzdq1VC+eTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822821;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fIrRDOKg1oVzgYE48snlMIYIMACIUo6e7q7mtkoPmxU=;
	b=OfHsKx3sJttCOx6wCZ6bAu+ibwQCiKpgaCNihHQSb0X8enn5uLvjw5tMStleG9v+Gybf
	 996xFEEiqNWBWbfiSE7WRzI6fGZtrl6jmI9ko5MXEaBScxs9BvDTAJQVN09JNfo671DYr
	 Tuj+JeWKEaWCUr4vATDZTEOO5dpDUwlOcBZDWzj5ue+t+AZJ7pzpeKtWqzpsQNtuzRhx3
	 WEOY8flBJy5H8WUKsi8Q808JgXzo4RTi0aDIlds+A4QYSGVwVhEApg8isywy7orqD2hcx
	 es6y4Z/w1+zmnD7WwKLyiwl30yVwZlWkL6y+VNKcJWMsJif+Yorlq0K/ZWxnMHlZr5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+UOIYyc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5FF606A323
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+UOIYyc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD371F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822820;
	bh=fIrRDOKg1oVzgYE48snlMIYIMACIUo6e7q7mtkoPmxU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=g+UOIYyc2OhPYRIk0lPhtWXs3uEY9E/TiT7HdSR0HRHwwh/x/I/cL14eFeICJU2jp
	 XmH3mSWirqeZjUjmxKpuw8wauC1AhMchcoddPTIjT+8Q4yyVXRal0pBuwyYhBcuLqg
	 XFphVMA3uvyd5TnT56sePjL/zfSh2DkCyJg69zJX2lnDX/a//VD0Serl0645EDyZzw
	 wWohEdUD6SIwRScuFUSgW6AsCnC7mo8fK4qlkw26h8pj7v20bPTskJBLAw+/mNUGuY
	 wIQ/kL/xNeYq2UpvfGsBsXLMw0shT9RCo2Oy0CfiSySj6tW6c7z0dYUUzBHSS8ssyx
	 3ns6B8hJmtgew==
Message-ID: <sashiko-outbox-216665@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/13] ima: handle errors from resolving the real
 inode
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261116-work-ovl-d_real-v2-6-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
 <20261116-work-ovl-d_real-v2-6-90564c4ae347@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:53:40 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> d_real() is about to be able to fail for D_REAL_DATA. So switch IMA
> from d_real_inode() to d_real_data_inode() and deal with the error.
>=20
> Currently, if overlayfs fails to resolve the data of a file it hands
> back the overlayfs inode. process_measurement() then sees
> real_inode =3D=3D inode, skips the detection of changes in the backing fi=
le
> and returns the cached verdict. That's the wrong default. With
> metacopy and verity this isn't limited to files nobody opened yet
> either. A metadata-only copy-up of an open file makes overlayfs validate
> the verity digest of the data again on the next D_REAL_DATA lookup and
> that can fail.
>=20
> So if the inode hosting the data can't be resolved in
> process_measurement() we can't tell whether the data changed. Treat it
> like a change and clear IMA_DONE_MASK and measured_pcrs so the file is
> evaluated again. The metadata check for EVM stays independent of that.
>=20
> This is a no-op until d_real() can actually fail.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-ovl-d=
_real-v2-0-90564c4ae347@kernel.org?part=3D6

