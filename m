Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826747;
	b=CqiWl9vyFEsapActi7LO1eOAS3w3TBywVWP+noPplQMdr6YJ5w13ihkH0I+611+bFnWA
	 Huu8RJQCD2hMbueSq8J+2g0McdsQiTuHQeb7zvsDDXiTEKfOLaeX8ReROU54B7sMqsKRW
	 EqICdNlU/2hSJc/Dg+pKdPHZaHJSrrx9+dcrOeTbpR2BsN/fWu1fNtYzkMi5/m7Ci6gAj
	 6W86YqjUOp2WJTJL66K8WEKgQxjxA74pHPgNTywOuqCj80MEk/VHmShxLFroFfqLVmxDq
	 601k15YWWDv/JyvComsWxGiy005+nUKru1mI6B/aZnsKJrBGDJKbZtMnIAKSYMLjnkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826747;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ihcxZ3+XH7FewnORHfKr+aZkrdCA8w6aEtGT4qDjfAI=;
	b=u+SC0d5L6rknst6KPdoSCuoZNt9iNruq6agaRGCU3H4mKmL/sON47ikiE3XqKVNwi4iz
	 drpciRKkG6EWqYqfPKJPdtPFwwe1nx5chJu4lsLCcYwaoGsBOaAIAVuOQJ4NIua65t+KT
	 dUBy4dSZvillOYC0lZaXePcLuu2eTBqSKLOKwebodc44efcsU/Jo13et/zaQCms+AaFfL
	 uETMdGfRKk/sZMc38qmXu3CmsDLJAWIDCe7Q1eaGosIS6nEA79RUsyM8iifRxOW8D3TBY
	 97RusJpvHexgMr5Fdx3yW0ZS4HdbG2AYDq1/DeHNU1HNjkUGILwDXWjHUiuRXpACt1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrsNUgnI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD73360B88D2
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrsNUgnI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1C51F00A1C
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826746;
	bh=ihcxZ3+XH7FewnORHfKr+aZkrdCA8w6aEtGT4qDjfAI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=MrsNUgnI8KVQV7cgZT4A+r55Llfr9YtJmmDKl9MfsoQlUDb6U/nE5+fofkJStZi4+
	 jEyo+1N+AKmrOsE1myiu/u2kHAlHTqSS73+68lcrojcaw2gI1XCBjH1i//RBtvTrs+
	 rHDdYo6KH7wUUeAzGl2AxHqP0t1i58bW3wsdPO5zrgIVXiWGdedB/cohOwQT8ki3Hd
	 AVR7PtA00rKm9KPssgsQb8lRhXQS1PNEFQTbC5RkVbzjeKlP9is+YtncRXdhJSNmyT
	 X4TY8MRh2WNz8BH2pL31T9i9qH6F/3nHlRzCdFVIuWLLs7QQlKMGX6xgDvPxmnSIlE
	 jD58rhJCP1lDw==
Message-ID: <sashiko-outbox-198056@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/27] selftests/landlock: Fix the ruleset_fd check
 in empty_or_same_ruleset
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-7-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-7-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:12:25 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> ASSERT_LE(-1, ruleset_fd) is always true, so the test does not check
> that creating a ruleset with an empty handled_access_fs fails.  Check
> for -1 instead.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D7

