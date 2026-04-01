Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F61447799E
	for <linux-security-module@vger.kernel.org>; Wed,  1 Apr 2026 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775061043; cv=none; b=byBVlUmrqihi39KqtMC295Ybr7A2gSBAE//UceiXICUacMEn/73X9gQtOA8z2Z7zA0tbotm3UVB14Is22OpT1Owgw9C5rVlWlvJ1cTWX3y7EOIqTcLB52pKpxP/BndXhTzTWDsjb+jhkcNqGV858zPIa6JeagCCuIZ2FYllgbac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775061043; c=relaxed/simple;
	bh=xffdP8b+xNS7ZZJMNDWxkaOwEUrlBf8vEehoEryfC4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZSa/tLOg2Rhc9kM/VgkE/hONjyaDn9OxTHLTpJDMSxopCaUjuVGEk3+F3yuEISGrEOEv2kNTZHFn7OASwHPpjHFL+hhLje7PoW1fNyTVYKcIZOW8pMYG2VuET67RSqkpFBIhA5j/l8s0L0Z62MOyabOTRSeNRQS9jRqjywfWdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=XphJcgzU; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="XphJcgzU"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fm9T25DfDzKln;
	Wed,  1 Apr 2026 18:30:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775061030;
	bh=JuWr13LtIdTMpa1/rQxH1LWPOEVdPRCm/X3aPAFgClE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XphJcgzUsscg8LoSJWYjKCaZPdy5joW8B/1ND+IwmSVzm6rkWPuQXFEDOJn+8XfQ9
	 alenBD//t6LnLH9BD3Xqox7qe7s6jobCA12VYTu9ljH4spSd6F7QMsIO2F8uvgqF0g
	 seeE1huBiDrYf/Qf84xu9R6k7axONAceckB7uVzA=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fm9T2292MzRBf;
	Wed,  1 Apr 2026 18:30:30 +0200 (CEST)
Date: Wed, 1 Apr 2026 18:30:28 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org
Subject: Re: [PATCH] landlock: Document fallocate(2) as another truncation
 corner case
Message-ID: <20260401.oor1chahp2oF@digikod.net>
References: <20260401150911.1038072-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260401150911.1038072-1-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Wed, Apr 01, 2026 at 05:09:10PM +0200, Günther Noack wrote:
> Reinforce the already stated policy that LANDLOCK_ACCESS_FS_TRUNCATE should
> always go hand in hand with LANDLOCK_ACCESS_FS_WRITE_FILE, as their
> meanings and enforcement overlap in counterintuitive ways.
> 
> On many common file systems, fallocate(2) offers a way to shorten files as
> long as the file is opened for writing, side-stepping the
> LANDLOCK_ACCESS_FS_TRUNCATE right.
> 
> Assisted-by: Gemini-CLI:gemini-3.1
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  Documentation/userspace-api/landlock.rst | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 7f86d7a37dc2..d5691ec136cc 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -378,8 +378,8 @@ Truncating files
>  
>  The operations covered by ``LANDLOCK_ACCESS_FS_WRITE_FILE`` and
>  ``LANDLOCK_ACCESS_FS_TRUNCATE`` both change the contents of a file and sometimes
> -overlap in non-intuitive ways.  It is recommended to always specify both of
> -these together.
> +overlap in non-intuitive ways.  It is strongly recommended to always specify
> +both of these together (either granting both, or granting none).
>  
>  A particularly surprising example is :manpage:`creat(2)`.  The name suggests
>  that this system call requires the rights to create and write files.  However,
> @@ -391,6 +391,10 @@ It should also be noted that truncating files does not require the
>  system call, this can also be done through :manpage:`open(2)` with the flags
>  ``O_RDONLY | O_TRUNC``.
>  
> +At the same time, on some filesystems, :manpage:`fallocate(2)` offers a way to
> +shorten file contents with ``FALLOC_FL_COLLAPSE_RANGE`` when the file is opened
> +for writing, sidestepping the ``LANDLOCK_ACCESS_FS_TRUNCATE`` right.

Interesting, which filesystems?  Shouldn't it be fixed in the code
instead?

> +
>  The truncate right is associated with the opened file (see below).
>  
>  Rights associated with file descriptors
> -- 
> 2.53.0.1185.g05d4b7b318-goog
> 
> 
