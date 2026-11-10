Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315721;
	b=Qn5f9hzp9Uaiik7vsiYDaQIgOXia1pgv1wJFUWbQmsOT3IWKWg/TWqz5BgtnTsiMuoen
	 2Cy956dKohGtXGiNhnS1KNlTi8CTSkgTknvl/foRi/O9GN9HIVNT0zvnpjbe6kTc45TSy
	 mhPP93N7a/Ub33hMsrMyw6idxwLeVqu1RSaohf2X27S5GWdJQwh4g1bsA84zlckTjYrfO
	 XV25RxwADmxPR7z7m4W/I69GIu+1Ki+2Q0X/WnkkG4hsjw7wSghLs1e3sBHD9/G660QRy
	 +34q3rAIQOraGhGR0OMm/rOhlUuyjk7ryUm/rquI6+Ft5eot+B7OmJjoZJwudoDEUgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315721;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6YvXQTfjCaV2SE82+Rwoq6/4RnxucCRoJj5YeIROtf0=;
	b=rgmhUt6oVH4OeSTPDjTlRsnaUUX+aS3REat7cFBHesiRE6T8hajy9m6IuekULHwv/yDG
	 z2ScYPXmYjfGA6gLl6dAgRdw25lFeaGgnJArUOlXlgLh2ekk3TnpxMava/OfR98ekxj05
	 Y0k8JH2Ez+URlpzbtkKKFHvwelJtFCGI43JvffTrN1vB2Ee9xb8vAWblzAOEv+GMI/DNT
	 cBOpSo5LvFkRs7Z+YJ4EowQF9cz222wEwbCSL91tYClpPOfm2Nt+9us/cdW74355EVpC3
	 CYE0CH7hFgRz66l5aYVhOX/AsniqfjFldAlHzBht8UMKFgNJixfv28d/eOEdAeOrsCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hhm8zuwl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B97E606A7D6
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hhm8zuwl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DBE1F0089F
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 13:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315721;
	bh=6YvXQTfjCaV2SE82+Rwoq6/4RnxucCRoJj5YeIROtf0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Hhm8zuwlQVe7x7usQgfRHvt77SWZjp2xmF3T3Z7ObH6VtBMnn9wq4/J7Rq5q+JdK4
	 XucjpWSZuQBFov3a16IoA9/F8nuEao+Feh1RI5aCcpmOo/YkVcyeGitI7vPy9SRi8n
	 0Qm9Z+J9xvhxyDVv3qAt1sYjGRVXE6bUP4LOBghkY7++WWnjZFFDfED+T2yzXu7zUU
	 Ma2NksYYwLIdOt8i+un/eRlMdi7u6Tv3yg9nCc4mkc3jvZisa7HF0MnKnrOJrKTDrh
	 HOhS6CQZHzf9QAISCduecDARB+bHPVr5P/EP7LlheA59D6bzDJfF+OlrTukhKFP7jG
	 6iMtZTxPHlyuw==
Message-ID: <sashiko-outbox-207068@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next -v2 2/8] lockdown: remove useless decrement
 operation
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261110132818.2231593-3-caixinchen1@huawei.com>
References: <20261110132818.2231593-1-caixinchen1@huawei.com>
 <20261110132818.2231593-3-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 13:02:00 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> From: Kalevi Kolttonen <kalevi@kolttonen.fi>
>=20
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110132818.2231=
593-1-caixinchen1@huawei.com?part=3D2

