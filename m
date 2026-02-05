Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FA938F935
	for <linux-security-module@vger.kernel.org>; Thu,  5 Feb 2026 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770287234; cv=none; b=aipGxyyNBRYpOC/jIac+wU4JNqSvyum2Ukt0kTlGGtsYj1YctQ9okf/mHlaAB3/SnWMqaBK4teWWUCQosSJlvm1YbPcPoo72rMqAO+oI6tqHP12elz9who+7yXL3AhsK//n1C0UCaJIUDv9mY9svNf0m4PD5PUx6zjQmmICMtHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770287234; c=relaxed/simple;
	bh=SDHqvdRq+9kkRxaJ+xb/6DluhJ3MGu6JiRR72nWr4b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPd08Dyo93H826A8zX5eujlNkFRF0QFi/BfRUdOVPXGhBNE4fH9gUNTG7/KyPcPyo4x4OlrVuwnoTshnv3bsjNFhw3Rrw9xEkttBWg+fZFXkLRGPPKbMJBaXvkHLvGkjkqor+1D60tKYj1oSx5yoyVb7oy8tKkJhH65UAkAyIbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Lhcwdjsh; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Lhcwdjsh"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f6D1938TVzkv;
	Thu,  5 Feb 2026 11:27:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1770287229;
	bh=DL/L4KOrUYctPO9xXv16mvMiDfMz1mSPBPLY+EtJLBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lhcwdjsh3PWFQGjh+QvMEYGOVddenT8h2jB8PGB0ALq56rbvFw45rXQ/Z7r53cEUm
	 dKXrmhDcosqDap6x1CqJhioHcWYoDmfpYYnrFwJiSbVr9Rkq4P7f+0B+Bfed/LwFs6
	 rvmI9Z1vULTnP0XuWXKZtYQQ4gom4ees1DDHMgLc=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4f6D183s0CzTHw;
	Thu,  5 Feb 2026 11:27:08 +0100 (CET)
Date: Thu, 5 Feb 2026 11:27:03 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, John Johansen <john.johansen@canonical.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, linux-security-module@vger.kernel.org, 
	Matthieu Buffet <matthieu@buffet.re>
Subject: Re: [PATCH v2 0/6] Landlock: Implement scope control for pathname
 Unix sockets
Message-ID: <20260205.Kiech3gupee1@digikod.net>
References: <20260109.Ino1ahfef1iu@digikod.net>
 <f07fe41a-96c5-4d3a-9966-35b30b3a71f1@maowtm.org>
 <20260202.uu0oCheexahY@digikod.net>
 <8093547c-ab40-4814-ac9a-8dff6f2a2a90@gmail.com>
 <16129d76-b6d3-4959-b241-dc79a32dd0cd@maowtm.org>
 <aYI2OQhPMgdMAOiz@google.com>
 <e6b6b069-384c-4c45-a56b-fa54b26bc72a@maowtm.org>
 <aYMxHRwHCao30HfX@google.com>
 <20260204.quaiyeiW9ipo@digikod.net>
 <20260205.8531e4005118@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260205.8531e4005118@gnoack.org>
X-Infomaniak-Routing: alpha

