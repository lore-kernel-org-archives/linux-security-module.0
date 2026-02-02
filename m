Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0764429D29F
	for <linux-security-module@vger.kernel.org>; Mon,  2 Feb 2026 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064356; cv=none; b=Sa1J5hQuDgy1RoyW6oq3f1mYaWkNU3wWErQaskuXQerIwzlRqjXpNdea4qi0t2pnDABbGJnRZ6fO625KDn8NViluc0uLUOcSM+RDIvkB1BhjvLqy+yyhPgJgQLQKz7u+nYaSg6IwESFL6BhIUy9032N2w22SC/Y4gTa0SkBpPlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064356; c=relaxed/simple;
	bh=Ou8FFAwz++jVey2rRikMIVtSjdtMZRCeA7c3vLG3Td4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWoS6WzgcS+Dbv9hQM9+QTbViXWY+5mzOPDTTb2MIWFejbDROgLghPBy9JKE+cPVjFx3N77u3YAbxY1su0sfgOB/Jw9HvKXWaDMY+OyjzNlhyggFwL5egB0Duhn6tUmYZg5y3/u7fP0m4gULpcsHY8p8aicAvlFXuFuXv7e+OcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ffApdBtS; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ffApdBtS"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f4dZv0yYqzlFq;
	Mon,  2 Feb 2026 21:32:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1770064342;
	bh=NyGvaM19lFFYFcY1Ji0ArKPWcrN+Sbqy3XUgJ2Lnmis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ffApdBtStbqiQQLn1g/IB+uJG3aTtyLDaem66VAqXMFBZkI00FRsnBIkLVTk074zk
	 Ltm3zZUWN+g+iuimRxOBlgS6oMg6dAeoxA6xTfJAo9cctESNlWe/g1wcqVKWNztNR5
	 mRrt9Bvj4V2syhe3RaFyLz87bDd5sqOj5MPtij+A=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4f4dZt3Jv8zGkM;
	Mon,  2 Feb 2026 21:32:22 +0100 (CET)
Date: Mon, 2 Feb 2026 21:32:21 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	Demi Marie Obenour <demiobenour@gmail.com>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Justin Suess <utilityemal77@gmail.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Landlock: Implement scope control for pathname
 Unix sockets
Message-ID: <20260202.uu0oCheexahY@digikod.net>
References: <cover.1767115163.git.m@maowtm.org>
 <20251230.bcae69888454@gnoack.org>
 <dc9b99b6-14a1-45b6-a23f-0b24143dac58@gmail.com>
 <20260109.Ino1ahfef1iu@digikod.net>
 <f07fe41a-96c5-4d3a-9966-35b30b3a71f1@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f07fe41a-96c5-4d3a-9966-35b30b3a71f1@maowtm.org>
X-Infomaniak-Routing: alpha

