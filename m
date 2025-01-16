Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B9D1DE2B8
	for <linux-security-module@vger.kernel.org>; Thu, 16 Jan 2025 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024561; cv=none; b=FzBNahkM6NCKNm1Y50iLaefVdwR/y0hAlgI1RbVDduu0yc3CwkpKeNst7Gd3Ak40uEjSYh76qXD13B3EXiTMgGhoofLzCkIvhlRftFipFdx/XOePuoUJeU4FEMbbcKGpnSFIB9hC3FB1JqqZkVLDjKNtmt6SYTG2yQj06zcK9B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024561; c=relaxed/simple;
	bh=wprOV6PY6Ne5vllMDDp4WhKeISLYIhraG6DPdW2oAjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsZgAnnAV+uEGKAtgP8LF0Cyfzt0gu5VIrS7yC51WT78KHEWawpLzPGiaU/4p2dAhPdt1cHynduvKJ2BYZkN9wOSNx2R7QhxGRHGfEK1BpQAltlGYdCfKHcZ/5WDQYXqNKTNt2LKplfcLA1GTRtrnfxnsLpM54mdAKxkaYxmTdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Jrd+MWoh; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Jrd+MWoh"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YYfkD0csSzrYC;
	Thu, 16 Jan 2025 11:49:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1737024547;
	bh=0OJztgyAMuj/9iBq14YYE6F6MRhd3WAVnquZ2qjhhTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jrd+MWohxMTP15wjS0GNr5OCRJyrvuV5zANhcQW0h4jvdQR9K1HFNUrAGFMGZmGq0
	 0EkXlwph2+gZrqDlwou0GPHG1W2wDRWRYZeebnCFQwxftIAY7iBfFi82Z7W97i2MDf
	 3r0bstHh8WFdjPAnG7f3/VsF7qgGxbFxtfYST0Xg=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YYfk91stMzxwR;
	Thu, 16 Jan 2025 11:49:05 +0100 (CET)
Date: Thu, 16 Jan 2025 11:49:04 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Charles Zaffery <czaffery@roblox.com>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, 
	Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Phil Sutter <phil@nwl.cc>, Praveen K Paladugu <prapal@linux.microsoft.com>, 
	Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, 
	Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, 
	Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 8/30] landlock: Add AUDIT_LANDLOCK_DENY and log ptrace
 denials
Message-ID: <20250116.gie7theti7Ji@digikod.net>
References: <20250108154338.1129069-9-mic@digikod.net>
 <081bd4a2a44a80e046662667e0aeb309@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <081bd4a2a44a80e046662667e0aeb309@paul-moore.com>
X-Infomaniak-Routing: alpha

On Wed, Jan 15, 2025 at 06:53:06PM -0500, Paul Moore wrote:
> On Jan  8, 2025 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> > 
> > Add a new AUDIT_LANDLOCK_DENY record type dedicated to any Landlock
> > denials.
> 
> ...
> 
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index 75e21a135483..60c909c396c0 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -33,7 +33,7 @@
> >   * 1100 - 1199 user space trusted application messages
> >   * 1200 - 1299 messages internal to the audit daemon
> >   * 1300 - 1399 audit event messages
> > - * 1400 - 1499 SE Linux use
> > + * 1400 - 1499 access control messages
> >   * 1500 - 1599 kernel LSPP events
> >   * 1600 - 1699 kernel crypto events
> >   * 1700 - 1799 kernel anomaly records
> > @@ -146,6 +146,7 @@
> >  #define AUDIT_IPE_ACCESS	1420	/* IPE denial or grant */
> >  #define AUDIT_IPE_CONFIG_CHANGE	1421	/* IPE config change */
> >  #define AUDIT_IPE_POLICY_LOAD	1422	/* IPE policy load */
> > +#define AUDIT_LANDLOCK_DENY	1423	/* Landlock denial */
> 
> I didn't have an opportunity to respond to your reply to my v3 comments
> before you posted v4, but I see you've decided to stick with _DENY as
> opposed to _ACCESS (or something similar).  Let me copy your reply
> below so I can respond appropriately ...
> 
> > A stronger type with the "denied" semantic makes more sense to me,
> > especially for Landlock which is unprivileged, and it makes it clear
> > that it should only impact performance and log size (i.e. audit log
> > creation) for denied actions.
> 
> This is not consistent with how audit is typically used.  Please
> convert to AUDIT_LANDLOCK_ACCESS, or something similar.

OK

> 
> > The next patch
> > series will also contain a new kind of audit rule to specifically
> > identify the origin of the policy that created this denied event, which
> > should make more sense.
> 
> Generally speaking audit only wants to support a small number of message
> types dedicated to a specific LSM.  If you're aware of additional message
> types that you plan to propose in a future patchset, it's probably a
> time to discuss those now.

The only other audit record type I'm thinking about would be one
dedicated to "potentially denied access", something similar to SELinux's
permissive mode.

> 
> > Because of its unprivileged nature, Landlock will never log granted
> > accesses by default.  In the future, we might want a permissive-like
> > mode for Landlock, but this will be optional, and I would also strongly
> > prefer to add new audit record types for new semantics.
> 
> Once again, this isn't consistent with how audit is typically used and
> I'm not seeing a compelling reason to rework how things are done.  Please
> stick with encoding the success/failure, accept/reject, etc. states in
> audit record fields, not the message types themselves.

OK
