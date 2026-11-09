Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794202880;
	b=QpKSVc9FtV2C7sqT5WU5XkezrGhUu6jEozWCCmQ35prK/PMFeRvzM4+UL29HqAxif8UA
	 +WrFEi+EikdOBoTLao7Efx7E3qKSjmts+prZI4W3NFVGzxp9UblYeBEC/9V5mcTgM2YbB
	 3mipiHqEx9BSYwUBc7PQ/I2DoWtzZrAK7w9CZgRwvDz+6xBHCxtKsOG+9Ebvkv0VCH4dQ
	 lVaMj4Yqk4qhOL0wHf8wyd1HYLGBlEFMFVOztaIAEZ71HTXKvSiN8KirBYdmcPlFrlwBM
	 kfesxE3tGQi3SCgnSHvEP5UO58mv9bWkFfvW1dObX8MMBgAq37CQjIYUONuSV2czCog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202880;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gywrSrDEXrSvaldqfHkt9eRI4dlMAgUFPK2fNkSrlp4=;
	b=LiR5DgCqcRqDQEG5S050znYdA5bJcWFnaId464iFY4k4CgEmJQLjzEQTxWwzkDkxjuet
	 7DYj5wRsCUnoiv3E1iLIwWQI4yBRwUyhmfTx+onCFpB5MT6dPP693DzHsn6Wx/AvDjYB+
	 Jex8NhZkdqOyYeWXkOY0lGZepRgNr6uRELcEEYeRu0tOywstF4l47Is0iBXBgxcna2DzF
	 GBNtbhaIJCT8EiwyMOR4l+kjyHZIU4OzdqxF3N8Y7AGEwf90i6HY273nutaGbCNc/5cIF
	 rhY6V1+gFhpDIOR+fGJ/ua4o9WsguHGUeyIClFJxgr0Jyi8bO38G2RjvNcfD9GquzMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f9tGFdPQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0431606A331
	for <linux-security-module@vger.kernel.org>; Mon,  9 Nov 2026 05:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f9tGFdPQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEE51F0089F
	for <linux-security-module@vger.kernel.org>; Mon,  9 Nov 2026 05:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794202879;
	bh=gywrSrDEXrSvaldqfHkt9eRI4dlMAgUFPK2fNkSrlp4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=f9tGFdPQ4WEixpvgye1yrFbdYyhAVpHMd8QDZTifhT0zwiAPGRqiR8C0aTyLYQ1s9
	 L90dvGcIc2mjqHdlQz+8nIw8BIB9N9vrRsfuyKyVYugux2eLLGIdZ+sPeLivCdCKLx
	 0JenfEeCNNQyfJRaQZjQCAYu8zYqPdwp7DHgMkw0S8rD0W79ncGZJ1JOPqAZ4eUtMt
	 iWdL59hVfUHXV2nkQhzjxpDVmEdfGvCC9kA7cj00PKQTO41vEpMd96pASYyWpMezzo
	 MKegI7OeQDe972qMnEYKgFCHc6bhGg2fhWE8RsSABbX0AhBHXLxzg3k147sN0vH+xW
	 jaDCb172C0o8Q==
Message-ID: <sashiko-outbox-204451@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] keys/trusted/tpm2: rename "bool" to "boolean"
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <avFcjHwnh9mrOEnz@stanley.mountain>
References: <avFcjHwnh9mrOEnz@stanley.mountain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 05:41:19 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> In C23, "bool" is a keyword so rename this array from bool[] to boolean[]
> to avoid a conflict.
>=20
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/avFcjHwnh9mrOEnz@st=
anley.mountain?part=3D1

