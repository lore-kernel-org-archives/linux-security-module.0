Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802669;
	b=SGoVU9TbFDFoWUrvWIlheiV/afsV2X8ucUJnrElhqxb+r4fzporkiP2bpJagT1QUB1ZB
	 Ovpsaoy40OaK/jgA9BguZeZyugB1g942UGERl6RTasqClIfQtu4uLznhVTxD7fMoYVACR
	 JP2GOTjoK7XeO84aXinVQ/DWZdPELM3MEka44jM24evYvH/QUZJoU4mNLNFzWGT4ptL4B
	 vGW/m/oXzQ2X1ao0SVkVmzjRWgdgh6HX5VV3c/pVidxnaDLDZomKOrr77/CQ6h9s3JgO1
	 o7Fy9Jw5iE3CSAYm3hAhkkOFjNjiQETvpjPTbu19CpJmnFlf19Zzcm6yqDp3QcKedVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802669;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ka3jth5sqNhknTKxVoj+kqorzHZfnShakHmX/maAiWo=;
	b=KucM3i4DYuvyvMSEqcUZ643mpXB0CoflnNJXIk9NTuadAvLdTq/JaKuJc8TO7M5Vi/vc
	 g4CoyUlVo3SJ380/UCChvJ686HD+Zep6D1ly280/3OUaV8NM+OgJWztjhm7ft+PUczrMF
	 zWPi39ZeJDDl3UEL694VAz62su/Hw2NmFBXSRVaMU+pXe1UJvrs7eJd5VJm9atiYvtyOj
	 7eC2wAknYMTpWQUdDgnHlcYiPgSTexGNNf2vcADfKA1uh4S90QFa8s+Nr9fWZ7X4th25e
	 TFenw0Z/aq/OtnSfL3BDmDggvVHKaamHhnvnvP/iiLD2lyiZ2sISqrsaJycjktZUJuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4FQ7c12;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A667606A326
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4FQ7c12
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF06C1F000C1
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793802669;
	bh=ka3jth5sqNhknTKxVoj+kqorzHZfnShakHmX/maAiWo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=j4FQ7c129g1BGo4BWPkL1x+jFDTxPI5B8mK6oA5pxNSb6xWmqxyghv2CcUlvxTC2R
	 F+5YIYHZ0UR1ZeJPwcKVi20987VOrQ5kqlQa9XmuX8LiF7te4DIP9tq8numgC62lRy
	 DyA7elj/dTSbHBq6nutoRX7jDHgFslGa+4dbz7Bm2D7EIGZ04rT4otsyu+00phobul
	 9GL0doqv1CYQGLMTVa2+s4WiBPDLvwlCYy8mMOtWXTtXMLOtURIXeJrGtUSr7TBleD
	 JXDBCvESFSJXBSwJ6s2xlS0i5P8sRcS9JAkZy8nLTGnIL6GA7861i4+/LWedOAIsAI
	 VeyIwsyO91nTQ==
Message-ID: <sashiko-outbox-197444@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/13] keys: use cred_ids_allow_control()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-b4-cred-ids-v2-13-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
 <20261104-b4-cred-ids-v2-13-956213608f16@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:31:08 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> KEYCTL_SESSION_TO_PARENT wants the effective uid and gid of the caller to
> be all three of the uids and gids of its parent. Use the library.
>=20
> No functional change.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-b4-cred-id=
s-v2-0-956213608f16@toxicpanda.com?part=3D13

