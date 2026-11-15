Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794751633;
	b=4oCw1bzI64GXPG8IKhQiy5gN9AOl5siImeQ0+ysaFmGRhILuVANpBrK8E7pwdfKNtpU/
	 Y23yJnV9t5nWjLqTYF6VkS49IdJpuVRy6YSX2slhNSO/TgxeSha7aroMMUn9BF4jvPBkS
	 8oqrX1L+ujCmQ0XZmkRFTRFJH0yoR3s3xK4bMoxEojC2Ux1a9z2l548X+FX1bb82bKT5Z
	 0yWFNTetLBb2aGqFrPLtmBgwYxnvyvuoY2QaJJaKyDsbzy2fjp/odvvZLlcrRYWXiOlR+
	 chGrgDxIMo3Tzsyb49XUDPM4TDz85MsgcR06tqLklGdtzBXz8G3YrouzhRXtL2TZBJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794751633;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lfPqxd1lQdBGy62GwelSdK3cpwCMQHmJ16T3QYtjuKw=;
	b=SYj9HWDYwJLOndvUK21mCjNSh47/pYaeBFtp2bIBZtRfM9LbIKYlsKdA7dykG6Cla+Vc
	 dDqLM/4gjpmg1+oT9flryM/cPJgbKZ6ZOfkDmJbuvqZ3FZNNjmb/cqNCAAlSbv/jUtsDs
	 gQo6dmEcGA59iowv/V0sfiP9fuOBuOniumadRExMlPO6iisgiQxsNpxCuY18AU5FytKc4
	 7v5ZD76426oUEEREvUV9xaq7bzdIKLSgysFuCc/8ScaiVrJEDf0u6THfZpVrjf/OEsLpo
	 UXtTIts6z624QOuEbUpI4Ac45oHzlH2UJpEgjCz8bR4f+o91Z8x7dXp7JnGa1LEEmVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRNsXBos;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66CC606A31D
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRNsXBos
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA5F1F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794751633;
	bh=lfPqxd1lQdBGy62GwelSdK3cpwCMQHmJ16T3QYtjuKw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=JRNsXBoscDN/4rrTOt0+E9Pyhl305fgN/RW3FCEA9T8E+sGvpLHAYhGNsGvQ3s4VN
	 pouR1S9mzdcNINiFNM5gqd4FBzEhmtYd9HhlD8Suo/CH3/W7H8TQs6p+Jw5JDsFtM2
	 NGMDWJ/I4EyWJpv2F6hgb3OoTcqHHzZ9ni4L1h+1h8N5TD5h+FI89WzTTLtzSMOMFK
	 23fIWurW8z6aff3X/yqLy/SyiB4zSYgsnqhwFMmh5CYcflyrgg6k05Xse1cqGIBzFs
	 7iTsgai08QwKqMMZSxtVojH4zig0sHjFp7HlobMvUapFtht+MqdsMIWwQt53elTC8j
	 /wMoDyrp5zWew==
Message-ID: <sashiko-outbox-215559@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/13] fs: remove d_real_inode()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261115-work-ovl-d_real-v1-11-ca155efbcb2e@kernel.org>
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org>
 <20261115-work-ovl-d_real-v1-11-ca155efbcb2e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 14:07:12 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> All callers have been converted to d_real_data_inode() or
> d_real_metadata_inode(). Remove d_real_inode() so that any user we
> missed, or one that gets added in another tree, fails to build instead
> of passing an ERR_PTR() from d_real() to d_inode().
>=20
> Add a porting.rst entry.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-work-ovl-d=
_real-v1-0-ca155efbcb2e@kernel.org?part=3D11

