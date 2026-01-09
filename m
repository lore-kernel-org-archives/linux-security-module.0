Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDB6359F98
	for <linux-security-module@vger.kernel.org>; Fri,  9 Jan 2026 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767960115; cv=none; b=DGxzipIaUEXPykikAEZIWVCgPAUJq168isxwiPGkxlNjYpWCxTB3jLGux2RK1FB3gmhMthnArH7Wyiwu5oju9QKriFNk7rt3DxCjzF7Dm/DJoAhSObf7GlHiLCLbWc9aCll6940coHLZqoB21nPIL0xCuYfc/6/xmLKH5/Zl9kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767960115; c=relaxed/simple;
	bh=RnbnKnvJUK0Qs1vF30VXMkqci9V0ZKXE/Cou9GaorK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZUgUkEvsYyJPUXzLM1CFKAbgMkTsbZK3CT2qXkio42IEsRUffysr39QCj3SrXugHyelKRJesmsTlHLPtGeA86iLjmRc2a5oveVgUykLBhY8sBmkyo5umy5AS1m7XFz4nuXCQK58wug6O+lHTqD0fhh+EPkb/3Lhb08wmhrzAd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=r63eCWN4; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="r63eCWN4"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dngNs2phszPVL;
	Fri,  9 Jan 2026 13:01:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1767960108;
	bh=B6ZSXnJ0zb+PsfSKPSMpDOf7CWo4oT10bCS57I8sNlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r63eCWN41gTdISANPNs1Zs0ny8YMFl/p1JTAp/1E7lF/8HqtWWL2eMXIkU2G1svIW
	 W+K30MrVcnyR1D2GAE5nsOVAm/q2DOnf1uVaurt3H+OenxA7FXnnb4Y4ohAGOy6Imb
	 BCBypefaGjUcNUnq0ZTd+XzmxU6tSxbdbQOWk5vM=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dngNq6BBfzXJF;
	Fri,  9 Jan 2026 13:01:47 +0100 (CET)
Date: Fri, 9 Jan 2026 13:01:41 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	Tingmao Wang <m@maowtm.org>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Justin Suess <utilityemal77@gmail.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Landlock: Implement scope control for pathname
 Unix sockets
Message-ID: <20260109.Ino1ahfef1iu@digikod.net>
References: <cover.1767115163.git.m@maowtm.org>
 <20251230.bcae69888454@gnoack.org>
 <dc9b99b6-14a1-45b6-a23f-0b24143dac58@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc9b99b6-14a1-45b6-a23f-0b24143dac58@gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Dec 31, 2025 at 11:54:27AM -0500, Demi Marie Obenour wrote:
