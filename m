Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD623426D2E
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 10:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158467; cv=none; b=FWVrAXpt9juinBenKtsIUEx0LO4EaaciYQIBLvvgs+7zN21j9TLeyeqhyFWHdKo9iDkNsfWjEPW4Pi9ufSoOeExMOJvubR4xbv44RZaeDnzE8FXnrO9UQM1ssChP5VtZJPGyIGKyh6LaTxsxOSYSRiFdP4anDShnYRANNjTmImA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158467; c=relaxed/simple;
	bh=h1AWZRxSrpr2Ju7TwFdK+nHYJRjWltU7Ec14LNpAKVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgNRvDQO4l9hPDoEZ3j2oeJuGUc+7VTRLCPe8yVDZmEH3goJlcpmgDgKN0yK0eYmU4FNQx/VBK/7A8G/n139gRgPutr5jMVd+Q7OZsr+fL1Pz0NMJrKUCfQaYpSsrD95khNxotJHFESENl0xEMEMMafour7D1zhAm0DTiOOaTeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1hdtkPw7; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1hdtkPw7"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hqXqv2SSSzbm3;
	Wed, 23 Sep 2026 12:14:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1790158443;
	bh=SFOa6PXnvBCltv3PDeGTOt6gr++V0R18iCtkjLktUwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1hdtkPw7LjOjMNpTmsouoDpZKOhNYHgwH7jTNmRKoiy+vNUY4cyKE6wJ+IzUt8eif
	 y7zmgJvFHUDPL7p4U9fWJqsRwAT8uLSNEBoPMSCT0PBT6AFjX/QXYDFHIEZHvV5sjm
	 whH3F5uMft8pCQMRryu1smUuECKWVDZj+7M4eLzc=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hqXqt21f2zd3w;
	Wed, 23 Sep 2026 12:14:02 +0200 (CEST)
Date: Wed, 23 Sep 2026 12:14:01 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Christopher Lusk <clusk@northecho.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: landlock: clarify TTY signal scoping
Message-ID: <20260923.oyohBie1Jeen@digikod.net>
References: <20260916152336.1589383-1-clusk@northecho.dev>
 <aqq3yY8SKIBGUZ8v@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqq3yY8SKIBGUZ8v@google.com>
X-Infomaniak-Routing: alpha

This looks good, much simpler.  Could you please send the (new) test
with the v3 of this series?

On Wed, Sep 16, 2026 at 05:37:45PM +0200, Günther Noack wrote:
> On Wed, Sep 16, 2026 at 11:23:36AM -0400, Christopher Lusk wrote:
> > The LANDLOCK_SCOPE_SIGNAL documentation does not describe how TTY-driven
> > signals interact with signal scoping.  Holding a PTY master file descriptor
> > is a separate capability: its holder can cause the TTY layer to signal
> > processes running under that terminal, even across a Landlock domain
> > boundary.
> > 
> > Add a concise clarification to the userspace API guide and the UAPI header.
> > This records the capability boundary identified during review of the
> > TIOCSIG discussion without enumerating individual TTY signal paths.
> > 
> > The documentation text and changelog were drafted with assistance from
> > Codex (gpt-5.6-sol).
> > 
> > The userspace API documentation builds successfully with the kernel-pinned
> > Sphinx dependencies.  The patch introduces no new warnings; the existing
> > missing-graphviz and undefined-label warnings are unchanged.
> 
> Minor nit: Last two paragraphs of the commit message would have been
> fine to drop for conciseness (the Assisted-by line already lists Codex
> and the other paragraph talks about things that didn't change).
> 
> But really just very minor, and probably not worth changing unless we
> unexpectedly need a V3.
> 
> > 
> > Link: https://lore.kernel.org/r/aqqJAZfG9FC7PgMW@google.com
> > Suggested-by: Günther Noack <gnoack@google.com>
> > Assisted-by: Codex:gpt-5.6-sol
> > Signed-off-by: Christopher Lusk <clusk@northecho.dev>
> > ---
> >  Documentation/userspace-api/landlock.rst | 3 +++
> >  include/uapi/linux/landlock.h            | 2 ++
> >  2 files changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> > index 84cb7bf6b3ed..33a514ebc615 100644
> > --- a/Documentation/userspace-api/landlock.rst
> > +++ b/Documentation/userspace-api/landlock.rst
> > @@ -430,6 +430,9 @@ The operations which can be scoped are:
> >      This limits the sending of signals to target processes which run within the
> >      same or a nested Landlock domain.
> >  
> > +    Holding a PTY master FD still grants the capability to issue signals through
> > +    that PTY to the processes running under that terminal.

It would be more complete to quickly explain that a master TTY FD should
be considered at least as privileged as the processes using/trusting the
slave side.  See
https://lore.kernel.org/all/20260923.eehieph7UaX1@digikod.net/

So, this paragraph should really be short.

> > +
> >  ``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET``
> >      This limits the set of abstract :manpage:`unix(7)` sockets to which we can
> >      :manpage:`connect(2)` to socket addresses which were created by a process in
> > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > index cceda3b3b961..6485af37dd25 100644
> > --- a/include/uapi/linux/landlock.h
> > +++ b/include/uapi/linux/landlock.h
> > @@ -501,6 +501,8 @@ struct landlock_net_port_attr {
> >   *   related Landlock domain (e.g., a parent domain or a non-sandboxed process).
> >   * - %LANDLOCK_SCOPE_SIGNAL: Restrict a sandboxed process from sending a signal
> >   *   to another process outside the domain.
> > + *   Holding a PTY master FD still grants the capability to issue signals
> > + *   through that PTY to the processes running under that terminal.

What about rewording the LANDLOCK_SCOPE_SIGNAL description to say that
it is about signaling *arbitrary* processes (which is not the case with
the TTY master FD)?  This way we would not have to specifically re-talk
about the TTY case.

> >   */
> >  /* clang-format off */
> >  #define LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
> > -- 
> > 2.55.0
> > 
> 
> Reviewed-by: Günther Noack <gnoack@google.com>
> 
> Thank you very much for your contribution! :)
> 
> It ended up as a much smaller patch than we started out with, but the
> real advancement lies in the understanding of the semantics and in the
> double checking of these boundary conditions.  The LLM output was in
> some cases a bit wordy ;-) but overall this was a good discovery and
> useful discussion.
> 
> Thanks,
> —Günther
> 
