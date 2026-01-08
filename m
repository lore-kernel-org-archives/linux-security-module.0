Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D283AE6FD
	for <linux-security-module@vger.kernel.org>; Thu,  8 Jan 2026 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876017; cv=none; b=LwAMXP6X9t9gyIGGlgXzCZ5TZg0KPX9JgLHBLb9qtcC3Fqm+C1peABtbvSx227IbdFP8jMQ3DCh90N3fH4dwOaizi/NleRXPzgywRCfjLNAkpDxpLRGXlouzUX4BlrX9D7Ko70oHfZtawdL8JRlF2MjNgKPK5n9iyN4dJ31gG4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876017; c=relaxed/simple;
	bh=HLwV7Is5lkxTUQGPFEAgQewzV6Ep3PmR/xp1lM4wAyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0JSYC/XkDCJIJaJP3/ZPVVFlNKBnKDfkdmamnm7Wzj6ilUPQOdnsEUI6/lJvaEZPs57f0gmpDVU5fSXDNaw9kDAPLWojJCDmxnV3T76yAvpoRGwwFUOFzs+ot1agCiBvQc9OPBaLAahoHIpspOp8McVf5QcioKTduT8cHd9XK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=vKeHkq/p; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="vKeHkq/p"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dn3gL416Mz14bN;
	Thu,  8 Jan 2026 13:12:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1767874334;
	bh=s85DhQIcafXG1peBDnmh0Zu+fNK+q7mdW9IuKsYyrSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vKeHkq/phg0/y5q/B2OQZeATNODmmdCwBxysxxft4l2YnXwX4tvPOypOhJ1y+lFgL
	 mxruuUDwDsYpFhV3V9xT2BiO6PJKTsyZyuYDBh8hSiwRb6Pq0c1QExxphuixwk1Gz1
	 jWzG4NECB+RJDhjSumikRdzoUfDSB2bs7T2wPEAQ=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dn3gK0zKSzYkM;
	Thu,  8 Jan 2026 13:12:13 +0100 (CET)
Date: Thu, 8 Jan 2026 13:12:07 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: Demi Marie Obenour <demiobenour@gmail.com>, 
	Justin Suess <utilityemal77@gmail.com>, Tingmao Wang <m@maowtm.org>, fahimitahera@gmail.com, 
	hi@alyssa.is, ivanov.mikhail1@huawei-partners.com, jannh@google.com, 
	konstantin.meskhidze@huawei.com, linux-security-module@vger.kernel.org, matthieu@buffet.re, 
	paul@paul-moore.com, samasth.norway.ananda@oracle.com
Subject: Re: [RFC PATCH 3/5] samples/landlock: Add support for
 LANDLOCK_ACCESS_FS_CONNECT_UNIX
Message-ID: <20260108.Thaex5ruach2@digikod.net>
References: <20260101134102.25938-4-gnoack3000@gmail.com>
 <20260101193009.4005972-1-utilityemal77@gmail.com>
 <423dd2ca-ecba-47cf-98a7-4d99a48939da@maowtm.org>
 <22e29fd8-2f39-4a64-b08c-2f41153e3be8@gmail.com>
 <2d02eefa-bc86-4f04-b190-beed304337d4@maowtm.org>
 <43c0515d-afd3-4e00-a0fe-4d651a1d5cf1@gmail.com>
 <884e44c6-7695-49a2-8d60-c7e76d260bea@gmail.com>
 <20260102.d6870733fe10@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260102.d6870733fe10@gnoack.org>
X-Infomaniak-Routing: alpha

