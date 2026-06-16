Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C1F35201E
	for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2026 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621957; cv=none; b=mcCqwn1YU4dHRXw29kE+GcpH9Qeg/L/wCSq9gl1zlDywRnCSooFggzAbBon8DqyMXSnaYY4vBY4w0mCB7PkdH0JazdaxYto58emtfCo0npgKB2CZcgYwBoacxr3O9YGo6ELCFhvpAX2awkwcM8tpblYgmWg+/BkXXLIwG9AH8LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621957; c=relaxed/simple;
	bh=X3fMR/ZEXbBI2Z/cLtrzizXZ1ayrDE1uxGtCK0hPD/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwQhGUoEh/Ugky8hwK2JFLvdaaA0o5HLRgVLD23/IIHXhUBiqDR0onryN+6RRWnt8jesqgbJf25alNmmjChdzF4h95p7T7YphvRBVoz2rwHeVWHT5wIs+/C/7WmNYFhnYAIu40yePWOX2ojlWfDqcbLfiHFgku2p34+vz5HMmWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=lWpoKd/j; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="lWpoKd/j"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gfqrT73GQzVpZ;
	Tue, 16 Jun 2026 16:59:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1781621945;
	bh=lFcV+TOiD9eSMYUz56NI27zzZP05fiAm12hr7lGdHU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lWpoKd/jQzXQVwFsUfpbYMcS3ZsT8Iuj6++MnD96DwLkCqO+l6MUkKfaYkBsUhbxo
	 8ccDhJbHkv3ICPLnIO9yKXaCidZ4D9UOJJXYkDhU+5yjU2DJMANS7YrA1/fnlg7Ch1
	 oC1pJIUYJ5YECjhOrt3hpIerzeLTziRkV5kyiz40=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gfqrS6rshzKn6;
	Tue, 16 Jun 2026 16:59:04 +0200 (CEST)
Date: Tue, 16 Jun 2026 16:59:03 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, sashiko@lists.linux.dev, 
	Roman Gushchin <roman.gushchin@linux.dev>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Subject: Re: Sashiko reviews for the LSM mailing list
Message-ID: <20260616.aiGaim8xie8z@digikod.net>
References: <20260615.zeinurej8oZ9@digikod.net>
 <CAHC9VhQxHEuznN-xiMJ-LCsz2z-UB0ri6MeMn+Ajyn1WUTDNDw@mail.gmail.com>
 <20260616.EPh8ked0niko@digikod.net>
 <CAHC9VhRa8DQ-ekrmPQSg2pO9pBFj6GA9DO=x5kguGFTbKKyv7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRa8DQ-ekrmPQSg2pO9pBFj6GA9DO=x5kguGFTbKKyv7Q@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Tue, Jun 16, 2026 at 10:11:42AM -0400, Paul Moore wrote:
> On Tue, Jun 16, 2026 at 4:49 AM Mickaël Salaün <mic@digikod.net> wrote:
> > On Mon, Jun 15, 2026 at 04:13:59PM -0400, Paul Moore wrote:
> > > On Mon, Jun 15, 2026 at 11:41 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I've been reading Sashiko's (AI bot) reviews wrt Landlock patches, and
> > > > most of them were valuable.  It found issues (security or not), but it
> > > > requires to go to https://sashiko.dev to find them, which is too easy to
> > > > forget, and requires additional work from maintainers to copy or point
> > > > to these reviews.  I sent a PR (currently in draft) to enable email
> > > > replies from Sashiko to the Linux Security Module mailing list (most
> > > > patches are already reviewed anyway):
> > > > https://github.com/sashiko-dev/sashiko/pull/278
> > > >
> > > > Making such reviews broadly available can improve the quality of patches
> > > > we receive without much noise, helping for all LSM-related code.  We can
> > > > fine tune some email-related settings if needed.
> > > >
> > > > If there are any concern or question, this is the right time to start a
> > > > discussion.
> > >
> > > I recently enabled Sashiko for the SELinux list to trial it there
> > > first, with the goal of eventually bringing this topic up for the rest
> > > of the LSM folks on the LSM list.
> > >
> > > While I think Sashiko's review comments are generally okay, you should
> > > have contacted the LSM mailing list folks *before* submitting a PR
> > > that would cause an automated bot to send email to the LSM list (this
> > > applies to all automated emails, not just LLM reviews).  Please hold
> > > the PR until you have given people a chance to comment on the issue.
> >
> > As I explained just above, the PR is a draft (GitHub specific state for
> > WIP), so it cannot be merged as-is, but it is useful for reviews and for
> > LSM folks to get a look if they are interested.
> >
> > > Personally, I'm okay with it.
> >
> > Looks good.  What about waiting a week to get some feedback here and
> > then ask for a merge of the PR?
> 
> I would suggest enabling Sashiko for the LSM list, but not enabling
> the email replies at first.  This would allow people to view the
> reviews and perhaps make a better informed decision.

The point of this PR and the related discussion is to enable email
replies, the reviews are already there.  As explained, my motivation for
this change is to get reviews, and without emails I suspect almost nobody
(will) take a look and that would not even be an experiment.  I'm saying
that because I forgot several times to take a look and it adds more work
to the review/maintenance.

FWIW, there are currently 41 kernel mailing lists registered:
https://github.com/sashiko-dev/sashiko/blob/main/sashiko.dev/email_policy.toml

> 
> > Anyway, it would not be written in
> > stone, we can update Sashiko config with new PRs.
> 
> It is worth noting that sashiko.dev updates are not immediate, so
> there is a delay between a PR being merged and it taking effect.

Sure and I don't think it's an issue.  It's really easy to filter
emails on any MUA if really needed, and I'm sure the Sashiko maintainers
would be able to fix things quickly if needed.
