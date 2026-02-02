Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BE330EF84
	for <linux-security-module@vger.kernel.org>; Mon,  2 Feb 2026 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770063264; cv=none; b=tF7qrvQj8MIUA1tWwc8KBI6Dnxsnzf4Q+w/Al6k7j6Sst/7aOFY2DcJdcOrN7kuXNZm0mBMklwvStu0gD0A4zIIcJOQmcQmwg1yfTAQPvT1XT+Ua8XxkKwj1+on5i2Q08uTySwDcVHyh+u5HBZPgtjKr9HGdqB0bPEdHQ0NtRg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770063264; c=relaxed/simple;
	bh=pHEp2wDZZm2XgfapiY5kf4TQlX/mBLuPjZFX6Njtvio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OT7TRFhETV/IrwfZGcvbHe2MnXXiGwkULPKTr63HQ9ljcxSXrW7pPq5zPR93Y+d77GJKpkFVeuDfU8PYfYkWoj48thW1p++A1/MScavZUzkLBvy9udCOPrqip5e/2FTf+ZAQj9LzvYqtDynIWDmwDt173oOiDzHd9wModsmfAsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1f7ED7KK; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1f7ED7KK"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f4d9s5JzczlrY;
	Mon,  2 Feb 2026 21:14:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1770063249;
	bh=pGAimY3qVqjHvHRsBS1vObia0CwQLXnrUuR7raL6ZFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1f7ED7KKwiV347yz4n2puCe5CbDx8PDLUpVERQ9U5mBzazQ3Heh9g0TKps7KjBfrS
	 WNwHd7sCJsPlWasvfOsvEVOpbq4S9h7uIFpEoyu/ePf11tivUOWEukuxM13mPsvJnv
	 t1jzJFGIEv3fYlrI8+Wvv8qIRrgl83dBLiMGk0eA=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4f4d9s00Yjzrws;
	Mon,  2 Feb 2026 21:14:08 +0100 (CET)
Date: Mon, 2 Feb 2026 21:14:04 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Justin Suess <utilityemal77@gmail.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 3/6] samples/landlock: Support
 LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
Message-ID: <20260202.eeTh8aiwuhee@digikod.net>
References: <cover.1767115163.git.m@maowtm.org>
 <5e9ac4104e5f70cdf250a3dea9a553a65a36fff9.1767115163.git.m@maowtm.org>
 <20260129.Hizei3ea8eew@digikod.net>
 <5a2e3aad-0eaf-4964-9629-333b36a05ae6@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a2e3aad-0eaf-4964-9629-333b36a05ae6@maowtm.org>
X-Infomaniak-Routing: alpha

On Sat, Jan 31, 2026 at 05:48:24PM +0000, Tingmao Wang wrote:
> On 1/29/26 21:27, Mickaël Salaün wrote:
> > We should have a (potentially small) description of what this patch
> > does, even if it's a bit redundant with the subject.
> >
> >
> > On Tue, Dec 30, 2025 at 05:20:21PM +0000, Tingmao Wang wrote:
> >> Signed-off-by: Tingmao Wang <m@maowtm.org>
> >> ---
> >>
> >> I've decided to use "u" as the character to control this scope bit since
> >> it stands for (normal) Unix sockets.  Imo using "p" or "n" would make it less
> >> clear / memorable.  Open to suggestions.
> >
> > Looks good to me.
> >
> >>
> >> Also, open to suggestion whether socket scoping (pathname and abstract)
> >> should be enabled by default, if LL_SCOPED is not set.  This would break
> >> backward compatibility, but maybe we shouldn't guarentee backward
> >> compatibility of this sandboxer in the first place, and almost all cases
> >> of Landlock usage would want socket scoping.
> >
> > I agree that this example could have better defaults, but this should be
> > done with a standalone patch series.  An important point to keep in mind
> > is that this example is used by developers (e.g. potential copy/paste),
> > so we need to be careful to not encourage them to create code which is
> > backward incompatible.  I think the best way to do it is to request a
> > default behavior for a specific Landlock ABI version (e.g. with a new
> > parameter).
> 
> Just to make sure we're on the same page, I was only talking about whether
> we keep the behavior of the sandboxer "backward compatible" (i.e. if
> someone ran a program that relied on accessing UNIX sockets of more
> privileged programs, if we make the sandboxer start enforcing socket
> scoping by default, their program would stop working under this
> sandboxer), I was not suggesting that we do something which will cause the
> sandboxer itself to no longer work on older kernels.

Yep, I extrapolated a bit.

> 
> But on second thought, the sandboxer is already not designed to be relied
> upon to always behave the same way after an update, since the user don't
> get to choose which handled access rights are added to the ruleset.  With
> new bits added to either ACCESS_FS_ROUGHLY_READ or
> ACCESS_FS_ROUGHLY_WRITE, the policy effectively gets more restrictive
> automatically.  For example, once Günther's patch [1] that adds
> LANDLOCK_ACCESS_FS_RESOLVE_UNIX is merged, the sandboxer will effectively
> starts restricting pathname UNIX sockets "by default" anyway (under any
> dirs not listed in LL_FS_RW).  So maybe we don't need to think too hard
> about this.

Indeed :)

> 
> [1]: https://lore.kernel.org/all/20260119203457.97676-6-gnoack3000@gmail.com/
> 
