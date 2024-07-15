Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F23573446
	for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2024 18:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721066669; cv=none; b=YgJ4VJFixnNHMPsoDW2aqxy0xRUU5uP0SErU95t3Au+yHFwQWlaD0CjRL5MNsPbJFtBCg80IDy+VDGIupe+OOaQlGDLI9by4ytb80dqyPLQuDd+kcspgyWIBQs977nPJBg2xM+KLL6EMPSSHQ17pM5rWxsLUEmq/8iulbhMXX1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721066669; c=relaxed/simple;
	bh=qTCr6QL4J6++WwWH8o7u6xeqNvp1YHa3q8UcBYI2COY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCB22EOYE+wmzcmcSZljz+7PVY4ZZzCrEMzTWHIYLhiUB1UrLdl1uvNuREu66Co+TTQr2rjxlzXskd+LP3rQH70OyuiSLGqdiGl7x4tkMKwsOEOG4hvy2RK8XvoUxdO8wWp/4+DnrlvrykkzsbbWn4hhSHIHCda5OmOmbc16f6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=QTdnTKbU; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="QTdnTKbU"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WN97q1T5dzP8D;
	Mon, 15 Jul 2024 20:04:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721066663;
	bh=Ts0JRV5RTp+wreMPGmJVZjdkQk90kW48JRHm2YH+ldE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QTdnTKbUTMwd+hU3fxrktta6iCELFR/pBAtMWtEc5LIfYSAFlOn93v8NBLXiFKwyK
	 p9rUYVyFbKbHLQ/kAlicr9hjkBFiMYJacblnaqX/sQsmfGpzVivvwUn5OkVEXDSMCU
	 7aE9xaO4nWAl5FBuw0GumVKqmx9jo4EkGUOONRMo=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WN97p4pZrz115;
	Mon, 15 Jul 2024 20:04:22 +0200 (CEST)
Date: Mon, 15 Jul 2024 20:04:21 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <kees@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, cve@kernel.org, 
	linux-kernel@vger.kernel.org, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: CVE-2024-40938: landlock: Fix d_parent walk
Message-ID: <20240715.seingevie9Ph@digikod.net>
References: <2024071218-CVE-2024-40938-1619@gregkh>
 <20240715.aeLiunipi8ia@digikod.net>
 <2024071553-yippee-broadways-8035@gregkh>
 <20240715.Eishohd0ehoo@digikod.net>
 <202407150908.34E00AAD1@keescook>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202407150908.34E00AAD1@keescook>
X-Infomaniak-Routing: alpha

On Mon, Jul 15, 2024 at 09:11:35AM -0700, Kees Cook wrote:
> On Mon, Jul 15, 2024 at 02:20:59PM +0200, Mickaël Salaün wrote:
> > On Mon, Jul 15, 2024 at 01:16:38PM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Jul 15, 2024 at 12:37:53PM +0200, Mickaël Salaün wrote:
> > > > Hello,
> > > > 
> > > > AFAIK, commit 88da52ccd66e ("landlock: Fix d_parent walk") doesn't fix a
> > > > security issue but an unexpected case.  The triggered WARN_ON_ONCE() is
> > > > just a canary, and this case was correctly handled with defensive
> > > > programming and didn't allow to bypass the security policy nor to harm
> > > > the kernel.  However, this fix should indeed be backported.
> > > 
> > > If a WARN_ON() is hit, a machine with panic_on_warn enabled will reboot,
> > > hence if there is any way that userspace can hit this, it needs to be
> > > issued a CVE, sorry.
> > 
> > OK, I didn't know about this panic_on_warn rule for CVE.  Out of
> > curiosity, panic_on_warn is definitely useful for fuzzing and testing,
> > but what is the rational to enable panic_on_warn on production systems?
> > It literally transforms a warning message into a system DoS (i.e.
> > WARN_ON into BUG_ON).  We should explicitly use BUG_ON() if this is a
> > critical unhandled case, right?
> 
> We need a way to raise WARN to panic for deployments that have tested
> their workloads and want FORTIFY_SOURCE and UBSAN_BOUNDS to actually

OK, I guess it makes sense if we know and tested all the possible
execution paths and states, which is challenging, but I get your point.
However, for this use case, I don't see the point of promoting a WARN_ON
issue to a CVE.

> perform mitigations instead of just warning. Linus rejected all prior
> knobs for this and panic_on_warn (or better yet, kernel.warn_limit
> syscall) is used for this purpose.
> 
> Userspace actions must never be able to reach a WARN or BUG state:
> https://docs.kernel.org/process/deprecated.html#bug-and-bug-on

Yes, that's why we use WARN_ON_ONCE() to check cases that should never
happen (at the time of writting), but in practice it's useful to check
(with fuzzing) that this assertion is true.  However, if a
WARN_ON_ONCE() is reached, this doesn't mean that this is a security
issue, but just an unexpected case that kernel maintainers should be
notified with to fix it.
