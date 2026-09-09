Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D0B39CD13
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 18:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788978917; cv=none; b=K9UbrN3v7pC69BRl8G46l1Ur/Os8x4Qlcd4dFyKSedb+YGBvKUdxdVAfvPsg5Crho/T0Ai8Cz9ZPrkoOhGFUcFAm9X5A1/2rnePWrm3LmZmieSR+vgXnYAVTYw3kNUKjZC6Fem8XEE9khxSVpiwQb52qxbL0LDmdaOiVWOKk+PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788978917; c=relaxed/simple;
	bh=AC4lBqGuD4zcf/6Z/HUBafA2incti3y8Lkd1zHpZjns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uECznXdtqgRnf1uMvvR5raeaPCHfzA5faWWPTDcrRLT2L9HaOJ2SS840HvHTUC9QliJiWLg0k58TyiK6NKGIIhPgGqDAHyp0KC3fiZ6v5XM75LGQohUKBWvNnpfZn3jHQoHRwFMWQZD3mmj6h5tkW2F8E8vDmyt2lMIWISF7R44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=HUIOhqI9; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="HUIOhqI9"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hg8cV5DxQzx9j;
	Wed,  9 Sep 2026 20:35:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1788978906;
	bh=039DE0Nj6zfdqHjgOxtMBb1+k4HmJRZc5h2UMeymOjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HUIOhqI9V1nC2Wg+pzSs1XnGXHH9Iit5VUcr+5eRi0gn03VrArdNNuxZ6ILDs+gKJ
	 eReVIOMYr4Hc7YSYrGq6c9JBScQcUD+XArk77TD+deWOnCWkJ7jfYE5GsFnGl4zeYy
	 t7ieIU3UmcpX8TJJFC99LV48IOZpuvRFSLTFl0Gc=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hg8cS5C1PznPJ;
	Wed,  9 Sep 2026 20:35:04 +0200 (CEST)
Date: Wed, 9 Sep 2026 20:35:00 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Daniel Durning <danieldurning.work@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Justin Suess <utilityemal77@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 3/12] security: Add LSM_AUDIT_DATA_NS for namespace
 audit records
Message-ID: <20260909.quahcia8aiF4@digikod.net>
References: <20260726161400.3010511-4-mic@digikod.net>
 <5cabf9b33a20f130cedcc423b8b2d151@paul-moore.com>
 <CAHC9VhS_WP-bLgMGiFAfE1MT76iKvVJ-OV5r7xju-KMdrfjssQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhS_WP-bLgMGiFAfE1MT76iKvVJ-OV5r7xju-KMdrfjssQ@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Aug 31, 2026 at 05:26:20PM -0400, Paul Moore wrote:
> On Tue, Aug 11, 2026 at 4:16 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Jul 26, 2026 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> > >
> > > Add a new LSM audit data type LSM_AUDIT_DATA_NS that logs namespace
> > > information in audit records.  Two fields are provided:
> > >
> > > - ns_type: the CLONE_NEW* flag identifying the namespace type, logged
> > >   in hexadecimal.
> > >
> > > - ns_id: the unique 64-bit namespace identifier, retrievable from
> > >   userspace via NS_GET_ID or listns(2).  Unlike the proc inode number
> > >   (inum), ns_id is never recycled.  For namespace creation denials,
> > >   ns_id is 0 because the namespace does not exist yet.
> >
> > Based on the code in this patch, "ns_type" should be "namespace_type"
> > and a similar change needs to be done for "ns_id".  Regardless, the
> > first three patches look fine to me (I can fixup the above during a
> > merge).
> >
> > As mentioned previously, I want to merge at least the first three
> > patches via the LSM tree since we have multiple LSMs which depend on
> > these new hooks.  I'm happy to also merge the remaining Landlock
> > patches in this patchset via the LSM tree, or you can manage those
> > separately; let me know how you would like to proceed with that.
> >
> > Since we are at -rc7, this is obviously something for after the
> > upcoming merge window so I'm going to merge the first three patches
> > into the lsm/dev-staging branch now with the understanding that they
> > will move over to the lsm/dev branch after the upcoming merge window
> > is finished.  If you want me to merge the Landlock patches too, just
> > let me know.
> 
> The first three patches are now in lsm/dev, thanks everyone.

Thanks.

> 
> Mickaël, if you would like me to merge the remaining patches in this
> patchset into the lsm/dev branch just let me know.

I'll send a new patch series soon because this v3 would not apply
anymore.  I'll include your lsm/dev patches to keep a consistent patch
series.
