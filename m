Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E0741DE1A
	for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2026 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784552394; cv=none; b=m3P6MTlyePZwwEvP39S18NROCxnEtlp8lhDFaYqvA/S7FN5TjAA9N1m58TyCQMt9cKTvFKe1Lg7a3+ooIQS+8K5CXcOQf5O75WJIw4WJiNKxpAVf/4ijS2Qnl/1PC/qBZYz/UalCme5dTjsyeJqAk4+J4tuKrjenaPG+TY7poPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784552394; c=relaxed/simple;
	bh=yoczCrZLH3m6/Piugp4sSlD0UbvSuhUnAIOk+aELQJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNLnLqW8ZgpZSfFwfhXF9prDg6WHazUt9mIulobx3slpbvxnRZWNHuGOl8eW9AGxlhCRVF5fE8b8YmdCi4tHUG336fZMpcl8ShwAtzsjJtcRwGfPMpl1UfcS6v6sIU0jbAT9zhs5eZbLtHp0eLk0TG/JDolCS3N69mUEiUtBVkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=QJl1Mhuh; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="QJl1Mhuh"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h3gb52rSwz3ZH;
	Mon, 20 Jul 2026 14:59:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1784552385;
	bh=Nz5gOh3J4r65petlwUyj+D42IUdV73zSCFDjsTRAO3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QJl1MhuhRt4M4pmWO8GyS/npYUnZ8hgvtyl0LUZp7Z44s44tU3QMMTzOivCfUaIVj
	 yoFeGjQD+CYCk8MmwJqt45DHmbUw9+nXIFsn5QvvAL24CjmFS0db68yABLvNvY8eTw
	 hANMfxAnnkCoXv+d5XmMHuRxmaWaaHOSw8fyXrNc=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4h3gb129xdz2Wk;
	Mon, 20 Jul 2026 14:59:41 +0200 (CEST)
Date: Mon, 20 Jul 2026 14:59:37 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jann Horn <jannh@google.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Bryam Vargas <hexlabsecurity@proton.me>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, 
	Justin Suess <utilityemal77@gmail.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Leon Romanovsky <leon@kernel.org>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Paul Moore <paul@paul-moore.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Tingmao Wang <m@maowtm.org>, Ubisectech Sirius <bugreport@ubisectech.com>, 
	Willy Tarreau <w@1wt.eu>, Yuxian Mao <maoyuxian@cqsoftware.com.cn>, 
	kernel-team@cloudflare.com, landlock@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v1] landlock: Document the threat model
Message-ID: <20260720.veefeidoh5Ee@digikod.net>
References: <20260707210336.2060040-1-mic@digikod.net>
 <CAG48ez3ywK8FZ-TZFzp1GwiW6Wb+DeO3OFt3Ys4QAeGTS0jv6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3ywK8FZ-TZFzp1GwiW6Wb+DeO3OFt3Ys4QAeGTS0jv6g@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Jul 08, 2026 at 11:48:09PM +0200, Jann Horn wrote:
> On Tue, Jul 7, 2026 at 11:03 PM Mickaël Salaün <mic@digikod.net> wrote:
> > +Sandboxing is layered
> > +---------------------
> > +
> > +Landlock is the access-control layer of a sandbox, not the whole sandbox.  A
> > +robust sandbox also needs steps that are the program's responsibility: switching
> > +to an unprivileged user, dropping capabilities, setting ``PR_SET_NO_NEW_PRIVS``,
> > +and confining all threads of the process with the same domain.  A
> > +single-threaded process gets the latter for free; a multithreaded one can
> > +enforce a ruleset atomically on all its threads, or must otherwise synchronize
> > +them before any untrusted work.  Landlock is typically applied last, to tighten
> > +access and make the domain identifiable and auditable.
> > +
> > +Stronger isolation can come from combining Landlock with other mechanisms in a
> > +defense-in-depth approach, notably seccomp-bpf (see
> > +Documentation/userspace-api/seccomp_filter.rst) for what Landlock does not yet
> > +cover.  A long-term goal of Landlock is to control access to any kind of kernel
> > +resource in a way suited to sandboxing.
> 
> I think this part is something that should go near the top of the
> document, and should have a title like "How to securely use landlock"
> - most of the document is focused on telling kernel developers or
> security researchers what the boundaries of the threat model are, but

This patch is really about the threat model, to make it clear to
kernel developers, security researchers, and especially to AI agents
(not sure it will work but at least we can point to a specific doc),
what is not a Landlock security bug and why.

> I think it is also important (and maybe even more important) to
> present this from the perspective of "if I want to design a sandbox
> using landlock, what do I need to pay attention to".

I agree that it's more important, but the correct doc for that would be
the userspace API doc, which already describes how to use Landlock.
That would be an independent patch though.

> 
> I think it would also make sense to give more specific guidance on
> which sets of syscalls, with what argument restrictions, can be
> permitted in a seccomp policy because landlock covers any accesses
> that these syscalls can perform to objects to which the process
> doesn't already hold file descriptors or such.
> I think it would be helpful to have instructions like "you can safely
> allow socket operations if you ensure that socket creation (socket())
> only works for AF_UNIX, and that the process has no existing socket
> file descriptors for non-covered socket types, and you have fs_access
> rules, and the kernel is sufficiently recent".

I'm wondering how we could have such a doc without gaps, make it simple
to read, and keep it up-to-date for all kernel versions and
architectures.  Another challenge would also be to map these syscalls
and arguments to the evolving set of Landlock access rights.  I think
the most pragmatic approach would be to rely on a dedicated library, but
maintaining it with a complete test coverage looks like a nightmare.
