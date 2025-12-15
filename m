Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E1E335083
	for <linux-security-module@vger.kernel.org>; Mon, 15 Dec 2025 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765799124; cv=none; b=qXpPz9AKYjR5dYnST7aiLW//Y8BWXStEALYfmKyfo+doJu19aWUhckNhWYa40Hs+afGt7iNnzIBlyoIPdW2DJ/NnsjH1AllDvVUR6HQmZ6RlQe5NrfcYTF/w84qqfZNGNdS39DN2UDH9UVFW06rxla7ejSJqR2pXMcasgZFNeCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765799124; c=relaxed/simple;
	bh=ZyBIaG+lG8vPxwAdZxxTp/Zsp33JbnblFQsOln6KmLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opOfMDSqBcy2XxpzPHRU4cHJ+Z6DVr3EiDmNGtXrD6hr8w1nUekXeHzOGkPir6u0ziOdoxRih/KxBUf3Ajj8dXEJYNcWVt05u/Pg30FMFf8dv2hpBVDUOJB2lD2gze7oAXh6kviFNsB1bDPEWOCOXBS/NoHmqlxeLDUM3551Iqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=YXH/zicO; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="YXH/zicO"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dVHpT0Q90z2fl;
	Mon, 15 Dec 2025 12:27:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1765798032;
	bh=VO3ERMjg7lf1h+aBSm8JMyUIbIGpq7gPo9rDAvIPZgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YXH/zicO5DwPzUyzLRG4pdjRABIqpGo3xh00ul0wwUcm7jjZjQa8tP+G/LgS680Uf
	 sHTodTXsoS+USwUJEWwkqZ+6tQ4a+zk46GmhU+Hy4UAfYtFbKjbHWUdibQt5tvCHlO
	 LO5V/fVOZa1qkWf9yqVv21wIgYOGMYULA7qbQUlI=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dVHpS24KPzTF4;
	Mon, 15 Dec 2025 12:27:12 +0100 (CET)
Date: Mon, 15 Dec 2025 12:27:07 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	Alyssa Ross <hi@alyssa.is>, Spectrum OS Development <devel@spectrum-os.org>, 
	linux-security-module@vger.kernel.org, landlock@lists.linux.dev, 
	"Ryan B. Sullivan" <ryanbakersullivan@gmail.com>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH] host/roots: Sandbox xdg-desktop-portal-spectrum-host
Message-ID: <20251215.igh0yobahc8E@digikod.net>
References: <20251212-sandbox-dbus-portal-v1-1-522705202482@gmail.com>
 <87o6o25h6y.fsf@alyssa.is>
 <cfab1f24-65ad-40ed-b4a6-17f0aad8dc60@gmail.com>
 <87ikea5a8x.fsf@alyssa.is>
 <00256266-26db-40cf-8f5b-f7c7064084c2@gmail.com>
 <87bjk16dvv.fsf@alyssa.is>
 <515ff0f4-2ab3-46de-8d1e-5c66a93c6ede@gmail.com>
 <20251214.aiW5oc2izaxa@digikod.net>
 <20251215.5d7e473daa34@gnoack.org>
 <2a681b48-bc6e-4257-8e0f-3b6aff25ac67@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a681b48-bc6e-4257-8e0f-3b6aff25ac67@gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Dec 15, 2025 at 03:54:25AM -0500, Demi Marie Obenour wrote:
> On 12/15/25 03:20, Günther Noack wrote:
> > On Sun, Dec 14, 2025 at 08:50:45PM +0100, Mickaël Salaün wrote:
> >> On Sat, Dec 13, 2025 at 11:49:11PM -0500, Demi Marie Obenour wrote:
> >>> On 12/13/25 20:39, Alyssa Ross wrote:
> >>>> Demi Marie Obenour <demiobenour@gmail.com> writes:
> >>>>
> >>>>> On 12/13/25 16:42, Alyssa Ross wrote:
> >>>>>> Demi Marie Obenour <demiobenour@gmail.com> writes:
> >>>>>>
> >>>>>>> On 12/13/25 14:12, Alyssa Ross wrote:
> >>>>>>>> Demi Marie Obenour <demiobenour@gmail.com> writes:
> >>>>>>>>
> >>>>>>>>> It is quite possible that these Landlock rules are unnecessarily
> >>>>>>>>> permissive, but all of the paths to which read and execute access is
> >>>>>>>>> granted are part of the root filesystem and therefore assumed to be
> >>>>>>>>> public knowledge.  Removing access from any of them would only increase
> >>>>>>>>> the risk of accidental breakage in the future, and would not provide any
> >>>>>>>>> security improvements.  seccomp *could* provide some improvements, but
> >>>>>>>>> the effort needed is too high for now.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
> >>>>>>>>> ---
> >>>>>>>>>  .../template/data/service/xdg-desktop-portal-spectrum-host/run    | 8 ++++++++
> >>>>>>>>>  1 file changed, 8 insertions(+)
> >>>>>>>>
> >>>>>>>> Are you sure this is working as intended?  There's no rule allowing
> >>>>>>>> access to Cloud Hypervisor's VSOCK socket, and yet it still seems to be
> >>>>>>>> able to access that.  Don't you need to set a rule that *restricts*
> >>>>>>>> filesystem access and then add holes?  Did you ever see this deny
> >>>>>>>> anything?
> >>>>>>>
> >>>>>>> 'man 1 setpriv' states that '--landlock-access fs' blocks all
> >>>>>>> filesystem access unless a subsequent --landlock-rule permits it.
> >>>>>>> I tried running with no --landlock-rule flags and the execve of
> >>>>>>> xdg-desktop-portal-spectrum-host failed as expected.
> >>>>>>>
> >>>>>>> The socket is passed over stdin, and I'm pretty sure Landlock
> >>>>>>> doesn't restrict using an already-open file descriptor.
> >>>>>>> xdg-desktop-portal-spectrum-host does need to find the path to the
> >>>>>>> socket, but I don't think it ever accesses that path.
> >>>>>>
> >>>>>> I've been looking into this a bit myself, and from what I can tell
> >>>>>> Landlock just doesn't restrict connecting to sockets at all, even if
> >>>>>> they're inside directories that would otherwise be inaccessible.  It's
> >>>>>> able to connect to both Cloud Hypervisor's VSOCK socket and the D-Bus
> >>>>>> socket even with a maximally restrictive landlock rule.  So you were
> >>>>>> right after all, sorry!
> >>>>>
> >>>>> That's not good at all!  It's a trivial sandbox escape in so many cases.
> >>>>> For instance, with access to D-Bus I can just call `systemd-run`.
> >>>>>
> >>>>> I'm CCing the Landlock and LSM mailing lists because if you are
> >>>>> correct, then this is a bad security hole.
> >>>>
> >>>> I don't find it that surprising given the way landlock works.  "connect"
> >>>> (to a non-abstract AF_UNIX socket) is not an operation there's a
> >>>> landlock action for, and it's not like the other actions care about
> >>>> access to parent directories and the like — I was able to execute a
> >>>> program via a symlink after only giving access to the symlink's target,
> >>>> without any access to the directory containing the symlink or the
> >>>> symlink itself, for example.  Landlock, as I understand it, is intended
> >>>> to block a specified set of operations (on particular file hierarchies),
> >>>> rather than to completely prevent access to those hierarchies like
> >>>> permissions or mount namespaces could, so the lack of a way to block
> >>>> connecting to a socket is more of a missing feature than a security
> >>>> hole.
> >>>
> >>> 'man 7 unix' states:
> >>>
> >>> On  Linux,  connecting to a stream socket object requires write
> >>> permission on that socket; sending a datagram to a datagram socket
> >>> likewise requires write permission on that socket.
> >>>
> >>> Landlock is definitely being inconsistent with DAC here.  Also, this
> >>> allows real-world sandbox breakouts.  On systemd systems, the simplest
> >>> way to escape is to use systemd-run to execute arbitrary commands.
> >>
> >> The Linux kernel is complex and the link between the VFS and named UNIX
> >> sockets is "special" (see the linked GitHub issue).  Landlock doesn't
> >> handle named UNIX sockets yet for the same reason it doesn't handle some
> >> other kind of kernel resources or access rights: someone needs to
> >> implement it (including tests, doc...).  There is definitely interest to
> >> add this feature, it has been discussed for some time, but it's not
> >> trivial.  It is a work in progress though:
> >> https://github.com/landlock-lsm/linux/issues/36
> > 
> > Agreed, this would be the change that would let us restrict connect()
> > on AF_UNIX sockets.
> > 
> > Additionally, *in the case that you do not actually need* Unix
> > sockets, the other patch set that would be of interest is the one for
> > restricting the creation of new socket FDs:
> > https://github.com/landlock-lsm/linux/issues/6
> > 
> > In this talk in 2014, I explained my mental model around the
> > network-related restrictions:
> > https://youtu.be/K2onopkMhuM?si=LCObEX6HhGdzPnks&t=2030
> > 
> > The discussed socket control feature continues to be a central missing
> > piece, as the TCP port restrictions do not make much sense as long as
> > you can still create sockets for other protocol types.
> > 
> > Issue #6 that should fix this is still under active development -- an
> > updated version of the patch was posted just last month.
> > 
> > To bridge the gap, the same thing can also be emulated with seccomp,
> > but as you noted above as well in this thread, this is harder.
> > 
> > –Günther
> 
> I'm a bit surprised that this needs to be separate from other access
> controls.  To me, it seems like a bit of a misdesign in the core kernel
> (not Landlock).
> 
> I would go as far as to state that enabling other filesystem
> restrictions should also restrict AF_UNIX filesystem sockets
> automatically, as that is what users and administrators will expect.

I agree, that would be nice, but it's legacy.

> 
> What surprises me somewhat is that Linux does not have any sort of
> unified hook for filesystem path walks.  My mental model of Landlock
> is that from a filesystem perspective, the result should be equivalent
> to creating an empty mount namespace, putting a tmpfs on its root,
> and bind-mounting the allowed paths.  That this mental model does
> not match reality was quite surprising.

The approach taken by Landlock is to not break user space with kernel
updates, follow an incremental approach, and have a nice compatibility
story.  This is why a ruleset is created with a set of well-defined
"handled" access rights and restrictions.  Each new handled access right
or restriction must come with an explicit request from user space (e.g.
set new bits in struct landlock_ruleset_attr).

It would have been appealing to start from scratch, drop all access
rights, and then gradually implement access rights, but that would have
make Landlock unusable in most use cases.  Instead, we gradually extend
the scope of Landlock with well-defined and well-tested restrictions.
This approach eases the integration of Landlock and when new kernel
features are available, it's easy to update an integration to leverage
the new features.  From day one, Landlock has been useful, even if it
doesn't cover all use cases and environments.  When sandboxing a program
(or properly securing an OS), most of the time, the difficult part is to
get a good security architecture with proper privilege separation.  Once
this is done, it's much easier to gradually improve it.

We should probably improve the Landlock documentation, especially by
extending the warning block with some other relevant syscalls:
https://docs.kernel.org/userspace-api/landlock.html#filesystem-flags
