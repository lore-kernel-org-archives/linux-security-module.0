Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D65814659D
	for <linux-security-module@vger.kernel.org>; Sat,  1 Feb 2025 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738405724; cv=none; b=bcptG8Xun+Tra+uQzPCJ15OTQRNpxNBAA36+Atuj7eCHbGAoYTbjYYlgf93S8K8Umw4fsMwtXJ7Oa64wML77HBeZ322XNcCGW+EcwTjaz0+hH80xwf4OFaY5ykwmHBuEOt6y8bXSNyIX2gZ5h5AY6sa58kyr2s0x9wLCNKviSUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738405724; c=relaxed/simple;
	bh=J1ifWIaykQ9jC7m+oybw8a6NDp1KR2w9PhpIWhP61VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SehcXp/uj3Mpg/1xYoMGS3ExgR375AvWG5vA5NgvAiZMOgQY7s83AfAc9j/7WmPmJY7nF/l5Xt3JiN81sw0G0Hc1dnFi+WKxT43JOZpkZoBUzJK2+4dp0lWhdXNEhOVQqVTqj5QBayJFaojOXZS4QpYJmVdRCe8LQ2HXhGb+diE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1t72USoB; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1t72USoB"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YlTW91NxzzW6L;
	Sat,  1 Feb 2025 11:28:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1738405717;
	bh=iqJ2oClAM+gYcuSNYA8A87BSAID+U0YtomCWA9x9Zvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1t72USoBVp26UEn8RYGT/IfO1Zc6o27OHh9AEBL+AH8wW8t3yG5OMYwhiEt7slkwE
	 xjzEHk5pGPAE+Dv/E5mxPKvrM2gOGm3VOx0xwd4P1WAM36XBTmmxSAP2LhbCnml1Yy
	 neO+1u9P9YbEs/x/HDeZcRzInUY4GNUgtcMAoL7w=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YlTW71g9Kz6gg;
	Sat,  1 Feb 2025 11:28:35 +0100 (CET)
Date: Sat, 1 Feb 2025 11:28:28 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Charles Zaffery <czaffery@roblox.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, Francis Laniel <flaniel@linux.microsoft.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Kees Cook <kees@kernel.org>, Luca Boccassi <luca.boccassi@gmail.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Praveen K Paladugu <prapal@linux.microsoft.com>, 
	Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, 
	Tyler Hicks <code@tyhicks.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/3] pidfd: Extend PIDFD_GET_INFO with
 PIDFD_INFO_LANDLOCK_*_DOMAIN
Message-ID: <20250201.quaizoh3taeV@digikod.net>
References: <20250131163447.1140564-1-mic@digikod.net>
 <20250131163447.1140564-3-mic@digikod.net>
 <CAHC9VhS=mMH9s2KUc2kSK7pW1yG8RB58hyJjW5oWsCK=i-1PdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhS=mMH9s2KUc2kSK7pW1yG8RB58hyJjW5oWsCK=i-1PdA@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Jan 31, 2025 at 02:02:49PM -0500, Paul Moore wrote:
