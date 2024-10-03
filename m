Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464F01A4F1F;
	Thu,  3 Oct 2024 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970247; cv=none; b=QiQPt/DEUdJRwaTwZuwJXvgORlFqv1lSe0Xald/5VL0cicoq1MVjEQLMuiHwX+WkGRKe2Nnk3fUR0Vtunt2jT0uzNfEQ+fFoNK5WIvhJnWVZaZ8kus1YPI4g0j66weyTiO+nCLirb1Ol5Jv7Rmzfk3cOyuiZZhwcciNFl56mV3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970247; c=relaxed/simple;
	bh=EJyjRNZkUYKY3jz4lZ+oTG1AXfsQ5x87I5lih2T8CqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EE8b+5gUg6/pVm54U+qeOFLBCPJx43YgDcrU4W3Jl9h7XyAx+1itJpAKKHFoJy4nM7uBX8VBnnNovEbzhdino0EUHUUsSvrarGutqs7biozTbknpr6X2E6DqyfMFIz+TNgUSKuQb2IXiZPd+Hl6rHK0BUUIE9iSoru6YXxdkXEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 493FhaMn004347;
	Thu, 3 Oct 2024 10:43:36 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 493FhaME004346;
	Thu, 3 Oct 2024 10:43:36 -0500
Date: Thu, 3 Oct 2024 10:43:36 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: John Johansen <john.johansen@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>, Jonathan Corbet <corbet@lwn.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] tomoyo update for v6.12
Message-ID: <20241003154336.GB3267@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp> <877cavdgsu.fsf@trenco.lwn.net> <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com> <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com> <20241002103830.GA22253@wind.enjellic.com> <033eb4d9-482b-4b70-a251-dc8bcc738f40@canonical.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <033eb4d9-482b-4b70-a251-dc8bcc738f40@canonical.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 03 Oct 2024 10:43:37 -0500 (CDT)

On Wed, Oct 02, 2024 at 07:27:47PM -0700, John Johansen wrote:

> On 10/2/24 03:38, Dr. Greg wrote:
> >On Tue, Oct 01, 2024 at 09:36:16AM -0700, Linus Torvalds wrote:
> >
> >Good morning Linus, I hope the week is going well for you.
> >
> >Some reflections, for the record, on this issue.
> >
> >>On Tue, 1 Oct 2024 at 07:00, Paul Moore <paul@paul-moore.com> wrote:
> >>>
> >>>Linus, it's unclear if you're still following this thread after the
> >>>pull, but can you provide a little insight on your thoughts here?
> >
> >>I absolutely hate the whole "security people keep arguing", and I
> >>cannot personally find it in myself to care about tomoyo.  I don't
> >>even know where it is used - certainly not in Fedora, which is the
> >>only distro I can check quickly.
> >>
> >>If the consensus is that we should revert, I'll happily revert. This
> >>was all inside of the tomoyo subdirectory, so I didn't see it as
> >>some kind of sidestepping, and treated the pull request as a regular
> >>"another odd security subsystem update".
> >
> >I see that Paul Moore has further responded with commentary about the
> >'LSM community' responding to this issue.  I wanted, on behalf of our
> >project and in support of Tetsuo's concerns, to register directly with
> >you a sense of jaded skepticism about the notion of a community
> >response.
> >
> >Fixing Tetsuo's issue, at least to the extent it can be fixed,
> >requires technical improvements in the Linux security architecture.

> yes and that is correct place to do it. Doing it within a single
> LSM is very much the wrong approach

Just going out the door and saw this e-mail

Your e-mail crossed with one I just sent over in the kernel code
loading side of this thread/debate.

Will look forward to seeing your thoughts there.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
