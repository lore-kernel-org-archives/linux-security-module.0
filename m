Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A673913D2B2
	for <linux-security-module@vger.kernel.org>; Wed, 13 Nov 2024 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511125; cv=none; b=BkQNVV36oKZ9oN74HJjipnb8H4h0lHDIkhxYfJ2mzOv0+t693bxxs/h6QLJkS/a1z1AZKEcgTF7c/E98zamOb4bJOXpr+cwNwUwFh7KXCMwbcq8ZEztk8u+v8fpe1iNqspcNx/WH1WuzsZdxSIu/yQX8b2/HXYetIbJo5JV179I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511125; c=relaxed/simple;
	bh=mYlUJN1gBFD5HKODNMC7Blm9B6/ZeU8V3DHCo45FeaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CC9fpBsVvrfbtrcf5JHph8Fl+k7PkSSdbN+ZSXX7UdAKxSUTloPFchVqvseY1fJ3B5Ro0kXIPkkZiDh0fd0bhFBJOJQgS+iatmZe1YGYc2HkGSZtaF4V3AHcdNh7qCxrCHgGViPFN8zhCM+nNQ3V+XBh582/O3QC6wVIS5Ybxbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=H7pSYD1f; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="H7pSYD1f"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XpRkd6L5Pzwxp;
	Wed, 13 Nov 2024 16:18:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1731511113;
	bh=MLSSXV5vV/3ILf2Fs3lIEhU7AyFQKoGO0eFMitslUCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H7pSYD1fX2Z++3ImtIykQcrNY9c3kG7QvodKsh6W2qISLIxE5GiUo1CcNI9oldnxq
	 6zHiELOQAA1bhKhd+Cl5VSeE7btdtPdlZ+cTJx3hwz0BwIP7b9q0HLtvFRx7FNusyI
	 kWmzptE8/QZkKvvyjXWv/28U4S45DVjJU4pA9Dmw=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XpRkb6yJPzgd3;
	Wed, 13 Nov 2024 16:18:31 +0100 (CET)
Date: Wed, 13 Nov 2024 16:18:31 +0100
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
Subject: Re: [RFC PATCH v2 04/14] landlock: Add unique ID generator
Message-ID: <20241113.oQue0Ohj3aef@digikod.net>
References: <20241022161009.982584-1-mic@digikod.net>
 <20241022161009.982584-5-mic@digikod.net>
 <1962333.tdWV9SEqCh@pwmachine>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1962333.tdWV9SEqCh@pwmachine>
X-Infomaniak-Routing: alpha

On Fri, Oct 25, 2024 at 05:18:06PM +0200, Francis Laniel wrote:
> Hi!
> 
> Le mardi 22 octobre 2024, 18:09:59 CEST Mickaël Salaün a écrit :
> > Landlock IDs can be generated to uniquely identify Landlock objects.
> > For now, only Landlock domains get an ID at creation time.
> > 
> > These IDs have important properties:
> > * They are unique during the lifetime of the running system thanks to
> >   the 64-bit values: at worse, 2^60 - 2*2^32 useful IDs.
> > * They are always greater than 2^32 and must then be stored in 64-bit
> >   integer types.
> > * The initial ID (at boot time) is randomly picked between 2^32 and
> >   2^33, which limits collisions in logs between different boots.
> > * IDs are sequential, which enables users to order them.
> > * IDs may not be consecutive but increase with a random 2^4 step, which
> >   limits side channels.
> > 
> > Such IDs can be exposed to unprivileged processes, even if it is not the
> > case with this audit patch series.  The domain IDs will be useful for
> > user space to identify sandboxes and get their properties.
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20241022161009.982584-5-mic@digikod.net
> > ---

> > diff --git a/security/landlock/id.h b/security/landlock/id.h
> > new file mode 100644
> > index 000000000000..689ba7607472
> > --- /dev/null
> > +++ b/security/landlock/id.h
> > @@ -0,0 +1,25 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Landlock LSM - Unique identification number generator
> > + *
> > + * Copyright © 2024 Microsoft Corporation
> > + */
> > +
> > +#ifndef _SECURITY_LANDLOCK_ID_H
> > +#define _SECURITY_LANDLOCK_ID_H
> > +
> > +#ifdef CONFIG_AUDIT
> > +
> > +void __init landlock_init_id(void);
> > +
> > +u64 landlock_get_id(size_t number_of_ids);
> > +
> > +#else /* CONFIG_AUDIT */
> > +
> > +static inline void __init landlock_init_id(void)
> > +{
> > +}
> 
> Should the function have the same signature than when CONFIG_AUDIT is set?

The API is the same, only the static inline changes, which is what we
need to do in a header file.
