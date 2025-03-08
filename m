Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAA4D528;
	Sat,  8 Mar 2025 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741436967; cv=none; b=eeRKEuATxrTqIS2Y6m5vfPKwc6ME9vFko1MrkmuaMvQmXE8gZVL2EsCSWa3+seZwqDJjAMqL9DZa+TIYONlNhmpRBDQtn4ZMGBJbT7K/Dbg8b3YPddc7SssKGPbQnyHjMFy4rtallyKaDSqu6m0stMODtc9u+8x974YYgYKnYPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741436967; c=relaxed/simple;
	bh=IhaxkifnhpsrsORjzS9wgFiE3rx1yAxDAbOLByYxRq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCvEK05eYMO5vcoC39asETNmTmTQNcIJM1hKe3EJswRmfIczMFlpbgU5Jv97EIfeMHw+KzkxLhdykPx3RCskoMeZ8PrJryaI1BFqPWLEXKvuQeWaAyAOKYxIk4GD+B6j4d5oGbRqqcjI3PO/2Y6KPqUi/4nPSIW500IuGOKOcI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=jqyHr69v; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="jqyHr69v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=EXlQXUiLdWnzgegzXlB07qgX7dan9uvz07XLUHH+YpM=; b=jqyHr69vkcwsq7iG
	xO6IcYePXX/n8RLPuGZOElm//YKd4RNJPv5XqBOmReZjirhOMqfar1C0F+MpJF7mIf4ZA648X+a1w
	hB0xUPPmHU4KYQCqeEeLjna06LDZ4LqKKYcUrMPY0HyzA65zfNHYWofWast6awH+EegrLy/jkCl5E
	QUrPicDVLlPdhDi+7ZbgEK7O20miVSKoTr/HsJwnD09bYiju7eE3If8YRxRK6SJ5xvvKDYkc1ce4l
	L2MUNq/dB5o6VviTCRlaBJvIeYRByNJUJ4xs9PbXV1HjOH14y60keZVU8LdvHHUyUoh3e843XG56o
	y9Xy3Bqt52B/S+6rHw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tqtIj-003b96-2N;
	Sat, 08 Mar 2025 12:29:09 +0000
Date: Sat, 8 Mar 2025 12:29:09 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: sergeh@kernel.org
Cc: Paul Moore <paul@paul-moore.com>, serge@hallyn.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] capability: Remove unused has_capability
Message-ID: <Z8w4FWl03gHYggPp@gallifrey>
References: <20241219172859.188117-1-linux@treblig.org>
 <CAHC9VhQ73qdL2Qf-jOMMVSf=+h-H8K+mz165XZztb5X6XjH11w@mail.gmail.com>
 <CAHC9VhTuvNuNfeLrR+5b+LOB_kC8a_67EvLPnOJO4vcvkcuMYQ@mail.gmail.com>
 <Z8u9MhM450tD3lYe@lei>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8u9MhM450tD3lYe@lei>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:29:01 up 303 days, 23:43,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* sergeh@kernel.org (sergeh@kernel.org) wrote:
> On Wed, Feb 26, 2025 at 07:08:52PM -0500, Paul Moore wrote:
> > On Thu, Dec 19, 2024 at 1:28 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > On Thu, Dec 19, 2024 at 12:29 PM <linux@treblig.org> wrote:
> > > >
> > > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > >
> > > > The vanilla has_capability() function has been unused since 2018's
> > > > commit dcb569cf6ac9 ("Smack: ptrace capability use fixes")
> > > >
> > > > Remove it.
> > > >
> > > > Fixup a comment in security/commoncap.c that referenced it.
> > > >
> > > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > > > ---
> > > >  include/linux/capability.h |  5 -----
> > > >  kernel/capability.c        | 16 ----------------
> > > >  security/commoncap.c       |  9 +++++----
> > > >  3 files changed, 5 insertions(+), 25 deletions(-)
> > >
> > > Now that Serge has the capabilities tree back up and running I'm
> > > assuming he will grab this patch, if not just let me know Serge and I
> > > can take it.
> > >
> > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> > 
> > Bump this thread to make sure Serge sees it ...
> 
> d'oh, sorry, yes
> 
> Acked-by: Serge Hallyn <serge@hallyn.com>
> 
> I will apply this now.

Thanks!

Dave

> -serge
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
