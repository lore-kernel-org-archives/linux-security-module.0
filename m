Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876EE2D7BF
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852865; cv=none; b=Ufs7d1rWOex+93XeyxF2AQPM5MioQTNinetcFt8jytuIHFGTBO79NJCDNuyp+1WvwXVf48fH0vSCAV5+b6ZEF0FroeaVf0FlHId9JvNTbZIvG5ES2UmhjFVG5YRaOyi47EwVb8Y3okjX/e45dxMy+GcNBY2FQCOuR951xZO/PVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852865; c=relaxed/simple;
	bh=ndnjvgHRrPAbSBq56Y3DJ2KEvKpX89RvNwXSFHvFE40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHeJc6UTQeMmv7YafgnRDidyQkcNMAXa/Oeu2GzuQPNeDvONZaxyM2JWbulJOHNbFzCJgCsgIJN33y0FH7DtETHyUr+FWL4lQr+jabRyrH3gLOAxbV8Eqc2aXRMmrhXBKnKbZB6UXf7xvlj4YibroSWc/3+wy1IqPBmD55fhVjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=U44xiEIc; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="U44xiEIc"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fbZg16QXRzxy9;
	Wed, 18 Mar 2026 17:54:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773852861;
	bh=0rSh7c6mPfH9oJbBzFJ6YorUcEJg+BgIIZNAm8uU+qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U44xiEIc6qvpw6/VmGYFEP+4UAS/4EFZbFTGneFvcjIXlDkxkSHFD3wsU13uoZsHK
	 LlzbFVxaUvyvXuxiBOWl2uv14/zzE0tqD7zXENWBtwPLN4OFHBApmpEOogukv7JQ2R
	 G1NYDWzETyX+LZB0gLCAJEpp+Yis6i5N5NC+f3Ts=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fbZg12FG0zL8r;
	Wed, 18 Mar 2026 17:54:21 +0100 (CET)
Date: Wed, 18 Mar 2026 17:54:19 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org, 
	Tingmao Wang <m@maowtm.org>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>, 
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH v6 9/9] landlock: Document FS access right for pathname
 UNIX sockets
Message-ID: <20260318.geom7Taxahpi@digikod.net>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
 <20260315222150.121952-10-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260315222150.121952-10-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

Please always add some minimal description.

Also, as already requested, could you run the check-linux.sh all on each
patch?  That would avoid me to fix things like the date (which would now
be OK because of the new patch in my next branch, but still).

On Sun, Mar 15, 2026 at 11:21:50PM +0100, Günther Noack wrote:
> Cc: Justin Suess <utilityemal77@gmail.com>
> Cc: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  Documentation/userspace-api/landlock.rst | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 13134bccdd39..e60ebd07c5cc 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -77,7 +77,8 @@ to be explicit about the denied-by-default access rights.
>              LANDLOCK_ACCESS_FS_MAKE_SYM |
>              LANDLOCK_ACCESS_FS_REFER |
>              LANDLOCK_ACCESS_FS_TRUNCATE |
> -            LANDLOCK_ACCESS_FS_IOCTL_DEV,
> +            LANDLOCK_ACCESS_FS_IOCTL_DEV |
> +            LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
>          .handled_access_net =
>              LANDLOCK_ACCESS_NET_BIND_TCP |
>              LANDLOCK_ACCESS_NET_CONNECT_TCP,
> @@ -127,6 +128,11 @@ version, and only use the available subset of access rights:
>          /* Removes LANDLOCK_SCOPE_* for ABI < 6 */
>          ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
>                                   LANDLOCK_SCOPE_SIGNAL);
> +        __attribute__((fallthrough));

Case 6 should be handled too:

  case 6 ... 8:

> +    case 7:
> +    case 8:
> +        /* Removes LANDLOCK_ACCESS_FS_RESOLVE_UNIX for ABI < 9 */
> +        ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_RESOLVE_UNIX;
>      }
>  
>  This enables the creation of an inclusive ruleset that will contain our rules.
> @@ -685,6 +691,13 @@ enforce Landlock rulesets across all threads of the calling process
>  using the ``LANDLOCK_RESTRICT_SELF_TSYNC`` flag passed to
>  sys_landlock_restrict_self().
>  
> +Pathname UNIX sockets (ABI < 9)
> +-------------------------------
> +
> +Starting with the Landlock ABI version 9, it is possible to restrict
> +connections to pathname UNIX domain sockets (:manpage:`unix(7)`) using
> +the new ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX`` right.
> +
>  .. _kernel_support:
>  
>  Kernel support
> -- 
> 2.53.0
> 
