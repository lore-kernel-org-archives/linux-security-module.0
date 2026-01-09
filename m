Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67412363C55
	for <linux-security-module@vger.kernel.org>; Fri,  9 Jan 2026 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972333; cv=none; b=GK9ikAplY83x/BpHMCvONG1LOFwcJQfesCRfCtdT4EQPgUWMJJd15SOnf0bM68VAxuN39UlJwMGhhT5Lo1U7NNnxmWyGshMtC/mN/KBHTBWphlU1fTZKfc5UNv1dJYye9HEaBNrn8DglEMK6d4CWQUa7FFGFeI8peuRIsq8LIUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972333; c=relaxed/simple;
	bh=VwR6rITCTT/5W6kOS7rTSUcoCYLlb7c3vLq55qymEDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjEtQdn75XP1FsrkMqxpjx1MWXNffOaaFCl1/ZThHRtmbZmhp7dQ5rhk9JYuVk/n+LrEUi8g4EWAQC6Br+JCkn6Jz5UyXX5L5yC05XM/iXLxY4weGjmaxa1grKYeD/Oj0LYE7991eU5esVngsqp+1jCrXMhB1CpTttwOa6QKs7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=zOsl2MCn; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="zOsl2MCn"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dnlvl2pqSzFLV;
	Fri,  9 Jan 2026 16:25:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1767972323;
	bh=iKnHglTUbcZ4XDCh4O3nJLB8hAFlIIsic8IdBnOoJAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zOsl2MCndj5u5uUlawakiDdmnb+PmMIBolpwpl37ei19J8i5/JmzHz+TCiUauv5rx
	 zhTmlTjGnPIVl3smDqRrUgQk6O6UkRZny51x3ZFh0NcE2ZGev281dHGvxryLB9byWR
	 W6tJJ5+/xSMRIpXoM2nWCVPN0n8ec0Sv4MPtjHdU=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dnlvk5cTnzX6X;
	Fri,  9 Jan 2026 16:25:22 +0100 (CET)
Date: Fri, 9 Jan 2026 16:25:21 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	Tingmao Wang <m@maowtm.org>, Paul Moore <paul@paul-moore.com>, 
	linux-security-module@vger.kernel.org, Justin Suess <utilityemal77@gmail.com>, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, Alyssa Ross <hi@alyssa.is>, 
	Jann Horn <jannh@google.com>, Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [RFC PATCH 0/5] landlock: Pathname-based UNIX connect() control
Message-ID: <20260109.yahQuiwu9kug@digikod.net>
References: <20260101134102.25938-1-gnoack3000@gmail.com>
 <61a6be66-a9bd-4d68-98ed-29aac65b7dfb@gmail.com>
 <73c5509a-5daa-4ea5-ab9f-e24a59786f6d@maowtm.org>
 <1d36b2ee-b967-42d7-a6c2-e5b1602a512f@gmail.com>
 <20260102.93e0d7b9c9b5@gnoack.org>
 <81f908e3-8a98-46e7-b20c-fe647784ceb4@gmail.com>
 <20260102.17e1c2b9faa4@gnoack.org>
 <64484ab4-e137-4fd9-9441-a63ccdff1616@gmail.com>
 <20260108.uoD0aesh8Uth@digikod.net>
 <a5850eb9-cee3-412d-ac20-c47e3161fdd9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5850eb9-cee3-412d-ac20-c47e3161fdd9@gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Jan 09, 2026 at 06:33:10AM -0500, Demi Marie Obenour wrote:
> On 1/8/26 06:14, Mickaël Salaün wrote:
> > On Fri, Jan 02, 2026 at 01:37:14PM -0500, Demi Marie Obenour wrote:
> >> On 1/2/26 05:50, Günther Noack wrote:
> >>> On Fri, Jan 02, 2026 at 05:27:40AM -0500, Demi Marie Obenour wrote:
> >>>> On 1/2/26 05:16, Günther Noack wrote:
> >>>>> On Thu, Jan 01, 2026 at 05:44:51PM -0500, Demi Marie Obenour wrote:
> >>>>>> On 1/1/26 17:34, Tingmao Wang wrote:
> >>>>>>> On 1/1/26 22:14, Demi Marie Obenour wrote:
> >>>>>>>> [...]
> >>>>>>>> Does this leave directory traversal as the only missing Landlock
> >>>>>>>> filesystem access control?  Ideally Landlock could provide the same
> >>>>>>>> isolation from the filesystem that mount namespaces do.
> >>>>>>>
> >>>>>>> I think that level of isolation would require path walk control - see:
> >>>>>>> https://github.com/landlock-lsm/linux/issues/9
> >>>>>>>
> >>>>>>> (Landlock also doesn't currently control some metadata operations - see
> >>>>>>> the warning at the end of the "Filesystem flags" section in [1])
> >>>>>>>
> >>>>>>> [1]: https://docs.kernel.org/6.18/userspace-api/landlock.html#filesystem-flags
> >>>>>>
> >>>>>> Could this replace all of the existing hooks?
> >>>>>
> >>>>> If you do not need to distinguish between the different operations
> >>>>> which Landlock offers access rights for, but you only want to limit
> >>>>> the visibility of directory hierarchies in the file system, then yes,
> >>>>> the path walk control described in issue 9 would be sufficient and a
> >>>>> more complete control.
> >>>>>
> >>>>> The path walk control is probably among the more difficult Landlock
> >>>>> feature requests.  A simple implementation would be easy to implement
> >>>>> technically, but it also requires a new LSM hook which will have to
> >>>>> get called *during* path lookup, and we'd have to make sure that the
> >>>>> performance impact stays in check.  Path lookup is after all a very
> >>>>> central facility in a OS kernel.
> >>>>
> >>>> What about instead using the inode-based hooks for directory searching?
> >>>> SELinux can already restrict that.
> >>>
> >>> Oh, thanks, good pointer!  I was under the impression that this didn't
> >>> exist yet -- I assume you are referring to the
> >>> security_inode_follow_link() hook, which is already happening during
> >>> path resolution?
> >>
> >> I'm not familiar with existing LSM hooks, but I do know that SELinux
> >> enforces checks on searching and reading directories and symlinks.
> > 
> > SELinux uses inode-based hooks, which is not (directly) possible for
> > Landlock because it is an unprivileged access control, which means it
> > cannot rely on extended file attributes to define a security policy.
> > 
> > See https://github.com/landlock-lsm/linux/issues/9
> 
> Could Landlock use a side table, with the inode's address in memory
> as the key?

A struct inode is not enough because we need to resolve a file
hierarchy, which is only possible with a struct path.
