Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826873;
	b=DdXMRy0YahlwU/tXCrqCsq/nh2oASM2tllfJATeBggCLM/W9ks4QS13pDuyP8LXfVd66
	 yj74HhlRJaHLmXWTCcOrjUm56ztkRDgumYSYlQUb/8OAeQqfJYRPWAZ7Wcv9ceRG+I186
	 XeuytxuQf/y6+XqsbJLTJjnvxiu82LSQkP3SZ3BlUP050+NbuT1d3ifTqgp8eD0unr+7p
	 bTctlRNtWRe2X6BP5ywGD3RJS/1xr2e27oNfNirFcUoe4NrHanqAcWnTFR1oU2t1VgEYA
	 WM+Jq7/1jD1R+2XIze9uHLzY8ZwFy5IqSxpuj9BhClGRQn0E9O9f8H2U4azq8dH68aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826873;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hDuGCDFy0kqm1pZMLxZVUxhjxxFMh3VdmUDA68lQA0Q=;
	b=jCHomq9TD/jl5WsQE9UduCSr81S6sVBCaDJglDx9UWaQ+gzLhuSyTd/2DfKaMArjPUOr
	 jc7xR2DlLHSN0lyMnfXlSaxhrcTsochPmfa9MnLjpxDviS1urc3z1mBvE8u+oJpZecJlG
	 yJuiRyZDTSlRHuYihjPWG1Aa0hckW+PTJZKR20NJHDeqyrjORzinf1L6slyCxYsBeFfm0
	 IFW9NeC2zuIhvyLYqN0bqXtne/pvGbjPuiAETYOUdpGgrBuyry6DwamlbFZ5NbvhUVFVf
	 VpU1fTEBehCbYDpyG0MVelEmovpGAQjRXnNYZp5lSLKyNsu1G7EB/2dIu3uu2IyPvqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TXFCm0yw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1A16072663
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TXFCm0yw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150CB1F00A1C
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826873;
	bh=hDuGCDFy0kqm1pZMLxZVUxhjxxFMh3VdmUDA68lQA0Q=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=TXFCm0ywFyDpDEbMGf4qOSDqQ+YUBiC2xJhXWXlfdq70U7IZhmze68wvKOHqy7ifu
	 xJcPK1qaDx9taQNjuZ/yV29PjKmGm1cVqHLAj57ftlpYvNXAhmtlIQjOP16MewALKv
	 Rn0qKQ6nlAbNQ/gKUHpA8Xv7wTDt+x2BcA7pFYJDdFgS7yJHm73NUrYLuTcJtxM3wo
	 oXPr9ymLlAmx7XoQXTxV+1UOfkVQ79ebOqYtsWbgmpiI5t+dghdARBlyXSinq1IOZn
	 I9vFka5V3zuOzfrwS3TzA35pj+k1VT0sVOckRk6UcLznDyvlPMlEWxiVjLuxLDx5Ve
	 w/SaWm4YXGZIQ==
Message-ID: <sashiko-outbox-198067@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/27] selftests/landlock: Assert helper results that
 are used afterwards
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-11-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-11-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:14:32 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Some helpers check a result with EXPECT_*() and then use it:
> cap_get_proc() in _init_caps() and _change_cap(), and
> landlock_create_ruleset() in drop_access_rights(), create_domain() and
> create_fs_domain().  On failure they pass NULL or -1 to the next calls,
> which then fail with misleading messages.
>=20
> Use ASSERT_*() for these checks, as create_scoped_domain() already does.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D11

