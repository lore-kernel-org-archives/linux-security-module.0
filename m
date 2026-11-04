Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802562;
	b=gKZO3mXCK2+mLZGqa8994dy4OfSCi335kAzwGK8nwqsYmojpKKzCtZcBqXBrg+doJ/U7
	 0mFka3mrzqRKccCNf7Kh0VObGBz+ckgrL/SXtbqU9EH5nngdJBEum89sGpybuTOEmFmBn
	 q1eTA3bWwr5T1Bl+4Ua4Et/nr1FubthhWSI4us4IhayXNrwvGGvbQIuYq29baj2VCePza
	 WqTc1B16UuthJuBLcYHDGgQBuaUKOHBWdhWzpfac1URc2UcIeaX74F7KB29dbAmkDFPLO
	 X0xldlaJ89GnDnfaYoeEuoiaExTQ842qpIVWyqIKaPXLBZnqgWlJgICozATjEYbM96g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802562;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aGeZPPvzD3NDtht8vpD+NvblllnN0VChk65rqYgfs7s=;
	b=noCeKljnurjetLcl/ZrODHNGYxyWCXrdcUqR7nwxtUgrP39NavdDKMrHbQxgUCUH+fFd
	 GeKreWF0vxCgxi+NPYPGe5MqjvaHIRIPGZqXzxHSEAJQ+7MTN7FQFSAthloD1CVQOnG6f
	 YSoR1xgMPS+RPJ+aJoA8DRhb5pGxElzQ2pbOezRoto5CeiqdQd9ngQNOCsrJlo8p5LhvS
	 pGaWxo0GmQXKmfdc3pgKyl17DdFx0rTG3JN3n5Oss3zFuvuTTGrrKNUxU2j2TqQ6VxLhE
	 PuA0EAkZIaVUllNRay9NGvQ8k01L+hTtzPAUzwT0O5V/Yj3pRZHR1++LuzcNgJ2x/Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VeuiUWU2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0434606A326
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VeuiUWU2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4349F1F000C1
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793802561;
	bh=aGeZPPvzD3NDtht8vpD+NvblllnN0VChk65rqYgfs7s=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=VeuiUWU2YbtKiq0wYqwOvQ5f2e0mIHRqCr27eZ96+n3AkiJcrlqfX1eTLt6TfFOct
	 zxBxiRurvQEymL4jUoTXTo5tUbAy0atsp01LHDS0XYA8N7Ynzd1POeJkYtHLVnqd+q
	 u+S+LNBtmficfXLZzGYirXEnEhPXrOI7PQRwVBg3v8HDy2P1mCYIsaC9D0Ezy3sl4D
	 auyX6N445DofTXGegZEBhQkWgsN0cmU6o3GEEJfKYQH5q6GrDkqA1Lt1yiwhxMXpax
	 b8CVzGwEh2FhpZnLlIZH0c4K4/yhSIfBmxs9dVLBPbQLCUl04/dEm0MpvTAfIvaxsf
	 vLQ22gTqKAF6A==
Message-ID: <sashiko-outbox-197441@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/13] ptrace: use cred_ids_allow_control()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-b4-cred-ids-v2-12-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
 <20261104-b4-cred-ids-v2-12-956213608f16@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:29:20 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> __ptrace_may_access() picks the filesystem or the real uid and gid of the
> caller by its mode and wants them to be all three of the uids and gids of
> the target. Say which ids it is and use the library.
>=20
> No functional change.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-b4-cred-id=
s-v2-0-956213608f16@toxicpanda.com?part=3D12

