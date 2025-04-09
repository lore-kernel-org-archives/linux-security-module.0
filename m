Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E5C1E5018;
	Wed,  9 Apr 2025 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226797; cv=none; b=KPNKBPw5/XD1aTf67A2WEaNpC+215YIkKYcCbtsew8XfIxo6zs6AeKUeoFkQ9shMV8jBDAkywHhZ3rqyyfR90TQayzoFJkaW38KmtFOsNzgf8lh2hXLby79Sa7MhA5XGyQAmLqxsZ5LkpwcQlxYzuWEPj8XoJTdZkFj2fsrXPJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226797; c=relaxed/simple;
	bh=X1SfMEfZvzUHxVnR6pOqX7AHRwOT8TnCctzXPRDQKLk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=igYRKgYl9MQ6zBCMcD7phZLNm6kUcjMai7ReJmzcqr9fsZNtFvskMUcq4M5YZzyWOJqLa+WGAT9ccKYYcciejqEsSmhwniZW1R5L5z7X/g2rblJdsvOIfGCPaoqmU9i74LqdMVEjGZEL6bY2wzBiQUjfV4JzVfTdXP9GXE8ZChQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=COIQkGHh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HS/y6q1Q; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="COIQkGHh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HS/y6q1Q"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BEC7711401DD;
	Wed,  9 Apr 2025 15:26:33 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-12.internal (MEProxy); Wed, 09 Apr 2025 15:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744226793;
	 x=1744313193; bh=ttmrteYlvyEshuI4BJblUw5d++ZbDVerZYrZVyNtdLQ=; b=
	COIQkGHh5fvRVnMFnFjGz/DcmGmgVS+LK/tUjf+/XiIvNlXOgEdpI4YLFb8SNtNp
	h8L3iFGO6CreCFn+MGuRsxoNq+v5Vv1gey6zPcP9DWYi2/Vr/hPwHLGZJFtPKyXF
	0bCvkq65tKg49oE3vIs3Kzl/rgM288quqRbyifXhju4nMmfL7jhL6ou3/EHHgc9w
	Umz5UGS/K0LqaeAHXC5f8cZmc/x2VyxN+idO69M5wG/BTs+V5JrGIcf4YJVTx1tg
	zlZikYwCyXoeV0iG9WDOALbaMsDneDBbJbLsIZcLpIsIXLUpFuCeJtmv7AojECOL
	V3I8xY235/cL81vlHa33vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744226793; x=
	1744313193; bh=ttmrteYlvyEshuI4BJblUw5d++ZbDVerZYrZVyNtdLQ=; b=H
	S/y6q1QLydTA19jhLtCx9n9xl/as+Xm2ddC1saP1X2d7/EqfU0v7BWDBhgW9vPo7
	QsdDZvbW+go11uUnBq7YfmuE25YiRz7uDRuSy4cQVQBDVrT/Xf4M1IzdeQVTdm0j
	Kky2Sy2N+j6X+MFLKvOeKVuPAoKLybxuqUUJPj+jFsO0UIExlmpFzo/G4he0hA27
	7P/2sBsYH1K8c6WO8nAh0ygQl6fT1DOy21epV6Gntn4VbLChIaRFv/e6UpFS4P4c
	EYbeWMLiDnpoGDRHcZ7oTeFkryRDJGruspU65w4isHMApzqdYfXyfvDgTuLz4Os1
	EVDgccLWoTmP3vs3oCIBA==
X-ME-Sender: <xms:6cn2Z1LtdPSto2YqEf9fYuN6j3_uoU6xCoZB_urDFpRnamfMrOTiUw>
    <xme:6cn2ZxLUjk7rUNRf5QPwH1XxTd_2sMmWIYCPr0MQY7aRk-Ay2UxhWfwEALpsaH-T7
    OIo-SEKTop1yr_0Tq8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeikeefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:6cn2Z9vPUNmhyu2XAMrgmvsqXs2T_Ua_IlQiq-8OLIB8fdAeb1zxMg>
    <xmx:6cn2Z2au7u513ss2xv_dybWyNl98GaZIlxaDkA73CGhribHz3odJtA>
    <xmx:6cn2Z8apm6La2l9U5REZnRRiI__0dF-6uLtPWBvVf6iHrQ02BrN-vA>
    <xmx:6cn2Z6DJPc7_OsytJwJYrv2JunbkYFHWHrkKtXeYzjUjYhO8XC8pFA>
    <xmx:6cn2Z8xLO1XmQQXRNfKKrhtE09ArOCDVMrWwo3YLvOGiJAUIHtTMx7bh>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0703C2220075; Wed,  9 Apr 2025 15:26:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T00187b92ccd5616f
Date: Wed, 09 Apr 2025 21:24:15 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mark Brown" <broonie@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Kees Cook" <kees@kernel.org>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org
Message-Id: <3c3365f2-96f8-40c1-ab8b-2bd17b9b7d87@app.fastmail.com>
In-Reply-To: <815b2990-570a-4603-b33f-2af1f0851434@sirena.org.uk>
References: 
 <20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org>
 <202504081630.4CE88E855@keescook>
 <db50faff-7290-4193-b861-f60e36f1d1e3@sirena.org.uk>
 <CAHk-=wjc+piYyUw36s4ttEkY32jVkxhRtyrt431wew7XcDS2Qg@mail.gmail.com>
 <a9a459c2-674d-43dc-9e27-41de0471f602@sirena.org.uk>
 <CAHk-=whKEuQQh2JymabBQLrLs=pEfx0qYVmUnYZRq_tOFj90sA@mail.gmail.com>
 <815b2990-570a-4603-b33f-2af1f0851434@sirena.org.uk>
Subject: Re: [PATCH] gcc-plugins: Disable GCC plugins for compile test builds
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Apr 9, 2025, at 20:09, Mark Brown wrote:
> On Wed, Apr 09, 2025 at 10:42:19AM -0700, Linus Torvalds wrote:
>
> Yeah.  The other problem we have is that AFAIK unlike clang we don't
> really have people actively working on GCC coverage specifically,
> everyone mostly just assumes everyone else is doing it since GCC is the
> default (me being as guilty of that as everyone else here).  The work
> Arnd's doing is the nearest thing I'm aware of but that's more
> intermittent and I gather his toolchains don't have plugins enabled
> which wouldn't help here.

Right, I don't think there is any sensible way to support plugins
with my cross compilers, because that requires building the plugin
on a developer's machine and link it against the compiler I statically
linked against a specific libstdc++ to avoid runtime compatibility
problems.

       Arnd
