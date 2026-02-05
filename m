Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6167729C339
	for <linux-security-module@vger.kernel.org>; Thu,  5 Feb 2026 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770304974; cv=none; b=ffNsmh9QxsY6wOZV4ltIZBdoDzYOUpWaOgWmefz7kY2TnfgPJzRK0rgVWNtucTld7o3Gd7jS4i5WZGWqs8HU+UxwR/HGzjGnkc9djOaZWuHuhe2bVj4mpNYiCUFmKaEUrok8kwF2SXsMbtCSgeYYD4P78YNyFge3txXFAOJg3Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770304974; c=relaxed/simple;
	bh=jtYAr+amyJouHCXMVAL6sPglP5zbrtUbh7jICRMXP+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBmwec9o+CQA8pymj8QtnR+QpFZbv5Ocj8SziLHVcKATLSpzWqc1kknAbdmPebJzvR0WOVIJVLkJopygmNBVYD7KtpoewMt/PCQthajcpuWELNOM6X9I1iSESJqAP3u6Mj1+yqOLrW5vDKpcj9EBm1pLPyLxhO+RkWPaPE9UL1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSCT9GKm; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSCT9GKm"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79518cc2bb4so7984247b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 05 Feb 2026 07:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770304973; x=1770909773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzVSTvsJXBwT/LJnbmpFKOc0ty8i/0TRQSIXuI9UPh8=;
        b=mSCT9GKmhUhvQVMXuGoJGd92hfFKSjaKuYATn4rh5OyiN8dCZHIV9Fz1bT9ueAJLBI
         uiLzIRbk9FOYQSC+E04qXrUwRYHsfp6DYmvVkAjNLXZeM23IVE0iU+dcsjxNtO0BZEC/
         JpL3Y4oPwOfpqI4Qd6ZJVawd1NbiwPI9lTHkVuB9bct0wBqUj5C32YGyvR/8lcQsIpqQ
         yH8CVmlRqpc9FrsgMXl6mMa9JoL+Xswso9KjIK3b7UOs5LTwEQGToovi9EPkOWdHdHhR
         qwaya1AfhVHD4yqfEKzPeD6s3pyZaudBucVI9JIOfclKzW5J4wM7lOc68Z0PIo2CH7bd
         fhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770304973; x=1770909773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nzVSTvsJXBwT/LJnbmpFKOc0ty8i/0TRQSIXuI9UPh8=;
        b=iaHkoFEL1dih1mshlHfwPuDGON4fEnyFVjXCxK/FGe6+haOPY1L+89Gwz9DYOHqYFc
         hQJ8N+ULv5QLCjU7QzRfsNzlMy4DOC8zeuEjHUctR/m086w1a9vy0Eft/xf0wYwaCAoU
         fajt351aRNqqnJSj+rZ8WwULeT84IsukTZ3v3tvyWqTwzt0cPtm7hkS7yFa4Rai36NYi
         ive4s3ZlXgq7RBq0RG+fMXO+WheRJFiQl/UNqwtzGOU5ZT1a/+7+da7fytLD+fR+9tla
         8EtcOR4v9ze9HlmeEz6CSACCrLuBYGKBbAg/+OcjGGGqJ9Gpj9HQNYDe0NCzlB2ai7BI
         YkJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVR1jivjiYsp6RN3pRVb0Ei1sdJWbbEC44y2H/xJa6uzURm14H80zbKHCGmx5OJldY1//cSoH76r6ZOdvn2mBtfThefp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmoPvz8pRURvZCO5aK0ioLZKiWjpLpuA7dw2IZieIOOi7tyIT1
	KQMY8vTMEbuiS6zCBDAMZqj1yvSHuN2xkYLacgg/8xkGnUZTQgQ0qDIc
