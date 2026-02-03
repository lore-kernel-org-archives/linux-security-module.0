Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803653195F0
	for <linux-security-module@vger.kernel.org>; Tue,  3 Feb 2026 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141251; cv=none; b=WQ1Be/iPQoJnDypBSiviszOklH2T3NbdNOtb3BiZT8HZMSRrPdtB5JhWpat0cVZ/jMnv4C647QRmDUdCJ7B4FZnBkkoR9ximFq2kK4flCMFRAev53bCUGFgLSkYns8PFfY5RWXJ+JGJ/h1ASlfJV2uU2FSnHXkLEzUhXxuw+P6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141251; c=relaxed/simple;
	bh=WsGerUYZYwU39jgt72deKKgYVJMeO//1CRmKjgqh7E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qU4zb4wvdAzNI59DJSx/IYwXwUFzUnYup3Dk0zhtNVMSooFB7gM9aeAGWNIaQLvPf2QRXNX35cXt/hGG65mkOdy4a4gpiaAnFOSkWRniPAE7bvFpGAZwfO1rl6hr1etfiqOZJmWWU15eOL9Gqcs+PT2JD63fK79Yq9kNojXNn8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jO0Na7DX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jO0Na7DX"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4806dffc64cso45768825e9.1
        for <linux-security-module@vger.kernel.org>; Tue, 03 Feb 2026 09:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770141248; x=1770746048; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C2VY9R4P6T+04iS3IMGnHqFR0e9uF4zn/ls8xiDD2g4=;
        b=jO0Na7DXwvIqyetGEAlpvMw0vgdbOBjKXIUKj0BcpdpSBV64FeOqVTyRWTxm8SrlCA
         RlXPvyJJqGAdJisnSmqVNZ6oFK/U7gpJ0fAGXM+WIA9cdVTuw096OW7T2crCZYQXdytk
         5JIIpt2g+H7JC5dhjfHskcT82Cp6AnOQ9XrkBCW4bKLaPgrgtbIQUKUDJXch1X/PB0qj
         ikuHasV56oIcjiCoHg9qNVqwYHHOb+zoPAXc3/WF6sNE4kyH07pNRBwy3+yX14VIbG+w
         CN7zoTfdb+eD8mF5m8sA+uRDed/TTxdLX7EYpLOY1og50rvOTITs1yqddeXAqTg7m+3B
         y2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770141248; x=1770746048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2VY9R4P6T+04iS3IMGnHqFR0e9uF4zn/ls8xiDD2g4=;
        b=DYc4/yCcDI/DHslx2klmi1KkJgMAAEcBr0uPqV7su1pg36/Z1/8FuW7ZxVC7Jc0vbS
         qVXc38+9Fgdgb9e4/sj90lAt/ASu/iInuAN8wxXwIJoBHnFBU5AcM3+0otG068ZoWQCk
         JVm1n5t3BqLUX2IL5ipcezgOWFvV/TIqKPodNvZ66QoRHiOYOiqGgbxvwY8Or2c7P0Rp
         fSLfG2py+vbNrDHSSJrjI9fV+TYVvLLfvwtG/J3PenYncug7aKX6TEoSSlKssXRt3lZy
         lIQRKplCaI7acVlJPXCZ+K2FpPvcUrgvC8Pm9hxkajvG9JGa18yvpAs7N6dUlstAPVff
         HtJA==
X-Forwarded-Encrypted: i=1; AJvYcCUfvgsHUrdtzBBag+SfN6YTOPU5KtBcbrf4Za1uC4mctmXSaqDNAzPdFIjpOuz7YXrQG0c6IGqQT02uSA6Gwu/+nZc7P0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4klqEKpplVt4GrPzROclZXMXe3BHpfu2yrLNd6RvrMa2LmTG+
	nV4ycIsKMV0NTYiLZd2YScUtvKK+zmt7kqCJa219jW4Ov2mrruu+EnUjaGN3Uj/k6Q==
