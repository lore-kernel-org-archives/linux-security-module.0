Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168832;
	b=n0dKNvQ8XXMObtbNnvOY8m4FFLEsIA4kZdd2VHKMAhuek9pT4ZzzHbGG3x9BUagy6paw
	 /SyprhTu5xOzE+r5cvXM/J48wcH2vrC7teUE5aSoV2R6vOGfkFkGVCJ79ArmGbqhLeavK
	 auQZMhnInOpzqk3Lf5AL9KQCjjw/etSvnljDRA/brSFEjoOhWSrK5PiDYA7CBbgijkHmW
	 favS0ejc16ODarggXCwCX0ixiNvmsi5jFt5XiqbRtZbizDnW7XZwZTQZ3Ys+AJcrBddnp
	 VB1fNAKnxANY+x0VssmBXI5dAWiYJV2/eH//dtieTFsofNpJUqxUxT0G+x9yZ83RZyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168832;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=c10JNG4WYEsNSBalU2/oHfbcA0QYPYJnILasd5pjh/k=;
	b=xuuBdhb5zfC09yffaA6xwbugSWprBxPds+spbuooA7U7KbkKIxjcpk2zh/nIvH8N/a8O
	 VyDX5cuhg3CmF3uGus1dlT3utc6AHIxHgkqPH+wQmx9QvWNjKy+WQXUhYyqjKMZWIgx4c
	 qKTgDU50nCDRCyV+eIb+NKhB0xKsIJvfhfDbrexq9GXpCf7OowsagWOixeLupQ3yBip96
	 muBs98MtYEgV1A/zwwmURjfNQO+DwnyKIDOoNYKtewkZgavesyRMOzS0/BFHldNmL6x0F
	 pIlruQzhywgC09XpyPi+CwV7HLl1MJyAXm7cd0j2/hbobcz+vK2/oHeT6+cDr8CTgwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cVytyggf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA85606A325
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cVytyggf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9991F000CA
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 10:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795168832;
	bh=c10JNG4WYEsNSBalU2/oHfbcA0QYPYJnILasd5pjh/k=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=cVytyggfxjhYREVmWaZzkc5IPDlmkCg3suMHmh8Kp+Seea7kU1hQWeInCNgAdBs1c
	 BtgE0dsyuWI1PVcNkhKt8IhBLPwDCrURcGe217yii1ym+armt4mvIU5v7DjBqxK0EY
	 jK91xtbis2GJmAvpvYwRVfooVlH9+Kcuv6aHmuGjapCuXBR0xNcAR/zl499JGQw495
	 qJL4b0NtLJCkDf8INKTzV4BLr9R6dwvehRJyQJhtRJzXXsumoGw3j4hx/RTMIqXDNe
	 zLjYXzE+EgVxM5JQ58FfppoYCwJ8D7a0Wb66GIH57CZlJRs0JXtp8zQn2S7W9SgYuW
	 PRupY7xV9ELLA==
Message-ID: <sashiko-outbox-224901@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] security: Add hook for unresolved pathname
 opens
Reply-To: sashiko-reviews@lists.linux.dev
To: linux-security-module@vger.kernel.org
In-Reply-To: <20261120094820.11929-2-tasos.papagiannnis@gmail.com>
References: <20261120094820.11929-1-tasos.papagiannnis@gmail.com>
 <20261120094820.11929-2-tasos.papagiannnis@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 10:00:31 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Check the copied pathname against the selected base before traversal or
> file changes, including O_PATH and O_TMPFILE.
>=20
> Pass lookup flags so policy can request a referenced retry. Recheck the
> base after each restart and cover kernel opens with an explicit root.
>=20
> Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120094820.1192=
9-1-tasos.papagiannnis@gmail.com?part=3D1

