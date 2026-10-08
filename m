Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADC54DE739
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473170; cv=none; b=j0xdEcJELnOx9aLk8I43f28itBzyInn0yBq+e12AUXfIfGCPF7SBYTTzy3ouFM9R4u+jzlVOxKrXRIsdxf4/B0qVljPsCcaztAxCosdBH9bVZx21Usr3OO+lNY4ojnulmy1fRTaS+Hos7SJeh34Xlq9a5V+RIRCT0ePn5p+lSBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473170; c=relaxed/simple;
	bh=g96kn8prlqHLeOWeX0KxA6EkmMdRw+u4MQCAAIEcvLs=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DYAxZNy9p71uCguJbnt5NG7Tc6b0HWlp83ddY4J/whRq1ZcxN2YEX4ryqhM+y9JlRb1XDrd51VigLQFO+0vitn2Qh2s1ivctPMkMbs2Jw8wjzwtBvYOx1VVFLcq3MLzTtPIRhNUnlM18lF/74iHYzrnyBzapCnVJjzPK++fxA+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwnhQMId; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwnhQMId"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E988D1F000FF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791473162;
	bh=jAQp40xtT55e1gxVXYXTs2AKdt3tTJo8clcpD7bg94U=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=JwnhQMIdMSeuU2jG38OarfAW/iS85MpuQ8dBwktfg6b9fHjbAId54bfv3BOd7V3Fv
	 B0cnkqvWeZKP6sW95UyM9zqJfoyCE2SHrDt8GJDCG97cquknJyCrbR3rhYKYvj6YjF
	 UoMn1EVyfr0gHkUlxSdx6HY8whgRK6uNYk0SILkt5jbvl+272wlX69ZJNlRDBhdqSG
	 CHoZ9EYkg6K/Bsnoxoq+jQ6zxlSWxomzNyBaQsxIa8Xqnemkus+dbGLULfb6myCyrr
	 lpn6/dZXr+fiOKvHTyQvLSL8agljemhUqM7NbK2azsRc7+D9+srrdVcw5rruN82JCu
	 PidjtIJoXR4oQ==
Message-ID: <sashiko-outbox-164340@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] calipso: update payload_len when removing the
 CALIPSO option
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <179138670045.80227.16292613517250896744@gmail.com>
References: <179138670045.80227.16292613517250896744@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 15:26:01 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] ipv6: calipso_skbuff_delattr corrupts IPv6 Jumbograms via payloa=
d_len underflow
- [Medium] ipv6: calipso: calipso_skbuff_delattr() fails to invalidate CHEC=
KSUM_COMPLETE
--

commit 8fb4651bac6a1dd9a8a2f7c1f3e21afbeec3108b
Author: Joas Antonio dos Santos <joasantonio108@gmail.com>

calipso: update payload_len when removing the CALIPSO option

calipso_skbuff_delattr() removes the CALIPSO option from the hop-by-hop
extension header, or the whole extension header if CALIPSO is its only
option, and pulls the skb by the removed length. It never updates
ipv6hdr->payload_len, so after a successful removal the header still
claims the original length.

> diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
> index c6a34334e657e..c072eca501070 100644
> --- a/net/ipv6/calipso.c
> +++ b/net/ipv6/calipso.c
> @@ -1428,6 +1428,9 @@ static int calipso_skbuff_delattr(struct sk_buff *s=
kb)
>  		skb_pull(skb, delta);
>  		memmove((char *)ip6_hdr + delta, ip6_hdr, size);
>  		skb_reset_network_header(skb);

[Severity: Medium]
When delta bytes are removed from the packet, should skb->csum also be
updated (e.g., via skb_postpull_rcsum()), or should skb->ip_summed be
cleared to CHECKSUM_NONE?

An IPv6 multicast packet arriving with CHECKSUM_COMPLETE can reach the
NF_INET_FORWARD hook with its checksum state intact, since ip6mr_forward2()
does not invoke skb_forward_csum().

If SELinux intercepts this via selinux_ip_forward() and triggers
calipso_skbuff_delattr(), the packet is left with an invalid
CHECKSUM_COMPLETE state. If the packet is subsequently forwarded into a
virtual interface like a veth pair, the receiver will drop it due to a
spurious checksum mismatch.

> +		ip6_hdr =3D ipv6_hdr(skb);
> +		ip6_hdr->payload_len =3D
> +			htons(ntohs(ip6_hdr->payload_len) - delta);

[Severity: Medium]
Can this underflow when ip6_hdr->payload_len is 0, corrupting the IPv6
Jumbogram length calculation?

For Jumbograms, payload_len is explicitly 0 and the actual length is stored
in a Hop-by-Hop option. Subtracting delta from 0 underflows the 16-bit
integer, resulting in a large positive value.

Subsequent IPv6 stack processing will misinterpret this packet as a standard
IPv6 packet with a large payload rather than reading the Jumbogram option,
completely corrupting the packet.

While calipso_skbuff_setattr() also incorrectly modifies Jumbogram lengths,
this underflow logic on the delete path is newly introduced here.

>  	}
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179138670045.80227.=
16292613517250896744@gmail.com?part=3D1
