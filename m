Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A9B392C50
	for <linux-security-module@vger.kernel.org>; Fri,  9 Oct 2026 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561459; cv=none; b=kXa9o4QRCINEDc7Z5iILEJf15DKaR0wv7AVXsMKTuKmWf9INeXGV5RjBY/YNqOaTFwnlTMfs/X/KALDD6O10JrAqwP4E6QZD0ElXnYwO7T0UINZ+2wuoS65uiZj2IVvDusKSv1n2f5bVc3AFKu5sxooFf5T7WLGSJBo5jscWrnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561459; c=relaxed/simple;
	bh=Mpg94/pFhPBcqMak96469hcEggzTpmAD2c4XXoOujhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c9JKl8Besh3DW0Pw2DBJmsB6uD3gS5ncsVSDfSe6S6MtyUOn3AfsbJG+mDS7gpSS7Ze55fnmm4cdjOt9qWH6IhFOh83IftxecAD5wrzEW/4pMBa/1M7SzOtWE9+CFm+yGhNTj5b6ICiwpB9k2bLRh5Sa5advijHBrTjfWlhHUXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6y7YjRF; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6y7YjRF"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7cb590dcbb1so154914137.2
        for <linux-security-module@vger.kernel.org>; Fri, 09 Oct 2026 08:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791561457; x=1792166257; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G4pkQpZGByfs6jaHMa7nJIVkDQrQWOU2ACAqg+X74hw=;
        b=i6y7YjRF3exiYLBNjF0eSvuSQZ+sDdxxtIe+vioYWRkh7CAl1T9O53YQwaFRgA9oFQ
         +/dqfsT+MBHc9PpIzUc7s0vJm+gBnLLV39x5J8g/eNqBPqExIghjjSQAtp8gJZ3BbH75
         PYIbi/wW9zZUaoEnyCIcOmrDj9hNq5yHr5CrOzOMVDs7Cfm8g7r3L/VRXD1qsEfLnW+U
         ahBrJjMc5w8S4NJ3E9EAwWR6rizQZEapAMEUjYFwqvSJkRdPT0PbpcpAc8FZAWdoIj+e
         J0wtNZhcQ2t82mYqvq4quNKK9BEZ0PhAZcXOWUoEmfknNUqIXJDZMUEbR9hq/v+duYBo
         ZY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791561457; x=1792166257;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G4pkQpZGByfs6jaHMa7nJIVkDQrQWOU2ACAqg+X74hw=;
        b=y5im2dmj3mcHU8xf65oP5z6CLZ8eyYFKfPa/9H/44hkEwiYIvaz6bxk82+tqorRmp9
         uVbNI/RnFZumBZ/b03tAHxKcRIVwDjl5UFcj4pcdZLil2lvCgj71fH/ChwZ9VMjMhOG0
         HiSnK/UtJbT9zfonuXOIZA0JMdlZFZ02xZCQIkwixuU6Vc2D7K6vu0iHntzawhPz862+
         IidrddUtjjpgWjIf/xtLG9IzJ372+IfmEOfpk8J71KuF5/TVpuVJAHkKpnNXlB1lmNVq
         VljHyZrFslNv3AmDobzigziUCb+BkSvCOWn91vcnqeUAKyYYpllLqIqh6ONvYCFSecz9
         roWA==
X-Forwarded-Encrypted: i=1; AKwUvBxgvln83njqDAc227Zl0aUig0JkNnmT6SF8V7JgOIseNoaTbsY1rYZvX0atSqgM/smnsOClm1yQ21YLtCnLbqpSSRzA57c=@vger.kernel.org
X-Gm-Message-State: AFq9FYLiomGw55pLoeqVPr3zKpzywo7TnQsxVX+85S3m8qgNYEXMzTmW
	aWbr6bsSoBRmvHnU9qSx50mR7rFLcx09b3DQ4F8K/8SyxZsWAI+AC7kZ
