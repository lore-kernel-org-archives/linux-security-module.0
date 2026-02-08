Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1901E2614
	for <linux-security-module@vger.kernel.org>; Sun,  8 Feb 2026 02:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770519439; cv=none; b=p+sFk6/2SM/hiBnuuGfhNzWF3jX1xLs5dklBXwVoTBNgw0uglSoycwlP2n1Sl9sElCGzETJP4HgAD4/rzJefAwlJe+3l2gMgdnR7m+bFMRRVbuvxDdHfhP4e5HqQC1CLfukeZtA95YoGgtcmn4IzyQeCcWGyMNR38JV93UrWcWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770519439; c=relaxed/simple;
	bh=Qu1Hy3DzJkRe7jU1QccrJ+kWXeQAa9gmhkIuTCqXwxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpKzXV0aNyP8rnLc7e0yfG9Jvejv5rwjZZbhzMZPgJjNYXWTDWHlLnK/6vMmza6yO8KWp5RIfeZoO8zp6duciBIsWW56r21cLy4pEYUac1Gi+PnkHiarahHqNr9weAG0lsRiQ0ueUNN7qpqM7BOGFsLENZz5y4Cr8SBZKKCY1DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=QzQ4l7VF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eCtVVZca; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="QzQ4l7VF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eCtVVZca"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C08EE1D0008A;
	Sat,  7 Feb 2026 21:57:18 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sat, 07 Feb 2026 21:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770519438;
	 x=1770605838; bh=p5Spa9bumKgz/qGs5riBRRIw7PIJLXoGemwM6sSnMU8=; b=
	QzQ4l7VFFxyxWwhteMe6EL4Ry7Iw4/a9AIv/0vsfmhS833v6H3jdFxQkdKQi9FBK
	lRpTZsf9uNQMt7Xo07dMd4O6AZeCwJhTWiJOMRQRJ7R0Y2+tdEvGVRZ7hOx2GU3f
	v8ul1K7zgankAq9Z6OYjs2RacrHYuQk8Kd712m1CYmOYqVChYS3iezGtIO862Rn5
	wXvZrIDx6E1egrSLNX8bqBoSYeLfLlSdU43HmnKYPlR3WyhMzC+F29d0AdCqpWRV
	oXC7Kz3BGGqcIiwDXEicIKCxtyOuTMItvX9yOCihirUNnY0bE94jKGQLNHEIepEC
	cgYLtyDwCmxTYZLNfPOgKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770519438; x=
	1770605838; bh=p5Spa9bumKgz/qGs5riBRRIw7PIJLXoGemwM6sSnMU8=; b=e
	CtVVZca88KeAH1aRxtLraYa13iEJ9varA+zDNpXIrwV2q60RrnsEH3M5KBcE9zKg
	cuINA6qBzkzJI8iD6M/UvG8q2AX+rgCzLBBp134aM4g5e9dlxwVYenYKSzScZzxR
	eGSXPBZthtBwUqsuClh+8LRAbi9aRjRGm0Zgk89fGG4HMi1T6liG8/WL5/R/Lg0t
	XBSDyyi5abn5fZ2b0s4n8b51qCGcRl21uOe9g59X6LszNVX9gp2oDmg7Ht8HY/AF
	oMGt2oI/BwSA3rapn+TJGcWo0YWJZHgONUQNkX8gFSSd2EiqLnIGqw5hHIVljnvR
	A1MegQorsgL99PBn9doqg==
X-ME-Sender: <xms:jvuHacFPwVbQ17rpwxsDUgKj4dmLA2nPY49Z4UcyN8Ixw3O6e5E5Lw>
    <xme:jvuHaR5Crvki9UEevC7-lJnh0qWc7pSmCZvVI73VguBoJmwB_fffTMVNS4C55wtE7
    1AYB7PiJRP96fN-mzskx-fBySk3Dint5lkZYf_sX7wzlyyXCNJEONY>
X-ME-Received: <xmr:jvuHaalT50nCz7VvK-YETyaEbYzHgOmJlkz5d-DW3lMWo_FdVyGmdcwXwLAlkTtsDwcHC3hXS1Vdosj6EQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledvjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepud
    ekvefhgeevvdevieehvddvgefhgeelgfdugeeftedvkeeigfeltdehgeeghffgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehuthhilhhithihvg
    hmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhnohgrtghkfedttddtsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprh
    gtphhtthhopeguvghmihhosggvnhhouhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    hhhisegrlhihshhsrgdrihhspdhrtghpthhtohepjhgrnhhnhhesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepfhgrhhhimhhithgrhhgvrhgrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:jvuHaU526SptfFtlEIJbYSLTCuqouei3spzx00YRm7HkARtpiQ6phg>
    <xmx:jvuHaTRLtxVQza0o1zhrC0ECY97QHgoZt9K1mEUxQYVKxkBfUUOWdQ>
    <xmx:jvuHaaw0jjEzExaml378B-QTnYyDlK7cjTzSr_UkaA5CJUMHrRQFEQ>
    <xmx:jvuHaTpeLyfFhyiAF2yjOseWIK1JfYClK3rATYnHAz63JHBFm3OUOA>
    <xmx:jvuHabvJhr85RsbqU8KoC8QD307TIa4ENZ8xEekBEhlNSr0kQrIYxaew>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Feb 2026 21:57:16 -0500 (EST)
Message-ID: <3f9d456f-8343-4b46-8770-38190f838dbe@maowtm.org>
Date: Sun, 8 Feb 2026 02:57:16 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Landlock: Implement scope control for pathname
 Unix sockets
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Justin Suess <utilityemal77@gmail.com>, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack3000@gmail.com>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>,
 Jann Horn <jannh@google.com>, Tahera Fahimi <fahimitahera@gmail.com>,
 linux-security-module@vger.kernel.org, Matthieu Buffet <matthieu@buffet.re>
References: <f07fe41a-96c5-4d3a-9966-35b30b3a71f1@maowtm.org>
 <20260202.uu0oCheexahY@digikod.net>
 <8093547c-ab40-4814-ac9a-8dff6f2a2a90@gmail.com>
 <16129d76-b6d3-4959-b241-dc79a32dd0cd@maowtm.org>
 <aYI2OQhPMgdMAOiz@google.com>
 <e6b6b069-384c-4c45-a56b-fa54b26bc72a@maowtm.org>
 <aYMxHRwHCao30HfX@google.com>
 <bfcac905-5901-4cfb-8489-fb228cef0ee0@gmail.com>
 <20260204.vug7Osheiwou@digikod.net>
 <44d216aa-9680-4cf5-bbf0-173869111212@gmail.com>
 <20260205.phohK6hajaih@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260205.phohK6hajaih@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/5/26 19:15, Mickaël Salaün wrote:
> On Thu, Feb 05, 2026 at 10:18:54AM -0500, Justin Suess wrote:
>>
>> On 2/4/26 13:28, Mickaël Salaün wrote:
>>
>>>> [...]
>>>> Tingmao:
>>>>
>>>> For connecting a pathname unix socket, the order of the hooks landlock sees is something like:
>>>>
>>>> 1.  security_unix_find. (to look up the paths)
>>>>
>>>> 2. security_unix_may_send, security_unix_stream_connect (after the path is looked up)

btw, ideally for pathname sockets we can leave all the checking in the
security_unix_find() hook (as newly proposed, with the struct sock *other
param), and not have to e.g. call domain_is_scoped() again in
security_unix_may_send and security_unix_stream_connect, right?

(Although if this changes error codes, we might have to "delay" the denial
until the may_send/connect hooks...?  Hopefully not but not checked.)
