Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1F7487597
	for <linux-security-module@vger.kernel.org>; Thu,  8 Jan 2026 11:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873016; cv=none; b=DNfIpBVfRmBR3dOuA/m9Ea9Qful6PL64y0nvdpz7I4+vKmPlvXJ29zUGI6ARyTbqcwSf5HO8g4dpALxDlLFJpPNG4o1TuT83AAQivPsr1+HJKC6mXoqc3pyksPZ1Oe9wjPwje3AAHJ6nfqRiaaWzvLlWBwStJGDciY9xUxVzG1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873016; c=relaxed/simple;
	bh=zMrDOdJlJfblUj3s8NSBHfHcO493THfQb+u8c0TgY4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVm3hY4VVZ/Ct2ylk/pHjobxzAfrWe9p6tdKWDlei4X4wZXgsquPS2Dgu4uRkzj01YelYzmjPHeUloVk5vT5MVzGJ/HeuMuxHR0L2jJdOqj9g1zAuIvdDxCTa1/yXNZkELnZnNJisn/u/tLAi1KpUIX+532oF/B7uF3rNOOl45Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=rkQq4zoJ; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="rkQq4zoJ"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dn2P34SlJz1C1;
	Thu,  8 Jan 2026 12:14:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1767870887;
	bh=MLSPNFwurXe0dw5EDD88i0r1rQxZlhSMUT+r4QQRUzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rkQq4zoJuu0WEeEw2XOfMt8lvW5AGtGTqB2yTWkjqYZVsc00pwfdSIJVkoXnI5zUL
	 X6GmKd4C3jpn88mztMTlcaFXIdsI4gWfgXu4ilk6tqTThBtDj3EuzRijXk8iSyeebF
	 6PCzbPBTjN06UKvYE8BJLH9XSJvIKK2x2XOi5V7I=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dn2P30FgMzgf2;
	Thu,  8 Jan 2026 12:14:47 +0100 (CET)
Date: Thu, 8 Jan 2026 12:14:41 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	Tingmao Wang <m@maowtm.org>, Paul Moore <paul@paul-moore.com>, 
	linux-security-module@vger.kernel.org, Justin Suess <utilityemal77@gmail.com>, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, Alyssa Ross <hi@alyssa.is>, 
	Jann Horn <jannh@google.com>, Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [RFC PATCH 0/5] landlock: Pathname-based UNIX connect() control
Message-ID: <20260108.uoD0aesh8Uth@digikod.net>
References: <20260101134102.25938-1-gnoack3000@gmail.com>
 <61a6be66-a9bd-4d68-98ed-29aac65b7dfb@gmail.com>
 <73c5509a-5daa-4ea5-ab9f-e24a59786f6d@maowtm.org>
 <1d36b2ee-b967-42d7-a6c2-e5b1602a512f@gmail.com>
 <20260102.93e0d7b9c9b5@gnoack.org>
 <81f908e3-8a98-46e7-b20c-fe647784ceb4@gmail.com>
 <20260102.17e1c2b9faa4@gnoack.org>
 <64484ab4-e137-4fd9-9441-a63ccdff1616@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64484ab4-e137-4fd9-9441-a63ccdff1616@gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Jan 02, 2026 at 01:37:14PM -0500, Demi Marie Obenour wrote:
> On 1/2/26 05:50, Günther Noack wrote:
> > On Fri, Jan 02, 2026 at 05:27:40AM -0500, Demi Marie Obenour wrote:
> >> On 1/2/26 05:16, Günther Noack wrote:
> >>> On Thu, Jan 01, 2026 at 05:44:51PM -0500, Demi Marie Obenour wrote:
> >>>> On 1/1/26 17:34, Tingmao Wang wrote:
> >>>>> On 1/1/26 22:14, Demi Marie Obenour wrote:
> >>>>>> [...]
> >>>>>> Does this leave directory traversal as the only missing Landlock
> >>>>>> filesystem access control?  Ideally Landlock could provide the same
> >>>>>> isolation from the filesystem that mount namespaces do.
> >>>>>
> >>>>> I think that level of isolation would require path walk control - see:
> >>>>> https://github.com/landlock-lsm/linux/issues/9
> >>>>>
> >>>>> (Landlock also doesn't currently control some metadata operations - see
> >>>>> the warning at the end of the "Filesystem flags" section in [1])
> >>>>>
> >>>>> [1]: https://docs.kernel.org/6.18/userspace-api/landlock.html#filesystem-flags
> >>>>
> >>>> Could this replace all of the existing hooks?
> >>>
> >>> If you do not need to distinguish between the different operations
> >>> which Landlock offers access rights for, but you only want to limit
> >>> the visibility of directory hierarchies in the file system, then yes,
> >>> the path walk control described in issue 9 would be sufficient and a
> >>> more complete control.
> >>>
> >>> The path walk control is probably among the more difficult Landlock
> >>> feature requests.  A simple implementation would be easy to implement
> >>> technically, but it also requires a new LSM hook which will have to
> >>> get called *during* path lookup, and we'd have to make sure that the
> >>> performance impact stays in check.  Path lookup is after all a very
> >>> central facility in a OS kernel.
> >>
> >> What about instead using the inode-based hooks for directory searching?
> >> SELinux can already restrict that.
> > 
> > Oh, thanks, good pointer!  I was under the impression that this didn't
> > exist yet -- I assume you are referring to the
> > security_inode_follow_link() hook, which is already happening during
> > path resolution?
> 
> I'm not familiar with existing LSM hooks, but I do know that SELinux
> enforces checks on searching and reading directories and symlinks.

SELinux uses inode-based hooks, which is not (directly) possible for
Landlock because it is an unprivileged access control, which means it
cannot rely on extended file attributes to define a security policy.

See https://github.com/landlock-lsm/linux/issues/9

> 
> > I take it back then. :) If there is prior art, implementing this might
> > be more feasible than I thought.
> 
> I think so too!
> -- 
> Sincerely,
> Demi Marie Obenour (she/her/hers)





