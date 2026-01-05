Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFD43A1E6D
	for <linux-security-module@vger.kernel.org>; Mon,  5 Jan 2026 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767654597; cv=none; b=Q7UrqPmAnd4RvvnaGV6ClTcSqbsk/feTece/m+BYQpiskrjbDpAy2khqvxqOmLSjaslv6BkE8jSZhRIFmOkPDP8UwOHsUyJDuJgsLNERCmC9RCLxV31cRd6x1TT1ldj5IOwwLPqrTcWMDyDBZxQ2PmY/0yroZSblVQj1sBOhzAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767654597; c=relaxed/simple;
	bh=avo5CR9Z1DYQeJXwYN+xxzxXqUvd/jN3tXFeP6w6pys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pb6arcFU3lnX9M8o9Z/0M3TIw7R5gvvd4kZlHwA9LeP8uYnAjzb+wXaOtfhgDHUXZGhiLA0ihSvc5IWPw0BSgtQhTP1yQXCRHGKrZ03zvCsl7fBwIoBzxHe+MXmP3jZ7tJODSsplG+f7Jezu7EcS/M1t3Be4JSCymMlPWu+8V5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GMcjywvj; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GMcjywvj"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-65e943048afso186490eaf.0
        for <linux-security-module@vger.kernel.org>; Mon, 05 Jan 2026 15:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767654594; x=1768259394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7BfI8p5Sg/gvNukiFtFu/vPv9ZMQSyL6zAakTHxHqPk=;
        b=GMcjywvj0eVcWJ+mhdKworuuKpRddK3/pUdblBKr9rO+pszwMbAEbPPiNo4m3p0Fcd
         ul50D6HpXBxTWkZO7RpReNJ7I8dqFqDlwOfPflrEkev1qEsLgEyhTxAfgOZ/xru1UGyq
         4M3BKhqMAle4HWh7XCjs0q36txrL1n+dbEVlt3EwlSM1g2omsHhY7gUJ7F6t2aUmH43X
         MrI3bWM+CklFbl2jOKpqaI7mfOkwNsf9rmakotlSnAkERdE7iDznb3KWVW33fhDl0tGe
         ORhNMXGVRf4+/BWhA34Kpx0Jvhak/b18ZfJmLwHE0JJfuvD2CvfwBsJb0k4zi99Ij5Bd
         E8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767654594; x=1768259394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BfI8p5Sg/gvNukiFtFu/vPv9ZMQSyL6zAakTHxHqPk=;
        b=Xqh3+mIbqueHGZ+dwCRJunR6I3ujbmjNtPuSC8YidSQCi3Im6dCsSiqV9yESp1ygrF
         hACaGUHsGgYZq41l4ZqNeOa3J0hRbpSmn9ioJUtq+lmqd7GAxEjTR5GT2zPGxAzkfrdK
         mbk8by8dlIL7bkEw4wjl0LqTt97ojH8uUXw+5BrenN0ggCqLvk9+xBVFZXxcl3q903m/
         ISfqGfkvIEde+dtrKAbGukdcwhjj8RajSlJ9aZ2nOV9ENoJx7ZAebzCwQOh5F9aXARGO
         9meYH7luLzWJ0LELvCnFdo/65TMY1EYqQx6geHjD9IrE92wPN7y5mcY2+OGf/Wcici2w
         E8qw==
X-Forwarded-Encrypted: i=1; AJvYcCXIS7tizfCsrI92N7bhzNT1ZOftVRmoXIUNFHWzFfQ+BBQKFL8/Qbz4uyMJ6hz7vzI2PVXg+oTwxdmlMWPDYbn1BwOUW+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyap6OfbdNSYnx2evrrRRMlo3xWOF49kowmiKeQOqxe3esLaT7E
	mZU/tkiTAIy1yyvjCRfD0NLg5E84GZIM+Ak+nm8Od/LL8HwfcMTbBTXIJGwsDMlvBcs=
X-Gm-Gg: AY/fxX45gt6+S8gD1JSr5+K5zzBIhdjljL5+yXt0yJQdIhBjj+GB4lrhSLdvjcqp+kV
	ZoBaUAKBq35igRA3HR8+vv4yLfF0sDMuhA+tzwYo7dAROUpcg8m7F7i1PN94+tdkmhweYooG6Q9
	SO4vgYK9w/h2nl1PDqYk66SBKPUDLxD8BP0x7UAP4e5BylibXaTgd/zZmWpzdL+WyL8qeT0dOkj
	NfyRSzMjpPuv6vHSLAY0YjpWcs9I38oaCIAZYNcya6f2mWCTBET4ypzafZdmaadkjsr9BKEOSmE
	Ji/3H6AQD+onOWYl2cAG7jK/+8kz87rUqg6zFAPjQoL4C4Xf3lwEpnY+UXBvw7kVKfNjT8L1W4Z
	hrBKSyPUgq5uQ9yay/+t5+NhgCNLZ1FAaIsZDUBHO/PfklC4svb8dtPC0jLrcovER4g==
