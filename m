Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B911C321434
	for <linux-security-module@vger.kernel.org>; Thu,  5 Feb 2026 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318934; cv=none; b=pcBSVJlANWlft9HBphutTzHHVQH3wB2+Y5Vt7h6gLwfWUhxZXY7m2JjuoVTnu2jTbnQ4kT6AJ1NXXNfQzo0C1fBixA6oQsLVX2I7RIz3AQvbHrrigz0StkDfIOTDkxMQxOjMVurqO/DXBExqF8XI4nr6diHv0umJI3H0V+3NqEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318934; c=relaxed/simple;
	bh=qA9G4zwebbTzIDiIl17sb4ppMzQyZ2NGr6TpcB12tv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMEp40IIogXGkqxHmfoHHWRewsDOZbYP+qYKdY27aXrQScwo5zOq9Llq0uzaW09riqoYbp4IQv+/uIE2XScpoCI7j+GVccl5x5w9oFHBmwzY1yqWZmms6MZpymhxKO7tsIK5jfzO22QFA9zuygra4y3qnkVsvsUd3t0CK0HF+50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=xjm3DlKI; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="xjm3DlKI"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f6Rkh6QQ9z8Lt;
	Thu,  5 Feb 2026 20:15:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1770318924;
	bh=o1xF/iBeIcBtrAwiWs6EtRFvi4hWlX0W7LyER67lqyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xjm3DlKICkhXEZ/P0vL0NKXTUN0k+Ucb4qHub/LirZcyfgQxlH3MwCn7SvZ+YwFkO
	 ymjIeVBYuXE+G6B5Loz9FOMmfR9yTEhtp3hguFpc354/nix56rGKX0dLOmG4gs+IQk
	 B+12qIQve7FIxj1Q9srHKakf/om1/vvuKp/SaYLg=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4f6Rkh1k0Szvsl;
	Thu,  5 Feb 2026 20:15:24 +0100 (CET)
Date: Thu, 5 Feb 2026 20:15:20 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Tingmao Wang <m@maowtm.org>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, linux-security-module@vger.kernel.org, 
	Matthieu Buffet <matthieu@buffet.re>
Subject: Re: [PATCH v2 0/6] Landlock: Implement scope control for pathname
 Unix sockets
Message-ID: <20260205.phohK6hajaih@digikod.net>
References: <f07fe41a-96c5-4d3a-9966-35b30b3a71f1@maowtm.org>
 <20260202.uu0oCheexahY@digikod.net>
 <8093547c-ab40-4814-ac9a-8dff6f2a2a90@gmail.com>
 <16129d76-b6d3-4959-b241-dc79a32dd0cd@maowtm.org>
 <aYI2OQhPMgdMAOiz@google.com>
 <e6b6b069-384c-4c45-a56b-fa54b26bc72a@maowtm.org>
 <aYMxHRwHCao30HfX@google.com>
 <bfcac905-5901-4cfb-8489-fb228cef0ee0@gmail.com>
 <20260204.vug7Osheiwou@digikod.net>
 <44d216aa-9680-4cf5-bbf0-173869111212@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44d216aa-9680-4cf5-bbf0-173869111212@gmail.com>
X-Infomaniak-Routing: alpha

On Thu, Feb 05, 2026 at 10:18:54AM -0500, Justin Suess wrote:
> 
> On 2/4/26 13:28, Mickaël Salaün wrote:
> 
> >> [...]
> >> Tingmao:
> >>
> >> For connecting a pathname unix socket, the order of the hooks landlock sees is something like:
> >>
> >> 1.  security_unix_find. (to look up the paths)
> >>
> >> 2. security_unix_may_send, security_unix_stream_connect (after the path is looked up)
> >>
> >> Which for is called in DGRAM:
> >>
> >>  unix_dgram_connect OR  unix_dgram_sendmsg 
> >>
> >> and for STREAM:
> >>
> >>  unix_stream_connect
> >>
> >> IIRC, the path lookup only occurs in this order always, so in the logic as you have it the domain_is_scoped()
> >> would be called twice, once from the security_unix_find when you call it in step two, and once from the
> >> domain scope hooks. (If access was allowed from security_unix_find)
> >>
> >> There are a couple of things to consider.
> >>
> >> ---
> >>
> >> Audit blockers need special handling:
> >>
> >> Here's an example:
> >>
> >> 1. Program A enforces a ruleset with RESOLVE_UNIX and the unix pathname scope bit, with no rules with that
> >> access bit (deny all for RESOLVE_UNIX).
> >>
> >> 2. Program A connects to /tmp/mysock.sock ran by program B, which is outside the domain.
> >>
> >> 2. security_unix_find is hit to lookup the path, and the RESOLVE_UNIX code doesn't grant access to
> >> /tmp/mysock.sock, so it calls domain_is_scoped
> >>
> >> 3. domain_is_scoped denies it as well, so now we must log an audit record.
> >>
> >> When logging the denial, we have to include both blockers "scope.unix_socket"  and "fs.resolve_unix" for the
> >> denial, because it is the absence of both that caused the denial. I think the refer right has similar cases for auditing, so there is precedent for this (multiple blockers for an audit message).
> > That's a good point, and it would give more informations to diagnose
> > issues.  However, being able to identify if both accesses are denied
> > would require to check both, whereas the first is enough to know that
> > Landlock denies the access.  So, if we can return both records without
> > continuing the security checks, that's good, otherwise we should stop
> > ASAP and return the error.
> Maybe I'm missing something, but if the flags interact in an "OR" manner
> wouldn't we need to check both?

