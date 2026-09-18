Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19AB47A871;
	Fri, 18 Sep 2026 18:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789757896; cv=none; b=B3uHWjQE2lmOy8OjmSFNx60xkMcnJXPbvDoesbNkez3O8t/5i93+vQ6xumI7DrhvNzo+rLUVT6QFg5wqOGujMYMh3OTJB8d2z+jSXTFXVOzUEruAO/DCbHYnhOeozVe2QgJ98DY/+9IgRnRvxoiPIa59XiGoOSHenT2Nb+0IYA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789757896; c=relaxed/simple;
	bh=eX+o0EDMa3Seu/T1lBh2ypWkXgBvgyMumaANqzrOowU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZbR40HdUrtO8fisX12EduaZlCyD9d+If14MqKtWl8eBhlRfaGq8IBPfwLs8iqJCgv1PqIs0AUbp5c9qa+1MBSMTk2gq3cqRtLZDtBBYv0wth12vgD/JCfMD3JBFTM0RpE0jhtH4FHJiywo3kfhUmsjOyNFoEB2AQzf4vGFWJlGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvAONtaG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvAONtaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320951F000FF;
	Fri, 18 Sep 2026 18:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789757885;
	bh=5NFALw5GZFKlJOE0iqyKyfLv1G5kiUcTAt2Ki+ybxgs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AvAONtaG0JStxEo7KQzV7aSprAULUPNsTCHutf9Kyal64fq18q3e/4pCcmZ7DSSJW
	 tOKkR5TK2dxslFhenRS7AFqFJVRr5zqJReDzxYfQ7WXgZqaTcLPLsQNxU3GCI04x+d
	 UnYI28k6mEpAz3zUyez9hrYnW570Q3pS0kaQAuNwu2gJl6pK4F6YCgk/SyQOvWobje
	 4kL6BfAw8nWK7SRNLhkgeHVQX5+rq+IpYpkmqHJXUDN7MDvMSzqBqnLcjVahZYT4bs
	 NP3WWsvIV5MRVFlrEjQLBC1u2eJovfq1Jqiv/BukMP63rBcMChgX4R3W1qfMobmkDn
	 IXJ2boduOkbIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 8/9] selftests/landlock: Test network denial context
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20260918185036.608651-9-mic@digikod.net>
References: <20260918185036.608651-1-mic@digikod.net>
 <20260918185036.608651-9-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 18:58:04 +0000
Message-Id: <20260918185805.320951F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Network denial events now report the port from their one authoritative
> validated address through one signed field.  Verify this value directly
> without inferring a source or destination role.
>=20
> Exercise a nonzero IPv4 TCP bind, an explicit-zero IPv4 UDP bind, a
> synthetic-zero IPv6 UDP autobind, and a family-only AF_UNSPEC UDP send.
> Require exactly one event with the exact policy blocker for each shape.
> The value -1 distinguishes a family-only address with no validated port
> from the two valid port-zero cases.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918185036.6086=
51-1-mic@digikod.net?part=3D8

