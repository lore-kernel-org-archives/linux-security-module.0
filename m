Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2932D4683
	for <linux-security-module@vger.kernel.org>; Sat,  5 Oct 2024 00:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728087432; cv=none; b=eA2w1p9fEt1nJpsMYrK1+diaEnrMLzy6L7dHp0JeQAwurtiky8AfkjXUQMiGeDouixU4xueTpidT7RlJfK+pa6K8C2YxmusrYXExVTNF2T1o9mvYDt3NfOPKbe5Bg9T1xhLdiLk3suzZhpxy3R7o4Jh14zD48IGed7E/f3PljRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728087432; c=relaxed/simple;
	bh=mOf0eFUOgibLcsITPsHZYYCI6pyj03P+jE6rm9xK6gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqhKfpgEcDPxzclvWjiuWQ4zG3uvZLdpvm+MXkLA8Ud21GGzInFiNr2Ft0yb4RB4Gk1W/wGGdPgQSnpWQNH3JVgrTYdw6KFJD9znhXeiICG8kn3kKZ2hiwT7tSJXA4VpTigACuD9gPODDDYGwl+c2HShOEC9EhRnfXO4V8aNTuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnqV3gif; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnqV3gif"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5104C4CEC6;
	Sat,  5 Oct 2024 00:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728087431;
	bh=mOf0eFUOgibLcsITPsHZYYCI6pyj03P+jE6rm9xK6gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YnqV3gifmpZGRhGi0viw2ION12cAtgHDVxv0BO18ceT1mL5peFggCnnqnhQgh7MYc
	 vWQ21JEaZ/sxJLfcdSYG1hRiuAFgWiyNpEGY9jvYQF2nFOuf9g16IRJe2Ci+wfUtzg
	 bI3EHW/YVqRZRssLw2sRAC4rrn5iBzviJL00UVo24ucLnkewrehv97ICMVNF8N1tPa
	 WOI9U1HMjeD8bDIFGRKLKZoZt3kUmKWhzdB0r+IWVnqvWBGHZP6ADX+RWbDqVw9Ip5
	 2APjXs+67XUF7wHbkaIERPqYsw/iaIYYTzMGwt/hGcOdc1m3pV+fpqG5kmJJweMKM/
	 0IejejzumribA==
Date: Fri, 4 Oct 2024 17:17:08 -0700
From: Kees Cook <kees@kernel.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Paul Moore <paul@paul-moore.com>, Fan Wu <wufan@linux.microsoft.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	KP Singh <kpsingh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-security-module@vger.kernel.org
Subject: Re: TOMOYO's pull request for v6.12
Message-ID: <202410041645.27A48DA@keescook>
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <202410041305.544EA7E4E@keescook>
 <ece0c7bd-0d28-4562-8760-c54b0077583a@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ece0c7bd-0d28-4562-8760-c54b0077583a@I-love.SAKURA.ne.jp>

On Sat, Oct 05, 2024 at 08:41:06AM +0900, Tetsuo Handa wrote:
> On 2024/10/05 5:54, Kees Cook wrote:
> > - tomoyo_register_hooks() becomes an exploitation gadget that could be
> >   used to bypass the LSM as a whole.
> 
> tomoyo_register_hooks() is enabled only if "CONFIG_SECURITY_TOMOYO_LKM is
> included while building the kernel" && "security=tomoyo is specified or
> tomoyo is included in the lsm= kernel command line options".
> 
> Therefore, those who are building kernels with CONFIG_SECURITY_TOMOYO_LKM=n are
> not affected.

Sure, but my point is that convincing RedHat that this is acceptable is
likely to be an uphill battle considering their effort to gain full
ro_after_init coverage for SELinux.

> Even if kernels are built with CONFIG_SECURITY_TOMOYO_LKM=y, callbacks
> registered by tomoyo_register_hooks() won't be called unless "security=tomoyo
> is specified or tomoyo is included in the lsm= kernel command line options", for
> the proxy callbacks that use static call tables are not registered.

This part I overlooked. I forgot that Tomoyo is still not fully stackable,
so it isn't getting included in CONFIG_LSM= for the distros that do
build it.

> Even if kernels are built with CONFIG_SECURITY_TOMOYO_LKM=y, and "security=tomoyo
> is specified or tomoyo is included in the lsm= kernel command line options",
> tomoyo_register_hooks() can be called only once.

An attacker with a read/write primitive would be able to locate and
write to "registered" (since it is not read-only), allowing them to call
tomoyo_register_hooks() multiple times.

> And tomoyo.ko is loaded by the
> time /sbin/init (nowadays /usr/lib/systemd/systemd) starts. That is, by the time
> an attacker can login from console or can start attacking via network,
> tomoyo_register_hooks() is no longer callable.

See above -- calling tomoyo_register_hooks() after boot is entirely
feasible given a read/write attack primitive.

> Therefore, the only problem with tomoyo.ko approach is that the static call tables
> for tomoyo_register_hooks() are currently not marked as __ro_after_init. But it will
> be possible to make the static call tables read-only if the static call tables

The tables actually don't matter as much -- an attacker could construct
their own table anywhere in kernel memory and pass that as an argument
for their call to tomoyo_register_hooks().

(This is actually one of the reasons I have pushed to have sensitive
functions like that be able to check that their passed-in argument is
contained in a read-only area, but that didn't get much traction[1].)

> are aligned in a page boundary and an architecture-dependent kernel API that changes
> given page's attribute to read-only is called. (This is why __ro_after_init can work,
> isn't it?)

The __ro_after_init section is immediately neighboring the .rodata
section, so when .rodata is marked read-only (after __init has
finished), the kernel marks both sections read-only. (Except for, I
think, s390, which does two passes: .rodata is read-only before __init,
and then __ro_after_init is marked read-only after __init.)

> As a whole, I don't think tomoyo.ko approach is unacceptably dangerous.

I agree, this implementation is safer than I initial assessed (due to the
LSM's view of the hooks being skipped due to lsm= not including tomoyo).
I still think how this patch ended up in Linus's tree was a big mistake,
though.

Regardless, my opinion is unchanged: I think it will be harder to convince
RedHat to build in _this_ version of tomoyo compared to the stock version.

(Out of curiosity, does RedHat build in AppArmor?)

-Kees

[1] https://lore.kernel.org/lkml/202408052100.74A2316C27@keescook/

-- 
Kees Cook
