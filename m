Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E6D35FF6B
	for <linux-security-module@vger.kernel.org>; Thu,  5 Feb 2026 08:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770278547; cv=none; b=B9MqlVRnj28CjhY3BN9ozNy17hk9y2X/nOHZclzsgfkC1C1caI/qDuTYQ09zefatnCPzRsNr5EQ/QVe3VjM1jFFMKafHPLMUgfSgkDcxbC4nmSqlgbcyF+kPksclaW7/rG3WawaWv2VESl6J7HwIwmMPkTMCNWJW/gvQlbtTsec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770278547; c=relaxed/simple;
	bh=zVJzlSQNkjV4yO2kLzmf7g+aPyW6TidqsNc6uyRBCrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COpruqK5yfSvY8d8G52Oon6hBp7NV/Wdz6cV3DZuNa1vH3ldLUcIx6cYuEeBoqX4NWv9anbRZ6BgBbhWb2TjYfT5qlLi2GyTcFRj+Ei+G8jnnSjgQ4fEt6epNxTMcHn/so6e2HadDFvn+KVyEy8PM5JK6FEsRQc3xRE/Wm8iUbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Id29PyNT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Id29PyNT"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so3911205e9.3
        for <linux-security-module@vger.kernel.org>; Thu, 05 Feb 2026 00:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770278545; x=1770883345; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1UALzwcAgCgAmBOsI8mvwnoR/uMatsdgnqthmgib5/M=;
        b=Id29PyNT4RgqaLS3AEwoBjBKfcPNdxpjSgwejnK2rfAsFAxTb2a5LEvFVVt7yVgYuj
         dEWpFdo9kc6HvQbR3z4ID0gWn8LzLUD2ZM7MnWV2qD7zI2vI6pm/FjK5dKO2kuoiRZ9J
         Cw0IqVLPfEtpM7dWtrmiBxGGNbYQGstwcOVYJzbTA+GhvLQjqxsVhqsAttNVlzzoQ1Uc
         mCwP7MvWMwTAZZDlfKz812C86C52IsPDYXAMix3ecpDPcz4K66g7RkpVmDmYO+BoOVha
         KRsXtT/TtLvB+5D+BzXTMmXG8IWEqabUwvKTjvNA5kkYHfGn+7ya+Bx9uTMlV9V+LkLJ
         G+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770278545; x=1770883345;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1UALzwcAgCgAmBOsI8mvwnoR/uMatsdgnqthmgib5/M=;
        b=LCUhuaGIjFopIsQ9wyLZPLM1qik37UfOCDYJYtSeGqrS263WdjwQa1mxOAb5omWPNN
         yxwwTVZL7XA2wUq41OhHoZrljuXGQ5cZQ3b6yDFEm2SaGvH67k+/dTqrZBlU4Gtw+Df8
         rErHBCwNsjLAUt01pbi9rQeWx8RgWQ7zhLLz6TFF+lUrCR/IaIk3gclUQtwXnRZJVXzE
         e+axhwCzEOUMQrH64VUsJFR5mlSpz0rNMnF9/l+A5QZc4Ca9qvVucUsLhaLNG7LonB6M
         keE+Dkzxp6NmKY8jS/i1ALpDD9YGyzgtWN3EaTV1Hr/BAVhp2xGUaBvovMfF7B7QFKcg
         9xzg==
X-Forwarded-Encrypted: i=1; AJvYcCUlwKetPIGkxU381W9IqqaGKqSzUnw3B9JE+pIg5zN5emLgIjiAvhfdJINEfZ73bOgODch0VohL6phsPx6NAAvnD0h3OLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfRUsj7D/ZTdWEy4HXlXTPaTw9o1XE4P+1l9PgPf61FtK8rjb4
	EV//GeL7GIxFhR+oEXKakFU+vYHRYYHpBU7FW12Ln/0uEWJWJRfHF802
