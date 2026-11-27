Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795760058;
	b=aA0Ahu9y26M33HIMPzKY7WekXSR+auIQU2YpjzLmv5VaNERVm7YnnP9WVIY4w8irDVzd
	 di15nezGYt9BRlV+o0PwFTC3xW+8L5+t3UNF5oP7qvYwAb/kInSjV16uGzyiONMSXh3QK
	 rVKbiLoto+tw/PHJi/EsLRpGx9vtHCxyC1RemqLQkpvKmifrWpwbMUj5HzoKDnBMAQiNG
	 DcdkD4YPMTZOWbuE3JaVwnJYYWxagEd4UNVYPX4B8HyYdj2m7V4ph2hG3Qv0LsTSy3EMc
	 qaO7k9hx9+a6pBy9MwjRM0SEmHbbs+imL1rYK27+cnf4cuSJU4OW55hgpTnXnPh3U2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795760058;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XlcvAaUPadBphiqnCfEV7mbp2FUFv8qwr9TTBcJ5Qto=;
	b=KUav+Aw7Sva4y5sa4JMtvjxZ28Jig8QO+DyjiM7439MxVYrscSRrRv2Z7yDB3+ZuFRhu
	 N9giw6G15xVMNHg9wAnAu8V2ri+JOrEd3wpCUqk7goFJafQwO9fecb+N2eljMH/mjfLRk
	 vZDX5lHIoPifRMhdPRuN4Lwc57VjRk6Hz2ffKjxv+rdQe1o5CMdhAZsPZwg1V6fQsO9Kw
	 haRiTeMCsSa1hwP9PTe/0rFabrwRDtl6XtDirte7vW7KbrunoKFa5Iddd5v/poHGMSnLX
	 GDQJmNxn/vCjKq9bsetlj8YKIKChI8h2oeKpVpysSktTNqZdHv3q+95KqSZNvRIOnzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XB2A/fli";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2EF606A31C
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 06:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XB2A/fli
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703291F00898
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 06:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795760058;
	bh=XlcvAaUPadBphiqnCfEV7mbp2FUFv8qwr9TTBcJ5Qto=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=XB2A/fli4U5L/VX3GmxQHIURqobpqaIZBRVHsJdnlQo7Z77l/FNTkLobtU8+TKmwn
	 fIw+Ga8/DFuQ88+zoNDfJgxeqCIDBKAmlSI9DTkDtT+4svkuHWPbAC6W4GUfo9WuPi
	 MGXvzl6cB4P550zfdCNduBxW4isMi2HM6tRqyzdOCrszHLE3srAWgLI11AXgWLMUqs
	 fDIOGDyRZEfFpygyaB6k6vdb7ZSD5jTQGQAEp8UmjTMJfdZFqd0uEBbWkoawtGitAN
	 e1Yjvc/S71DTMWrWmmfTQn0PuZVGdxEPzdZIhcG7W0yWHHtupIlhBXh4JisjCJAKBB
	 Eo+2hLzHPZPdQ==
Message-ID: <sashiko-outbox-236695@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 00/17] KEYS: trusted: asymmetric keys
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261127055602.2357884-1-jarkko@kernel.org>
References: <20261127055602.2357884-1-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 06:14:18 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 17-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127055602.2357=
884-1-jarkko@kernel.org
