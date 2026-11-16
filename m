Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822735;
	b=IbmQEwK4QmqEfXEgUkxAv0sbYPW8skybKVXdCIRQNvTDXsO1mrC1ONBDgc7NyCT1sOpc
	 TZmwuVGcz2Bx/YHMx7ao9Re+wo+mMcnxbaW+fluZGuKxze2JqAKHyYXXb52N7HePSDJZL
	 5OJvmq6oemTXGefqB4/GaWN6KsLbjc1pNweq+VW8/vkNz/89vNkOHoFmXskRTNNUF4g7u
	 Zm+8Xj69icn0J0YO8gU7eFcib3BiOPi+OyAeHbsGGkle341uXTRXDOcue+GLszXs1t8NF
	 d5cWr9mmkuTyaCu8OPU3KeTXHRxKsFjUDbyQKWChsLmxFC812eHbsleoLNjcNDKE13w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822735;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IL07gNazwx6XSIK2EbUbjGio0kUPd8wy1npjGCE6I6Y=;
	b=YlbIcLFYiwL0SXSLqm7h/icx6YBqX+RPMfn1sRC7eZ4YfQmrQlYpzk25EqjZvcQvelr/
	 R4XhAL2m2/rKeG12ywAdv0hSZu79zoyXmFDjlNrTDVjE0wl0Tqq23D4BhTx2ycmWImvdr
	 1dkk4uSWwu/eC1x57TiPWzNX8PDKj4KIIl1TCj48DucicWsZl5WKrUhQO2wGWUFP8KFH9
	 Ku4OC/uRzPcLBW5NsoRwvREOp6bVfEk0Xm+Z06621sAoYbI3b7w43C20X88CyUtUtMW4f
	 fYr5CTvmvstNh/Rtu7+w1+OIHQ8IF6Grr8Vs4AkzYt7R+e/miJSXlVa/43Rm82C1aiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cPmZ5dxN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C289E606A33F
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cPmZ5dxN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569D91F000C5
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822735;
	bh=IL07gNazwx6XSIK2EbUbjGio0kUPd8wy1npjGCE6I6Y=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=cPmZ5dxNAUry5rMIaIBRxAHfrLo0RqKh5uH11hrKopmInxeMOUO7FdyVNJZvciZ7f
	 7y+NO2ajeqOHlit1kKH6O8fzk+bAPqOFIP22wdyWqnutGqQrQQKs9ssL+cUBataHpL
	 gRrzABiWxFzUV9gu72lf5DxM7FhsE/jHfA50OpGEQN1H4RIFtTj+bMi3lU81qFw+ZP
	 /HH5/WB6oeOTXqlDiSR7c6yJcuab/94q9ZbBIjIV3nisC7fmhLyiOM5PRIF3IEs6KJ
	 dGYA2MzUhZ4muvvYR3TZmtF2Tf5i4DZWp5EtryF+DKQVz4gbkpPDx4PkNANo6AWqoh
	 Mqytg4o6B9lWg==
Message-ID: <sashiko-outbox-216656@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/13] ima,evm: use d_real_metadata_inode()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261116-work-ovl-d_real-v2-7-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
 <20261116-work-ovl-d_real-v2-7-90564c4ae347@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:52:14 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> d_real() is about to be able to fail. D_REAL_METADATA never has to look
> anything up but we don't want to promise that it never fails. So switch
> the open-coded d_inode(d_real(..., D_REAL_METADATA)) in
> process_measurement() and evm_calc_hmac_or_hash() over to
> d_real_metadata_inode() and deal with errors.
>=20
> evm_calc_hmac_or_hash() returns the error so EVM fails to verify the
> metadata. process_measurement() passes the error on to
> evm_metadata_changed() which treats it like changed metadata and resets
> the EVM status. That is needed as evm_verify_hmac() would otherwise hand
> out a cached INTEGRITY_PASS without looking at the metadata again.
>=20
> This is a no-op as long as overlayfs can't fail D_REAL_METADATA.
>=20
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/all/CAOQ4uxjoHbevvu8auB4m8AVcY9H6uHdDAP6mfi=
9OOMh+3775xA@mail.gmail.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-ovl-d=
_real-v2-0-90564c4ae347@kernel.org?part=3D7