> On 12/30/25 18:16, Günther Noack wrote:
> > Hello!
> > 
> > Thanks for sending this patch!
> > 
> > On Tue, Dec 30, 2025 at 05:20:18PM +0000, Tingmao Wang wrote:
> >> Changes in v2:
> >>   Fix grammar in doc, rebased on mic/next, and extracted common code from
> >>   hook_unix_stream_connect and hook_unix_may_send into a separate
> >>   function.
> >>
> >> The rest is the same as the v1 cover letter:
> >>
> >> This patch series extend the existing abstract Unix socket scoping to
> >> pathname (i.e. normal file-based) sockets as well, by adding a new scope
> >> bit LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET that works the same as
> >> LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET, except that restricts pathname Unix
> >> sockets.  This means that a sandboxed process with this scope enabled will
> >> not be able to connect to Unix sockets created outside the sandbox via the
> >> filesystem.
> >>
> >> There is a future plan [1] for allowing specific sockets based on FS
> >> hierarchy, but this series is only determining access based on domain
> >> parent-child relationship.  There is currently no way to allow specific
> >> (outside the Landlock domain) Unix sockets, and none of the existing
> >> Landlock filesystem controls apply to socket connect().
> >>
> >> With this series, we can now properly protect against things like the the
> >> following while only relying on Landlock:
> >>
> >>     (running under tmux)
> >>     root@6-19-0-rc1-dev-00023-g68f0b276cbeb ~# LL_FS_RO=/ LL_FS_RW= ./sandboxer bash
> >>     Executing the sandboxed command...
> >>     root@6-19-0-rc1-dev-00023-g68f0b276cbeb:/# cat /tmp/hi
> >>     cat: /tmp/hi: No such file or directory
> >>     root@6-19-0-rc1-dev-00023-g68f0b276cbeb:/# tmux new-window 'echo hi > /tmp/hi'
> >>     root@6-19-0-rc1-dev-00023-g68f0b276cbeb:/# cat /tmp/hi
> >>     hi
> >>
> >> The above but with Unix socket scoping enabled (both pathname and abstract
> >> sockets) - the sandboxed shell can now no longer talk to tmux due to the
> >> socket being created from outside the Landlock sandbox:
> >>
> >>     (running under tmux)
> >>     root@6-19-0-rc1-dev-00023-g68f0b276cbeb ~# LL_FS_RO=/ LL_FS_RW= LL_SCOPED=u:a ./sandboxer bash
> >>     Executing the sandboxed command...
> >>     root@6-19-0-rc1-dev-00023-g68f0b276cbeb:/# cat /tmp/hi
> >>     cat: /tmp/hi: No such file or directory
> >>     root@6-19-0-rc1-dev-00023-g68f0b276cbeb:/# tmux new-window 'echo hi > /tmp/hi'
> >>     error connecting to /tmp/tmux-0/default (Operation not permitted)
> >>     root@6-19-0-rc1-dev-00023-g68f0b276cbeb:/# cat /tmp/hi
> >>     cat: /tmp/hi: No such file or directory
> >>
> >> Tmux is just one example.  In a standard systemd session, `systemd-run
> >> --user` can also be used (--user will run the command in the user's
> >> session, without requiring any root privileges), and likely a lot more if
> >> running in a desktop environment with many popular applications.  This
> >> change therefore makes it possible to create sandboxes without relying on
> >> additional mechanisms like seccomp to protect against such issues.
> >>
> >> These kind of issues was originally discussed on here (I took the idea for
> >> systemd-run from Demi):
> >> https://spectrum-os.org/lists/archives/spectrum-devel/00256266-26db-40cf-8f5b-f7c7064084c2@gmail.com/
> > 
> > What is unclear to me from the examples and the description is: Why is
> > the boundary between allowed and denied connection targets drawn at
> > the border of the Landlock domain (the "scope") and why don't we solve
> > this with the file-system-based approach described in [1]?
> > 
> > **Do we have existing use cases where a service is both offered and
> > connected to all from within the same Landlock domain, and where the
> > process enforcing the policy does not control the child process enough
> > so that it would be possible to allow-list it with a
> > LANDLOCK_ACCESS_FS_CONNECT_UNIX rule?**

Yes, with the sandboxer use case.  It's similar to a container that
doesn't know all programs that could be run in it.  We should be able to
create sandboxes that don't assume (nor restrict) internal IPCs (or any
kind of direct process I/O).

Landlock should make it possible to scope any kind of IPC.  It's a
mental model which is easy to understand and that should be enforced by
default.  Of course, we need some ways to add exceptions to this
deny-by-default policy, and that's why we also need the FS-based control
mechanism.

> > 
> > If we do not have such a use case, it seems that the planned FS-based
> > control mechanism from [1] would do the same job?  Long term, we might
> > be better off if we only have only one control -- as we have discussed
> > in [2], having two of these might mean that they interact in
> > unconventional and possibly confusing ways.
> 
> I agree with this.

Both approaches are complementary/orthogonal and make sense long term
too.  This might be the first time we can restrict the same operations,
but I'm pretty sure it will not be the last, and it's OK.  Handled FS
access and scoped restrictions are two ways to describe a part of the
security policy.  Having different ways makes the interface much simpler
than a generic one that would have to take into account all potential
future access controls.

One thing to keep in mind is that UAPI doesn't have to map 1:1 to the
kernel implementation, but the UAPI is stable and future proof, whereas
the kernel implementation can change a lot.

