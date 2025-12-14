Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103F254774
	for <linux-security-module@vger.kernel.org>; Sun, 14 Dec 2025 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765741869; cv=none; b=GUQ+Xb5VXFwbsIlUF5Er7ZJn+PJWFvb31BTCKQnkVk2f6qsHicQD9wW0yO2oHb+bwaSiE1qJcrFbJTZLE8Y7lO9JZUFhhv5dU58M7RAKr1L7zaYAAU0Kud/Yf0aUaE+3EvPPyIoTOTY+4aDAGNfQaAaWKZgoLDnXPD+UltPPKfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765741869; c=relaxed/simple;
	bh=owQoEX1EZbTrWEdvUCqyB5MmSXK5MjShMHQhglkngTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDMPp6m1VKV7rGk6RMjK7LEFESx7Y7AtXo9rLaHIKpySnX8aKrTcaciC6bwnCqkCijY0dllNP8rIDUqEtYIpCL1VHQEHDtb6DZOI0sJoxy6DYPL7zO3iWF6i7q0+SSmtNUjlb/984F4MEatr0FiTDeNGWFsXxifXh6IPxJwn5rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=RkWJekln; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="RkWJekln"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dTv241XDgzDTs;
	Sun, 14 Dec 2025 20:50:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1765741852;
	bh=MbdiP+SEfNKCivL2//nS56J84ECCZ8Gy69g/EtE32TQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RkWJeklnBpDkATwQbEA+Ki2t10/npeozDlL4NEsqBbUqO1/nl9OBiVTNwwvqgnp2V
	 O3gFGgtMgkVllCc30HJzE5STzfdosEyn1MfGQqqSAT4tBhW3YMOua8SxWSnEwRPARX
	 CovALq8jHGCWuHEzcW3/8eRIt/L0p3O0xoYPFacY=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dTv232HdQzL7j;
	Sun, 14 Dec 2025 20:50:51 +0100 (CET)
Date: Sun, 14 Dec 2025 20:50:45 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Alyssa Ross <hi@alyssa.is>, 
	Spectrum OS Development <devel@spectrum-os.org>, linux-security-module@vger.kernel.org, landlock@lists.linux.dev, 
	"Ryan B. Sullivan" <ryanbakersullivan@gmail.com>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH] host/roots: Sandbox xdg-desktop-portal-spectrum-host
Message-ID: <20251214.aiW5oc2izaxa@digikod.net>
References: <20251212-sandbox-dbus-portal-v1-1-522705202482@gmail.com>
 <87o6o25h6y.fsf@alyssa.is>
 <cfab1f24-65ad-40ed-b4a6-17f0aad8dc60@gmail.com>
 <87ikea5a8x.fsf@alyssa.is>
 <00256266-26db-40cf-8f5b-f7c7064084c2@gmail.com>
 <87bjk16dvv.fsf@alyssa.is>
 <515ff0f4-2ab3-46de-8d1e-5c66a93c6ede@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <515ff0f4-2ab3-46de-8d1e-5c66a93c6ede@gmail.com>
X-Infomaniak-Routing: alpha

On Sat, Dec 13, 2025 at 11:49:11PM -0500, Demi Marie Obenour wrote:
> On 12/13/25 20:39, Alyssa Ross wrote:
> > Demi Marie Obenour <demiobenour@gmail.com> writes:
> > 
> >> On 12/13/25 16:42, Alyssa Ross wrote:
> >>> Demi Marie Obenour <demiobenour@gmail.com> writes:
> >>>
> >>>> On 12/13/25 14:12, Alyssa Ross wrote:
> >>>>> Demi Marie Obenour <demiobenour@gmail.com> writes:
> >>>>>
> >>>>>> It is quite possible that these Landlock rules are unnecessarily
> >>>>>> permissive, but all of the paths to which read and execute access is
> >>>>>> granted are part of the root filesystem and therefore assumed to be
> >>>>>> public knowledge.  Removing access from any of them would only increase
> >>>>>> the risk of accidental breakage in the future, and would not provide any
> >>>>>> security improvements.  seccomp *could* provide some improvements, but
> >>>>>> the effort needed is too high for now.
> >>>>>>
> >>>>>> Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
> >>>>>> ---
> >>>>>>  .../template/data/service/xdg-desktop-portal-spectrum-host/run    | 8 ++++++++
> >>>>>>  1 file changed, 8 insertions(+)
> >>>>>
> >>>>> Are you sure this is working as intended?  There's no rule allowing
> >>>>> access to Cloud Hypervisor's VSOCK socket, and yet it still seems to be
> >>>>> able to access that.  Don't you need to set a rule that *restricts*
> >>>>> filesystem access and then add holes?  Did you ever see this deny
> >>>>> anything?
> >>>>
> >>>> 'man 1 setpriv' states that '--landlock-access fs' blocks all
> >>>> filesystem access unless a subsequent --landlock-rule permits it.
> >>>> I tried running with no --landlock-rule flags and the execve of
> >>>> xdg-desktop-portal-spectrum-host failed as expected.
> >>>>
> >>>> The socket is passed over stdin, and I'm pretty sure Landlock
> >>>> doesn't restrict using an already-open file descriptor.
> >>>> xdg-desktop-portal-spectrum-host does need to find the path to the
> >>>> socket, but I don't think it ever accesses that path.
> >>>
> >>> I've been looking into this a bit myself, and from what I can tell
> >>> Landlock just doesn't restrict connecting to sockets at all, even if
> >>> they're inside directories that would otherwise be inaccessible.  It's
> >>> able to connect to both Cloud Hypervisor's VSOCK socket and the D-Bus
> >>> socket even with a maximally restrictive landlock rule.  So you were
> >>> right after all, sorry!
> >>
> >> That's not good at all!  It's a trivial sandbox escape in so many cases.
> >> For instance, with access to D-Bus I can just call `systemd-run`.
> >>
> >> I'm CCing the Landlock and LSM mailing lists because if you are
> >> correct, then this is a bad security hole.
> > 
> > I don't find it that surprising given the way landlock works.  "connect"
> > (to a non-abstract AF_UNIX socket) is not an operation there's a
> > landlock action for, and it's not like the other actions care about
> > access to parent directories and the like — I was able to execute a
> > program via a symlink after only giving access to the symlink's target,
> > without any access to the directory containing the symlink or the
> > symlink itself, for example.  Landlock, as I understand it, is intended
> > to block a specified set of operations (on particular file hierarchies),
> > rather than to completely prevent access to those hierarchies like
> > permissions or mount namespaces could, so the lack of a way to block
> > connecting to a socket is more of a missing feature than a security
> > hole.
> 
> 'man 7 unix' states:
> 
> On  Linux,  connecting to a stream socket object requires write
> permission on that socket; sending a datagram to a datagram socket
> likewise requires write permission on that socket.
> 
> Landlock is definitely being inconsistent with DAC here.  Also, this
> allows real-world sandbox breakouts.  On systemd systems, the simplest
> way to escape is to use systemd-run to execute arbitrary commands.

The Linux kernel is complex and the link between the VFS and named UNIX
sockets is "special" (see the linked GitHub issue).  Landlock doesn't
handle named UNIX sockets yet for the same reason it doesn't handle some
other kind of kernel resources or access rights: someone needs to
implement it (including tests, doc...).  There is definitely interest to
add this feature, it has been discussed for some time, but it's not
trivial.  It is a work in progress though:
https://github.com/landlock-lsm/linux/issues/36

Contributions are welcome!

Regards,
 Mickaël
