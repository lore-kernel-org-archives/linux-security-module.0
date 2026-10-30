Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336027;
	b=YYsrzhYp0Fn79PUn5TCgzO7MNYQ+6qq+D7ilmvUHtCN2Y7PTIp+/81W6T9t3GOJqUXxu
	 5tPyEYaevsUGSe24U4PySrlDW1WO3k+uEfN7l7ftDG58Z4IipHS8e4Ha6uUh6hTyncQVl
	 iXBfDConYsgdbeOYlvDSq8U2JQJmcieCsaEdCE9qVFk8B7QMvO8syv/1oAwfXECMKMF6c
	 lbMZR5VfLImGcR+3al4CJOuocT26NMp6K1E4yUyfqiBBysHNicafAHkGfY43ySuUrVEb3
	 YOFMQ1goTMbyDsNglghJzZM5SoArVem6E/7fVSaIoft0IvjRBiDAY+qLoeN1STyxMoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336027;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q1FGUtHsqBFgI8eA29Pi6in7+klQCz2JDZvO8BbEQ1M=;
	b=Xkr3C/vHv0bpVj1/ecEJWT04D5e2noh1iKMLnab8HBtGeguMarxg+NTurtN5Gzn863jD
	 /O5OPVlWW9usRMwvGFOaFaatJablckBU1IxgZB0DkiUb2AGI7C4XGX7E6Ur25NvLT3wE4
	 7CJnG9iH/9oWPvut6DODbylrKWDvaqA+YX1n3Eu6zW3jo5PI0z5PXVTRGmpMC1lN0e5Mk
	 NAimeYQpQs6KdZszz533ucPC6/Qfc+h3cxc8f4oCpeyzlqIqC6xpdYG5IyvPn2Yw8u7f2
	 4j1CZgvZPbe9cBwMTAsK04+RicdU0fLvDLrSYA9oZbCw0V9WVob5bPwJhFGE9pTKL7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgYcT68O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF9E606A31C
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 04:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgYcT68O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C5F1F000C1
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 04:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793336026;
	bh=q1FGUtHsqBFgI8eA29Pi6in7+klQCz2JDZvO8BbEQ1M=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=jgYcT68OsYdlE4NkpQhPp6/YCS+p5glsPXqhN4/Wyt0M2ZKDM8dLjFsQfOUaSzEJ7
	 HLeI9MFxpEEtgvAJyxFQeyU7EVuqi8It28TAzzLgTCv3tqfLmOsOW3IoK1T8+7Dpka
	 FmwDSbBMoxHE9gGmtBWtPpYPdPvV4/hiOeU0F9zbUtKFrt+nXFhdYTpKhCl7OCBnTt
	 0VBMFSSuj20upDQ6jWNJFlhBmkxDGsFadMaxKn/2cmSPY/IaoeLR2s2ML70oqYTzlh
	 qeBpfT1ry5JM7wlL5difO/53yAMzf5N8CnpG1tjmHLgHBuU9WSmq7uWqKqAIWNt/Ti
	 GOEohdFbB8dfg==
Message-ID: <sashiko-outbox-190349@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/7] landlock: Add UDP bind() access control
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260502124306.3975990-2-matthieu@buffet.re>
References: <20260502124306.3975990-2-matthieu@buffet.re>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:53:45 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Add support for a first fine-grained UDP access right.
> LANDLOCK_ACCESS_NET_BIND_UDP controls the ability to set the local port
> of a UDP socket (via bind()). It will be useful for servers (to start
> receiving datagrams), and for some clients that need to use a specific
> source port (e.g. mDNS requires to use port 5353)
>=20
> For obvious performance concerns, access control is only enforced when
> configuring sockets, not when using them for common send/recv
> operations.
>=20
> Bump ABI to allow userspace to detect and use this new right.
>=20
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502124306.3975=
990-1-matthieu@buffet.re?part=3D1

