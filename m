Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9FE432BDE
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785510907; cv=none; b=ej08My56OufTQwlmtqGa2OdA8CpMNgQgEzKMJuD19I32m7pQNpMPxrQ9Ez5udAhgz1a9EL4zihvDvddoSYx0f0iQYdUkEu7uU+hPLcXh0jvBKeNZZrpZO98AOb98FbCeWhnK5SvDnsrXMQB/FW4D4JMMxQ6gDtL0UqAaNYII1pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785510907; c=relaxed/simple;
	bh=cQDd8tmu8lFUhnkOtc2dJEouEyPamrM8EIKlgzFZ7iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEldO2RJ0uYRvtJ/5JwT3yF55apgwO1uB2AsZMjHf3wNRLm53Ma5OVJohrZI+wyMprlhwh4fCqzGZRgfZUxW5sGQYkmoplJdkKAX9r4fDHmG0QtgaW2SeImA9fQe7IxEGLQXG4j+HNQB9aAGe9QCFcLNsKQ1/mbPjsziXk+UV6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Y7Qntfjf; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Y7Qntfjf"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hBV3z0NvfzFtS;
	Fri, 31 Jul 2026 17:14:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1785510894;
	bh=8kdeNKK2Kafw1Or6Z4qgrFEPXyBrP/D6q+bDb1ZS6K4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y7QntfjfH08ZCpoTiJZ8qkqrasVcUfnXQCaJcf3gmcGyQE7iAkd5eoIf5onl/EX/v
	 SLexExbofMaJ5N+HbrayQsOBnnlq3S3GkKfpu+IY3PyBAPPZ5Fp5BRJ2j/7FUQ6vTd
	 ThnD91CsNW4xeAp3xBdi/RmZAB17MZt5SjqYw0x8=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hBV3y0wXFzm2x;
	Fri, 31 Jul 2026 17:14:54 +0200 (CEST)
Date: Fri, 31 Jul 2026 17:14:49 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Serge Hallyn <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v4 2/5] landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for
 whiteout creation
Message-ID: <20260731.Eemae3quu2na@digikod.net>
References: <20260724161004.2360749-1-gnoack@google.com>
 <20260724161004.2360749-3-gnoack@google.com>
 <20260731.eiNi7aik6cah@digikod.net>
 <amyvWp25gjy_U5Hv@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amyvWp25gjy_U5Hv@google.com>
X-Infomaniak-Routing: alpha

On Fri, Jul 31, 2026 at 04:21:14PM +0200, Günther Noack wrote:
> On Fri, Jul 31, 2026 at 01:07:57PM +0200, Mickaël Salaün wrote:
> > On Fri, Jul 24, 2026 at 06:10:01PM +0200, Günther Noack wrote:
> > > +
> > > +/**
> > > + * DOC: erratum_4
> > > + *
> > > + * Erratum 4: Creation of whiteout objects
> > > + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > + *
> > > + * This fix addresses an issue through which it was possible to create whiteout
> > > + * objects, even when all file creation is restricted using Landlock.
> > > + *
> > > + * With this fix, the creation of whiteout objects is now guarded using
> > > + * ``LANDLOCK_ACCESS_FS_MAKE_REG``, both when it is done through
> > > + * :manpage:`renameat2(2)` with `RENAME_WHITEOUT`, and when it is done through
> > > + * :manpage:`mknod(2)` with ``S_IFCHR`` and ``makedev(0, 0)`` (which previously
> > > + * required ``LANDLOCK_ACCESS_FS_MAKE_CHAR``).
> > > + *
> > > + * Whiteout objects are special file types used in OverlayFS to mark the absence
> > > + * of a file in an upper file system, even when the lower (often read-only) file
> > > + * system does have a file with the same name.
> > > + *
> > > + * Impact:
> > > + *
> > > + * Without this fix, it was possible to create whiteout files from userspace
> > > + * using :manpage:`renameat2(2)` with the ``RENAME_WHITEOUT`` flag.
> > 
> > The errata should focus on the change of access rights which are needed
> > (and could potentially break some use cases), not to talk about the
> > RENAME_WHITEOUT (bypass) fix.  Most fixes don't get a Landlock errata
> > bit.  The impact should then be explicit that this is for sandboxed
> > programs such as fuse-overlayfs.
> > 
> > This patch does two things:
> > - fix the RENAME_WHITEOUT creating a whitout without being controlled
> >   (no errata, just a fix),
> > - and repurpose the MAKE_REG to control whitetout creation instead of
> >   relying on MAKE_CHAR (which needs an errata because it could break
> >   legitimate use cases/policies).
> 
> FYI, I'm thinking to change the phrasing to this:
> 
> /**
>  * DOC: erratum_4
>  *
>  * Erratum 4: Creation of whiteout objects
>  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  *
>  * This fix changes the access rights required for the creation of whiteout
>  * objects through :manpage:`mknod(2)` with ``S_IFCHR`` and ``makedev(0, 0)``.

Adding renameat2 + RENAME_WHITEOUT would be better too.

>  * This way of creating whiteout objects is now guarded by
>  * ``LANDLOCK_ACCESS_FS_MAKE_REG`` instead of ``LANDLOCK_ACCESS_FS_MAKE_CHAR``.
>  *
>  * Whiteout objects are used in OverlayFS to mark the absence of a file in an
>  * upper file system.  Despite being created with ``S_IFCHR``, whiteout objects
>  * do not count as character devices.
>  *
>  * Impact:
>  *
>  * Sandboxed programs that create OverlayFS whiteouts (such as fuse-overlayfs)
>  * now require ``LANDLOCK_ACCESS_FS_MAKE_REG`` instead of
>  * ``LANDLOCK_ACCESS_FS_MAKE_CHAR``.
>  */
> LANDLOCK_ERRATUM(4)
> 
> Please let me know whether that sounds better.

This looks good, thanks!
