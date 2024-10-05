Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B486A175B1;
	Sat,  5 Oct 2024 02:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728095676; cv=none; b=S3OdSHIo9WNq7ILDFwP7kbFuDOyOv5dVOUKV0Mm5E7EF57ipYSBEX+5dECAhVWDihrAsAcKhlzZ4Ifz4Ip+iu8ecTPU6X5Y5hpEiAcNxJ+WXcKmYB6QySFs5LOI4wyipbGoQtBs94zGH2YycXqUez/I1RYhpQjqSvg3u5hMNmfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728095676; c=relaxed/simple;
	bh=/plCDqktHJLu26c1/0KD6JVouNJ24M8l54tl9DOPvU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhGwsKN0bmT37hA+qdclGx8dLM1ft3Srzif+MG0CBIzmiwKpklyf22JRXmR8f2q7AtYpxR7FfHZEVnsMIfz3tzjbnpaiJJRM9Fo41wbRkmBrcDAvOTJfN8ymGlhDsOF0aPDx45V1HyjgnmAKK9uGlTKgB33xIviFK9AgVo+5XCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 4952Y0Sr020590;
	Fri, 4 Oct 2024 21:34:00 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 4952Xvf4020589;
	Fri, 4 Oct 2024 21:33:57 -0500
Date: Fri, 4 Oct 2024 21:33:57 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Paul Moore <paul@paul-moore.com>
Cc: John Johansen <john.johansen@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] tomoyo update for v6.12
Message-ID: <20241005023357.GA20577@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp> <877cavdgsu.fsf@trenco.lwn.net> <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com> <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com> <20241002103830.GA22253@wind.enjellic.com> <033eb4d9-482b-4b70-a251-dc8bcc738f40@canonical.com> <20241004184019.GA16388@wind.enjellic.com> <CAHC9VhS0aeDB2GzxJPHN8_LDk59gT_RuRKwb26K+3SzX7SQ=3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhS0aeDB2GzxJPHN8_LDk59gT_RuRKwb26K+3SzX7SQ=3g@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 04 Oct 2024 21:34:00 -0500 (CDT)

On Fri, Oct 04, 2024 at 02:58:57PM -0400, Paul Moore wrote:

Good evening, I hope the week has gone well for everyone.

> On Fri, Oct 4, 2024 at 2:40???PM Dr. Greg <greg@enjellic.com> wrote:
> > On Wed, Oct 02, 2024 at 07:27:47PM -0700, John Johansen wrote:
> > > On 10/2/24 03:38, Dr. Greg wrote:
> > > >On Tue, Oct 01, 2024 at 09:36:16AM -0700, Linus Torvalds wrote:
> > > >>On Tue, 1 Oct 2024 at 07:00, Paul Moore <paul@paul-moore.com> wrote:
> 
> ...
> 
> > The third problem to be addressed, and you acknowledge it above, is
> > that there needs to be a flexible pathway for security innovation on
> > Linux that doesn't require broad based consensus and yet doesn't
> > imperil the kernel.

> The new LSM guidelines are documented at the URL below (and
> available in the README.md file of any cloned LSM tree), the
> document is also linked from the MAINTAINERS file:
>
> https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm-guidelines
>
> The guidelines were developed last summer on the LSM mailing list
> with input and edits from a number of LSM developers.
>
> https://lore.kernel.org/linux-security-module/CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com

We are intimately familiar with those documents.

Our reference was to the need for a technical solution, not political
medicaments.

> paul-moore.com

Have a good weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
