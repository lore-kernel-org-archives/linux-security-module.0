Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890467;
	b=kTf7TUg+mQuJc+6idFHtRZQQWlldqo10CGsBQ7OX3jfrP+QNHVUYu6vCqSOefDi862EL
	 Sw/qBQ4hXyVmMAo0nH3s93fFnllJc1/0L9QWC0c300ZlCQlNoYackShqMa/8efkiqY2hz
	 5EF3C7irLSOybqFJSWCi6SksXDbB7g6h3CfiC7UT+vQgcwQyTepJOTNj2V941iit35/eW
	 JIc2p6az6wOtp8Wft3P1EVoBT/KV0tDTDz0hgTx4uLnmSGHOmmh4vaL92h6I5tUhKIW3M
	 x3irkNAxnb6BwHb8p8F3CN5AsKLMvPLmgrHLxFvbcMcMzliansamzYYz2Mud6vd6k7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890467;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iU9sJ+Teqfu+eSfuxlcUCOIwDlxMXVaLRAn3IV+X9pE=;
	b=OynTF2O63Q0o3r6/08Kyt1CBvYZmsBO/HnY4mQFawU8dL71J9YHWzcDdvZPAfeEXMdZ2
	 +lr9wk5Fg5+7t+vXDkONAonb1r90DSmrw4CfhSBK2X9EsD+5faR9GaJ732TmB0vcRWKld
	 R9m2IazHvuWfhl27ghPxA/15ptzKyyd2ZcA5YsVB80IgD53zBD5K2oWk3FLNeO5Z/WJ2a
	 nFezmIXjde93q4wrAeuEfpJtpuKN4DXaLVJqHsBi5JiTDnuaEkwckqZoDJV+w73r8Q3nA
	 VckGoKsLeP5Seg9HPXBkv0aJ2FLZAbNtWA0rOzI4njMfSI5LuhJ19Q0cl9HxMi2exiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="g9r/TNHW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A53F606A329
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9r/TNHW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1BA1F000C1
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 14:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793890466;
	bh=iU9sJ+Teqfu+eSfuxlcUCOIwDlxMXVaLRAn3IV+X9pE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=g9r/TNHWIa+JpuEdwJ1KmziVrpuFiTm2IORXhDr2vL7NtgWesMzci5LQ5C5RJlfeF
	 MHbdbBY0QieVO3GMevs4PaL1ziG6oA+YGmbT5YyCmGCGlKfi7oDwVJuL4NBR77TfjW
	 TlkUEs256VBCIDhli5rLlXDJrGDTptx1FHTSuMkWSYbsjsIWOv4D+CA7vPlVj22oxK
	 HonyqzIx+6a21OTnh+Q2KpPpgARQIasmAiZjWjaOvkqNnJw/F198HTYq/rbtn8ldVh
	 +JbEAkhAcWvbMdaircmuvfMB9zX77wpHhRDe2iIqC80Phng9QeQdepLyiDPmMfi8Le
	 MQrrzanj0qpBg==
Message-ID: <sashiko-outbox-199272@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 8/9] keys/trusted_keys: enable PKWM wrapping key
 selection by label
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261105144320.357260-9-ssrish@linux.ibm.com>
References: <20261105144320.357260-1-ssrish@linux.ibm.com>
 <20261105144320.357260-9-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 14:54:26 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The PKWM trusted source currently uses the default wrapping key for all
> seal and unseal operations. However, PKWM supports multiple wrapping keys,
> enabling better isolation between trusted keys.
>=20
> Allow users to provide an active wrapping key of their choice created
> through sysfs when sealing trusted keys through a new wrapping_key=3D<lab=
el>
> option. If no label is specified, the default wrapping key is used for
> sealing.
>=20
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105144320.3572=
60-1-ssrish@linux.ibm.com?part=3D8

