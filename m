Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E165B65C;
	Mon, 30 Sep 2024 10:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693655; cv=none; b=lFvuR57T/WC0wa8XrJhDOZz6v56aComXl73exLkrtjpb0OYObBBQGurT97e6KRTJEvP16sYhFq2CoZe9he9eEwVj408vo8QPf9dOT04SgT94wvN4bDNRr8Cg4Z6GGOe4yq/m+a+N+NVeRlzJ5OnAoQry4dYF+FpcFXmm+ZDqaBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693655; c=relaxed/simple;
	bh=O5nRE9hhVdbt60KS+UAuLQZ/+3pxiQO4oKFXq/b1Hok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAn3gAh1STqNwvyspzn3t0yjnaNRGNVpkBrLybXsCkiUwCKmuaCke8r83XjEyrDdIoJupPW4CUtTq4gcLmisRKDt9dImrYi7GAY5HYJGg/sossA65mREisytS5jSawNyIiOtFo4leWPQTwpRnAX5asqkuQyEEbUIOQc3tdH1dCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 48UArWPe027811;
	Mon, 30 Sep 2024 05:53:32 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 48UArUVj027810;
	Mon, 30 Sep 2024 05:53:30 -0500
Date: Mon, 30 Sep 2024 05:53:30 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] lsm/lsm-pr-20240911
Message-ID: <20240930105330.GA27787@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <d15ee1ccfb91bda67d248b3ec70f0475@paul-moore.com> <960e740f-e5d9-409b-bb2a-8bdceffaae95@I-love.SAKURA.ne.jp> <69e4014e-0a34-4fde-8080-4850a52b0a94@I-love.SAKURA.ne.jp> <CAHC9VhQq0-D=p9Kicx2UsDrK2NJQDyn9psL-PWojAA+Y17WiFQ@mail.gmail.com> <20240927085841.GA3642@wind.enjellic.com> <2ea23569-6fb2-4a4e-acc1-e3927dd5615d@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ea23569-6fb2-4a4e-acc1-e3927dd5615d@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Mon, 30 Sep 2024 05:53:32 -0500 (CDT)

On Fri, Sep 27, 2024 at 09:33:19AM -0700, Casey Schaufler wrote:

Good morning Casey, always good to get your reflections, we hope your
week is starting well.

> On 9/27/2024 1:58 AM, Dr. Greg wrote:
> > On Mon, Sep 16, 2024 at 04:08:11AM -0400, Paul Moore wrote:
> >
> > Good morning, I hope the end of the week is going well for everyone.
> >
> >> On Sun, Sep 15, 2024 at 8:38???PM Tetsuo Handa
> >> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>> On 2024/09/14 0:28, Paul Moore wrote:
> >>>> I find it somewhat amusing that you are complaining about the LSM
> >>>> framework not accepting new LSMs in the same pull request where we are
> >>>> adding a new LSM (IPE).  As a reminder, we have documented guidelines
> >>>> regarding the addition of new LSMs:
> >>>>
> >>>> https://github.com/LinuxSecurityModule/kernel/blob/main/README.md
> >>> (...snipped...)
> >>>> While I have no intention to negatively impact out-of-tree LSMs,

> >>> What I call "patent examination" is "New LSM Guidelines" section
> >>> within that link. That section includes "here are a list of
> >>> requirements for new LSM submissions:" and "The new LSM must be
> >>> sufficiently unique", and out-of-tree LSMs which cannot satisfy
> >>> it won't be able to become in-tree.  If we apply this
> >>> requirement to userspace program, this requirement means you are
> >>> declaring that "postfix" (or anything except "sendmail") cannot
> >>> become in-tree because "sendmail" is already in-tree. This is a
> >>> clear intention of negatively impact out-of-tree LSMs. People
> >>> have the right to use whatever subsets/alternatives. Even if a
> >>> new LSM has were completely a subset of existing in-tree LSMs,
> >>> people have the right to use such LSM.

