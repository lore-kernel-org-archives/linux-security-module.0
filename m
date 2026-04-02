Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE2C345CAE
	for <linux-security-module@vger.kernel.org>; Thu,  2 Apr 2026 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153805; cv=none; b=sOCr7Dun8wm3rgweosCj0WalfyJtvvMoyPXYlYvlH6d1Z/9v5LqhNiCAxa7HSNSjwIOkUMmwb/CqntBmZqVtgyna0MOQ1aXbZXUSKG9BRCXfucEIVXUUaA31yQfk+WbwAMw7bpvwValBhc+zUWaDAbx/wAbbn8XvUYL47Nn+z2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153805; c=relaxed/simple;
	bh=kGo/eR/FoLjcjcIRsiLmdZBauFsMKM+7QbWkRTHBpbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U79fXvHwey2TBzrF4QlUbxGueLtvaVLqSynsbZ2cwIlCwSB6GfLx0dx/Vt8nd0HydIPnof3X69hXSsPQBuX5cxhMRtGaOcZKXsVyOXODs37KzJcVmBWqFjzhAh17VCgdE7aM8MMDaCVp9dG9QHvA1k1p7uBb0D7C5M9q1Uq/j18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Y/M4vZGC; arc=none smtp.client-ip=83.166.143.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Y/M4vZGC"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fmqmx06JTzn7m;
	Thu,  2 Apr 2026 20:16:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775153792;
	bh=vFFDB2NEPMtx43+S5SG+6JHs4TLWeUnQymgx+zKf2bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y/M4vZGC8MintZ9bvBQj2pT28TI1HL0eVMB0tXwQFdFUSKqsk7kzXep2AoAGxladh
	 /kPL+144CcVd0onOvdIh5jhyxOFGUXvtyRes4eeOMlnkK1sVAAf+BENbVaUk7R4YOh
	 Ut/YaisyNeT9mJwKMDw0+fOdMQl4dYfMibZrmC3A=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fmqmw4Dkzzx3P;
	Thu,  2 Apr 2026 20:16:32 +0200 (CEST)
Date: Thu, 2 Apr 2026 20:16:27 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org
Subject: Re: [PATCH] landlock: Document fallocate(2) as another truncation
 corner case
Message-ID: <20260402.rai0Iegh2ohy@digikod.net>
References: <20260401150911.1038072-1-gnoack@google.com>
 <20260401.oor1chahp2oF@digikod.net>
 <ac1SP3cGuEeIZFmM@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac1SP3cGuEeIZFmM@google.com>
X-Infomaniak-Routing: alpha

On Wed, Apr 01, 2026 at 07:13:35PM +0200, Günther Noack wrote:
> On Wed, Apr 01, 2026 at 06:30:28PM +0200, Mickaël Salaün wrote:
> > On Wed, Apr 01, 2026 at 05:09:10PM +0200, Günther Noack wrote:
> > > Reinforce the already stated policy that LANDLOCK_ACCESS_FS_TRUNCATE should
> > > always go hand in hand with LANDLOCK_ACCESS_FS_WRITE_FILE, as their
> > > meanings and enforcement overlap in counterintuitive ways.
> > > 
> > > On many common file systems, fallocate(2) offers a way to shorten files as
> > > long as the file is opened for writing, side-stepping the
> > > LANDLOCK_ACCESS_FS_TRUNCATE right.
> > > 
> > > Assisted-by: Gemini-CLI:gemini-3.1
> > > Signed-off-by: Günther Noack <gnoack@google.com>
> > > ---
> > >  Documentation/userspace-api/landlock.rst | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> > > index 7f86d7a37dc2..d5691ec136cc 100644
> > > --- a/Documentation/userspace-api/landlock.rst
> > > +++ b/Documentation/userspace-api/landlock.rst
> > > @@ -378,8 +378,8 @@ Truncating files
> > >  
> > >  The operations covered by ``LANDLOCK_ACCESS_FS_WRITE_FILE`` and
> > >  ``LANDLOCK_ACCESS_FS_TRUNCATE`` both change the contents of a file and sometimes
> > > -overlap in non-intuitive ways.  It is recommended to always specify both of
> > > -these together.
> > > +overlap in non-intuitive ways.  It is strongly recommended to always specify
> > > +both of these together (either granting both, or granting none).
> > >  
> > >  A particularly surprising example is :manpage:`creat(2)`.  The name suggests
> > >  that this system call requires the rights to create and write files.  However,
> > > @@ -391,6 +391,10 @@ It should also be noted that truncating files does not require the
> > >  system call, this can also be done through :manpage:`open(2)` with the flags
> > >  ``O_RDONLY | O_TRUNC``.
> > >  
> > > +At the same time, on some filesystems, :manpage:`fallocate(2)` offers a way to
> > > +shorten file contents with ``FALLOC_FL_COLLAPSE_RANGE`` when the file is opened
> > > +for writing, sidestepping the ``LANDLOCK_ACCESS_FS_TRUNCATE`` right.
> > 
> > Interesting, which filesystems?  Shouldn't it be fixed in the code
> > instead?
> 
> It works on ext4, and I also see mentions of FALLOC_FL_COLLAPSE_RANGE
> in XFS, F2FS, SMB and NTFS3.
> 
> I should mention, it is not *exactly* the same as a truncation, but
> you can remove a chunk of the file from the middle, which also leads
> to a shorter file.  For example, assuming a block size of 1024:
> 
>   1. Make a file with 2*1024 bytes: 1024*'A', then 1024*'B'
>   2. fallocate(collapse range, 0, 1024)
> 
> Resulting file is 1024*'B', and the file is shortened to 1024 bytes.
> 
> So this is not *exactly* a truncation.  (The man page says that an
> attempt to remove the end of a file results in EINVAL, so you have to
> take it from the middle, and it needs to align with block boundaries.)
> 
> But it's quite similar, also shortens the file, and it does not
> require the Landlock truncation access right.
> 
> I agree, another way would potentially be to call the LSM ftruncate
> hook.  I suspect this would stay compatible with other LSMs, because
> the LSM ftruncate hook is a relatively recent addition (but have not
> checked in detail).
> 
> The implementation of fallocate is vfs_fallocate() in fs/open.c - I
> only had a tentative look now; it checks that the file->f_mode is open
> for writing and calls security_file_permission() with MAY_WRITE.
> 
> I always saw LANDLOCK_ACCESS_FS_WRITE_FILE and
> LANDLOCK_ACCESS_FS_TRUNCATE as rights that should always go together,
> so I suspect that it does not make a big difference in practice, and
> that is why I am suggesting to just document it more clearly for now.

OK, I agree, I'll take this patch. Thanks!

> 
> —Günther
> 