Yes, but my point is that as soon as one or the other *denies* an
access, there is no need to check the other access type.

> In your proposal where RESOLVE_UNIX
> implies the scoped flag, if a program connects to a unix socket that is within
> the domain but does not have an explicit RESOLVE_UNIX exception, we must
> still check for the case that the access is scoped.
> 
> ---
> 
> (Given LANDLOCK_ACCESS_FS_RESOLVE_UNIX and LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
> are set)
> 
> case 1: access to socket within domain and no RESOLVE_UNIX rule covers the access
> 
> We check first in security_unix_find hook and find there is no rule allowing the access.
> After the check fails, because LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET is set
> we then check is_domain_scoped, the check allows the access.
> 
> case 2: access to socket outside domain but RESOLVE_UNIX rule covers the access
> 
> We check first in security_unix_find hook and find there is a rule allowing the access.
> We can allow the access early (short-circuit eval) without calling is_domain_scoped.
> 
> case 4: access to socket inside domain and RESOLVE_UNIX covers the access
> 
> We check first in security_unix_find hook and find there is a rule allowing the access.
> We can allow the access early (short-circuit eval) without calling is_domain_scoped. (same as case 2)
> 
> 
> case 4: access to socket outside domain and no RESOLVE_UNIX covers the access
> 
> We check first in security_unix_find hook and find there is no rule allowing the access.
> After the check fails, because LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET is set
> we then check is_domain_scoped, the check does not allow the access. (it is the combination
> of the two checks failing that denied the access).

BTW, we should first check is_domain_scoped() because it is quicker than
the FS checks.

> 
> ---
> 
> Case 4 is what I'm specifically considering would need to have both blockers listed in a denial audit.
> We can't short circuit in that case because we have to check the scoping before denying.
> Let me know if I'm misunderstanding this.

Indeed, if both deny the request, both should be listed.

Anyway, we're now going to only have one access flag that would merge
both semantic, so this should not be an issue.

However, this specific case will be relevant when we'll add e.g., a
signal attr that would then be complementary to the signal scope.  At
this point, I think it would be enough to only log the signal.* record
because it would be a superset of the scope.signal