X-Gm-Gg: AZuq6aIs7BGQLcBht8/nmUSwYcnFD7gMiVkM9Ao9n4iWUZWRqPPkHnJfXUaWYY2JCD6
	9LPwMd4tcaMFPbe9znfoya2NcduMdonA4QyAfh5eTmJBmAdxAPY28AIhQSrAvQtXCkK7VjYk8W7
	JJH0blPDigWvMLgSD/UYLIFTiAwMChgCisP1n+QhDyj0Ttm7dJ/erQHevt/OIdRRnkGl2wSxN4r
	qyOKA8wPwg0q/I5jBOYC4bcMgoHQAfrzxnezTO+48yPuxG2se+qhqzzi1CLKA/OEDlntw8YAay6
	YR49bUvNBhR0uggRvcSiYsR7cH5wY6fBWlreee1veknmE7eG9MJrEZpIM7Q43fJawrqLAy+A97G
	hVoOIQVsA2LqykIFgz7pToiAjXkLjB16qaguXpl1H9oScrenfA9DZVFqSgE77sZF/lupWK6n9p/
	HNPWO4A+pmijDokWZnzJyEoqkq1pstjzZ72f3Y
X-Received: by 2002:a05:600c:4fcc:b0:480:1d0b:2d15 with SMTP id 5b1f17b1804b1-4830e9926c0mr83557875e9.27.1770278544628;
        Thu, 05 Feb 2026 00:02:24 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830ec1809esm79138515e9.0.2026.02.05.00.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 00:02:24 -0800 (PST)
Date: Thu, 5 Feb 2026 09:02:19 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-security-module@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: Re: [PATCH v2 0/6] Landlock: Implement scope control for pathname
 Unix sockets
Message-ID: <20260205.8531e4005118@gnoack.org>
References: <dc9b99b6-14a1-45b6-a23f-0b24143dac58@gmail.com>
 <20260109.Ino1ahfef1iu@digikod.net>
 <f07fe41a-96c5-4d3a-9966-35b30b3a71f1@maowtm.org>
 <20260202.uu0oCheexahY@digikod.net>
 <8093547c-ab40-4814-ac9a-8dff6f2a2a90@gmail.com>
 <16129d76-b6d3-4959-b241-dc79a32dd0cd@maowtm.org>
 <aYI2OQhPMgdMAOiz@google.com>
 <e6b6b069-384c-4c45-a56b-fa54b26bc72a@maowtm.org>
 <aYMxHRwHCao30HfX@google.com>
 <20260204.quaiyeiW9ipo@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260204.quaiyeiW9ipo@digikod.net>

