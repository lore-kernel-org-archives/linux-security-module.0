Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0007A1F540D
	for <linux-security-module@vger.kernel.org>; Tue,  7 Jan 2025 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259393; cv=none; b=onKv9wZtsJoOI1hGjJ+9d7hz4QnBJUw9nnLxrEmSKKfUgDvJ7WLTATZoXUg5aM2od/lGRImLdxYGZ+71wr0Ft9hd6MEhIN6chsHcOrGCkjgmPwkbqdknDoedcGViao6if6n+q56TObG36tqQ4C8Oja4IhksjVONRju3pz0ziaSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259393; c=relaxed/simple;
	bh=HkWRbgtHRgtFxahtfa+4WFYJvcN8mxyN8lLNocI1x0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7dJGrsFBsihuDQEK9N4LB/MfuNyfGqL9i4H/0z8I4aF52A1m4qLTa3hBgP7rgOMvnLllDqhTTptytIlPA92LvQIBKNMqkFaM5nB2g4vDoaPeQb7gpZ0omhaLULeewB7fn5RX6MsIdNsL3ekXvM0ABPJIjDOyUs7GtBBhnKR7d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=QUh9UMPq; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="QUh9UMPq"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YSClX40fWzVG0;
	Tue,  7 Jan 2025 15:16:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736259384;
	bh=qjoeBhexUB4tppgwtHsPKezms784ibvFJ+1Aw98kSVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QUh9UMPq0RxKSCmelKqdKeLxtQzNkZSW1RTy18wm/5MSI6/WtPgByG6OWgcf/Ws3q
	 K+JygkQpSRcHHptFkCQtIH3Uo8Oevgl68bO18ALftz0nXagVkedj3gaDRdyHtbPOMG
	 B+w9a+VUILEmF08uBorLtmH/DOElIG3u8md27aTc=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YSClV0VwFzCvb;
	Tue,  7 Jan 2025 15:16:21 +0100 (CET)
Date: Tue, 7 Jan 2025 15:16:18 +0100
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
Subject: Re: [PATCH v3 10/23] landlock: Log domain properties and release
Message-ID: <20250107.alee0ahMovoh@digikod.net>
References: <20241122143353.59367-11-mic@digikod.net>
 <237bfe2be7b4ba5d59b3b832c23622bb@paul-moore.com>
 <20250106.ohgh8Zeu6coo@digikod.net>
 <CAHC9VhR7EWDm5afnzRbVO6jkqtwtBe-UbHk+b-bED7uwisu_bA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhR7EWDm5afnzRbVO6jkqtwtBe-UbHk+b-bED7uwisu_bA@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Jan 06, 2025 at 04:56:50PM -0500, Paul Moore wrote:
> On Mon, Jan 6, 2025 at 9:51 AM Mickaël Salaün <mic@digikod.net> wrote:
> > On Sat, Jan 04, 2025 at 08:23:51PM -0500, Paul Moore wrote:
> > > On Nov 22, 2024 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> ...
> 
> > > > Audit event sample for a first denial:
> > > >
> > > >   type=LL_DENY msg=audit(1732186800.349:44): domain=195ba459b blockers=ptrace opid=1 ocomm="systemd"
> > > >   type=LL_DOM_INFO msg=audit(1732186800.349:44): domain=195ba459b creation=1732186800.345 pid=300 uid=0 exe="/root/sandboxer" comm="sandboxer"
> > > >   type=SYSCALL msg=audit(1732186800.349:44): arch=c000003e syscall=101 success=no [...] pid=300 auid=0
> > >
> > > As mentioned in patch 9/23, I don't want subsystems external to audit
> > > to access the audit timestamp information, so the "creation=" field
> > > in the audit event would need to be removed.  Assuming that the timestamp
> > > was used either to reference the original domain creation and/or simply
> > > provide some additional information for analysis, all of that information
> > > should already be in the audit log, assuming of course that you are
> > > logging domain creation (which you should, at least as an option).
> >
> > As explained in this patch, we don't want to (and cannot realistically)
> > log domain creations.  That would make the audit support for Landlock
> > unusable.  Moreover, these information is useless and only add noise
> > unless there is a denial, hence this asynchronous approach.
> 
> That's fine, just know that it doesn't change my thoughts on exposing
> the audit timestamp.
> 
> > However,
> > users may want to log some syscalls, including landlock_restrict_self(),
> > and it would make audit logs more consistent using the same timestamp as
> > the Landlock domain creation time.  I'm wondering why exposing this
> > timestamp to the kernel would be an issue whereas it is already exposed
> > to user space.
> 
> Currently there are no other users of the audit timestamp besides
> audit.  Making the audit timestamp available to other subsystems makes
> the timestamp less flexible over the long term as it would become, in
> a way, part of the API that audit provides to other in-kernel users.
> 
> I still have hopes to rework a large chunk of the audit subsystem, and
> keeping the interfaces between audit and the other in-kernel
> subsystems makes that easier.