> 
> (PS: IIRC the hooks used by the LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
> will never be hit if the check in security_unix_find fails. So some logic to check this
> access in security_unix_find will be needed).
> 
> >
> > Anyway, that might not be needed if we end up with my latest proposal
> > about always setting scope.unix_socket when fs.resolve_unix is set.
> >
> >> ---
> >>
> >> Dual lookup for domain_is_scoped. Consider this case:
> >>
> >> 1. Program A enforces a ruleset with RESOLVE_UNIX and the unix pathname scope bit, with no rules with that
> >> access bit (deny all for RESOLVE_UNIX).
> >>
> >> 2. Program A connects to Program C's /tmp/foo.sock, which for the purposes of this example is in the domain of program A.
> >>
> >> 3.  security_unix_find is hit to lookup the path, and the RESOLVE_UNIX code doesn't grant access to
> >> /tmp/mysock.sock, so it calls domain_is_scoped. Access is granted, and continues. (LSM hook complete)
> >>
> >> 4.  The connection proceeds past the path lookup stage, and now security_unix_may_send, or security_unix_stream_connect gets called. This requires ANOTHER domain_is_scoped access check.
> >>
> >> While I don't THINK this introduces a TOCTOU, it is a little confusing.
> >>
> >> This does mean that we look up the domain twice, if this is implemented naively. I think we can then just
> >> skip the task credential checks then for security_unix_may_send and security_unix_stream_connect **for
> >> connecting to pathname sockets**, since the domain_is_scoped will already have been called in landlock's
> >> security_unix_find hook, eliminating the need for handling pathname socket domain checks layer on.
> >>
> >>>> I definitely agree that it is tricky, but making same-scope access be
> >>>> allowed (i.e. the suggested idea above) would only get rid of step 1,
> >>>> which I think is the "simpler" bit.  The extra logic in step 2 is still
> >>>> needed. 
> >>>>
> >>>> I definitely agree with pro1 tho.
> >>> Yes, you are describing the logic for the variant where
> >>> LANDLOCK_ACCESS_FS_RESOLVE_UNIX does not implicitly permit access from
> >>> within the same scope.  In that variant, there can be situations where
> >>> the first hook can deny the action immediately.
> >>>
> >>> In the variant where LANDLOCK_ACCESS_FS_RESOLVE_UNIX *does* implicitly
> >>> allow access from within the same scope, that shortcutting is not
> >>> possible.  On the upside however, there is no need to distinguish
> >>> whether the scope flag is set when we are in the security_unix_find()
> >>> hook, because access from within the same scope is always permitted.
> >>> (That is the simplification I meant.)
> >>>
> >>>
> >>>>> AGAINST:
> >>>>>
> >>>>> (con1) It would work differently than the other scoped access rights
> >>>>>        that we already have.
> >>>>>
> >>>>>        A speculative feature that could potentially be built with the
> >>>>>        scoped access rights is that we could add a rule to permit IPC
> >>>>>        to other Landlock scopes, e.g. introducing a new rule type
> >>>>>
> >>>>>          struct landlock_scope_attr {
> >>>>>            __u64 allowed_access;  /* for "scoped" bits */
> >>>>>            /* some way to identify domains */
> >>>>>          }
> >>>>>
> >>>>>        so that we could make IPC access to other Landlock domains
> >>>>>        configurable.
> >>>>>
> >>>>>        If the scoped bit and the FS RESOLVE_UNIX bit were both
> >>>>>        conflated in RESOLVE_UNIX, it would not be possible to make
> >>>>>        UNIX connections configurable in such a way.
> >>>> This exact API would no longer work, but if we give up the equivalence
> >>>> between scope bits and the landlock_scope_attr struct, then we can do
> >>>> something like:
> >>>>
> >>>> struct landlock_scope_attr {
> >>>>     __u64 ptrace:1;  /* Note that this is not a (user controllable) scope bit! */
> >>>>     __u64 abstract_unix_socket:1;
> >>>>     __u64 pathname_unix_socket:1;
> >>>>     /* ... */
> >>>>
> >>>>     __u64 allowed_signals;
> >>>>
> >>>>     /*
> >>>>      * some way to identify domains, maybe we could use the audit domain
> >>>>      * ID, with 0 denoting "allow access to non-Landlocked processes?
> >>>>      */
> >>>> }
> >>> Yes, it would be possible to use such a struct for that scenario where
> >>> IPC access gets allowed for other Landlock scopes.  It would mean that
> >>> we would not need to introduce a scoped flag for the pathname UNIX
> >>> socket connections.  But the relationship between that struct
> >>> landlock_scope_attr and the flags and access rights in struct
> >>> landlock_ruleset_attr would become less clear, which is a slight
> >>> downside, and maybe error prone for users to work with.
> >>>
> >>> If we introduced an additional scoped flag, it would also be
> >>> consistent though.
> >>>
> >>> (con1) was written under the assumption that we do not have an
> >>> additional scoped flag.  If that is lacking, it is not possible to
> >>> express UNIX connect() access to other Landlock domains with that
> >>> struct.  But as outlined in the proposal below, if we *do* (later)
> >>> introduce the additional scoped flag *in addition* to the FS access
> >>> right, this *both* stays consistent in semantics with the signal and
> >>> abstract UNIX support, *and* it starts working in a world where ICP
> >>> access can be allowed to talk to other Landlock domains.
> >>>
> >>>>> (con2) Consistent behaviour between scoped flags and their
> >>>>>        interactions with other access rights:
> >>>>>
> >>>>>        The existing scoped access rights (signal, abstract sockets)
> >>>>>        could hypothetically be extended with a related access right of
> >>>>>        another type. For instance, there could be an access right type
> >>>>>
> >>>>>          __u64 handled_signal_number;
> >>>>>
> >>>>>        and then you could add a rule to permit the use of certain
> >>>>>        signal numbers.  The interaction between the scoped flags and
> >>>>>        other access rights should work the same.
> >>>>>
> >>>>>
> >>>>> Constructive Proposal for consideration: Why not both?
> >>>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>> I will think about the following a bit more but I'm afraid that I feel
> >>>> like it might get slightly confusing.  With this, the only reason for
> >>>> having LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET is for API consistency when we
> >>>> later enable allowing access to other domains (if I understood correctly),
> >>>> in which case I personally feel like the suggestion on landlock_scope_attr
> >>>> above, where we essentially accept that it is decoupled with the scope
> >>>> bits in the ruleset, might be simpler...?
> >>> Mickaël expressed the opinion to me that he would like to APIs to stay
> >>> consistent between signals, abstract UNIX sockets, named UNIX sockets
> >>> and other future "scoped" operations, in scenarios where:
> >>>
> >>> * the "scoped" (IPC) operations can be configured to give access to
> >>>   other Landlock domains (and that should work for UNIX connections too)
> >>> * the existing "scoped" operations also start having matching access rights
> >>>
> >>> I think with the way I proposed, that would be consistent.
> >>>
> >>>
> >>>>> Why not do both what Tingmao proposed in [1] **and** reserve the
> >>>>> option to add the matching "scoped flag" later?
> >>>>>
> >>>>>   * Introduce LANDLOCK_ACCESS_FS_RESOLVE_UNIX.
> >>>>>
> >>>>>     If it is handled, UNIX connections are allowed either:
> >>>>>
> >>>>>     (1) if the connection is to a service in the same scope, or
> >>>>>     (2) if the path was allow-listed with a "path beneath" rule.
> >>>>>
> >>>>>   * Add LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET later, if needed.
> >>>>>
> >>>>>
> >>>>> Let's go through the arguments again:
> >>>>>
> >>>>> We have observed that it is harmless to allow connections to services
> >>>>> in the same scope (1), and that if users absolutely don't want that,
> >>>>> they can actually prohibit it through LANDLOCK_ACCESS_FS_MAKE_SOCK
> >>>>> (pro1).
> >>>>>
> >>>>> (con1): Can we still implement the feature idea where we poke a hole
> >>>>>         to get UNIX-connect() access to other Landlock domains?
> >>>>>
> >>>>>   I think the answer is yes.  The implementation strategy is:
> >>>>>
> >>>>>     * Add the scoped bit LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
> >>>>>     * The scoped bit can now be used to allow-list connections to
> >>>>>       other Landlock domains.
> >>>>>
> >>>>>   For users, just setting the scoped bit on its own does the same as
> >>>>>   handling LANDLOCK_ACCESS_FS_RESOLVE_UNIX.  That way, the kernel-side
> >>>>>   implementation can also stay simple.  The only reason why the scoped
> >>>>>   bit is needed is because it makes it possible to allow-list
> >>>>>   connections to other Landlock domains, but at the same time, it is
> >>>>>   safe if libraries set the scoped bit once it exists, as it does not
> >>>>>   have any bad runtime impact either.
> >>>>>
> >>>>> (con2): Consistency: Do all the scoped flags interact with their
> >>>>>         corresponding access rights in the same way?
> >>>>>
> >>>>>   The other scope flags do not have corresponding access rights, so
> >>>>>   far.
> >>>>>
> >>>>>   If we were to add corresponding access rights for the other scope
> >>>>>   flags, I would argue that we could apply a consistent logic there,
> >>>>>   because IPC access within the same scope is always safe:
> >>>>>
> >>>>>   - A hypothetical access right type for "signal numbers" would only
> >>>>>     restrict signals that go beyond the current scope.
> >>>>>
> >>>>>   - A hypothetical access right type for "abstract UNIX domain socket
> >>>>>     names" would only restrict connections to abstract UNIX domain
> >>>>>     servers that go beyond the current scope.
> >>>>>
> >>>>>   I can not come up with a scenario where this doesn't work.
> >> Gunther / Tingmao / Mickaël:
> >>
> >> I have a potential idea to make this concept cleaner.
> >>
> >> The docs for landlock currently say:
> >>
> >>
> >>        IPC scoping does not support exceptions via landlock_add_rule(2).
> >>        If an operation is scoped within a domain, no rules can be added
> >>        to allow access to resources or processes outside of the scope.
> > This part might indeed be confusing.  The idea was to explain the
> > difference between scoped rights and handled access rights (which may
> > have rules).
> >
> >> So if we go with the solution where we are now saying IPC scoping DOES support exceptions
> >> we will need to update the documentation, to say scoping for pathname unix sockets is an exception,
> >> and have to have the "exemptible scopes" (like this one) alongside "non-exemptible" scopes
> >> (ie the existing ones). This creates some friction for users.
> > The documentation will definitely require some updates.  I think it can
> > be explained in a simple way.
> >
> >> If we foresee other "exempt-able scopes" (which are scopes that also support creating exemptions w/ corresponding access rights) in the future, maybe we should consider separating the two in the ruleset
> >> attributes (I used scoped_fs as an example for the attribute name):
> >>
> >> structlandlock_ruleset_attrruleset_attr={
> >> .handled_access_fs=
> >> LANDLOCK_ACCESS_FS_EXECUTE|
> >> LANDLOCK_ACCESS_FS_WRITE_FILE|
> >> LANDLOCK_ACCESS_FS_READ_FILE|
> >> LANDLOCK_ACCESS_FS_READ_DIR|
> >> LANDLOCK_ACCESS_FS_REMOVE_DIR|
> >> LANDLOCK_ACCESS_FS_REMOVE_FILE|
> >> LANDLOCK_ACCESS_FS_MAKE_CHAR|
> >> LANDLOCK_ACCESS_FS_MAKE_DIR|
> >> LANDLOCK_ACCESS_FS_MAKE_REG|
> >> LANDLOCK_ACCESS_FS_MAKE_SOCK|
> >> LANDLOCK_ACCESS_FS_MAKE_FIFO|
> >> LANDLOCK_ACCESS_FS_MAKE_BLOCK|
> >> LANDLOCK_ACCESS_FS_MAKE_SYM|
> >> LANDLOCK_ACCESS_FS_REFER|
> >> LANDLOCK_ACCESS_FS_TRUNCATE|
> >> LANDLOCK_ACCESS_FS_IOCTL_DEV,
> >> .handled_access_net=
> >> LANDLOCK_ACCESS_NET_BIND_TCP|
> >> LANDLOCK_ACCESS_NET_CONNECT_TCP,
> >> .scoped=
> >> LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET|
> >> LANDLOCK_SCOPE_SIGNAL,
> >>     .scoped_fs = 
> >> 	LANDLOCK_SCOPE_FS_PATHNAME_UNIX_SOCKET
> >> };
> >>
> >> This more clearly distinguishes between scopes that have exceptions/corresponding fs rights,
> >> and ones that don't. Later we could add scoped_net, if needed. I feel like this would be more
> >> intuitive and better categorize future scoping rights. An obvious con is increasing the size of
> >> the ruleset attributes.
> > I see your point but I don't think it would be worth it to add
> > sub-scoped fields.  Each field has a clear semantic, and the scoped one
> > is related to the domain wrt other domains.
> As long as it's documented clearly, and future IPCs have similar behavior
> I agree that a separate field probably isn't needed.
> >
> >> Of course this separation is only worth it if there are other "exempt-able" rights in the future.
> >> I can think of a few potential future rights which COULD be scoped and have corresponding rights
> >> (binder, sysv-ipc, pipes, tcp/udp between two local programs). 
> > Yes, it would definitely be useful to add exception for other kind of
> > IPCs.  The idea would be to be able to describe the peer, either with a
> > file path, or PID, or cgroups, or a Landlock domain...  The inet case
> > is an interesting idea but that might be a challenging task to
> > implement, if even possible.
> 
> >
> >>>>>
> >>>>> In conclusion, I think the approach has significant upsides:
> >>>>>
> >>>>>   * Simpler UAPI: Users only have one access bit to deal with, in the
> >>>>>     near future.  Once we do add a scope flag for UNIX connections, it
> >>>>>     does not interact in a surprising way with the corresponding FS
> >>>>>     access right, because with either of these, scoped access is
> >>>>>     allowed.
> >>>>>
> >>>>>     If users absolutely need to restrict scoped access, they can
> >>>>>     restrict LANDLOCK_ACCESS_FS_MAKE_SOCK.  It is a slightly obscure
> >>>>>     API, but in line with the "make easy things easy, make hard things
> >>>>>     possible" API philosophy.  And needing this should be the
> >>>>>     exception rather than the norm, after all.
> >>>>>
> >>>>>   * Consistent behaviour between scoped flags and regular access
> >>>>>     rights, also for speculative access rights affecting the existing
> >>>>>     scoped flags for signals and abstract UNIX domain sockets.
> >>>>>
> >>>>> [1] https://lore.kernel.org/all/f07fe41a-96c5-4d3a-9966-35b30b3a71f1@maowtm.org/
> >>> —Günther
