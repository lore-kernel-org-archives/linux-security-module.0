Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488833;
	b=S3z688sXNSc4M6QCYugK7yC7dIlgt0ovNGikIgDPyw+t4f1dyKFiY8T2msASybOq7skX
	 O0xuXjsXxHcZ74mxmssUpk6gkyy0tqEKs93DoyFh4zXQHVYcqMPvG5phbrVUoWWdPzU9S
	 jVglF2xmptEas/LS/XdcH241VM+27bC/tabc8WOTj5UfXc2eUlmeTuy4BcGG3jH+h+cop
	 LUOJacH1EPW5e+TfoNLJB8mWDqg/TbHxa98m3Ljn6ssymBWjTLiDaHb3QrviZ3IpAxvoM
	 fTulRG/zccZ83ihBegWnqLoXTx8n3Bk0lRFxeg5Mj1ln3EbrRPk5c6LG4ZD6ApeJsnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488833;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IzbLrr7LpII86auCWYhAT6Y6p+u1NQD5p3z/oEoSjdk=;
	b=gSv0KR6acnIsFcH/0CC+RpcLV2T1E5CBJhXnXxPLw0tHRj47IwGZuS3EmqmMoQ5fiGTS
	 b6KxlCuVlrkekeFCVjIcegB6n4KPNQFm1j4cqeZIGa8Tw1zpICSsn9DQC36oVJ7LsUlwF
	 SyJFiehqbC/bceYHmJ1Ymnwi06S2QV90bdvanGZ6XgoKC6OyHiYMQRbGDjLXcEQW7a3WS
	 eqGbw2GFGNIYJffqnuOyVckJpRzZkyWL6puVsf3Uhoe+0OahBXJ+p5zpSpshq5M5NnGHW
	 AimDnE0RPTAkm3g9/0KROQHNm0YvDq7KjsdyjRN6J8xQbKAizHJvUdjbu6K9nlRWf9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HfnNv/WL";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99DB606A31C
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HfnNv/WL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81F91F00A05;
	Thu, 12 Nov 2026 13:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794488833;
	bh=IzbLrr7LpII86auCWYhAT6Y6p+u1NQD5p3z/oEoSjdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HfnNv/WLp+DcMOfcuEHEHMATGGLebAUYiMpEZobW4NtyqVg0B80WjPbBqvAnFh/1b
	 41RN708d47oBtuV3ft2S9/DP117mqkrTaps52VSR0bP/B1aR0L0A52q7qGive+lyEj
	 Ituj9mcSUdMn18XEA9VcUmWn44TtvFcar/AVpSMM5RufX/YsLU0ijBKJZmtY38e7ib
	 oyC4DwC9V7NzKgZGxS6VR0Cd44+UGNs+YQzXuKjMZJG9O/zKLU7PgbgOnAdXra1Ec+
	 btHaEimtgxADC05Zzsu9DogiqrKLy/sVJrsBkZjEInI2D5+QheHwqlnVsrGwo5D2Ql
	 /Qi9XBWiImwAQ==
Message-ID: <sashiko-outbox-211138@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] ima: keep kexec dump state tied to installed
 image
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>
Cc: "Eric Snowberg" <eric.snowberg@oracle.com>, linux-security-module@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261112125246.2715174-4-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261112125246.2715174-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20261112125246.2715174-4-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 13:07:12 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> ima_add_kexec_buffer() updates the global measurement scratch buffer
> and segment size for the new image. If kexec_file_load() fails, the
> new image is freed but the scratch buffer and segment size remain. When
> kexec starts the installed image, ima_update_kexec_buffer() dumps the
> measurement list into the IMA segment. A larger failed segment causes an
> OOB write, while a smaller one truncates the log and reports the wrong
> size in the kexec_execute event. KASAN for instsance reports the OOB
> writes as:
>=20
>   BUG: KASAN: vmalloc-out-of-bounds in ima_update_kexec_buffer+0x265/0x280
>   Write of size 868426 at addr ffffc9000004e000 by task init/1
>   ...
>   __asan_memcpy+0x3b/0x60
>   ima_update_kexec_buffer+0x265/0x280
>=20
> Leave installed scratch state unchanged until all later load steps pass.
> Store new buffers in the candidate and reuse only equal-size installed
> buffers. Emit kexec_load before those steps with the local size.
> Allocation failure still omits the optional segment.
>=20
> Fixes: 9f0ec4b16f2b ("ima: kexec: move IMA log copy from kexec load to ex=
ecute")
> Cc: stable@vger.kernel.org
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112125246.2715=
174-2-Jeremy.Jean@oss.cyber.gouv.fr?part=3D2

