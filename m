Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A0C2116F4;
	Fri,  5 Jun 2026 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667118; cv=none; b=H8/nJC+2f4foDUW29G2oXcXp2GWjR7GQFqUTXrUe8pi5MhAOpsBezhyEvMCKfz9pTVkDHuAHlfPak/QGeNJaGv6JdICWHtlzExgnEmkhp56cd3CHZ0nfxuxhEzna2tEdZKEmftoK9kmsoQ7a5knHu7S8fwJnnkeOs9Hmg5Bg0oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667118; c=relaxed/simple;
	bh=56LzANDXLeGt3Cb3NBq35BfCpKLrBNw7dddTSmki2EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipNACXukckHZlZrapc1lTAc+5kZfC3FFRsleYFyTuzv6Zc3XP6PtgMlBh6cT8+holpr4yBkr0+7nNyF7yjGOCk4y3/MMmM1Lhcif8jLSlOvKtN41H6QY2CZdiEalU5TGfIlH7FkQETQ7edIOB3UJprXZbKtP635nXr9uKNNRwZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=n0ZpP+Te; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="n0ZpP+Te"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1780667108; bh=56LzANDXLeGt3Cb3NBq35BfCpKLrBNw7dddTSmki2EU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n0ZpP+Te0X9SSmdWCcprwUqZWAkVwIqSTx3ZKwkDyKkvpcRN7+apUNjlqMLp7PsT+
	 mfFmEqr8YIjYvxF1rpOMZXjuv6seUp77+IstHYHv3IWYzJgAHOon3TEF3YhGn8XWP/
	 XcL4L7thXDOq4Yh5TeGEJjeFkX+zx4ApvuXHHeW11oRCykTFVv301Xs7WgDrGMQPJ3
	 2Q8wgQI5QIXO1CuZ+BI1kpv5QbgByeFz66jCMaM+WWm4c9KXMwYrVCpgh3YGct71Al
	 B2HDVOnOmc2cGfmnqKWPmAwxwUrWidE8KStjWqWQ9XBE4jhFwx7tH6ubOQhxeziHU9
	 K0GPkbyr4E0qg==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 069C1432; Fri,  5 Jun 2026 08:45:07 -0500 (CDT)
Date: Fri, 5 Jun 2026 08:45:07 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: -next status as at v7.1-rc6
Message-ID: <aiLS4wOtpqrpw4pA@mail.hallyn.com>
References: <83f77b2b-8c00-424d-b6f9-b044e7ea1ee7@sirena.org.uk>
 <CAHk-=wj6CtZS9hbwFjQcoNkPwQLoyKmk8czaBF6=bBOCYuXEUQ@mail.gmail.com>
 <CAHC9VhRX1=tx4+arzuH76kirYFFJozexa5L=41Bb2QbgWZXOkQ@mail.gmail.com>
 <CAHk-=wj_rtiufEEVudMCSbh86HYrnmEa9NhYfKeWHs1SOzJVnA@mail.gmail.com>
 <CAHC9VhRXW_kyWXgYBqW3K-jSr5yN9wp1EPos1c=BFmiebxLiUQ@mail.gmail.com>
 <CAHk-=wij4nkMRcshzEGsxvjwP2RBQyaiQ4-vQrYTOqvQusxu9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wij4nkMRcshzEGsxvjwP2RBQyaiQ4-vQrYTOqvQusxu9g@mail.gmail.com>

On Thu, Jun 04, 2026 at 04:18:46PM -0700, Linus Torvalds wrote:
> On Thu, 4 Jun 2026 at 15:23, Paul Moore <paul@paul-moore.com> wrote:
> >
> > While you didn't reply to any of my comments explaining how Hornet
> > works, specifically how it ties into the kernel, I'm assuming you've
> > read the overview.  Can you help those of us in the LSM space
> > understand why a BPF dev's NACK on code that lives strictly under
> > security/ is sufficient grounds to reject an LSM patch?
> 
> Honestly, I'm not competent to make a judgment call between two
> different models for hash chain verification, so I basically *have* to
> go by maintainer opinions.
> 
> And the discussions I have been cc'd on have not been what I'd call
> enlightening.
> 
> But people have pointed out that the LSM code mucks around with bpf
> internals, and those NAK's have had reasons for them.
> 
> And honestly, I don't understand *why* Hornet does what it does - and
> does it in ways that obviously annoy the bpf people. There is no
> *reason* to look at the bpf maps that I can see, and from my
> understanding of Alexei's arguments (which may be lacking), the fact
> that Hornet does that is the main reason for the NAK.

The two most useful threads I believe were from a year ago,
20250502184421.1424368-1-bboscaccy@linux.microsoft.com
and
20250528215037.2081066-1-bboscaccy@linux.microsoft.com
which includes the proposal by the BPF side:
https://lore.kernel.org/linux-security-module/CACYkzJ6VQUExfyt0=-FmXz46GHJh3d=FXh5j4KfexcEFbHV-vg@mail.gmail.com/

There were 2 or three objections from each side iiuc, but the main ones
that stuck in my mind were

1. whether it is ok to rely on a signed userspace bpf verifier program to
   verify the signature.
2. objection by James Bottomley 
   (2f71d6c03698eb17d51f7247efde777627ee578a.camel@HansenPartnership.com)
   about the verifiability of the hash chain link.

> But instead of working with the bpf people on coming up with some
> model that does *not* do that, it all seems to have become a "we'll do
> it anyway, despite maintainer complaints".
> 
> And I *did* see the bpf people pointing to "this would be an
> acceptable alternative" with KP Singh outlining something that *had*
> been discussed.
> 
> But I never actually saw anybody say "ok, we'll try that instead".
> 
> Maybe I missed it.
> 
> But from what I saw, it really looked like "I see NAK's from three
> different bpf maintainers, with suggested alternate approaches". None
> of which resulted in anything that looked like "ok, we'll try to
> follow your guidance", only more of the same.
> 
> Why would *my* input then make any difference?
> 
> The bpf people's arguments resonated more with me. For example, the
> whole "we need to know if it passed the bpf signature" seems to be
> complate pointless silliness, and the bpf peoples responses to that
> resonated with me. There's *no* point in any LSM check whether the
> signature passed or not, since if it didn't pass, it's not getting
> loaded.
> 
> So that's basically where I stand - I've seen disagreement, and I've
> seen what looks to me like reasonable push-back, and I've not really
> seen the LSM response as taking it into account.
> 
>            Linus
