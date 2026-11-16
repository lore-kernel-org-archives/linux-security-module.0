Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822592;
	b=Yp6n/97Cz+VDxMRsg0sUyhRMayBL4LGGCmwkUswyc8PQfkp9SKv/ZQUzQrz5dk8K42DN
	 BHFAhPIEMGj4olbY9OlQm6NC7dPaPwZnmVbKmx+GAQmMTlOrN/mBjVKT0KyA4D4g/PIXS
	 VbgWGvBy3E8aTrZcDGZABV6SZShCGtluqPqmSrOA7qy8XYKpHutei7I2vbDyUlSrqgR+E
	 17YfMKUHKaUP8scrBgZeiqpIiU+BWHaEBGbQc/pYQYZqF2/R7HoTovicC0YFrJWpS4Qwq
	 b+Xa1wdkDbovU7j2ezpFU1QAqzIya5JgRDJR0pPSKhNEP1FKh/8/Jakkc/KH/ipKvVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822592;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vKBIKlx5mh7kuh197i0Y43oEFa252dTTuFZlIe14ybk=;
	b=TJSZlVV0xidWr9VQVEM22qor3Vo850nEVdwHggYiAJZMaJTNe6XtLvM1jO9yxLVhh7hp
	 j6AwkAs5GwM+pxE5J1oON0ctlNP4iGbXkJ2rc+xTP/Qg42ZEJHxvELpHEqSvEczQbIOwx
	 US+CYnwcZDZ8falHF22shCWUPAQ0GDoDUoYcC6SFLWXF08nzfNA6D4BKTnswpQCnMCF52
	 O77N06RyMNEheynGSZWQL1UcSqqkj7IRiFjHa0EsS0m9sNyi7KRVUPuPN5BI4doxVCWmV
	 DGA4nJgyvN1TKzNp7ARsYJzO64bXnGUHZpajMWGrl8X3t3AwhvSUecTjWcuIUoS7+2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HAecGfVf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71B5606A31C
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HAecGfVf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DD31F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822591;
	bh=vKBIKlx5mh7kuh197i0Y43oEFa252dTTuFZlIe14ybk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=HAecGfVf5lFtKybkVMl1h84bWeVVJdKJtGL8Fa7v//c1w5LDfDTi12A2Vo4vmugJ6
	 nM11z1zPJxmXEMRdO1JvQ+XOd2FUy+4gU5kJ5zbwwvbxxqOlIeLXGUarXvmVBkvdcu
	 IUPOx3K+Eyoal2bQ7QxhYBpS44IuzwNHGN4d/wRvt2a8zg6tDZF6OmNugvcRQLNVmv
	 PpaiJA3IIg384OqKk9tdz1B0YGXpsnQKj825CeX53FROUdVz0b3CHR5R+eDhKOnSGp
	 1naXnk0ybwWayqAQQcf8HKedRM/4vefQQXw+s/lifSNk5wjuzXnAyQ3Fo3WHnPFdeN
	 BITR1zFDQ8trA==
Message-ID: <sashiko-outbox-216645@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/13] bpf: handle errors from resolving the real
 inode in uprobe_multi
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261116-work-ovl-d_real-v2-4-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
 <20261116-work-ovl-d_real-v2-4-90564c4ae347@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:49:51 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> d_real() is about to be able to fail for D_REAL_DATA. So switch
> bpf_uprobe_multi_link_attach() from d_real_inode() to
> d_real_data_inode() and deal with the error.
>=20
> Currently, the real inode is resolved again for every single uprobe of
> the link. There's no point in doing that. Resolve it once right after
> the d_is_reg() check and fail BPF_LINK_CREATE with the error if the data
> of the file can't be resolved. Then all uprobes of the link are
> registered on the same inode.
>=20
> This is a no-op until d_real() can actually fail.
>=20
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-ovl-d=
_real-v2-0-90564c4ae347@kernel.org?part=3D4

