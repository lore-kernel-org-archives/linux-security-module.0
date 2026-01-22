Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7320D358D13;
	Thu, 22 Jan 2026 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769081542; cv=none; b=OaEMnJQghCNMg8QDbZzeSDgBaBtnHQcJEeNBpRma/UNA0mShG0zh+iTqdy11Kw4Ldm9VBi4uPx5NWXJnzAn5xAzc/HyYAUy/cfQXoOXEmlw5dI9kunaf5VV/PV0dryVW23iD8VKYFdC8eus1/6x4jdNxKRF3B/fD3coXgGlA1zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769081542; c=relaxed/simple;
	bh=Oef5xctHI8v7fFpqPEZMrxAZOxlin0yJSzkc/GnLVPA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+nAawwUDGFWKgXDKJXl0kiswBKr38uKPA5h9yf98bJn3wbybY1tS9K5D57V7YpGlzEpeGyrREOmv0r4eLyal2pHoGG8nm3muszyLOv26mnpiXe+/YP19GnvtRcsYDjWQaTW/wMFazz4jKikUlAb6PYqJEqmJhmanfx5rwFbrWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=hnUBiP76; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="hnUBiP76"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5591420612;
	Thu, 22 Jan 2026 12:32:18 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ABFtNYbnaoXt; Thu, 22 Jan 2026 12:32:17 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id CEC902088E;
	Thu, 22 Jan 2026 12:32:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com CEC902088E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1769081537;
	bh=/eq8UMKclos0k96diblmhWZCbedG/oCLn4nWsSqxvYA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=hnUBiP7609lQ5lU5VbPxTw/jRKvNHhfC7oGRM9qRaXsiUCzRaGCTRhTocY5Ob7/sm
	 J8KBdN08PWQm+te8rGMC5N/swmjvh1pRI32OJbqQoKVGsCX/Ftq180DYYUvfuCs5fE
	 7vlueCWAbr4dghISr0Giq+1uMkclaZfj87M5TIeeNmHUCeLDWx1wOMcy9IHzsKnUX6
	 VUdbdYY2XvfZW0EVXsjkOUsPUJppHLYKRPFJabnaLNhYnCc0C/2qYQhN3MOp1tpD0/
	 /GxOA13X9n5KtbDBSgDIaSLfQuX+kWBz/7RJnSQl+A89YBbY47sXhLuC2VJj/y3x/Z
	 6/EC/XqkDXmYQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 12:32:17 +0100
Received: (nullmailer pid 1712837 invoked by uid 1000);
	Thu, 22 Jan 2026 11:32:16 -0000
Date: Thu, 22 Jan 2026 12:32:16 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC: Boris Pismenny <borisp@mellanox.com>, "David S. Miller"
	<davem@davemloft.net>, Florian Westphal <fw@strlen.de>, Kristian Evensen
	<kristian.evensen@gmail.com>, Leon Romanovsky <leon@kernel.org>, Leon
 Romanovsky <leonro@nvidia.com>, Raed Salem <raeds@mellanox.com>, Raed Salem
	<raeds@nvidia.com>, Saeed Mahameed <saeedm@mellanox.com>, Yossi Kuperman
	<yossiku@mellanox.com>, Network Development <netdev@vger.kernel.org>,
	linux-security-module <linux-security-module@vger.kernel.org>, Aviad Yehezkel
	<aviadye@nvidia.com>
Subject: Re: [PATCH] xfrm: force flush upon NETDEV_UNREGISTER event
Message-ID: <aXIKwNJv59KnsnLw@secunet.com>
References: <924f9cf5-599a-48f0-b1e3-94cd971965b0@I-love.SAKURA.ne.jp>
 <537343f7-c580-43b0-9ad2-691701b9fb8e@I-love.SAKURA.ne.jp>
 <287edf7f-85fb-46c3-9c70-c8ec7014a0db@I-love.SAKURA.ne.jp>
 <aXIGxmCB2QU86-iA@secunet.com>
 <447378de-3cc9-44f5-872e-a1fc477f591e@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <447378de-3cc9-44f5-872e-a1fc477f591e@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

On Thu, Jan 22, 2026 at 08:28:31PM +0900, Tetsuo Handa wrote:
> On 2026/01/22 20:15, Steffen Klassert wrote:
> > Hm, I'd say we should not try to offload to a device that does
> > not support NETIF_F_HW_ESP.
> 
> I was about to post the patch below, but you are suggesting that "do not allow calling
> xfrm_dev_state_add()/xfrm_dev_policy_add() if (dev->features & NETIF_F_HW_ESP) == 0" ?

As said, I think this is the correct way to do it. But let's wait
on opinions from the hardware people.
