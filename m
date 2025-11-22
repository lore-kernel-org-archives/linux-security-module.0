Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FAC1F95C
	for <linux-security-module@vger.kernel.org>; Sat, 22 Nov 2025 23:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763854544; cv=none; b=hudqsLU49BRT8yMSAA33e5YXtaIJEZg3I9J4Sm+TmmCf+GZg4UxVnei2zf12F07ODCsjDGXr9hbzXBl4xeIdAA5AatpkVb6K9ISWdtji2pjAwUhaYhGMwDsqms+b65aKZGcG5PWjTveOKFX4n8XEZx2XGOlm9yqT2Fo/bF8U8AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763854544; c=relaxed/simple;
	bh=sVccsN6niw2w9ZlGQ2nfa0sh0ZCIXCR+5GFXbeF82hE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H27iHikcHL9ATGPkoYgcTI+eUAxX8Ob5Qtk7ljyZ1tGQYIfa+dUJ5JzGrvdxFStKCtzBvoHXoy+TKjb1j6Z3Esfc50riIbzEdjrQXucHCVKVtd7fElJ2iTG+wk+XT9lY24Q0Fbzutgnd3giAb0jJc7mh0WH+sSXN+8O7fnOovCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=UR89cBsY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lVFdjga6; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="UR89cBsY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lVFdjga6"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BC31E14000BA;
	Sat, 22 Nov 2025 18:35:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 22 Nov 2025 18:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763854540;
	 x=1763940940; bh=U2W8RfUHtiFCvKU+e7gTwAjP8oBL0FAZvF6dg4ijV7Q=; b=
	UR89cBsYmBWpnIoXwaDnJhJbE6+ihPr3HDT8pPMOZTgytNYMv4bKcywtI4m2lVCI
	hImDu5xlceDjX/cKLPFF0TQMDqcZUFD+A3SOi8P1GsUM3A0RymKMD1t7NUXWPQfb
	HJ3I+n0TgD7jqFlhaR8YE7xB+jNEqmLlS7Llfetz43lG0ZENGhxPSZn2vKmTeVOj
	kAYtmWiZ2H/2zARh7vjb/uGdLPABLNSPqnzKXoSEWX7mjr5cgUHocvBEvLzNy4HB
	CdG82wL3/1tLHuroPT5c0dwiM9zkiUzDm4ggFrL5DkGUKWvPuaskSD4n0eDuq+Ug
	jbsRyqMZz5L1H2B7MD1K6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763854540; x=
	1763940940; bh=U2W8RfUHtiFCvKU+e7gTwAjP8oBL0FAZvF6dg4ijV7Q=; b=l
	VFdjga6LakO+Gwv30BLkSIF9GpAE9Nj2DuBFGB18sutM3MdfwfkEBaW8+vNbynhW
	pGFFs+p3QbeBcpAF4yXOz+OmY+duXPBskElvi7D4+Y4DGuAJYkzOBVfz99W2OHDY
	hT2bKiFNydmqaK2xxjQh5ecypYI+LS2b+0Lfc0GoRE10ZaQtq9bQyPj4EBR/PuUh
	cps3EUflm/As5jYZBgvsrwkNoAMjTlO4+PZ9p4EjWx+ivFXd5Z4zIzNYKeRlNt/y
	hUGL4qb3cli3GhUGzRp/DR4geKVZov74Iqk+6DWAs9bDUSyDRKxKSQ0ZG6P+yW++
	NT6K2+ycaiMxyToQUuNVQ==
X-ME-Sender: <xms:zEgiaYswO91qwdIMcnw3yG6kOovRhoGJgQ2Bwvbji4Ax2Tvshp-W6Q>
    <xme:zEgiaZLOZaFn1Sc_tYRUV1MV0I7ZvSSUZE_Q4wCw91XEJIeS4j1OYN7YfOx4Hj_eU
    McfzsQbzW0M7aY6x-PIS2zPYV12cGBazsLzMbk1WzPcVMvQqY8y3f8q>
X-ME-Received: <xmr:zEgiadl6S4PeXJAudSg9YzO9mLit_qbWjdTyPoRhcA4xwOl6LtPK72118z7wWTphZH3TzDOlnQ6epZkh2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeegudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepud
    ekvefhgeevvdevieehvddvgefhgeelgfdugeeftedvkeeigfeltdehgeeghffgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehuthhilhhithihvghmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgt
    iidprhgtphhtthhopeigrghnughfuhhrhiesghhmrghilhdrtghomhdprhgtphhtthhope
    hmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtoheplhhinhhugidqshgvtghurhhi
    thihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zEgiaSK0ewlgyNV_mN3DSqAl2aA8A_9R9-frvhxxRmbfRljpW6bdJQ>
    <xmx:zEgiaa4NUB8XjC6coo9hHM5fgzSQanM4g5eDh1p4_mOfcTpe5FDWYA>
    <xmx:zEgiae1F-FDqQw8XwZKsj2DxOPWxY_WjlBm1HZnR8J7_n0BiSYeeQw>
    <xmx:zEgiaYcqDZP_T0g-c0OSiQhGe60y2kGs47fAj4g-Kp8V0_BgIxGbsg>
    <xmx:zEgiaZzoIkntzebwbv07bVZb3wftkbcVpKN8pb6X4gX5t7cgrPtWV2QH>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Nov 2025 18:35:39 -0500 (EST)
Message-ID: <baa3449e-e238-4caa-a16e-c252016bf480@maowtm.org>
Date: Sat, 22 Nov 2025 23:35:37 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] landlock: Fix compilation error for kunit tests when
 CONFIG_AUDIT is disabled.
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Jan Kara <jack@suse.cz>, Abhinav Saxena <xandfury@gmail.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 linux-security-module@vger.kernel.org
References: <20251120222346.1157004-1-utilityemal77@gmail.com>
 <20251120222346.1157004-6-utilityemal77@gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20251120222346.1157004-6-utilityemal77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/20/25 22:23, Justin Suess wrote:
> This was necessary when fixing the no inherit patch in the implementation of kunit tests.
> 
> When compiled without the audit flag enabled, kunit tests would fail to compile because of
> the missing quiet flag field. This fixes this issue.
> 
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

Thanks for spotting these issues!  I will include your fix in the next
version of my patch (it's not merged yet, so mistakes can be fixed "at
source").  Feel free to reply to my patch directly if you spot more
problems :)

(For the landlock_log_denial one, we might not end up changing the
function's parameter after all - Mickaël has suggested the rule_flags be
embedded inside the landlock_request)
