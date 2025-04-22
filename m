Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C998935949;
	Tue, 22 Apr 2025 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745333951; cv=none; b=chNuTfpDjNpsioHvgw2QMUNeM/wJjQ0DWcOe02Q+QruXYaQdoE495/8QfouESeNwD2qjksLvl1kFXEhkgDk+ZShYiAHVuxNAwtSG/JFNSl60pBkHNR+Ygv4iG6LXOung0HiY7DfNbzwKSEGSsQD1MXtWaqXA/KQLrIzEJEdXiJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745333951; c=relaxed/simple;
	bh=QfUbRAUwdvLjnyJ6+Xvv7d9sVZwBvQJv2ePW9+tPj10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3eiZyfeFsR7Y0OnvyDVbnbqNqn0WWYteoX3tSYaLEL8CD0cHko3NnsXgcRYxZtl72YA8LLoGcfa54Tyu7x8j5UvUdxs4G5oCOFixczBgy9FYtVi8IJmBByVaNqiTG/8SN+aLo1ifnPdYbMHNJaMWke9qlbmvSz3zFyC2Hbq88w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyG2Bm/q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyG2Bm/q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14895C4CEF2;
	Tue, 22 Apr 2025 14:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745333951;
	bh=QfUbRAUwdvLjnyJ6+Xvv7d9sVZwBvQJv2ePW9+tPj10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QyG2Bm/qoPGNuAUbAiF1AQkcOgcNEsKa93jlRy5IEX7m6ar4tMwTFnQvWJvgtfuaj
	 uWfuVB2V2/Ip9q7i0A8P4zQstRDP9vYGibvlwA7kc1KHvTYGAPc6epYVCamctZOMxF
	 coSO6iaeLqSJN1iXoVlp6LRI8+dc0s9fULdzXMSz1mzANS2EeWpFvaI7i7MZa1MfC8
	 UX6j4arl9enjTUkaj4Y0ol24nqiJ9/PiOCq/5/PKzWOc1OuUuaAINcDkDdILbIkmSK
	 rXMc1h05OiAyCm6GVxGia5bzP8y6O+qhKwzhxwJqcjRy1esHt7oksRdc+Q4dauQilb
	 KTISmvEkJa2og==
Date: Tue, 22 Apr 2025 07:59:07 -0700
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	linux <linux@treblig.org>, Mark Brown <broonie@kernel.org>,
	WangYuli <wangyuli@uniontech.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] landlock: Work around randstruct unnamed static
 initializer support
Message-ID: <202504220756.4DD4BAD@keescook>
References: <20250421000854.work.572-kees@kernel.org>
 <20250422.eetheiPu6aiH@digikod.net>
 <ccdfe9c0-7c28-4ecf-a7da-95c9a20eead7@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccdfe9c0-7c28-4ecf-a7da-95c9a20eead7@app.fastmail.com>

On Tue, Apr 22, 2025 at 02:53:05PM +0200, Arnd Bergmann wrote:
> On Tue, Apr 22, 2025, at 14:25, Mickaël Salaün wrote:
> > On Sun, Apr 20, 2025 at 05:08:59PM -0700, Kees Cook wrote:
> >> Unnamed static initializers aren't supported by the randstruct GCC
> >> plugin. Quoting the plugin, "set up a bogus anonymous struct field
> >> designed to error out on unnamed struct initializers as gcc provides
> >> no other way to detect such code". That is exactly what happens
> >> with the landlock code, so adjust the static initializers for structs
> >> lsm_ioctlop_audit and landlock_request that contain a randomized structure
> >> (struct path) to use named variables, which avoids the intentional
> >> GCC crashes:
> >
> > This is not a sustainable solution.  Could we fix the plugin instead?
> > This new Landlock change may be the first to trigger this plugin bug but
> > it will probably not be the last to use unnamed static initializers.
> > Forbidding specific C constructs should be documented.
> 
> I think the version from Kees' patch looks more readable than
> the version with the compound literal, so it certainly seems appropriate
> as an immediate regression fix, even if it's possible to fix the
> plugin later.
> 
> >> We went 8 years before tripping over this! 
> 
> Right, it's probably enough to revisit the plugin code after
> it happens again.

Yeah, that's my thinking as well.

> >> Closes: https://lore.kernel.org/lkml/337D5D4887277B27+3c677db3-a8b9-47f0-93a4-7809355f1381@uniontech.com/
> >> Signed-off-by: Kees Cook <kees@kernel.org>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks! Mickaël, are you good with this for now, and if so, do you want
to carry it or shall I?

-Kees

-- 
Kees Cook
