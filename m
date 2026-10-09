Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25574D0CDC;
	Fri,  9 Oct 2026 11:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546133; cv=none; b=dYHsUMZaxaAX16G5gbbAy+IGPHi0T/bYNSSgDnU67QP8gsFNsDfpCFT/mLrOuk499lwhoYfu7wyn3Up5pWux/mX6HO+ZFB6s0hi/TPcs56nd+SDLrDjYQWKlr4GXugZzxArxrEzCwr1FspGcC2wUxpQitYzw41mMdH7988AmuhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546133; c=relaxed/simple;
	bh=/ytrXwjy/3GbsfN9HIye1HopERZbJiOztI12NgeN7AU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5U8O3K57y2ln0Lcsvgj8DQiNAiAqzI8Myex0dGKH3223igzLdmNJhRgyxmziVwP3qktoSdO8Zjg6U/rVWXfQO+1KtYjTd9OqDF8YFg160SKZfRMk8JuhdX66LeJIOkUi+sXNWlA/zJFKNarQLu/FiBduYMyXt4PpSe7JbvRDmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=F1wVplm4; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="F1wVplm4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791546126; x=1823082126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/ytrXwjy/3GbsfN9HIye1HopERZbJiOztI12NgeN7AU=;
  b=F1wVplm4M5BZ7FGAskRbyDCs9ImRTcDxOtqHFuSsxShKAZnqceWHiWVJ
   6A7zf58KVUsVlG1/hYlv12DLhopWNOr4jF0QbSUVM12D5Tn+NtwFLca+c
   k/QK5h9g2NQo9/1idYLllU3KL4OHp3Q2tBoCs5M1fwHmm/AAtqBtl8uiR
   rFbEmEhr0ZiL0oGP+l6fQ5Llcp3IF+hRfUDaa6Js9KxPUFzqJl0Y711ll
   xstdrNpTcwhPsZUyZdDPVfCaZu+NDGoDqq0+F3LWC/7kyC3zHGqlZ9NRW
   sYf9XSVYVN3jYa44JN0JpSqHFd+inQeIGGG57Wbe0fxGnQyIAj3Anax5l
   A==;
X-CSE-ConnectionGUID: 3R8Tm/V9Soa4dBCQpbSVPw==
X-CSE-MsgGUID: /9iBSp1iTX2vXlosCZDWeQ==
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="75126207"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2026 04:42:05 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 9 Oct 2026 04:42:05 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 9 Oct 2026 04:42:03 -0700
Date: Fri, 9 Oct 2026 13:42:03 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
CC: Paul Moore <paul@paul-moore.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH net-next] calipso: hash the cache key, not the option
 start, in calipso_cache_add()
Message-ID: <20261009114203.e5fhom6ncokmzevv@DEN-DL-M70577.microsemi.net>
References: <179138670045.80227.16155454353416856947@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <179138670045.80227.16155454353416856947@gmail.com>

> calipso_cache_add() stores calipso_ptr + 2 as the cache key, but
> computes entry->hash over calipso_ptr, i.e. starting two bytes earlier
> at the option type and length.  calipso_opt_getattr() looks entries up
> with calipso_cache_check(calipso + 2, calipso[1], ...), which hashes the
> key itself.
> 
> The two hashes only match on a jhash collision, so the CALIPSO label
> cache never hits and every labelled packet takes the full DOI lookup and
> category conversion path.  The memcmp() on the key keeps lookups
> correct, so this is a performance bug only.
> 
> Hash the stored key, as cipso_v4_cache_add() does for CIPSO.

FWIW:

I tested this with a small throwaway KUnit test: put 16 labels into the cache,
then look each one up again the same way the kernel does when a packet arrives.
Without the patch none of them were found (0/16), with it all of them were
(16/16).

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