On Sat, Jan 31, 2026 at 05:41:14PM +0000, Tingmao Wang wrote:
> On 1/9/26 12:01, Mickaël Salaün wrote:
> > On Wed, Dec 31, 2025 at 11:54:27AM -0500, Demi Marie Obenour wrote:
> >> On 12/30/25 18:16, Günther Noack wrote:
> >>> [...]
> >>> On Tue, Dec 30, 2025 at 05:20:18PM +0000, Tingmao Wang wrote:
> >>>> [...]
> >>>
> >>> What is unclear to me from the examples and the description is: Why is
> >>> the boundary between allowed and denied connection targets drawn at
> >>> the border of the Landlock domain (the "scope") and why don't we solve
> >>> this with the file-system-based approach described in [1]?
> >>>
> >>> **Do we have existing use cases where a service is both offered and
> >>> connected to all from within the same Landlock domain, and where the
> >>> process enforcing the policy does not control the child process enough
> >>> so that it would be possible to allow-list it with a
> >>> LANDLOCK_ACCESS_FS_CONNECT_UNIX rule?**
> > 
> > Yes, with the sandboxer use case.  It's similar to a container that
> > doesn't know all programs that could be run in it.  We should be able to
> > create sandboxes that don't assume (nor restrict) internal IPCs (or any
> > kind of direct process I/O).
> > 
> > Landlock should make it possible to scope any kind of IPC.  It's a
> > mental model which is easy to understand and that should be enforced by
> > default.  Of course, we need some ways to add exceptions to this
> > deny-by-default policy, and that's why we also need the FS-based control
> > mechanism.
> > 
> >>>
> >>> If we do not have such a use case, it seems that the planned FS-based
> >>> control mechanism from [1] would do the same job?  Long term, we might
> >>> be better off if we only have only one control -- as we have discussed
> >>> in [2], having two of these might mean that they interact in
> >>> unconventional and possibly confusing ways.
> >>
> >> I agree with this.
> > 
> > Both approaches are complementary/orthogonal and make sense long term
> > too.  This might be the first time we can restrict the same operations,
> > but I'm pretty sure it will not be the last, and it's OK.  Handled FS
> > access and scoped restrictions are two ways to describe a part of the
> > security policy.  Having different ways makes the interface much simpler
> > than a generic one that would have to take into account all potential
> > future access controls.
> > 
> > One thing to keep in mind is that UAPI doesn't have to map 1:1 to the
> > kernel implementation, but the UAPI is stable and future proof, whereas
> > the kernel implementation can change a lot.
> > 
> > The ruleset's handled fields serve two purposes: define what should be
> > denied by default, and define which type of rules are valid
> > (compatibility).  The ruleset's scoped field serve similar purposes but
> > it also implies implicit rules (i.e. communications with processes
> > inside the sandbox are allowed).  Without the soped field, we would have
> > to create dedicated handled field per type (i.e. scope's bit) and
> > dedicated rule type for the related handled field, which would make the
> > interface more generic but also more complex, for something which is not
> > needed.
> > 
> > In a nutshell, in the case of the FS-based and scope-based unix socket
> > control, we should see one kind of restrictions (e.g. connect to unix
> > socket), which can accept two types of rules: (explicit) file path, or
> > (implicit) peer's scope.  Access should be granted as long as a rule
> > matches, whatever its type.
> > 
> > This rationale should be explained in a commit message.
> > 
> >>
> >>> Apart from that, there are some other weaker hints that make me
> >>> slightly critical of this patch set:
> >>>
> >>> * We discussed the idea that a FS-based path_beneath rule would act
> >>>   implicitly also as an exception for
> >>>   LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET, in [2] - one possible way to
> >>>   interpret this is that the gravity of the system's logic pulls us
> >>>   back towards a FS-based control, and we would have to swim less
> >>>   against the stream if we integrated the Unix connect() control in
> >>>   that way?
> 
> While I do think being able to control UNIX socket access via domain
> scoping is useful (after all, it is an additional bit of information /
> relationship that "normal" filesystem objects doesn't have, and
> applications using Landlock might find it useful to control access based
> on this extra information, either to simplify the policy, or because a
> generic sandboxer can't come up with a pre-determined list of UNIX socket
> fs rules, e.g. for applications which places socket in hard-coded "/tmp"),
> I do share the worry about how this might get confusing from an API
> perspective, as discussed in my GitHub comment [1].
> 
> Another way to put it is that, if FS-based and scope-based controls
> interacts in the above proposed way, both mechanisms feel like "poking
> holes" in the other.  But as Mickaël said, one can think of the two
> mechanisms not as independent controls, but rather as two interfaces for
> the same control.  The socket access control is "enabled" if either the
> LANDLOCK_ACCESS_FS_RESOLVE_UNIX access is handled, or the scope bit
> proposed in this patch is enabled.
> 
> With that said, I can think of some alternative ways that might make this
> API look "better" (from a subjective point of view, feedback welcome),
> however it does mean more delays, and specifically, these will depend on
> LANDLOCK_ACCESS_FS_RESOLVE_UNIX:
> 
> One possibility is to simply always allow a Landlock domain to connect to
> its own sockets (in the case where LANDLOCK_ACCESS_FS_RESOLVE_UNIX is
> handled, otherwise all sockets are allowed).  This might be reasonable, as
> one can only connect to a socket it creates if it has the permission to
> create it in the first place, which is already controlled by
> LANDLOCK_ACCESS_FS_MAKE_SOCK, so we don't really lose any policy
> flexibility here - if for some reason the sandboxer don't want to allow
> access to any (pathname) sockets, even the sandboxed app's own ones, it
> can just not allow LANDLOCK_ACCESS_FS_MAKE_SOCK anywhere.

LANDLOCK_ACCESS_FS_MAKE_SOCK is only required to bind/listen to a
socket, not to connect.  I guess you was thinking about
LANDLOCK_ACCESS_FS_RESOLVE_UNIX in this case?

> 
> Another possibility is to have this scope control as part of the
> LANDLOCK_ACCESS_FS_RESOLVE_UNIX rule itself, rather than as a separate
> scope bit, via introducing a "rule flag" (which is a new mechanism
> proposed in [2]) which I will tentatively call
> (LANDLOCK_ADD_RULE_)SAME_SCOPE_ONLY.  So for example:
> 
> - If the sandboxer wants to allow all socket access, don't handle
>   LANDLOCK_ACCESS_FS_RESOLVE_UNIX at all, or handle it but have an allow
>   rule at / with no flags.
> 
> - If it wants to allow access to only the sandboxed app's own sockets,
>   handle LANDLOCK_ACCESS_FS_RESOLVE_UNIX, then place one allow rule on /
>   with the rule flag SAME_SCOPE_ONLY.  This means that the allow rule
>   "UNIX socket under /" only allows connecting to sockets in the same
>   domain scope.  Additional rules without this rule flag can be placed on
>   more specific places to add "exceptions" to allow access to more
>   privileged sockets.
> 
> - To allow access to specific sockets only, not even the sandboxed app's
>   own sockets, just use LANDLOCK_ACCESS_FS_RESOLVE_UNIX without this new
>   rule flag.
> 
> This is slightly more flexible than just the LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
> scope bit plus LANDLOCK_ACCESS_FS_RESOLVE_UNIX, as it allows the sandboxer
> to specify where an application can connect, even with sockets in its own
> domain, and it also nicely avoids the "what feels like two independent
> controls poking holes in each other" problem.  But it does mean more
> complexity (although hopefully not too much), as we now need to introduce
> the rule flags concept, but that is required for some other proposed stuff
> anyway - quiet flags [3] and no_inherit [4] rules, and the rule flags
> design is in a good state I think.

This looks too complex and would intertwine both concept, which is more
confusing IMO.

> 
> What do folks think?

I'd like to keep a clean API, with a "scoped" field handling IPC
scoping, and an "handled_access_fs" field handling filesystem-related
accesses.

One thing to keep in mind is that we could add a new kind of "handled"
field that would enable to add rules identifying e.g. processes,
cgroups, or Landlock domains, and that could be used to add exceptions
to the current scopes.  This means that we need to have a generic way to
handle this case.

What is the issue with two complementary interfaces (scope and access)
used to express a policy about connecting to UNIX sockets?  We just need
to make sure that scopes and handled_access_fs dealing with UNIX sockets
are like binary OR: if the scope is set, then the domain can communicate
with peers which are in the same domain, and if the handled_access_fs
right is set, then the domain can only communicate with matching sockets
(OR scoped ones if the scope is set).

My main concern is about user space libraries and users that may want to
have conditional enforcement for compatibility reasons e.g., only
enforce LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET (let's say ABI v8) if it can
also set LANDLOCK_ACCESS_FS_RESOLVE_UNIX (let's say ABI v9).  I see two
ways to deal with this case (if needed):
- add synthetic access right to easily let users "combine" two access
  rigths or none;
- have a more generic way to AND and OR access rights.  I'm thinking
  about updating the Rust library in this direction.

Anyway, we need to decide if this should be merged in Linux 7.0 (next
week) or not.  I'd prefer to merge it now because I think it works well
and it's not a new concept wrt the abstract UNIX socket scoping.
However, if there are any concern, I'd like to hear them now and I can
delay this merge if needed.  This patch series still need a new version
but that should only be about cosmetic fixes.  WDYT?

> 
> (btw, when I say "sandboxed app" this can of course also mean multiple
> applications in the same sandbox, e.g. like a container runtime as Mickaël
> pointed out, which raises the probability that just having
> LANDLOCK_ACCESS_FS_RESOLVE_UNIX would be insufficient, e.g. when bind
> mounts are involved, or other cases which I haven't thought of right now)
> 
> [1]: https://github.com/landlock-lsm/linux/issues/36#issuecomment-3693123942
> [2]: https://lore.kernel.org/all/f238931bc813fc50fc8e11a007a8ad2136024df3.1766330134.git.m@maowtm.org/
> [3]: https://lore.kernel.org/all/cover.1766330134.git.m@maowtm.org/
> [4]: https://lore.kernel.org/all/20251221194301.247484-1-utilityemal77@gmail.com/
> 
