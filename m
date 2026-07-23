Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68719381E88
	for <linux-security-module@vger.kernel.org>; Thu, 23 Jul 2026 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784837163; cv=none; b=Bw77njgLwr6mOHQzy1JqvYuASYFdBPgdZpRo+Y7IV5TsNCTyNPeXN8sZkAzUriiSp9F9eLItjtjR5eh6YOiD2JQMvseUp0F42a1v1dZLshoa6BLQz84ivZlp0sk8OybE60BkbZmKLlJAejFPZawB7//O1wkI349AbdacpQdt0g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784837163; c=relaxed/simple;
	bh=BWa8vfOhHK322dHFFbyV4kRQgIJfDehqnJy+UJgkylQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUAng9KmSiYSxfr8ximUlH2gk1wy7RnIz57wFQEFKi1qIYSOreYxY/4J2PNT2wpAPnRCvLSp5361qvu+qyjGIYTqxKcS7ZF1zIbRetY7pcPQW5mTHC1/Oz0QDpKcFXPGJUPdyjXpEpyblJ0AmvnGhbaijOpEHzCCoV5g/uegoFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqCenQCY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqCenQCY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E2A1F000E9;
	Thu, 23 Jul 2026 20:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784837162;
	bh=pLkiOWrXMceI+blGwiEOUTldBmwOhTpTtOCRaZkTeXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IqCenQCYCqs49oCjLFnC67E2XSTpOFhRZ71CUkMtjBuBCVKL/vDaO6lvk7T1PXTja
	 Q9R1Anw1SBTknWeSG4dnUCEWuZvqbXZnO4Dp8n50SLfelgv9IPXbzDkeU3GoTOfSJe
	 YoOYGQYyGa0wFRgTCMNBed+HvbBWJklPbrF53kadbZbQtALX08BOGPmFgHz1Bsg5Vl
	 g1Yt0h0JP6bIBZjPyB+V47QPcoiafKvq2Dp1BkF1LuCkQ//KcrUKIfg41HsGPMpU/S
	 5PMP2Y9PuZzVekRKzD3hKCEEzlxBR8H6nO3pCafRq3nAb3w3E5EBkMdwgeLn5q2aZ8
	 ehrBFvWbuhVFw==
Date: Thu, 23 Jul 2026 15:05:57 -0500
From: sergeh@kernel.org
To: Paul Moore <paul@paul-moore.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	linux-security-module@vger.kernel.org,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] capability: remove non-kernel-doc comments
Message-ID: <amJ0JZkuRreQLth6@AUS2MQ6190Y76.amd.com>
References: <20260723165209.226050-1-rdunlap@infradead.org>
 <CAHC9VhSxv-=sszc-he+oupu2ZAUCoQ9+RfF4=ZG9UajYfTK5wA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSxv-=sszc-he+oupu2ZAUCoQ9+RfF4=ZG9UajYfTK5wA@mail.gmail.com>

On Thu, Jul 23, 2026 at 01:08:38PM -0400, Paul Moore wrote:
> On Thu, Jul 23, 2026 at 12:52 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > Convert 2 "/**" comments to use plain C "/*" comment style to avoid
> > kernel-doc warnings:
> >
> > Warning: include/uapi/linux/capability.h:114 expecting prototype for
> >  POSIX(). Prototype was for CAP_CHOWN() instead
> > Warning: include/uapi/linux/capability.h:175 expecting prototype for
> >  Linux(). Prototype was for CAP_SETPCAP() instead
> >
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > ---
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> >
> >  include/uapi/linux/capability.h |   12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> I'm assuming Serge will take this via the capabilities tree, but I can
> always take it via the LSM tree if he prefers.

Yup, I'll take it, thanks.

> Reviewed-by: Paul Moore <paul@paul-moore.com>

