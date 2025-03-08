Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01213323D;
	Sat,  8 Mar 2025 02:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741402033; cv=none; b=HyBHdzqCc3WcyEDmPadtNUKSGvg83FbXpCKklJhLg0RQ5vFJhwqU0Fvgr1OJIn9v2gzTbTuni3U2cWDDJxI70VzvbtkgDEVOoumh9K3epvzp/SQnF3N6inL+7Fja0moey0Za4sxOTDh9yRSP4mOZeRXUjUGr1k54plHp659r4yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741402033; c=relaxed/simple;
	bh=5cdZLxJnq6R8e9bUBQI6oyxbuFAODFCfWGehIsbGSwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCtQldZCeLwDolJAzDLHonQQM6v7Cpaa+3oSuP3pXlG2+5oFWvj1QBMsh0W+5M4wsYqdjJBO+u9LNcxU5OK6bMTuN5wGDqIlyJU/LooJaPkONbOCjfMPdQBjZD581g7YpnhhiHzCV2xJgY3hyzbfxNdSGc2dcgG3dGI9xp5kGWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBPSdq8r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBPSdq8r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC79C4CED1;
	Sat,  8 Mar 2025 02:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741402032;
	bh=5cdZLxJnq6R8e9bUBQI6oyxbuFAODFCfWGehIsbGSwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vBPSdq8rpqH6IZwr8EG2o/r+RNjHe+AGHpm+jX0Fl/jPfapJdRTvFYQoHhggnvinR
	 hrGteWfIEM6XznJ0U3f70e2AP77JLiRXqVm3sJzGxIdX3Qo/40yUCxzvxEUscwlLf7
	 BQzbCp61vmybz3QDIw9OS5iw/lnK3+y0FY1CQsvZIlV7uZqxU5uHqJe6ZGgXw0jCZW
	 EFB733A75t3c2nixgAAMarWQrZImZHhbwalU+dnuvk0/+zLmujY5hqEg5fF+e3s8Xk
	 YDZk6QGtbjn02cLnwz8dD+pvXCsKkuJOpo7yX+GHtE0M5KIU5ohTWymuuCzeQh5+wE
	 7EXFj2l92JWPw==
Date: Sat, 8 Mar 2025 02:47:08 +0000
From: sergeh@kernel.org
To: Paul Moore <paul@paul-moore.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] MAINTAINERS: add an explicit credentials entry
Message-ID: <Z8uvrJRfu4-0lk-I@lei>
References: <20250304222304.214704-2-paul@paul-moore.com>
 <CAHC9VhRW4Be+uBbtgCRvSkUj1-CtYFZ9jbD9MZM70i7GhF624Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRW4Be+uBbtgCRvSkUj1-CtYFZ9jbD9MZM70i7GhF624Q@mail.gmail.com>

On Fri, Mar 07, 2025 at 12:13:08PM -0500, Paul Moore wrote:
> On Tue, Mar 4, 2025 at 5:23 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > The lack of an explicit credential (kernel/cred.c) entry has caused
> > confusion in the past among new, and not-so-new developers, about where
> > to send credential patches for discussion and merging.  Those patches
> > that are sent can often rot on the mailing lists for months as there
> > is no clear maintainer tasked with reviewing and merging patches.
> >
> > I'm volunteering for the cred maintainer role to try and reduce the
> > confusion and help cred patches find their way up to Linus' tree.  As
> > there generally aren't a lot of cred patches I'll start with simply
> > folding them into the LSM tree, but if this changes I'll setup a
> > dedicated cred tree.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  MAINTAINERS | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> 
> I haven't seen any objections, or any other volunteers, so I'm going
> to go ahead and merge this to send up to Linus during the upcoming
> merge window.

Sorry, I managed to not take my personal laptop charger with me
on a trip this week, fell behind.

I'm very happy with you as the maintainer, but I do volunteer to
try and step in here, if that works.

> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 896a307fa065..68e4656c15ea 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6139,6 +6139,14 @@ L:       linux-input@vger.kernel.org
> >  S:     Maintained
> >  F:     drivers/hid/hid-creative-sb0540.c
> >
> > +CREDENTIALS
> > +M:     Paul Moore <paul@paul-moore.com>
> > +L:     linux-security-module@vger.kernel.org
> > +S:     Supported
> > +T:     git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
> > +F:     include/linux/cred.h
> > +F:     kernel/cred.c
> > +
> >  INTEL CRPS COMMON REDUNDANT PSU DRIVER
> >  M:     Ninad Palsule <ninad@linux.ibm.com>
> >  L:     linux-hwmon@vger.kernel.org
> > --
> > 2.48.1
> 
> -- 
> paul-moore.com
