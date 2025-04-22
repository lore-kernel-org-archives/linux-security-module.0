Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1080D27CCE2;
	Tue, 22 Apr 2025 12:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745326422; cv=none; b=n3Fwx/BewUl2W/TmghgOKBNpqmP3u3NmvKskqBjgyRQv+Kyd7i0KyobRaMqtW5lrzFIgw3gbjRRx4iLAymF3T9hCaz/iXnj89/ndxCsiCLVdFogooknIiZwPYy9E13fnLeB0XfKG2173kWDYCGwoH1h/AWBG5mJEVAtxw4FSAh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745326422; c=relaxed/simple;
	bh=ia1z1SeD0etI3VfTHM25UQEl6UhcRMtzL98yLTEoM1w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=O6RYxyk0e6wW0n9OoBpWCEggp7lYJ5Dus0uBw3o/SlXV2JzYZgp+MP74y8AcRcctUmjROIWfPACyGtSW7U1SYhq+OQDrObasbthnY6P52SK/9h198M8eJAK4jg6K1GoXLfFKp3J3vda3wNRi++nEUbn47RyRYmYQqA/6nkIZu1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=IqnjCbjF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bFiHs6KN; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="IqnjCbjF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bFiHs6KN"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DBEDB114028A;
	Tue, 22 Apr 2025 08:53:38 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-05.internal (MEProxy); Tue, 22 Apr 2025 08:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745326418;
	 x=1745412818; bh=1Sj1ihnNRf66WWMPWwcQKoe0OJ6klzue0Chv96p60Wo=; b=
	IqnjCbjFjSdZ1WFoir/zRvMtYIyUzBpHCXTgEecy96GZ6Gjv6muuQpuGGGW0pKXo
	0PGZdZ7EHmzfFu1XiIEeOSpDl9GihIMZfusKDRhdDxkyuLiESQP5yrLRVjzq+nxX
	ofjVshganaMv2/lCSClLz0BAWxp4T3IqFHpH4jGeP0w5I53U+ZTPiHVs3Ei8Mtl5
	x5dRHD+c0sGDPTzVFqClk6Qy/ZV0/4utxuMNWze5EHHMrILKDots3SrMivEl80vE
	yMsw/3EBt8a46haOGtFil/SD+hfjyV84vYJaMiZuIV98fhiQ/HtEynWJH9oT+FOD
	jZ5JW5Bb/9MR/Wcli00wLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745326418; x=
	1745412818; bh=1Sj1ihnNRf66WWMPWwcQKoe0OJ6klzue0Chv96p60Wo=; b=b
	FiHs6KN947ldMEQ69Oj0wj5upbQTpAdRboK9U6ZFyPp6gbPXQ4AdZ6HufF42+S/W
	cOszYl4SM9mj9ZMdDlXvSgPlAnD9quBz+BlNKxNol9p63xXBFGUdaTi1t0x3e7tv
	xuU7dm26d9+rggjVjwak+M/OTf6uUMgGcQLWxvrJ//0LQFBydEctbYSb84UWAfEM
	zxmAOonnIFdmbiHCQUw3uDWsbOuou3FMj4X4uLAP/hShP0wBXIYyCZvJuwn5iNio
	mn2kZpsurTKCeCl00n87q3zealmY5yOdhZZoHsMQY3jSwsHfzPywczJ0dNzdE7io
	/v+aeHJqPjo2e53OlCQEg==
X-ME-Sender: <xms:UZEHaE96bj1ZVN7f1RN1Wa4O6u0oJLNJxWLtY-NSavEntYw7N3RInQ>
    <xme:UZEHaMspt_SfTs2ZKmAWisHUIpyNBA5_HTEUNI7h9uzL_vziP_s2cTNbmqb3AbbES
    eFh5whszKlMP5XVerE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepkedvuefhiedtueeijeevtdeiieejfeelveff
    feelkeeiteejffdvkefgteeuhffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehgnhhorggt
    khesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshgvrhhgvgeshhgrlhhlhihnrdgtoh
    hmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    khgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhrvhgrlhgusheslhhinh
    hugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepjhhmohhrrhhishesnhgr
    mhgvihdrohhrghdprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpd
    hrtghpthhtoheplhhinhhugiesthhrvggslhhighdrohhrgh
X-ME-Proxy: <xmx:UZEHaKCFDUrniirq-iHmmMml4LzsmocgvwW5NTsKH2syJ0GCR2zl-w>
    <xmx:UZEHaEcRM-K9ixwlKIW6qKuAqNTBjz_XadMmclI-4bGUU_v-p5yB1g>
    <xmx:UZEHaJPp--w8CexHYmvXZTT_0pcMA2lueFqZyW3RtmgsA_MjrKevzg>
    <xmx:UZEHaOkhh4lUl_dFRmKtJCRmpOrYoswm9HcWeFvWOnmCzQml037V9g>
    <xmx:UpEHaI9LPDzwEb7gCGcc6HEDpwZ_hkKDfk8zBT5G2Wqm5MkO2LKC-EhZ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 84AB62220073; Tue, 22 Apr 2025 08:53:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T9298f45962bf681a
Date: Tue, 22 Apr 2025 14:53:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 "Kees Cook" <kees@kernel.org>
Cc: linux <linux@treblig.org>, "Mark Brown" <broonie@kernel.org>,
 WangYuli <wangyuli@uniontech.com>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Message-Id: <ccdfe9c0-7c28-4ecf-a7da-95c9a20eead7@app.fastmail.com>
In-Reply-To: <20250422.eetheiPu6aiH@digikod.net>
References: <20250421000854.work.572-kees@kernel.org>
 <20250422.eetheiPu6aiH@digikod.net>
Subject: Re: [PATCH] landlock: Work around randstruct unnamed static initializer
 support
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025, at 14:25, Micka=C3=ABl Sala=C3=BCn wrote:
> On Sun, Apr 20, 2025 at 05:08:59PM -0700, Kees Cook wrote:
>> Unnamed static initializers aren't supported by the randstruct GCC
>> plugin. Quoting the plugin, "set up a bogus anonymous struct field
>> designed to error out on unnamed struct initializers as gcc provides
>> no other way to detect such code". That is exactly what happens
>> with the landlock code, so adjust the static initializers for structs
>> lsm_ioctlop_audit and landlock_request that contain a randomized stru=
cture
>> (struct path) to use named variables, which avoids the intentional
>> GCC crashes:
>
> This is not a sustainable solution.  Could we fix the plugin instead?
> This new Landlock change may be the first to trigger this plugin bug b=
ut
> it will probably not be the last to use unnamed static initializers.
> Forbidding specific C constructs should be documented.

I think the version from Kees' patch looks more readable than
the version with the compound literal, so it certainly seems appropriate
as an immediate regression fix, even if it's possible to fix the
plugin later.

>> We went 8 years before tripping over this!=20

Right, it's probably enough to revisit the plugin code after
it happens again.

>> Closes: https://lore.kernel.org/lkml/337D5D4887277B27+3c677db3-a8b9-4=
7f0-93a4-7809355f1381@uniontech.com/
>> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
