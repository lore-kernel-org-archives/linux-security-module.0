Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC591157A7C
	for <linux-security-module@vger.kernel.org>; Tue, 23 Jul 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721753454; cv=none; b=Qn9KQ6fEYeQ6pGbyakMGAJCqo2BHZnkLki7PZ8HLneRbMtaSOc1rgNpzMcVe8BC/SB3JrtTTgUrjxII4jyT6zgyALU3ECk6jLcXPTucl+lskaBERBeQibjQ7tK16su2pUpp86IfRLcpWbCqjS5TuqdO4UznSwepNfYZeJfOt+oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721753454; c=relaxed/simple;
	bh=+ppp43Ig0Ybxm6TsC99DBorr9/fIy3Ir+ExxDkm5Lz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgvSeY+eL/9S4ICBYbkwrZ//fsisVNhf+ll0OIVXFISLyv2dKLbHy3CjxNz+/VpLRmV98SEvFemtIsX/eyAUZ44dJHslJuf5/Dstk4OvzW3FHVGyZpkpSmJiXeMTsZ+SJefWwVXW4jUBjP06HJAX5lNDv9ew58e37MucuGtWxos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=YgckCY06; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="YgckCY06"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WT37C4Jhzz6Lk;
	Tue, 23 Jul 2024 18:50:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721753447;
	bh=Brq8CGE6n5AxIP1M9IXyLvKdJ9qyGO3tn/GoLw2aeQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YgckCY06kG5xbq1fwZwWKX7pSwKx3RWRLdRhOa6T2Z+wPDUEi1xx2dsY7oJjZJDl/
	 Jfhm2eGtnR1X376HqvkY4VaVN8V/7MYvMpqMm683gLJSmj3J3iL0a/yyW9dCOXlBOU
	 uadIWcuu6TwAvHjnVXdYOCdmLANF0/uzR7E44eOA=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WT37B4JB4zGll;
	Tue, 23 Jul 2024 18:50:46 +0200 (CEST)
Date: Tue, 23 Jul 2024 18:50:43 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Paul Moore <paul@paul-moore.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Jeff Xu <jeffxu@google.com>, Kees Cook <keescook@chromium.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Shervin Oloumi <enlightened@chromium.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/3] Use socket's Landlock domain
Message-ID: <20240723.Bee3bah1caim@digikod.net>
References: <20240719150618.197991-1-mic@digikod.net>
 <Zp-q9zxmCmGjR2-N@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zp-q9zxmCmGjR2-N@google.com>
X-Infomaniak-Routing: alpha

On Tue, Jul 23, 2024 at 03:07:53PM +0200, Günther Noack wrote:
> Hello Mickaël!
> 
> On Fri, Jul 19, 2024 at 05:06:15PM +0200, Mickaël Salaün wrote:
> > While the current approach works, I think we should change the way
> > Landlock restricts network actions.  Because this feature is relatively
> > new, we can still fix this inconsistency.  In a nutshell, let's follow a
> > more capability-based model.  Please let me know what you think.
> 
> Thanks for sending the patch.  The implementation with ->f_cred is much simpler
> than I had thought it would be.  Some higher level questions:
> 
>  * I assume that the plan is to backport this as a fix to older kernels that
>    already have the feature?  (Otherwise, we would potentially have backwards
>    compatibility issues.)

Correct, if this patch is merged it must be backported too, but there
might be better alternatives, or we might just stick to the initial
approach.

> 
>  * I believe it clashes a little bit with the TCP server example [1],
>    which I found a useful use case for the TCP connect/bind and socket
>    restriction features.

Indeed, because the socket is created before the sandboxing, the socket
could be reused to bind (or connect) to other ports.  This is a good
example of why using current's instead of socket's credentials may be
less surprising.  From my point of view, the main issue is that a socket
can be reconfigured.

> 
>  * accept(2) on a passive (listen-mode) socket will give you a new socket FD
>    -- does that new socket inherit its f_cred from the server socket,
>    or does it inherit its f_cred from the thread?

According to sock_alloc_file(), the newly created socket inherits the
caller's credentials, which is similar to a call to openat2(2) with a
directory file descriptor.

