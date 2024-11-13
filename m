Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58AC1F77A2
	for <linux-security-module@vger.kernel.org>; Wed, 13 Nov 2024 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511140; cv=none; b=cS38iCuNnjUp5cEx7s9u+IYupNUy01DrMZSFSQZ10zul/NHdTbHdWk4COtikPbSoHMwtAG71d7WvD7JwbR/hIzuVQnIPZ8C26nFxwCPeqEX9eQS4WU7gFn/9uboWFoAFvKPUG+LV7gL/FUpo2ruLqXmJUndLYdM4N0ZbsDizjBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511140; c=relaxed/simple;
	bh=xeu7KCgEYJ8XXi6Gz4AFPepJZaQ6qzZE0POmdVGrdrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vlh+GIv+birmLWARalxpyEM4B64vCL6qRpli12EQneD6l6qijZ0fj4PfvAvoMRLvjR7j0mWimR5Cm9GEld+OCoEV8O1XercG3vx/xRhLlulkwS0B8QgO90Lx3arhTpCGhilzqyPhJ/kQ4nxkkwVvTysuIcf+ZmfL/2OytpFAlfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=w8+E0Fwv; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="w8+E0Fwv"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XpRkx007fzxv6;
	Wed, 13 Nov 2024 16:18:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1731511128;
	bh=UgS4yOSHpEojR85PAvnZsXzTbMFsrzYqEYNGNDWWtKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w8+E0Fwv70BvCtcnLF+fvDdp/B7rn+qXywV8zqZpmp9jwWMbAWEyv9ZZm72XvPtJj
	 CW9F2NFNEXWe0rkh5B5ilqtbzPMq33qd64/a8zLI84mQtUksRtL/8sPBv6LZg+unzL
	 0B+dh/8/jEmsIN5ws7yvlKIVbrXw/UBGZAgStqaM=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XpRkw1Ds8zJgT;
	Wed, 13 Nov 2024 16:18:48 +0100 (CET)
Date: Wed, 13 Nov 2024 16:18:47 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Francis Laniel <flaniel@linux.microsoft.com>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Charles Zaffery <czaffery@roblox.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, 
	Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v2 05/14] landlock: Move access types
Message-ID: <20241113.he5shei2aiHo@digikod.net>
References: <20241022161009.982584-1-mic@digikod.net>
 <20241022161009.982584-6-mic@digikod.net>
 <3020507.e9J7NaK4W3@pwmachine>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3020507.e9J7NaK4W3@pwmachine>
X-Infomaniak-Routing: alpha

On Fri, Oct 25, 2024 at 05:20:39PM +0200, Francis Laniel wrote:
> Le mardi 22 octobre 2024, 18:10:00 CEST Mickaël Salaün a écrit :
> > Move ACCESS_FS_OPTIONAL, access_mask_t, struct access_mask, and struct
> > access_masks_all to a dedicated access.h file.
> > 
> > This file will be extended with a following commit, and it will help to
> > avoid dependency loops.
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20241022161009.982584-6-mic@digikod.net
> > ---
> > 
> > Changes since v1:
> > * New patch
> > ---
> >  security/landlock/access.h  | 53 +++++++++++++++++++++++++++++++++++++
> >  security/landlock/fs.c      |  1 +
> >  security/landlock/fs.h      |  1 +
> >  security/landlock/ruleset.h | 31 +---------------------
> >  4 files changed, 56 insertions(+), 30 deletions(-)
> >  create mode 100644 security/landlock/access.h
> > 
> > diff --git a/security/landlock/access.h b/security/landlock/access.h
> > new file mode 100644
> > index 000000000000..2659fd9b4aaf
> > --- /dev/null
> > +++ b/security/landlock/access.h
> > @@ -0,0 +1,53 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Landlock LSM - Access types and helpers
> > + *
> > + * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
> > + * Copyright © 2018-2020 ANSSI
> > + * Copyright © 2024 Microsoft Corporation
> > + */
> > +
> > +#ifndef _SECURITY_LANDLOCK_ACCESS_H
> > +#define _SECURITY_LANDLOCK_ACCESS_H
> > +
> > +#include <uapi/linux/landlock.h>
> > +
> > +#include "limits.h"
> > +
> > +/* clang-format off */
> > +#define ACCESS_FS_OPTIONAL ( \
> > +	LANDLOCK_ACCESS_FS_TRUNCATE | \
> > +	LANDLOCK_ACCESS_FS_IOCTL_DEV)
> 
> Nit: The patch message indicates this is moved from somewhere but I cannot find 
> deletion for it.

Correct, I'll move this define to the following patch introducing
deny_masks_t.