X-Gm-Gg: AZuq6aI62ByC8JyjAp1vHh9MtLF0iW10ErGklhsyphuSxuns8EVdwIKaOamWyj+jpt7
	qCkI2J9RvRdoIc0uv5Ml7f0Ez7xhFXWTviL9aWBG23R2x+IOLgGQepauOsOV2Ny5yC7twRovCM3
	U65wbw0Y1/byCLH7plJVgW9hdvCh5JJouqyaCLA9t7CTSAr8GttRGFieUP/ZUCTXdjoUrViE94o
	fECg6CbwCv2a65UpJkZeAEYyOB53W78VQL5NewSwOsxH5pixtM5hz7LoMuC7Jk1IbpWht5canLZ
	w4RwDA7EAad94xLSGAS6vJANSY8Z610vcRX9VQH3dWtoIO4c9yJvYli3dYo3vhZzU95Ll8EdQcW
	A1XqzbOOmKY0dvza2+8oABtqwcyU1i2Px4TzP1p2tf3WpINrOB1fR5dDcMMDq4lFL/60CkBHQOG
	NtSjZvHJ9LvXQoO6ceBs0Xm40OMHwGlbKUcXPV2JQj15lLOnt6BlYrXmrMFArI
X-Received: by 2002:a05:690c:2505:b0:794:ede8:16a with SMTP id 00721157ae682-794fe6ca8ffmr67818477b3.13.1770304973001;
        Thu, 05 Feb 2026 07:22:53 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794feea8236sm47874817b3.17.2026.02.05.07.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 07:22:52 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: mic@digikod.net
Cc: demiobenour@gmail.com,
	fahimitahera@gmail.com,
	gnoack3000@gmail.com,
	gnoack@google.com,
	hi@alyssa.is,
	jannh@google.com,
	linux-security-module@vger.kernel.org,
	m@maowtm.org,
	matthieu@buffet.re,
	utilityemal77@gmail.com
Subject: Re: [PATCH v2 0/6] Landlock: Implement scope control for pathname Unix sockets
Date: Thu,  5 Feb 2026 10:22:50 -0500
Message-ID: <20260205152251.2947451-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204.vug7Osheiwou@digikod.net>
References: <20260204.vug7Osheiwou@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/4/26 13:28, Mickaël Salaün wrote:

>> [...]
>> Tingmao:
>>
>> For connecting a pathname unix socket, the order of the hooks landlock sees is something like:
>>
>> 1.  security_unix_find. (to look up the paths)
>>
>> 2. security_unix_may_send, security_unix_stream_connect (after the path is looked up)
>>
>> Which for is called in DGRAM:
>>
>>  unix_dgram_connect OR  unix_dgram_sendmsg 
>>
>> and for STREAM:
>>
>>  unix_stream_connect
>>
>> IIRC, the path lookup only occurs in this order always, so in the logic as you have it the domain_is_scoped()
>> would be called twice, once from the security_unix_find when you call it in step two, and once from the
>> domain scope hooks. (If access was allowed from security_unix_find)
>>
>> There are a couple of things to consider.
>>
>> ---
>>
>> Audit blockers need special handling:
>>
>> Here's an example:
>>
>> 1. Program A enforces a ruleset with RESOLVE_UNIX and the unix pathname scope bit, with no rules with that
>> access bit (deny all for RESOLVE_UNIX).
>>
>> 2. Program A connects to /tmp/mysock.sock ran by program B, which is outside the domain.
>>
>> 2. security_unix_find is hit to lookup the path, and the RESOLVE_UNIX code doesn't grant access to
>> /tmp/mysock.sock, so it calls domain_is_scoped
>>
>> 3. domain_is_scoped denies it as well, so now we must log an audit record.
>>
>> When logging the denial, we have to include both blockers "scope.unix_socket"  and "fs.resolve_unix" for the
>> denial, because it is the absence of both that caused the denial. I think the refer right has similar cases for auditing, so there is precedent for this (multiple blockers for an audit message).
> That's a good point, and it would give more informations to diagnose
> issues.  However, being able to identify if both accesses are denied
> would require to check both, whereas the first is enough to know that
> Landlock denies the access.  So, if we can return both records without
> continuing the security checks, that's good, otherwise we should stop
> ASAP and return the error.

