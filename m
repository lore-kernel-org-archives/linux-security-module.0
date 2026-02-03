Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD917223705
	for <linux-security-module@vger.kernel.org>; Tue,  3 Feb 2026 21:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770155598; cv=none; b=akFf4bJ82RDDJygHm3hhmRqnFXwySD83/8ULZ9LX7n7UPcrNLsXm1xi1rHILFDs8nGq72RLDyy7HlXfep8DzHrecTWoBVZ3ED3n4W5fG62jXXNw/qLv1QUmcuNs33dglBnwHGZAzPzNtSAk/Sj7thtfoHgrONZUKehMotzyY3AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770155598; c=relaxed/simple;
	bh=ObH2eHOhGZ1P70EJYpOZWJOU+uybmPPNly3BX41Z61M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q40dneSo25zl/SrGYIGQZ2a7pnlcEdwN5WCAXW0iN74W+Q/FzmzkxiM3IHwrdVubMC+VKlJe/nWoqZ/ZQdL4II5iBUkNlgsZV420s4v4p7WVWDJHoSIVFd3u7HmSVYEzXDySLN5Uo+V7hZqrTeHorDC8Y7YqXZLdDVex+cTd56I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=t7ruY1ez; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RYNu7tsh; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="t7ruY1ez";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RYNu7tsh"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D2C79EC008D;
	Tue,  3 Feb 2026 16:53:14 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 03 Feb 2026 16:53:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770155594;
	 x=1770241994; bh=3Jwn+fqy/KjDKQgiUhEYTYkLAUBAIbKjoyA1Mq4Y+Fw=; b=
	t7ruY1ezObbVUtuIz5gLSU1b5tvLHybEWavPUt2pGcHPNwI/INQbKsPMIsHxxnF2
	N0G7aC9R+U5RdcSEoDtidip0ys1lWi4Qnv3kiwRktvzqN/vxt/NBXktAfjT0kABl
	rnr8mIqxvnKbbsdzbG10VCNHVXmYsmEW0Lqu0HXG9obVNIOHtUZlygf4Jzs8e3bg
	nlG/5KoZakkCVEkw9rCXfRzjLd9QIZmcGEcFEkTpIERW8bh1tvyGK2U94HShF02N
	EkUxQKPryvDtyJhDMTUuAyWCSw0hj0gXg5wp7tHD93+lPAK6w79bhvqB635DumFn
	KPx7rRNN+SkX3thf+U6MAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770155594; x=
	1770241994; bh=3Jwn+fqy/KjDKQgiUhEYTYkLAUBAIbKjoyA1Mq4Y+Fw=; b=R
	YNu7tshXiaEDLRrjt6CpXNk67DPDLl72KBjP/A4ogqMcRr5dl7p0P25VrsaNv2RQ
	QF8JuP1UEPnEE7YwtC3wJofALFavcq+f+CccfS1vCl4+Ma36QTrAlms2uVlwoUII
	mzteinJoYvFjh9mkgdrDvgRgKXWk9JikxdnspHKnRagw17R8irmBkTyUGv02OwRV
	Ghdp27sNKFWMKeK5RjdMphqFE28m0Qpjpi6VZ8hG0x7A2xX6B6QvYUKwuTjf/8HP
	f2nPfy6HTwdVssyhNXD7KoGkAnNSzC9/474nl9RczbF15gKPTtXpNE0JphHdrepV
	hFlK0RyD27G7UQf/PQEkg==
X-ME-Sender: <xms:Sm6Cab965mlOXXtOIlRGjZa0hWxYFqKChpyY8xeOOpSs2Z1NnWCWPA>
    <xme:Sm6CaaS9MSZ4nOnyxFcbAsmOZaOm-rPHuVWmXrgQsYwJ86rcDiLJLCdT1-WLOzdHp
    I9DVQNFaees8sJN1YWxfpJcmfMQavq91owQ_V8MLbPIRoP8hyI-m7w>
