Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74E0338F45
	for <linux-security-module@vger.kernel.org>; Fri,  9 Jan 2026 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767955046; cv=none; b=TTgJD5IcYHD40Itrp/Y6drIPxV7y4HVb6pQjGi3UyDd/xcaWP7RRIo1hNoXqRCx09NQhVnhdiic/BLOPwrfj7mxnOZvKaFDf35z0taO/F/7wiTIn7Q5r8ruhCwwAt7lhLQ3+qR3q1uRJso1SkGpVRbJ3qqXGHGK11Fx9QbZqjqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767955046; c=relaxed/simple;
	bh=WHrY62BwaaX3+yQah2UCGV210XBozWb1DMl3EkGR4bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBsvC7o2HRhxiPqQZNVNRUzciDeXxVF+Tmx5CVIZz0TJ4ZnSfLL66G28ZfEhY13kio0KTEhWerLJTG0G6Ahgc9aWVqFRsIE3/m9YEctC2qszWA+dNYUaXoITTnL+mhQqQz3L9bPgit3cAiC28ZxS3+Akk0T0pVIxVmPlaPvbmwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=bycJOhQD; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="bycJOhQD"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dndWL6QjTzdHL;
	Fri,  9 Jan 2026 11:37:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1767955038;
	bh=TUIC8KJj625rEK3UhLUgqdbkew76jglP84QVVFcuEDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bycJOhQDIei9ofXiYMgydiy3v2y3eGVR0n/jdmL7N4u0Wfi8GxNnZlf/Z4UZ10gVD
	 SvLpCRqSeDwm6iO6dbucUun3Av6SazlUJG6gOuSUduSIASIJwZlxKuzas/t3obEeWZ
	 nPTmH4Y2Sia0yfGZBiCNka4G3B/be2BKPUSBNFjE=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dndWK4fj5zdxF;
	Fri,  9 Jan 2026 11:37:17 +0100 (CET)
Date: Fri, 9 Jan 2026 11:37:12 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, 
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>, 
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [RFC PATCH 0/5] landlock: Pathname-based UNIX connect() control
Message-ID: <20260109.she1eg0Ohl4u@digikod.net>
References: <20260101134102.25938-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260101134102.25938-1-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

On Thu, Jan 01, 2026 at 02:40:57PM +0100, Günther Noack wrote:
> Happy New Year!

Happy New Year!

> 
> This patch set introduces a file-system-based Landlock restriction
> mechanism for connecting to Unix sockets.

Thanks for this patch series, this is an important feature for
sandboxing.

> 
> ## Motivation
> 
> Currently, landlocked processes can connect() to named UNIX sockets
> through the BSD socket API described in unix(7), by invoking socket(2)
> followed by connect(2) with a suitable struct sockname_un holding the
> socket's filename.  This can come as a surprise for users (e.g. in
> [1]) and it can be used to escape a sandbox when a Unix service offers
> command execution (some scenarios were listed by Tingmao Wang in [2]).
> 
> These patches are built on Justin Suess's patch which adds the LSM
> hook:
> https://lore.kernel.org/all/20251231213314.2979118-1-utilityemal77@gmail.com/

As Kuniyuki pointed out [1], we should handle both connect and send.
This would be similar to the scoped restriction from Tingmao.  I guess
we'll need a similar hook for the send operation.  Because there is no
need to differenciate between connected and disconnected unix socket in
a security policy, we should have one access right for both.  Any
proposal for its name? Something like TRANSMIT_UNIX or EMIT_UNIX?

[1] https://lore.kernel.org/all/CAAVpQUAd==+Pw02+E6UC-qwaDNm7aFg+Q9YDbWzyniShAkAhFQ@mail.gmail.com/
