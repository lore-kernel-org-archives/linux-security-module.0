Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1B7224DD;
	Tue, 16 Jul 2024 07:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721114271; cv=none; b=kH9BMcKaxO3okgZseQdiFIO/YcjT6AG3L+nnDGLjoGVwCRwQqajtNCXieOUD7uUqQTkvZ8EWTl5J1T0m4NKbEYNH8d3LmS2RGx7pjuOVEpXTluozRoWnZ9THN9/fRtH0Y2ZDI3mqC9zbgU7h1gaeA0KhWt92KXiCjXYiBI6fhts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721114271; c=relaxed/simple;
	bh=RPgWsqPkqCULp4EQ+wvnSiI5qZJJnSgv+KSWYJap9FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7Naw9II62+wUbl94Il8Q0EjyrnfqaxQqmU801GbYGWQyF1/3yL1kUrlULErExob8iT3kKjPiWhIUaJoqIPdMli9o669yDUV9zSQSMLzhjJcSh0ym1MasEoj9WrYm5jBq4FKjirUmwSwTUt9cR0OAXwOfZ9ar4/Mo3Jx0+JL30U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qol7SDQ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qol7SDQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3090C116B1;
	Tue, 16 Jul 2024 07:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721114270;
	bh=RPgWsqPkqCULp4EQ+wvnSiI5qZJJnSgv+KSWYJap9FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qol7SDQ7A+QwlDSeEI7eAS/Z1zvSCkF4W3o+eiSTQqh/LABcA7jc0v4z6+F6Kov6W
	 +RZLe8LxVUtWD4DySlu2IwZzdq3EBqtNWlNHeu1awbyVcufffzY4x4sg8R8htoWfjX
	 IqlKgS9QQ0ptVMtm52T+fGYT6K9UwoVIQUPaKh64=
Date: Tue, 16 Jul 2024 09:17:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kees Cook <kees@kernel.org>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>, cve@kernel.org,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: CVE-2024-40938: landlock: Fix d_parent walk
Message-ID: <2024071617-unscathed-spur-f4e5@gregkh>
References: <2024071218-CVE-2024-40938-1619@gregkh>
 <20240715.aeLiunipi8ia@digikod.net>
 <2024071553-yippee-broadways-8035@gregkh>
 <20240715.Eishohd0ehoo@digikod.net>
 <202407150908.34E00AAD1@keescook>
 <20240715.seingevie9Ph@digikod.net>
 <202407151315.88BE0662@keescook>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202407151315.88BE0662@keescook>

On Mon, Jul 15, 2024 at 01:17:10PM -0700, Kees Cook wrote:
> On Mon, Jul 15, 2024 at 08:04:21PM +0200, Mickaël Salaün wrote:
> > Yes, that's why we use WARN_ON_ONCE() to check cases that should never
> > happen (at the time of writting), but in practice it's useful to check
> > (with fuzzing) that this assertion is true.  However, if a
> > WARN_ON_ONCE() is reached, this doesn't mean that this is a security
> > issue, but just an unexpected case that kernel maintainers should be
> > notified with to fix it.
> 
> I leave CVE determinations to the CNA. :) I think the difficulty here is
> with having no way to trivially see which WARN is security sensitive and
> which isn't, and since WARNs may panic, all WARNs could be a DoS, and
> therefore may be a CVE for some deployment somewhere.

That is exactly correct, and why we must mark any way that userspace can
hit a WARN as needing a CVE.

thanks,

greg k-h
