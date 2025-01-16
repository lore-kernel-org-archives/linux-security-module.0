Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC661DE2D7
	for <linux-security-module@vger.kernel.org>; Thu, 16 Jan 2025 10:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737025044; cv=none; b=K0kpfvAJnyEGYZvMZzBCWqhi+ujjhfokM7hDUVSpfCz1tLl1imylHVsvDjBM0gVwp1j/Kj1fGqe8wWYyEbRHrONdwaK+KSU4DVS32Yr2QrFdJKhyU5tAI4+KHPzaJFx4XLH/h28Nj5aXsk7CBBPfb5Thm62R9L9f1/gzXw8Wtac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737025044; c=relaxed/simple;
	bh=VQ20OYCm7LTW6QnWoDw/BkUofW5RRIhojQ1mEuKiVAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eu0ZeHXY7wH7Yc5hO56m0/pk0MgeL7MLARg2QUZnYm/1JDwO06TWw5whAwnAOeCSaNl0BS9lOslPQr/L58gXPFzdPE/mWe1Src3rza41mdngRe8i3FReIyCShuhAT30veV9ylLSrOVCbG+49a22yoOmcPsUEL4mTKFY0E6GIoCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=kF3N5X6P; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="kF3N5X6P"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YYfvg5vPBznM1;
	Thu, 16 Jan 2025 11:57:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1737025039;
	bh=gTDiyaTDPfpSnRlUFP5GvbzzGcDbaMRsUAaVHeyXyFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kF3N5X6PYIa/hs4bz66HeXt7oGXMwmBDiyi6tqwX3PM+UaeoDl72WzyjccazmlWom
	 lY0PObCTTDVq8/KJBDsuFwgnljF4ktnYou0Kgy3smjcv0DGWN2ASsB6Q5DjclI6cZ7
	 vh/dvENtCQ5BBb+oVBjVfeoTNWtrAKlaxD0QlNTU=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YYfvf25pYz1s3;
	Thu, 16 Jan 2025 11:57:18 +0100 (CET)
Date: Thu, 16 Jan 2025 11:57:17 +0100
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
Subject: Re: [PATCH v4 28/30] audit,landlock: Add AUDIT_EXE_LANDLOCK_DENY
 rule  type
Message-ID: <20250116.tie4PhauzooC@digikod.net>
References: <20250108154338.1129069-29-mic@digikod.net>
 <1ac8548a7b42eaed3f4392690011eb8b@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ac8548a7b42eaed3f4392690011eb8b@paul-moore.com>
X-Infomaniak-Routing: alpha

On Wed, Jan 15, 2025 at 06:53:08PM -0500, Paul Moore wrote:
> On Jan  8, 2025 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> > 
> > Landlock manages a set of standalone security policies, which can be
> > loaded by any process.  Because a sandbox policy may contain errors and
> > can lead to log spam, we need a way to exclude some of them.  It is
> > simple and it makes sense to identify Landlock domains (i.e. security
> > policies) per binary path that loaded such policy.
> > 
> > Add a new AUDIT_EXE_LANDLOCK_DENY rule type to enables system
> > administrator to filter logs according to the origin or the security
> > policy responsible for a denial.
> 
> For reasons similar to why I didn't want to expose the audit timestamp
> to users outside of audit, I'm not very enthusiastic about expanding
> the audit filtering code at this point in time.
> 
> I'm not saying "no" exactly, just "not right now".

Contrary to MAC systems which are configured and tuned by one entity
(e.g. the sysadmin), Landlock security policies can be configured by a
lot of different entities (e.g. sysadmin, app developers, users).  One
noisy policy (e.g. a buggy sandboxed tar called in a loop by maintenance
scripts) could easily flood the audit logs without the ability for
sysadmins to filter such policy.  They will only be able to filter all
users that *may* trigger such log (by executing the buggy sandboxed
app), which would mean almost all users, which would mask all other
legitimate Landlock events, then nullifying the entire audit support for
Landlock.

My plan was to extend these new kind of filter types to PID, UID, GID,
and LOGINUID (a subset of the audit filter exclude list) to give the
necessary flexibility to filter policy creators.

We really need a way to filter policy creators, and that needs to be
part of the (initial) Landlock audit support for it to be viable.
What do you propose?
