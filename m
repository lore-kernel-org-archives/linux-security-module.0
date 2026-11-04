Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826917;
	b=07Lq0/YGKUYN0bgmWEBvQsAkIxYdsYIKAdns1W04/EpFMmh3tqOAhW9bDcfdNkLW3yaO
	 VqBBXPP8XHRLc+S4JZCuf0SY7CYJxhGf15ZsgjGOG0wzR9d1ttTQRRcRLACHuQKob3W6w
	 3T6X5CJi3Dj9qhjksMETk3Y4gDqkmygSDo23gt63NPZbiEX7d43jCq/k8cWY8AaDUsDaX
	 yldPxvZ3VPWJ/E2wblVP+vF4xiryucD6pP7tYO78jL3e2cY04TCjpm7eEZc3HFL2pkVDv
	 jsfwTbR73Fwmndvs7Mz8wqmpvRDz03crIm+xzvJfH4IchDc6FsSmYLrwTFd4MMUGlBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826917;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ltj/QyGgORq6RmFgw0/SIl+SzAntZzJvPDFmqhIzIIQ=;
	b=4LhgGEe+AtYcm3vs3EjxPjEXyCckdDJB7eYN0nimo0/5qtZAIceDLtWONThPiMAar0X0
	 /yRs6ZGIm2WXHAvNQaHMNAM89HKJShEgdXyE5VVOZ62TH+9dMnLl67UZMjPHcllxj2ci4
	 M3B+iSC+Xdt1Dv1PRDsQ8SMTfwzcMy01kzdZzuK7DAzKe88jDbZHRq6tcMVuo5N92Xt1/
	 b0+XHFMQuCaSbC8Er8LANnglLM8iUhb02p4PwLN5mt3M2i5NkFKNxoBZsg1am4YsmRD9L
	 6yCEHWg9pTHbJSNZ013BdIgosMAiIMPmhnZcuL9OFRQVreXUxQXan7idI9L1CMSVFaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lv3sO5WY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026D26072F82
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lv3sO5WY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABECF1F000C1
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826916;
	bh=ltj/QyGgORq6RmFgw0/SIl+SzAntZzJvPDFmqhIzIIQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=lv3sO5WYULgIusJ28S6zDZ644XLia7EC6OR/KZbWVSyzKZXF4ihl+utRnNcSM0wt+
	 Fwqui99jjftXpkGg7vjbSAnYqGC4k8jhC46Te2xrXPw2pTDn38okq+vuCjrWWNBDOQ
	 gEf57s99p30OKNc5pencgh1a3QFtnGrSoM7cxjeWo9yLZTgz+NMgDvpA7XvBRwKYRZ
	 VnBeZUjcrI4qJIhQ7v5gaTxMotDL1+JdOUuXu8PBV3L8jlktlrY3jW/ny4DbuYKZi8
	 MLANHtqo5OQ7qgSYhuVEdxxMgIE4SRag/fIANeVWgp22OcoV/2bbVoU+f5QMxVB3e1
	 7wc3SpUlyR3KA==
Message-ID: <sashiko-outbox-198077@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 21/27] selftests/landlock: Use _exit() in the
 named_pipe_ioctl child
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-21-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-21-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:15:16 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> In the named_pipe_ioctl test, use _exit(2) like in other places.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D21

