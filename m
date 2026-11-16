Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822704;
	b=ooSdTDr0HQDSVX9vafWD+3/kO7n+hsIDNWv4qZ2w2/VbcZ1mluX/rx/lfWPEoHxYpF30
	 Wy9PxeblIrQ8IMzucLe6YdgfGRl68j54t/tZBpEAIcitjtl668tDlvwQYRiP++yEdUx/r
	 +G4a/vpeT2iJ5C/pjnTTAHmP8F68cl5CWaAUMr7Cebc2UbgMqgeZ9aWA7QUHzpyyvl9wq
	 Pgx5rZbEyUOJdZzHOwczxDC7EJpAEBXkpPZ9QToJXuqlEKz2lrNPgAADU7Av2csjp2Ghi
	 j2Oz70wbMUMIq2XNW5HP2STuiH6ug4z8ZgQeIiYYR829qtlS4LRRVQ71DqZjgPyeJMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822704;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DPp8BHbVoxJNXV6wy0QduajVDf2vIYiN8qlvKZrTXWg=;
	b=uFVtnfELq2uCyh74ctVo34xe84ZdkiQSuTYNO3rcGj1vPdosdJ4TE0lxwpvLzp5BeeLl
	 HMg5REs9bpqut3hKFs51neTGlShhdeV15deBBpyIiZZfWVk1ncqH7urzOE5VCDLFAyOAo
	 +EK/XzMOWhZh2T4dSPKf7IIF9RB5CIDyislqT7p3fYTnNDD13AOKgj8OMG8cxJF4Bklg7
	 GIT2bWAKamuhHLJ1hl71k/09YvMihLy+ZeuoSv4lz5/tq/HoaKBfPxcVJ0YZ3+3E+eoiM
	 orqZhi7Vg29jHn8JnHAGAN25/AMP/ZIbKVHlHaMyNvYOas3JnRVecl6cufd9/yhkN1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+BfqZ22;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3CF606A885
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+BfqZ22
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123651F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822704;
	bh=DPp8BHbVoxJNXV6wy0QduajVDf2vIYiN8qlvKZrTXWg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=H+BfqZ22Iz9699rOjtQ53RJkZuTBQ8uISNHsCTFGb9L1yPcro+HZtb9y/4KPz5I0j
	 QJGmYWoWH8T+iw9DEQl2/rECKW0C0vw7SxcUzj2t0vLvsxw6CoxNJwE3hqnxY4wIKU
	 VgHWugJcAAbPNYF3a0KrQA1ZebZXrr00Qb4IJZ/6z/8SvGXm+wTe3eFKWSdLM3/eyL
	 jhnp5qQciRkqetHAT5fMfN5xh2e/NoZuab9QqWPK9ySzLcv62CaH6H7F6KNHaSipMO
	 azBt+8wz0OpxfuCqkBo49Ir/FrFvlC0HBeEPhcHLgpBgzCBqbW4R34K+gw2A4nuZYE
	 YFHIjJT2lPi3Q==
Message-ID: <sashiko-outbox-216654@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/13] bpf: return NULL from bpf_real_data_inode() on
 errors
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261116-work-ovl-d_real-v2-9-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
 <20261116-work-ovl-d_real-v2-9-90564c4ae347@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:51:43 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> d_real() is about to be able to fail for D_REAL_DATA. So switch
> bpf_real_data_inode() from d_real_inode() to d_real_data_inode() and
> return NULL if the data can't be resolved.
>=20
> The kfunc is already KF_SLEEPABLE | KF_RET_NULL and its documentation
> says it may return NULL. So programs already have to deal with NULL and
> the verifier enforces that. Note that this is the caller that most
> easily ends up with a file whose data was never looked up.
> lsm.s/file_open runs before ovl_open() and lsm.s/file_receive sees
> O_PATH files passed via SCM_RIGHTS.
>=20
> Spell that out in the documentation.
>=20
> This is a no-op until d_real() can actually fail.
>=20
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-ovl-d=
_real-v2-0-90564c4ae347@kernel.org?part=3D9

