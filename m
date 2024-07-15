Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252961891A4;
	Mon, 15 Jul 2024 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721047181; cv=none; b=a63nnqjcQML/G17lnECw7em3K3yaczc88H9BULOIZ3GD+lh1yZP7f+TmlSqFwemNCf+Hq8KmId2KCMSR0Pfj+BC1+/MfFzsOgO361tq9Pg72+L0VIGrN2sMJ7cInmy4H8E6HaFgvvKRX5bXXVUwNHubKEAZnrniewoVvYhqGURA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721047181; c=relaxed/simple;
	bh=urFsKcjAp6UTHzAfM659oLy3mk1/RPrjyvRtDxyWXyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nllTLPjV290LPv6NWF6f2TCDmQv1EGrDQXM59HXrycQyQIU1J//M2DnnGW1UywkTKx8tgYOeTVtxbFaEFAVgijau76cdV+8pJlJhT4ZMyIKlutt1ZP/KRl4TAsTOhprl/du80S4f8pMZf/LjmrFTn1jaxj/EE4qmZGKqQmk8VwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kjCkiobM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kjCkiobM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DBFC32782;
	Mon, 15 Jul 2024 12:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721047180;
	bh=urFsKcjAp6UTHzAfM659oLy3mk1/RPrjyvRtDxyWXyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kjCkiobMrrmzutk0XWXmPF7ovtLU/HHJrgpvpUKqFctINM57tngfPipyqinp8m/Ig
	 7jgaGq/w2YHTx32S01/MJVNrM6qiOc03nnM95/fen55w7SiD5TBBu5KQOS4KztaB29
	 lGjW+F1n8nXHxqQi4m20iXb7VnZnXadIegHb+RZc=
Date: Mon, 15 Jul 2024 14:39:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: CVE-2024-40938: landlock: Fix d_parent walk
Message-ID: <2024071508-prison-liftoff-7987@gregkh>
References: <2024071218-CVE-2024-40938-1619@gregkh>
 <20240715.aeLiunipi8ia@digikod.net>
 <2024071553-yippee-broadways-8035@gregkh>
 <20240715.Eishohd0ehoo@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240715.Eishohd0ehoo@digikod.net>

On Mon, Jul 15, 2024 at 02:20:59PM +0200, Mickaël Salaün wrote:
> On Mon, Jul 15, 2024 at 01:16:38PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Jul 15, 2024 at 12:37:53PM +0200, Mickaël Salaün wrote:
> > > Hello,
> > > 
> > > AFAIK, commit 88da52ccd66e ("landlock: Fix d_parent walk") doesn't fix a
> > > security issue but an unexpected case.  The triggered WARN_ON_ONCE() is
> > > just a canary, and this case was correctly handled with defensive
> > > programming and didn't allow to bypass the security policy nor to harm
> > > the kernel.  However, this fix should indeed be backported.
> > 
> > If a WARN_ON() is hit, a machine with panic_on_warn enabled will reboot,
> > hence if there is any way that userspace can hit this, it needs to be
> > issued a CVE, sorry.
> 
> OK, I didn't know about this panic_on_warn rule for CVE.  Out of
> curiosity, panic_on_warn is definitely useful for fuzzing and testing,
> but what is the rational to enable panic_on_warn on production systems?

People like to have their devices/servers rebooted if _anything_ is seen
to go wrong.  A few billion phones have this enabled, as do most all
cloud servers it seems :(

> It literally transforms a warning message into a system DoS (i.e.
> WARN_ON into BUG_ON).

Yes :(

> We should explicitly use BUG_ON() if this is a critical unhandled
> case, right?

Personally I would use neither, handle the error properly and clean up
correctly.  Only if the continuing to run would cause unrecoverable harm
(i.e. data loss or corruption or compromise) would I ever call BUG_ON().

> > > Could you please Cc me for future CVE related to my changes or to
> > > Landlock?  For kernel CVEs, I think it would be good to Cc at least
> > > maintainers, reviewers, authors, and committers for the related commits.
> > 
> > I suggest setting up lei to watch the linux-cve-announce mailing list if
> > you wish to do this (just filter for landlock stuff).  Automatically
> > mailing cve stuff to maintainers has been deemed too "noisy" which is
> > why we do not do this by default.
> 
> Well, it might be too noisy for some but I guess/hope not for most.
> Email filtering should be easy for the few receiving too many of these
> emails though.

For now we have decided to not cc: maintainers as these are all sent to
a public list that can be subscribed to if they wish to.

thanks,

greg k-h
