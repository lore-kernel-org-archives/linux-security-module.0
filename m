Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CB93803E3
	for <linux-security-module@vger.kernel.org>; Wed,  8 Apr 2026 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651073; cv=none; b=jPHtYwVVgyCBsAAKlViCLmqgfx27Fn+Vcvw9zAZNgrMV9JUwZ702Ujbme5qARlQNKwoDK7KzSc1462AoZMc6TMndssulp7vV5DiCVz4rxWyVkxLiTkYpNs1v7MsWfzyVXjQtnxGXdGjnMajiQMRT7WyFmMvQz022n2DD+mzN6E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651073; c=relaxed/simple;
	bh=jPn2+XUdBDU4PE9SQFsVLHuJ4Z/pk83Xi6yn+2VHq8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOWWc3v8pdl/GgBbh5wHurw3jln1ntK6JuVoo4G9K71arHZKjdIR9Yczbi6DSvp0EnQZwKklJTN8xkyglViLICgpga/2+CfDlzwG0JctTjsTE7z+MDewzC5lZ4IlPb2gxmZB4KyvEa1ZLnWFKTEzaQWwpo97D8Kurh+b2qV2bEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=tX0yHVyy; arc=none smtp.client-ip=84.16.66.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="tX0yHVyy"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4frMgq6jCYznbT;
	Wed,  8 Apr 2026 14:24:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775651063;
	bh=B1smvf+ybVXTtSJ2nuo3dWZp5RzBVc6OX7E5d64qHeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tX0yHVyybaVscrS/X/1DuTLcZ4ibs0LVnESKf2ATooWNhcBUDS1p/CPdk7zXV9aSR
	 cDX5Od5X+vzJeXLUjMS7aool5H4h1fPCxtagyHzh/H3ZTuHDY4eZg3pgDXm2eXmcDC
	 2altqDirckIxrpNmPN+cOichendSApR0zKjpTgNU=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4frMgn20gvzX2c;
	Wed,  8 Apr 2026 14:24:21 +0200 (CEST)
Date: Wed, 8 Apr 2026 14:24:17 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, Georgia Garcia <georgia.garcia@canonical.com>, 
	Kentaro Takeda <takedakn@nttdata.co.jp>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	linux-fsdevel@vger.kernel.org, Alejandro Colomar <alx@kernel.org>
Subject: Re: LSM: Whiteout chardev creation sidesteps mknod hook
Message-ID: <20260408.jae8Cohse9Pe@digikod.net>
References: <adUBCQXrt7kmgqJT@google.com>
 <20260408.beu1Eing5aFo@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408.beu1Eing5aFo@digikod.net>
X-Infomaniak-Routing: alpha

CCing fsdevel and Alejandro.

On Wed, Apr 08, 2026 at 01:01:31PM +0200, Mickaël Salaün wrote:
> On Tue, Apr 07, 2026 at 03:05:13PM +0200, Günther Noack wrote:
> > Hello Christian, Paul, Mickaël and LSM maintainers!
> > 
> > I discovered the following bug in Landlock, which potentially also
> > affects other LSMs:
> > 
> > With renameat2(2)'s RENAME_WHITEOUT flag, it is possible to create a
> > "whiteout object" at the source of the rename.  Whiteout objects are
> > character devices with major/minor (0, 0) -- these devices are not
> > bound to any driver, so they are harmless, but still, the creation of
> > these files can sidestep the LANDLOCK_ACCESS_FS_MAKE_CHAR access right
> > in Landlock.
> 
> Any way to "write" on the filesystem should properly be controlled.  The
> man page says that RENAME_WHITEOUT requires CAP_MKNOD, however, looking
> at vfs_mknod(), there is an explicit exception to not check CAP_MKNOD
> for whiteout devices. See commit a3c751a50fe6 ("vfs: allow unprivileged
> whiteout creation").
> 
> > 
> > 
> > I am unconvinced which is the right fix here -- do you have an opinion
> > on this from the VFS/LSM side?
> > 
> > 
> > Option 1: Make filesystems call security_path_mknod() during RENAME_WHITEOUT?
> 
> This is the right semantic.
> 
> > 
> > Do it in the VFS rename hook.
> > 
> > * Pro: Fixes it for all LSMs
> > * Con: Call would have to be done in multiple filesystems
> 
> That would not work.
> 
> > 
> > 
> > Option 2: Handle it in security_{path,inode}_rename()
> > 
> > Make Landlock handle it in security_inode_rename() by looking for the
> > RENAME_WHITEOUT flag.
> > 
> > * Con: Operation should only be denied if the file system even
> >   implements RENAME_WHITEOUT, and we would have to maintain a list of
> >   affected filesystems for that.  (That feels like solving it at the
> >   wrong layer of abstraction.)
> 
> Why would we need to maintain such list?  If it's only about the errno,
> well, that would not be perfect be ok with a proper doc.
> 
> I'm mostly worried that there might be other (future) call paths to
> create whiteout devices.
> 
> I think option 2 would be the most practical approach for Landlock, with
> a new LANDLOCK_ACCESS_FS_MAKE_WHITEOUT right.
> 
> I'm also wondering how are the chances that other kind of special file
> type like a whiteout device could come up in the future.  Any guess
> Christian?
> 
> > * Con: Unclear whether other LSMs need a similar fix
> 
> I guess at least AppArmor and Tomoyo would consider that an issue.
> 
> > 
> > 
> > Option 3: Declare that this is working as intended?
> 
> We need to be able to controle any file creation, which is not currently
> the case because of this whiteout exception.
> 
> > 
> > * Pro: (0, 0) is not a "real" character device
> > 
> > 
> > In cases 1 and 2, we'd likely need to double check that we are not
> > breaking existing scenarios involving OverlayFS, by suddenly requiring
> > a more lax policy for creating character devices on these directories.
> > 
> > Please let me know what you think.  I'm specifically interested in:
> > 
> > 1. Christian: What is the appropriate way to do this VFS wise?
> > 2. LSM maintainers: Is this a bug that affects other LSMs as well?
> > 
> > Thanks,
> > —Günther
> > 
> > P.S.: For full transparency, I found this bug by pointing Google
> > Gemini at the Landlock codebase.
> > 