Maybe I'm missing something, but if the flags interact in an "OR" manner
wouldn't we need to check both? In your proposal where RESOLVE_UNIX
implies the scoped flag, if a program connects to a unix socket that is within
the domain but does not have an explicit RESOLVE_UNIX exception, we must
still check for the case that the access is scoped.

---

(Given LANDLOCK_ACCESS_FS_RESOLVE_UNIX and LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
are set)

case 1: access to socket within domain and no RESOLVE_UNIX rule covers the access

We check first in security_unix_find hook and find there is no rule allowing the access.
After the check fails, because LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET is set
we then check is_domain_scoped, the check allows the access.

case 2: access to socket outside domain but RESOLVE_UNIX rule covers the access

We check first in security_unix_find hook and find there is a rule allowing the access.
We can allow the access early (short-circuit eval) without calling is_domain_scoped.

case 4: access to socket inside domain and RESOLVE_UNIX covers the access

We check first in security_unix_find hook and find there is a rule allowing the access.
We can allow the access early (short-circuit eval) without calling is_domain_scoped. (same as case 2)


case 4: access to socket outside domain and no RESOLVE_UNIX covers the access

We check first in security_unix_find hook and find there is no rule allowing the access.
After the check fails, because LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET is set
we then check is_domain_scoped, the check does not allow the access. (it is the combination
of the two checks failing that denied the access).

---

Case 4 is what I'm specifically considering would need to have both blockers listed in a denial audit.
We can't short circuit in that case because we have to check the scoping before denying.
Let me know if I'm misunderstanding this.

(PS: IIRC the hooks used by the LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
will never be hit if the check in security_unix_find fails. So some logic to check this
access in security_unix_find will be needed).

