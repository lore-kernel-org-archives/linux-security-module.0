Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316669;
	b=hxyYlnSnmQWCnDlOIGO/yHH03acAmjQ3V/sQE2i/fP8lTfyRoGiVxeT8hm0AdOU+Sohk
	 3LuzO1/qedCD228UPZTCiltFKtEeLkI24AN+sK/6VT+cWD8OYQz+XaYG9QnBGEYqkGjCG
	 F6UL32neUuJiDA7YzRGe+AuvRpV/Ivw9CtVcF8TXuNpNrew7Fc4E4vsizq5slqn5OjafV
	 iG1wEfsiy5zeGJe75MWJbfX/Th3THRMWcKopvRzNcPq0gKI2vsbX2OMnTXRqBxgRJggFY
	 q/7nQqypQsjNoU9MR054SSL+tJsSufJw61ElliH1Nxwnr0AUucC5ls4NF7Z6ojtks3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316669;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RBgNSeAz8msYH6519F4u8kHGkY9+/1pFyTzzR+EfPZI=;
	b=VpWH+nhCBKCSxKFWaFx+9C/36mB9VIzZZ0apeVb09we1dSVmNMS4P4hUJCXPvCtTu+b2
	 QphL9IUU833CXpWdlq2WYQCE9L4bi551/OFqaKS9M832+YH55oSBKD4aPXJGOLGFM4rrT
	 ursKJVX+JpASils5Ibzb7sQ60NYtIqLyDBw65mHIJA/lr5NlPX3gbV1Ty2ktEGwS4yloD
	 0+dq2aNN0dCNKOtwhhZzJ+Si5n/obqX9sAhjWMHF6EctWStGgi3b22O/uIthvdaxeq1mp
	 mm9c6jerDFCw+pvufNclKiMG+HYDmXvXk8jBSYT/DHxQEp0Lxwas+6tcQLKcNRHPddQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=flLF0fC9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C122B606B6CA
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=flLF0fC9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EC41F008A2
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 13:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316668;
	bh=RBgNSeAz8msYH6519F4u8kHGkY9+/1pFyTzzR+EfPZI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=flLF0fC9PShe4pn1Zq0Glj0wjxtlnUjrLn21O0j5EwpvY8CsZ2Mi1XVXNFI42TYW1
	 faJbmbmpuUcyB9WwsiURpEpZVjCeWQdFp26sgePjqbIXD2u33z8UEnrAFxtz/hR2ao
	 KBZfS1a/+aas8G6b9W1OY4TG8KNpHv9uCiERqmz8rmTw4oZ3DusExuUFNvBXmOpEhU
	 VvzvvHxhArqpriw/sdC6mCUo27jpVpHVtoIoIPliQgqUSt3WzwLDwhE6z7vjw3nmzp
	 XLzjkmzb1oiqfNpdGXax7iE5pjdNEegqLMi4wNOEJq3Axn8gsM/yIHMmqO4iEdH6GM
	 xFR36lAHUh1tQ==
Message-ID: <sashiko-outbox-207110@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/2] cipso: unshare headers before recompiling IP
 options in cipso_v4_error()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261109131736.3060756-3-edumazet@kernel.org>
References: <20261109131736.3060756-1-edumazet@kernel.org>
 <20261109131736.3060756-3-edumazet@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 13:17:48 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> cipso_v4_error() recompiles the IP options of the offending packet with
> __ip_options_compile() before echoing them in an ICMP error.
> __ip_options_compile() updates Record Route and Timestamp options in
> place.
>=20
> cipso_v4_error() is called from the LSM socket receive hooks through
> netlbl_skbuff_err(). ip_rcv_options() unshared the IPv4 header earlier,
> but at socket delivery time the skb can again be a clone sharing its
> data with other skbs, such as the per-socket clones made for raw sockets
> or multicast/broadcast delivery. Writing to the options then modifies
> packet data seen by the other users of the buffer, and a concurrent
> recompilation would hit the same check-then-write race as the one fixed
> in ipv4_send_dest_unreach().
>=20
> Make the header private before recompiling options, as ip_rcv_options()
> already does. If the copy fails, do not send the ICMP error.
>=20
> The issue was found by an AI code review agent. It was not reproduced,
> and the fix was only build-tested.
>=20
> Fixes: 3da1ed7ac398 ("net: avoid use IPCB in cipso_v4_error")
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109131736.3060=
756-1-edumazet@kernel.org?part=3D2

