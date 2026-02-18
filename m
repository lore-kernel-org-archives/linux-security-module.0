Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B637314B8C
	for <linux-security-module@vger.kernel.org>; Wed, 18 Feb 2026 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771407575; cv=none; b=Y/6tGbxHsrgEbugoXk27ch4ETBjbEcG0/hnJvaWhpOcDcbraTlfzDD2TrkA9T/vUq27+8dd6ENNbz+KwBCemMKfs0iN3qzsoC46OkYeNYFCwHFfzvGWQJv66wzZz8Om9G+x5PFqlSVraZQ8itaKupK+UJtJhZOhrNySCBHiAkGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771407575; c=relaxed/simple;
	bh=D1ur1fV0iVQk5k2KOpSLszfZor7lFIJrz6vU6DGqPKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrRwHcGl6WQWtajX9cn4PHWMDudclNzw/mJc5VVKjgxJOr5S6HOtlzYR4WiurA2NvA9g7bPaWrlUER236RPYmhI2kCNfvMxggI5x2dJB8hDJulQ7PJOeRUSqF6I5tmTeu/vbsydDxzJaYGukoQz/wCekzqjC/nrMebiUsaiqJ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=oCVgaW7t; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="oCVgaW7t"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fGBL52GlNzvPs;
	Wed, 18 Feb 2026 10:39:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1771407565;
	bh=xHqrmQWiY0MlW87rO/PgVKhs4XIXziZ44UfytakahCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oCVgaW7tX1/Oxv5DUv7iAVbJv5ZA/732sAb1SFm1KwvsZhdJELEbAA3C3LVcKPAJo
	 5bp2dgHZamxF6IJ679uRyKH9ShPiNmFEaUm7fWYfpXODW/FmbkYYwRVS6Yu0T6A2xZ
	 cfFxs44EBbB6x283bf8HsuXTFuR0/j27NsPTdgs8=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fGBL45BzPz4tC;
	Wed, 18 Feb 2026 10:39:24 +0100 (CET)
Date: Wed, 18 Feb 2026 10:39:23 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org, 
	Tingmao Wang <m@maowtm.org>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>, 
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v5 8/9] landlock: Document FS access right for pathname
 UNIX sockets
Message-ID: <20260218.AXoosuwo8aen@digikod.net>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
 <20260215105158.28132-9-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260215105158.28132-9-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

On Sun, Feb 15, 2026 at 11:51:56AM +0100, Günther Noack wrote:
> Cc: Justin Suess <utilityemal77@gmail.com>
> Cc: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  Documentation/userspace-api/landlock.rst | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 13134bccdd39..3ba73afcbc4b 100644
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
> @@ -127,6 +128,12 @@ version, and only use the available subset of access rights:
>          /* Removes LANDLOCK_SCOPE_* for ABI < 6 */
>          ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
>                                   LANDLOCK_SCOPE_SIGNAL);
> +        __attribute__((fallthrough));
> +    case 7:
> +        __attribute__((fallthrough));

I don't think the fallthrough attribute is needed here.  Same for the
sample.

> +    case 8:
> +        /* Removes LANDLOCK_ACCESS_FS_RESOLVE_UNIX for ABI < 8 */

ABI < 9

> +        ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_RESOLVE_UNIX;
>      }
>  
>  This enables the creation of an inclusive ruleset that will contain our rules.
> @@ -685,6 +692,13 @@ enforce Landlock rulesets across all threads of the calling process
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
> 2.52.0
> 
> 
