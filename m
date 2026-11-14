Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794673100;
	b=f45rmL7XpQA8q+8dURdukXc5CmcFFTTKH1akdciPLCgApq1bm9XK9K2PaZNqHmYDZ2BC
	 DqjXNcNPGVmG4u/0Jkt0iU5ThDese/KKYzn3CcLAEgosXzLlvF1fnSOmrfG2EcDeN/Ydr
	 DcRwN3N0RoDTrTjXT7LDWhYWmo/e6OJNqYejB9KGO0mTBUNdPBKJyIOob448viiQlWkVX
	 r96dqVCXUlmg4FggoBNFpKaHJJsNKXUqpmcmCwYg3Sm4Pn41xcONGbr+YjhL6NzWB9Vdc
	 s3zoC0Jl0byO1oQRsVsLe6Gqp5+R85iPGoQsLuaxIhQofYgH5HEFtqTy447C+jY8KPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794673100;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MiKUunAt1kKpLL4xpneL2hT9T/L6+zId/69WTRWMspM=;
	b=bXS/3MKaUd8/Zd8EGAZ+FiVGLv9/uzMzet/uJLSsTjJPFYQaokbwaQOy/eq6+Fo9eXDn
	 /1QRWZ/hiod/al/sE4629NbSr30+gLVpUMIDHBKNtYoN+bD6odXoiB1ync+09nPezrerC
	 lOwA8cRS52iNu0gR22BL8ZuZ3OVty25FjFvOJUA4/6TKxur46IUtcwB3RHGhkKnx3XF6b
	 xmXRF4JXUSqZ/7Wb8lPwONdvIriPKNze6ezZxUEYfrsd6Wgq+7JvLbOssE7KX4p6zDqwu
	 UTJMvmPHuIBWz6s0kJB4k7Ebi0f55dMnfQdaFI2z2z36hxylM6Wp951ogaINhK3yskA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBMoD7GW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C2A606A329
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBMoD7GW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC93A1F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 16:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794673099;
	bh=MiKUunAt1kKpLL4xpneL2hT9T/L6+zId/69WTRWMspM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=UBMoD7GWL/OUZ4K84ArCgINDLtk1ygFo6CU6oSYSHH5INAi0e3du8130u7W3/SAtM
	 1DUcpVDIuXi1RDkr+fTUAui0zzI19Uv9UMo22TJeccRVnf+zaapxa75L4ALmrCjRCy
	 gCb6lR7apiFBXuYsUsgLyYbiq0dHypNZTdpzfe8H+n3eo317Zu9ZBd8FvrWtK4JeYp
	 M2N9g0NUS79UakX3R5l/vS86qythzV/cLga1vjgiHXK3cu/ZIUvdqRFy53YjYgQL3q
	 vmlkZgqGJkIq/DwSlWaHlf1Q6Wzayy2Gn2t7dgkKUiw4EmyxgRKyeB9O9IZTMWKT1Q
	 bTO3cNsgoVVUw==
Message-ID: <sashiko-outbox-214741@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 6/6] lib: Remove assoc_array
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261114161211.376859-7-jarkko@kernel.org>
References: <20261114161211.376859-1-jarkko@kernel.org>
 <20261114161211.376859-7-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:18:19 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> As assoc_array has no longer in-kernel users, remove assoc_array
> implementation, includes and documentation.
>=20
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114161211.3768=
59-1-jarkko@kernel.org?part=3D6