On Thu, Feb 05, 2026 at 09:02:19AM +0100, Günther Noack wrote:
> On Wed, Feb 04, 2026 at 06:43:24PM +0100, Mickaël Salaün wrote:
> > On Wed, Feb 04, 2026 at 12:44:29PM +0100, Günther Noack wrote:
> > > On Tue, Feb 03, 2026 at 09:53:11PM +0000, Tingmao Wang wrote:
> > > > On 2/3/26 17:54, Günther Noack wrote:
> > > > >> Furthermore, an application / Landlock config etc can always opt to not
> > > > >> use the scope bit at all, if it "knows" all the locations where the
> > > > >> application's sockets would be placed, and just use RESOLVE_UNIX access
> > > > >> right (or nothing if it is not supported).
> > > > >>
> > > > >> (The following is a bit of a side note, not terribly relevant if we're
> > > > >> deciding to go with the patch as is.)
> > > > >>
> > > > >>>> [...]
> > > > >>>> Another way to put it is that, if FS-based and scope-based controls
> > > > >>>> interacts in the above proposed way, both mechanisms feel like "poking
> > > > >>>> holes" in the other.  But as Mickaël said, one can think of the two
> > > > >>>> mechanisms not as independent controls, but rather as two interfaces for
> > > > >>>> the same control.  The socket access control is "enabled" if either the
> > > > >>>> LANDLOCK_ACCESS_FS_RESOLVE_UNIX access is handled, or the scope bit
> > > > >>>> proposed in this patch is enabled.
> > > > >>>>
> > > > >>>> With that said, I can think of some alternative ways that might make this
> > > > >>>> API look "better" (from a subjective point of view, feedback welcome),
> > > > >>>> however it does mean more delays, and specifically, these will depend on
> > > > >>>> LANDLOCK_ACCESS_FS_RESOLVE_UNIX:
> > > > >>>>
> > > > >>>> One possibility is to simply always allow a Landlock domain to connect to
> > > > >>>> its own sockets (in the case where LANDLOCK_ACCESS_FS_RESOLVE_UNIX is
> > > > >>>> handled, otherwise all sockets are allowed).  This might be reasonable, as
> > > > >>>> one can only connect to a socket it creates if it has the permission to
> > > > >>>> create it in the first place, which is already controlled by
> > > > >>>> LANDLOCK_ACCESS_FS_MAKE_SOCK, so we don't really lose any policy
> > > > >>>> flexibility here - if for some reason the sandboxer don't want to allow
> > > > >>>> access to any (pathname) sockets, even the sandboxed app's own ones, it
> > > > >>>> can just not allow LANDLOCK_ACCESS_FS_MAKE_SOCK anywhere.
> > > > >>>
> > > > >>> LANDLOCK_ACCESS_FS_MAKE_SOCK is only required to bind/listen to a
> > > > >>> socket, not to connect.  I guess you was thinking about
> > > > >>> LANDLOCK_ACCESS_FS_RESOLVE_UNIX in this case?
> > > > >>
> > > > >> In this "allow same-scope connect unconditionally" proposal, the
> > > > >> application would still be able to (bind to and) connect to its own
> > > > >> sockets, even if LANDLOCK_ACCESS_FS_RESOLVE_UNIX is handled and nothing is
> > > > >> allowed to have LANDLOCK_ACCESS_FS_RESOLVE_UNIX access.  But a sandboxer
> > > > >> which for whatever reason doesn't want this "allow same scope" default can
> > > > >> still prevent the use of (pathname) sockets by restricting
> > > > >> LANDLOCK_ACCESS_FS_MAKE_SOCK, because if an app can't connect to any
> > > > >> sockets it doesn't own, and can't create any sockets itself either, then
> > > > >> it effectively can't connect to any sockets at all.
> > > > >>
> > > > >> (Although on second thought, I guess there could be a case where an app
> > > > >> first creates some socket files before doing landlock_restrict_self(),
> > > > >> then it might still be able to bind to these even without
> > > > >> LANDLOCK_ACCESS_FS_MAKE_SOCK?)
> > > > >
> > > > > FWIW, I also really liked Tingmao's first of the two listed
> > > > > possibilities in [1], where she proposed to introduce both rights
> > > > > together.  In my understanding, the arguments we have discussed so far
> > > > > for that are:
> > > > >
> > > > > IN FAVOR:
> > > > >
> > > > > (pro1) Connecting to a UNIX socket in the same scope is always safe,
> > > > >        and it makes it possible to use named UNIX sockets between the
> > > > >        processes within a Landlock domains.  (Mickaël convinced me in
> > > > >        discussion at FOSDEM that this is true.)
> > > > >
> > > > >        If someone absolutely does not want that, they can restrict
> > > > >        LANDLOCK_ACCESS_FS_MAKE_SOCK and achieve the same effect (as
> > > > >        Tingmao said above).
> > > > >
> > > > > (pro2) The implementation of this is simpler.
> > > > >
> > > > >        (I attempted to understand how the "or" semantics would be
> > > > >        implemented, and I found it non-trivial when you try to do it
> > > > >        for all layers at once. (Kernighan's Law applies, IMHO))
> > > > 
> > > > I think the logic would basically be:
> > > > 
> > > > 1. if any layers deny the access due to handled RESOLVE_UNIX but does not
> > > > have the scope bit set, then we will deny rightaway, without calling
> > > > domain_is_scoped().
> > > > 
> > > > 2. Call domain_is_scoped() with a bitmask of "rules_covered" layers where
> > > > there are RESOLVE_UNIX rules covering the socket being accessed, and
> > > > essentially ignore those layers in the scope violation check.
> > > > 
> > > > I definitely agree that it is tricky, but making same-scope access be
> > > > allowed (i.e. the suggested idea above) would only get rid of step 1,
> > > > which I think is the "simpler" bit.  The extra logic in step 2 is still
> > > > needed. 
> > > > 
> > > > I definitely agree with pro1 tho.
> > > 
> > > Yes, you are describing the logic for the variant where
> > > LANDLOCK_ACCESS_FS_RESOLVE_UNIX does not implicitly permit access from
> > > within the same scope.  In that variant, there can be situations where
> > > the first hook can deny the action immediately.
> > > 
> > > In the variant where LANDLOCK_ACCESS_FS_RESOLVE_UNIX *does* implicitly
> > > allow access from within the same scope, that shortcutting is not
> > > possible.  On the upside however, there is no need to distinguish
> > > whether the scope flag is set when we are in the security_unix_find()
> > > hook, because access from within the same scope is always permitted.
> > > (That is the simplification I meant.)
> > 
> > This proposal make sense, improve IPC restriction consistency (by always
> > be able to connect to peers from the same domain), and would simplify
> > some checks.
> 
> > What bothers me the most is the implicit scoping induced
> > by the FS_RESOLVE_UNIX handling.
> 
> I see this as similar to other decisions we have taken, e.g. on the
> (in-review) socket type patch, we have also discussed at the time that
> socketpair() should always be allowed, even though it creates sockets,
> because this syscall only establishes IPC communication channels
> within the same Landlock domain.
> 
> Admittedly, in this case it is a bit more clearly about the Landlock
> domain boundaries, but still OK in my mind.  I think we are aligned
> though, see my answer to your proposal below.
> 
> 
> > A related issue is the mix of checks
> > for the FS_RESOLVE_UNIX implementation, which could make the code more
> > complex, but I don't see a better way.  Landlock already has an implicit
> > ptrace scoping but it's not (and should never be) optional.
> 
> I am afraid that we don't have a better option.  Even if we only
> introduced one of the two patch sets in its original form now, we
> would have to introduce that implementation as soon as the other is
> added.
> 
> 
> > See my proposal below about implicit
> > LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET.  That would not change the kernel
> > checks you described though.
> 
> 
> > > > > AGAINST:
> > > > >
> > > > > (con1) It would work differently than the other scoped access rights
> > > > >        that we already have.
> > > > >
> > > > >        A speculative feature that could potentially be built with the
> > > > >        scoped access rights is that we could add a rule to permit IPC
> > > > >        to other Landlock scopes, e.g. introducing a new rule type
> > > > >
> > > > >          struct landlock_scope_attr {
> > > > >            __u64 allowed_access;  /* for "scoped" bits */
> > > > >            /* some way to identify domains */
> > > > >          }
> > > > >
> > > > >        so that we could make IPC access to other Landlock domains
> > > > >        configurable.
> > > > >
> > > > >        If the scoped bit and the FS RESOLVE_UNIX bit were both
> > > > >        conflated in RESOLVE_UNIX, it would not be possible to make
> > > > >        UNIX connections configurable in such a way.
> > > > 
> > > > This exact API would no longer work, but if we give up the equivalence
> > > > between scope bits and the landlock_scope_attr struct, then we can do
> > > > something like:
> > > > 
> > > > struct landlock_scope_attr {
> > > >     __u64 ptrace:1;  /* Note that this is not a (user controllable) scope bit! */
> > > >     __u64 abstract_unix_socket:1;
> > > >     __u64 pathname_unix_socket:1;
> > > >     /* ... */
> > > > 
> > > >     __u64 allowed_signals;
> > > > 
> > > >     /*
> > > >      * some way to identify domains, maybe we could use the audit domain
> > > >      * ID, with 0 denoting "allow access to non-Landlocked processes?
> > > >      */
> > > > }
> > > 
> > > Yes, it would be possible to use such a struct for that scenario where
> > > IPC access gets allowed for other Landlock scopes.  It would mean that
> > > we would not need to introduce a scoped flag for the pathname UNIX
> > > socket connections.  But the relationship between that struct
> > > landlock_scope_attr and the flags and access rights in struct
> > > landlock_ruleset_attr would become less clear, which is a slight
> > > downside, and maybe error prone for users to work with.
> > > 
> > > If we introduced an additional scoped flag, it would also be
> > > consistent though.
> > > 
> > > (con1) was written under the assumption that we do not have an
> > > additional scoped flag.  If that is lacking, it is not possible to
> > > express UNIX connect() access to other Landlock domains with that
> > > struct.  But as outlined in the proposal below, if we *do* (later)
> > > introduce the additional scoped flag *in addition* to the FS access
> > > right, this *both* stays consistent in semantics with the signal and
> > > abstract UNIX support, *and* it starts working in a world where ICP
> > > access can be allowed to talk to other Landlock domains.
> > 
> > In this case, we need to assume the scoped flag is already there, and
> > because we have the implementation, to actually add it now.
> > 
> > As a side note, I don't really like this landlock_scope_attr interface.
> > A dedicated attr per kind of IPC would be much more flexible (e.g. the
> > handled_signal_number you described below).  For instance, even if at
> > first we don't make it possible to describe different signals within the
> > attr struct, this struct will be able to grow.  So it's better to have a
> > dedicated interface per IPC type than a generic scope interface that can
> > only express a subset of it.
> > 
> > Anyway, this proposal could work for pathname UNIX sockets, but a future
> > signal attr would be a bit inconsistent wrt to the pathname UNIX one.
> 
> See my answer to your proposal below.
> 
> 
> > > > > (con2) Consistent behaviour between scoped flags and their
> > > > >        interactions with other access rights:
> > > > >
> > > > >        The existing scoped access rights (signal, abstract sockets)
> > > > >        could hypothetically be extended with a related access right of
> > > > >        another type. For instance, there could be an access right type
> > > > >
> > > > >          __u64 handled_signal_number;
> > > > >
> > > > >        and then you could add a rule to permit the use of certain
> > > > >        signal numbers.  The interaction between the scoped flags and
> > > > >        other access rights should work the same.
> > > > >
> > > > >
> > > > > Constructive Proposal for consideration: Why not both?
> > > > > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > 
> > > > I will think about the following a bit more but I'm afraid that I feel
> > > > like it might get slightly confusing.  With this, the only reason for
> > > > having LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET is for API consistency when we
> > > > later enable allowing access to other domains (if I understood correctly),
> > > > in which case I personally feel like the suggestion on landlock_scope_attr
> > > > above, where we essentially accept that it is decoupled with the scope
> > > > bits in the ruleset, might be simpler...?
> > > 
> > > Mickaël expressed the opinion to me that he would like to APIs to stay
> > > consistent between signals, abstract UNIX sockets, named UNIX sockets
> > > and other future "scoped" operations, in scenarios where:
> > > 
> > > * the "scoped" (IPC) operations can be configured to give access to
> > >   other Landlock domains (and that should work for UNIX connections too)
> > > * the existing "scoped" operations also start having matching access rights
> > > 
> > > I think with the way I proposed, that would be consistent.
> > 
> > What about always implicitly set LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET (in
> > the kernel) when LANDLOCK_ACCESS_FS_RESOLVE_UNIX is set?
> > 
> > *Requiring* users to set LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET would add a
> > new way to trigger an error, but setting
> > LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET *implicitly* looks safer.  This
> > might also help for the documentation BTW.
> > 
> > If we agree on this, I could merge the scope_pathname_unix in 7.0, and
> > merge the resolve_unix in 7.1 (or later if something unexpected happen).
> > Otherwise, I'll merge both at the same time with the same ABI version
> > (with the risk to postpone again).  WDYT?
> 
> In my understanding, the only thing in which our two proposals differ
> is the order in which we introduce the
> LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET and
> LANDLOCK_ACCESS_FS_RESOLVE_UNIX bits to the UAPI.
> 
> As soon as both bits are added, our two proposals do the same thing.
> 
> My proposal (introduce LANDLOCK_ACCESS_FS_RESOLVE_UNIX first)
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The reason why I have been arguing to introduce
> LANDLOCK_ACCESS_FS_RESOLVE_UNIX first is:
> 
> (a) It is possible (which initially wasn't obvious to me):
> 
>     When implementing this, handling LANDLOCK_ACCESS_FS_RESOLVE_UNIX
>     implies the LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET semantics(!), even
>     when that bit is not exposed in the UAPI yet.  (When
>     LANDLOCK_ACCESS_FS_RESOLVE_UNIX is handled, UNIX-connect always
>     works within the same Landlock domain, even for the time when the
>     scoped flag is not exposed in the UAPI yet.)
> 
>     That way, everything stays compatible even when the scoped flag is
>     later introduced.
> 
> (b) When introducing LANDLOCK_ACCESS_FS_RESOLVE_UNIX first, the UAPI
>     will initially only expose one of the two bits.
> 
>     This simplifies the UAPI because users initially do not need to
>     deal with the fact that two bits in the UAPI "interact".

It simplifies but users can just ignore the bits for which they don't
care.  They just have to set the one they want (either scope or resolve)
and Landlock will do the right thing. :)

The only corner case is that setting scope_pathname_unix or not when
resolve_unix is set will result to the same restrictions.  In other
words, resolve_unix is a superset of scope_pathname_unix, so this scope
UAPI bit will be useless when resolve_unix will be introduced.

> 
>     We can still introduce LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET later.
>     But the only ruleset-building feature for which this needed would
>     be if we want to have rules that allow outwards IPC interactions
>     with other Landlock domains.
> 
>     Possibility of YAGNI: I am not sure how certain you are that the
>     speculative allowing-scope-access feature is needed; I mentioned
>     it here only because it is an option we want to keep open.  If we
>     end up *not* needing this feature though, we will *not need to
>     introduce the LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET bit at all*,
>     because LANDLOCK_ACCESS_FS_RESOLVE_UNIX can already do all that is
>     needed.

Indeed, I get your point.  Please add this rationale in the "Design
choices" section in Documentation/security/landlock.rst

> 
> The implementation of this approach would be that we would have to
> join the functionality from the scoped and FS-based patch set, but
> without introducing the LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET flag in
> the UAPI.

Right, this looks good to me.  We'll need to sync both patch series and
remove the scope flag from UAPI.  I'll let you and Tingmao work together
for the next series.  The "IPC scoping" documentation section should
mention LANDLOCK_ACCESS_FS_RESOLVE_UNIX even if it's not a scope flag.

> 
> Your proposal (introduce LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET first)
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> * Upside: users won't be surprised if UNIX-connect within
>   the same Landlock domain works, because the bit is there for it
> 

> * Downside: They'll have to understand that the FS bit implies the
>   scope flag.

Yes, but this would be the same with your approach.  Not sure which one
would be the less confusing though.

> 
> 
> 
> But as I said in the beginning -- if we add both flags, these two
> proposals end up being the same in the end.
> 
> Maybe the main point that is unclear to me is what I called the
> "Possibility of YAGNI" above: it is at this point not 100% clear to me
> that the feature for allowing IPC to other domains is going to happen
> (we don't have a bug tracker issue for it either, AFAICT).  So in the
> case where this does not actually end up happening, I think that my
> approach has the advantage of introducing one flag less, so the UAPI
> stays simpler.

As I said earlier, I'd definitely prefer to have an IPC-specific attr
instead of a generic scope attr.  So yes, this looks good to me.

> 
> If you know that that feature will happen though, I think the two
> approaches are equally good in the long run.
> 
> But either way, Mickaël, you are the maintainer here :); if you prefer
> to do the LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET patch set in its current
> form first, it's also OK with me.  As I said, I think these two
> approaches are the same.

You convinced me.  Let's go for the hybrid approach you proposed with
the implicit scope.

> 
> 
> P.S. Tingmao: One additional complication, in case the
> LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET patch set gets sent first -- your
> current patch set uses a different LSM hook than the final state which
> we are aiming for.  We may need to double check that this will stay
> compatible even if we move the scoped-check into the new LSM hook in
> the future.  (If we move the check into a different hook, there may be
> some obscure scenarios in which a denied connect()/send() results in a
> different error code.)  I may comment on the patch set.

That's also a good point.  I'd be curious to know if this changes
anything, but it should not except maybe some error codes.

Anyway, we'll need this new LSM hook.

> 
> > > > > Why not do both what Tingmao proposed in [1] **and** reserve the
> > > > > option to add the matching "scoped flag" later?
> > > > >
> > > > >   * Introduce LANDLOCK_ACCESS_FS_RESOLVE_UNIX.
> > > > >
> > > > >     If it is handled, UNIX connections are allowed either:
> > > > >
> > > > >     (1) if the connection is to a service in the same scope, or
> > > > >     (2) if the path was allow-listed with a "path beneath" rule.
> > > > >
> > > > >   * Add LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET later, if needed.
> > > > >
> > > > >
> > > > > Let's go through the arguments again:
> > > > >
> > > > > We have observed that it is harmless to allow connections to services
> > > > > in the same scope (1), and that if users absolutely don't want that,
> > > > > they can actually prohibit it through LANDLOCK_ACCESS_FS_MAKE_SOCK
> > > > > (pro1).
> > > > >
> > > > > (con1): Can we still implement the feature idea where we poke a hole
> > > > >         to get UNIX-connect() access to other Landlock domains?
> > > > >
> > > > >   I think the answer is yes.  The implementation strategy is:
> > > > >
> > > > >     * Add the scoped bit LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
> > > > >     * The scoped bit can now be used to allow-list connections to
> > > > >       other Landlock domains.
> > > > >
> > > > >   For users, just setting the scoped bit on its own does the same as
> > > > >   handling LANDLOCK_ACCESS_FS_RESOLVE_UNIX.  That way, the kernel-side
> > > > >   implementation can also stay simple.  The only reason why the scoped
> > > > >   bit is needed is because it makes it possible to allow-list
> > > > >   connections to other Landlock domains, but at the same time, it is
> > > > >   safe if libraries set the scoped bit once it exists, as it does not
> > > > >   have any bad runtime impact either.
> > > > >
> > > > > (con2): Consistency: Do all the scoped flags interact with their
> > > > >         corresponding access rights in the same way?
> > > > >
> > > > >   The other scope flags do not have corresponding access rights, so
> > > > >   far.
> > > > >
> > > > >   If we were to add corresponding access rights for the other scope
> > > > >   flags, I would argue that we could apply a consistent logic there,
> > > > >   because IPC access within the same scope is always safe:
> > > > >
> > > > >   - A hypothetical access right type for "signal numbers" would only
> > > > >     restrict signals that go beyond the current scope.
> > > > >
> > > > >   - A hypothetical access right type for "abstract UNIX domain socket
> > > > >     names" would only restrict connections to abstract UNIX domain
> > > > >     servers that go beyond the current scope.
> > > > >
> > > > >   I can not come up with a scenario where this doesn't work.
> > > > >
> > > > >
> > > > > In conclusion, I think the approach has significant upsides:
> > > > >
> > > > >   * Simpler UAPI: Users only have one access bit to deal with, in the
> > > > >     near future.  Once we do add a scope flag for UNIX connections, it
> > > > >     does not interact in a surprising way with the corresponding FS
> > > > >     access right, because with either of these, scoped access is
> > > > >     allowed.
> > > > >
> > > > >     If users absolutely need to restrict scoped access, they can
> > > > >     restrict LANDLOCK_ACCESS_FS_MAKE_SOCK.  It is a slightly obscure
> > > > >     API, but in line with the "make easy things easy, make hard things
> > > > >     possible" API philosophy.  And needing this should be the
> > > > >     exception rather than the norm, after all.
> > > > >
> > > > >   * Consistent behaviour between scoped flags and regular access
> > > > >     rights, also for speculative access rights affecting the existing
> > > > >     scoped flags for signals and abstract UNIX domain sockets.
> > > > >
> > > > > [1] https://lore.kernel.org/all/f07fe41a-96c5-4d3a-9966-35b30b3a71f1@maowtm.org/
> > 
> > Thanks for this summary Günther!
> 
