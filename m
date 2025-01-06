Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752DF145A11
	for <linux-security-module@vger.kernel.org>; Mon,  6 Jan 2025 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736175617; cv=none; b=VmdD8iz8XpSmYXLspKX1/CP3pG13ViyoHGk20NoUGoGQFdrIezZg/VX7eYygbX31MA8bbgaYvtc6mD7maDZA2VJRHddbLI2uUe4vG3rO2zw9nHUWpJ9r8vGV2GyhzbOwoEsQFybaleSE5tcGe4zhETpGNs5WcrjhzfDTpSzMMHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736175617; c=relaxed/simple;
	bh=/vFuWBwJSMaPkLPS6qLPlahd9vTOlI5HHTOiKBma8io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcyjKNkHedpJlyapxc2HL4WjpHyo8aApWF8WPRa0VI7UonQn/Pu9hUoUTIpXlj4SD1vyDn8wLhxvSbHsIkJWMezblLb0eWiQv+oPkYiywPcGzIimoSbqCOAXl29jSarIdghWqzsk8+FDtB9QTNwze78i42jpzbU7Bc4k5bqaX00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0IYaoN97; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0IYaoN97"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YRcZy4Dq3zpbC;
	Mon,  6 Jan 2025 15:51:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736175114;
	bh=pfImSMOnPsu7h9I1ixZWU9vAY8s1VHS6V7qrZPdxR00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0IYaoN97PwKp9Q06nPsqT5KENzFTYSNezgVOcfMy9kdWuAKYsgonJIp/ycJVOxxzV
	 RZAjLo4y9KH7R/AvulAiRNm+JYYtXhPZmn/NHxeM2pnM3ug9lgR6Wvx2SsFd9R8BH6
	 8nlHHi8ING7GTxaZKXy8mDZ1fB66vle4zbUzqMZE=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YRcZx63FSzfY5;
	Mon,  6 Jan 2025 15:51:53 +0100 (CET)
Date: Mon, 6 Jan 2025 15:51:53 +0100
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
Subject: Re: [PATCH v3 18/23] landlock: Log scoped denials
Message-ID: <20250106.ohHi4La0ahTh@digikod.net>
References: <20241122143353.59367-19-mic@digikod.net>
 <1372f9de0bb265a08114a870ec086da0@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1372f9de0bb265a08114a870ec086da0@paul-moore.com>
X-Infomaniak-Routing: alpha

On Sat, Jan 04, 2025 at 08:23:53PM -0500, Paul Moore wrote:
> On Nov 22, 2024 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> > 
> > Add audit support for unix_stream_connect, unix_may_send, task_kill, and
> > file_send_sigiotask hooks.
> > 
> > Audit event sample:
> > 
> >   type=LL_DENY [...]: domain=195ba459b blockers=scope_abstract_unix_socket path=00666F6F
> 
> Similar to 17/23, I believe the SOCKADDR record should already capture
> the socket address information.

This might not be the case, which is why SELinux and others explicitly
log it I guess.

> 
> It would also be nice to see an example record on a signal event.

Yes, I'll add such example.

> 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Tahera Fahimi <fahimitahera@gmail.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20241122143353.59367-19-mic@digikod.net
> > ---
> > Changes since v1:
> > - New patch.
> > ---
> >  security/landlock/audit.c |  8 ++++++
> >  security/landlock/audit.h |  2 ++
> >  security/landlock/task.c  | 58 ++++++++++++++++++++++++++++++++++++---
> >  3 files changed, 64 insertions(+), 4 deletions(-)
> 
> --
> paul-moore.com
