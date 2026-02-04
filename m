Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AD841B359
	for <linux-security-module@vger.kernel.org>; Wed,  4 Feb 2026 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227884; cv=none; b=GBud9pKntW/vFc/H8WV1Wczqi4yxEQyoZEYYb/w52EgQCPNCItWXlLWd7EFOcAoqVJhcTtbZsjUreeBZapipmhSxr331o77I5OCcEtINzNvMahg58eXsdXbLpqiTG1nzlX/1xu1h/0gdfVERIYrnBsggtSTy3CW64wxul2NpM7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227884; c=relaxed/simple;
	bh=PY2Msu5AvPEAZlawYwO5V2fwDfSBtKKbMbnKkGOaLps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuvaq+mSksynX9NRJ7wRicb2LQX5IVco32iumKhstjyOh3kLmW3K5Le/RizH634f35zwBHH0TGtnqFkJ2e9mGz9kwUEQZE+Epf3REIoeQ9V7BTLGHESjO8SwuRT4wCoXq9aURtt3TzbsAqopp/haTKESHY8yDh0xiHC/xFY6aBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=gmpZ4AQ1; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="gmpZ4AQ1"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f5nfy0ccRzMKy;
	Wed,  4 Feb 2026 18:39:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1770226793;
	bh=Z+DsZNmBmEIgoPXKpBIN0lcU+dMPZAVbZY3KpfwfUjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gmpZ4AQ1c1W+MWXwYbhNGo0lh6v6kusz7MoCEC8IvbRrPMX7GZc8m+n90lUheT1pp
	 Z03skJAH45m7nHYV0xSBPdL5oRip44tcQKH/pyRggRjdu0FQLsm4MmtZovyZh8nlcn
	 J2yQAu64mtkBsCQBitNimECsQg+8OWcvUGOa2Jko=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4f5nfx2bTLzp7k;
	Wed,  4 Feb 2026 18:39:53 +0100 (CET)
Date: Wed, 4 Feb 2026 18:39:51 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: Justin Suess <utilityemal77@gmail.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, Demi Marie Obenour <demiobenour@gmail.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, linux-security-module@vger.kernel.org, 
	Matthieu Buffet <matthieu@buffet.re>
Subject: Re: [PATCH v2 0/6] Landlock: Implement scope control for pathname
 Unix sockets
Message-ID: <20260203.iuyaiGaed3Ai@digikod.net>
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
X-Infomaniak-Routing: alpha

On Tue, Feb 03, 2026 at 01:26:31AM +0000, Tingmao Wang wrote:
> Hi Mickaël,
> 
> Thanks for the feedback and explanations :)
> 
> On 2/2/26 20:32, Mickaël Salaün wrote:
> > On Sat, Jan 31, 2026 at 05:41:14PM +0000, Tingmao Wang wrote:
> >> [...]
> >> What do folks think?
> >
> > I'd like to keep a clean API, with a "scoped" field handling IPC
> > scoping, and an "handled_access_fs" field handling filesystem-related
> > accesses.
> >
> > One thing to keep in mind is that we could add a new kind of "handled"
> > field that would enable to add rules identifying e.g. processes,
> > cgroups, or Landlock domains, and that could be used to add exceptions
> > to the current scopes.  This means that we need to have a generic way to
> > handle this case.
> >
> > What is the issue with two complementary interfaces (scope and access)
> > used to express a policy about connecting to UNIX sockets?  We just need
> > to make sure that scopes and handled_access_fs dealing with UNIX sockets
> > are like binary OR: if the scope is set, then the domain can communicate
> > with peers which are in the same domain, and if the handled_access_fs
> > right is set, then the domain can only communicate with matching sockets
> > (OR scoped ones if the scope is set).
> 
> Right, I see what you're saying, especially with the "additional access
> rules for other scopes" example, and I think I'm happy with this.  I guess
> my attempt at trying to make the API more "elegant" would introduce
> complexity and also create future inconsistency if other existing scope
> bits are combined with handled_access rules.
> 
> > [...]
> > Anyway, we need to decide if this should be merged in Linux 7.0 (next
> > week) or not.  I'd prefer to merge it now because I think it works well
> > and it's not a new concept wrt the abstract UNIX socket scoping.
> > However, if there are any concern, I'd like to hear them now and I can
> > delay this merge if needed.  This patch series still need a new version
> > but that should only be about cosmetic fixes.  WDYT?
> 
> I ended up being pretty busy today but I can definitely send the next
> version tomorrow with your formatting changes and comments.  I'm happy
> with it going into the next merge window if you are.  Justin raises a
> point about having these two mechanisms in the same ABI version - see
> below for consideration.
> 
> >> [...]
> >
> > My main concern is about user space libraries and users that may want to
> > have conditional enforcement for compatibility reasons e.g., only
> > enforce LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET (let's say ABI v8) if it can
> > also set LANDLOCK_ACCESS_FS_RESOLVE_UNIX (let's say ABI v9).  I see two
> > ways to deal with this case (if needed):
> > - add synthetic access right to easily let users "combine" two access
> >   rigths or none;
> > - have a more generic way to AND and OR access rights.  I'm thinking
> >   about updating the Rust library in this direction.
> 
> I'm not sure I fully understand the complexity here, but I think, assuming
> these land in separate kernel versions, it will have to be that if both
> the scope bit and LANDLOCK_ACCESS_FS_RESOLVE_UNIX is requested (maybe if
> the user actually adds rules containing RESOLVE_UNIX access), but only the
> scope bit is supported, then it will have to skip enforcing pathname UNIX
> socket restrictions altogether by skipping both the scope bit and the
> RESOLVE_UNIX access (if in best effort mode), or fail (if in hard
> requirement mode).

Yeah, this should be OK in theory but it might be confusing to
developers.

> 
> I don't immediately see how further customization ability (e.g. synthetic
> access rights or other AND/OR combination) could be used - if an app needs
> access to a privileged socket and can't pre-open it before
> landlock_restrict_self(), then the only realistic choice is to not use the
> scope bits if LANDLOCK_ACCESS_FS_RESOLVE_UNIX is not supported.

Yes, that's the main idea.  The synthetic access right would just be
useful to avoid doing this check each time but let the library do it
instead.  Anyway, that's mostly a (Rust) lib thing.

> 
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

Yes

> 
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

That's good to keep in mind.  There might be weird cases but developers
should be encouraged to set all the scopes bits and then potentially
allow specific sockets with FS_RESOLVE_UNIX.
