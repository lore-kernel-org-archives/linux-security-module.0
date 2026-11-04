Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826746;
	b=ARPDesOe9PFHQnF0A3/DxPknbcVSWLdgdoPXjw0SVRk4TxNyH7DGMtWLI6Obxh37rKVc
	 SE7A3O2tq/4bes0ATSj0eq+QNhcB4M/1tDL4OSlbU0kTuVHNsP+ZDMlGIUeWT63rM6V+1
	 E7FfDue7bIEjPRMStoPXNYwgs6I2skbSGjMJxKlHget+SPRZeLakzq97FQeGQl9CWARId
	 xkZeXrQErkswNfS9Q8UeH4EmdtFcojy83vfBATjuZeyaWZuOSSrhSH6Ckk49diPTNA9PI
	 gS0/MyMQiZxMMs3m+CzVBHd2uqd7IjAcsDlaP/wvWPl7pRoqzPCkd0cHfPpWRgszUlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826746;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YeFAR/4vi8ZhC+8DVA9Ggep4BLe4SYnUK2KgyiTUj8U=;
	b=3+gMTK+5goTFpyO3LD7SOysF4RGCuHLeIcTeBfhEs7F8+pZHfg27O9qv5F/4xpNL6v4N
	 xZTMHNTn07opZcLm3nzbqCBe6hGlK3XczCx9aA4oyVtaBJ5XppZmnu9+VK9paIBSVoPvs
	 M27So1xcAwLLq8Jo7d+67b6MCePg5FX/vN4IkmLeJ3OMUXYxu0CqAiv5WQhe64u/HWf9W
	 XicKj55AR8cqpdZgdRV2gyfM0D0DdfkHeJjJp7Kxdb+ICMHffuLpF9zRTRyfZ9NXxw8r6
	 RtrvfkX+hjjN5WOHLRj+pU+vg1YJtxCmngqh8itMAco9CJd921D9DQuNHp4jF/yvl8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="M/WLwbd5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5664A60B88C5
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M/WLwbd5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6524F1F000C1
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826745;
	bh=YeFAR/4vi8ZhC+8DVA9Ggep4BLe4SYnUK2KgyiTUj8U=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=M/WLwbd5Gy4VA+X9BqU8FitW3ZP5x8h4SBFejhcDk3H1pp0+wzHKARPVvBSXW4U7U
	 RO5e5gjC/l+G+hH/mCS0dXSLXrFYDaVJqs8UqFdeZKwCXchP9OhY+TJ6Gy5bZUDhOW
	 cm0j6nBrmxEi5jkjquyKGqh+9BJO5JStQqj5n/GtrDo3kR48dApkuY//wgCFPwje73
	 wuZqBWSny8+PBBDy3Hr9neh5GBzwSEQYSvQB7J24LUltzaSB7CVjNxb6BzFa4hxe0u
	 zZrjyC6Wi0+xHBMmD+qesxa+LDbyNRLwnkgB5zoUzOfI2PMXG1s0UJIkhez6hKSVKf
	 uBj+TQAjaId6w==
Message-ID: <sashiko-outbox-198055@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/27] selftests/landlock: Handle a missing control
 message in recv_fd()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-8-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-8-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:12:24 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> CMSG_FIRSTHDR() returns NULL when recvmsg(2) did not receive any
> ancillary data, e.g. when the peer closed the socket without sending an
> FD.  recv_fd() dereferences the result unconditionally and crashes
> instead of returning an error.
>=20
> Return -EIO in that case.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D8

