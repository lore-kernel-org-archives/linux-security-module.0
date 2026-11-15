Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794751839;
	b=zK24wf2XggJNWOMNdxig2XCFY2KFPFFwcoI9pexnXDR4b+qR1+agmmxdPfu8lCjYjYQW
	 9c+XG2/aj49T5UIXahReEuyKLAY1kVV9thdd3ROWy2nt+D7HMTNiPvg3C2lKEXZLPLDtL
	 BjU3yRAe3EdFiTJpeSLlH843T0m3VklPFsMKDbTKMDxWIiq7utHvUAO20h0SKNlO72FJ4
	 nvt/i4o/FLS9dXNPF64CAvYHdTccRQ2HikDVwaqyccW5a9yTd7mgE1njSyFCC/01HdxE1
	 IIgiKsJouOPx8vC1ykQ3OgqPDizNY69feAfq4u119qUGlNU9WEqkjkJuJtxas1wRWuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794751839;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=98prZMxgQXkz88VoYmKYLS6/VWcmZ0d5vjilkwuTdn8=;
	b=ZeE9+Y14OoVCIFl3pVuiqCYCJcGwJFWYPBN312FTxR7kPJjakegdAEeO9u/7yTAebQqR
	 d0GOGljR9GK12frXxTvS6NI0JK6AzXd42YxTPJJzIwyuPFtLDRd6kS3tK27YWjTnr9IQc
	 ipWZsox/wEj0xMG6F7E2CpJvKEMUKTqMKGjKDpvkN7FB8N7kLTrsu3JzWbMjUT+WvMZYz
	 DmL6cX4eQJiEuim5PE+sQeiaDLZevDyw+iaI5txtpoMAFtTSZkj80Ts+/GBnH9wbQuGqA
	 48W4dgKcuNU+RlaSe+bjy8L5NAHuKPM904UpPxajy6WY6wL9vpWjZqqAJSg+BjRfU4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HwNqOqmO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2522A606A31D
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HwNqOqmO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25D11F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794751838;
	bh=98prZMxgQXkz88VoYmKYLS6/VWcmZ0d5vjilkwuTdn8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=HwNqOqmOn3FEnJT2c73JlagZDLXrD6O8qfXeLMI6ytokxa28OskVUfjkPr0AhaxgV
	 ROScpuesrmYpUddP6+YcGRhjnTU52HhW4uopFBOvH2MAbEwfW3zYvebP8KzDhu3wSi
	 r18Gt1IOeIfADog6vwFLCcg5ZLcT+Ecn+a/RJRwjDhlp1okgOC8He6Gy8ZKGsEBfHW
	 azkjGMUK2mO4tPaVr7pB6xOY4MHIzIQD6y0P/d3Q4/6/EX7AfjRk84uAfyUMJHneo+
	 nFOew1SleWejMrFsxzSq8sb8ITB/Ci3o0KkP0hBjQrnNc+ATxJCRsrcOO/1RLC3bTc
	 kwZo1j6AAVbKw==
Message-ID: <sashiko-outbox-215567@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/13] ima: handle errors from resolving the real inode
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261115-work-ovl-d_real-v1-6-ca155efbcb2e@kernel.org>
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org>
 <20261115-work-ovl-d_real-v1-6-ca155efbcb2e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 14:10:38 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> d_real() is about to be able to fail for D_REAL_DATA. So switch IMA
> from d_real_inode() to d_real_data_inode() and deal with the error.
>=20
> Currently, if overlayfs fails to resolve the data of a file it hands
> back the overlayfs inode. process_measurement() then sees
> real_inode =3D=3D inode, skips the detection of changes in the backing fi=
le
> and returns the cached verdict. That's the wrong default. With
> metacopy and verity this isn't limited to files nobody opened yet
> either. A metadata-only copy-up of an open file makes overlayfs validate
> the verity digest of the data again on the next D_REAL_DATA lookup and
> that can fail.
>=20
> So if the inode hosting the data can't be resolved in
> process_measurement() we can't tell whether the data changed. Treat it
> like a change and clear IMA_DONE_MASK and measured_pcrs so the file is
> evaluated again. The metadata check for EVM stays independent of that.
>=20
> This is a no-op until d_real() can actually fail.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-work-ovl-d=
_real-v1-0-ca155efbcb2e@kernel.org?part=3D6