> Anyway, that might not be needed if we end up with my latest proposal
> about always setting scope.unix_socket when fs.resolve_unix is set.
>
>> ---
>>
>> Dual lookup for domain_is_scoped. Consider this case:
>>
>> 1. Program A enforces a ruleset with RESOLVE_UNIX and the unix pathname scope bit, with no rules with that
>> access bit (deny all for RESOLVE_UNIX).
>>
>> 2. Program A connects to Program C's /tmp/foo.sock, which for the purposes of this example is in the domain of program A.
>>
>> 3.  security_unix_find is hit to lookup the path, and the RESOLVE_UNIX code doesn't grant access to
>> /tmp/mysock.sock, so it calls domain_is_scoped. Access is granted, and continues. (LSM hook complete)
>>
>> 4.  The connection proceeds past the path lookup stage, and now security_unix_may_send, or security_unix_stream_connect gets called. This requires ANOTHER domain_is_scoped access check.
>>
>> While I don't THINK this introduces a TOCTOU, it is a little confusing.
>>
>> This does mean that we look up the domain twice, if this is implemented naively. I think we can then just
>> skip the task credential checks then for security_unix_may_send and security_unix_stream_connect **for
>> connecting to pathname sockets**, since the domain_is_scoped will already have been called in landlock's
>> security_unix_find hook, eliminating the need for handling pathname socket domain checks layer on.
>>
>>>> I definitely agree that it is tricky, but making same-scope access be
>>>> allowed (i.e. the suggested idea above) would only get rid of step 1,
>>>> which I think is the "simpler" bit.  The extra logic in step 2 is still
>>>> needed. 
>>>>
>>>> I definitely agree with pro1 tho.
>>> Yes, you are describing the logic for the variant where
>>> LANDLOCK_ACCESS_FS_RESOLVE_UNIX does not implicitly permit access from
>>> within the same scope.  In that variant, there can be situations where
>>> the first hook can deny the action immediately.
>>>
>>> In the variant where LANDLOCK_ACCESS_FS_RESOLVE_UNIX *does* implicitly
>>> allow access from within the same scope, that shortcutting is not
>>> possible.  On the upside however, there is no need to distinguish
>>> whether the scope flag is set when we are in the security_unix_find()
>>> hook, because access from within the same scope is always permitted.
>>> (That is the simplification I meant.)
>>>
>>>
>>>>> AGAINST:
>>>>>
>>>>> (con1) It would work differently than the other scoped access rights
>>>>>        that we already have.
>>>>>
>>>>>        A speculative feature that could potentially be built with the
>>>>>        scoped access rights is that we could add a rule to permit IPC
>>>>>        to other Landlock scopes, e.g. introducing a new rule type
>>>>>
>>>>>          struct landlock_scope_attr {
>>>>>            __u64 allowed_access;  /* for "scoped" bits */
>>>>>            /* some way to identify domains */
>>>>>          }
>>>>>
>>>>>        so that we could make IPC access to other Landlock domains
>>>>>        configurable.
>>>>>
>>>>>        If the scoped bit and the FS RESOLVE_UNIX bit were both
>>>>>        conflated in RESOLVE_UNIX, it would not be possible to make
>>>>>        UNIX connections configurable in such a way.
>>>> This exact API would no longer work, but if we give up the equivalence
>>>> between scope bits and the landlock_scope_attr struct, then we can do
>>>> something like:
>>>>
>>>> struct landlock_scope_attr {
>>>>     __u64 ptrace:1;  /* Note that this is not a (user controllable) scope bit! */
>>>>     __u64 abstract_unix_socket:1;
>>>>     __u64 pathname_unix_socket:1;
>>>>     /* ... */
>>>>
>>>>     __u64 allowed_signals;
>>>>
>>>>     /*
>>>>      * some way to identify domains, maybe we could use the audit domain
>>>>      * ID, with 0 denoting "allow access to non-Landlocked processes?
>>>>      */
>>>> }
>>> Yes, it would be possible to use such a struct for that scenario where
>>> IPC access gets allowed for other Landlock scopes.  It would mean that
>>> we would not need to introduce a scoped flag for the pathname UNIX
>>> socket connections.  But the relationship between that struct
>>> landlock_scope_attr and the flags and access rights in struct
>>> landlock_ruleset_attr would become less clear, which is a slight
>>> downside, and maybe error prone for users to work with.
>>>
>>> If we introduced an additional scoped flag, it would also be
>>> consistent though.
>>>
>>> (con1) was written under the assumption that we do not have an
>>> additional scoped flag.  If that is lacking, it is not possible to
>>> express UNIX connect() access to other Landlock domains with that
>>> struct.  But as outlined in the proposal below, if we *do* (later)
>>> introduce the additional scoped flag *in addition* to the FS access
>>> right, this *both* stays consistent in semantics with the signal and
>>> abstract UNIX support, *and* it starts working in a world where ICP
>>> access can be allowed to talk to other Landlock domains.
>>>
>>>>> (con2) Consistent behaviour between scoped flags and their
>>>>>        interactions with other access rights:
>>>>>
>>>>>        The existing scoped access rights (signal, abstract sockets)
>>>>>        could hypothetically be extended with a related access right of
>>>>>        another type. For instance, there could be an access right type
>>>>>
>>>>>          __u64 handled_signal_number;
>>>>>
>>>>>        and then you could add a rule to permit the use of certain
>>>>>        signal numbers.  The interaction between the scoped flags and
>>>>>        other access rights should work the same.
>>>>>
>>>>>
>>>>> Constructive Proposal for consideration: Why not both?
>>>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> I will think about the following a bit more but I'm afraid that I feel
>>>> like it might get slightly confusing.  With this, the only reason for
>>>> having LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET is for API consistency when we
>>>> later enable allowing access to other domains (if I understood correctly),
>>>> in which case I personally feel like the suggestion on landlock_scope_attr
>>>> above, where we essentially accept that it is decoupled with the scope
>>>> bits in the ruleset, might be simpler...?
>>> Mickaël expressed the opinion to me that he would like to APIs to stay
>>> consistent between signals, abstract UNIX sockets, named UNIX sockets
>>> and other future "scoped" operations, in scenarios where:
>>>
>>> * the "scoped" (IPC) operations can be configured to give access to
>>>   other Landlock domains (and that should work for UNIX connections too)
>>> * the existing "scoped" operations also start having matching access rights
>>>
>>> I think with the way I proposed, that would be consistent.
>>>
>>>
>>>>> Why not do both what Tingmao proposed in [1] **and** reserve the
>>>>> option to add the matching "scoped flag" later?
>>>>>
>>>>>   * Introduce LANDLOCK_ACCESS_FS_RESOLVE_UNIX.
>>>>>
>>>>>     If it is handled, UNIX connections are allowed either:
>>>>>
>>>>>     (1) if the connection is to a service in the same scope, or
>>>>>     (2) if the path was allow-listed with a "path beneath" rule.
>>>>>
>>>>>   * Add LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET later, if needed.
>>>>>
>>>>>
>>>>> Let's go through the arguments again:
>>>>>
>>>>> We have observed that it is harmless to allow connections to services
>>>>> in the same scope (1), and that if users absolutely don't want that,
>>>>> they can actually prohibit it through LANDLOCK_ACCESS_FS_MAKE_SOCK
>>>>> (pro1).
>>>>>
>>>>> (con1): Can we still implement the feature idea where we poke a hole
>>>>>         to get UNIX-connect() access to other Landlock domains?
>>>>>
>>>>>   I think the answer is yes.  The implementation strategy is:
>>>>>
>>>>>     * Add the scoped bit LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
>>>>>     * The scoped bit can now be used to allow-list connections to
>>>>>       other Landlock domains.
>>>>>
>>>>>   For users, just setting the scoped bit on its own does the same as
>>>>>   handling LANDLOCK_ACCESS_FS_RESOLVE_UNIX.  That way, the kernel-side
>>>>>   implementation can also stay simple.  The only reason why the scoped
>>>>>   bit is needed is because it makes it possible to allow-list
>>>>>   connections to other Landlock domains, but at the same time, it is
>>>>>   safe if libraries set the scoped bit once it exists, as it does not
>>>>>   have any bad runtime impact either.
>>>>>
>>>>> (con2): Consistency: Do all the scoped flags interact with their
>>>>>         corresponding access rights in the same way?
>>>>>
>>>>>   The other scope flags do not have corresponding access rights, so
>>>>>   far.
>>>>>
>>>>>   If we were to add corresponding access rights for the other scope
>>>>>   flags, I would argue that we could apply a consistent logic there,
>>>>>   because IPC access within the same scope is always safe:
>>>>>
>>>>>   - A hypothetical access right type for "signal numbers" would only
>>>>>     restrict signals that go beyond the current scope.
>>>>>
>>>>>   - A hypothetical access right type for "abstract UNIX domain socket
>>>>>     names" would only restrict connections to abstract UNIX domain
>>>>>     servers that go beyond the current scope.
>>>>>
>>>>>   I can not come up with a scenario where this doesn't work.
>> Gunther / Tingmao / Mickaël:
>>
>> I have a potential idea to make this concept cleaner.
>>
>> The docs for landlock currently say:
>>
>>
>>        IPC scoping does not support exceptions via landlock_add_rule(2).
>>        If an operation is scoped within a domain, no rules can be added
>>        to allow access to resources or processes outside of the scope.
> This part might indeed be confusing.  The idea was to explain the
> difference between scoped rights and handled access rights (which may
> have rules).
>
>> So if we go with the solution where we are now saying IPC scoping DOES support exceptions
>> we will need to update the documentation, to say scoping for pathname unix sockets is an exception,
>> and have to have the "exemptible scopes" (like this one) alongside "non-exemptible" scopes
>> (ie the existing ones). This creates some friction for users.
> The documentation will definitely require some updates.  I think it can
> be explained in a simple way.
>
>> If we foresee other "exempt-able scopes" (which are scopes that also support creating exemptions w/ corresponding access rights) in the future, maybe we should consider separating the two in the ruleset
>> attributes (I used scoped_fs as an example for the attribute name):
>>
>> structlandlock_ruleset_attrruleset_attr={
>> .handled_access_fs=
>> LANDLOCK_ACCESS_FS_EXECUTE|
>> LANDLOCK_ACCESS_FS_WRITE_FILE|
>> LANDLOCK_ACCESS_FS_READ_FILE|
>> LANDLOCK_ACCESS_FS_READ_DIR|
>> LANDLOCK_ACCESS_FS_REMOVE_DIR|
>> LANDLOCK_ACCESS_FS_REMOVE_FILE|
>> LANDLOCK_ACCESS_FS_MAKE_CHAR|
>> LANDLOCK_ACCESS_FS_MAKE_DIR|
>> LANDLOCK_ACCESS_FS_MAKE_REG|
>> LANDLOCK_ACCESS_FS_MAKE_SOCK|
>> LANDLOCK_ACCESS_FS_MAKE_FIFO|
>> LANDLOCK_ACCESS_FS_MAKE_BLOCK|
>> LANDLOCK_ACCESS_FS_MAKE_SYM|
>> LANDLOCK_ACCESS_FS_REFER|
>> LANDLOCK_ACCESS_FS_TRUNCATE|
>> LANDLOCK_ACCESS_FS_IOCTL_DEV,
>> .handled_access_net=
>> LANDLOCK_ACCESS_NET_BIND_TCP|
>> LANDLOCK_ACCESS_NET_CONNECT_TCP,
>> .scoped=
>> LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET|
>> LANDLOCK_SCOPE_SIGNAL,
>>     .scoped_fs = 
>> 	LANDLOCK_SCOPE_FS_PATHNAME_UNIX_SOCKET
>> };
>>
>> This more clearly distinguishes between scopes that have exceptions/corresponding fs rights,
>> and ones that don't. Later we could add scoped_net, if needed. I feel like this would be more
>> intuitive and better categorize future scoping rights. An obvious con is increasing the size of
>> the ruleset attributes.
> I see your point but I don't think it would be worth it to add
> sub-scoped fields.  Each field has a clear semantic, and the scoped one
> is related to the domain wrt other domains.
As long as it's documented clearly, and future IPCs have similar behavior
I agree that a separate field probably isn't needed.
>> Of course this separation is only worth it if there are other "exempt-able" rights in the future.
>> I can think of a few potential future rights which COULD be scoped and have corresponding rights
>> (binder, sysv-ipc, pipes, tcp/udp between two local programs). 
> Yes, it would definitely be useful to add exception for other kind of
> IPCs.  The idea would be to be able to describe the peer, either with a
> file path, or PID, or cgroups, or a Landlock domain...  The inet case
> is an interesting idea but that might be a challenging task to
> implement, if even possible.

>>>>> In conclusion, I think the approach has significant upsides:
>>>>>
>>>>>   * Simpler UAPI: Users only have one access bit to deal with, in the
>>>>>     near future.  Once we do add a scope flag for UNIX connections, it
>>>>>     does not interact in a surprising way with the corresponding FS
>>>>>     access right, because with either of these, scoped access is
>>>>>     allowed.
>>>>>
>>>>>     If users absolutely need to restrict scoped access, they can
>>>>>     restrict LANDLOCK_ACCESS_FS_MAKE_SOCK.  It is a slightly obscure
>>>>>     API, but in line with the "make easy things easy, make hard things
>>>>>     possible" API philosophy.  And needing this should be the
>>>>>     exception rather than the norm, after all.
>>>>>
>>>>>   * Consistent behaviour between scoped flags and regular access
>>>>>     rights, also for speculative access rights affecting the existing
>>>>>     scoped flags for signals and abstract UNIX domain sockets.
>>>>>
>>>>> [1] https://lore.kernel.org/all/f07fe41a-96c5-4d3a-9966-35b30b3a71f1@maowtm.org/
>>> —Günther