X-Gm-Gg: AZuq6aI4EOu39Y98/eSEVbAUhosyqOSxayp4Sydb99rmX8ltN55/kGlHNxFIpu5Yz6Q
	zpciNHhccrT/wihW+LhiQLC7ePH2AaBUZ+Q5GCmNHiNC8mN7ZR+5LMnCXRvvnERkcVqJfvhXdmf
	TnBqgenjow/9V4YnoO+NVp4oXGTro3reoimq/rf4mmNVF/0w8ql3BrNtNcnAXYpnEiSw9VMsNkc
	vBdGAs9u5PND6m1xjDZsTZQEWr2MjCc9XfbJrAct2Gf6h+5ZPMiVmXBjZPKcg29c4Gu+zh7h/ij
	U/Oi1c2MovT0rVM2FINlhHcyNDaDPcDmjZT2m4EFAfE7DKO5OGvzpfTlWt1mCbXyT4cJzGIAGGr
	VTcSIHG1PtN0EmtXtlwK1hguPVkHt4eR2BR3NE65TwMnycqxGFnbSCsZSUMJTMYP+hY+dAEtiNt
	xRMQhUlM8j6fgpHe/HBaYtBYJ7j9fFIakN3xSyM5qhcA==
X-Received: by 2002:a05:600c:3552:b0:480:1c75:407c with SMTP id 5b1f17b1804b1-4830e9240f8mr7668465e9.2.1770141247410;
        Tue, 03 Feb 2026 09:54:07 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:91ac:e27e:d480:1bed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830eb34298sm3753185e9.10.2026.02.03.09.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:54:06 -0800 (PST)
Date: Tue, 3 Feb 2026 18:54:01 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Tingmao Wang <m@maowtm.org>
Cc: Justin Suess <utilityemal77@gmail.com>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Landlock: Implement scope control for pathname
 Unix sockets
Message-ID: <aYI2OQhPMgdMAOiz@google.com>
References: <cover.1767115163.git.m@maowtm.org>
 <20251230.bcae69888454@gnoack.org>
 <dc9b99b6-14a1-45b6-a23f-0b24143dac58@gmail.com>
 <20260109.Ino1ahfef1iu@digikod.net>
 <f07fe41a-96c5-4d3a-9966-35b30b3a71f1@maowtm.org>
 <20260202.uu0oCheexahY@digikod.net>
 <8093547c-ab40-4814-ac9a-8dff6f2a2a90@gmail.com>
 <16129d76-b6d3-4959-b241-dc79a32dd0cd@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16129d76-b6d3-4959-b241-dc79a32dd0cd@maowtm.org>

