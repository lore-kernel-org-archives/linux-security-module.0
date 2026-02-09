Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694B833291B
	for <linux-security-module@vger.kernel.org>; Mon,  9 Feb 2026 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770668453; cv=none; b=Wl6i2alOtgvDl4CS/ThRNoGN/Dq6x8toI5ttDTb8bfCKdtp1Zwj1FjhrjKbz5CESRS925RbTIq4aCPPKpfrRV3ivo+Zd6ZE2kff4sGT+kV6SKaFR+H1wLoi7n8QBg58woK4UCN0ve57bi8RT5TXBFKH9u6umrqRrOcFxISFDAhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770668453; c=relaxed/simple;
	bh=pgNGnI4rxDunafH3jkuRQQSxCJwSr1DQ+JC6kMmEHbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ny1k2xd0k7QGFJPDZiJ9Ay+6zkWPnfzeMImYnpjZYRGqMEDIjF+rDv7kD6DQcCX2C+jv0iViVoy8pVJA3pDHZ5nI9eU3cT4ve+xLzOS447wxYDHORxF92WH/aco1BTyXHClDuAlo41A1aAoqwU3CMsqEcahlx1eFHFRzxtqfkOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=IyJC97TM; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="IyJC97TM"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f8x090XRQznNg;
	Mon,  9 Feb 2026 21:20:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1770668440;
	bh=39PhqqZD+UIrxoRN8ceRRZN4e+vXjo3E7BPOOI6LL2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IyJC97TMZT7Fp/q2XpCG8mo702bQGTO9gpRYK0+geiKrujVG56KjHF1HSluJxK1nq
	 /1fBMpNtwEbfbF5VuWOcAIfNh/OAdg5886w3bqxcoz92ytpfH7CV8BKJjc+kW4wwOG
	 QPIaHjBvuqWKUKKoYJAlH+AoY3PYfnF5nDq+HE9Y=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4f8x081g4nzJd0;
	Mon,  9 Feb 2026 21:20:40 +0100 (CET)
Date: Mon, 9 Feb 2026 21:20:36 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Justin Suess <utilityemal77@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, John Johansen <john.johansen@canonical.com>, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Matthieu Buffet <matthieu@buffet.re>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Landlock: Implement scope control for pathname
 Unix sockets
Message-ID: <20260209.aer1Eiph0Iej@digikod.net>
References: <16129d76-b6d3-4959-b241-dc79a32dd0cd@maowtm.org>
 <aYI2OQhPMgdMAOiz@google.com>
 <e6b6b069-384c-4c45-a56b-fa54b26bc72a@maowtm.org>
 <aYMxHRwHCao30HfX@google.com>
 <20260204.quaiyeiW9ipo@digikod.net>
 <20260205.8531e4005118@gnoack.org>
 <20260205.Kiech3gupee1@digikod.net>
 <ee38960f-8670-434b-9cf1-d95995b228da@maowtm.org>
 <20260208.4600394b9da7@gnoack.org>
 <c33926c5-3c7a-40d8-b910-ac99b43576ff@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c33926c5-3c7a-40d8-b910-ac99b43576ff@maowtm.org>
X-Infomaniak-Routing: alpha

On Sun, Feb 08, 2026 at 08:48:22PM +0000, Tingmao Wang wrote:
> On 2/8/26 20:37, Günther Noack wrote:
> > On Sun, Feb 08, 2026 at 02:57:10AM +0000, Tingmao Wang wrote:
> >> On 2/5/26 10:27, Mickaël Salaün wrote:
> >>> On Thu, Feb 05, 2026 at 09:02:19AM +0100, Günther Noack wrote:
> >>>> [...]
> >>>>
> >>>> The implementation of this approach would be that we would have to
> >>>> join the functionality from the scoped and FS-based patch set, but
> >>>> without introducing the LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET flag in
> >>>> the UAPI.
> >>>
> >>> Right, this looks good to me.  We'll need to sync both patch series and
> >>> remove the scope flag from UAPI.  I'll let you and Tingmao work together
> >>> for the next series.  The "IPC scoping" documentation section should
> >>> mention LANDLOCK_ACCESS_FS_RESOLVE_UNIX even if it's not a scope flag.
> >>
> >> This sounds good to me.  I'm not sure how much code we can reuse out of
> >> the existing LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET patchset - but I think
> >> the selftest patches could still largely be useful (after changing e.g.
> >> create_scoped_domain() to use the RESOLVE_UNIX fs access instead of the
> >> scope bit for pathname sockets).  The fs-based rules (i.e. "exceptions")
> >> can then be tested separately from the scope tests (and would also check
> >> for things like path being different across mount namespaces etc).
> >>
> >> Günther, feel free to take anything out of the existing scope series, if
> >> you feel it would be useful.  Also let me know if you would like me to
> >> help with any part of the RESOLVE_UNIX series if you feel that would be
> >> useful (but you don't have to if not).
> >
> > Thank you, Tingmao!
> >
> > So far, the selftests that I already had in fs_test.c were
> > straightforward to extend so that they cover the new cases.  I had a
> > look at your patch set, but found the scoping tests difficult to port
> > to fs_test.c
> 
> I was thinking that the tests in scoped_abstract_unix_test.c could be
> extended to test scoping of pathname UNIX sockets as well (otherwise
> wouldn't you have to write another instance of the scoped_domains test
> based on scoped_base_variants.h, whether you put it in fs_test.c or
> somewhere else?)
> 
> And if you think that is sensible, then I'm hoping that patch 4,5,6 of the
> series would be mostly useful.  But it's up to you :)

I agree that these 3 patches should be integrated (see my other reply on
Günther's v4).

> 
> > , but I'll double check that we don't miss anything.
> > Either way, I'll make sure that you'll get appropriate credit for
> > it. :)
> 
> Thanks!
> 
> Tingmao
> 
> > ...
> 
