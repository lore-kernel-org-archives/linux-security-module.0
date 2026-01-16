Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D34C26CE2B
	for <linux-security-module@vger.kernel.org>; Fri, 16 Jan 2026 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573513; cv=none; b=FiaVeWQhPbzkVnPrgLvy3Rr9UtlWmC17THw8z1aYgYs9K1tBY7/o8kCAVXNepW3GfCXdy/yLw8kevEPpz9Ak+uClfYpIM2fDhogdHEYkSQvGzJkMzuF9ZWvti7BSOHPnqKB+kmMJ8vu1SNxomUmxjpdznWK8krxYgepnqCFN/Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573513; c=relaxed/simple;
	bh=eCXytYP8WevteH3/pOP/2VhZhiG6sXWWdVj5prs14mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUc/ZuGOKJ6YuUSgHqxwQ/mPg70Wnj8ez9468dbHQ7MPfyMfGYqzfkb+TM1pIZSafKE8/7k0yDETiin+RoBqp2hUfNoETrXY37XjPWaoBFoZcCiC1o2/NfSi6Xo5HCe8CILVY8pi3xDnINH2HzaFpka8feyuO1wIJXQsKqstcTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=rCJfHu8B; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="rCJfHu8B"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dt2596z3vzwqc;
	Fri, 16 Jan 2026 15:18:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1768573101;
	bh=eYz+3Iuov1grERrs2u3VuMKuJ+8vLSFt+XOo11ZnweQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rCJfHu8BT/eCBtBvaYc+ocOUpskOj+nP7C+tZU7PBgEdGT0xo3Ab75k6v6HVKLdA/
	 uFpuxgH8fCdL5+jzi3PIm/ABTT2qzaQ5+aFopxg3q5dJL9XEyaNpWSqJENuM904xDQ
	 ZZPIemyUkIMrBWV/gAzvXGmsTH9/07dW2yzWdsgk=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dt2591RpdzqjC;
	Fri, 16 Jan 2026 15:18:20 +0100 (CET)
Date: Fri, 16 Jan 2026 15:18:15 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Tingmao Wang <m@maowtm.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] Landlock fix for v6.19-rc6
Message-ID: <20260116.feegh2ohQuae@digikod.net>
References: <20260115214740.803611-1-mic@digikod.net>
 <CAHk-=wgPRijTr7fZQNs9pxbhRLBVQGdE7ceZDwQFP53MXjRBxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgPRijTr7fZQNs9pxbhRLBVQGdE7ceZDwQFP53MXjRBxg@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Thu, Jan 15, 2026 at 03:09:34PM -0800, Linus Torvalds wrote:
> On Thu, 15 Jan 2026 at 13:47, Mickaël Salaün <mic@digikod.net> wrote:
> >
> > This PR fixes TCP handling, tests, documentation, non-audit elided code,
> > and minor cosmetic changes.
> 
> This seems significantly bigger than what you sent for the whole merge
> window for the Landlock code.
> 
> The merge window pull was - ignoring tests - 4 files changed, 59
> insertions(+), 17 deletions(-).
> 
> I want more explanations for why I'm suddenly getting more alleged
> fixes than I got any development and why this shouldn't wait until the
> next merge window.
> 
> Because honestly, this just all seems out of place.

There are indeed relatively more line changes because the related
commits are fixes for different kernel versions, not specifically v6.19
but also v6.15 (type issue), v6.7 (TCP fix), and it required to move a
lot of lines (including a lot of comments) for a theoretically small
fix.  In fact, the last merge window pull was mostly about fixes too
(which were on time for the merge window, but otherwise I would have
sent them as this one).

The other commits are documentation/comment fixes (including another
chunk of moved lines, which appears as kernel code diff), tests fixes or
minor cleanup.  I can postpone these commits but because they don't
directly impact the kernel, I wanted to group all fixes and minor
non-kernel changes together to have a clean PR for the next merge
window.  Please let me know what you prefer.

 Mickaël