> On Fri, Jan 31, 2025 at 11:43 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > Because Landlock enables users to create nested sandboxes (i.e.
> > domains), we might need to identify the domain with all restrictions
> > (latest), or the domain we created (i.e. closest domain).  Indeed,
> > because any process can create its own domain, the latest domain may not
> > be known by the requester.
> >
> > The PIDFD_INFO_LANDLOCK_LAST_DOMAIN flag enables user space to get the
> > latest (i.e. most nested) Landlock domain ID related to a sandboxed
> > task, if any.  The domain ID is set in the pidfd_info's
> > landlock_last_domain field according to the related mask.
> >
> > The PIDFD_INFO_LANDLOCK_FIRST_DOMAIN flag enables user space to get the
> > closest (i.e. first hierarchy relative to the pidfd's credentials)
> > Landlock domain ID related to a sandboxed task, if any.  The domain ID
> > is set in the pidfd_info's landlock_first_domain field according to the
> > related mask.
> >
> > It is only allowed to get information about a Landlock domain if the
> > task's domain that created the pidfd is a parent of the PID's domain.
> > Following the object-capability model, the pidfd's credentials are used
> > instead of the caller's credentials.  This makes this command
> > idenmpotent wrt the referenced process's state.
> >
> > If Landlock is not supported or if access to this information is denied,
> > then the IOCTL does not set the PIDFD_INFO_LANDLOCK_*_DOMAIN flag in the
> > returned mask.
> >
> > If PIDFD_INFO_LANDLOCK_LAST_DOMAIN or PIDFD_INFO_LANDLOCK_FIRST_DOMAIN
> > is specified but the provided struct pidfd_info is not large enough to
> > contain the related field, then -EINVAL is returned.
> >
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Luca Boccassi <luca.boccassi@gmail.com>
> > Cc: Praveen K Paladugu <prapal@linux.microsoft.com>
> > Closes: https://github.com/landlock-lsm/linux/issues/26
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20250131163447.1140564-3-mic@digikod.net
> > ---
> >  fs/pidfs.c                 | 24 ++++++++++++++++++++++--
> >  include/uapi/linux/pidfd.h |  4 ++++
> >  2 files changed, 26 insertions(+), 2 deletions(-)
> 
> While there are exceptions, mostly for legacy things, we try very hard
> to avoid having the kernel call directly into a specific LSM,
> preferring to use LSM interfaces, both so that all LSMs can benefit
> from the change and also so that we can avoid having a lot of very
> similar, but LSM-specific, calls in various parts in the kernel.

Making life easier for LSMs by sharing common code is a good thing, but
making life easier for all kernel components by sharing common code is
even better.  The PIDFD_GET_INFO IOCTL was design to be very flexible,
and it follows the principle of "pay for what you request" thanks to the
"mask" bitfield.

Users specify a set of properties they want, and the kernel returns
these properties if they are supported and allowed.  Each of this
property is well-specified and has a clear semantic.  This patch series
implements two Landlock properties, each clearly identified and
independent.

One important difference between the current LSMs attributes and these
two new Landlock properties, is that the Landlock domain IDs are u64
values instead of strings.  This makes the implementation quite forward
and it fits well with how PIDFD_GET_INFO currently works, so there is no
need for a new (PIDFD_GET_SECURITY) IOCTL handling complex data
structure composing a set of strings such as what is required for
current LSMs' attributes.

> 
> There is an effort, albeit a slowly moving effort due to interrupts,
> to add LSM support via a PIDFS_GET_SECURITY API:
> 
> https://lore.kernel.org/linux-security-module/CAHC9VhRV3KcNGRw6_c-97G6w=HKNuEQoUGrfKhsQdWywzDDnBQ@mail.gmail.com/

This effort is good, but it is a separate effort which is independent
from this patch series.  This will be useful for LSMs (or hopefully
other parts of the kernel as well) that deal with string-based
attributes.

Even with a common hook and data structure, any LSM need to implement
their own attribute management.  This patch series just makes a call to
the Landlock implementation the same way UID, cgroupid, and other
properties are retrieved.  There is no need for a wrapper interface for
simple data types that are already handled by PIDFD_GET_INFO.

Simple property types should all be queryable with the PIDFD_GET_INFO
IOCTL (compared to a dedicated LSM's PIDFD_GET_SECURITY IOCTL), which
can batch queries, making it more efficient and easier to implement for
user space.

> 
> I don't see any reason why we couldn't support Landlock's domain info
> as part of that, the lsm_ctx struct was created to support various
> different LSM contexts/attributes.  You could either add multiple
> lsm_ctx array entries for Landlock, one for each of the domain IDs, or
> you could place all of the domain IDs in an expanded lsm_ctx.
> Remember the lsm_ctx->ctx field can hold binary blobs and/or you can
> expand past the end of lsm_ctx->ctx so long as lsm_ctx->{len,ctx_len}
> are set accordingly.
> 
> If you want to work on the PIDFS_GET_SECURITY patch(set) as a means to
> add Landlock domain ID support, I think that would be great.  Luca
> provided a basic skeleton in the link above, and I expect you would
> have no issue adding the missing LSM bits.
> 
> -- 
> paul-moore.com
> 