> 
> Regarding the TCP server example, the current implementation is *very* simple,
> and does the following steps:
> 
>  1. create socket with socket(2)
>  2. bind(2) the socket to the desired port
>  3. enforce a Landlock ruleset that disables all networking features
>     (TCP bind, TCP connect and socket creation with the new patch set)
>  4. listen(2) on the socket
>  5. go into the accept(2) loop
> 
> With the old behaviour, step 3 is going to affect the existing passive socket:
> It will not be possible any more to bind(2) that passive socket to another port.
> 
> With the new behaviour (after your patch), step 3 does *not* affect the existing
> socket, and the server socket can be reused to bind(2) to other ports.
> 
> Or, in other words: If the relevant domain is tied to the socket at creation
> time, that means that a future client connection which takes over the process
> might be able to use that socket's Landlock domain, which potentially grants
> more permissions than the thread's domain

Yes, that's why it might be more risky, but I wanted to have this
discussion.  Whatever the outcome, it should be explained in
Documentation/security/landlock.rst

One thing to keep in mind and that contrary to other LSMs, Landlock,
like seccomp, enables processes to (only) drop privileges, and this is
done by the process itself (not at execve time).  This was also one
argument for the initial approach.

A thing that bothered me was related to the restrictions of sockets,
especially with the WIP scoping feature.  Datagram (unix) sockets could
work before sandboxing, and suddenly become broken after sandboxing
(because the security check would be done at send time instead of
connect time).  This kind of issue should be identified quite early and
easily though.

However, there is still an inconsistency between connected stream
sockets and datagram sockets.  From a security point of view, this looks
like a good thing though.

> 
> I think it would be nice if a use case like in the TCP server example would
> still be possible with Landlock; there are multiple ways to reach that:
> 
>  - We could enforce two layers of Landlock rules, one before socket creation
>    that restricts bind(2) to a given port, and one after socket creation that
>    restricts other bind(2), create(2) and socket(2) operations.
> 
>    Drawbacks:
> 
>    - One Landlock layer more, and needs to add a Landlock rule:
>      This is a bit more complicated to implement.

Right, I think it's too complex for users.

>    - The bind(2) restriction on the socket is still only per port *number*,
>      but it is still possible to bind with that port number on different IP
>      addresses.

Good point.  That's another argument for the initial approach and the
way you sandboxed the example: dropping the *_TCP access rights, it is
not possible to rebind or reconnect a socket (to another address).

Actually, I'm not sure if using the socket's credential would not
confuse users to understand why an access is denied (or allowed).

> 
>  - Alternatively, I wish we could just lock the passive server socket in, so
>    that it can't be made to reconnect anywhere else.  After all, the socket
>    disassociation with connect(2) with AF_UNSPEC seems to be a somewhat obscure
>    and seldomly used feature - if we could just disallow that operation, we
>    could ensure that this socket gets reused for such a nefarious purpose.

We could also add a new "scope" for socket reconfiguration of sockets
created by a parent or sibling domain, similar to the ptrace
restrictions.

> 
>    It would still require two nested Landlock rulesets to make the TCP server
>    example work, but they would be a bit simpler than in the alternative above.
> 
>  - There are probably more alternatives...?
> 
> What do you think?

I see other alternatives:

- We could have a new ruleset's attribute to specify if network
  restrictions should apply on the caller or the socket.  That might be
  confusing for users though.

- We could just stick to the initial approach and add new access rights
  (denied by default, similar to FS_REFER) that will only apply to newly
  created sockets.  This is close to the previous alternative but more
  explicit. Both use cases could then be used, with a default secure
  approach (i.e. the initial one).  However, we need to have a clear
  rationale for the WIP scoping restrictions: should the caller or the
  socket be checked as the client?

- We could extend the current approach and check both the caller's
  credential and the socket's credential.  This could be confusing to
  users though.

- We could have a new fcntl(2) command to (securely) transition a file
  descriptor's credential to the caller's one (e.g. approved by
  ptrace_may_access).  That could be generic to all Linux access control
  systems.

- According to a new ruleset's attribute, we could revalidate (at use
  time) file descriptors not opened by the caller's Landlock domain, but
  users would have to be explicit (e.g. stdio issue). And how to handle
  partially allowed accesses?

> 
> —Günther
> 
> [1] https://wiki.gnoack.org/LandlockTcpServerExample
> 