On Tue, Feb 03, 2026 at 01:26:31AM +0000, Tingmao Wang wrote:
> On 2/2/26 22:03, Justin Suess wrote:
> > Regardless if you merge the patch series now in 7.0 or a later version, I think there is something to be said
> > about having the filesystem and scoped unix access right merged in the same ABI version / merge window.
> > 
> > As you pointed out earlier, the combination of the two flags is much flexible and useful to userspace
> > consumers than one or the other, and if the features were merged separately, there would be an
> > awkward middle ABI where user space consumers may have to make compromises or changes to
> > sandbox between different versions or change application behavior.
> > [...]
> 
> Given that the scope bit and RESOLVE_UNIX access right are in some sense
> part of the same system (they interact in an OR manner, after all), there
> is some positive for having them introduced in the same version, but on
> the other hand, with my above reasoning, I don't think these two
> mechanisms (scope bit and RESOLVE_UNIX access) being in different ABI
> versions would be too much of a problem.  In either case, for applications
> which require access to more "privileged" sockets, when running on a
> kernel without the RESOLVE_UNIX access right support, no pathname socket
> restrictions can be applied (i.e. it won't use the scope bit either, there
> isn't much "compromise" it can make here).  On the other hand, if
> RESOLVE_UNIX is supported, then it knows that the scope bit is also
> supported, and can just use it.

Yes, but that does require additional subtle backwards compatibility
logic in userspace libraries, to implement the "best effort" fallbacks.

Assuming the scoped bit is added in v8 and the FS_RESOLVE_UNIX right in v9,
if a user does this (in Go-landlock syntax):

  // restrict both scoped bit and FS RESOLVE_UNIX right, if possible
  landlock.V9.BestEffort().RestrictPaths(
    landlock.ResolveUnix("/tmp/socket"),  // allow to connect to /tmp/socket
  )

then if the system only supports ABI v8, it will have to clear both
bits so that connections to /tmp/socket work,
even though the scoped bit is technically supported on v8.

**This requires additional logic in client libraries**,
similar to our "refer" semantics (which users often get wrong):

  if (there is a rule that allows connections by path name)
     clear_the_scoped_bit_as_well();
     // even though the path name rule normally only affects a different bit


In contrast, if both the scoped bit and FS_RESOLVE_UNIX were added in
the same ABI version, then if a user does the above call, we are
either equal-or-above that ABI version, in which case it works, or we
are below that ABI version, in which case the two bits already get
cleared from the landlock_ruleset_attr through the existing backwards
compatibility mechanism.

**In my mind, Justin is right that we should ideally introduce these
together.** We have seen users implementing the "Refer" special case
wrongly very often, it will likely happen here too, if we require
extra logic in userspace libraries.


BTW, regarding the implementation: To have *OR* semantics for "within
scope" and "allow-listed path", the implementation will be
non-trivial, and I suspect we won't hit the merge window if we try to
get them both in for 7.0.  But in my mind, a simple UAPI is more
important than trying to make it in time for the next merge window.

(The implementation is difficult because the path-based and
scope-based check currently happen in different LSM hooks, and none of
the two hooks has enough information to make the decision alone.  The
second hook only gets called if the first returns 0.  It'll require
some further discussion to make it work together.)


> Furthermore, an application / Landlock config etc can always opt to not
> use the scope bit at all, if it "knows" all the locations where the
> application's sockets would be placed, and just use RESOLVE_UNIX access
> right (or nothing if it is not supported).
> 
> (The following is a bit of a side note, not terribly relevant if we're
> deciding to go with the patch as is.)
> 
> >> [...]
> >> Another way to put it is that, if FS-based and scope-based controls
> >> interacts in the above proposed way, both mechanisms feel like "poking
> >> holes" in the other.  But as Mickaël said, one can think of the two
> >> mechanisms not as independent controls, but rather as two interfaces for
> >> the same control.  The socket access control is "enabled" if either the
> >> LANDLOCK_ACCESS_FS_RESOLVE_UNIX access is handled, or the scope bit
> >> proposed in this patch is enabled.
> >>
> >> With that said, I can think of some alternative ways that might make this
> >> API look "better" (from a subjective point of view, feedback welcome),
> >> however it does mean more delays, and specifically, these will depend on
> >> LANDLOCK_ACCESS_FS_RESOLVE_UNIX:
> >>
> >> One possibility is to simply always allow a Landlock domain to connect to
> >> its own sockets (in the case where LANDLOCK_ACCESS_FS_RESOLVE_UNIX is
> >> handled, otherwise all sockets are allowed).  This might be reasonable, as
> >> one can only connect to a socket it creates if it has the permission to
> >> create it in the first place, which is already controlled by
> >> LANDLOCK_ACCESS_FS_MAKE_SOCK, so we don't really lose any policy
> >> flexibility here - if for some reason the sandboxer don't want to allow
> >> access to any (pathname) sockets, even the sandboxed app's own ones, it
> >> can just not allow LANDLOCK_ACCESS_FS_MAKE_SOCK anywhere.
> >
> > LANDLOCK_ACCESS_FS_MAKE_SOCK is only required to bind/listen to a
> > socket, not to connect.  I guess you was thinking about
> > LANDLOCK_ACCESS_FS_RESOLVE_UNIX in this case?
> 
> In this "allow same-scope connect unconditionally" proposal, the
> application would still be able to (bind to and) connect to its own
> sockets, even if LANDLOCK_ACCESS_FS_RESOLVE_UNIX is handled and nothing is
> allowed to have LANDLOCK_ACCESS_FS_RESOLVE_UNIX access.  But a sandboxer
> which for whatever reason doesn't want this "allow same scope" default can
> still prevent the use of (pathname) sockets by restricting
> LANDLOCK_ACCESS_FS_MAKE_SOCK, because if an app can't connect to any
> sockets it doesn't own, and can't create any sockets itself either, then
> it effectively can't connect to any sockets at all.
> 
> (Although on second thought, I guess there could be a case where an app
> first creates some socket files before doing landlock_restrict_self(),
> then it might still be able to bind to these even without
> LANDLOCK_ACCESS_FS_MAKE_SOCK?)

FWIW, I also really liked Tingmao's first of the two listed
possibilities in [1], where she proposed to introduce both rights
together.  In my understanding, the arguments we have discussed so far
for that are:

IN FAVOR:

(pro1) Connecting to a UNIX socket in the same scope is always safe,
       and it makes it possible to use named UNIX sockets between the
       processes within a Landlock domains.  (Mickaël convinced me in
       discussion at FOSDEM that this is true.)

       If someone absolutely does not want that, they can restrict
       LANDLOCK_ACCESS_FS_MAKE_SOCK and achieve the same effect (as
       Tingmao said above).

(pro2) The implementation of this is simpler.

       (I attempted to understand how the "or" semantics would be
       implemented, and I found it non-trivial when you try to do it
       for all layers at once. (Kernighan's Law applies, IMHO))

AGAINST:

(con1) It would work differently than the other scoped access rights
       that we already have.

       A speculative feature that could potentially be built with the
       scoped access rights is that we could add a rule to permit IPC
       to other Landlock scopes, e.g. introducing a new rule type
  
         struct landlock_scope_attr {
           __u64 allowed_access;  /* for "scoped" bits */
           /* some way to identify domains */
         }

       so that we could make IPC access to other Landlock domains
       configurable.

       If the scoped bit and the FS RESOLVE_UNIX bit were both
       conflated in RESOLVE_UNIX, it would not be possible to make
       UNIX connections configurable in such a way.

(con2) Consistent behaviour between scoped flags and their
       interactions with other access rights:

       The existing scoped access rights (signal, abstract sockets)
       could hypothetically be extended with a related access right of
       another type. For instance, there could be an access right type

         __u64 handled_signal_number;

       and then you could add a rule to permit the use of certain
       signal numbers.  The interaction between the scoped flags and
       other access rights should work the same.


Constructive Proposal for consideration: Why not both?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Why not do both what Tingmao proposed in [1] **and** reserve the
option to add the matching "scoped flag" later?

  * Introduce LANDLOCK_ACCESS_FS_RESOLVE_UNIX.

    If it is handled, UNIX connections are allowed either:

    (1) if the connection is to a service in the same scope, or
    (2) if the path was allow-listed with a "path beneath" rule.

  * Add LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET later, if needed.


Let's go through the arguments again:

We have observed that it is harmless to allow connections to services
in the same scope (1), and that if users absolutely don't want that,
they can actually prohibit it through LANDLOCK_ACCESS_FS_MAKE_SOCK
(pro1).

(con1): Can we still implement the feature idea where we poke a hole
        to get UNIX-connect() access to other Landlock domains?

  I think the answer is yes.  The implementation strategy is:

    * Add the scoped bit LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
    * The scoped bit can now be used to allow-list connections to
      other Landlock domains.

  For users, just setting the scoped bit on its own does the same as
  handling LANDLOCK_ACCESS_FS_RESOLVE_UNIX.  That way, the kernel-side
  implementation can also stay simple.  The only reason why the scoped
  bit is needed is because it makes it possible to allow-list
  connections to other Landlock domains, but at the same time, it is
  safe if libraries set the scoped bit once it exists, as it does not
  have any bad runtime impact either.

(con2): Consistency: Do all the scoped flags interact with their
        corresponding access rights in the same way?

  The other scope flags do not have corresponding access rights, so
  far.

  If we were to add corresponding access rights for the other scope
  flags, I would argue that we could apply a consistent logic there,
  because IPC access within the same scope is always safe:

  - A hypothetical access right type for "signal numbers" would only
    restrict signals that go beyond the current scope.

  - A hypothetical access right type for "abstract UNIX domain socket
    names" would only restrict connections to abstract UNIX domain
    servers that go beyond the current scope.

  I can not come up with a scenario where this doesn't work.


In conclusion, I think the approach has significant upsides:

  * Simpler UAPI: Users only have one access bit to deal with, in the
    near future.  Once we do add a scope flag for UNIX connections, it
    does not interact in a surprising way with the corresponding FS
    access right, because with either of these, scoped access is
    allowed.

    If users absolutely need to restrict scoped access, they can
    restrict LANDLOCK_ACCESS_FS_MAKE_SOCK.  It is a slightly obscure
    API, but in line with the "make easy things easy, make hard things
    possible" API philosophy.  And needing this should be the
    exception rather than the norm, after all.

  * Consistent behaviour between scoped flags and regular access
    rights, also for speculative access rights affecting the existing
    scoped flags for signals and abstract UNIX domain sockets.

I know this was a slightly long mail, but I thought long and tried to
be structured.  Please let me know what you think.

—Günther


[1] https://lore.kernel.org/all/f07fe41a-96c5-4d3a-9966-35b30b3a71f1@maowtm.org/