X-ME-Received: <xmr:Sm6Cacrr3IV0iUiPLpksGoCL59Dz9D78j2ta4_APlMIIyP0IaQVUBfiff-iujFDkYMomudfX5eKlg4o5Cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeduudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepge
    ekffegffeuhfefiedtjeetueefleelfedugeekveffvddvjedtvddviefhgfejnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvg
    drtghomhdprhgtphhtthhopehuthhilhhithihvghmrghljeejsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehgnhhorg
    gtkheftddttdesghhmrghilhdrtghomhdprhgtphhtthhopeguvghmihhosggvnhhouhhr
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohephhhisegrlhihshhsrgdrihhspdhrtghpth
    htohepjhgrnhhnhhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepfhgrhhhimhhithgr
    hhgvrhgrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqshgvtghurhhith
    ihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Sm6CaXmWrBKPYoWQYhzRDKiw8iw9Ccz6wc4cIgk-ifV7YxJUtuxUFw>
    <xmx:Sm6CaVf3uCnABpeJzVO-bFMRo64HS1a4iimFuGRfOGVoHoU9jUpsKA>
    <xmx:Sm6CaTowz3kTc6ZyTTv50NpEBPlP6O358uf3pbJmTi0fheqanYo3Fw>
    <xmx:Sm6CafOgCo2aBLGqtox2Hch2vzrYGxbtMn6fVuc7UmlnG4c9kQo4-g>
    <xmx:Sm6CadIx4nUeciMmjidms0AiEZe7uY6xIh47a_n9jm0y3aXlgSTjmVoN>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 16:53:12 -0500 (EST)
Message-ID: <e6b6b069-384c-4c45-a56b-fa54b26bc72a@maowtm.org>
Date: Tue, 3 Feb 2026 21:53:11 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Landlock: Implement scope control for pathname
 Unix sockets
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Justin Suess <utilityemal77@gmail.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>,
 Jann Horn <jannh@google.com>, Tahera Fahimi <fahimitahera@gmail.com>,
 linux-security-module@vger.kernel.org
References: <cover.1767115163.git.m@maowtm.org>
 <20251230.bcae69888454@gnoack.org>
 <dc9b99b6-14a1-45b6-a23f-0b24143dac58@gmail.com>
 <20260109.Ino1ahfef1iu@digikod.net>
 <f07fe41a-96c5-4d3a-9966-35b30b3a71f1@maowtm.org>
 <20260202.uu0oCheexahY@digikod.net>
 <8093547c-ab40-4814-ac9a-8dff6f2a2a90@gmail.com>
 <16129d76-b6d3-4959-b241-dc79a32dd0cd@maowtm.org>
 <aYI2OQhPMgdMAOiz@google.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <aYI2OQhPMgdMAOiz@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/3/26 17:54, Günther Noack wrote:
> On Tue, Feb 03, 2026 at 01:26:31AM +0000, Tingmao Wang wrote:
>> On 2/2/26 22:03, Justin Suess wrote:
>>> Regardless if you merge the patch series now in 7.0 or a later version, I think there is something to be said
>>> about having the filesystem and scoped unix access right merged in the same ABI version / merge window.
>>>
>>> As you pointed out earlier, the combination of the two flags is much flexible and useful to userspace
>>> consumers than one or the other, and if the features were merged separately, there would be an
>>> awkward middle ABI where user space consumers may have to make compromises or changes to
>>> sandbox between different versions or change application behavior.
>>> [...]
>>
>> Given that the scope bit and RESOLVE_UNIX access right are in some sense
>> part of the same system (they interact in an OR manner, after all), there
>> is some positive for having them introduced in the same version, but on
>> the other hand, with my above reasoning, I don't think these two
>> mechanisms (scope bit and RESOLVE_UNIX access) being in different ABI
>> versions would be too much of a problem.  In either case, for applications
>> which require access to more "privileged" sockets, when running on a
>> kernel without the RESOLVE_UNIX access right support, no pathname socket
>> restrictions can be applied (i.e. it won't use the scope bit either, there
>> isn't much "compromise" it can make here).  On the other hand, if
>> RESOLVE_UNIX is supported, then it knows that the scope bit is also
>> supported, and can just use it.
>
> Yes, but that does require additional subtle backwards compatibility
> logic in userspace libraries, to implement the "best effort" fallbacks.
>
> Assuming the scoped bit is added in v8 and the FS_RESOLVE_UNIX right in v9,
> if a user does this (in Go-landlock syntax):
>
>   // restrict both scoped bit and FS RESOLVE_UNIX right, if possible
>   landlock.V9.BestEffort().RestrictPaths(
>     landlock.ResolveUnix("/tmp/socket"),  // allow to connect to /tmp/socket
>   )
>
> then if the system only supports ABI v8, it will have to clear both
> bits so that connections to /tmp/socket work,
> even though the scoped bit is technically supported on v8.
>
> **This requires additional logic in client libraries**,
> similar to our "refer" semantics (which users often get wrong):
>
>   if (there is a rule that allows connections by path name)
>      clear_the_scoped_bit_as_well();
>      // even though the path name rule normally only affects a different bit
>
>
> In contrast, if both the scoped bit and FS_RESOLVE_UNIX were added in
> the same ABI version, then if a user does the above call, we are
> either equal-or-above that ABI version, in which case it works, or we
> are below that ABI version, in which case the two bits already get
> cleared from the landlock_ruleset_attr through the existing backwards
> compatibility mechanism.
>
> **In my mind, Justin is right that we should ideally introduce these
> together.** We have seen users implementing the "Refer" special case
> wrongly very often, it will likely happen here too, if we require
> extra logic in userspace libraries.

Ok, this makes sense to me.  I will send the patch's next version as-is
anyway for completeness since it's basically done but I recognize that we
might change the plan based on this discussion.

>
>
> BTW, regarding the implementation: To have *OR* semantics for "within
> scope" and "allow-listed path", the implementation will be
> non-trivial, and I suspect we won't hit the merge window if we try to
> get them both in for 7.0.  But in my mind, a simple UAPI is more
> important than trying to make it in time for the next merge window.
>
> (The implementation is difficult because the path-based and
> scope-based check currently happen in different LSM hooks, and none of
> the two hooks has enough information to make the decision alone.  The
> second hook only gets called if the first returns 0.  It'll require
> some further discussion to make it work together.)

Right.  In that case, would it make sense to pass sk into the new
security_unix_find() hook, perhaps with the new argument named `struct
sock *other`?  Then we can use this hook for the scope check as well by
using landlock_cred(other->sk_socket->file->f_cred)->domain etc.

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 227467236930..db9d279b3883 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1223,24 +1223,24 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 
 	err = -ECONNREFUSED;
 	inode = d_backing_inode(path.dentry);
 	if (!S_ISSOCK(inode->i_mode))
 		goto path_put;
 
+	err = -ECONNREFUSED;
+	sk = unix_find_socket_byinode(inode);
+	if (!sk)
+		goto path_put;
+
 	/*
 	 * We call the hook because we know that the inode is a socket
 	 * and we hold a valid reference to it via the path.
 	 */
-	err = security_unix_find(&path, type, flags);
+	err = security_unix_find(&path, sk, flags);
 	if (err)
-		goto path_put;
-
-	err = -ECONNREFUSED;
-	sk = unix_find_socket_byinode(inode);
-	if (!sk)
-		goto path_put;
+		goto sock_put;
 
 	err = -EPROTOTYPE;
 	if (sk->sk_type == type)
 		touch_atime(&path);
 	else
 		goto sock_put;

By doing this we won't even need to pass `type` separately anymore.  The
only change would be that now one can determine if a socket is bound or
not even without being allowed RESOLVE_UNIX access.  I'm not sure how much
of an issue this is, but we could also call the hook anyway with a NULL in
place of the new argument, if unix_find_socket_byinode() fails.  Other
LSMs can then decide what to do in that case (either return -ECONNREFUSED
or -EPERM).

>
>
>> Furthermore, an application / Landlock config etc can always opt to not
>> use the scope bit at all, if it "knows" all the locations where the
>> application's sockets would be placed, and just use RESOLVE_UNIX access
>> right (or nothing if it is not supported).
>>
>> (The following is a bit of a side note, not terribly relevant if we're
>> deciding to go with the patch as is.)
>>
>>>> [...]
>>>> Another way to put it is that, if FS-based and scope-based controls
>>>> interacts in the above proposed way, both mechanisms feel like "poking
>>>> holes" in the other.  But as Mickaël said, one can think of the two
>>>> mechanisms not as independent controls, but rather as two interfaces for
>>>> the same control.  The socket access control is "enabled" if either the
>>>> LANDLOCK_ACCESS_FS_RESOLVE_UNIX access is handled, or the scope bit
>>>> proposed in this patch is enabled.
>>>>
>>>> With that said, I can think of some alternative ways that might make this
>>>> API look "better" (from a subjective point of view, feedback welcome),
>>>> however it does mean more delays, and specifically, these will depend on
>>>> LANDLOCK_ACCESS_FS_RESOLVE_UNIX:
>>>>
>>>> One possibility is to simply always allow a Landlock domain to connect to
>>>> its own sockets (in the case where LANDLOCK_ACCESS_FS_RESOLVE_UNIX is
>>>> handled, otherwise all sockets are allowed).  This might be reasonable, as
>>>> one can only connect to a socket it creates if it has the permission to
>>>> create it in the first place, which is already controlled by
>>>> LANDLOCK_ACCESS_FS_MAKE_SOCK, so we don't really lose any policy
>>>> flexibility here - if for some reason the sandboxer don't want to allow
>>>> access to any (pathname) sockets, even the sandboxed app's own ones, it
>>>> can just not allow LANDLOCK_ACCESS_FS_MAKE_SOCK anywhere.
>>>
>>> LANDLOCK_ACCESS_FS_MAKE_SOCK is only required to bind/listen to a
>>> socket, not to connect.  I guess you was thinking about
>>> LANDLOCK_ACCESS_FS_RESOLVE_UNIX in this case?
>>
>> In this "allow same-scope connect unconditionally" proposal, the
>> application would still be able to (bind to and) connect to its own
>> sockets, even if LANDLOCK_ACCESS_FS_RESOLVE_UNIX is handled and nothing is
>> allowed to have LANDLOCK_ACCESS_FS_RESOLVE_UNIX access.  But a sandboxer
>> which for whatever reason doesn't want this "allow same scope" default can
>> still prevent the use of (pathname) sockets by restricting
>> LANDLOCK_ACCESS_FS_MAKE_SOCK, because if an app can't connect to any
>> sockets it doesn't own, and can't create any sockets itself either, then
>> it effectively can't connect to any sockets at all.
>>
>> (Although on second thought, I guess there could be a case where an app
>> first creates some socket files before doing landlock_restrict_self(),
>> then it might still be able to bind to these even without
>> LANDLOCK_ACCESS_FS_MAKE_SOCK?)
>
> FWIW, I also really liked Tingmao's first of the two listed
> possibilities in [1], where she proposed to introduce both rights
> together.  In my understanding, the arguments we have discussed so far
> for that are:
>
> IN FAVOR:
>
> (pro1) Connecting to a UNIX socket in the same scope is always safe,
>        and it makes it possible to use named UNIX sockets between the
>        processes within a Landlock domains.  (Mickaël convinced me in
>        discussion at FOSDEM that this is true.)
>
>        If someone absolutely does not want that, they can restrict
>        LANDLOCK_ACCESS_FS_MAKE_SOCK and achieve the same effect (as
>        Tingmao said above).
>
> (pro2) The implementation of this is simpler.
>
>        (I attempted to understand how the "or" semantics would be
>        implemented, and I found it non-trivial when you try to do it
>        for all layers at once. (Kernighan's Law applies, IMHO))

I think the logic would basically be:

1. if any layers deny the access due to handled RESOLVE_UNIX but does not
have the scope bit set, then we will deny rightaway, without calling
domain_is_scoped().

2. Call domain_is_scoped() with a bitmask of "rules_covered" layers where
there are RESOLVE_UNIX rules covering the socket being accessed, and
essentially ignore those layers in the scope violation check.

I definitely agree that it is tricky, but making same-scope access be
allowed (i.e. the suggested idea above) would only get rid of step 1,
which I think is the "simpler" bit.  The extra logic in step 2 is still
needed. 

I definitely agree with pro1 tho.

>
> AGAINST:
>
> (con1) It would work differently than the other scoped access rights
>        that we already have.
>
>        A speculative feature that could potentially be built with the
>        scoped access rights is that we could add a rule to permit IPC
>        to other Landlock scopes, e.g. introducing a new rule type
>
>          struct landlock_scope_attr {
>            __u64 allowed_access;  /* for "scoped" bits */
>            /* some way to identify domains */
>          }
>
>        so that we could make IPC access to other Landlock domains
>        configurable.
>
>        If the scoped bit and the FS RESOLVE_UNIX bit were both
>        conflated in RESOLVE_UNIX, it would not be possible to make
>        UNIX connections configurable in such a way.

This exact API would no longer work, but if we give up the equivalence
between scope bits and the landlock_scope_attr struct, then we can do
something like:

struct landlock_scope_attr {
    __u64 ptrace:1;  /* Note that this is not a (user controllable) scope bit! */
    __u64 abstract_unix_socket:1;
    __u64 pathname_unix_socket:1;
    /* ... */

    __u64 allowed_signals;

    /*
     * some way to identify domains, maybe we could use the audit domain
     * ID, with 0 denoting "allow access to non-Landlocked processes?
     */
}

>
> (con2) Consistent behaviour between scoped flags and their
>        interactions with other access rights:
>
>        The existing scoped access rights (signal, abstract sockets)
>        could hypothetically be extended with a related access right of
>        another type. For instance, there could be an access right type
>
>          __u64 handled_signal_number;
>
>        and then you could add a rule to permit the use of certain
>        signal numbers.  The interaction between the scoped flags and
>        other access rights should work the same.
>
>
> Constructive Proposal for consideration: Why not both?
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I will think about the following a bit more but I'm afraid that I feel
like it might get slightly confusing.  With this, the only reason for
having LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET is for API consistency when we
later enable allowing access to other domains (if I understood correctly),
in which case I personally feel like the suggestion on landlock_scope_attr
above, where we essentially accept that it is decoupled with the scope
bits in the ruleset, might be simpler...?

>
> Why not do both what Tingmao proposed in [1] **and** reserve the
> option to add the matching "scoped flag" later?
>
>   * Introduce LANDLOCK_ACCESS_FS_RESOLVE_UNIX.
>
>     If it is handled, UNIX connections are allowed either:
>
>     (1) if the connection is to a service in the same scope, or
>     (2) if the path was allow-listed with a "path beneath" rule.
>
>   * Add LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET later, if needed.
>
>
> Let's go through the arguments again:
>
> We have observed that it is harmless to allow connections to services
> in the same scope (1), and that if users absolutely don't want that,
> they can actually prohibit it through LANDLOCK_ACCESS_FS_MAKE_SOCK
> (pro1).
>
> (con1): Can we still implement the feature idea where we poke a hole
>         to get UNIX-connect() access to other Landlock domains?
>
>   I think the answer is yes.  The implementation strategy is:
>
>     * Add the scoped bit LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
>     * The scoped bit can now be used to allow-list connections to
>       other Landlock domains.
>
>   For users, just setting the scoped bit on its own does the same as
>   handling LANDLOCK_ACCESS_FS_RESOLVE_UNIX.  That way, the kernel-side
>   implementation can also stay simple.  The only reason why the scoped
>   bit is needed is because it makes it possible to allow-list
>   connections to other Landlock domains, but at the same time, it is
>   safe if libraries set the scoped bit once it exists, as it does not
>   have any bad runtime impact either.
>
> (con2): Consistency: Do all the scoped flags interact with their
>         corresponding access rights in the same way?
>
>   The other scope flags do not have corresponding access rights, so
>   far.
>
>   If we were to add corresponding access rights for the other scope
>   flags, I would argue that we could apply a consistent logic there,
>   because IPC access within the same scope is always safe:
>
>   - A hypothetical access right type for "signal numbers" would only
>     restrict signals that go beyond the current scope.
>
>   - A hypothetical access right type for "abstract UNIX domain socket
>     names" would only restrict connections to abstract UNIX domain
>     servers that go beyond the current scope.
>
>   I can not come up with a scenario where this doesn't work.
>
>
> In conclusion, I think the approach has significant upsides:
>
>   * Simpler UAPI: Users only have one access bit to deal with, in the
>     near future.  Once we do add a scope flag for UNIX connections, it
>     does not interact in a surprising way with the corresponding FS
>     access right, because with either of these, scoped access is
>     allowed.
>
>     If users absolutely need to restrict scoped access, they can
>     restrict LANDLOCK_ACCESS_FS_MAKE_SOCK.  It is a slightly obscure
>     API, but in line with the "make easy things easy, make hard things
>     possible" API philosophy.  And needing this should be the
>     exception rather than the norm, after all.
>
>   * Consistent behaviour between scoped flags and regular access
>     rights, also for speculative access rights affecting the existing
>     scoped flags for signals and abstract UNIX domain sockets.
>
> I know this was a slightly long mail, but I thought long and tried to
> be structured.  Please let me know what you think.
>
> —Günther
>
>
> [1] https://lore.kernel.org/all/f07fe41a-96c5-4d3a-9966-35b30b3a71f1@maowtm.org/
