Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5073ECBC4
	for <linux-security-module@vger.kernel.org>; Wed,  4 Feb 2026 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770205477; cv=none; b=tMp+Oy34IKTMfqBfpxlkNgsNaB91C7Ggq3VNtCcOYtUm0l16rMHoujyPlYjQReGSNE+uSK/zIF6pKmLiE0kRSUyBpMa0B7tsL7xgpb+9aBg4Cxx7wkhz+DN0dm0v+eTyy9TzFRUD92VmDWVLfQQsQC7hI0+at5iSGqOGZFmvzYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770205477; c=relaxed/simple;
	bh=pWjax3N/tQR4QpbSrdYIHSuDeNtaITdwrMkTdU5uXfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwF01gNDfxj2xviE+1BC1PW1yrXTKx5b5nAzBgGWj4vcDEq/7ihRoUALPubAtBVsA8Xln14TQiadbbhDrM7diA7f6ualNl7Zdj+gLkDYH7AnWsbj1ZIh3e1f4GzQFrttBUu3r5+MVLxSBNSN42KtnMXNXkwKk6SehTNeskwd660=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yeILIls9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yeILIls9"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso67124155e9.0
        for <linux-security-module@vger.kernel.org>; Wed, 04 Feb 2026 03:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770205476; x=1770810276; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1ncA+ATnpab++fWc+fMqVuMJd4DjtINbNNGKcEyLW4I=;
        b=yeILIls9kfce3SKbJxBQKIhEX/Rc0XzrDqs8kD3Nk1Gti3jIjuGuxIHmgcIlFzgJfG
         T1t7Wu0oc8KRiESd6x/OqnuysFYVnZMPBgnWd3yb/IO9bUtCnWaV6qcri8J4HHkey0/u
         knumgBIftJTBtPLtoLttlkkm9hLxBgn+O5dUEphR7ZpWF+vGFaYe0wgUTyaxVpKxRRjj
         x6GBDTr0UH1uzKtqGToXwZXFkcdHCq7o/6DC+dWOaputIhs63YAOwK6riZ2EPfBnqJC4
         gIeTC8ABawQX9stCZgBXQZ/LAz7th3Z7v7DGoGMXQg8eXIQ5AHj9/fR59QLRXhD3xmkY
         3cEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770205476; x=1770810276;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ncA+ATnpab++fWc+fMqVuMJd4DjtINbNNGKcEyLW4I=;
        b=qyT1Qms5QDVEdvV6Slrgyo+xtcv2yApF0VcGxYhXtcAUbShaD+eWQCPT6MueYh5ARk
         YM5hlNYW7zoNFFKTdvGfKYBExEFwwZB14N8pLeAuw2c6l8grCEE/hjuSxHsfjfnyppNb
         Kx2w6RN5AwcshkirreHwiPBnZggUfTWL8UH6HT795tUIBzt9LkQILOA0Eq+9ndscpmcC
         47Eio4p3DTU0Grj3OZgxztDmPyBDm9jL/8DV2V/dypD/+188VmtkubAbzAu5t+vBFawy
         Llv+aRYkfPhLvdydraBvSw1ZneAbD5QHVGnq4PvlAQPfp9PYGi2MQyRX3Q2E410ra6BR
         4c/g==
X-Forwarded-Encrypted: i=1; AJvYcCV0aHpF+egfpM8gz8riZjjLhhQXYY3LukTAuOqwDgYCJGhooqJk9DYfcxhMfJmLhgjmUmVk532RbbHbOOXinM3bCa+WEaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0PqXN0TSfz04xOYWna2g7pm8JYYbt9VKHvI0vnABRd/AhrZET
	9uJL5ZQLqHFb0gM0PqHw8CyQrWj2sTuh5SansypzaFBm1NvTa7eXwwBloek32jIAdQ==
