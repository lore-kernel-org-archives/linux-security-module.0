Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8323F34751B
	for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2026 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636995; cv=none; b=oiHk9kFLU7cFXyWnSD3qais+xTDmOz2bEyTPz56OlovtxcXMnKu9Txu0abHxg7MI2u9q8+FljzzW5An+bv9dlzGWoVCs/Z5BgxlZsnJXHBKglJ9OEGcpVfxT1sUvLaMm9OvOuDv/lIa1Atb0PwnNvvCKMAzHMzeQ+kFFl4ZWzc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636995; c=relaxed/simple;
	bh=YuTMsk3SzAf870WHdlfdjC3bLmpJC1PrJNwwYBkyu7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8Ayqrg6MFkUINGnOcGb8772IMneZi+Sbk8pUt6kTzcZm+gsy4C1GCe5TRA0AMPOnsxzBpp/oCJ/OFr5r8fAztdGSlOCdXM2rd3UcjCKd//R0kJNBfyaA3LOZsy1yZQuMlztxOAmnOtYPwwU3sQlqdRJ2KekMJMvErjZRdWjFo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=i21vltDX; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="i21vltDX"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gfxGk2Q04zVZX;
	Tue, 16 Jun 2026 21:03:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1781636622;
	bh=bK9mMydwdUZO110dKDxOPkPMIkKaLqwVFPP/lQAQyVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i21vltDXuFrTG98Y64Y8XMzSvg3AEfdeEbvcBNbXU5eNDOnFXOB22fLBFMVQqWC31
	 7mL0L2kiRy41ctl4TYFo2LKSQe1HpFHXk91dwPHiehe78xSYl9VYAcQcNHxjQ8y561
	 0dGx7rkCgueSQUbhPqjAu1IpWFrHwwPCMz2PeIHQ=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gfxGj31WjzK7F;
	Tue, 16 Jun 2026 21:03:41 +0200 (CEST)
Date: Tue, 16 Jun 2026 21:03:35 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, sashiko@lists.linux.dev, 
	Roman Gushchin <roman.gushchin@linux.dev>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Subject: Re: Sashiko reviews for the LSM mailing list
Message-ID: <20260616.odush7Poos1A@digikod.net>
References: <20260615.zeinurej8oZ9@digikod.net>
 <CAHC9VhQxHEuznN-xiMJ-LCsz2z-UB0ri6MeMn+Ajyn1WUTDNDw@mail.gmail.com>
 <20260616.EPh8ked0niko@digikod.net>
 <CAHC9VhRa8DQ-ekrmPQSg2pO9pBFj6GA9DO=x5kguGFTbKKyv7Q@mail.gmail.com>
 <20260616.aiGaim8xie8z@digikod.net>
 <CAHC9VhQyN3CczsTHG=sJF8G=MqxGL6NO7assuAjuF9K1t-qDmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQyN3CczsTHG=sJF8G=MqxGL6NO7assuAjuF9K1t-qDmQ@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Tue, Jun 16, 2026 at 11:23:54AM -0400, Paul Moore wrote:
