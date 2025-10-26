Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2E519A288
	for <linux-security-module@vger.kernel.org>; Sun, 26 Oct 2025 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761512473; cv=none; b=RtWadsFoSEI/ZZTgpzT4lQx2yEJH/cXXAr6ZE6b1Z3wjQMJtoc0X6NA8MGg7EVekrqFPjI2i8NByhY+fqm8dtN/Ii3FDXuZtR73psryiEmRLYk2IO6eKNy/hNkR4oUb2pjxhCQSuEhkQ9269MIe9J30zJdjf/y3JcHuPqehELHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761512473; c=relaxed/simple;
	bh=2REOOhu1X1I+t+ksgII1awCoKSYPkTHfP3HSl4jMdCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtRt+CTm+AByvVPiRL6Yop6YmDCoAxZiHjM8GJ81Zxd01BKWHirr6cLkVJ+1jYdybY/6w5Ek73n92nJU53BEjwr19Cmln6WqTKzrMFW0oNRQAF/0j9XrY/4LqBebNDovoQVDocgUTsFgR3RCmxkOsOBeZE7A0FeCx+6tkuFf358=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=clCk9OvO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K3GlDx2+; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="clCk9OvO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K3GlDx2+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 30689EC011F;
	Sun, 26 Oct 2025 17:01:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 26 Oct 2025 17:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761512469;
	 x=1761598869; bh=nm2gP3sdE5I83DbMOfq+59U2sZsWe9hhxFZcHH4DEE0=; b=
	clCk9OvOy6Z1oCLtpauuEB4i8H1b/NZyc5RDAr3TUOAageyxHbXxLjsq8GcV6UBc
	JbRogkhMUf5PoMkhJEIx4d9HBU8/nWcPe0mmqh/gLuQ/KjkBcSmVwkW9dVZC4VqZ
	NUkp7b65Os65p5Ivf5utWJ6Wjc1KCE7xxxUqNiuMWrhnsUXJKFvhcYEdygKSiwxM
	KJkxIdNj0wx+Zlpx58nd7Cf5Y6Ot/OfkMG7vqv+j7WihjjbZawYtNPjLNSBV5UtU
	54TczvvgfuOLLhFDZxPiblA0LG/B2L5i/SVscOVjvB08oeb7Fbh1DHm4c2kI8SNm
	fBhmzPFwac7jft1JqdbqqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761512469; x=
	1761598869; bh=nm2gP3sdE5I83DbMOfq+59U2sZsWe9hhxFZcHH4DEE0=; b=K
	3GlDx2+OjEslu1/2SHrUcZYUrXJNhmUDJJfKsx9IbX8eS+M8Ri5cKpMOjlt2JZqw
	sFGyH1hM9bpY+oh4uefzsCdgMuw82mDP2vO9Nj2mf6t3rqunE88iKaJDRlfIhgX+
	AJl1BLYKl9nZBWhDu47EWD2qUcEcOUjJUF8UtX/Vl1uqbamzzLeDNyDOANJMQZYA
	ghOklJRZ65ujrRz171UbNzL3hR1Rh2jJEn06eOe8vt/Sjj+Iw/05JoMab1zMOjwe
	pyu9KAb7Y/Ddx9IJGfC70Ap2F/+DokLpVD5UBe2kYyWGigFNyBWRk0tCgQQMUcoC
	S0oFRA5/KHJYvsEe1xK3g==
X-ME-Sender: <xms:FIz-aAAQzZDQyAIxZv3WzpEtnk2csOPZdkLCPLzifhVDulBuY2uIbg>
    <xme:FIz-aJa23L5x1YcmzXiQSM59PhWhukGLox3e6GkO4yDYhltN7RQdze-MRG_OPlkuB
    BNWDX1jT1zOk-xxYF4B1IejtbqYnGPCuOXteUYgXq2nue_y6sWhbwM>
X-ME-Received: <xmr:FIz-aL4UX5lr6iRF8xFc7cK0HJBETE3oS5h15CPsSMf2RS8g8PFp4cbKEOUkzQVSD_-2DW3f9tF-GHZB_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeiuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepfe
    dvheeluedthfelgfevvdfgkeelgfelkeegtddvhedvgfdtfeeilefhudetgfdunecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthho
    peigrghnughfuhhrhiesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvg
    gtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FIz-aCaz5yKVmApzijZGy1rdbO651SDLt80IzAn6N4LFKeJmFL4DRA>
    <xmx:FIz-aCgouVfdfDgJ_kL1UIkYButWqUYRZ3paecx8LU17WJ1Az4PFbw>
    <xmx:FIz-aL9ixmza3Ip1dliCiQg-6YjOwVYmGuw-bW5LmwOLZzhIAtIrzQ>
    <xmx:FIz-aFrtfI0_TPoBx9A7KjAMRdpzykdV0ZJoqgn0-NUDxMGW_eAOXQ>
    <xmx:FYz-aL1ZV8TLGlOPYK2lMM-_FY4taPsmw2cDeOnsyiK_IJcViZNL4QyU>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 17:01:07 -0400 (EDT)
Message-ID: <86e98429-0e3f-41a1-9dc1-0470912eddff@maowtm.org>
Date: Sun, 26 Oct 2025 21:01:07 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] landlock: Add API support and docs for the quiet
 flags
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Jan Kara <jack@suse.cz>, Abhinav Saxena <xandfury@gmail.com>,
 linux-security-module@vger.kernel.org
References: <cover.1761511023.git.m@maowtm.org>
 <2794ddec86d8f24bdfe8a4b3adae18a5f0c41494.1761511023.git.m@maowtm.org>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <2794ddec86d8f24bdfe8a4b3adae18a5f0c41494.1761511023.git.m@maowtm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/26/25 20:44, Tingmao Wang wrote:
> As for kselftests, for now we just change add_rule_checks_ordering to use
> a different invalid flag.  I will add tests for the quiet flag in a later
> version.

This message is out of date.  Will remove in v4.  (Also will remember to
put these sort of things under ---)
