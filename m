Received: from wind.enjellic.com (wind.enjellic.com [67.230.224.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23713A1E63
	for <linux-security-module@vger.kernel.org>; Thu, 15 Jan 2026 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.230.224.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492582; cv=none; b=gguATOkKnGA/tgTL5Cmeer0/dAZbfm+wV/ApF3gU9cwEUdh22DZ0dxsYz1h/6VH8GJWJOnYN1CtYr7K5mLLkZpCF5y8BScSAj0t7FKCuAZfYp7ntp2f4vGJxB/TCNK6Fi4aC7mHuGePGkynV3Fz9UaSJJ25qtpoaLpv29NcOLkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492582; c=relaxed/simple;
	bh=D4yMeSmjvV1olpHXsjpceXuRMxeLq0q7PHTsQs9lzsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnZh25M7bhmt+bNzP25+Dz0nw9ivE9P0B5e0pMLrnImEYwL2DtIHCqOthsbuJcf8THwTEoPQdCvVwH21W8IUaDkUQ/KF4hThdIw9KDhLJUJWLDM957up8yv3j1dqQHHKHJR+x7gxKXn4kW+uNq8I69Nd6EIx1m5+HtCpVxTApx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=67.230.224.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 60FFtvFj018739;
	Thu, 15 Jan 2026 09:55:57 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 60FFttai018738;
	Thu, 15 Jan 2026 09:55:55 -0600
Date: Thu, 15 Jan 2026 09:55:55 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Subject: Re: Improved guidance for LSM submissions.
Message-ID: <20260115155555.GA18668@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20260108154604.GA14181@wind.enjellic.com> <CAHC9VhTyvEVLGLJkkyQnSZYSj4-YHPz82BnDEUwMjU7hHdbFoA@mail.gmail.com> <2ea2e67e-8fcd-43d8-8cda-7df8d678d2b0@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ea2e67e-8fcd-43d8-8cda-7df8d678d2b0@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 15 Jan 2026 09:55:57 -0600 (CST)

On Fri, Jan 09, 2026 at 11:58:39AM -0800, Casey Schaufler wrote:

> On 1/9/2026 10:51 AM, Paul Moore wrote:
> > On Thu, Jan 8, 2026 at 11:08???AM Dr. Greg <greg@enjellic.com> wrote:
> >> What is not clear in these guidelines is how a virgin LSM should be
> >> structured for initial submission.  Moving forward, we believe the
> >> community would benefit from having clear guidance on this issue.
> >>
> >> It would be helpful if the guidance covers a submission of 10-15 KLOC
> >> of code and 5-8 compilation units, which seems to cover the average
> >> range of sizes for LSM's that have significant coverage of the event
> >> handlers/hooks.

> Good day Greg, I hope you are well.

Hi Casey, thank you, I hope your week has been going well.

> If you would review the comments I made in 2023 regarding how to
> make your submission reviewable you might find that you don't need
> a "formal" statement of policy. Remember that you are not submitting
> your code to a chartered organization, but to a collection of system
> developers who are enthusiastic about security. Many are overworked,
> some are hobbyists, but all treat their time as valuable. If you can't
> heed the advice you've already been given, there's no incentive for
> anyone to spend their limited resources to provide it in another
> format.

As Paul noted in the following:

https://lore.kernel.org/linux-security-module/20230608191304.253977-2-paul@paul-moore.com/

Microsoft employs him to maintain the Linux security sub-system, and
related infrastructure, secondary to Microsoft's concern over the long
term health of the Linux community.

Given that, it is disappointing that Microsoft isn't providing
sufficient resources to enable him to provide guidance to the
community they desire to support, regardless of that, we now have
'official' guidance as to the requirements for submitting a virgin
body of LSM code:

https://docs.kernel.org/process/submitting-patches.html

Paul notes the 'separate your changes' section as his only specific
recommendation for the submission of new code, that section recommends
that each patch represent a logical change.

A careful read of the document suggests that our submission did not
violate what is the 'official' guidance for virgin code submissions.

Absent the utility of specific guidance, Paul recommends reviewing the
mailing list for community norms and expectations, so we did.

The following URL provides a full reference to Microsoft's submission
of their IPE LSM:

https://lwn.net/Articles/969749/

Their strategy mirrored ours with respect to submitting each major
functional unit as a single patch, a strategy that was sufficient for
the review of Microsoft's submission, 16 separate times.

You take exception with a single include file containing structures
referenced by every compilation unit, indicating that a structure
should be introduced with the code that uses it.

For the good of the community, it would be helpful to have
clarification as to how you do that without including all of the
compilation units in a single patch, which would clearly be rejected
as an inappropriate submission.

Best wishes for a productive New Year.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
