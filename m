Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4E9189505;
	Fri, 27 Sep 2024 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727427559; cv=none; b=t2djYCJ0aUwoPxOAoIhBHLskxoAEmPPzGlvGkkrvkmUL2nOyhsDJb+tsEubJnFgvgjO/+JHbhc2Vo09GuCFvmZAbIizYKgZxbkUp0+39Hj6NS15kyp4V7bVhtGz4uB4SpS0Oir255kVUj30p53L9m8gxOxHPC9LN/qKlcWwrUHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727427559; c=relaxed/simple;
	bh=VFt1mI2XEH7xYVDuen7V7h+Man2pR0Jpk0S1LJM+qW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ML0Jc4QWo+kmPyupY3OC3p7NTc1346DjveKEOl92gg9FBOEBuSDkcapHLhTYlOGnF3Ucw+yDq89BX7+/Whpq1j9EK4/a2Xvo0lK/UejSxh1mRjSNaj8cfU6/F/qrwghBmJTNlayuFEye4cUKTsrfvQzdxP6Pj28+rNsk6IEuRYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 48R8wgDv003841;
	Fri, 27 Sep 2024 03:58:42 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 48R8wgWb003840;
	Fri, 27 Sep 2024 03:58:42 -0500
Date: Fri, 27 Sep 2024 03:58:42 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] lsm/lsm-pr-20240911
Message-ID: <20240927085841.GA3642@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <d15ee1ccfb91bda67d248b3ec70f0475@paul-moore.com> <960e740f-e5d9-409b-bb2a-8bdceffaae95@I-love.SAKURA.ne.jp> <69e4014e-0a34-4fde-8080-4850a52b0a94@I-love.SAKURA.ne.jp> <CAHC9VhQq0-D=p9Kicx2UsDrK2NJQDyn9psL-PWojAA+Y17WiFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQq0-D=p9Kicx2UsDrK2NJQDyn9psL-PWojAA+Y17WiFQ@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 27 Sep 2024 03:58:43 -0500 (CDT)

On Mon, Sep 16, 2024 at 04:08:11AM -0400, Paul Moore wrote:

Good morning, I hope the end of the week is going well for everyone.

> On Sun, Sep 15, 2024 at 8:38???PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > On 2024/09/14 0:28, Paul Moore wrote:
> > > I find it somewhat amusing that you are complaining about the LSM
> > > framework not accepting new LSMs in the same pull request where we are
> > > adding a new LSM (IPE).  As a reminder, we have documented guidelines
> > > regarding the addition of new LSMs:
> > >
> > > https://github.com/LinuxSecurityModule/kernel/blob/main/README.md
> > (...snipped...)
> > > While I have no intention to negatively impact out-of-tree LSMs,
> >
> > What I call "patent examination" is "New LSM Guidelines" section within
> > that link. That section includes "here are a list of requirements for
> > new LSM submissions:" and "The new LSM must be sufficiently unique", and
> > out-of-tree LSMs which cannot satisfy it won't be able to become in-tree.
> > If we apply this requirement to userspace program, this requirement means
> > you are declaring that "postfix" (or anything except "sendmail") cannot
> > become in-tree because "sendmail" is already in-tree. This is a clear
> > intention of negatively impact out-of-tree LSMs. People have the right to
> > use whatever subsets/alternatives. Even if a new LSM has were completely a
> > subset of existing in-tree LSMs, people have the right to use such LSM.

> Comparing userspace applications to kernel code isn't a fair
> comparison as a userspace application can generally be added without
> impacting the other applications on the system.

Tetsuo's comparison may be a bit strained, but it remains relevant.

Linux was founded on a concept of choice, the current LSM architecture
struggles with the ability to facilitate generalized choice and
flexibility.

> > While I consider that some of out-of-tree LSMs being unable to
> > become in-tree is inevitable, the requirement that any LSM has to
> > be built-in is a barrier for LSMs which cannot be built-in.

> Anyone is always free to build their own kernel with whatever code
> changes they like, this is the beauty of the kernel source being
> available and licensed as Open Source.  You are free to build a
> kernel with whatever LSM you like included and enabled.  You have
> been shown examples on how to do this in previous threads.

> > People have the right to install whatever userspace software /
> > kernel modules they need.

> Anyone is free to build their own kernel with whatever LSMs they want,
> either in-tree or out-of-tree; the static call changes do not prevent
> that.

This line of reasoning represents a bit of an indulgence in a false
binary logic fallacy.

Anyone reading this forum is certainly capable of building a kernel in
any configuration they want to.  That being said, the general Linux
technical community now represents a cohort far larger than
individuals who have the ability to build and platform a kernel of
their choosing.

From a security perspective, Linux will benefit from providing a
better means to serve a middle ground where alternate security models
and architectures can be implemented without building a kernel from
scratch.

> > > My focus is on the upstream Linux kernel and ensuring that the upstream,
> > > in-tree LSMs have the best framework possible to ensure their proper
> > > operation and ease of development/maintenance.  While I have no
> > > intention to negatively impact out-of-tree LSMs, I will not harm the
> > > upstream code base solely to support out-of-tree LSMs.  Further, if
> > > improvements to the upstream LSM framework are determined to harm
> > > out-of-tree LSMs, that shall be no reason to reject the upstream
> > > improvements.
> >
> > I have been asking you for a solution for "in-tree but not built-in" LSM
> > (namely TOMOYO). You are refusing to provide a solution for the sake of
> > "in-tree and built-in" LSMs. The "static call" changes fails to ensure that
> > the upstream, in-tree TOMOYO to have the best framework. The "static call"
> > changes makes the upstream, in-tree TOMOYO to have a worse framework than
> > now.

> As mentioned so many times before, the "in-tree but not built-in"
> LSM problem is entirely a distribution/binary-kernel problem.  The
> upstream kernel community is not responsible for the choices and
> individual build configurations of the different Linux distros.
> Support for mechanisms which allow for dynamic LSMs in pre-built
> distro kernels is something we could consider, but so far everything
> that has been proposed has had a negative impact on the upstream
> kernel sources and has been rejected as a result.

Not everything.

As of the TSEM V4 release, which is now a month old, we have proposed
a middle ground that provides multiple mechanisms for the mainsteam
kernel to support alternate security models in an orthogonal manner,
but it has struggled to receive any significant review.

The V4 release now includes the ability to use loadable modules to
implement customized security models.  The premise for this support is
to replace the need for a dynamic LSM with an LSM that has dynamic
configurability.

Bandwidth is always in short supply, but some internal investigation
by our team has demonstrated that the TSEM architecture can implement
Tomoyo as a loadable security model.

TSEM also provides a framework for servicing the needs of Endpoint
Detection and Response systems without having to write any kernel code
at all.  This same mechanism also facilitates the ability to apply
machine learning detection and intervention models, a capability that
is notably absent from any of the existing LSM's.

For the record and everyone reading along at home, here are the links
to the four releases:

V1:
https://lore.kernel.org/linux-security-module/20230204050954.11583-1-greg@enjellic.com/T/#t

V2:
https://lore.kernel.org/linux-security-module/20230710102319.19716-1-greg@enjellic.com/T/#t

V3:
https://lore.kernel.org/linux-security-module/20240401105015.27614-1-greg@enjellic.com/T/#t

V4:
https://lore.kernel.org/linux-security-module/20240826103728.3378-1-greg@enjellic.com/T/#t

We believe that making some forward progress with review and inclusion
of TSEM would positively impact the issues under discussion.

> paul-moore.com

Have a good weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