> On Tue, Jun 16, 2026 at 10:59 AM Mickaël Salaün <mic@digikod.net> wrote:
> > On Tue, Jun 16, 2026 at 10:11:42AM -0400, Paul Moore wrote:
> > > On Tue, Jun 16, 2026 at 4:49 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > > On Mon, Jun 15, 2026 at 04:13:59PM -0400, Paul Moore wrote:
> > > > > On Mon, Jun 15, 2026 at 11:41 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > I've been reading Sashiko's (AI bot) reviews wrt Landlock patches, and
> > > > > > most of them were valuable.  It found issues (security or not), but it
> > > > > > requires to go to https://sashiko.dev to find them, which is too easy to
> > > > > > forget, and requires additional work from maintainers to copy or point
> > > > > > to these reviews.  I sent a PR (currently in draft) to enable email
> > > > > > replies from Sashiko to the Linux Security Module mailing list (most
> > > > > > patches are already reviewed anyway):
> > > > > > https://github.com/sashiko-dev/sashiko/pull/278
> > > > > >
> > > > > > Making such reviews broadly available can improve the quality of patches
> > > > > > we receive without much noise, helping for all LSM-related code.  We can
> > > > > > fine tune some email-related settings if needed.
> > > > > >
> > > > > > If there are any concern or question, this is the right time to start a
> > > > > > discussion.
> > > > >
> > > > > I recently enabled Sashiko for the SELinux list to trial it there
> > > > > first, with the goal of eventually bringing this topic up for the rest
> > > > > of the LSM folks on the LSM list.
> > > > >
> > > > > While I think Sashiko's review comments are generally okay, you should
> > > > > have contacted the LSM mailing list folks *before* submitting a PR
> > > > > that would cause an automated bot to send email to the LSM list (this
> > > > > applies to all automated emails, not just LLM reviews).  Please hold
> > > > > the PR until you have given people a chance to comment on the issue.
> > > >
> > > > As I explained just above, the PR is a draft (GitHub specific state for
> > > > WIP), so it cannot be merged as-is, but it is useful for reviews and for
> > > > LSM folks to get a look if they are interested.
> > > >
> > > > > Personally, I'm okay with it.
> > > >
> > > > Looks good.  What about waiting a week to get some feedback here and
> > > > then ask for a merge of the PR?
> > >
> > > I would suggest enabling Sashiko for the LSM list, but not enabling
> > > the email replies at first.  This would allow people to view the
> > > reviews and perhaps make a better informed decision.
> >
> > The point of this PR and the related discussion is to enable email
> > replies ...
> 
> ... and you've heard my opinions on that.
> 
> > the reviews are already there.
> 
> I don't believe the LSM list is being directly reviewed by sashiko.dev
> at the moment (check the lists drop-down in the web UI).  Any
> LSM-posted patches being reviewed are being reviewed due to a CC to a
> sashiko.dev monitored list.

I reiterate my claim that the LSM list is already being reviewed.  You
just need to enter an LSM name in the search box to see the reviewed
patch series.  They are already categorized by mailing list, only the
drop-down menu doesn't list all of them.  For instance, the latest for
AppArmor (neither the LKML nor the LSM mailing list are being explicitly
registered for Sashiko):
https://sashiko.dev/#/patchset/20260613060424.2213712-1-junxiao.chang%40intel.com

> 
> > As explained, my motivation for
> > this change is to get reviews, and without emails I suspect almost nobody
> > (will) take a look and that would not even be an experiment.  I'm saying
> > that because I forgot several times to take a look and it adds more work
> > to the review/maintenance.
> 
> I think it's important to allow people a chance to see what the
> reviews are like before you enable an automated bot on the mailing
> list.  I'm sorry you found it cumbersome to check the web UI, but a
> change to what is sent to the mailing list affects more than just you.
> 
> Perhaps we do eventually enable sashiko.dev to post to the LSM list,
> as I said before I have no problem with that, but I want to give
> people a chance to look at the Sashiko reviews first and make a more
> informed decision.

Sure, I sent this emails to start this discussion, and we can already
take a look, but I guess a drop-down menu will help.  Are you OK to
start with this drop-down menu?

> 
> > FWIW, there are currently 41 kernel mailing lists registered:
> > https://github.com/sashiko-dev/sashiko/blob/main/sashiko.dev/email_policy.toml
> 
> Yes, I think we can all read a configuration file.
> 
> > > > Anyway, it would not be written in
> > > > stone, we can update Sashiko config with new PRs.
> > >
> > > It is worth noting that sashiko.dev updates are not immediate, so
> > > there is a delay between a PR being merged and it taking effect.
> >
> > Sure and I don't think it's an issue.  It's really easy to filter
> > emails on any MUA if really needed, and I'm sure the Sashiko maintainers
> > would be able to fix things quickly if needed.
> 
> I think it's important to understand that not everyone approaches the
> email lists the same way, and something that is a non-issue for you
> might be a larger issue for someone else.

I know, it's not about me.

> 
> As a reminder, you are always welcome to create your own list for
> Landlock if you find that the LSM list no longer meets your needs.
> The only thing I ask is that any patches touching/affecting the LSM
> framework are sent to the LSM list and of course any pull requests
> sent to Linus should CC the LSM list.

That would be easier, but that's an option I would prefer to avoid
because I want everyone to benefit form these reviews.
