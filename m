Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7551A7083C
	for <linux-security-module@vger.kernel.org>; Sat, 28 Jun 2025 03:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751082068; cv=none; b=Bl0eProgaA1SjEbGyKnBDhYrUI3K6v0Td0YL2pW/ebjuIGMXSUsdfwz7J2YSRcErVV3Xf4cwsbjGl02ma7I4KYZtj6dDJotu1hgXqp09YettrxbZTyxJtwmiWjXb8qAouVV7lr3tS48jI7M5HvfVEIuYenjqCk5oKfw10JTHzuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751082068; c=relaxed/simple;
	bh=JNh/U3x/vwGB3PlSMx9ke/L5mBBI0/UM/H9Pznl7+0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkzKZszPMhhsjNM+c1D5W/iOtPvZiuR3gJBj7JpfqgXJnzt7EoDhyS3WsAwNC4daCbQUrQFwAiVLcocxi1JLI/xp0ljpRNx9SwBATrEmc9trFlMYrwyuBM77Mw6WObWBpLPchfTckOxdjBETRWh4/LmC7lv+dWdYgUZrvrEXtbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id DABC661C; Fri, 27 Jun 2025 22:40:55 -0500 (CDT)
Date: Fri, 27 Jun 2025 22:40:55 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Luigi Semenzato <semenzato@google.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Subject: Re: adding CAP_RESERVED_# bits
Message-ID: <20250628034055.GA94340@mail.hallyn.com>
References: <CAA25o9TqH3LNWy8F2tXO7P6AdQk0x+boWiPhy+CKL=wDouKODw@mail.gmail.com>
 <CAHC9VhT-UKWRbmsuJfkWO6BK_Mon4KUMB8DU5py1gDBJgYwJDw@mail.gmail.com>
 <CAA25o9QqmFGA1AsxK+5jds80uDV-3=BtM7kH0WgU=k+DEuxaiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA25o9QqmFGA1AsxK+5jds80uDV-3=BtM7kH0WgU=k+DEuxaiA@mail.gmail.com>

Sorry... why not just request a real capability bit be reserved?

Ok, I see at https://lore.kernel.org/all/?q=Luigi%20Semenzato%20capability
that Casey was suitably cautious.  However, I'd say if we end up needing to do
the painful transition to 128bit caps, we should face that, rather than
make people do ugly hacks.

-serge

On Fri, Jun 27, 2025 at 01:26:54PM -0700, Luigi Semenzato wrote:
> Sorry for the delay in responding, and thank you so much for
> clarifying the Linux priorities.
> 
> For our project we ended up hijacking an existing bit which we're
> comfortably sure we won't need for that binary (or any binary,
> really), plus a seccomp filter.  It's a total hack, but a simple one,
> and it beats the alternatives.
> 
> 
> On Fri, Jun 6, 2025 at 7:11 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Fri, Jun 6, 2025 at 1:58 PM Luigi Semenzato <semenzato@google.com> wrote:
> > >
> > > Recently I inquired about the decision process for adding a CAP_DRM
> > > bit to capability.h (to become DRM master).  It occurred to me that
> > > the process for adding ANY bit would be fraught with controversies (to
> > > say the least).
> > >
> > > So I looked into maintaining a patch in our own kernel sources, but
> > > that was surprisingly messy due to the build-time dependencies of
> > > capability.h and the way we maintain and share sources internally for
> > > multiple kernel versions.  This would have been quite simple if there
> > > were a few reserved bits, such as CAP_RESERVED_0, ..,
> > > CAP_RESERVED_<N-1> with, say, N=3.
> > >
> > > Would this also be controversial?
> >
> > Yes, and likely rejected too.  The upstream Linux kernel generally
> > doesn't make any sacrifices to support out-of-tree kernel code, and
> > giving up precious capability bitmap space would definitely be
> > considered a sacrifice.
> >
> > --
> > paul-moore.com
