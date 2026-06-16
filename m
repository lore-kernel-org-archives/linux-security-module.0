Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD26930AD0A
	for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2026 08:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599806; cv=none; b=Hh46jxfCdLHzvti62gVfE49TuS7pF0grwLAkXDNAoy3fd2NKlkPr9pf6xyPnmwXbAETvYGpARkK+C5HrXa1W6V5quti7sNzi2hRdGSSk3nG1W8/EChY6epIDrmfeZmOl4pavUR161cSY/bXnjTULMyWTzFArfoKg9lSnEcdNa0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599806; c=relaxed/simple;
	bh=uGieTqiWAYjeIR92NQ4M3tFxM0kmXf3nWH4SXSKoXss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1P6XyNQtYQxm1UtkmKEl6VQ8Ln8zJdW0Rmtn10b8dbwcLQJj0dD/g5dACMW3FevQVSo2rmYRiJw+Qb4+Wzqo6YDOlxO+kb+lMVxZO1hRnix9pqyxLYJaNtU1CnBKjcTzFaGlvuE+G7rNxYGTP5QgIJI/XAb1PSsbEEcnBt0Rfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=RG8Hkbta; arc=none smtp.client-ip=83.166.143.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="RG8Hkbta"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gfgfT5wH9zfYS;
	Tue, 16 Jun 2026 10:49:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1781599793;
	bh=+FmqWYCTPnBUhtjFsDkCf2D0Q6mewo7WFk3/+e78ytk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RG8HkbtahZmqOaiDbAvsDIk4eG+8AwxnaCwhltw4frOyBNrGP7mRNrcMBmXe+PWh3
	 kwHD8q/fYHzNpLvBH0Weq+BvWqATQl0fdr47f65qVX/heYyxfYUz2PZoCgBqizy5Tw
	 3EZoLkGtP00IANpCu0sFWtHekvnxQZTJyzSXGO/M=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gfgfS5sv3zGfM;
	Tue, 16 Jun 2026 10:49:52 +0200 (CEST)
Date: Tue, 16 Jun 2026 10:49:51 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, sashiko@lists.linux.dev, 
	Roman Gushchin <roman.gushchin@linux.dev>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Subject: Re: Sashiko reviews for the LSM mailing list
Message-ID: <20260616.EPh8ked0niko@digikod.net>
References: <20260615.zeinurej8oZ9@digikod.net>
 <CAHC9VhQxHEuznN-xiMJ-LCsz2z-UB0ri6MeMn+Ajyn1WUTDNDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQxHEuznN-xiMJ-LCsz2z-UB0ri6MeMn+Ajyn1WUTDNDw@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Jun 15, 2026 at 04:13:59PM -0400, Paul Moore wrote:
> On Mon, Jun 15, 2026 at 11:41 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > Hi,
> >
> > I've been reading Sashiko's (AI bot) reviews wrt Landlock patches, and
> > most of them were valuable.  It found issues (security or not), but it
> > requires to go to https://sashiko.dev to find them, which is too easy to
> > forget, and requires additional work from maintainers to copy or point
> > to these reviews.  I sent a PR (currently in draft) to enable email
> > replies from Sashiko to the Linux Security Module mailing list (most
> > patches are already reviewed anyway):
> > https://github.com/sashiko-dev/sashiko/pull/278
> >
> > Making such reviews broadly available can improve the quality of patches
> > we receive without much noise, helping for all LSM-related code.  We can
> > fine tune some email-related settings if needed.
> >
> > If there are any concern or question, this is the right time to start a
> > discussion.
> 
> I recently enabled Sashiko for the SELinux list to trial it there
> first, with the goal of eventually bringing this topic up for the rest
> of the LSM folks on the LSM list.
> 
> While I think Sashiko's review comments are generally okay, you should
> have contacted the LSM mailing list folks *before* submitting a PR
> that would cause an automated bot to send email to the LSM list (this
> applies to all automated emails, not just LLM reviews).  Please hold
> the PR until you have given people a chance to comment on the issue.

As I explained just above, the PR is a draft (GitHub specific state for
WIP), so it cannot be merged as-is, but it is useful for reviews and for
LSM folks to get a look if they are interested.

> 
> Personally, I'm okay with it.

Looks good.  What about waiting a week to get some feedback here and
then ask for a merge of the PR?  Anyway, it would not be written in
stone, we can update Sashiko config with new PRs.

> 
> --
> paul-moore.com
> 
