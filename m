Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4F933F5A7
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 21:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785533720; cv=none; b=tHF7I6o7Ly2E2garoKeTwWajZGrR6J2LlQuRB2mBfGk1gejqpRGdulxdDD/ZQ1KKoZzo6WAxR8+PlG6iSkZvLCwxhoxEFsrTmZqipz5+Zoyee5l8cH6PziD5M9gETSyxrTtUIhZqlI7QlQ+bKHXmCk2CyXpnOrWDwsNOFvVdXX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785533720; c=relaxed/simple;
	bh=lRJnPb5IyHrYDhU8eaqQcAyH4c4BsS2t9aS18UJUtJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzG2A++4nkg+LnIs5eSaI1eLSYPmMpLlmnPMmoPni67rZ+9t7R++GAMzpupvRrBdqtbbW09boi71i0xvq9TdN5DFjpVj1pr0tNuK6t3CFxBakPQUzqV4IdH2/FNDBm3LSkfuy1Kg7pP4eCvjpVlX3X02TAkkBq/a4m2CoWieXTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=RGoxttdP; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="RGoxttdP"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hBfLd667Lzg2Z;
	Fri, 31 Jul 2026 23:28:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1785533289;
	bh=Jh8yyEG94IUXqQPzVoAP68vvx+qZg88VGYDQYueKAok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RGoxttdPQYlwCMGtM57sU/FVo2GA+9WRlwVVqhNJ4eoM0gCy0TvzQXY/ojbtCFg/Q
	 xM7TlxjAlC1Kj4H8O5I0QDRpV1RNZDLFgvmQonz/LU+aCQzAtAAinaCbOPej7yL0uR
	 x/92rqcENta750qzgV5iVNE7ZIT3oMa+xJoDkG0s=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hBfLd1rgtzs0c;
	Fri, 31 Jul 2026 23:28:09 +0200 (CEST)
Date: Fri, 31 Jul 2026 23:27:58 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Justin Suess <utilityemal77@gmail.com>
Cc: Simon McVittie <smcv@collabora.com>, 
	linux-security-module@vger.kernel.org, gnoack@google.com
Subject: Re: [PATCH 0/3] Implement LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC
Message-ID: <20260731.saiXaPew4voo@digikod.net>
References: <20260708133928.852999-1-utilityemal77@gmail.com>
 <20260709.Eaphooyoh6sh@digikod.net>
 <ak-EgMPeFtH8MAQP@descent>
 <alJwpLRgqpKXAutX@suesslenovo>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alJwpLRgqpKXAutX@suesslenovo>
X-Infomaniak-Routing: alpha

On Sat, Jul 11, 2026 at 01:00:20PM -0400, Justin Suess wrote:
> On Thu, Jul 09, 2026 at 12:22:40PM +0100, Simon McVittie wrote:
> > On Thu, 09 Jul 2026 at 12:09:25 +0200, Mickaël Salaün wrote:
> > > On Wed, Jul 08, 2026 at 09:39:24AM -0400, Justin Suess wrote:
> > > > Consider a sandbox launcher that depends on a set-user-ID helper, such
> > > > as launching applications through bubblewrap on distributions where
> > > > unprivileged user namespaces are disabled and bwrap is installed
> > > > set-user-ID root.
> > 
> > It's perhaps worth noting that the current version 0.11.2 of bubblewrap
> > deprecates this mode of use (it will refuse to run while setuid unless
> > that was explicitly enabled at compile-time), and the next release 0.12.0
> > will also remove the ability to enable it at compile-time.
> > 
> > When bubblewrap was first written, having it be setuid was a necessary
> > workaround for kernels/distros not letting it do its sandboxing job any
> > other way; but now that unprivileged user namespaces are more widespread,
> > its maintainers have come to the conclusion that when it's setuid,
> > the risk of vulnerabilities that allow a root privilege escalation
> > (CVE-2020-5291, CVE-2026-41163) is unacceptably high, so being able to
> > make it setuid is no longer a good trade-off.
> > 
> > > > This flag also closes a gap for CAP_SYS_ADMIN callers of
> > > > landlock_restrict_self(2) itself.  The no_new_privs/CAP_SYS_ADMIN
> > > > requirement exists to keep set-user-ID programs from running confused
> > > > inside a sandbox they do not expect.  However, a privileged process
> > > > that enforces a domain without setting no_new_privs leaves that hole
> > > > open for all of its descendants
> > > 
> > > In a nutshell, not setting NNP might be risky, even when not strictly
> > > needed.  We might want to update the Landlock doc with that.
> > 
> > If the CAP_SYS_ADMIN caller is setuid or setcap, then it has been
> > granted special privileges by the sysadmin or distro, and part of
> > the "contract" between the sysadmin/distro and the setuid program is
> > that setuid/setcap must only be set on executables that have taken
> > responsibility for ensuring that they can't create insecure situations
> > (for example bubblewrap always sets PR_SET_NO_NEW_PRIVS, unconditionally,
> > for this reason).
> > 
> > A large part of why bubblewrap no longer supports being setuid is that
> > its maintainers don't want it to have this heavy responsibility.
> >
> Understandable. I guess my usecase proposed was narrower than thought.
> And we probably want to avoid creating risky confused deputy scenarios.
> 
> So now I'm leaning towards the LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS path,
> dropping the "ON_EXEC" part as Mickaël proposed.
> 
> But I'm struggling to see where the value is added over the prctl call.
> Sure atomic enforcement with the ruleset is nice, but not a huge value added
> on it's own.
> 
> Perhaps the setting of this bit with a -1 ruleset_fd could enable auditing
> of the (failed or successful) privilege acquisition for the domain via the
> fcaps/suid/guid methods w/o setting NNP? (otherwise this would be no
> different from a Landlock specific prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)
> call).
> 
> And setting it with a non -1 ruleset_fd would set NNP *and* enable the
> same auditing.

I guess in this context "auditing" means for the caller to know what is
the origin of the error?

> 
> That way we are making this a "value-added" flag instead of just a landlock-flavored
> prctl call.
> 
> This would work well with the LANDLOCK_PERM_CAPABILITY_USE proposal,
> which allows us to audit both methods of acquiring new capabilities.
> (the clone/unshare path, and the fcaps/setuid/setgid path).
> 
> What do you think Mickaël?

I wasn't sure if we should or not artificially restrict the use of this
new Landlock NNP flag.  Fundamentally, it is not tie to a ruleset,
and like LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF it could be used with
ruleset as -1.  However, I don't really see a use case where a program
would "just" drop NNP and would not be interested to create a (minimal)
sandbox with Landlock (e.g. at least the scope restrictions).

Anyway, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF should remain an
exception (for a good reason), and any other use of -1 as ruleset should
be well justified.

BTW, if one day we need need to defer this NNP we should also add a new
dedicated flag for that, so it is not an issue.