On Fri, Jan 02, 2026 at 10:53:49AM +0100, Günther Noack wrote:
> On Thu, Jan 01, 2026 at 05:39:26PM -0500, Demi Marie Obenour wrote:
> > On 1/1/26 17:38, Justin Suess wrote:
> > > On 1/1/26 17:19, Tingmao Wang wrote:
> > >> On 1/1/26 22:11, Demi Marie Obenour wrote:
> > >>> On 1/1/26 17:07, Tingmao Wang wrote:
> > >>>
> > >>> (snip)
> > >>>
> > >>>> Looking at this I guess it might also make sense for the kernel side to
> > >>>> enforce only being able to add LANDLOCK_ACCESS_FS_CONNECT_UNIX on socket
> > >>>> files (S_ISSOCK(d_backing_inode)) too in landlock_append_fs_rule?
> > >>>>
> > >>>> Also, for the sandboxer logic, maybe a better way would be having
> > >>>> LANDLOCK_ACCESS_FS_CONNECT_UNIX in ACCESS_FILE (matching the kernel code),
> > >>>> then another if(!S_ISSOCK) below this that will clear out
> > >>>> LANDLOCK_ACCESS_FS_CONNECT_UNIX if not socket.
> > >>> A process might legitimately need to connect to a socket that doesn't
> > >>> exist at the time it sandboxes itself.  Therefore, I think it makes
> > >>> sense to for LANDLOCK_ACCESS_FS_CONNECT_UNIX access to a directory
> > >>> to allow LANDLOCK_ACCESS_FS_CONNECT_UNIX to any socket under that
> > >>> directory.  This matches the flexibility mount namespaces can achieve.
> > >> Right, I forgot about the fact that we also need it on dirs, apologies.
> > >>
> > >> (But maybe it might still make sense to not allow this on files which are
> > >> neither a socket or a dir? (If the file later gets removed and recreated
> > >> as a socket, the rule would not apply retroactively anyway due to being
> > >> tied to the inode.))
> > > How do we handle IOCTL access on regular files? I think that landlock will let you put IOCTL rights on regular files even they are not valid for that operation.
> > 
> > Regular files definitely support ioctls.
> 
> The LANDLOCK_ACCESS_FS_IOCTL_DEV right only applies to ioctl(2)
> invocations on device files.
> 
> 
> > > Sockets seem like a similar case where the operation is only valid for a subset of file types.
> > > 
> > > I think we should mirror the existing behavior is for consistency.
> > > 
> > > Besides, restricting which file types can have that right also makes it harder for applications that may not care about the specific file type, but now would have to check the filetype before making a policy on them (also opening them to TOCTOU).
> > 
> > I agree.
> 
> I also agree with your interpretation, Justin.
> 
> For the record, Landlock's kernel implementation currently groups FS
> access rights into two groups:
> 
>  - file access rights
>  - directory-only rights
> 
> When adding a rule, the directory access rights can only be granted on
> a directory inode.  The file access rights can be granted on both a
> directory inode and a regular file inode.
> 
> It is pointless to grant the CONNECT_UNIX (or IOCTL_DEV) right on a
> file which is not a Unix socket (or device file).  But it complicates
> the userspace API if we introduce more special rules there. - Users of
> Landlock would have to keep track of all these special cases and
> mirror the logic, which is error prone.  IMHO is is granular enough if
> we differentiate between files and directories as we currently do.

Agreed. We discussed about making it more granular (see the IOCTL patch
series), but it is not worth it.  Even the directory/file
differentiation is questionable, but I initially made this decision to
incentivise user space to know if they are dealing with directories or
files because access right inheritance should be carefully managed.
In most cases, when programs sandbox themselves, they should not need to
stat the file because they should already know if it's a file or a
directory; only sandboxers need too check the file type.

> 
> For reference, this is documented at
> https://docs.kernel.org/userspace-api/landlock.html#filesystem-flags
> and the logic is implemented in landlock_append_fs_rule() in fs.c.
> 
> (Actually, in the implementation, the IOCTL_DEV right is treated the
> same as one of the ACCESS_FILE rights - I should probably revise that
> documentation: That right does not *directly* apply to a directory
> inode, as directories are not device files.  It only inherits down in
> the file system hierarchy.  Looking back at earlier versions of the
> IOCTL_DEV patch set, it was different there.  I think I missed to keep
> the documentation in-line.)

Indeed
