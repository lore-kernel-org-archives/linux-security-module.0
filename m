Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E14212A14A
	for <linux-security-module@vger.kernel.org>; Thu, 28 Mar 2024 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644243; cv=none; b=tx/lPpRabkGTm5ThBOBA8/QeYpL3ZAUP0MZ6kA3Kz6bjTqZhpZwZoIybtSxRNcKdyL61yKVRtTG7q3u2Od9jxQ/Ar3MzB4EoF2FfWsLjZUUmwSiA6pwlc+nHgM0TCS5LCTQqPr7doZKDzDiCnllUV0+Ae14cv92XUfs6k+jovU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644243; c=relaxed/simple;
	bh=+bSrKAtDF5uJe/MOUQh6w++8XZ49Zs92jJVUIiROUZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l77k0haIQ4N8fCkFsqZA3jRH91LIMX3MUjmTBH+zID5JkyLbU8TXsJvwRT1yisVENeAtK89q1NOE/eKGZaisKte7ZnGNOKa8nQpCEA4xJ8Km719FdA3CzmwRMSEtZ0/navwg156mcbFEwKDuu3TLFgnNDD5uI2gdJ9xMKrs3vWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=DXOp6IKO; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="DXOp6IKO"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V58WB1Cs4zY8m;
	Thu, 28 Mar 2024 17:43:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1711644230;
	bh=+bSrKAtDF5uJe/MOUQh6w++8XZ49Zs92jJVUIiROUZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DXOp6IKO55i6BlFAuMxhPG/l0JvRNaGEgg0nV1UX+hFYw+Xy3yL58Pps5MyuS9PRf
	 9YqFZhuu9iIisMmS2TGxsOZOkcu8z1JihsOCZBH9Pe9DEkLg6iGTTCcLOx1UA8fisE
	 iDxv2hytl/l2wyx2AufkXulw49xs5We8HMNXp/RU=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4V58W9410hzsB;
	Thu, 28 Mar 2024 17:43:49 +0100 (CET)
Date: Thu, 28 Mar 2024 17:43:49 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 10/10] fs/ioctl: Add a comment to keep the logic in
 sync with the Landlock LSM
Message-ID: <20240328.mahn4seChaej@digikod.net>
References: <20240327131040.158777-1-gnoack@google.com>
 <20240327131040.158777-11-gnoack@google.com>
 <20240328.ahgh8EiLahpa@digikod.net>
 <CAHC9VhT0SjH19ToK7=5d5hdkP-ChTpEEaeHbM0=K8ni_ECGQcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhT0SjH19ToK7=5d5hdkP-ChTpEEaeHbM0=K8ni_ECGQcw@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Thu, Mar 28, 2024 at 09:08:13AM -0400, Paul Moore wrote:
> On Thu, Mar 28, 2024 at 8:11 AM Mickaël Salaün <mic@digikod.net> wrote:
> > On Wed, Mar 27, 2024 at 01:10:40PM +0000, Günther Noack wrote:
> > > Landlock's IOCTL support needs to partially replicate the list of
> > > IOCTLs from do_vfs_ioctl().  The list of commands implemented in
> > > do_vfs_ioctl() should be kept in sync with Landlock's IOCTL policies.
> > >
> > > Signed-off-by: Günther Noack <gnoack@google.com>
> > > ---
> > >  fs/ioctl.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > > index 1d5abfdf0f22..661b46125669 100644
> > > --- a/fs/ioctl.c
> > > +++ b/fs/ioctl.c
> > > @@ -796,6 +796,9 @@ static int ioctl_get_fs_sysfs_path(struct file *file, void __user *argp)
> > >   *
> > >   * When you add any new common ioctls to the switches above and below,
> > >   * please ensure they have compatible arguments in compat mode.
> > > + *
> > > + * The commands which are implemented here should be kept in sync with the IOCTL
> > > + * security policies in the Landlock LSM.
> >
> > Suggestion:
> > "with the Landlock IOCTL security policy defined in security/landlock/fs.c"
> 
> We really shouldn't have any comments or code outside of the security/
> directory that reference a specific LSM implementation.  I'm sure
> there are probably a few old comments referring to SELinux, but those
> are bugs as far as I'm concerned (if anyone spots one, please let me
> know or send me a patch!).
> 
> How about the following?
> 
> "The LSM list should also be notified of any command additions or

"The LSM mailing list..."

> changes as specific LSMs may be affected."

Looks good.

> 
> -- 
> paul-moore.com
> 
