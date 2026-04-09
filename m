Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6073A3CE48C
	for <linux-security-module@vger.kernel.org>; Thu,  9 Apr 2026 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775738841; cv=none; b=DiHg+py+XKTqc18hx/Pi8q7SGNI5TZ8MsCRvLmycXW1t8GwYk4cS5YxxUlSxetz5hDnhoRl5bDftLnlvxB9Q0/kh0nv6dMOtsNY/NJbEVqwpqsou16YOz4efZ8C1VLjHpS7JmCCilgoB5zajTC4aS9UFisFHiYEURQCBYFJFQ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775738841; c=relaxed/simple;
	bh=JzLual4b8vOgSlvSLdY4sHt5oZXZB627tGbFNb96fEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tl1QE88j0oI6cm6Xf5kcAMKEIuN4/SgDbWjuBidLEpnIb324kR9BNYXfZLicUGE46dCsBhOT7AmQzxkYpdzuR8Lzu47SMgOV6+oW+BZQfM8n72qYskAx2B0cuULcIu4AkjkmSBS/XtoCFN5E4uDWXGIuvVxitP5oSnkukRrJPbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0cZ3OI9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0cZ3OI9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDE0C4CEF7;
	Thu,  9 Apr 2026 12:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775738841;
	bh=JzLual4b8vOgSlvSLdY4sHt5oZXZB627tGbFNb96fEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0cZ3OI9HbY6ImT5L3OQpOrKo1HEBl3RLnL/wX+Bu/qXagLRqetbf50rzpE1DIvTv
	 MNMRmyxelY3T0grlk01a72w0/igksp5NrfMOg8hqTbUi3TQadGYvqUCXYgei4HEtjH
	 usMkBtVLioBBAetbKFv4HFOj+2ZkAWE5eyiOzXv+X34ake6n7CHsD3yxUGU80Q7cWH
	 NQjhQkmvzTYM1zoDd2PxRU1EFRv8NT02HYCuf3IJmOw7H1szi4yIkGz/KYD1yp7Qvr
	 Jk4wvlyQMG2UYho55uZc6hqLL64F4DJb1/U56xEpBFrnNLFByaYj+bLL/Py/4Wg0Yg
	 avMmqt86jxP6A==
Date: Thu, 9 Apr 2026 14:47:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Serge Hallyn <serge@hallyn.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, Paul Moore <paul@paul-moore.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: LSM: Whiteout chardev creation sidesteps mknod hook
Message-ID: <20260409-entbrennen-turnschuh-54af9b45610e@brauner>
References: <adUBCQXrt7kmgqJT@google.com>
 <06337e89-349a-4334-a735-b8dc9b566cdd@hallyn.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06337e89-349a-4334-a735-b8dc9b566cdd@hallyn.com>

On Tue, Apr 07, 2026 at 12:15:00PM -0500, Serge Hallyn wrote:
> Apr 7, 2026 08:05:43 Günther Noack <gnoack@google.com>:
> 
> > Hello Christian, Paul, Mickaël and LSM maintainers!
> >
> > I discovered the following bug in Landlock, which potentially also
> > affects other LSMs:
> >
> > With renameat2(2)'s RENAME_WHITEOUT flag, it is possible to create a
> > "whiteout object" at the source of the rename.  Whiteout objects are
> > character devices with major/minor (0, 0) -- these devices are not
> > bound to any driver, so they are harmless, but still, the creation of
> > these files can sidestep the LANDLOCK_ACCESS_FS_MAKE_CHAR access right
> > in Landlock.

They aren't devices.

> >
> >
> > I am unconvinced which is the right fix here -- do you have an opinion
> > on this from the VFS/LSM side?
> >
> >
> > Option 1: Make filesystems call security_path_mknod() during RENAME_WHITEOUT?

No.

> >
> > Do it in the VFS rename hook.
> >
> > * Pro: Fixes it for all LSMs
> > * Con: Call would have to be done in multiple filesystems
> >
> >
> > Option 2: Handle it in security_{path,inode}_rename()
> >
> > Make Landlock handle it in security_inode_rename() by looking for the
> > RENAME_WHITEOUT flag.
> >
> > * Con: Operation should only be denied if the file system even
> >   implements RENAME_WHITEOUT, and we would have to maintain a list of

Why? Just deny RENAME_WHITEOUT. What does it matter if the filesystem
implements it or not. Overlayfs would fall back to non-RENAME_WHITEOUT
if not provided by the upper fs anway.

> >   affected filesystems for that.  (That feels like solving it at the
> >   wrong layer of abstraction.)
> > * Con: Unclear whether other LSMs need a similar fix
> >
> >
> > Option 3: Declare that this is working as intended?
> 
> Option 3 has my vote.

Seconded.

> 
> 
> > * Pro: (0, 0) is not a "real" character device
> >
> >
> > In cases 1 and 2, we'd likely need to double check that we are not
> > breaking existing scenarios involving OverlayFS, by suddenly requiring
> > a more lax policy for creating character devices on these directories.
> >
> > Please let me know what you think.  I'm specifically interested in:
> >
> > 1. Christian: What is the appropriate way to do this VFS wise?
> > 2. LSM maintainers: Is this a bug that affects other LSMs as well?
> >
> > Thanks,
> > —Günther
> >
> > P.S.: For full transparency, I found this bug by pointing Google
> > Gemini at the Landlock codebase.

Clearly.