On Wed, Feb 04, 2026 at 06:43:24PM +0100, Mickaël Salaün wrote:
> On Wed, Feb 04, 2026 at 12:44:29PM +0100, Günther Noack wrote:
> > On Tue, Feb 03, 2026 at 09:53:11PM +0000, Tingmao Wang wrote:
> > > On 2/3/26 17:54, Günther Noack wrote:
> > > >> Furthermore, an application / Landlock config etc can always opt to not
> > > >> use the scope bit at all, if it "knows" all the locations where the
> > > >> application's sockets would be placed, and just use RESOLVE_UNIX access
> > > >> right (or nothing if it is not supported).
> > > >>
> > > >> (The following is a bit of a side note, not terribly relevant if we're
> > > >> deciding to go with the patch as is.)
> > > >>
> > > >>>> [...]
> > > >>>> Another way to put it is that, if FS-based and scope-based controls
> > > >>>> interacts in the above proposed way, both mechanisms feel like "poking
> > > >>>> holes" in the other.  But as Mickaël said, one can think of the two
> > > >>>> mechanisms not as independent controls, but rather as two interfaces for
> > > >>>> the same control.  The socket access control is "enabled" if either the
> > > >>>> LANDLOCK_ACCESS_FS_RESOLVE_UNIX access is handled, or the scope bit
> > > >>>> proposed in this patch is enabled.
> > > >>>>
> > > >>>> With that said, I can think of some alternative ways that might make this
> > > >>>> API look "better" (from a subjective point of view, feedback welcome),
> > > >>>> however it does mean more delays, and specifically, these will depend on
> > > >>>> LANDLOCK_ACCESS_FS_RESOLVE_UNIX:
> > > >>>>
> > > >>>> One possibility is to simply always allow a Landlock domain to connect to
> > > >>>> its own sockets (in the case where LANDLOCK_ACCESS_FS_RESOLVE_UNIX is
> > > >>>> handled, otherwise all sockets are allowed).  This might be reasonable, as
> > > >>>> one can only connect to a socket it creates if it has the permission to
> > > >>>> create it in the first place, which is already controlled by
> > > >>>> LANDLOCK_ACCESS_FS_MAKE_SOCK, so we don't really lose any policy
> > > >>>> flexibility here - if for some reason the sandboxer don't want to allow
> > > >>>> access to any (pathname) sockets, even the sandboxed app's own ones, it
> > > >>>> can just not allow LANDLOCK_ACCESS_FS_MAKE_SOCK anywhere.
> > > >>>
> > > >>> LANDLOCK_ACCESS_FS_MAKE_SOCK is only required to bind/listen to a
> > > >>> socket, not to connect.  I guess you was thinking about
> > > >>> LANDLOCK_ACCESS_FS_RESOLVE_UNIX in this case?
> > > >>
> > > >> In this "allow same-scope connect unconditionally" proposal, the
> > > >> application would still be able to (bind to and) connect to its own
> > > >> sockets, even if LANDLOCK_ACCESS_FS_RESOLVE_UNIX is handled and nothing is
> > > >> allowed to have LANDLOCK_ACCESS_FS_RESOLVE_UNIX access.  But a sandboxer
> > > >> which for whatever reason doesn't want this "allow same scope" default can
> > > >> still prevent the use of (pathname) sockets by restricting
> > > >> LANDLOCK_ACCESS_FS_MAKE_SOCK, because if an app can't connect to any
> > > >> sockets it doesn't own, and can't create any sockets itself either, then
> > > >> it effectively can't connect to any sockets at all.
> > > >>
> > > >> (Although on second thought, I guess there could be a case where an app
> > > >> first creates some socket files before doing landlock_restrict_self(),
> > > >> then it might still be able to bind to these even without
> > > >> LANDLOCK_ACCESS_FS_MAKE_SOCK?)
> > > >
> > > > FWIW, I also really liked Tingmao's first of the two listed
> > > > possibilities in [1], where she proposed to introduce both rights
> > > > together.  In my understanding, the arguments we have discussed so far
> > > > for that are:
> > > >
> > > > IN FAVOR:
> > > >
> > > > (pro1) Connecting to a UNIX socket in the same scope is always safe,
> > > >        and it makes it possible to use named UNIX sockets between the
> > > >        processes within a Landlock domains.  (Mickaël convinced me in
> > > >        discussion at FOSDEM that this is true.)
> > > >
> > > >        If someone absolutely does not want that, they can restrict
> > > >        LANDLOCK_ACCESS_FS_MAKE_SOCK and achieve the same effect (as
> > > >        Tingmao said above).
> > > >
> > > > (pro2) The implementation of this is simpler.
> > > >
> > > >        (I attempted to understand how the "or" semantics would be
> > > >        implemented, and I found it non-trivial when you try to do it
> > > >        for all layers at once. (Kernighan's Law applies, IMHO))
> > > 
> > > I think the logic would basically be:
> > > 
> > > 1. if any layers deny the access due to handled RESOLVE_UNIX but does not
> > > have the scope bit set, then we will deny rightaway, without calling
> > > domain_is_scoped().
> > > 
> > > 2. Call domain_is_scoped() with a bitmask of "rules_covered" layers where
> > > there are RESOLVE_UNIX rules covering the socket being accessed, and
> > > essentially ignore those layers in the scope violation check.
> > > 
> > > I definitely agree that it is tricky, but making same-scope access be
> > > allowed (i.e. the suggested idea above) would only get rid of step 1,
> > > which I think is the "simpler" bit.  The extra logic in step 2 is still
> > > needed. 
> > > 
> > > I definitely agree with pro1 tho.
> > 
> > Yes, you are describing the logic for the variant where
> > LANDLOCK_ACCESS_FS_RESOLVE_UNIX does not implicitly permit access from
> > within the same scope.  In that variant, there can be situations where
> > the first hook can deny the action immediately.
> > 
> > In the variant where LANDLOCK_ACCESS_FS_RESOLVE_UNIX *does* implicitly
> > allow access from within the same scope, that shortcutting is not
> > possible.  On the upside however, there is no need to distinguish
> > whether the scope flag is set when we are in the security_unix_find()
> > hook, because access from within the same scope is always permitted.
> > (That is the simplification I meant.)
> 
> This proposal make sense, improve IPC restriction consistency (by always
> be able to connect to peers from the same domain), and would simplify
> some checks.

> What bothers me the most is the implicit scoping induced
> by the FS_RESOLVE_UNIX handling.

I see this as similar to other decisions we have taken, e.g. on the
(in-review) socket type patch, we have also discussed at the time that
socketpair() should always be allowed, even though it creates sockets,
because this syscall only establishes IPC communication channels
within the same Landlock domain.

Admittedly, in this case it is a bit more clearly about the Landlock
domain boundaries, but still OK in my mind.  I think we are aligned
though, see my answer to your proposal below.


> A related issue is the mix of checks
> for the FS_RESOLVE_UNIX implementation, which could make the code more
> complex, but I don't see a better way.  Landlock already has an implicit
> ptrace scoping but it's not (and should never be) optional.

I am afraid that we don't have a better option.  Even if we only
introduced one of the two patch sets in its original form now, we
would have to introduce that implementation as soon as the other is
added.


> See my proposal below about implicit
> LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET.  That would not change the kernel
> checks you described though.


> > > > AGAINST:
> > > >
> > > > (con1) It would work differently than the other scoped access rights
> > > >        that we already have.
> > > >
> > > >        A speculative feature that could potentially be built with the
> > > >        scoped access rights is that we could add a rule to permit IPC
> > > >        to other Landlock scopes, e.g. introducing a new rule type
> > > >
> > > >          struct landlock_scope_attr {
> > > >            __u64 allowed_access;  /* for "scoped" bits */
> > > >            /* some way to identify domains */
> > > >          }
> > > >
> > > >        so that we could make IPC access to other Landlock domains
> > > >        configurable.
> > > >
> > > >        If the scoped bit and the FS RESOLVE_UNIX bit were both
> > > >        conflated in RESOLVE_UNIX, it would not be possible to make
> > > >        UNIX connections configurable in such a way.
> > > 
> > > This exact API would no longer work, but if we give up the equivalence
> > > between scope bits and the landlock_scope_attr struct, then we can do
> > > something like:
> > > 
> > > struct landlock_scope_attr {
> > >     __u64 ptrace:1;  /* Note that this is not a (user controllable) scope bit! */
> > >     __u64 abstract_unix_socket:1;
> > >     __u64 pathname_unix_socket:1;
> > >     /* ... */
> > > 
> > >     __u64 allowed_signals;
> > > 
> > >     /*
> > >      * some way to identify domains, maybe we could use the audit domain
> > >      * ID, with 0 denoting "allow access to non-Landlocked processes?
> > >      */
> > > }
> > 
> > Yes, it would be possible to use such a struct for that scenario where
> > IPC access gets allowed for other Landlock scopes.  It would mean that
> > we would not need to introduce a scoped flag for the pathname UNIX
> > socket connections.  But the relationship between that struct
> > landlock_scope_attr and the flags and access rights in struct
> > landlock_ruleset_attr would become less clear, which is a slight
> > downside, and maybe error prone for users to work with.
> > 
> > If we introduced an additional scoped flag, it would also be
> > consistent though.
> > 
> > (con1) was written under the assumption that we do not have an
> > additional scoped flag.  If that is lacking, it is not possible to
> > express UNIX connect() access to other Landlock domains with that
> > struct.  But as outlined in the proposal below, if we *do* (later)
> > introduce the additional scoped flag *in addition* to the FS access
> > right, this *both* stays consistent in semantics with the signal and
> > abstract UNIX support, *and* it starts working in a world where ICP
> > access can be allowed to talk to other Landlock domains.
> 
> In this case, we need to assume the scoped flag is already there, and
> because we have the implementation, to actually add it now.
> 
> As a side note, I don't really like this landlock_scope_attr interface.
> A dedicated attr per kind of IPC would be much more flexible (e.g. the
> handled_signal_number you described below).  For instance, even if at
> first we don't make it possible to describe different signals within the
> attr struct, this struct will be able to grow.  So it's better to have a
> dedicated interface per IPC type than a generic scope interface that can
> only express a subset of it.
> 
> Anyway, this proposal could work for pathname UNIX sockets, but a future
> signal attr would be a bit inconsistent wrt to the pathname UNIX one.

See my answer to your proposal below.


> > > > (con2) Consistent behaviour between scoped flags and their
> > > >        interactions with other access rights:
> > > >
> > > >        The existing scoped access rights (signal, abstract sockets)
> > > >        could hypothetically be extended with a related access right of
> > > >        another type. For instance, there could be an access right type
> > > >
> > > >          __u64 handled_signal_number;
> > > >
> > > >        and then you could add a rule to permit the use of certain
> > > >        signal numbers.  The interaction between the scoped flags and
> > > >        other access rights should work the same.
> > > >
> > > >
> > > > Constructive Proposal for consideration: Why not both?
> > > > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > 
> > > I will think about the following a bit more but I'm afraid that I feel
> > > like it might get slightly confusing.  With this, the only reason for
> > > having LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET is for API consistency when we
> > > later enable allowing access to other domains (if I understood correctly),
> > > in which case I personally feel like the suggestion on landlock_scope_attr
> > > above, where we essentially accept that it is decoupled with the scope
> > > bits in the ruleset, might be simpler...?
> > 
> > Mickaël expressed the opinion to me that he would like to APIs to stay
> > consistent between signals, abstract UNIX sockets, named UNIX sockets
> > and other future "scoped" operations, in scenarios where:
> > 
> > * the "scoped" (IPC) operations can be configured to give access to
> >   other Landlock domains (and that should work for UNIX connections too)
> > * the existing "scoped" operations also start having matching access rights
> > 
> > I think with the way I proposed, that would be consistent.
> 
> What about always implicitly set LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET (in
> the kernel) when LANDLOCK_ACCESS_FS_RESOLVE_UNIX is set?
> 
> *Requiring* users to set LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET would add a
> new way to trigger an error, but setting
> LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET *implicitly* looks safer.  This
> might also help for the documentation BTW.
> 
> If we agree on this, I could merge the scope_pathname_unix in 7.0, and
> merge the resolve_unix in 7.1 (or later if something unexpected happen).
> Otherwise, I'll merge both at the same time with the same ABI version
> (with the risk to postpone again).  WDYT?

In my understanding, the only thing in which our two proposals differ
is the order in which we introduce the
LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET and
LANDLOCK_ACCESS_FS_RESOLVE_UNIX bits to the UAPI.

As soon as both bits are added, our two proposals do the same thing.

My proposal (introduce LANDLOCK_ACCESS_FS_RESOLVE_UNIX first)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The reason why I have been arguing to introduce
LANDLOCK_ACCESS_FS_RESOLVE_UNIX first is:

(a) It is possible (which initially wasn't obvious to me):

    When implementing this, handling LANDLOCK_ACCESS_FS_RESOLVE_UNIX
    implies the LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET semantics(!), even
    when that bit is not exposed in the UAPI yet.  (When
    LANDLOCK_ACCESS_FS_RESOLVE_UNIX is handled, UNIX-connect always
    works within the same Landlock domain, even for the time when the
    scoped flag is not exposed in the UAPI yet.)

    That way, everything stays compatible even when the scoped flag is
    later introduced.

(b) When introducing LANDLOCK_ACCESS_FS_RESOLVE_UNIX first, the UAPI
    will initially only expose one of the two bits.

    This simplifies the UAPI because users initially do not need to
    deal with the fact that two bits in the UAPI "interact".

    We can still introduce LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET later.
    But the only ruleset-building feature for which this needed would
    be if we want to have rules that allow outwards IPC interactions
    with other Landlock domains.

    Possibility of YAGNI: I am not sure how certain you are that the
    speculative allowing-scope-access feature is needed; I mentioned
    it here only because it is an option we want to keep open.  If we
    end up *not* needing this feature though, we will *not need to
    introduce the LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET bit at all*,
    because LANDLOCK_ACCESS_FS_RESOLVE_UNIX can already do all that is
    needed.

The implementation of this approach would be that we would have to
join the functionality from the scoped and FS-based patch set, but
without introducing the LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET flag in
the UAPI.

Your proposal (introduce LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET first)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Upside: users won't be surprised if UNIX-connect within
  the same Landlock domain works, because the bit is there for it

* Downside: They'll have to understand that the FS bit implies the
  scope flag.



But as I said in the beginning -- if we add both flags, these two
proposals end up being the same in the end.

Maybe the main point that is unclear to me is what I called the
"Possibility of YAGNI" above: it is at this point not 100% clear to me
that the feature for allowing IPC to other domains is going to happen
(we don't have a bug tracker issue for it either, AFAICT).  So in the
case where this does not actually end up happening, I think that my
approach has the advantage of introducing one flag less, so the UAPI
stays simpler.

If you know that that feature will happen though, I think the two
approaches are equally good in the long run.

But either way, Mickaël, you are the maintainer here :); if you prefer
to do the LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET patch set in its current
form first, it's also OK with me.  As I said, I think these two
approaches are the same.


P.S. Tingmao: One additional complication, in case the
LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET patch set gets sent first -- your
current patch set uses a different LSM hook than the final state which
we are aiming for.  We may need to double check that this will stay
compatible even if we move the scoped-check into the new LSM hook in
the future.  (If we move the check into a different hook, there may be
some obscure scenarios in which a denied connect()/send() results in a
different error code.)  I may comment on the patch set.

> > > > Why not do both what Tingmao proposed in [1] **and** reserve the
> > > > option to add the matching "scoped flag" later?
> > > >
> > > >   * Introduce LANDLOCK_ACCESS_FS_RESOLVE_UNIX.
> > > >
> > > >     If it is handled, UNIX connections are allowed either:
> > > >
> > > >     (1) if the connection is to a service in the same scope, or
> > > >     (2) if the path was allow-listed with a "path beneath" rule.
> > > >
> > > >   * Add LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET later, if needed.
> > > >
> > > >
> > > > Let's go through the arguments again:
> > > >
> > > > We have observed that it is harmless to allow connections to services
> > > > in the same scope (1), and that if users absolutely don't want that,
> > > > they can actually prohibit it through LANDLOCK_ACCESS_FS_MAKE_SOCK
> > > > (pro1).
> > > >
> > > > (con1): Can we still implement the feature idea where we poke a hole
> > > >         to get UNIX-connect() access to other Landlock domains?
> > > >
> > > >   I think the answer is yes.  The implementation strategy is:
> > > >
> > > >     * Add the scoped bit LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
> > > >     * The scoped bit can now be used to allow-list connections to
> > > >       other Landlock domains.
> > > >
> > > >   For users, just setting the scoped bit on its own does the same as
> > > >   handling LANDLOCK_ACCESS_FS_RESOLVE_UNIX.  That way, the kernel-side
> > > >   implementation can also stay simple.  The only reason why the scoped
> > > >   bit is needed is because it makes it possible to allow-list
> > > >   connections to other Landlock domains, but at the same time, it is
> > > >   safe if libraries set the scoped bit once it exists, as it does not
> > > >   have any bad runtime impact either.
> > > >
> > > > (con2): Consistency: Do all the scoped flags interact with their
> > > >         corresponding access rights in the same way?
> > > >
> > > >   The other scope flags do not have corresponding access rights, so
> > > >   far.
> > > >
> > > >   If we were to add corresponding access rights for the other scope
> > > >   flags, I would argue that we could apply a consistent logic there,
> > > >   because IPC access within the same scope is always safe:
> > > >
> > > >   - A hypothetical access right type for "signal numbers" would only
> > > >     restrict signals that go beyond the current scope.
> > > >
> > > >   - A hypothetical access right type for "abstract UNIX domain socket
> > > >     names" would only restrict connections to abstract UNIX domain
> > > >     servers that go beyond the current scope.
> > > >
> > > >   I can not come up with a scenario where this doesn't work.
> > > >
> > > >
> > > > In conclusion, I think the approach has significant upsides:
> > > >
> > > >   * Simpler UAPI: Users only have one access bit to deal with, in the
> > > >     near future.  Once we do add a scope flag for UNIX connections, it
> > > >     does not interact in a surprising way with the corresponding FS
> > > >     access right, because with either of these, scoped access is
> > > >     allowed.
> > > >
> > > >     If users absolutely need to restrict scoped access, they can
> > > >     restrict LANDLOCK_ACCESS_FS_MAKE_SOCK.  It is a slightly obscure
> > > >     API, but in line with the "make easy things easy, make hard things
> > > >     possible" API philosophy.  And needing this should be the
> > > >     exception rather than the norm, after all.
> > > >
> > > >   * Consistent behaviour between scoped flags and regular access
> > > >     rights, also for speculative access rights affecting the existing
> > > >     scoped flags for signals and abstract UNIX domain sockets.
> > > >
> > > > [1] https://lore.kernel.org/all/f07fe41a-96c5-4d3a-9966-35b30b3a71f1@maowtm.org/
> 
> Thanks for this summary Günther!
