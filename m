Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357D244D01E
	for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138376; cv=none; b=gZpLSpY2NP9pLxHsYA+JDW+8oc5kE/79I7lNx3HKR+Q9Tzw6Q4pairQXeDaRDLi/xcQyzQB8qi8BsfvG57iu6vBmN/6992uqjxEgpKN7quhyLzHFc5E0uGEqW8hqPQNHI0FNCnS/pv60giY6Qz4FQHaRlAV/XaGbWETNfxPiGms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138376; c=relaxed/simple;
	bh=GRDbizvGMpNke/p0WUm/41qICMJyjoWyNcAmFCgdDAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=GREQdZXy0mjAug6PZZYJ0RUWBU4IncUxyU8b2Cek5Ax3vkoPdV5ZJGf2EUDg6tgn3H1IDb92kEpG3bb7IL882QHdnNR3/AWz7p8fH0SoIQU3uSl/UgkJwV8TWxqGg5N2+V2aByIA7djMoncmgUpn1EyseMKj/ySFQMQRzpU+Cco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UJarnKwU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJarnKwU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773138374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XtVLt2ML1J1ffuBphSH/gYIYlcPTeexrkhKaWI0sd/g=;
	b=UJarnKwUhgh++QjwQlf9RzsATr5hxllVT8PELawr7k1SGC8P8APQoC2HPg6Sq6zmNSJH9u
	wZ8bHke1TaARXWyWp9B9DJpzQPNh710hN4/GJjP0SOp7e+dT6xkIytyUFV5pVdtMRWGwA0
	L7IQ8QELOMc2YInUmg4m8enm821vKVw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-8_4XBOMhNSWhs261kyTL4A-1; Tue,
 10 Mar 2026 06:26:09 -0400
X-MC-Unique: 8_4XBOMhNSWhs261kyTL4A-1
X-Mimecast-MFC-AGG-ID: 8_4XBOMhNSWhs261kyTL4A_1773138366
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D728E19560B7;
	Tue, 10 Mar 2026 10:26:05 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.133])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2CCAF19560A6;
	Tue, 10 Mar 2026 10:25:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: kuniyu@google.com
Cc: willemb@google.com,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	jmorris@namei.org,
	casey@schaufler-ca.com,
	paul@paul-moore.com,
	kuni1840@gmail.com,
	fw@strlen.de,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: Re: [v2,net-next,07/15] udp: Remove partial csum code in RX.
Date: Tue, 10 Mar 2026 11:25:55 +0100
Message-ID: <20260310102555.147680-1-pabeni@redhat.com>
In-Reply-To: <20260305215013.2984628-8-kuniyu@google.com>
References: <20260305215013.2984628-8-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: h1zGgr-dzoPaUEtJK6j1-B3Zk0th90oLy5xssyDbdIw_1773138366
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
udp: Remove partial csum code in RX.

This commit removes UDP-Lite specific partial checksum handling from UDP
receive paths, including removal of UDP_SKB_CB fields, simplification of
checksum initialization functions, and elimination of UDP-Lite guards.

Link: https://lore.kernel.org/netdev/20260305215013.2984628-8-kuniyu@google.com/

> diff --git a/include/net/udp.h b/include/net/udp.h
> --- a/include/net/udp.h
> +++ b/include/net/udp.h

[ ... ]

> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c

[ ... ]

> @@ -2703,14 +2647,15 @@ static int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
>  	if (ulen > skb->len)
>  		goto short_packet;
>
> -	if (proto == IPPROTO_UDP) {
> -		/* UDP validates ulen. */
> -		if (ulen < sizeof(*uh) || pskb_trim_rcsum(skb, ulen))
> +	/* UDP validates ulen. */
> +	if (ulen < sizeof(*uh)) {
> +		if (pskb_trim_rcsum(skb, ulen))
>  			goto short_packet;
> +
>  		uh = udp_hdr(skb);
>  	}
>
> -	if (udp4_csum_init(skb, uh, proto))
> +	if (udp4_csum_init(skb, uh))
>  		goto csum_error;
>

Does this refactoring introduce two bugs?

The old code checked both conditions with short-circuit OR:
  if (ulen < sizeof(*uh) || pskb_trim_rcsum(skb, ulen))
      goto short_packet;

This correctly (1) rejected packets where ulen < 8, and (2) trimmed the
SKB to the declared UDP length when ulen < skb->len.

The new code changes the logic structure:
  if (ulen < sizeof(*uh)) {
      if (pskb_trim_rcsum(skb, ulen))
          goto short_packet;
      uh = udp_hdr(skb);
  }

First potential bug: When sizeof(*uh) <= ulen < skb->len, the entire block
is skipped. This means pskb_trim_rcsum() is never called, so the SKB
retains trailing data beyond the declared UDP length. Won't this cause
checksum calculations to include extraneous bytes, leading to valid packets
being incorrectly rejected?

This scenario occurs when UDP length < IP payload length, which can happen
with malformed or crafted packets.

Second potential bug: When ulen < sizeof(*uh), the old code would
immediately goto short_packet via the || short-circuit. The new code enters
the block and tries to trim the SKB to a sub-header-size length. If
pskb_trim_rcsum() succeeds, processing continues with skb->len <
sizeof(struct udphdr). Is this safe?

Looking at the IPv6 counterpart __udp6_lib_rcv(), it handles this
differently:

  if (ulen < sizeof(*uh))
      goto short_packet;

  if (ulen < skb->len) {
      if (pskb_trim_rcsum(skb, ulen))
          goto short_packet;
      saddr = &ipv6_hdr(skb)->saddr;
      daddr = &ipv6_hdr(skb)->daddr;
      uh = udp_hdr(skb);
  }

Should the IPv4 code follow the same pattern, or should it preserve the
original short-circuit logic:

  if (ulen < sizeof(*uh) || pskb_trim_rcsum(skb, ulen))
      goto short_packet;
  uh = udp_hdr(skb);

