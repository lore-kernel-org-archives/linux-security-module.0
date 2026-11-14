Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794685329;
	b=PYkBlSF2kbz3Hkqe6aPfUEiwkYH1J6yvWJt7UpB+kKtY0LHDzuzjmmOQgStO4rmKjXQv
	 HmY3bDDYLtGyaNupaQ4sEPRZNpppJw/rFg15/AoYSIgbAPghRsmHIet8LWIrR/5kRrT4/
	 yzu400mRQglKjqrqQxIM/oqTWCmpypV0FLLNyRdFzNL9xrH5vbkf2PSCJ9sF7wPdvsRcj
	 xodvK7/WRDddO4xTsvIhoQetYePkU+bzHA8I278nLn5CrO240Wf+gOQ52OXGttoNWfYo3
	 zcCKqJqrgjaZJkOAN76o7CFf7Xn7DvFKwgiicivODEiPaKZ3QCkyTXzLMwyQ0kRVpBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794685329;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QQBElZYUCOecdxU35RpNktgYsJvdqTivHX/vXr9vntQ=;
	b=EQh31YnQYuu48q03wEYulus4VlXK/YmlrYB+qU3Sr31x7QhR1SOAjBg/eS5wl19gDy2u
	 xjMLnDtHXJZxmNnP1f1W/HqoAsfNwiP9vGNyBDk7XKzA0nJzr7uPyj4Ncqkp+TiibPB3D
	 0T7YQxifcOyponodDAN/OnJn0hA72x4K50Qny1UZW+SlplI5p7t+dXnFF/iIyhmV+iSKm
	 4ZzTb+ZK9IprlJ52qpSJh6u+x8U+fAKlZJGtoRylzfniBL/+nujekL8O6Ei5wVitqtDHf
	 9yF/gQGtv2DABxo7Vn7jSsn4wPgXHxUdKPCfjndZkn19fCkoPmF/MrJxyNukdff+suQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cJH9PwZB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31FE606A32D
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cJH9PwZB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F5B1F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 19:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794685329;
	bh=QQBElZYUCOecdxU35RpNktgYsJvdqTivHX/vXr9vntQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=cJH9PwZBWcKWd/b9w7chudShQ100nLI4krXcoq20NgWdWIwsHJ5Y4mRTq+UsKtY0H
	 yj/2qp73SXq1OMhTXwDi2ZjcWMFz9mA1hbQ4yofU9upNWNmAQhOMSi3PNXk9nef0Ru
	 DXDwuqDKh+tPtI5IvxtaiL67/D18qIJLmQZn2c4HqNdy7lt1AF6ftuvEgLwRPc4Y1b
	 3tg5p5okoncbW5QPWsRiBHVNCg5vBW/PsfatMGJRy4ncoW0KwXUTnmduL2+wgy8jA8
	 +comyKEYSuazQN3eqIYfS4kfYW/DOyFXj+xie2pdwb/H1egi+76ZRmhMX9DrEdvWXC
	 5kYEnv4un6HoA==
Message-ID: <sashiko-outbox-214982@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 4/7] s390/cert_store: Read-lock keyring semaphore in
 invalidate_keyring_keys()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261114193631.731615-5-jarkko@kernel.org>
References: <20261114193631.731615-1-jarkko@kernel.org>
 <20261114193631.731615-5-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 19:42:09 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> key_type->read() requires the caller to hold key->sem for reading.
> Acquire keyring->sem across the two key_type_keyring.read() calls in
> invalidate_keyring_keys() so the keyring cannot be modified between the
> size query and the payload read.
>=20
> Cc: David Howells <dhowells@redhat.com>
> Cc: stable@vger.kernel.org # v6.6+
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114193631.7316=
15-1-jarkko@kernel.org?part=3D4

