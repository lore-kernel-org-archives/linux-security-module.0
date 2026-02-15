Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7973C2E
	for <linux-security-module@vger.kernel.org>; Sun, 15 Feb 2026 03:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771124510; cv=none; b=sKXBE7aDsz2BAlYcu9jUXcfYZojfoPRpWzL9KUtqlyXIYhyA7xWTIiBSbwslfV4eDQPmtJYwvdz+l8IE8q90sBRoxhPWiTIvHN1l6PPUHE6Bews3yIhCo5bfQqrmv+Nary488Mk+FKDY2HQCL6uM61qQA0w/XUOQ1xUX7AOSChk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771124510; c=relaxed/simple;
	bh=0lTxNXJUoBG/xVCFqEbjp/iNB0z/cGdIcUJT0p6qLDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpkOAkbZx1tiRaPBWiRAAN0owtY36ujW6E6JwgIXK+B8tqt9s6YnCFfJWLPsk+bpwzBHB93urgc/sChMhVumwLZS/9oPnke+Fimo2gzA3WLrO+Wp/K6iYgbbOV6Nd/OWOu53vnMhzyTmhJ+fQmEnCuqwvpnEpVRQsxlRpCNV2qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=CbIBbY21; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XE9Bf8NZ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="CbIBbY21";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XE9Bf8NZ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 88C3F1400344;
	Sat, 14 Feb 2026 22:01:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sat, 14 Feb 2026 22:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771124508;
	 x=1771210908; bh=eDzfQpesdBpjM5PjeLFvYaBJ+w3p3zji8SotcvF7CVc=; b=
	CbIBbY21X477OaAfAeoBTgYq+eELEstLbEmmuA10YdUZktDJFukBLfYccIK/e4yg
	N4yfglSXZy6aAWnOgoS7bj1yBgPt2VPjy92L8qhbFhWJ3oObFHU4fZJxcebXruNZ
	DE25GVwVu89oOWj800TBV/X6S63ayAyjm7AJmX9n/v6+ojGIfDFBb0Gn35pAXC5q
	NGbbIjaHXLO11lkzK4BIUXwQxmuD/rerFLamg2UMNM9m67vhf8mvAhWIAm3Aaqrz
	CBcm/D7/8nR4Y+GaAJTAbp7jSyES/P9zLBseZle9MXtUCgU/12tC/OrldmTStu/I
	uUZnKBAnFnAr712P+nATHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771124508; x=
	1771210908; bh=eDzfQpesdBpjM5PjeLFvYaBJ+w3p3zji8SotcvF7CVc=; b=X
	E9Bf8NZ7oM2AsjmEGTi++7i3kvBqaC1eScW/WgEgGBUlGEvTVt97ZHQ2FGJq1BZ1
	hliIcBn1MAHNcuNAyCMMOez7/c51xxayPOMKAQuyG9Wc2KpY3smJbBdsr+AUccB+
	M7RlLkeW4BSYXHbDDf8RXnqwA+MpouG7vn+m1R1pqg8/n8yMxigXjdQb9b2Iwq1b
	GPDuymfo37jZSj3+w2Zh1EFfwVCUHiB6QY1YVShFsjmkrlxneGsgrorkuofji6ci
	ROuEOi65elLw8hh5MnwiQsl1EKQWM2Fcfgz8mlU9qer7/6pihVIuWwM/PoZNN8hP
	+kW19Xd0n0QS3AquemPCA==
X-ME-Sender: <xms:HDeRaR6HKR3eGOl4jauBEWsy-4enSF82AYJdlNznJmI4hTSToQaedg>
    <xme:HDeRaV486rA-GN33s2ODhXjD61x2o4Dn-04ucGcFYq76Y4_RL83aoqzQ5E6d0qAeQ
    Xp89ZlVnYTUxvDKbe-xamrPt1b-fRyNowRu4u5cL23MzMa5pG2bA0k>
X-ME-Received: <xmr:HDeRadc1il6J0wm2Grce_IRXsQDwCmE8IJa_lZvNXiK-YQYAtCU9qB_YBW_SO9YhvpZQ0BugYmUzmUMqTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvuddvkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepge
    ekffegffeuhfefiedtjeetueefleelfedugeekveffvddvjedtvddviefhgfejnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohep
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhnohgrtghkfedttddtsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphht
    thhopehuthhilhhithihvghmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplh
    hinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:HDeRaZAkjFpqLdkYjeFl6XvQorsdyn-h5zaLOIcHSz8SG-BY9YSzuw>
    <xmx:HDeRaQ8nhriPizHLkVd9Y1aRocwGD95eycgc8FfnEh_JMBAN1ULwjQ>
    <xmx:HDeRaUJpoGrZ7RUUUm-eyfNJ6B2wG-SkYU8NLa4JXn_zbxSQ3e_D6w>
    <xmx:HDeRaZgwoVGqlKortOZA7TiAZeFSKOL3mfnFO9msQrfHd5n-yAiq1Q>
    <xmx:HDeRabZfzxGjNQxUx_qXy2TZsYSOmNUVfE_YHzE16mY7HJQIJkYHGHgR>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Feb 2026 22:01:47 -0500 (EST)
Message-ID: <3ec9ae3f-f2d0-4675-a2c1-33cfbda879ff@maowtm.org>
Date: Sun, 15 Feb 2026 03:01:46 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] landlock/selftests: Test named UNIX domain socket
 restrictions
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org
References: <20260208231017.114343-1-gnoack3000@gmail.com>
 <20260208231017.114343-5-gnoack3000@gmail.com>
 <20260209.Noh6thae5cho@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260209.Noh6thae5cho@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/9/26 17:29, Mickaël Salaün wrote:
> On Mon, Feb 09, 2026 at 12:10:14AM +0100, Günther Noack wrote:
>> * Exercise the access right for connect() and sendmsg() on named UNIX
>>   domain sockets, in various combinations of Landlock domains and
>>   socket types.
>> * Extract common helpers from an existing IOCTL test that
>>   also uses pathname unix(7) sockets.
>>
>> The tested combinations are the cross product of these sets of fixture
>> fields:
>>
>> * {{.handled=RESOLVE_UNIX},
>>    {.handled=RESOLVE_UNIX, .allowed=RESOLVE_UNIX}}
>> * {{.sock_type=SOCK_STREAM},
>>    {.sock_type=SOCK_DGRAM},
>>    {.sock_type=SOCK_DGRAM, .use_sendto=true},
>>    {.sock_type=SOCK_SEQPACKET}}
>> * {{.server_in_same_domain=false},
>>    {.server_in_same_domain=true}}
> 
> It would improve test clarity to follow the same approach as Tingmao to
> check the scope, especially to use the scoped_base_variant.h:
> https://lore.kernel.org/all/88de5bed60b06ba97088d87803f7bb3dbcc9a808.1767115163.git.m@maowtm.org/
> Even if there is no more explicit scoped flag anymore, this test suite
> is still relevant.
> 
> The fs_test.c part would then mostly check the
> LANDLOCK_ACCESS_FS_RESOLVE_UNIX rules/exceptions.
> 

Günther, if you have not already started working on this but agrees with
the suggestion here, I'm happy to take a stab at rebasing the relevant
selftests patches in the scope series to test this new series.

Kind regards,
Tingmao
