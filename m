Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B196A4A21;
	Sun,  1 Feb 2026 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769962798; cv=none; b=aMzm8w76mF/kENyac08lU+cS9Oyd383HKnN0rDEhJFF/5y/EyJUWIhDPD5RooLPNXiuJH6v1wFrriMGXF7sR0oj2RslqHFqwzYjFwUHWw35nMujYSUO9Riy5Z9v36oFdmPZu9g8sXhnOECsbfenLOYDRPy2t1pNUT6R51VE/Mr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769962798; c=relaxed/simple;
	bh=lJT+ugwHA9E/sdCXlPBU1DSQ3rcT8aR3CQB+0aKQQmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s96Pkgz4L7Hgv3E5myYdu120bbCo6890sSaSXZ/jYzuOnNqRkrBcEPlrMx8zr4TwLeKhBQI9ONRv+A9dz8IQM2MyuX2xLxBM5aJ6kprxAdt+1OxF+Uf54JZgls9qv58sYhjpfvuUijm573w95LbrQLUZugPcxIQZjB6hScZqi10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=h3z9DZDl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E19Swjdt; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="h3z9DZDl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E19Swjdt"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B986D1D0002E;
	Sun,  1 Feb 2026 11:19:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 01 Feb 2026 11:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769962795;
	 x=1770049195; bh=tjDVnDrw5wXiMN4qhmJVUL2GTODL7265NtOI9O4QuXw=; b=
	h3z9DZDlacWbGo9fsFoRLGL+LgsOeO3lF7Uu2rsbhR5m0X90/gVirpsxKd9n5tuv
	Yv/yileQynIZVVNk6xMk8nD5hiGGIlJfToCGdj2/XO2s1u0ljQI4tuacw8cnIUSO
	qmJvv9+OrHfjV5ygbj5ovk45axhGzeUg3BBCz9rpZfOBAAaz7RHmouM0HoFB5cUq
	98r2YDvIBtnVoXgYCXdjXfoSm+0Ti8UrExDIQ8hyaj28IsR24vVSKkXuQn0CNEU9
	480TLPKfy70qv+LZwkNlRRE3/MZp5qD8OIbcMDA5lLtJSMNaIpDcKM15bb4Hxh2z
	TWQGrzBujXxQGoTtDd8R1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769962795; x=
	1770049195; bh=tjDVnDrw5wXiMN4qhmJVUL2GTODL7265NtOI9O4QuXw=; b=E
	19SwjdtWug+DWz7dihNYaIMmrSEBrYQFt2yNM2nfQf372OxNgp6uENFTRQNKa/sf
	/v7DJp+93pqGcQE0GopsGkA+7Fo2c2ptbjvt73NdudpUrhcDzguGM01FW2Cyog1P
	T/t8oteQCgiuGuq8xyKIH70Be6wn3tqn84anuaLDsFFd3UFIeNzJguN7x10d0oLg
	u0R7mNpILlb4SuaNYiLPIaWboI+zJTd0n7+SuLfwibhb9TFJpcRFpqY73arLU26J
	oM+C4I4ujxvEScKt7fkyeL2hwUDq5rLqe34tgAxx8pi0+DyZhV4uX3qJ7C6gs8XQ
	0AYMbPCotDdWOJT/4f5HQ==
X-ME-Sender: <xms:Kn1_abHjd53T1S-vU70CbI8q9d79gZpHdTzkvtI-LbL4asTfmgrQeA>
    <xme:Kn1_aZBmeLYlpHkKB9df_EnQBXb64n6v_sWhs7K1N9xKl4UE8V4PFJfcqOuC9l2qA
    bIwI945OMaORcV2U44QD23dC8ouHiwaZR9_KxK8iP7vaB23WtC7qg>
X-ME-Received: <xmr:Kn1_abXf3ZGVyFBvcBeqcN3iwEy8YkE1AIuUBqOEfgWVIOg7MhbfCiTX90DqO0WD6Ko8b0yuh0Cy8HInwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeehvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepfe
    dvheeluedthfelgfevvdfgkeelgfelkeegtddvhedvgfdtfeeilefhudetgfdunecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmrghtthhhihgvuhessghufhhfvghtrdhrvgdprhgtphhtthhopehmihgtseguih
    hgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepihhvrghnohhvrdhmihhkhhgrihhludeshhhu
    rgifvghiqdhprghrthhnvghrshdrtghomhdprhgtphhtthhopehkohhnshhtrghnthhinh
    drmhgvshhkhhhiugiivgeshhhurgifvghirdgtohhmpdhrtghpthhtohepnhgvthguvghv
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Kn1_ado9nvWKysJj4tluYCrOL_FIZ-3HyrfkkUrW5tp8ZkJwohjrBA>
    <xmx:Kn1_aXSNxESocRX-NwAll31b6bdeI2cXa7iQ07QbdU3QvUERtVMmAQ>
    <xmx:Kn1_aX1tH2z-o4N0SNX5Am_vEGxkH33eDSlU9VelwDBfG4Pb1CYCDg>
    <xmx:Kn1_aTCqiC5qeUsViUpMglYnqxuBxScO93KYJ7p0XVW2pyJNGOXVQQ>
    <xmx:K31_adgc9CKvPewWd7cdrTpOnVXx49xqniwdGIvwcgYmLpST66wzZKAV>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Feb 2026 11:19:53 -0500 (EST)
Message-ID: <e2e19f42-05f9-4857-9b18-29192b0a1926@maowtm.org>
Date: Sun, 1 Feb 2026 16:19:51 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 6/8] selftests/landlock: Add tests for UDP sendmsg
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-security-module@vger.kernel.org,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 konstantin.meskhidze@huawei.com, netdev@vger.kernel.org
References: <20251212163704.142301-1-matthieu@buffet.re>
 <20251212163704.142301-7-matthieu@buffet.re>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20251212163704.142301-7-matthieu@buffet.re>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Matthieu,

I noticed in passing that

On 12/12/25 16:37, Matthieu Buffet wrote:
> [...]
> +	EXPECT_EQ(-EACCES, sendto_variant(sock_fd, &self->srv0, "A", 1, 0));
> +	EXPECT_EQ(0, matches_log_prot(self->audit_fd, "net.sendto_udp", "daddr",
> +				      variant->addr, "dest"));

net.sendto_udp should probably be net\.sendto_udp

> +
> +	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
> +	EXPECT_EQ(0, records.access);
> +	EXPECT_EQ(1, records.domain);
> +
> +	EXPECT_EQ(-EACCES, sendto_variant(sock_fd, &self->unspec_srv0, "B", 1, 0));
> +	EXPECT_EQ(0, matches_log_prot(self->audit_fd, "net.sendto_udp", "daddr",
> +				      NULL, "dest"));

and same here

> +
> +	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
> +	EXPECT_EQ(0, records.access);
> +	EXPECT_EQ(0, records.domain);
> +
> +	EXPECT_EQ(0, close(sock_fd));
> +}
> +
>  TEST_HARNESS_MAIN
