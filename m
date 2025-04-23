Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E37244686
	for <linux-security-module@vger.kernel.org>; Wed, 23 Apr 2025 18:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745434520; cv=none; b=bgXGfQSSvFtv3eyseif93p2Y5/JxpF+TRSrZVuAx9MqlJzt+uLsycuLJFK/mz9PV0v9yKL7GFyaJXGl3kqxQ7qrDIO5Ydi1n1n0hANuiUJ2E0enxAznFuICqQT+MfEZ1UnYMcmpmc+AcZj+c2HUNV3p+OYzaspqe8QHCiBkwu7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745434520; c=relaxed/simple;
	bh=H+qfChid8MZRcIUe+CmM5TpMvrRUtQpTYrMmvncAATU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOJ50T4lxY+QzlQZCWvA7aSsC8dXLJTunI2D3a0CfBW6iiSDGY4ZNOw6FS6tqId/9bPyHgztt59gVtGDwbhqtroICG4sMqoLgNxNh5rOAq+8doB6sxQDPwIJqGumjNqjAQdv9Y7dm5fVXAtGZJ6snodyBiI4wZgwpTez6ALqmt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=kZBPfPkT; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="kZBPfPkT"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZjSY01rfxzCKV;
	Wed, 23 Apr 2025 20:38:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1745433508;
	bh=/4V+XPxzzcoQzqWEANF53l/uZ/DfVypkRjYToFa1+Tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kZBPfPkTIuPicmAjA3eASpg/zXg6FIyfr8TCyCodBjtgYXRwXkGrxBC8DaWpaUcPO
	 ffL2qCzc9tgSMsZ+wfqi6BEW3ONXUkJ5QlXW8lhFfi1g7I2J8+XTWV0gxy0on3wDOt
	 l+WhKfSv1yCHiBilm2Un3YCrDm/NTo1BJPBW6uDc=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZjSXy4Ym9z2Z6;
	Wed, 23 Apr 2025 20:38:26 +0200 (CEST)
Date: Wed, 23 Apr 2025 20:38:25 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <kees@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux <linux@treblig.org>, 
	Mark Brown <broonie@kernel.org>, WangYuli <wangyuli@uniontech.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] landlock: Work around randstruct unnamed static
 initializer support
Message-ID: <20250423.phe6choh9AiN@digikod.net>
References: <20250421000854.work.572-kees@kernel.org>
 <20250422.eetheiPu6aiH@digikod.net>
 <ccdfe9c0-7c28-4ecf-a7da-95c9a20eead7@app.fastmail.com>
 <202504220756.4DD4BAD@keescook>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202504220756.4DD4BAD@keescook>
X-Infomaniak-Routing: alpha

On Tue, Apr 22, 2025 at 07:59:07AM -0700, Kees Cook wrote:
> On Tue, Apr 22, 2025 at 02:53:05PM +0200, Arnd Bergmann wrote:
> > On Tue, Apr 22, 2025, at 14:25, Mickaël Salaün wrote:
> > > On Sun, Apr 20, 2025 at 05:08:59PM -0700, Kees Cook wrote:
> > >> Unnamed static initializers aren't supported by the randstruct GCC
> > >> plugin. Quoting the plugin, "set up a bogus anonymous struct field
> > >> designed to error out on unnamed struct initializers as gcc provides
> > >> no other way to detect such code". That is exactly what happens
> > >> with the landlock code, so adjust the static initializers for structs
> > >> lsm_ioctlop_audit and landlock_request that contain a randomized structure
> > >> (struct path) to use named variables, which avoids the intentional
> > >> GCC crashes:
> > >
> > > This is not a sustainable solution.  Could we fix the plugin instead?
> > > This new Landlock change may be the first to trigger this plugin bug but
> > > it will probably not be the last to use unnamed static initializers.
> > > Forbidding specific C constructs should be documented.
> > 
> > I think the version from Kees' patch looks more readable than
> > the version with the compound literal, so it certainly seems appropriate
> > as an immediate regression fix, even if it's possible to fix the
> > plugin later.
> > 
> > >> We went 8 years before tripping over this! 
> > 
> > Right, it's probably enough to revisit the plugin code after
> > it happens again.
> 
> Yeah, that's my thinking as well.
> 
> > >> Closes: https://lore.kernel.org/lkml/337D5D4887277B27+3c677db3-a8b9-47f0-93a4-7809355f1381@uniontech.com/
> > >> Signed-off-by: Kees Cook <kees@kernel.org>
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Thanks! Mickaël, are you good with this for now, and if so, do you want
> to carry it or shall I?

I don't like this kind of change but I'm OK with it if it comes with
documentation explaining what construct should not be used in the kernel
(and even better, updating checkpatch.pl accordingly), or if it's a
temporary workaround and someone is working on fixing the plugin.  Are
you or someone else working on it?  In the meantime, feel free to carry
this patch.