OK

> 
> > If you're really opposed to it I can create a new unrelated timestamp
> > specific to Landlock.
> 
> Yes, at this point in time I don't want to support exporting the audit
> timestamp outside of audit.  My guess is that you probably want to use
> some identifier, other than a timestamp, when trying to link Landlock
> events (presumably the domain ID would do this?), but I don't pretend
> to know the details of Landlock very well right now.

Correct, Landlock domain IDs are used to tie domain creation, denial,
and destruction/drop events (and their use will be extended to user
space in the future).

> 
> > > Also, is there a good reason why the LL_DOM_INFO information can't be
> > > recorded in the LL_DENY (or LL_ACCESS) record?  I think that would be
> > > preferable.
> >
> > The goal of the standalone LL_DOM_INFO record type is to limit useless
> > log verbosity.  Including this information in LL_DENY would have two
> > downsides:
> > - it would increases the length of *all* LL_DENY messages
> 
> Are you ever going to emit a LL_ACCESS/LL_DENY record without a
> LL_DOM_INFO record?

Yes, only the first LL_DENY (for a domain) emits an LL_DOM_INFO (for
this same domain), which is why this design is interesting: creation of
domains can happen at a high frequency (e.g. script executing a
sandboxed program in a loop, or just build a kernel with sandbox
compilers), and logging every domain creation would make 99% of these
events useless.  See log_status's LANDLOCK_LOG_RECORDED in log_node() in
this patch.

> 
> > - it would make it more difficult to extend this new mixed messages with
> >   access-related informations (e.g. file property) and domain-related
> >   informations (and associate them with either the object or the
> >   domain).
> 
> How?  Please elaborate on this.

I mean that appending intertwined (i.e. some might be related to define
a domain whereas others might be related to define an object) and
optional (e.g. a file object and a socket object are not defined the
same way) new fields to one message type makes the message less
predictable and more difficult to parse.

> 
> > > > Audit event sample for logged domains deletion:
> > > >
> > > >   type=LL_DOM_DROP msg=audit(1732186800.393:45): domain=195ba459b
> > > >
> > > > Cc: Günther Noack <gnoack@google.com>
> > > > Cc: Paul Moore <paul@paul-moore.com>
> > > > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > > > Link: https://lore.kernel.org/r/20241122143353.59367-11-mic@digikod.net
> > > > ---
> > > > Questions:
> > > > - Should we also log the creator's loginuid?
> > > > - Should we also log the creator's sessionid?
> > >
> > > Creation of a Landlock domain can only happen through the Landlock
> > > syscalls, yes?  If so, that information should already be logged in
> > > the associated syscall record (see the "auid=" and "ses=" fields )and
> > > we generally try to avoid duplicating information across records in
> > > the same audit event.
> >
> > The specificity of Landlock compared to existing supported systems is
> > that we cannot log domain creation for the reason I explain before.
> 
> Can you provide a link to that explanation?  I'm sure you explained it
> well, but I missed it when going over the patchset with a focus on
> audit.

That wasn't clear enough, I'll include the previous description in the
next series, but the basic design idea is defined in the cover letter:
https://lore.kernel.org/all/20241122143353.59367-1-mic@digikod.net/

> 
> If the Landlock domain is created independent from any user/process
> action, it likely doesn't make sense to log either the loginuid or
> sessionid since the domain creation is happening independently from a
> user session.

Landlock domain creations are a process action.  What we want to log are
the denials and a minimal context (e.g. which task created the related
domain).  I was wondering if we should (right now) include loginuid or
sessionid in this (asynchronous) context.