X-Gm-Gg: AYBFou3JtwhVLruoJXhW7+SxUdwC8anjF5ZLF6DX839iRUdBCgpF0s2RPy8WEV+0yW2
	s0TldRxdVPhrCoeQVIk1tAmGiG+Id3wSJ0pKAclxFg5tbW3qaPovR916Da7jv/FFmI79DuuiAmI
	O2GkRLZrvarBsOI1AMsDxIlB7kxKVcpOWp+kzc8O2JP2IPBV8eQz5Sq7JiICh6W/UTHgtjWcKnU
	yjUlsBLhdc/YtkI05Tb18LO7mWb7phFjBpGRx4EkohL+bzhgMepaC6AllpmV2YVDWQzKZj0mJOT
	q6DnlfMt2+LRLoPnkglNbVsSa1dUfgFwESwO1GSkbiDVuC5qttuyVLHfa5NFbed0MK6b/84Fqrd
	Vh0+LxfWjPBwWvqMf8Z+JJJ9q7WnVaYxBe4ljjGZQ10SHGCMVycJ5Ej28Xa285MKk0RWzlcWi2r
	g09sIr0pDQoW4idEFvsGsq6szW6LfCWh4Q0HnNUOMNalJYOGeMx3FETW5kmTBnBFGbZnb4nJAEU
	WITW/RDU8egps4m3PypMf0ZPNk2woE6+Q8esDSomxQzad+rdl4LykIZvL/KrL0uzD9dTXzuqNoq
	T23MileAqgKw7mzQ95nfd7hkk7/zGcR4sOAtPkMv1imhl9TrKBgukBzCMYek
X-Received: by 2002:a05:6102:5114:b0:7a7:195a:1b29 with SMTP id ada2fe7eead31-7cb375057ebmr674951137.35.1791561457026;
        Fri, 09 Oct 2026 08:57:37 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2804:7f0:b100:655c:c59b:456c:2d4d:2359])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cb35471536sm1860352137.11.2026.10.09.08.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 08:57:36 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Wang Zhan <wang.zhan@smartx.com>
Cc: netdev@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
 Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-security-module@vger.kernel.org,
 Alice Mikityanska <alice.kernel@fastmail.im>
Subject:
 Re: [PATCH net] calipso: keep BIG TCP payload_len in calipso_skbuff_setattr()
Date: Fri, 09 Oct 2026 12:57:30 -0300
Message-ID: <179156145081.36175.9867662260614090326@gmail.com>
In-Reply-To: <20261009084616.139462-1-wang.zhan@smartx.com>
References: <179147330473.58090.15760316487710432833@gmail.com>
 <20261009084616.139462-1-wang.zhan@smartx.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 09 Oct 2026, Wang Zhan wrote:
> I think there are boundary cases around IPV6_MAXPLEN: growing past it
> can cause payload_len to overflow, while shrinking below it leaves
> payload_len at zero.
>
> Could we use ipv6_set_payload_len(ip6_hdr, skb->len - sizeof(*ip6_hdr))
> to set the length here? I haven't checked the details, though.

Hi Wang,

You are right on both.  I checked them with a test-only debugfs hook
calling netlbl_skbuff_setattr() with a level-only label:

  case                         v1 (this patch)   your suggestion   real
  65530 GSO, grows past MAXPLEN            10           0          65546
  65540 GSO, shrinks below MAXPLEN          0       65532          65532

(0 meaning ipv6_payload_len() falls back to skb->len.)  The other cases
(normal packet, BIG TCP growing, shrinking a normal packet) give the
same result either way.  skb->len - sizeof(*ip6_hdr) is the payload
length there, as the network header was just reset to skb->data.

I will send v2 with ipv6_set_payload_len() and the test table once the
24h are up.

calipso_skbuff_delattr() (the other patch, v2 already posted) only
shrinks, so it cannot overflow; it can leave 0 when a BIG TCP packet
drops below IPV6_MAXPLEN, which ipv6_payload_len() still handles.  I
can switch it to the same helper for consistency if preferred.

Thanks,
Joas
