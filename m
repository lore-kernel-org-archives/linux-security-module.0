Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7A428540F
	for <linux-security-module@vger.kernel.org>; Mon, 19 May 2025 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747668027; cv=none; b=oJVhlkEZWfobGcrpfI8GrAIdHl8KQdJZ/z95aIN/ttkmEV7tiFi5KHbcleVT3kQC3DvM+O5Wz5EplRYQePVydUcOTJhGBMrDvLYeOJX5/mx+DXWtmAbWflddlvECASIP1IyTd7tzKfl1nyDwmDsHgqEipgXIT12ZM/SOr0RToiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747668027; c=relaxed/simple;
	bh=kZnDixZurz5gUG/KoTDzi0Lgr9DtIWkahDY3K7wYruY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2/dXvzyVvWVgywV/SYAgrBbmLAf/tQSnOXVedocVrLk1Ft/WlpImp+Po51Yc6vYd7ht3byhzII6PxLvcq/VZJZ8KBA66B3BhwZiLa64d8uzRCendLTqyvMWqYb7dtAl7Y9HVOgcLuo8OJCq5lnO8qqvrOValossCUPsBFQ9Wdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zygoon.pl; spf=pass smtp.mailfrom=zygoon.pl; dkim=pass (2048-bit key) header.d=zygoon.pl header.i=@zygoon.pl header.b=cA1ols37; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WgL/VXih; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zygoon.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zygoon.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zygoon.pl header.i=@zygoon.pl header.b="cA1ols37";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WgL/VXih"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id CC47E1380522;
	Mon, 19 May 2025 11:20:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 19 May 2025 11:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zygoon.pl; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747668023;
	 x=1747754423; bh=kZnDixZurz5gUG/KoTDzi0Lgr9DtIWkahDY3K7wYruY=; b=
	cA1ols37wWzbh6pxTG8wYHUpjetEzCw0yxcuzSwcOCDP8r9egrDddCEsmUYXgYaZ
	CVJEhLRtYoeFpff2AN6rFs0aVRSuX9hrb/KSg1obXeXxsFh2ujSo+6V2YBS1D5Y+
	3eluLCdHKFtSzUqAfQaTsMLPOeDzx4rkSU8XF9umYvmskCGwAEDG58PIp651hJru
	FLySUtDa0SRweshFp87gLVpwt5WTrMpa5qvtBLEiNQsaXtHyNDd6vlb6iWSjqHhA
	zRGND3LmDlJbirr63cZX1+2w7nq4jjjploXBzcpJp3eGXE6koaFkJq1l6W2eMDKe
	aL7l8BHW95C2GhrTOmMzfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747668023; x=
	1747754423; bh=kZnDixZurz5gUG/KoTDzi0Lgr9DtIWkahDY3K7wYruY=; b=W
	gL/VXihW4FjkpoxVyuStebuDoRg+keIxpGmB9LHpVpVFUJugscKbpr/etWXVKVSA
	IwT7q+J7qVMt5ZBK0GcA4m+jkGmTvszMAwTD0mqvTrZCxG5fjaATYZYIQ3AbAlIm
	4jnAxfoLuRNrr3HdAyy/g3VOdwUOMqsbgGyMI7yhXUFTV811GVfXVKcWYJBDw2oM
	V8jbvPi6/m4LzRdmklCKvjQtCjAG1Rn7+Dazz51ZtbiwDgbZN2r70i0G38g9H+f3
	2XQygpizK0NiXxTw3Ohqy7y5VTZDJi6QjkFYoz4mWrUgl7DKzq5OqUMRrpGot1b2
	Rk5BO74NDBLwuicwBAIng==
X-ME-Sender: <xms:NkwraDDb1ibx5Cg48NRvm7rz8s6ORh4nj_fc5U7NlQyEIPXi17L60g>
    <xme:NkwraJiPnoptUmINVxUxO12zr5kUJtQKViRUOPT87axlOnpyoWt0ks4F6J6xFP8Lf
    s0qks-Uvm15NB7nAg>
X-ME-Received: <xmr:NkwraOkLBqJ89HVtbf2rFpyI7T6K0Qm6_Hi4-Dbh40Cz39qClgDyYFyXV0Azl11MNdl7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddujedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddt
    vdejnecuhfhrohhmpegkhihgmhhunhhtucfmrhihnhhitghkihcuoehmvgesiiihghhooh
    hnrdhplheqnecuggftrfgrthhtvghrnhepvdffheehffekkeduhfevgeejgeeikedvhfdt
    gfefteeftdelhefgueelgeelveevnecuffhomhgrihhnpehlrghnughlohgtkhdrihhopd
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmvgesiiihghhoohhnrdhplhdpnhgspghrtghpthhtohepledpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgt
    phhtthhopehlrghnughlohgtkheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtth
    hopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepfhgrhhhimhhithgr
    hhgvrhgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepihhvrghnohhvrdhmihhkhhgrih
    hludeshhhurgifvghiqdhprghrthhnvghrshdrtghomhdprhgtphhtthhopehrhihsuhhl
    lhhivhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhifnheslhifnhdrnhgvthdprh
    gtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepohhsshdqshgvtghurhhithihsehlihhsthhsrd
    hophgvnhifrghllhdrtghomh
X-ME-Proxy: <xmx:NkwraFzU9biuIpSF1jEM-gIF6U6RRf3lJ30trXe8hjSr-I8HSWRoKQ>
    <xmx:NkwraITXiWZJryHF92r1DjgZW6iCBtQSYuEVdd7i5OsD2x5E3sgY4A>
    <xmx:NkwraIb35yae09jCNzb4z2Vc7h2Dn9jkAIT1SU5VYYtXDhj8Ev2JUg>
    <xmx:NkwraJRZTM-A9WDmM2Cd1hhrcApDx-msIP5vxvVio8rio4WCd_U6cQ>
    <xmx:N0wraPBpBawcN9taSYTUJ5oK9UnRJbUq38M2OG_ODW3qnUAsbr_O77kf>
Feedback-ID: i416c40e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 11:20:20 -0400 (EDT)
Message-ID: <dc6aa0e2-5a82-4b00-82b2-b38fffb33167@zygoon.pl>
Date: Mon, 19 May 2025 17:20:19 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Landlock news #5
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 landlock@lists.linux.dev
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Tahera Fahimi <fahimitahera@gmail.com>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 Ryan Sullivan <rysulliv@redhat.com>, lwn@lwn.net,
 linux-security-module@vger.kernel.org, oss-security@lists.openwall.com
References: <20250519.ceihohf6a3uT@digikod.net>
Content-Language: en-US
From: Zygmunt Krynicki <me@zygoon.pl>
In-Reply-To: <20250519.ceihohf6a3uT@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



W dniu 19.05.2025 o 16:30, Mickaël Salaün pisze:
> Official website:https://landlock.io
> Previews newsletter:
> https://lore.kernel.org/landlock/20240716.yui4Iezai8ae@digikod.net/

This points to the 4th newsletter, is that expected?

Best regards
ZK
