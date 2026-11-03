Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692461;
	b=ARataIkWY/UYIFwnkIBhXJn+VrDr1D+fz6jrcScqXbnimf2rKRlholkEzCfHBaZTjDTI
	 6cWMcT6hrUk/mgHGIdkiEsxS4UmS5bJgZqBTXPufnblCF8klKMKXWoy0BHne0BPPTFxc6
	 cNjuZTW8KfWZvFLV+05i2U/Go16N+2H39icSQ6wDlK/0To2TAeLdWmaZA5haoYGpy045V
	 Ds9xKQPqumUPBjMNF4A1tA19gRnn6ZYBVM8xytSQD4X/Yk5k3Xe70PgtakJvnULnbd6ZD
	 8kgWLujav0TL3yOYW6D8jq+c1DDyTuJ0gHCUAEubOgzVSXJlrv4RsGl2GteAUikYWNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692461;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K1/NH70T1amKeITK2854wx59b5oeFuKPXdNyQS2ueHA=;
	b=vsFEiSFmLevh9tf8K76u1tdUKobavy050YJhZdBLOzQy3ukYeSySB62XXITr6Lmd4f7l
	 bp11o+/sXv+92eaoq84Ho4otMuN7YBcwc4DA7FbISZnB/8woreyV2qk8rdKQz5es1k18U
	 LGMVyKTb+ThwQONAdRzaq5CALRwRl3NCKyHWL03vKMZfSB7dXZWX5dRBauuDWY37nQchx
	 rWW3WXQ+J8ssdgRL2xBAO2QRT8XzjSS9I0gjx+HSDpbdfL79VmeMl7ouOmh0ir7B+AJNH
	 eKqDZEwAh+O/eQR+AcRySBNtQib67qrgu8cMFJKsW1fEcvc37CU4jlz1TEAXD1ks31Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJ+FEJU2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9D5606A331
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 07:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJ+FEJU2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB2A1F0093A
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 07:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793692461;
	bh=K1/NH70T1amKeITK2854wx59b5oeFuKPXdNyQS2ueHA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=WJ+FEJU2epaQ5uBjKSPZs2rjV5jq7W4gix1evZd1fEif2JMubWVwETI7t/wOxrJrY
	 y3fRII2XiiqI2zVi4giDkpnmgGduWk5KFncf2qjCm2cdsU7+mDgXIK/EreQc1xM+Hp
	 xK+j89MO6MIn20+R8C75fLDfU5sXVEMg5uxjhY/VGf4A/P5P/1771vjt4sWIUskdWc
	 AwICd5gvRMPSEoBKI4ta7xnKKeHjA1W7gVwGa5As0wWdkfSk933o/1nmjnArNDBTfk
	 AZJnFmEG09GfzX7EHsRiwaEtlWnDzYfN8297W1ZoVgRbTIB/zXzaNq4wId7b0CSK/6
	 Eoxh3cPsi0zkQ==
Message-ID: <sashiko-outbox-194761@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next 3/9] lockdown: bound the status string with
 scnprintf
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261103082421.3033195-4-caixinchen1@huawei.com>
References: <20261103082421.3033195-1-caixinchen1@huawei.com>
 <20261103082421.3033195-4-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 07:54:20 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Use scnprintf() instead of sprintf() when composing the lockdown status
> string in lockdown_read().  The current set of levels fits well within the
> 80 byte buffer, but sprintf() provides no protection if more or longer
> labels are added later.  scnprintf() makes the buffer bounds explicit.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103082421.3033=
195-1-caixinchen1@huawei.com?part=3D3

