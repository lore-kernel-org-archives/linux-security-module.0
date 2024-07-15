Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62368189F5C
	for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2024 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721046074; cv=none; b=E1ULlFPVi/Y085YR857vDsPeRMmkkZ2/r0iBHE5oDRRRwSX9pc1aLZEU9j9ZYEO1nDTiVNR8q+BIX/I913r1MJgQR2haayPZCdMmc9ThjzVvu77yBMVK1n9D2SybwILFDVLAIA1EA+qL46G1oeXgP1PwVa8xx2sDwr1r0KJexWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721046074; c=relaxed/simple;
	bh=qLeSM8yy9Pm45fo+A7K1Jltke1y6CtzYxPtAFqAQmWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7Xl7ZJq3d3zi7K9oYWgaA0NWRGBiKgOVnW4Q3CpwmM29YpnOVJ6Wupz/IEdr90xEmL57d0wsurbJ5guSfsua8aLi3xkba3XAzeZSetlVZM7NNksXe8SV4p6NC6kz1kpSC/i1Uh26+diI33RxJM3fNKb0s5ir1yo/jDFM2qp4iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=J+TUa4ey; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="J+TUa4ey"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WN1Wd40wKzgCQ;
	Mon, 15 Jul 2024 14:21:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721046061;
	bh=sTqWvowT9CGlN8d5YXZBulF2bbw/PtMqLh9miq/PfrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+TUa4eypLG7kr9QeXVxab92+lL1eTU2yn3O/0spQ6YkXSLqrDVQ/P7+6fktYUqBE
	 wLPCmKdFqsL3KZ5WujJsdro8mFLLaM85FrxFGGSo/hdzWThflw1ZzMT5AjH8O9F8T2
	 UVoiXHxXzH8UHKQXWKhmANsBLiVu+99X3KOMqIbE=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WN1Wc6TYhzwYx;
	Mon, 15 Jul 2024 14:21:00 +0200 (CEST)
Date: Mon, 15 Jul 2024 14:20:59 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, linux-security-module@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: CVE-2024-40938: landlock: Fix d_parent walk
Message-ID: <20240715.Eishohd0ehoo@digikod.net>
References: <2024071218-CVE-2024-40938-1619@gregkh>
 <20240715.aeLiunipi8ia@digikod.net>
 <2024071553-yippee-broadways-8035@gregkh>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024071553-yippee-broadways-8035@gregkh>
X-Infomaniak-Routing: alpha

On Mon, Jul 15, 2024 at 01:16:38PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 15, 2024 at 12:37:53PM +0200, Mickaël Salaün wrote:
> > Hello,
> > 
> > AFAIK, commit 88da52ccd66e ("landlock: Fix d_parent walk") doesn't fix a
> > security issue but an unexpected case.  The triggered WARN_ON_ONCE() is
> > just a canary, and this case was correctly handled with defensive
> > programming and didn't allow to bypass the security policy nor to harm
> > the kernel.  However, this fix should indeed be backported.
> 
> If a WARN_ON() is hit, a machine with panic_on_warn enabled will reboot,
> hence if there is any way that userspace can hit this, it needs to be
> issued a CVE, sorry.

OK, I didn't know about this panic_on_warn rule for CVE.  Out of
curiosity, panic_on_warn is definitely useful for fuzzing and testing,
but what is the rational to enable panic_on_warn on production systems?
It literally transforms a warning message into a system DoS (i.e.
WARN_ON into BUG_ON).  We should explicitly use BUG_ON() if this is a
critical unhandled case, right?

> 
> > Could you please Cc me for future CVE related to my changes or to
> > Landlock?  For kernel CVEs, I think it would be good to Cc at least
> > maintainers, reviewers, authors, and committers for the related commits.
> 
> I suggest setting up lei to watch the linux-cve-announce mailing list if
> you wish to do this (just filter for landlock stuff).  Automatically
> mailing cve stuff to maintainers has been deemed too "noisy" which is
> why we do not do this by default.

Well, it might be too noisy for some but I guess/hope not for most.
Email filtering should be easy for the few receiving too many of these
emails though.
