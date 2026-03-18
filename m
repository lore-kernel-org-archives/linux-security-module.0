Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD7735A3BA
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773856396; cv=none; b=gwHjEy3t5K9QWgFxQfSTQGXrxCoxWvxF3jPIJX9CqyYm4LQjG9GrZ6xA7N0vuJtTJvRle4uLhlZErdwFbG9S7YnqDBGPinpjrAIpH4o9vUyA9B2iesNZ/qYdj8dU5qPLP7CQmLQvWdlzb9c5oJMNQMminSC0U0WkbLk7oshMm3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773856396; c=relaxed/simple;
	bh=wwY/sLnpVwQaj3iiA2fS5qDIk++RDzwAfDABSFvFYfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezYVBrzvia1MxnJuBnw9Tdf7eVqAG1wGG5O1kve5Kg3x5XcNTcUug7xFAdREU4/yHVLEFq5nXp0PeyfQMe8uXdpk7vMvVKOZ+gaax0qg/mTKTpgDZo5U9rSxcttEBuqSvi4lFOMy2puIkQwKKslkUOsUdsGHhQBtFf4BSDnotKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=dmgn4+jT; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="dmgn4+jT"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fbbyl1rF1zvJB;
	Wed, 18 Mar 2026 18:53:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773856383;
	bh=o5XvXYjpSTenXKXCT9/Jjc5qrGoK+3Y1u5eoNnXEnks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmgn4+jT0n25Cn8rkUhNZMsjSRVKsP9wzM3mfGZZ9siL6Ub2NZgSEp/C9zyEA0i00
	 JXt5wKZJotdcBvsVToxBrJ7GdqkRWlfIAG1Fh0pQBPU+r1uEvAab5+vEpQl3zQPe3I
	 1mMjzDSSUmVI2ASz17+ntSjP1tCUPT+KI1vNJrGI=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fbbyk0KvczZ8l;
	Wed, 18 Mar 2026 18:53:02 +0100 (CET)
Date: Wed, 18 Mar 2026 18:52:57 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Justin Suess <utilityemal77@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, John Johansen <john.johansen@canonical.com>, 
	Tingmao Wang <m@maowtm.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, 
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v6 3/9] landlock: Control pathname UNIX domain socket
 resolution by path
Message-ID: <20260318.aequoaDaeb7h@digikod.net>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
 <20260315222150.121952-4-gnoack3000@gmail.com>
 <20260318111507.1nr6rAki@linutronix.de>
 <abqzXO3MmMXKqXOy@suesslenovo>
 <20260318150559.j04YNDtV@linutronix.de>
 <20260318.Jeph6loh9uSa@digikod.net>
 <abrWSwS5urQpvbPb@suesslenovo>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abrWSwS5urQpvbPb@suesslenovo>
X-Infomaniak-Routing: alpha

On Wed, Mar 18, 2026 at 12:43:55PM -0400, Justin Suess wrote:
> On Wed, Mar 18, 2026 at 05:26:20PM +0100, Mickaël Salaün wrote:
> > On Wed, Mar 18, 2026 at 04:05:59PM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2026-03-18 10:14:52 [-0400], Justin Suess wrote:
> > > > Sebastian,
> > > Justin,
> > > 
> > > > In short: dom_other is a pointer to a landlock-owned refcounted struct.
> > > …
> > > > 
> > > > But we copy the domain pointer, which points to a landlock allocated
> > > > and controlled object.
> > > 
> > > and this is not going away while we are here and preempted after
> > > dropping the lock? (if the landlock policy is updated/ changed/ …)
> > 
> > I agree with Sebastian, this is a bug, see my original proposal:
> > https://lore.kernel.org/all/20260217.lievaS8eeng8@digikod.net/
> Mickaël,
> 
> Just to make sure we're speaking of the same thing (I spotted a bug
> shortly after replying to Sebastian).
> 
> This is a potential UAF if the dom_other is freed before the access
> check takes place correct?

Yes

> 
> 	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
> 	unix_state_unlock(other);
> 
> 	unmask_scoped_access(subject->domain, dom_other, &layer_masks,
> 			     fs_resolve_unix.fs);
> 
> If the dom_other->usage reaches zero, then the domain could be
> freed after the unix_state_unlock while we're checking access??
> 
> (I guess I assumed the sock_hold on the @other would prevent the task
> @other belongs to from being freed.)
> 
> Would it be better to move the access check under the unix_state_lock or
> to acquire another reference to the ruleset (or something else)?

Because the unmask_scoped_access() only read a bounded array, it's
simpler to unlock just after.

The other alternatives would be to use an RCU lock or a new reference
but I don't think it's worth it.

> 
> (Good catch Sebastian sorry for the confusion.)
> 
> Justin
