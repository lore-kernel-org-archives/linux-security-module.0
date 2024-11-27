Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C667B20010A
	for <linux-security-module@vger.kernel.org>; Wed, 27 Nov 2024 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732743768; cv=none; b=GcRnjOqa5pjzHaqDMXVeX4x1K4qMJMcd/veWHSIGe+Pqllk3p0LiqwvNz7q3enPGRKcQ6Iz+IhlZXsgzQJSKfcGt9JOEz9KLUIeiKsDFA5y7Qr7iZV/SXmmEgUnaqg7+F2RHmTOBsq1xN2iN8lAj+jct4221uu/vQ7LBdakNxBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732743768; c=relaxed/simple;
	bh=dhjTpDAhWClHBfrpQqnrArAoty22MA7J2P0QfwfC7ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2Z98/zrRRZtL0ReC/LP/vEYa3nMpxjZ0X0BxgiwXtqIutnjlXqnjT2UmWllnkeIarP4yEJ0cCREukllRlbtWsgU90+zpCR7TK85ZvTuiFYqpCjnFl4pzEZOOm6LPCrW2Ozr+rVTmtsJtIyiPfTzgWgaLXmE1+Io/DcTh+tAykU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 7909C4B3; Wed, 27 Nov 2024 15:42:43 -0600 (CST)
Date: Wed, 27 Nov 2024 15:42:43 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Serge Hallyn <sergeh@kernel.org>, Paul Moore <paul@paul-moore.com>,
	Jordan Rome <linux@jordanrome.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] capabilities
Message-ID: <20241127214243.GA28695@mail.hallyn.com>
References: <Zztcp-fm9Ln57c-t@lei>
 <CAHk-=wiotQ0isGLKp3EUOdq6sSEb=G=WbnxCfcsDnbszHGXNtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiotQ0isGLKp3EUOdq6sSEb=G=WbnxCfcsDnbszHGXNtw@mail.gmail.com>

On Wed, Nov 27, 2024 at 09:30:14AM -0800, Linus Torvalds wrote:
> On Mon, 18 Nov 2024 at 07:26, <sergeh@kernel.org> wrote:
> >
> > 2. Add a trace event for cap_capable (Jordan Rome).
> 
> So I've finally gotten around to this, but I absolutely detest how
> this was written.
> 
> It was oddly written before, but now it's absolutely illegible.  All
> just to have one single tracepoint.
> 
> And it's all *stupid*.
> 
> The "capable_ns" thing is entirely pointless.
> 
> Why? It always has exactly one value: 'cred->user_ns'. Lookie here,
> it's assigned exactly twice:
> 
>                 if (ns == cred->user_ns) {
>                         if (cap_raised(cred->cap_effective, cap)) {
>                                 capable_ns = ns;
> ...
>                 if ((ns->parent == cred->user_ns) && uid_eq(ns->owner,
> cred->euid)) {
>                         capable_ns = ns->parent;
> 
> and *both* times it's assigned something that we just checked is equal
> to cred->user_ns.
> 
> And for this useless value, the already odd for-loop was written to be
> even more odd, and the code added a new variable 'capable_ns'.
> 
> So I pulled this, tried to figure out _why_ it was written that oddly,
> decided that the "why" was "because it's being stupid", and I unpulled
> it again.
> 
> If we really need that trace point, I have a few requirements:
> 
>  - none of this crazy stuff
> 
>  - use a simple inline helper
> 
>  - make the pointers 'const', because there is no reason not to.
> 
> Something *UNTESTED* like the attached diff.
> 
> Again: very untested. But at least this generates good code, and
> doesn't have pointless crazy variables. Yes, I add that
> 
>         const struct user_namespace *cred_ns = cred->user_ns;
> 
> because while I think gcc may be smart enough to figure out that it's
> all the same value, I wanted to make sure.
> 
> Then the tracepoint would look something like
> 
>         trace_cap_capable(cred, targ_ns,  cred_ns, cap, opts, ret);
> 
> although I don't understand why you'd even trace that 'opts' value
> that is never used.

You mean cap_capable doesn't use opts?  Yeah, it's used only by other
LSMs.  I suppose knowing the value might in some cases help to figure
out caller state, but dropping it seems sensible.

Jordan is working on a new version based on your feedback.

thanks,
-serge
