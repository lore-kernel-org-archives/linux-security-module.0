Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AA84E0B82
	for <linux-security-module@vger.kernel.org>; Fri,  9 Oct 2026 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791559709; cv=none; b=AeDemCUI8Qh7A/UnSTEiXuDf1iKr4es+ltpMptJTwWuwNvPlmRTLT2yx+/Ni4P6zKBcfdU0/qfHO5+zKuzRkymM1082rtKleB7t0R1ZDz8dHi7lggz1hcZcu1D5LMeyMWbI9qho/d1tpP209mfd/A+30SKGWcuVXne1UzNxk5C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791559709; c=relaxed/simple;
	bh=Cqg4ETqiofDWZ8GpXH7BfrffQ5jhKpx+824luu1neTk=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=cKxQ0hV3eJwOrSBS827UYtIL2R3jSjhYiZI5u8uqJn4EC2IerAJxg77ve9UTjTFlBuCVRlorzmx7B7b7a6jgZlWDwWpUXqJ1LH+lc/YMOQn/i04FnRApinmKwQF8MWbfltpxa4cODl4epBuga3XJknHP0sptW5SVf61LSh4gouo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xe0pb3LH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xe0pb3LH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A201A1F000FF
	for <linux-security-module@vger.kernel.org>; Fri,  9 Oct 2026 15:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791559706;
	bh=I3pwdnC2Wmcw5e9SAMrkAa4BnU0IJwxmG0HjYctzu9A=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Xe0pb3LHyRf1QLGXC23pSoKJhY4iDIOgdnhklBZ9SzREzUDhSc4WDjCJGupsvLx0f
	 HUsz49Oj/5H58LhiWhU3pnPdEI6Z9WrYL4cymniq5yIPzn5Zv7/YOzKLMpsmUlgapJ
	 hjYIPQhdkLs6j2uxUbZq0Uz5igLWE/kwrh1Wiqu6nvRVigYiWo7OD82+VbKXbpFrNi
	 c2DkTVAAMiSdoYhabhOsS+cct2Th5/7wXlNM/j36zKqW4fGAOn7w+/DWuBtzJ3yhHT
	 nCSAPCDUYj3kfw01BKLFOjeFFAFnWeumkMNQeXj+xAQL5SoBHaY0pC2d6sWbxZuPxZ
	 QCZlWkyY0xmVw==
Message-ID: <sashiko-outbox-165773@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] calipso: update payload_len when removing the
 CALIPSO option
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <179147329205.58079.5847298721173675285@gmail.com>
References: <179147329205.58079.5847298721173675285@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 15:28:26 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ipv6: calipso_skbuff_delattr corrupts MAC header on bridged packets
--

commit 9797bee2d14350b4afedb726df3172b004b7badd
Author: Joas Antonio dos Santos <joasantonio108@gmail.com>

calipso: update payload_len when removing the CALIPSO option

This commit updates calipso_skbuff_delattr() to adjust the IPv6 payload
length after removing a CALIPSO option. The patch prevents forwarded packets
from being dropped as truncated by subtracting the removed length, while
leaving BIG TCP packets unchanged.

> diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
> index c6a34334e657e..5a42db4f87472 100644
> --- a/net/ipv6/calipso.c
> +++ b/net/ipv6/calipso.c
> @@ -1428,6 +1428,10 @@ static int calipso_skbuff_delattr(struct sk_buff *=
skb)
>  		skb_pull(skb, delta);
>  		memmove((char *)ip6_hdr + delta, ip6_hdr, size);
>  		skb_reset_network_header(skb);

[Severity: High]
When a bridged IPv6 packet with a CALIPSO option is forwarded, br_netfilter
feeds it to the NF_INET_FORWARD hook where SELinux may call
calipso_skbuff_delattr() in net/ipv6/calipso.c. Does shifting the IPv6 head=
er
forward by delta bytes here without repositioning the MAC header create a g=
ap
that corrupts the MAC header on bridged packets?

Because bridged packets bypass L3 routing and do not go through
neigh_output(), the bridge's transmission function br_dev_queue_push_xmit()
unconditionally calls skb_push(skb, ETH_HLEN). Since skb->data is shifted
by delta bytes during the pull, this incorrectly frames the transmitted MAC
header starting delta bytes into the original MAC header.

Could this result in the transmission of gap bytes and the loss of the
destination MAC address, causing severe packet corruption and drops on
L2 forwarded packets?

> +		ip6_hdr =3D ipv6_hdr(skb);
> +		/* BIG TCP packets have payload_len =3D=3D 0 */
> +		if (ip6_hdr->payload_len)
> +			be16_add_cpu(&ip6_hdr->payload_len, -delta);
>  	}
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179147329205.58079.=
5847298721173675285@gmail.com?part=3D1
