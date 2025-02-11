Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1FB230D0E
	for <linux-security-module@vger.kernel.org>; Tue, 11 Feb 2025 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739289459; cv=none; b=UdQ3A/QSC2QtGcAphZBPRTOBxv2V/+u4gIPOBDvIWvSDqUy/6bj3V4bWXYyXX158Ow8Hdgi8qPOo4NzmRUFDY9wNaJnY9xeK4JhMFcPC4+K4YdbgK3Cr3fCSkitWJWMu8vP6KY1pc0swTBBULAKJq9ggF1oy1iHKcqjBPDGqVMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739289459; c=relaxed/simple;
	bh=mGkbpZGcuEAE5mzBw2KwEqym3+OuEvCN3tcnWIYfQa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRmK19YYzvJnUdM+Y2ufJgHGsnFjajTcR7W7bww/lPbpyvSsUGM9pb8ZHldBnCu9lI/MDMoigYmHfGgisHHbygIGg2qEnHYBgSHBZwJfOCpRJKJ77YHZadQ+0pBy1TvpU5JxqFmYQESCHWIqcZYGZNf43SQ/QD3HVntPpCliwHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=AYZFubIZ; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="AYZFubIZ"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YslVv1yCWzVLh;
	Tue, 11 Feb 2025 16:20:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1739287207;
	bh=vd3UC2SznqvkWEBk0v6NQpgUdLEiATZMCaqdFNyj0sI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AYZFubIZ5AJooRqW2mU7v5rAUikbdQrCE6F9lWj3wlskjMp9kiM/OpnK/cYOAdvmw
	 uUlAXfVaFGtxpXK3xzKfRHmdsV4kb8DF372sYGhPp0CV6Y8j1+KiV/Byv95mEjMMb3
	 lJrzvvi5ytBTv6nnkYwKwXe6uU53Htep6iBFzPgs=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YslVt5cNHzw3N;
	Tue, 11 Feb 2025 16:20:06 +0100 (CET)
Date: Tue, 11 Feb 2025 16:20:06 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, 
	Tahera Fahimi <fahimitahera@gmail.com>, Tanya Agarwal <tanyaagarwal25699@gmail.com>, 
	Alejandro Colomar <alx@kernel.org>, linux-man@vger.kernel.org, 
	Daniel Burgener <dburgener@linux.microsoft.com>
Subject: Re: [PATCH 2/2] landlock: Clarify IPC scoping documentation
Message-ID: <20250211.eudei8Ohth2w@digikod.net>
References: <20250124154445.162841-1-gnoack@google.com>
 <20250124154445.162841-2-gnoack@google.com>
 <Z5O44dxg8y-QZV62@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5O44dxg8y-QZV62@google.com>
X-Infomaniak-Routing: alpha

On Fri, Jan 24, 2025 at 04:59:29PM +0100, Günther Noack wrote:
> Hi!
> 
> This is an attempt to clarify the kernel documentation for Landlock's IPC
> scoping support before I send the same wording to the man page list in troff
> format.
> 
> (Adding Alejandro and the man-page list to get an early review on wording and
> clarity.)
> 
> On Fri, Jan 24, 2025 at 03:44:45PM +0000, Günther Noack wrote:
> > * Clarify terminology
> > * Stop mixing the unix(7) and signal(7) aspects in the explanation.
> > 
> > Terminology:
> > 
> > * The *IPC Scope* of a Landlock domain is that Landlock domain and its
> >   nested domains.
> > * An *operation* (e.g., signaling, connecting to abstract UDS) is said
> >   *to be scoped within a domain* when the flag for that operation was
> >   *set at ruleset creation time.  This means that for the purpose of
> >   *this operation, only processes within the domain's IPC scope are
> >   *reachable.

This makes sense, but there are a lot of stars in here. ;)