X-Gm-Gg: AZuq6aJ6/+lMigIhSmWaPNMmOvjKl8DvtNmx+/On5YT3QLwE4iWp817NuSXa6ZttH2+
	rvWWPnxe1wS5o8P7oEkaQjBvzpXwExknyWvsuCC/HYt5LOmt0J6KtaCa3Jd6OcsmVaiw2rBlaXY
	QuuCBPJKX8ImN3qBHL9ZVe+1TA64KUwUuD09xaQPplXElr/eFLkRL1ZAqCety5hhY7eKwXT5BAy
	kKlhwtnxXsNJsGl5AWhqUSzxu5EuHfTdSbSdCpM+NaiSl+a7n89x0TFAUu3qSpkde3X6bZP48rW
	UkXgTr+6oLpyDZbEiUC0gEHjwnt8XKNQZovJxeHTfVH0dCBrtg4yJFnHB3XymXKe/CT81F/Bo32
	c3ey27pm2P7ss84QaxtzcWs1BMP64CrXTn/2lAmX19kQpY5WYoTfiYE/yYowv3AwzEaVC5Fe1RK
	Y6lDJWNSz+04QzyZyUwvbtdVwUU1octqTLRZ3E6QMfFA==
X-Received: by 2002:a05:600c:3e11:b0:482:f564:d613 with SMTP id 5b1f17b1804b1-4830e93ee70mr38546065e9.15.1770205475246;
        Wed, 04 Feb 2026 03:44:35 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:dc18:ae3c:a190:c516])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43618057f87sm6466798f8f.21.2026.02.04.03.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 03:44:34 -0800 (PST)
Date: Wed, 4 Feb 2026 12:44:29 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Tingmao Wang <m@maowtm.org>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Justin Suess <utilityemal77@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Landlock: Implement scope control for pathname
 Unix sockets
Message-ID: <aYMxHRwHCao30HfX@google.com>
References: <cover.1767115163.git.m@maowtm.org>
 <20251230.bcae69888454@gnoack.org>
 <dc9b99b6-14a1-45b6-a23f-0b24143dac58@gmail.com>
 <20260109.Ino1ahfef1iu@digikod.net>
 <f07fe41a-96c5-4d3a-9966-35b30b3a71f1@maowtm.org>
 <20260202.uu0oCheexahY@digikod.net>
 <8093547c-ab40-4814-ac9a-8dff6f2a2a90@gmail.com>
 <16129d76-b6d3-4959-b241-dc79a32dd0cd@maowtm.org>
 <aYI2OQhPMgdMAOiz@google.com>
 <e6b6b069-384c-4c45-a56b-fa54b26bc72a@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6b6b069-384c-4c45-a56b-fa54b26bc72a@maowtm.org>

On Tue, Feb 03, 2026 at 09:53:11PM +0000, Tingmao Wang wrote:
> On 2/3/26 17:54, Günther Noack wrote:
> > BTW, regarding the implementation: To have *OR* semantics for "within
> > scope" and "allow-listed path", the implementation will be
> > non-trivial, and I suspect we won't hit the merge window if we try to
> > get them both in for 7.0.  But in my mind, a simple UAPI is more
> > important than trying to make it in time for the next merge window.
> >
> > (The implementation is difficult because the path-based and
> > scope-based check currently happen in different LSM hooks, and none of
> > the two hooks has enough information to make the decision alone.  The
> > second hook only gets called if the first returns 0.  It'll require
> > some further discussion to make it work together.)
> 
> Right.  In that case, would it make sense to pass sk into the new
> security_unix_find() hook, perhaps with the new argument named `struct
> sock *other`?  Then we can use this hook for the scope check as well by
> using landlock_cred(other->sk_socket->file->f_cred)->domain etc.
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 227467236930..db9d279b3883 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1223,24 +1223,24 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
>  
>  	err = -ECONNREFUSED;
>  	inode = d_backing_inode(path.dentry);
>  	if (!S_ISSOCK(inode->i_mode))
>  		goto path_put;
>  
> +	err = -ECONNREFUSED;
> +	sk = unix_find_socket_byinode(inode);
> +	if (!sk)
> +		goto path_put;
> +
>  	/*
>  	 * We call the hook because we know that the inode is a socket
>  	 * and we hold a valid reference to it via the path.
>  	 */
> -	err = security_unix_find(&path, type, flags);
> +	err = security_unix_find(&path, sk, flags);
>  	if (err)
> -		goto path_put;
> -
> -	err = -ECONNREFUSED;
> -	sk = unix_find_socket_byinode(inode);
> -	if (!sk)
> -		goto path_put;
> +		goto sock_put;
>  
>  	err = -EPROTOTYPE;
>  	if (sk->sk_type == type)
>  		touch_atime(&path);
>  	else
>  		goto sock_put;
> 
> By doing this we won't even need to pass `type` separately anymore.  The
> only change would be that now one can determine if a socket is bound or
> not even without being allowed RESOLVE_UNIX access.  I'm not sure how much
> of an issue this is, but we could also call the hook anyway with a NULL in
> place of the new argument, if unix_find_socket_byinode() fails.  Other
> LSMs can then decide what to do in that case (either return -ECONNREFUSED
> or -EPERM).

