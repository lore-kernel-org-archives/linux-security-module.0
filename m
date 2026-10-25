Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792961874;
	b=HLwacH5YwuNJKPo1HgAkv3t4RD9FBvO/iuoq6EoCjPFj+amZD2Wmrg9juIAa731IGhY5
	 /hAddhlncoZRtW8CZEBcT6dQkbzDR1fMoCgnLnUPfnqnzIei876Vtw8nevT1msmAl6/Ls
	 Oo4G2UqysewR9rSDlWoiYLQ4K41NlEGhTeLJGAhSg7mEHTIkmKdnu/enhy0AhT6swjBim
	 0IjkXu+iqRjV+9cKo8xmxf5A9cWZVZKmwQEl90RYe4yubFK6MHdiH0xZ0E33tf8JeY/pp
	 C4m1RLU1VDA/BNBt/mG5/FT5hWLCA96Bft32g6EZzP5NjvClRBhEAkjxAgmj/imTmyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792961874;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/kfCQ15adPzbcIVXZwrEJNQcOtED1e7BpMsOarOpY7I=;
	b=QzeflawIMbpHFPErifSdo+8Ug+QXToX9DZsBfFmEIiZ0F0DQcOtL5vzBgrdKOhi5G8OT
	 bRrqgNrU19Y2QBuRIvhRekaWLjEZnx7CWzKSB+WhMRcA18+sAVfQAHcm8mbZwH7eFYX2E
	 a3hcng5ch8ICCP9rmKNR8EWBUubuUk7vMaW0NIN9dSxTbXprKrJdpSiLkJDRWb5wn0HBg
	 U5LeeWnMQmQEX0AG7URr/PAWt4RBaQZl0bJhqhgwpE4ouN/etQme2jIVLUvc8UZCTZ0ME
	 Q1gfokwxKCS88F87PzfNnFi16V4Dz0gsSPIiqjqMB+l4TZAW6hfRLzTPEPjedd/YCXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VRI+3KfN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9BA606A31B
	for <linux-security-module@vger.kernel.org>; Sun, 25 Oct 2026 20:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VRI+3KfN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF741F01825
	for <linux-security-module@vger.kernel.org>; Sun, 25 Oct 2026 20:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792961873;
	bh=/kfCQ15adPzbcIVXZwrEJNQcOtED1e7BpMsOarOpY7I=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=VRI+3KfNusD0/hdA7rJLAP1oZLrolZiNMijQPLz9bS1fmpU8XrsW8N7KEUsoLXdRK
	 1mSYuiRukXw3A0/Z+QUsUm5ySLOGU5w3af25OxBHNjsypaUJv1Lpq/onUMs5nJvUf9
	 ROcN+QpYrqBz8kCe3nkHJ0xX3QE/GURkLHpCxMSkM1LQYPRJjRrQRI24BzVbg9pgUl
	 CtFMeq+9hMdXnvx11ODVlb31nFTyIUnW/PUbKar7W6whHnqwjdBRzJDFBSObi5/sWY
	 Lm1vmyFgBHKM8RMsJ2q6em8pulUx/NpkEYAC3rm+Skk4anzlJ7S1Ue+OpnRiZxSJ4a
	 OSSLEZdEidijQ==
Message-ID: <sashiko-outbox-184444@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fsverity: Tell LSMs about signature only after verity
 is enabled
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261025204534.122506-1-ebiggers@kernel.org>
References: <20261025204534.122506-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 20:57:53 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> FS_IOC_ENABLE_VERITY calls security_inode_setintegrity() before verity
> has finished being enabled.  That's broken because enabling verity can
> still fail at that point, e.g. due to insufficient xattr space.
>=20
> Afterwards, arbitrary contents can be written to the file, which doesn't
> actually have verity enabled.  The in-core inode stays the same, so the
> LSM considers it to have verity enabled with a valid signature.  (Or
> rather, in the case of IPE, which is the only LSM that implements
> security_inode_setintegrity(), it also checks IS_VERITY(), which can be
> bypassed by enabling verity with no signature after the file writes.)
>=20
> Fix this by moving the call to security_inode_setintegrity() out of
> fsverity_verify_signature() and into a new function that is called from
> the appropriate places.
>=20
> Fixes: 7c373e4f1445 ("fsverity: expose verified fsverity built-in signatu=
res to LSMs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025204534.1225=
06-1-ebiggers@kernel.org?part=3D1