> >> Comparing userspace applications to kernel code isn't a fair
> >> comparison as a userspace application can generally be added without
> >> impacting the other applications on the system.

> > Tetsuo's comparison may be a bit strained, but it remains relevant.
> >
> > Linux was founded on a concept of choice, the current LSM architecture
> > struggles with the ability to facilitate generalized choice and
> > flexibility.

> >>> While I consider that some of out-of-tree LSMs being unable to
> >>> become in-tree is inevitable, the requirement that any LSM has to
> >>> be built-in is a barrier for LSMs which cannot be built-in.

> >> Anyone is always free to build their own kernel with whatever code
> >> changes they like, this is the beauty of the kernel source being
> >> available and licensed as Open Source.  You are free to build a
> >> kernel with whatever LSM you like included and enabled.  You have
> >> been shown examples on how to do this in previous threads.

> >>> People have the right to install whatever userspace software /
> >>> kernel modules they need.

> >> Anyone is free to build their own kernel with whatever LSMs they want,
> >> either in-tree or out-of-tree; the static call changes do not prevent
> >> that.

> > This line of reasoning represents a bit of an indulgence in a false
> > binary logic fallacy.
> >
> > Anyone reading this forum is certainly capable of building a kernel in
> > any configuration they want to.  That being said, the general Linux
> > technical community now represents a cohort far larger than
> > individuals who have the ability to build and platform a kernel of
> > their choosing.
> >
> > From a security perspective, Linux will benefit from providing a
> > better means to serve a middle ground where alternate security models
> > and architectures can be implemented without building a kernel from
> > scratch.

> Ye Gads.

That certainly dates both of us, the last time I heard that phrase it
was from Thurston Howell the III....

> One can create SELinux policy to support just about any security
> model you can think of, although I was the first to decry its
> complexity.  Smack access rules can be configured to support a wide
> variety of models, including Bell & LaPadula, Biba and rings of
> trust. AppArmor is very useful for targeted application security
> model enforcement. And then there's BPF.
>
> It seems to me that the problem isn't with the facilities provided
> to support the implementation of new security models, it is with the
> definition of those security modules. Or rather, the lack
> thereof. The ancient Bell & LaPadula sensitivity model can be
> implemented using Smack rules because it is sufficiently well
> defined. If the end user can define their policy as clearly as B&P
> does, its a slam dunk for any of the aforementioned LSMs.

We certainly wouldn't choose to argue with any of this, given your
repertoire in the field of mandatory access controls and security
models.

But therein lies the rub with respect to the implementation of system
security.

There are what, maybe 5-6 people in the world like yourself, that have
the technical chops to translate the theoretical expressiveness you
describe above into functional, let alone maintainable, security
implementations?

If there was the ability to practically implement just about any
security model with SeLinux there would be no need for the LSM, yet
its existence has arisen, given the desire to support multiple
security schemes.  That alone would seem to suggest the lack of
technical prowess that is required to translate theoretical
expressiveness into practical implementations.

A primary challenge to security is scale of skill.

In the face of limited advanced security skills, we have hundreds of
thousands of people around the world creating and modifying millions
of workloads, on a daily basis.

I mentioned just recently, in a meeting with technical influencers
here in the Great State of North Dakota, that we are never going to
train our way out of this security problem.

Cisco recognized this with network security and this fact was central
to the concept of it's Application Centric Infrastructure (ACI).  With
respect to scale, ACI is based on the premise that the manageability
of network security has to be an artifact of the development process.

One of the motivations behind TSEM is to deliver that same concept to
system security.  The notion of allowing development teams to create a
customized, bounded and mandatorily enforced security behavior,
specific to a workload, as an extension of the development process.

Another tool in the 'Secure By Design' toolbox.  A concept that
entities like NIST, DHS/CISA and particularly the insurance companies
are going to force the industry to translate into practice,
particularly in critical infrastructure systems.

Have a good week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
