Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B221BD9C1
	for <linux-security-module@vger.kernel.org>; Thu, 28 Nov 2024 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732811349; cv=none; b=G0M3WdUAbAwcP3OIWzzIbC+9kjFfgk01XfmbONl62NehAjRYSA7O7R2jCgUYAeDFeoosh+1/HYTfWQ8XNmSCRF8GMgRsW1TDl9Z0qsWaJqiZS01jYohgiO3mu/+5qlCtqyck5l8gE6mq48l81Gl+EzDpURxB5r3IQeBwEGx0e4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732811349; c=relaxed/simple;
	bh=e0wfWjSleIBlGJvkb54Ss1rj/qQ0JiteCkN+CQxwt5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfIdpw2kpLI+cNIn2vcT1yPg5DGy8yP+Ik/BqriXreEJkKaxUGIaIGVCOBVjyKZQ9ZaaPC7zIuzd8HrkLhJhw2jvH2VpmaEaUqcyMu9cP9iMF4OtBEfLIpXTlNkSIJsPinhSttr/5mBDb3YDqw0hm71vY9A3f+gU5OPhbfgTV0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 6259755E; Thu, 28 Nov 2024 10:28:56 -0600 (CST)
Date: Thu, 28 Nov 2024 10:28:56 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jordan Rome <linux@jordanrome.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Serge Hallyn <sergeh@kernel.org>, Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] capabilities
Message-ID: <20241128162856.GA40355@mail.hallyn.com>
References: <Zztcp-fm9Ln57c-t@lei>
 <CAHk-=wiotQ0isGLKp3EUOdq6sSEb=G=WbnxCfcsDnbszHGXNtw@mail.gmail.com>
 <20241127214243.GA28695@mail.hallyn.com>
 <CA+QiOd6pNMzAxsHsr11oyJNY5V9DLAxSdECC37X_WYDHbv4v0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+QiOd6pNMzAxsHsr11oyJNY5V9DLAxSdECC37X_WYDHbv4v0Q@mail.gmail.com>

On Thu, Nov 28, 2024 at 10:42:16AM -0500, Jordan Rome wrote:
> On Wed, Nov 27, 2024 at 4:42 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> >
> > On Wed, Nov 27, 2024 at 09:30:14AM -0800, Linus Torvalds wrote:
> > > On Mon, 18 Nov 2024 at 07:26, <sergeh@kernel.org> wrote:
> > > >
> > > > 2. Add a trace event for cap_capable (Jordan Rome).
> > >
> > > So I've finally gotten around to this, but I absolutely detest how
> > > this was written.
> > >
> > > It was oddly written before, but now it's absolutely illegible.  All
> > > just to have one single tracepoint.
> > >
> > > And it's all *stupid*.
> > >
> > > The "capable_ns" thing is entirely pointless.
> > >
> > > Why? It always has exactly one value: 'cred->user_ns'. Lookie here,
> > > it's assigned exactly twice:
> > >
> > >                 if (ns == cred->user_ns) {
> > >                         if (cap_raised(cred->cap_effective, cap)) {
> > >                                 capable_ns = ns;
> > > ...
> > >                 if ((ns->parent == cred->user_ns) && uid_eq(ns->owner,
> > > cred->euid)) {
> > >                         capable_ns = ns->parent;
> > >
> > > and *both* times it's assigned something that we just checked is equal
> > > to cred->user_ns.
> > >
> > > And for this useless value, the already odd for-loop was written to be
> > > even more odd, and the code added a new variable 'capable_ns'.
> > >
> > > So I pulled this, tried to figure out _why_ it was written that oddly,
> > > decided that the "why" was "because it's being stupid", and I unpulled
> > > it again.
> > >
> > > If we really need that trace point, I have a few requirements:
> > >
> > >  - none of this crazy stuff
> > >
> > >  - use a simple inline helper
> > >
> > >  - make the pointers 'const', because there is no reason not to.
> > >
> > > Something *UNTESTED* like the attached diff.
> > >
> > > Again: very untested. But at least this generates good code, and
> > > doesn't have pointless crazy variables. Yes, I add that
> > >
> > >         const struct user_namespace *cred_ns = cred->user_ns;
> > >
> > > because while I think gcc may be smart enough to figure out that it's
> > > all the same value, I wanted to make sure.
> > >
> > > Then the tracepoint would look something like
> > >
> > >         trace_cap_capable(cred, targ_ns,  cred_ns, cap, opts, ret);
> > >
> > > although I don't understand why you'd even trace that 'opts' value
> > > that is never used.
> >
> > You mean cap_capable doesn't use opts?  Yeah, it's used only by other
> > LSMs.  I suppose knowing the value might in some cases help to figure
> > out caller state, but dropping it seems sensible.
> >
> > Jordan is working on a new version based on your feedback.
> >
> > thanks,
> > -serge
> 
> Here is the new patch:
> https://patchwork.kernel.org/project/linux-security-module/patch/20241128153733.1542817-1-linux@jordanrome.com/
> 
> I applied the suggested changes but left the local `struct
> user_namespace *ns` in the helper (as it gets updated in the loop to
> the ns parent).
> Though it feels a bit icky that there is not a null check against the
> `ns` variable (maybe it's not possible to reach that condition
> though).

Feels like a lot of bikeshedding here, but...

Is there any reason at this point not to just pass in cred_euid as a uid_t,
and not pass the cred in at all?  Avoid a few more dereferences...