> > 
> > Cc: Mickaël Salaün <mic@digikod.net>
> > Cc: Tahera Fahimi <fahimitahera@gmail.com>
> > Cc: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> > Signed-off-by: Günther Noack <gnoack@google.com>
> > ---
> >  Documentation/userspace-api/landlock.rst | 53 ++++++++++++------------
> >  1 file changed, 26 insertions(+), 27 deletions(-)
> > 
> > diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> > index ca8b325d53e5..6b80106d33de 100644
> > --- a/Documentation/userspace-api/landlock.rst
> > +++ b/Documentation/userspace-api/landlock.rst
> > @@ -317,33 +317,32 @@ IPC scoping
> >  -----------
> >  
> >  Similar to the implicit `Ptrace restrictions`_, we may want to further restrict
> > -interactions between sandboxes. Each Landlock domain can be explicitly scoped
> > -for a set of actions by specifying it on a ruleset.  For example, if a
> > -sandboxed process should not be able to :manpage:`connect(2)` to a
> > -non-sandboxed process through abstract :manpage:`unix(7)` sockets, we can
> > -specify such a restriction with ``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET``.
> > -Moreover, if a sandboxed process should not be able to send a signal to a
> > -non-sandboxed process, we can specify this restriction with
> > -``LANDLOCK_SCOPE_SIGNAL``.
> > -
> > -A sandboxed process can connect to a non-sandboxed process when its domain is
> > -not scoped. If a process's domain is scoped, it can only connect to sockets
> > -created by processes in the same scope.
> > -Moreover, if a process is scoped to send signal to a non-scoped process, it can
> > -only send signals to processes in the same scope.
> > -
> > -A connected datagram socket behaves like a stream socket when its domain is
> > -scoped, meaning if the domain is scoped after the socket is connected, it can
> > -still :manpage:`send(2)` data just like a stream socket.  However, in the same
> > -scenario, a non-connected datagram socket cannot send data (with
> > -:manpage:`sendto(2)`) outside its scope.
> > -
> > -A process with a scoped domain can inherit a socket created by a non-scoped
> > -process. The process cannot connect to this socket since it has a scoped
> > -domain.
> 
> Tahera, Mickaël:
> 
> I suspect what was meant in this paragraph are Abstract Unix Domain Sockets of
> the datagram type? -- the scenario where the process has an (unconnected) Unix
> Datagram Socket and then can not call connect(2) or send(2) *on* it?

Yes, that's correct.

> 
> I removed this paragraph because I believe it's sufficiently covered in the
> section that I wrote about Abstract Unix Domain Sockets below.  If I'm
> misunderstanding this, please let me know. :)
> 
> > -
> > -IPC scoping does not support exceptions, so if a domain is scoped, no rules can
> > -be added to allow access to resources or processes outside of the scope.

> > +interactions between sandboxes.  Therefore, at ruleset creation time, each
> > +Landlock domain can restrict the scope for certain operations, so that these
> > +operations can only reach out to processes within the same Landlock domain or in
> > +a nested Landlock domain (the "scope").
> > +
> > +The operations which can be scoped are:
> > +
> > +``LANDLOCK_SCOPE_SIGNAL``
> > +    When set, this limits the sending of signals to target processes which run
> > +    within the same or a nested Landlock domain.
> > +
> > +``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET``
> > +    When set, this limits the set of abstract :manpage:`unix(7)` sockets we can
> > +    :manpage:`connect(2)` to to socket addresses which were created by a process
> > +    in the same or a nested Landlock domain.
> > +
> > +    A :manpage:`send(2)` on a non-connected datagram socket is treated like an
> > +    implicit :manpage:`connect(2)` and will be blocked when the remote end does
> > +    not stem from the same or a nested Landlock domain.
> > +
> > +    A :manpage:`send(2)` on a socket which was previously connected will work.
> > +    This works for both datagram and stream sockets.

Nice!  I also agree with Daniel and Alejandro.

> > +
> > +IPC scoping does not support exceptions via :manpage:`landlock_add_rule(2)`.
> > +If an operation is scoped within a domain, no rules can be added to allow access
> > +to resources or processes outside of the scope.

A bit of background on the rationale.  The particularity of scopes is
that they implicitly allow operations on the current or a nested domain.
With a handled field we would have needed to manually add exceptions for
processes in the current domain or a nested one, which would have been
possible with a new type of rule to identify relative domains (i.e. not
at ruleset creation time but at restriction time).  This new scope
semantic is easy to use, well specified (with this doc ;) ), and it
should fit to most sandbox use cases.  If we ever need a way to further
restrict the use of some IPC, we could still implement a new handled_*
field with the dedicated rule types, which could still compose with the
current scope.


> >  
> >  Truncating files
> >  ----------------
> > -- 
> > 2.48.1.262.g85cc9f2d1e-goog
> > 
> 
> —Günther
> 