Thank you for the suggestion.

Small caveat is that the LSM interface is very central and we should
be careful.  We have previously gotten the advice from Paul to design
the hooks in an LSM-independent way that ideally reflects the
arguments to the unix_find_bsd() function, and this would now deviate
(slightly) from that, but simplifying the implementation for us.  In
my personal opinion, this might be worth doing the trade-off, if
AppArmor people also agree, but we should double check.

To keep the discussion of implementation and interface separate, I
have raised this question in the pathname-restricted-UNIX patch set
thread in [1].

[1] https://lore.kernel.org/all/aYMenaSmBkAsFowd@google.com/



> >> Furthermore, an application / Landlock config etc can always opt to not
> >> use the scope bit at all, if it "knows" all the locations where the
> >> application's sockets would be placed, and just use RESOLVE_UNIX access
> >> right (or nothing if it is not supported).
> >>
> >> (The following is a bit of a side note, not terribly relevant if we're
> >> deciding to go with the patch as is.)
> >>
> >>>> [...]
> >>>> Another way to put it is that, if FS-based and scope-based controls
> >>>> interacts in the above proposed way, both mechanisms feel like "poking
> >>>> holes" in the other.  But as Mickaël said, one can think of the two
> >>>> mechanisms not as independent controls, but rather as two interfaces for
> >>>> the same control.  The socket access control is "enabled" if either the
> >>>> LANDLOCK_ACCESS_FS_RESOLVE_UNIX access is handled, or the scope bit
> >>>> proposed in this patch is enabled.
> >>>>
> >>>> With that said, I can think of some alternative ways that might make this
> >>>> API look "better" (from a subjective point of view, feedback welcome),
> >>>> however it does mean more delays, and specifically, these will depend on
> >>>> LANDLOCK_ACCESS_FS_RESOLVE_UNIX:
> >>>>
> >>>> One possibility is to simply always allow a Landlock domain to connect to
> >>>> its own sockets (in the case where LANDLOCK_ACCESS_FS_RESOLVE_UNIX is
> >>>> handled, otherwise all sockets are allowed).  This might be reasonable, as
> >>>> one can only connect to a socket it creates if it has the permission to
> >>>> create it in the first place, which is already controlled by
> >>>> LANDLOCK_ACCESS_FS_MAKE_SOCK, so we don't really lose any policy
> >>>> flexibility here - if for some reason the sandboxer don't want to allow
> >>>> access to any (pathname) sockets, even the sandboxed app's own ones, it
> >>>> can just not allow LANDLOCK_ACCESS_FS_MAKE_SOCK anywhere.
> >>>
> >>> LANDLOCK_ACCESS_FS_MAKE_SOCK is only required to bind/listen to a
> >>> socket, not to connect.  I guess you was thinking about
> >>> LANDLOCK_ACCESS_FS_RESOLVE_UNIX in this case?
> >>
> >> In this "allow same-scope connect unconditionally" proposal, the
> >> application would still be able to (bind to and) connect to its own
> >> sockets, even if LANDLOCK_ACCESS_FS_RESOLVE_UNIX is handled and nothing is
> >> allowed to have LANDLOCK_ACCESS_FS_RESOLVE_UNIX access.  But a sandboxer
> >> which for whatever reason doesn't want this "allow same scope" default can
> >> still prevent the use of (pathname) sockets by restricting
> >> LANDLOCK_ACCESS_FS_MAKE_SOCK, because if an app can't connect to any
> >> sockets it doesn't own, and can't create any sockets itself either, then
> >> it effectively can't connect to any sockets at all.
> >>
> >> (Although on second thought, I guess there could be a case where an app
> >> first creates some socket files before doing landlock_restrict_self(),
> >> then it might still be able to bind to these even without
> >> LANDLOCK_ACCESS_FS_MAKE_SOCK?)
> >
> > FWIW, I also really liked Tingmao's first of the two listed
> > possibilities in [1], where she proposed to introduce both rights
> > together.  In my understanding, the arguments we have discussed so far
> > for that are:
> >
> > IN FAVOR:
> >
> > (pro1) Connecting to a UNIX socket in the same scope is always safe,
> >        and it makes it possible to use named UNIX sockets between the
> >        processes within a Landlock domains.  (Mickaël convinced me in
> >        discussion at FOSDEM that this is true.)
> >
> >        If someone absolutely does not want that, they can restrict
> >        LANDLOCK_ACCESS_FS_MAKE_SOCK and achieve the same effect (as
> >        Tingmao said above).
> >
> > (pro2) The implementation of this is simpler.
> >
> >        (I attempted to understand how the "or" semantics would be
> >        implemented, and I found it non-trivial when you try to do it
> >        for all layers at once. (Kernighan's Law applies, IMHO))
> 
> I think the logic would basically be:
> 
> 1. if any layers deny the access due to handled RESOLVE_UNIX but does not
> have the scope bit set, then we will deny rightaway, without calling
> domain_is_scoped().
> 
> 2. Call domain_is_scoped() with a bitmask of "rules_covered" layers where
> there are RESOLVE_UNIX rules covering the socket being accessed, and
> essentially ignore those layers in the scope violation check.
> 
> I definitely agree that it is tricky, but making same-scope access be
> allowed (i.e. the suggested idea above) would only get rid of step 1,
> which I think is the "simpler" bit.  The extra logic in step 2 is still
> needed. 
> 
> I definitely agree with pro1 tho.

Yes, you are describing the logic for the variant where
LANDLOCK_ACCESS_FS_RESOLVE_UNIX does not implicitly permit access from
within the same scope.  In that variant, there can be situations where
the first hook can deny the action immediately.

In the variant where LANDLOCK_ACCESS_FS_RESOLVE_UNIX *does* implicitly
allow access from within the same scope, that shortcutting is not
possible.  On the upside however, there is no need to distinguish
whether the scope flag is set when we are in the security_unix_find()
hook, because access from within the same scope is always permitted.
(That is the simplification I meant.)


> > AGAINST:
> >
> > (con1) It would work differently than the other scoped access rights
> >        that we already have.
> >
> >        A speculative feature that could potentially be built with the
> >        scoped access rights is that we could add a rule to permit IPC
> >        to other Landlock scopes, e.g. introducing a new rule type
> >
> >          struct landlock_scope_attr {
> >            __u64 allowed_access;  /* for "scoped" bits */
> >            /* some way to identify domains */
> >          }
> >
> >        so that we could make IPC access to other Landlock domains
> >        configurable.
> >
> >        If the scoped bit and the FS RESOLVE_UNIX bit were both
> >        conflated in RESOLVE_UNIX, it would not be possible to make
> >        UNIX connections configurable in such a way.
> 
> This exact API would no longer work, but if we give up the equivalence
> between scope bits and the landlock_scope_attr struct, then we can do
> something like:
> 
> struct landlock_scope_attr {
>     __u64 ptrace:1;  /* Note that this is not a (user controllable) scope bit! */
>     __u64 abstract_unix_socket:1;
>     __u64 pathname_unix_socket:1;
>     /* ... */
> 
>     __u64 allowed_signals;
> 
>     /*
>      * some way to identify domains, maybe we could use the audit domain
>      * ID, with 0 denoting "allow access to non-Landlocked processes?
>      */
> }

Yes, it would be possible to use such a struct for that scenario where
IPC access gets allowed for other Landlock scopes.  It would mean that
we would not need to introduce a scoped flag for the pathname UNIX
socket connections.  But the relationship between that struct
landlock_scope_attr and the flags and access rights in struct
landlock_ruleset_attr would become less clear, which is a slight
downside, and maybe error prone for users to work with.

If we introduced an additional scoped flag, it would also be
consistent though.

(con1) was written under the assumption that we do not have an
additional scoped flag.  If that is lacking, it is not possible to
express UNIX connect() access to other Landlock domains with that
struct.  But as outlined in the proposal below, if we *do* (later)
introduce the additional scoped flag *in addition* to the FS access
right, this *both* stays consistent in semantics with the signal and
abstract UNIX support, *and* it starts working in a world where ICP
access can be allowed to talk to other Landlock domains.

> > (con2) Consistent behaviour between scoped flags and their
> >        interactions with other access rights:
> >
> >        The existing scoped access rights (signal, abstract sockets)
> >        could hypothetically be extended with a related access right of
> >        another type. For instance, there could be an access right type
> >
> >          __u64 handled_signal_number;
> >
> >        and then you could add a rule to permit the use of certain
> >        signal numbers.  The interaction between the scoped flags and
> >        other access rights should work the same.
> >
> >
> > Constructive Proposal for consideration: Why not both?
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> I will think about the following a bit more but I'm afraid that I feel
> like it might get slightly confusing.  With this, the only reason for
> having LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET is for API consistency when we
> later enable allowing access to other domains (if I understood correctly),
> in which case I personally feel like the suggestion on landlock_scope_attr
> above, where we essentially accept that it is decoupled with the scope
> bits in the ruleset, might be simpler...?

Mickaël expressed the opinion to me that he would like to APIs to stay
consistent between signals, abstract UNIX sockets, named UNIX sockets
and other future "scoped" operations, in scenarios where:

* the "scoped" (IPC) operations can be configured to give access to
  other Landlock domains (and that should work for UNIX connections too)
* the existing "scoped" operations also start having matching access rights

I think with the way I proposed, that would be consistent.


> > Why not do both what Tingmao proposed in [1] **and** reserve the
> > option to add the matching "scoped flag" later?
> >
> >   * Introduce LANDLOCK_ACCESS_FS_RESOLVE_UNIX.
> >
> >     If it is handled, UNIX connections are allowed either:
> >
> >     (1) if the connection is to a service in the same scope, or
> >     (2) if the path was allow-listed with a "path beneath" rule.
> >
> >   * Add LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET later, if needed.
> >
> >
> > Let's go through the arguments again:
> >
> > We have observed that it is harmless to allow connections to services
> > in the same scope (1), and that if users absolutely don't want that,
> > they can actually prohibit it through LANDLOCK_ACCESS_FS_MAKE_SOCK
> > (pro1).
> >
> > (con1): Can we still implement the feature idea where we poke a hole
> >         to get UNIX-connect() access to other Landlock domains?
> >
> >   I think the answer is yes.  The implementation strategy is:
> >
> >     * Add the scoped bit LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
> >     * The scoped bit can now be used to allow-list connections to
> >       other Landlock domains.
> >
> >   For users, just setting the scoped bit on its own does the same as
> >   handling LANDLOCK_ACCESS_FS_RESOLVE_UNIX.  That way, the kernel-side
> >   implementation can also stay simple.  The only reason why the scoped
> >   bit is needed is because it makes it possible to allow-list
> >   connections to other Landlock domains, but at the same time, it is
> >   safe if libraries set the scoped bit once it exists, as it does not
> >   have any bad runtime impact either.
> >
> > (con2): Consistency: Do all the scoped flags interact with their
> >         corresponding access rights in the same way?
> >
> >   The other scope flags do not have corresponding access rights, so
> >   far.
> >
> >   If we were to add corresponding access rights for the other scope
> >   flags, I would argue that we could apply a consistent logic there,
> >   because IPC access within the same scope is always safe:
> >
> >   - A hypothetical access right type for "signal numbers" would only
> >     restrict signals that go beyond the current scope.
> >
> >   - A hypothetical access right type for "abstract UNIX domain socket
> >     names" would only restrict connections to abstract UNIX domain
> >     servers that go beyond the current scope.
> >
> >   I can not come up with a scenario where this doesn't work.
> >
> >
> > In conclusion, I think the approach has significant upsides:
> >
> >   * Simpler UAPI: Users only have one access bit to deal with, in the
> >     near future.  Once we do add a scope flag for UNIX connections, it
> >     does not interact in a surprising way with the corresponding FS
> >     access right, because with either of these, scoped access is
> >     allowed.
> >
> >     If users absolutely need to restrict scoped access, they can
> >     restrict LANDLOCK_ACCESS_FS_MAKE_SOCK.  It is a slightly obscure
> >     API, but in line with the "make easy things easy, make hard things
> >     possible" API philosophy.  And needing this should be the
> >     exception rather than the norm, after all.
> >
> >   * Consistent behaviour between scoped flags and regular access
> >     rights, also for speculative access rights affecting the existing
> >     scoped flags for signals and abstract UNIX domain sockets.
> >
> > [1] https://lore.kernel.org/all/f07fe41a-96c5-4d3a-9966-35b30b3a71f1@maowtm.org/

—Günther