X-Google-Smtp-Source: AGHT+IHvXL/KsqfHMGfaILEYbvXCIfRFUV+zAwS7sLeUwWiNFvLcGCxGKaIGOym3oFjVne8ZfPZqqA==
X-Received: by 2002:a05:6820:1c91:b0:65b:32b4:840a with SMTP id 006d021491bc7-65f47a2fbe5mr601235eaf.51.1767654594081;
        Mon, 05 Jan 2026 15:09:54 -0800 (PST)
Received: from CMGLRV3 ([2a09:bac5:947d:4e6::7d:88])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65f48ab2d00sm251173eaf.0.2026.01.05.15.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 15:09:53 -0800 (PST)
Date: Mon, 5 Jan 2026 17:09:51 -0600
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH RFC] ima: Fallback to a ctime guard without i_version
 updates
Message-ID: <aVxEv3k9YeG1or8z@CMGLRV3>
References: <20251229-xfs-ima-fixup-v1-1-6a717c939f7c@cloudflare.com>
 <4a4778ff395e533cad86ff3ffbf0ba90c3eb8798.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a4778ff395e533cad86ff3ffbf0ba90c3eb8798.camel@linux.ibm.com>

Hi Mimi,

On Mon, Jan 05, 2026 at 05:15:15PM -0500, Mimi Zohar wrote:
> On Mon, 2025-12-29 at 11:52 -0600, Frederick Lawler wrote:
> > Since commit 1cf7e834a6fb ("xfs: switch to multigrain timestamps"), IMA
> > is no longer able to correctly track inode.i_version due to the struct
> > kstat.change_cookie no longer containing an updated i_version.
> > 
> > Introduce a fallback mechanism for IMA that instead tracks a
> > integrity_ctime_guard() in absence of or outdated i_version
> > for stacked file systems.
> 
> Thanks, Frederick.
> 
> Instead of using the new function name integrity_ctime_guard() to describe the
> change, please describe the change in words.  Perhaps something like: rely on
> the inode's ctime to detect a file data or metadata change.
> 

Sure thing, I'll change for the v1.

> The purpose of generating a ctime guard value, as opposed to using the tv_sec
> and tv_nsec, I assume is to minimize the amount of memory being saved in the
> iint.

This was Jeff's suggestion. It does serve the purpose on saving
some memory, but also has some value in the event nsec or sec is zero'd.
It just needs to be different enough from the last cache'd evaluation.

> 
> > 
> > EVM is left alone since it mostly cares about the backing inode.
> > 
> > Link: https://lore.kernel.org/all/aTspr4_h9IU4EyrR@CMGLRV3
> > Fixes: 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
> > Suggested-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> > ---
> > The motivation behind this was that file systems that use the
> > cookie to set the i_version for stacked file systems may still do so.
> > Then add in the ctime_guard as a fallback if there's a detected change.
> > The assumption is that the ctime will be different if the i_version is
> > different anyway for non-stacked file systems.
> 
> Agreed. This patch inverts the i_version test to return immediately if the
> i_version hasn't changed and then checks the ctime guard value.  Is the ctime
> guard value test simply a performance improvement?
> 

Kinda. The thought was to make already-audited files that have an
unchanged i_version since last audit succeed early.

Stacking tempfs on XFS for instance, would incur the stat cost each
evaluation, since the cookie that used to set the i_version on
evaluation with XFS on 6.12, is now always setting it to zero since 6.13.

> > 
> > I'm not too pleased with passing in struct file* to
> > integrity_inode_attrs_changed() since EVM doesn't currently use
> > that for now, but I couldn't come up with another idea to get the
> > stat without coming up with a new stat function to accommodate just
> > the file path, fully separate out IMA/EVM checks, or lastly add stacked
> > file system support to EVM (which doesn't make much sense to me
> > at the moment).
> > 
> > I plan on adding in self test infrastructure for the v1, but I would
> > like to get some early feedback on the approach first.
> 
> I really appreciate your adding a self test.
>

I was poking around last week at some testing platforms, and instead of
adding to kernel sefltests & setup a VM etc..., to instead add to 
Linux Test Project (LTP) if that's fine?

In any case, I can add my test snippet to v1, so you have something
to review with the patch. That snippet works the same on 6.12 as it
does on 6.19 with this patch.

> thanks,
> 
> Mimi