The ruleset's handled fields serve two purposes: define what should be
denied by default, and define which type of rules are valid
(compatibility).  The ruleset's scoped field serve similar purposes but
it also implies implicit rules (i.e. communications with processes
inside the sandbox are allowed).  Without the soped field, we would have
to create dedicated handled field per type (i.e. scope's bit) and
dedicated rule type for the related handled field, which would make the
interface more generic but also more complex, for something which is not
needed.

In a nutshell, in the case of the FS-based and scope-based unix socket
control, we should see one kind of restrictions (e.g. connect to unix
socket), which can accept two types of rules: (explicit) file path, or
(implicit) peer's scope.  Access should be granted as long as a rule
matches, whatever its type.

This rationale should be explained in a commit message.

> 
> > Apart from that, there are some other weaker hints that make me
> > slightly critical of this patch set:
> > 
> > * We discussed the idea that a FS-based path_beneath rule would act
> >   implicitly also as an exception for
> >   LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET, in [2] - one possible way to
> >   interpret this is that the gravity of the system's logic pulls us
> >   back towards a FS-based control, and we would have to swim less
> >   against the stream if we integrated the Unix connect() control in
> >   that way?
> 
> I agree with this as well.  Having FS-based controls apply consistently
> to all types of inodes is what I would expect.

I'm not sure to understand, but I hope my explanation above will answer
this question.

> 
> > * I am struggling to convince myself that we can tell users to
> >   restrict LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET as a default, as we are
> >   currently doing it with the other "scoped" and file system controls.
> >   (The scoped signals are OK because killing out-of-domain processes
> >   is clearly bad.  The scoped abstract sockets are usually OK because
> >   most processes do not need that feature.)
> > 
> >   But there are legitimate Unix services that are still needed by
> >   unprivileged processes and which are designed to be safe to use.
> >   For instance, systemd exposes a user database lookup service over
> >   varlink [3], which can be accessed from arbitrary glibc programs
> >   through a NSS module.  Using this is incompatible with
> >   LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET as long as we do not have the
> >   FS-based control and the surprising implicit permission through a
> >   path_beneath rule as discussed in [2].
> > 
> >   (Another example is the X11 socket, to which the same reasoning
> >   should apply, I think, and which is also used by a large number of
> >   programs.)

Yes, restricting a sandbox too much may not work for any possible use
cases.  Some use cases would need the FS-based control before using the
scope-based one, and that's OK.  Some use cases would not need the
FS-based control, and the scope-based one would be enough (e.g.
sandboxed archive manager).

> I think making FS-based controls on by default is the least surprising
> option for users.  It's what I suspect most programs intend, and it
> would stop a lot of unexpected sandbox escapes.

Nothing in Landlock is on by default for compatibility reasons.

> 
> Without FS-based controls, scoping is also necessary to prevent
> sandbox escapes.  In my opinion, it's better to block access to
> unprivileged services than to allow connecting to any service.

Scoped-based control should be enforced in most cases, but FS-based
control might be a requirement/dependency.  In any case, a sandbox
should not break legitimate use cases.

> 
> X11 is a trivial sandbox escape by taking over the user's GUI.
> A sandboxed program accessing it indicates a misdesign.

I would say a *fully* sandboxed program for a desktop use case using X11
(instead of Wayland), which is not possible with Landlock *alone* yet.
Desktop environment is the worse case scenario for sandboxing, for a lot
of different reasons... but there are a lot of other use cases for
sandboxing.

> The NSS module
> is not needed by programs that do not do user database resolution,
> which I suspect includes almost all sandboxed programs.
> 
> > I agree that the bug [1] has been asleep for a bit too long, and we
> > should probably pick this up soon.  As we have not heard back from
> > Ryan after our last inquiry, IMHO I think it would be fair to take it
> > over.
> 
> I definitely support this!

Yes, thanks for working on this.

> 
> > Apologies for the difficult feedback - I do not mean to get in the way
> > of your enthusiasm here, but I would like to make sure that we don't
> > implement this as a stop-gap measure just because the other bug [1]
> > seemed more difficult and/or stuck in a github issue interaction.
> > Let's rather unblock that bug, if that is the case. :)

Receiving criticisms is part of the review process, which is a sign of
healthy development.  I understand your concerns and it's good discuss
about them to make sure we are going in the right direction.

> > 
> > As usual, I fully acknowledge that I might well be wrong and might
> > have missed some of the underlying reasons, in which case I will
> > happily be corrected and change my mind. :)

In any case, if someone doesn't understand something, it probably means
that this should be explained better somewhere.  Such design artifacts
will be useful for future developments too.

> > 
> > [1] https://github.com/landlock-lsm/linux/issues/36
> > [2] https://github.com/landlock-lsm/linux/issues/36#issuecomment-3699749541
> > [3] https://systemd.io/USER_GROUP_API/
> > 
> > Have a good start into the new year!
> > –Günther
> -- 
> Sincerely,
> Demi Marie Obenour (she/her/hers)





