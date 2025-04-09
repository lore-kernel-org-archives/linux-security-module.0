Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C5E1D90C8;
	Wed,  9 Apr 2025 05:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744177454; cv=none; b=MbeLzWKe3W2BjscZpT4UHxrvxMVzScrVJ8QVO5eA6P4GJaosA87blA1yG32bY20BxqYC1uL0v+MB8Wy6iVRuHcueX1x1RCRmtcL/ThOcjJSScwOGsgrXYevTqCKM7Bzz5JbXlRL0NGJlK9acaH+vnfvVuKQM9wfBjNKQuHPXhb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744177454; c=relaxed/simple;
	bh=lEYsufm0+7mvYuVM3gBjDtCxGFGACrLKvzyGryCbAnI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rOOz0AuZauoWeHj6mhr+r1jGGsw4wdG82mHcDWSsxhoGD5pOSOA9bFRFhNiSEm3MYz5qJvHNYQQdvldUp/Onhvbygblj05jMyQTDWENVPMlHacDScSz+7b4b5gsyosRxEtiU3PaZxmvorlWFTiBF3RX7d98X+nlGxcWO5lKMNQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YAtUPhmF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z8iuNanf; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YAtUPhmF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z8iuNanf"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id C548B1380123;
	Wed,  9 Apr 2025 01:44:09 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-12.internal (MEProxy); Wed, 09 Apr 2025 01:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744177449;
	 x=1744263849; bh=2rvvqH5wXGrIeZGfrzLbu4zZifmWg0jaJShmK4jU5Nc=; b=
	YAtUPhmFi1ZU66qtkugwlCiKlphA4Y8eFVXCQVTHTXw0MRUKVNmK8qZffsu+N+SW
	twzJ9GZkSGRjEb4QCtxAvoo+HJYHw1Pn4wVy+rklo/IM9N8ZSAO7gsZ4ikZNGbiE
	IddMkcCvFMSXG5TdR4FXSuDiVeZXeq6EGFEXmoR05UEVIJFIbWjlqKbnJXDrIuPW
	TbGT1D78GewxBIs/r4AcIYa1SByQagJoNCYl+/Eig2NLIy1zivd0w5ArZd3HzdTu
	KD8r/730ykG9i4UowNM+8xZtlsq9L0vd4VvABgF8hFnE7C5sux8RnXhN5d0OmwrZ
	5ULgIjMioKGe5l1TIPm65Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744177449; x=
	1744263849; bh=2rvvqH5wXGrIeZGfrzLbu4zZifmWg0jaJShmK4jU5Nc=; b=Z
	8iuNanf5/GSIPKG7mcIeYVIe0cQRfKSO1eW1nEpIH2qgZsF8oW/isDI+qwSRAceB
	mlJxguvHPBF0yP6WQDKeVZSunmOrNfPKN0OPmbkvxOKMkcktfFTY3m4FWxzZ97C5
	hMBZJ5vPKnRiBogSyTZWMYK6hMjK31M4PfLRG4pCvE+cma7sbcwor0wEAEkTYQTW
	DA00WcwRK2dTuTlJGZfPlADVsrguJRLoHLW6SF/7dPibvyZ55M6/DqcocGK+rJ0X
	RCiCSRn0n6QQL87B6zw6Uy5X4yPn1+LPKYz25YP9e5HjsZD3QGb3okgSbLx/PP9a
	M52b7bgZhBOuH/fRklAsA==
X-ME-Sender: <xms:KQn2Zx8vQeVL5gRSAgrdBLyizYmOW1D8zwKlXt2IQ_QB8fNdBci93Q>
    <xme:KQn2Z1sGocdtkZ3CTqUSJA_xVvgCJjynmHuuRqIPZY8u2pAbZG0jHUa_5-XLOwncb
    45VeFcPQ-0DyJtbpoY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdehudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughighhikhhougdrnh
    gvthdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    sghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvvghssehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggr
    thhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqhhgrrhguvghnihhnghesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthi
    dqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KQn2Z_DOiWjcg553ukFV597umIgqqXTJBzDkms_TnTgcwpvfGlqqsQ>
    <xmx:KQn2Z1covHxfamwQ5Yxey7uAhHoH1n22acJtaJLsHXV-_de8qg5RzA>
    <xmx:KQn2Z2Mb0wa4n0gSlgUubVn-kGp_54ImLjUsA3Cw0VIwTqQfUKyySg>
    <xmx:KQn2Z3k3qCyiG6lBwKk5YAZhZEfkKh9C9-XgLECBn5vcWCOz_UYs2Q>
    <xmx:KQn2Z03RjPxEO6ywmwKR3EpSREnhgrcnJ30ykf2PDUGBBqDGwRSd7KjH>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1C9F42220073; Wed,  9 Apr 2025 01:44:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T00187b92ccd5616f
Date: Wed, 09 Apr 2025 07:43:38 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kees Cook" <kees@kernel.org>, "Mark Brown" <broonie@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org
Message-Id: <a379dc7d-5bb0-415b-b690-1c2d9106d7ca@app.fastmail.com>
In-Reply-To: <202504081630.4CE88E855@keescook>
References: 
 <20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org>
 <202504081630.4CE88E855@keescook>
Subject: Re: [PATCH] gcc-plugins: Disable GCC plugins for compile test builds
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Apr 9, 2025, at 01:32, Kees Cook wrote:

> I can reproduce this for GCC 14, but I can't reproduce this with GCC
> 13. Which minor release is failing for you? My GCC 13 is:
> gcc (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0

I see it with "x86_64-linux-gnu-gcc-12 (Debian 12.2.0-14) 12.2.0"
(cross-compiling from arm64).

     Arnd
