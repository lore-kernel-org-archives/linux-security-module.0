Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793234267;
	b=POwZh8GTqemOBK+UWBRenWt28QTBJsTCBhj6nmOHdkG7QWcYBpT8VAislJQNynoUDq+Q
	 L8lnlKDByvM3tYscMs4GtmX7suYLuJauvm4jo/a8rJuSzRCYxcrmCjSczglgUXAVi0nfG
	 p+Bvz2CaXUr6xyxahendbMOg58M1f91d+Maj2dYXq2+eea3Vq9QYaPdHM2Jmt7R1mQrfj
	 RzQTMeyAUWJulVxHksoSBsQL2vguLP+NPmVvSfAvmF6pNLIK25mndwKUzYNjkh4Q/qHyr
	 rqjGBvMQ5HHXtmpRmhdDFdylTXPDBzaRvWuUB4PXtAkOK+huN+WQ6jfsKsuqsEipNRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793234267;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9v8pHQQjQUxQKmm0Gh73y9yEG8+GYEbFs0vOjTkOk8k=;
	b=otuJfKCpkSa4vr+LuoVEDSfkUo4Nsgci3TgNxmOv16cb8+oIshrkJYgKKvURnb4SpiIA
	 0KtVbyrL5ePj8pgcZeSbLmMxZklHcbnPLIHDBTKuIWocC3cv63t30n7grteZJvNg0auRL
	 zSdGu6e4dpQrQTJ42gOb3nf31FCiUTpZE5L2YoKjA814bBLVe6zNpm/26F6f0O3RZzW+s
	 dUQqjAXwlZtTC14CiSvsPDRchdyw4neGwyYPLeNPs5olIiiIfrYv6t78Wd6N8fRwDObbX
	 dBf14T6JJPVHKjQAQjyKSHsJUI6pXRPf0mrEpNuDI3IevF3y5iGA4DXlUFO9ugsxckQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QoSC0hLV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296C4606A31A
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 00:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QoSC0hLV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065A81F01825;
	Thu, 29 Oct 2026 00:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793234266;
	bh=9v8pHQQjQUxQKmm0Gh73y9yEG8+GYEbFs0vOjTkOk8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QoSC0hLVO4n1WW9gRRdcU3hKQVaNefG/PlFyjeDS2BlH+XwuTxgGgcQGjtlzbV3aW
	 fbeBsCGhLZUgYT5ikgKoSvXAIeEVu3F9K7jYY/RP8Vu7TZhxK3xnJ0nOGHNTr3x033
	 rIx6tErnZOvdnLfG2P7XOLa1rQDN36uNgNENg/3sgEE/g196HX0b3awNJlYVlZ8jxH
	 9xE5vPL306rliyBEWROXGeVDTSvSPifHKTnJoydP1RBPLapA1jHJVhYD0fi4SBHBQF
	 ak4y+0HGW+HvjlW657X2Y6ybNiEyIneCS1T0h5g7P/gll/BssVcXDhkDhF7gIbXMeT
	 ToDqq4DtclpGA==
Message-ID: <sashiko-outbox-188573@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] Documentation: ipe: document the IPE keyring
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manuel Huber" <manuelh@nvidia.com>, "Fan Wu" <wufan@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>, "Andrew Halaney" <andrew@amutable.com>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Luca Boccassi" <luca.boccassi@gmail.com>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, linux-security-module@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261029-b4-ipe-keyring-rfc-v2-3-77727b205844@nvidia.com>
References: <20261029-b4-ipe-keyring-rfc-v2-0-77727b205844@nvidia.com>
 <20261029-b4-ipe-keyring-rfc-v2-3-77727b205844@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 00:37:45 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> From: Manuel Huber <manuelh@nvidia.com>
>=20
> Document the .ipe policy-verification keyring with its additive use
> after the existing trust sources and the userspace's role in
> sustaining trust. Mention requirements for maintaining policy trust
> in kexec scenarios.
>=20
> Signed-off-by: Manuel Huber <manuelh@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-b4-ipe-key=
ring-rfc-v2-0-77727b205844@nvidia.com?part=3D3

