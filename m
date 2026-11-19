Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795085175;
	b=V+AR2PyacUeDaPjF/dyYn9/b1a0p4lR5teoUsEa1i+TjFyZo4SRfSdd5BIcoXCLz4+qw
	 rE9A9/S30BIkiIIzrbeyqRrFTT90sNSG2Xzxx2e9lFrkJF2n4CL2d9Hoa+nUrxtbmGtOS
	 wcP7wTX27KQM8u6Shq089b7mSUIf09r49T6Ixu9sbRmhd5o3O9LcJbfwNbicY+5j3nlsq
	 BOtM0/SoVRXdWaZoLiMwYeH+T6aD40OguQT5bbelYPK5hgeCyJSrv9fKHlPirYrRGDnlZ
	 CnbhkRAh/+F1+B5k9WQ5sy7Z63lYSBfL1y1qBLv5N6re2Z5adCwY8vyOPRmPS8YxyaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795085175;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yqAAUfEGP6WZkY3D3/PIZF0AkhpXcmGmbOmiTiNSAC4=;
	b=jZR1aAPtJeKhsHrvjj2+hp1xjZSCbc6RgZqDxmRFuHDtp68y9+pxnMAPyCak8WhdBDQU
	 k1/wNDpYSjbhpiDq2weDUzjI/Bp3g9JDyVgj8MPzE3kDkQLNBdEb573DnEqQhvrcMQJDy
	 b/8jPcehozSwL5OYcVFaH1dUA5897XZk+0VlRZddTpJXamb3Ch2wGELPuluCyVxlCMB0h
	 jdO0nBqsS78rjqKq1SjvcyXDjcTYZ0APCe0AF1lclXtVt9FZc+uoDTmUksZcUxuoBps+o
	 lYUDuWS+U/ysgGhmLpqa67oQhpGXdgCoGlhgWw7A3ho2gvbl74XGLtP8koH98qgU+jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JoHMWyTz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBAC606A325
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JoHMWyTz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCAB1F000C6
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 10:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795085174;
	bh=yqAAUfEGP6WZkY3D3/PIZF0AkhpXcmGmbOmiTiNSAC4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=JoHMWyTzyThvqnfPeUrgAOrM4T8QoT5JMxwlUoPUNDRgbHmv/V+gfiSbx0jALTMm7
	 xEu0P7Saro/CffvdFTylK1agiVV746fK2KdhbfWyg+O7WiltUQnYA2+setSfqEhulR
	 U9LX6IQkf8QQ2fpeU+0uJw9JaNFy/0u5uKAQ9d1s03gnWJQScm0IytkDGMdvALU57q
	 028GRYfqih0g2C8MFxizQeGIyNOtQ0ygwAjDV12Wgq2QnInmFMjQr9GnqzHEfTRdq6
	 3KeAPbz6vMGb6KPufPC1cIXzE/GH84VvBHxix1mwhpbpK6mvcGdKjROZjZ4nLhySzs
	 5hQLhBM5ZyPtw==
Message-ID: <sashiko-outbox-222981@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] proc: expose userns capability mask as CapUns in
 /proc/<pid>/status
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261119104208.782900-4-halg@google.com>
References: <20261119104208.782900-1-halg@google.com>
 <20261119104208.782900-4-halg@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 10:46:14 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Render cred->cap_userns as CapUns in /proc/<pid>/status alongside other
> capability masks, allowing userspace tools to inspect a task's userns
> capability mask directly.
>=20
> Document the new field in Documentation/filesystems/proc.rst.
>=20
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Hallgrimur H. Gunnarsson <halg@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119104208.7829=
00-1-halg@google.com?part=3D3

