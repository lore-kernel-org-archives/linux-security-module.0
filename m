Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339E73D7D81
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850968; cv=none; b=CsBChr6GIuEEiLCHAfYW7jDh+TTTxl7a1yxxGit7GtywbNqhbRV1vlyYJFm9uPVIujS/NDQckmC6Es6ja/c5+DLCaKJ5pFQkdXPDwArAQNHC3yf730ZMTowTALfD20FW47NAG9WiJyx/HaG/hWqKOMRGWOJRJO+VINYYyjy7k9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850968; c=relaxed/simple;
	bh=39uYVicU566x+eNdfwpbYBT6OhThLnYXRsfYT3vtigQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pf6EhVB0oTz99WLdUBLRu3pqIYkPT/Z66TRDv6h3NVi1J1Rdj0HOvkjpxogYts6ZWbGXE+hmiVywaNso4VSLW5pWDnr0JuBqqOrwqoqdmwcA2KlMyCGDYFbbB2NNEV/J+z7s+WFBfIN5aLbcMG348ECh7SC+IoXvX1wWKcuzPwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ZlLgFT2O; arc=none smtp.client-ip=84.16.66.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ZlLgFT2O"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fbYyV2GSZz8wk;
	Wed, 18 Mar 2026 17:22:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773850962;
	bh=p3Z++XLcTQuwq7LFpOkkcdkzdVhx9nvzQHpjzM9/zmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZlLgFT2OEncp31yadr87Y9jvKZJYUJkMrNJHqJwTsBYc/dAXGi4BeaPpglxO1be7a
	 RrAQoHSRx1Pqjy/xKHdMdwT1hfYfQiQTLH1ocUl/3boYN5VPXvZbXyDJt5c0xOzpFD
	 TwZzUJZAQ9G1SM+gDsF4aTSx5updh4a9vlPHF63w=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fbYyR36Bkzlhs;
	Wed, 18 Mar 2026 17:22:39 +0100 (CET)
Date: Wed, 18 Mar 2026 17:22:34 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>, 
	linux-security-module@vger.kernel.org, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>, 
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v6 1/9] lsm: Add LSM hook security_unix_find
Message-ID: <20260318.wa0eef4tei6I@digikod.net>
References: <20260315222150.121952-2-gnoack3000@gmail.com>
 <2697b9f672967b1318630f2ffa21914f@paul-moore.com>
 <20260318.In1aekohyivu@digikod.net>
 <CAHC9VhRy2j3nYHHnyjsDf9Rk6=5DAzCSrmXgHCpo4arVnfBjRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRy2j3nYHHnyjsDf9Rk6=5DAzCSrmXgHCpo4arVnfBjRw@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Mar 18, 2026 at 10:44:26AM -0400, Paul Moore wrote:
> On Wed, Mar 18, 2026 at 4:48 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > On Tue, Mar 17, 2026 at 05:34:57PM -0400, Paul Moore wrote:
> > > On Mar 15, 2026 =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com> wrote:
> > > >
> > > > Add a LSM hook security_unix_find.
> > > >
> > > > This hook is called to check the path of a named unix socket before a
> > > > connection is initiated. The peer socket may be inspected as well.
> > > >
> > > > Why existing hooks are unsuitable:
> > > >
> > > > Existing socket hooks, security_unix_stream_connect(),
> > > > security_unix_may_send(), and security_socket_connect() don't provide
> > > > TOCTOU-free / namespace independent access to the paths of sockets.
> > > >
> > > > (1) We cannot resolve the path from the struct sockaddr in existing hooks.
> > > > This requires another path lookup. A change in the path between the
> > > > two lookups will cause a TOCTOU bug.
> > > >
> > > > (2) We cannot use the struct path from the listening socket, because it
> > > > may be bound to a path in a different namespace than the caller,
> > > > resulting in a path that cannot be referenced at policy creation time.
> > > >
> > > > Cc: Günther Noack <gnoack3000@gmail.com>
> > > > Cc: Tingmao Wang <m@maowtm.org>
> > > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > > > ---
> > > >  include/linux/lsm_hook_defs.h |  5 +++++
> > > >  include/linux/security.h      | 11 +++++++++++
> > > >  net/unix/af_unix.c            | 13 ++++++++++---
> > > >  security/security.c           | 20 ++++++++++++++++++++
> > > >  4 files changed, 46 insertions(+), 3 deletions(-)
> > >
> > > Some really minor nitpicky things (below), but nothing critical.
> > > However, as we discussed, I would like to see the AppArmor folks comment
> > > on the new hook before we merge anything as I know they have an interest
> > > here.
> >
> > John, Georgia, we've been discussing this new hook for a few months now
> > but didn't hear from you yet.  We plan to merge this patch series with
> > the 7.1 merge window (in a few weeks), so before that I'd like to merge
> > it in -next in a few days to get a broader coverage.  I'm pretty sure
> > this hook will work well with AppArmor too, but could you please take
> > look to confirm?
> 
> I probably wasn't as clear as I should have been, my apologies.  The
> major reason I held back my ACK on this patch was that I wanted to
> hear from the AA folks regarding the hook's suitability for their
> needs.  While I don't expect they will have an issue with this hook
> as-is, they have expressed interest in the hook, and I would just
> assume make sure it is okay for everyone before we send it to Linus.
> 
> Since this is a feature addition and not a critical bug fix, I will be
> quite upset if this is sent to Linus without review by the AA
> developers and my ACK.

I definitely understand and that makes sense, but even if it is not a
strict fix, please consider that this feature still fixes an important
gap in practice (e.g. run anything outside a sandbox with the help of
systemd; see cover letter and reported issues [1]).  I don't want to
bypass anyone, but given the importance of this change, I don't want to
postpone it either (except if there is a major issue of course, but I
think the review was pretty good).  That's why we'd like to get some
feedback sooner than later.  While waiting for AA folks feedback, would
you still be OK for me to push it to -next to improve test and review
coverage?

[1] https://lore.kernel.org/all/cover.1767115163.git.m@maowtm.org/
