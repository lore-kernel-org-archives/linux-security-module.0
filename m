Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612012;
	b=3Fjxm/pOKa4GVefFDQ1yPCGP4STrI8+jivyI8OZ3Soidd1SpNpGiqj1y1cDjLULeIkHV
	 XMUW1Ah3aOc12/YYd3N/6tXAoRVPeIOFOyC28ylGSEvU3HEPj4YduXBgdOSv8E5dEYr7Y
	 bCbHBt3oPPeTQ+oxLPew4jkVxYLfpAlKWS2JIVkJlyFULSYdL8/KCP5hfr7lOPiv0HFED
	 0yfZF0NU+KqP1XF0N77rn89MDaNCQPWmpPhm44mtx87xeHbUUhX8v06nAUHJT1fhgg/xL
	 GcUffoJOZ82OykoDOzimpxRUVUEQLWdXGNJ2WDujCP6XA0uNSmXzIVaAYJ/gxKOY0OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612012;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bukvTBIX7ssOHXOwscBLh36jcT70i2efbL+07NsPyWI=;
	b=cLy4huHV1FFJ95iwNzWWkccxdnJTEFUr1TXCf5tM7DmdpQ0ByhLNjC43ou+7PEKYPrE0
	 aLB9sZyGDH+YAB8fPOP6DffOORZzG45oh6oe8P3qB2il/l1ckfURLiJ6eB1lPOQt3LIL8
	 JMFr3H6tlc9ckkGe/KM/nV1VDzHShEl4FXwBjppiPxLjb4qplQ58mptXfbVpamqaJvC+G
	 nZO6M+O0mff/wVYDderrUyo2zazm0LhEbxijFqHN/WkpIa7r13JQhI8X1ob+HZVJsYy3i
	 Ks/l0XX26BrMTx9NS9yBoE2qORXPRVOzmbxLqtUmkr4AS6MxdZ/UiH6s3XxYtcjVh0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d75GvZje;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237D0606A330
	for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d75GvZje
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564661F000C6
	for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 13:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795612011;
	bh=bukvTBIX7ssOHXOwscBLh36jcT70i2efbL+07NsPyWI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=d75GvZjevJFRb2DhaISq1d69OjuswNbysGEqM+a+2jFOwGg6oK04JuU0lcDvuNsK8
	 wUwn18GkxnzrsMqlp5DV6X4aBJmim0DDBUcW/j0nYUhPdgkiBkrJEf8SLi2bWMcNUD
	 neMcCKnO3X5kJXfUhNCzStxdcT70yHkP8u9DxSayOl29ZLx+60CZ/ehoiChlNtm9eu
	 ZD07b0G2JIKC2hKmcpLsqq0gxUftHPugRSrU1ASvFdIgrAyUQ1YgV6rjbhfPBv8R79
	 hNtCKIiO6Ed2OF+8tbHOqniCiesXObaWiu72aS2Rqb4l2oT+yS27bdpq/No3X1OxRh
	 enN1FmKd/qAcg==
Message-ID: <sashiko-outbox-233455@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 0/2] selftests/yama: add ptrace_scope and PR_SET_PTRACER
 tests
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261125125944.1768182-1-maguicai@kylinos.cn>
References: <20261125125944.1768182-1-maguicai@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 13:06:50 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 2-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125125944.1768=
182-1-maguicai@kylinos.cn
