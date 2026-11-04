Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826834;
	b=foP8P+ywgwVG1ebIKHB5nExOvTaVb6mr1U8BKPKDe24CgImMFN/G33Ft11EAfd7HznGo
	 w2lM/oapDlY24exRNaVxgQf9Zi8XbvOM5PSBqYPcCLBNadWQlpaO0838Iy4cFPkDSl2fY
	 7cV7jpH6+Dm630O+leGNd0BLT4fNmA71ffANGTu+bZ3gxogXQNp6RSLiouAea0Blj0D9p
	 wgbdN+FLwG57f1yilUiQdKU63qRe0ISOlzSgXncBrSI6vUCkuAGOrUm73MBJbjfW4A/f6
	 uU8X7zBzfrsZskc9DpfHigcvnWJY9XIJQ3VT6AxfwLtPDNcjV4U5Q3O5EcTP2mhk8Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826834;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/gqan+KugEk1wbUPFNpcL9mi+MNMlTj15UZIPIn9WeI=;
	b=bi7xhaYdUpi2O5Jgo/T9y3yfLare8zPodsqW2TKknq7wiT9PYgybJziXO9JBeFQy0EHf
	 xSe7zBGjzwfF53Ln72a5H/EjoWjKdOMwzCi7dgJeGCTtpRK1vbiId9f7llzwBYycvE9yf
	 qaYMYw9IigpEhemTn1jM0Ax9gWhjAf7OToQzrbUI8Cu9p7MLTH/pzdoQErsAPb+9O1Qse
	 7Z8U/e1RUCI8jL0d3jIpR9FKjLteSlglpP3V97Kob/puYRORnQtmY1aK4OMW19c2jGhce
	 gV1TdQnkPfcXeeKJnmF/5hU5FM6aslXqmcq7bTp2j0KpVGQ9iHN4HDHZzfwzV3aBpNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfbWyrqm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01206072F79
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfbWyrqm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B261F00919
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826833;
	bh=/gqan+KugEk1wbUPFNpcL9mi+MNMlTj15UZIPIn9WeI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=jfbWyrqmfDPawR475OcJd+TGWCNf04zRr0oGWBvpz9dptqhAJgV8B5+O+Wxzl6jZ2
	 FK+Zxz3H7J5X7/TRhjH1VRULL9Swot7jWNdwU7Spa3iQUCjVtz4LEC9OARYQ2/+Csy
	 Z3/6nDqVl4dk7qnuJoa/To/yU7qVlW6BaPh+MlWWW344MK/hUikKqjKc+ZzYpZI45r
	 8QEX9nURIFcV8mnSBKo44cGRvQgsOtpPUs2eAnyBAADnwGqbVZxtQVZjupXjN2NxmD
	 rW1tq+BViOtiwsFFtiF1m4wgx3VW3d8/f2tiwS9WIgUpVZHSkvjJaw9OAffZ+Zwol5
	 BdOAfdk4UE4Cw==
Message-ID: <sashiko-outbox-198059@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/27] selftests/landlock: Fix memory leak in
 audit_init_filter_exe()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-13-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-13-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:13:53 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> audit_init_filter_exe() does not free the buffer returned by realpath(3)
> when the path is too long.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D13

