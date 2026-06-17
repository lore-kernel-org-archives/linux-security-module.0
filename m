Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F5E217F27
	for <linux-security-module@vger.kernel.org>; Wed, 17 Jun 2026 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705811; cv=none; b=Olg5hV13jeGdYUJniSqT+qLYDk+cNAqDAGsmPpqKgPLpGXnB2K6ISgInoRtDtgqbgqe5y/MJZ4Gm65obmUb6qL9S6Iwj5ALunJ8/35PR2f+THmwP2QO2TWsbaZyLEHiKBa1htQbaBdlY1OyvGgjAJtxS4x2nlmbZti0bSK63mas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705811; c=relaxed/simple;
	bh=LuBV8z5mdVB/JfGpOaXk7lFVIERKcoGMtDps9ge/6e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wts8oX2KqP/H/HXfF2gi+ze8+/YfK1HAvazHDDPEOFPbv5idKdG5ZoRZ0ujxaWKnhANvZdHM0wmn46Adcy9hyCR1yBMj7UPvt5IBgPXJcl9qbhBIRDs6rpdhxa1BRF4Q2TSOuUj82DMAmL/3vG6FZqT+xvJrcioi8WDW6lGYfz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=p5XmuOST; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="p5XmuOST"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ggQs80F91zksB;
	Wed, 17 Jun 2026 16:16:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1781705803;
	bh=0az5TrG/tZ45K/qE3BmGVAeEOhBxKzwnVtxEjeZhnhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p5XmuOSTXMpkue7+1y+zZUJiXQDF1q9mYQxNz4dszA/FQhEwyw+m+hJCtTl4yoURC
	 5/CnsSF7/a7IgBs9NviVH8k1MWUf8mTTk3Bm6+PYjKSoM3uwiP0mcLley5shLxAZtW
	 abUD9KiSalLXQydYPPle2Xju6qGVZxPYXV4QL2GE=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ggQs70T1LzTTl;
	Wed, 17 Jun 2026 16:16:42 +0200 (CEST)
Date: Wed, 17 Jun 2026 16:16:38 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bryam Vargas <hexlabsecurity@proton.me>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Paul Moore <paul@paul-moore.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>
Subject: Re: Landlock: LANDLOCK_ACCESS_FS_IOCTL_DEV bypass via io_uring
 IORING_OP_URING_CMD
Message-ID: <20260617.aeNg7Aeseez4@digikod.net>
References: <20260616201633.275067-1-hexlabsecurity@proton.me>
 <fcfa9bc9-4f7d-478c-90a2-ec4efd4c7d43@kernel.dk>
 <20260617022541.328550-1-hexlabsecurity@proton.me>
 <209b76b4-e028-4af7-bdcb-b5813fef32fc@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <209b76b4-e028-4af7-bdcb-b5813fef32fc@kernel.dk>
X-Infomaniak-Routing: alpha

On Tue, Jun 16, 2026 at 08:44:55PM -0600, Jens Axboe wrote:
> On 6/16/26 8:25 PM, Bryam Vargas wrote:
> > Thanks Jens ? noted, the fix belongs in Landlock. Micka?l has the full
> > report.
> 
> Indeed - and hence no need to bother anyone else with it by blasting it
> wide. I've already explained this multiple times, but on the private
> security list, when the occasional AI report comes in on things like
> this. Hence why it's a bit tiring to see the same stuff come across,
> once again.
> 
> For the landlock folks, I'd suggest taking a look at what hooks already
> exists (and existed, when landlock was merged) for selinux etc, that'd
> be a really good hint on the existing surface covered.

As I explained in previous (private) reports, there is currently no
io_uring hooks implemented for Landlock because there is no use for
them.

io_uring "bypass" was already mentioned to us two times in March but
io_uring personality credential is not a Landlock bypass.  The Landlock
threat model is about enforcing restrictions when accessing new kernel
resources, on a sandboxed subject.  The credential identifies a set of
access rights, so in the case of io_uring, the subject is inherited by
the io_uring personality (i.e. the file descriptor).  If a sandboxed
task creates an io_uring personality, it will be sandboxed with the same
restrictions, which is BTW an interesting property (e.g.  pass a
restricted io_uring FD to processes)

A sandboxed process cannot create an io_uring personality that would
bypass its own restrictions, so there is no Landlock bypass.  Inheriting
or receiving a file descriptor is not restricted by Landlock because
these are operations from outside (or before) the sandbox.  If we want
to restrict them, we need to restrict the processes creating such file
descriptor.

Inherited or passed file descriptors are outside the Landlock threat
model because Landlock is only one part of the security policy when
(willingly) interacting with other processes.  In a nutshell, it's the
security capability model (where an object has some associated rights).
For instance, if a process willingly passes a file descriptor tied to a
secret file, then the receiving side can (and should be able to) read
it, being sandboxed with Landlock or not.  The scope of Landlock is to
drop ambient rights, but if an *unsandboxed* process is OK to pass a
sensitive resource, then that's a security architecture issue (i.e. a
confused deputy attack).

A nice side effect of this approach is that a process can sandbox itself
with a specific Landlock security policy and create an io_uring file
descriptor that will inherit the Landlock restrictions.  It can then
pass this FD to other processes with the guarantee that this FD will
only give access to resources allowed by the Landlock policy.

Landlock could implement the security_uring_sqpoll() hook, but for now
the use case is not clear to me.  We are working on controling socket
creation according to they properties and I think the same approach
would be useful for IO_URING:
https://lore.kernel.org/r/20251118134639.3314803-1-ivanov.mikhail1@huawei-partners.com

I agree that this might be confusing and I plan to improve Landlock
documentation to make this clear and simpler for AI to take into
account.

BTW, we also have an opened issue to add io_uring tests:
https://github.com/landlock-lsm/linux/issues/23

Regards,
 Mickaël
