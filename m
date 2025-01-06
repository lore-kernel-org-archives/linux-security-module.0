Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AFC8632E
	for <linux-security-module@vger.kernel.org>; Mon,  6 Jan 2025 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736175105; cv=none; b=YuCt/wfyeHdAP8ZTfNtLqN11epTBhAVpo9krKB8SVUaLs6PzLSV8OG48LVZFnKWujaLGnkvRFvda4uD1EyhC+1QDw0jmX1cVnIpeGzfCDDjO5nYU6rf0/ejDfE53WnSf8AJkEhxLlM4NJjBu/ZwVdBdjeiS9lgSJtxO1jbJwi6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736175105; c=relaxed/simple;
	bh=2lvMSkqADvRgxeDd9Hca90mpD+xmUD07lAwG3cQcniE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WomGHCWMrkAm3WzJtjAxyh68LT5vx3GcOHWqFz6zDZ+F83OMxy41qehjeUBmC/Cx5s9+xMVQhHnmeshX1kYA5Z74zsmWRjJks1GY4lu5mraDau0XzKllir/fARtJGEzT14ENdV4zw19JTyz/DPhxo4IIkjv41Ac+DJMbOvS2uBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=eYHw7xV8; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="eYHw7xV8"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YRcZh4sPHzRJp;
	Mon,  6 Jan 2025 15:51:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736175100;
	bh=c+ZsM6Mm8zd8TH5OlXJfqQMcjwf3r7T/rs7vYlbwu3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eYHw7xV8WW7C5mG0rGkb/lxPhKM2Ng5viFWLPH81MO5lJQ4D+FfsJBUUewyeYYKRp
	 2XHuK4KBtfyEkFIVgsH5k3lrFcn8sUlEdvAWTL1IExgLypWXoSz5lx9gdLXlHThSOM
	 1QsOijhABdwagusY3gW6DeDnAqKl4dREX44MA6/s=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YRcZg70PDzcmZ;
	Mon,  6 Jan 2025 15:51:39 +0100 (CET)
Date: Mon, 6 Jan 2025 15:51:39 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Charles Zaffery <czaffery@roblox.com>, Francis Laniel <flaniel@linux.microsoft.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 17/23] landlock: Log TCP bind and connect denials
Message-ID: <20250106.ea8aex7jai3O@digikod.net>
References: <20241122143353.59367-18-mic@digikod.net>
 <0055bef6843289ac8dc728a68326513d@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0055bef6843289ac8dc728a68326513d@paul-moore.com>
X-Infomaniak-Routing: alpha

On Sat, Jan 04, 2025 at 08:23:52PM -0500, Paul Moore wrote:
> On Nov 22, 2024 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> > 
> > Add audit support to socket_bind and socket_connect hooks.
> > 
> > Audit event sample:
> > 
> >   type=LL_DENY [...]: domain=195ba459b blockers=net_connect_tcp daddr=127.0.0.1 dest=80
> 
> The destination address and port is already captured in the SOCKADDR
> record for bind() and connect(), please don't duplicate it here.

This does not show up when a connect or bind is denied.  I guess this is
because move_addr_to_kernel() is called at syscall entry when there is
no context, whereas a Landlock denial is created after that.  For this
to work, users would have to log a list of syscalls, which would not be
usable (nor reliably maintainable) for most users.  I guess this might
be different with io_uring too.

SELinux and other LSMs log it this way, which makes sense to me.

> 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> > Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20241122143353.59367-18-mic@digikod.net
> > ---
> > Changes since v2:
> > - Remove potentially superfluous IPv6 saddr log, spotted by Francis
> >   Laniel.
> > - Cosmetic improvements.
> > ---
> >  security/landlock/audit.c | 12 +++++++++
> >  security/landlock/audit.h |  1 +
> >  security/landlock/net.c   | 51 ++++++++++++++++++++++++++++++++++++---
> >  3 files changed, 60 insertions(+), 4 deletions(-)
> 
> --
> paul-moore.com
