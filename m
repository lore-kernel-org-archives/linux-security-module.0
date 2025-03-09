Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AB61A2399
	for <linux-security-module@vger.kernel.org>; Sun,  9 Mar 2025 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741513312; cv=none; b=Tkuen711UrdzSwKuUDzIMTnNOv72uw3jL1oDHgknsNk/OSW8KweQIE1gr9OkzQQxqozAbLPItEn0fq3rUrUmMOsN3N85X4XXAo/k/lTZ/OlKIy54xR8LXtQ6HvuO9SSQlQ3sdFo+Ke8r/y1YhuPywuFpdjYZsl/IceAT/dxCToQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741513312; c=relaxed/simple;
	bh=1sV88catGBLBt67g4ta/h4L5l4cH+JnasGAkXXakRb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwaBCHpEO8RmmEEDdGmREhOeyb1mRwrzq/j/WHo3bfNp0bj8TskEeBNCfSGNvWl71olDZDq22Q8u1LkBx8Ulr4Yop6DiplExJzc+ggJ7s1Zccj+Hp9rO4hrut3aWuHLF0n9JLhp8UaCBL/R+CfnmTDF9MdwN6Z1u7HaK9dHm+zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=t9aE+AIC; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="t9aE+AIC"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9ZmV0Xg1zCBg;
	Sun,  9 Mar 2025 10:41:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741513305;
	bh=x6XlMZAJyO6mfNKQu0BsQoXE/LYgw7nuIaIwpx1cXzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t9aE+AICsBRV/plyXsP7UM4rnGKYiATycGLIm2DUv/g99vQsLvplSwY6AybBDDWuu
	 XwkBHfPMH0OOEnyLcaJkfmHIBfCO0KaiK2mOQ1SxsPLtyG8EpXT5nTDlYMHjx5TSb/
	 pQt243xocyHRJD3zUHX6LbvfthlXy5jsJ0DUeJHU=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9ZmS02L1z5LZ;
	Sun,  9 Mar 2025 10:41:43 +0100 (CET)
Date: Sun, 9 Mar 2025 10:41:42 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: Ben Scarlato <akhna@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, Francis Laniel <flaniel@linux.microsoft.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Tingmao Wang <m@maowtm.org>, Tyler Hicks <code@tyhicks.com>, 
	audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v6 00/26] Landlock audit support
Message-ID: <20250309.iug3oocuJohL@digikod.net>
References: <20250308184422.2159360-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250308184422.2159360-1-mic@digikod.net>
X-Infomaniak-Routing: alpha

On Sat, Mar 08, 2025 at 07:43:56PM +0100, Mickaël Salaün wrote:
> Hi,
> 
> This patch series adds audit support to Landlock.
> 
> Logging denied requests is useful for different use cases:
> - sysadmins: to look for users' issues,
> - security experts: to detect attack attempts,
> - power users: to understand denials,
> - developers: to ease sandboxing support and get feedback from users.
> 
> Because of its unprivileged nature, Landlock can compose standalone
> security policies (i.e. domains).  To make logs useful, they need to
> contain the most relevant Landlock domain that denied an action, and the
> reason of such denial.  This translates to the latest nested domain and
> the related blockers: missing access rights or other kind of
> restrictions.
> 
> # Main changes from previous version
> 
> Renamed the landlock_restrict_self(2) flags to improve clarity and
> consistency, and slightly change the semantic of the first one:
> - LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF: do not log denied access
>   caused by a task with the same executable (i.e. before any new
>   execve(2));
> - LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC_ON: log denied access for
>   processes resulting from an execve(2), which is not the case by
>   default.
> - LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF: do not log denied access
>   from future nested domains.
> 
> These new LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF and
> LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC_ON are not incompatible anymore.

As you can see in the patches, it's not
LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC_ON but
LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON now.  I think "new_exec" makes
more sense than "cross_exec", especially compared to "same_exec", but
I'm open to suggestions.

Anyway, this patch series should land Monday in linux-next.  In the
meantime you can find it here:
https://web.git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next
