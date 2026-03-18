Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731CE1E89C
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852801; cv=none; b=fdHgbVgLAdFSbcGkNKsIGzI/t1AyyC28wRNCKaE2i2682yyuOPPye3LBpQ6Xcl6cCGks7OVA4GpzDv2iSaqHxLyrZTvtp1yzQr/DelkZfCnlJ9MTkuMeMt+97xFoGY15Fak9lr7i+cuPg3Af+6l3IR5k6MpRY/LYgVhAowVH4Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852801; c=relaxed/simple;
	bh=OYSmS2buhTxWTFhogbGoDg82VLYhuLm3/wBuaxrdc6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUYKwZPjFyXxtTA2tTKerv2gGE8vKsMcb+CfHH7MQJ6K9+mCMDQmcZfIRlII9xZXtrr25MXRn88Eq+MOfIvgcIUFIulFlthRWxsjc3c2R5B0izVYaDQWHcyvPf7AbyZcMgHcaQGpWSq1yREplLWq6afwxAF2IgizEApI+01A4fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=uUxyyuVg; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="uUxyyuVg"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fbZdm5SPFzc3W;
	Wed, 18 Mar 2026 17:53:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773852796;
	bh=9bFT6Fs9rrujRssC9iT32MO8pDcA6bMgUmJxkbB1u6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uUxyyuVgJsHVvE449rm0BuULPLoLDPv+82uGbq4Xk9a8yfaUxpoHlrqtCqdctl490
	 W14tGl2lg+WIdCETFu7aTgmLn2Y2BV7G9EnobQXynh77Oh12ivEuBYTbKgkuvNmzM/
	 adVR9PlTKmWL8T9pW+UFpg/NSmIEgFjVIxx5d4+8=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fbZdm1cDVz7Yg;
	Wed, 18 Mar 2026 17:53:16 +0100 (CET)
Date: Wed, 18 Mar 2026 17:53:15 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	Justin Suess <utilityemal77@gmail.com>, Tingmao Wang <m@maowtm.org>, 
	linux-security-module@vger.kernel.org, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>, 
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH v6 5/9] landlock/selftests: Test
 LANDLOCK_ACCESS_FS_RESOLVE_UNIX
Message-ID: <20260318.eghahf0Chiez@digikod.net>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
 <20260315222150.121952-6-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260315222150.121952-6-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

The subject's prefix is swapped, it should be "selftests/landlock".

On Sun, Mar 15, 2026 at 11:21:46PM +0100, Günther Noack wrote:
> * Extract common helpers from an existing IOCTL test that
>   also uses pathname unix(7) sockets.
> * These tests use the common scoped domains fixture which is also used
>   in other Landlock scoping tests and which was used in Tingmao Wang's
>   earlier patch set in [1].
> 
> These tests exercise the cross product of the following scenarios:
> 
> * Stream connect(), Datagram connect(), Datagram sendmsg() and
>   Seqpacket connect().
> * Child-to-parent and parent-to-child communication
> * The Landlock policy configuration as listed in the scoped_domains
>   fixture.
>   * In the default variant, Landlock domains are only placed where
>     prescribed in the fixture.
>   * In the "ALL_DOMAINS" variant, Landlock domains are also placed in
>     the places where the fixture says to omit them, but with a
>     LANDLOCK_RULE_PATH_BENEATH that allows connection.
> 
> Cc: Justin Suess <utilityemal77@gmail.com>
> Cc: Tingmao Wang <m@maowtm.org>
> Cc: Mickaël Salaün <mic@digikod.net>
> Link[1]: https://lore.kernel.org/all/53b9883648225d5a08e82d2636ab0b4fda003bc9.1767115163.git.m@maowtm.org/
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 392 ++++++++++++++++++++-
>  1 file changed, 376 insertions(+), 16 deletions(-)
