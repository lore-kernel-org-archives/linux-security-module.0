Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA43347514
	for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2026 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885744; cv=none; b=Y5VeICyNdWdoMnqn8j9X6/aeVx/Q6UqyTn+MeRy+nTPg3HyjkQvR9L+W6ysP6G+ywxKa3pqf40tVoMMluvCb7NJia4NkQ2xB9zoszeCnr+2dUtg1IeI4vS8Dx4iSSvdhr1/4o7AdBrHFQ9BoR8Z5glI7nZ7qbkKx4BV8u1h4yJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885744; c=relaxed/simple;
	bh=D96Roc/uVrc3tSAZdwsn2ltSk6j7nclFegHmFGJ/P30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+L2EY60SD1FWpUdNHxxbhMD1I7cAzL+IO4h0k6pm0r+vJnWwr+yX3MVlypSGcallvOOmI22hW9HiRU6UXy0W3rixe7y9AWdgSNuICb3FQqM40uFfrIzC7U7xT6z9sNyN8QyuYUauh3ON33GBb83CI7yfZC0dBcNN3j8hE7iqsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=I/zd5W5K; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="I/zd5W5K"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h62fV6SVHzLqJ;
	Fri, 24 Jul 2026 11:25:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1784885154;
	bh=Pp+f9GC8KVA8gtnD54pUJ8PvVjud8oumonuoyRDoetE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I/zd5W5Kpdzz7a8hgXXrVNlt7NPptAf5TkhzK8WU2XTHf0WSrTICiQ4EfKWLOS/KB
	 xpoNGtDRLzPNelnPpdcTve4j0n3uZeY7KUs7DyecI7mC8oagZdBW1hhthQz15H6Qmq
	 ChgFrQUP73XziSULaRj/kKYDJfynTg+XbxQyu4YE=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4h62fT5J6dzb1g;
	Fri, 24 Jul 2026 11:25:53 +0200 (CEST)
Date: Fri, 24 Jul 2026 11:25:52 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Daniel Durning <danieldurning.work@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Justin Suess <utilityemal77@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/9] security: add LSM blob and hooks for namespaces
Message-ID: <20260724.raec1Roo6iox@digikod.net>
References: <3d4fe99cd1665a1be0b36636aeeaf4ab@paul-moore.com>
 <20260709.kaemaiTia6Li@digikod.net>
 <CAHC9VhSVQ0MLwU=C90FmohAThwaQj-mfB7L03fvkB5A0-J2jCg@mail.gmail.com>
 <20260709.paitheut7Ief@digikod.net>
 <CAHC9VhSrYUWkt0_kbOdEuoeKdj+oSaFcY0Fg8t2SuUwH-=MJXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSrYUWkt0_kbOdEuoeKdj+oSaFcY0Fg8t2SuUwH-=MJXA@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Jul 10, 2026 at 04:42:58PM -0400, Paul Moore wrote:
> On Thu, Jul 9, 2026 at 11:58 AM Mickaël Salaün <mic@digikod.net> wrote:
> > On Thu, Jul 09, 2026 at 09:03:58AM -0400, Paul Moore wrote:
> > > On Thu, Jul 9, 2026 at 5:12 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > > On Wed, Jul 08, 2026 at 11:22:17PM -0400, Paul Moore wrote:
> > > > > On May 27, 2026 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> ...
> 
> > > I'm aware of the new hook guidance, I was the one who documented it :)
> >
> > I know.  I guess that means you're ok with that?
> 
> Yes.

Thanks.  I applied your suggestions wrt comments and patch split for v3.

> 
> Just a heads-up, and some of this depends on timing, but as we've got
> multiple patchsets (there is a SELinux patchset that depends on these
> hooks) I'll want to take this hook additions via the LSM tree.  I can
> take the associated Landlock patches too if you like, or you base the
> Landlock tree off the LSM branch; no worries either way, we can sort
> out the details once the patchset is ready for merging.

If it's all right with you, I'd prefer to carry the LSM hook patches in
the Landlock tree this cycle, so the whole namespace/capability series
stays a single consistent set of commits.  I also have ongoing Landlock
work (e.g. tracepoints) that needs to build on these hooks, which is
easier to manage with them on landlock-next.

That shouldn't hold up the SELinux side: if those patches aren't in a
hurry, letting the hooks stay in the -next branch until the next merge
window also give them some time to get a broader set of checks.  Happy
to revisit if the timing gets tight on your end.
