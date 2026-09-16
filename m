Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5184CA785
	for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2026 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561560; cv=none; b=EhOn0wO9agOQx2zWjk2CV79NxvwrEAklIe+Xu6lu9dMyDx1K/VsfCrkgl2rf7iEWYSQh5eGBAy0VFM68VzObTcI2yocCysur/707y/vYAMl7lKH1hBIBEJ9/Gfd0RU4/BOX7KJfVKVnjK7kfyxnF5iE60RtSF2oVt8OXAQVvbZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561560; c=relaxed/simple;
	bh=A/D0dr/kkWY2pC4T1uDWLqU7ZfZpRwQVu3BLlTOo/bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gz9SZIzSqDsK/EgLstoaMONtihmpPKVmKSQok/l5x0s/JlMnQomyisUxeEJigTet6nAPn71rvRPTUZ7J6lbAIosDS7zHM9JZm7LhixQGTo6+ZlYSKlvKcKfqMzDw29rkENdBMNaQnzv+ZKSp87aZUX9J/Nxki5NrTmJRWzY/CyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=v7zXYsr6; arc=none smtp.client-ip=83.166.143.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="v7zXYsr6"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hlJ581xB3zv2b;
	Wed, 16 Sep 2026 14:25:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789561548;
	bh=RUlFhdG/MfGo+W5labbbmzPlbDvx+B41ocy/spUYVus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v7zXYsr6r02fEDjeHoP/Hxz1riGcUb7Mg4so4Rorv7U8UWggPHbdJ6deQ4WFdtIZK
	 a23WPpkUcxDsZsitQdbyaF9I223BQ4z0xUg51ntffhlnM/EOCkOVuEnJ9cXac/cSbD
	 X08q6e6xvmqWv9Of7gO8COpEyD99GjKltq6o4gqc=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hlJ554JjnzN6W;
	Wed, 16 Sep 2026 14:25:45 +0200 (CEST)
Date: Wed, 16 Sep 2026 14:25:41 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] landlock: work around gcc-16 -Wuninitialized warning
Message-ID: <20260916.shai0tha3IPa@digikod.net>
References: <20260915201036.3527935-1-arnd@kernel.org>
 <20260916084947.6QDy8KZQ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916084947.6QDy8KZQ@linutronix.de>
X-Infomaniak-Routing: alpha

On Wed, Sep 16, 2026 at 10:49:47AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-09-15 22:10:30 [+0200], Arnd Bergmann wrote:
> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110743
> > Link: https://lore.kernel.org/all/20260619082133.3504146-1-arnd@kernel.org/
> > Fixes: a260c0055665 ("landlock: Add a place for flags to layer rules")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > v2: rebased to linux-next-20260914
> > 
> > I originally sent this in June, but got no reply and this still
> > happens with gcc-16.2, which is the latest stable release.

Thanks Arnd, I missed it.  It's in my -next branch now.

> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> This looks reasonable. I don't see this with gcc-16.2 and the referenced
> gcc bug has it as fixed.

If GCC is fixed now, should we keep this work around?

> 
> Sebastian
> 
