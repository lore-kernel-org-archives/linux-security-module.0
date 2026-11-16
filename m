Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822581;
	b=QG/A39Q01zwjvwF6OFBoayL1LX6SBWQNHlto4dt+vcYw7N0gyZvPr/AQ9tmHKEBAtUU+
	 k90hDaieNt8iJtKBf2a/aaytPqm55C349My5j1hg/v5ngd0b4E7xBxXeuRfaLbstv9XSf
	 pdm/l7KtRRrLW9X4K4DWZyF9EY2Ra4iDgCnXv7HRBghVsF3Ago7Gtwm6KyiS+iX9mjFmO
	 XtPOJjLMjE9EAwEAdwxTVSMrn144ReMuKAt90p0IKDi91stz4PmbgyKHJ81ITPVRKxtNg
	 JYSpOOVdaUTzfkCJ4DOWymXZnvfjhBH/Dy7Scj+0JvB8Cobth8UC0tDklCq8feJhfpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822581;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=roroe5MrSI7paymosllBXX92oUpN+b8QXB0JVbEaD28=;
	b=QSq/ISs6cL5iBheP+p6zWzDP25vQR7ZKkduTiIsY3cm5xNVahivlV1cA58F+R6MF47ZD
	 wqWxCxbKwE1I9/r77NbZk9VFasc2HKAaz49FlkNWrfyEfUWI8OTvpX4iD04c/7GPdvW+n
	 2ppiLOyh36ATOVVBh8gmpuM4JdlZl5U/tAjF2bPdKMebYHSFZ5a7/1z7hRjfl7h+UCPkY
	 0aMmKaHEaHLGHroauJnpQTkbScaSUXhuxcxOwFMLfu+nfxKn8gxX1raGE9lZXi3ek17yK
	 c2OZ4G6yiuJyQ8logaj1UoRbiBBb4up/02D1pF/dNXd/XcF3W5EeuwU2golHDqy+IQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oakoxyTF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E50D606A31C
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oakoxyTF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EC51F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822581;
	bh=roroe5MrSI7paymosllBXX92oUpN+b8QXB0JVbEaD28=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=oakoxyTFQDLapOtKoW+UTgRcn3RsEZJ9fwv5oglk2y5CW8MOb8I2gts8vP9ZwiL5J
	 6pYFyIrn9+itlgrjF9CieIJTy+yzUITsVUqNdQHaq8z5M5gk26Esl2dz8dWODKFpfv
	 /QaYFUY+PYFfLkoVRJsrnQBt9aL6lSztdxDh8BnT551X1Lwb6ppKRqiSQUd4rqZVu8
	 jSvNtrkb9wJepyi427uN9o0dfBEUTgCCgJPPK9FlsmR3K34nPJbYAPTptWIDGGxTcy
	 35SdKbaWAQLTiMjJXi52KnTKEweLLFgTGFIcnKpi1B6Qtn4uy7pXl4+6duPO18adg7
	 D1ittXNsqCxLA==
Message-ID: <sashiko-outbox-216644@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/13] ovl: don't warn when the lazy lowerdata lookup
 fails in ovl_d_real()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261116-work-ovl-d_real-v2-1-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
 <20261116-work-ovl-d_real-v2-1-90564c4ae347@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:49:40 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> ovl_d_real() looks up the data of a metacopy file in a data-only layer
> itself if nothing has done that yet. If that lookup fails it WARN()s and
> returns the overlayfs dentry.
>=20
> Commit 42dd69ae1af4 ("ovl: implement lazy lookup of lowerdata in
> data-only layers") assumed that the file would be read before
> trace_uprobe places a uprobe on it so the data would be there already.
>=20
> But nothing actually guarantees that. trace_uprobe takes the path from
> kern_path() and calls d_real_inode() on it when the event is created and
> again when it is enabled. So a uprobe on a metacopy file whose redirect
> points at nothing warns twice:
>=20
>   ovl_d_real(/f, 0): real dentry not found
>   WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210, CPU#2: sh/279
> [ ... ]
> Closes: https://lore.kernel.org/all/sashiko-outbox-214581@kernel.org
> Reported-by: Chris Down <chris@chrisdown.name>
> Closes: https://lore.kernel.org/all/20261114120557.4bc1eb6e57218cdc@chris=
down.name
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-ovl-d=
_real-v2-0-90564c4ae347@kernel.org?part=3D1

