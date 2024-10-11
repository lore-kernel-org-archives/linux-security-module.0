Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C48839EB;
	Fri, 11 Oct 2024 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666422; cv=none; b=vFH89durACMfV0auncaax/Hxywf2kdKUS7M2eod4ZjsfZSi7XtGvJVVsHqhs12Hs3ymUVvhtMTilJSPC+DiLklPTBOOdRZk4AElKr27/ttqX4jKpsmPoUnBtV5APZRoE8cGuW0Od/feVMRrSMf3GAIZoO0Oa1TDJhfZ5NmWo2Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666422; c=relaxed/simple;
	bh=hlbXjoNjvFBTq51I5RxcgtxFHlTBY8xfwrD1VUEYKfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rT6hNY9lhwOqDLVOuSnETPTj9D8HHWTIrgsF+J3511s9+/w7wf3ohi+Fi1C0qyhGTSfDxO63vdr/XyDX7djR6jUjFUU+h0qsSRgxZ0uX1ZDiy1l14r6RIVww0OprCXVJiGioR4sgE4BOnAWB4xjBF4AeSZ9zqHwk88pfYeNbxtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 49BH6JSq005230;
	Fri, 11 Oct 2024 12:06:19 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 49BH6IF9005221;
	Fri, 11 Oct 2024 12:06:18 -0500
Date: Fri, 11 Oct 2024 12:06:18 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] tomoyo update for v6.12
Message-ID: <20241011170617.GA5139@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp> <877cavdgsu.fsf@trenco.lwn.net> <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com> <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com> <20241002103830.GA22253@wind.enjellic.com> <CAHC9VhRjq4B4Ub7kbD8uLZxL_CKSm=z+poCXBMmcfs=8ETHj3Q@mail.gmail.com> <20241008111442.GA23889@wind.enjellic.com> <88954576-5e62-4d95-bdf4-3913ffea68c2@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88954576-5e62-4d95-bdf4-3913ffea68c2@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 11 Oct 2024 12:06:19 -0500 (CDT)

On Tue, Oct 08, 2024 at 11:25:16AM -0700, Casey Schaufler wrote:

Good morning, I hope the week has gone well for everyone.

> On 10/8/2024 4:14 AM, Dr. Greg wrote:
> > ...
> >
> > Which we also believe justifies more attention than what it has been
> > able to receive in 20 months.
> 
> You're right. You're also not alone. There are things that you can do
> that will help get the review you're looking for. Developers who attend
> to the needs and preferences of reviewers get a whole lot more attention
> than those who fuss and fume about not getting what they "deserve". My
> hopefully constructive recommendations are:

We put a significant body of code and engineering time on the table to
try and improve the Linux security ecosystem.  We did this because in
certain circles the value of our approach is understood and there was
a desire to have it more generally available.

We don't believe we 'deserve' anything, review or don't review, it is
completely up to everyone involved.

Believe me when I say we are perfectly capable of supporting our
constituencies without contributing a single line of code or comment
back to the good of the Linux security commons.

Our aggravation in all of this is when statements are made regarding
serious and supposedly well understood flaws in our approach that
'everyone' agrees to be the case.  Statements that are a complete and
utter crock of bullshit meant to simply gaslight the situation that
has gone down.

Hopefully our choice of lingua franca is sufficiently simple and
unsophisticated.

We would, again, encourage everyone to re-read our previous e-mail
where we outlined our concerns over the status of the review that did
occur.

We do respect reviewers, but let's engage in some sense of
intellectual honesty.  This is not a situation of some poor lonely
overworked individual reviewing Linux code in their mother's basement
at night in Gulley, Minnesota while they work at the Cenex Station
during the day.

Paul has publically stated that Microsoft employees him to maintain
the Linux security system because of Microsoft's concern for the long
term health and well being of Linux.  In case anyone doubts this or
missed it, here is the link:

https://lore.kernel.org/linux-security-module/20230608191304.253977-2-paul@paul-moore.com/

Unfortunately our experience seems to challenge Linus' mantra of:

"Code talks, bullshit walks".

Perhaps times have changed for Linux in this new custodial
environment.

> 1.	Lead with code. Save the documentation for later.
> 2.	Incremental implementation. Don't drop the whole mess on the
> 	reviewers at once. A patch set should be a story, with each patch
> 	introducing one new element.
> 3.	Emphasize the similarities with existing implementations. No one
> 	wants to deal with novel or clever code. If it is familiar, it is
> 	easy to understand.
> 4.	Thank your reviewers. Complaints about review latency typically
> 	increase it.
> 5.	Do some reviews yourself. That will get in the good graces of other
> 	reviewers.
> 6.	Be brief. The biggest single problem with reviewing TSEM has been that
> 	doing anything takes so long. Multiple paragraph responses to an issue
> 	don't help. Say it, say it once, say it in small words, and use as
> 	few of those as possible.

We appreciate the insight and recommendations, we will see how and
where all of this ends up getting litigated.

Given the zeal for simplicity embodied in these recommendations, we
will assume that adversaries targeting Linux from a security
perspective will also choose to limit themselves to simple and
unsophisticated means and methods of attack.

Have a good weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
