Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9726B381EA1;
	Sat, 22 Aug 2026 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787432788; cv=none; b=r3/tFjQz8T9GYH8UWJCzwShaZu71DiJFkhdeeddm3bbl0xUgkDL3EzrulrH8ahWnjMrtYpajXo098LEYjEdRHq1IaPS06BQQvdH0fPgJFPh8012EHL1+NRIkPgBCZLb+z41zQiw7ioPZxbmTFNHruGNdoyv+ItqjrR3miuc6WhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787432788; c=relaxed/simple;
	bh=r5VLG+4JjYR6LAQFqjm05JwS6ilIqIvR712UbIefMQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lax+ePBFhQx0CONBQuIOew8Wji6m3qHNKR0l35gt8f2q97VSo0YwZCXonrTumh2fN7hEhheOfWwbjK4C7SWClxLUDFXL9OYTS5tv11vdxSRgPUZj8mTITHJL7GL/Zc9B0FuL442xNr5pj4vhoBITSYv9VVYj1snzankxjO+nJBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=unknown smtp.mailfrom=mail.hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=VZjXHUWY; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=mail.hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="VZjXHUWY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1787432782; bh=r5VLG+4JjYR6LAQFqjm05JwS6ilIqIvR712UbIefMQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VZjXHUWY1qfcOz3Ai+Xc+7DhiIFqLfSdlJqg8CSHm+BSQEZxCYBww3qb9O8OkD80R
	 EwWCo74/rNgBndC6jZipuqOBALVrodzxNDQRgxCnOlzgL9/qsQg6BfjKZVf843y7ne
	 Fmirgh+f/SPr833rnp9Ra+25zSlQ8LqXUKGDRpkK9Rp2J4R3awU9w0bA3Jb4+KXbgU
	 qZ3xl/PrNTsrNmGnOQqckzCXnHrRGX5jt24KOxdCsA4qxcHvjpnK0kLUYPx0AWc1Ys
	 S8QL2WTKCEv8LrlzxEj7UrKFKsvv5N0OoS5evyVwf4DK0WvFFI6VdUTTSLCTXIdx4S
	 pewT+eUjc7oTw==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 5093328C; Sat, 22 Aug 2026 16:06:22 -0500 (CDT)
Date: Sat, 22 Aug 2026 16:06:22 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [GIT PULL] capabilities update for v7.3
Message-ID: <aooPTp+6qQlp1h5V@mail.hallyn.com>
References: <aom3Gwl3GkBpw4fr@mail.hallyn.com>
 <CAHk-=wi4uW6cmMEu4Gp0cFzu=TRTBAEf+5BdKfPkX6kyPSG63w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi4uW6cmMEu4Gp0cFzu=TRTBAEf+5BdKfPkX6kyPSG63w@mail.gmail.com>

On Sat, Aug 22, 2026 at 09:15:45AM -0700, Linus Torvalds wrote:
> On Sat, 22 Aug 2026 at 07:50, Serge E. Hallyn <serge@hallyn.com> wrote:
> >
> > It's available at
> >
> > git@git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git #caps-20260820
> >
> > on top of commit 1590cf0329716306e948a8fc29f1d3ee87d3989f (tag: v7.2-rc4)
> 
> Your tag message is garbage - that's neither valid syntax nor the name
> of the tag nor even a valid git.kernel.org pointer.
> 
> The *regular* 'git pull-request' part was correct, but you should
> probably fix whatever script you use to create that tag message.
> Probably just removing that whole bogus "it's available at ..." part.
> 
>                  Linus

Oh, in the tag message itself, yeah, I see.  Thanks, will fix for
next time.

-serge
