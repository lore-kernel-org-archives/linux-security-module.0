Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEE9537E7
	for <linux-security-module@vger.kernel.org>; Fri,  8 Mar 2024 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890200; cv=none; b=EXQ/0mG1umqIjT8v7P6+b6E+JQVt730Vafs4queYU0LJKX7il1FW/IwQ3kLf3rjv8+9799enVOQe7elNkLTVKVNLA98234ekRy8AH7obExjyO0s8Dok14mZKWX6rbtVwmySPCCttxA4/FlbnhhW+f2b4750bU3YO+uBSVMcQEvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890200; c=relaxed/simple;
	bh=tObvJKUJH+I4RUoxig7mBJqgzKbVo4h3bFZ/dheOGJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NptVzBJE7DE9u12Iz9Ht9QZyRq6Gv12t5gjsjg9u7ZNso8Xm90EJwWmjC3xYntkIYO0XR7QcPviikT7CQEUbH6i4DduhoSXgMQt3JjXDspsvqb0RpuiamjKJtQVPNcvZOkTpcMgnYyvSTFQeoVqCkMtsZs96xxlFKok7+hNa+y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=t3jtDloM; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="t3jtDloM"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Trgqc22NRzMq20Q;
	Fri,  8 Mar 2024 10:29:48 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Trgqb23PjzMpnPm;
	Fri,  8 Mar 2024 10:29:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709890188;
	bh=tObvJKUJH+I4RUoxig7mBJqgzKbVo4h3bFZ/dheOGJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t3jtDloMKagIlJF/+74LQUQm2CsGLaxXla0ySuHybSvJ82bgZJlAPiL98d1ktfeVP
	 MyHloHrjelp/4MbBV90s7GSnm5K6O55G4IQqSDwVMUOMshFcp1E77++uZa2LFM9xQE
	 T4+NIp4teRHRnARuRoNT0gMCW3QA82fL/4lM1cRE=
Date: Fri, 8 Mar 2024 10:29:36 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dave Chinner <david@fromorbit.com>, Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
Message-ID: <20240308.saiheoxai7eT@digikod.net>
References: <20240219183539.2926165-1-mic@digikod.net>
 <ZedgzRDQaki2B8nU@google.com>
 <20240306.zoochahX8xai@digikod.net>
 <263b4463-b520-40b5-b4d7-704e69b5f1b0@app.fastmail.com>
 <20240307-hinspiel-leselust-c505bc441fe5@brauner>
 <9e6088c2-3805-4063-b40a-bddb71853d6d@app.fastmail.com>
 <Zem5tnB7lL-xLjFP@google.com>
 <CAHC9VhT1thow+4fo0qbJoempGu8+nb6_26s16kvVSVVAOWdtsQ@mail.gmail.com>
 <ZepJDgvxVkhZ5xYq@dread.disaster.area>
 <32ad85d7-0e9e-45ad-a30b-45e1ce7110b0@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32ad85d7-0e9e-45ad-a30b-45e1ce7110b0@app.fastmail.com>
X-Infomaniak-Routing: alpha

On Fri, Mar 08, 2024 at 08:02:13AM +0100, Arnd Bergmann wrote:
> On Fri, Mar 8, 2024, at 00:09, Dave Chinner wrote:
> > On Thu, Mar 07, 2024 at 03:40:44PM -0500, Paul Moore wrote:
> >> On Thu, Mar 7, 2024 at 7:57 AM Günther Noack <gnoack@google.com> wrote:
> >> I need some more convincing as to why we need to introduce these new
> >> hooks, or even the vfs_masked_device_ioctl() classifier as originally
> >> proposed at the top of this thread.  I believe I understand why
> >> Landlock wants this, but I worry that we all might have different
> >> definitions of a "safe" ioctl list, and encoding a definition into the
> >> LSM hooks seems like a bad idea to me.
> >
> > I have no idea what a "safe" ioctl means here. Subsystems already
> > restrict ioctls that can do damage if misused to CAP_SYS_ADMIN, so
> > "safe" clearly means something different here.
> 
> That was my problem with the first version as well, but I think
> drawing the line between "implemented in fs/ioctl.c" and
> "implemented in a random device driver fops->unlock_ioctl()"
> seems like a more helpful definition.
> 
> This won't just protect from calling into drivers that are lacking
> a CAP_SYS_ADMIN check, but also from those that end up being
> harmful regardless of the ioctl command code passed into them
> because of stupid driver bugs.

Indeed.

"safe" is definitely not the right word, it is too broad, relative to
use cases and threat models.  There is no "safe" IOCTL.

Let's replace "safe IOCTL" with "IOCTL always allowed in a Landlock
sandbox".

Our assumptions are (in the context of Landlock):

1. There are IOCTLs tied to file types (e.g. block device with
   major/minor) that can easily be identified from user space (e.g. with
   the path name and file's metadata).  /dev/* files make sense for user
   space and they scope to a specific use case (with relative
   privileges).  This category of IOCTLs is implemented in standalone
   device drivers (for most of them).

2. Most user space processes should not be denied access to IOCTLs that
   are managed by the VFS layer or the underlying filesystem
   implementations.  For instance, the do_vfs_ioctl()'s ones (e.g.
   FIOCLEX, FIONREAD) should always be allowed because they may be
   required to legitimately use files, and for performance and security
   reasons (e.g. fs-crypt, fsverity implemented at the filesystem layer).
   Moreover, these IOCTLs should already check the read/write permission
   (on the related FD), which is not the case for most block/char device
   IOCTL.

3. IOCTLs to pipes and sockets are out of scope.  They should always be
   allowed for now because they don't directly expose files' data but
   IPCs instead, and we are focusing on FS access rights for now.

We want to add a new LANDLOCK_ACCESS_FS_IOCTL_DEV right that could match
on char/block device's specific IOCTLs, but it would not have any impact
on other IOCTLs which would then always be allowed (if the sandboxed
process is allowed to open the file).

Because IOCTLs are implemented in layers and all IOCTLs commands live in
the same 32-bit namespace, we need a way to identify the layer
implemented by block and character devices.  The new LSM hook proposal
enables us to cleanly and efficiently identify the char/block device
IOCTL layer with an additional check on the file type.
