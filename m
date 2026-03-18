Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758A13290A6
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852727; cv=none; b=DoTcOuzZcDIOMNZh60PJCygUabzEbfRuGR4i1Y0zQ10pGtPOmqbvDSXDrhtOYiPKghnqWsRyefcZyPoTSl2KWWKLdN3lF8KqhNUkl7alkz9WrkAqI4x0wBOiCaDRTh7EJBYOzcz07VM5jo52jCGAr+khayrGirnT7FKj4iO7Scc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852727; c=relaxed/simple;
	bh=LQCFyOUUSplp5eShsmV6I/MKXo2fwwMA86XZnghC+IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/PZK57OIINJ1ahvwVAzqnN/n++mv33x/OKXamniFz1Cr6jOo/L72e8SiK7lwKMKS8ieLAu9W6UFZ5vW9/w4OuY0OafPuENE+LTuAEWiMwe8X6X6M62e7Yq3yzypjv2KYF8xI6mXLw7BsU2WbJ+4sVS33wSYlt3f/Q9qbVtgFMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=XOSgSpBz; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="XOSgSpBz"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fbZcD6FnhzdJ7;
	Wed, 18 Mar 2026 17:51:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773852716;
	bh=Xzcs+HBo55vlCaVgM+QV0cRzIBJGQFhXXf13QjKsaAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XOSgSpBz/LzVvF1/5nsaK+hbSMU+A21p7bi30+qhTS7h5u322GZ7i3sahZoIEleYj
	 VW5s0+ERmGELFlgxlxy8X4Z9PHY9al/UriHhWO+8I+VHegPQ97uGhCPXz0aLjC6bVG
	 tds+P12v+ibSico+I2J9Jp89rRKHtHT2fZqbou1U=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fbZcC4Hdrz7GX;
	Wed, 18 Mar 2026 17:51:55 +0100 (CET)
Date: Wed, 18 Mar 2026 17:51:51 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v6 1/9] lsm: Add LSM hook security_unix_find
Message-ID: <20260318.giez0eib8Ovu@digikod.net>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
 <20260315222150.121952-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260315222150.121952-2-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

On Sun, Mar 15, 2026 at 11:21:42PM +0100, Günther Noack wrote:
> From: Justin Suess <utilityemal77@gmail.com>
> 
> Add a LSM hook security_unix_find.

Add an LSM hook...

> 
> This hook is called to check the path of a named unix socket before a

UNIX socket

> connection is initiated. The peer socket may be inspected as well.
> 
> Why existing hooks are unsuitable:
> 
> Existing socket hooks, security_unix_stream_connect(),
> security_unix_may_send(), and security_socket_connect() don't provide
> TOCTOU-free / namespace independent access to the paths of sockets.
> 
> (1) We cannot resolve the path from the struct sockaddr in existing hooks.
> This requires another path lookup. A change in the path between the
> two lookups will cause a TOCTOU bug.
> 
> (2) We cannot use the struct path from the listening socket, because it
> may be bound to a path in a different namespace than the caller,
> resulting in a path that cannot be referenced at policy creation time.
> 
> Cc: Günther Noack <gnoack3000@gmail.com>
> Cc: Tingmao Wang <m@maowtm.org>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
>  include/linux/lsm_hook_defs.h |  5 +++++
>  include/linux/security.h      | 11 +++++++++++
>  net/unix/af_unix.c            | 13 ++++++++++---
>  security/security.c           | 20 ++++++++++++++++++++
>  4 files changed, 46 insertions(+), 3 deletions(-)
