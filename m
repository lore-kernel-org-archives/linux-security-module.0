Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBE244376;
	Tue,  6 Aug 2024 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910805; cv=none; b=o7IX3lJuIyiXWlt9UNeHqPaQCuEwC8yU5Q66MxU4l5JxQJMSAFdIKmHkhAQArBv0s+QpvovbfqyL9xO0FiHVYE4pk4Y2EvLKGcdlJLfdufp/lXbQInWWBC6/LSR5XDFH35DNLMLtJChRx22kgMNSDnoiJr7kSx4vSdlLacprWnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910805; c=relaxed/simple;
	bh=9S6tVtHSHJo3qToGq9bIhQsitjGsrcFKDan0KV0PsvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRfjGwXO6bFJCE9+/WA4BymHZ8/okVLmZhMubou00sG+G/CfqF+0Bo0oH38a71mlViKo9/pGhIWwmN6Z5dAaCUoaWB+ZaY6W/FdducF5H8QO5h/OPtDsVZpn/+tPLqwlUCdFzn3pww4IQgcBI4+R/m7dCJ02/BV24qjPeDBapRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duZ/BX7b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duZ/BX7b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFECC32782;
	Tue,  6 Aug 2024 02:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722910804;
	bh=9S6tVtHSHJo3qToGq9bIhQsitjGsrcFKDan0KV0PsvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=duZ/BX7bxzV9putEGR6x3UaY33fkNgIV0nyl6E8b6tRQayz4gmFK2xBeX+BzEiNw3
	 ytsi9uwkdzmgBDq8qb4e1xmiJjJoVrJA47lvOaAoIxpxXU3Vw+s6GdlvV0evXKh5AC
	 jJzIldGWTXoGutWOi28B8NMl8hCPPU5Aj2Md5V+158/PuP7zgNoq1IXUmBXwnyH+Lz
	 xe4/SceQtJ44S8SYwYd3r7vOYZpHqbxy5cQIVjd+/UnH9dC5T8a3VLxpLXeERCLMaK
	 4y3PpyDVaUO4H6URKGh89TevxE2gicu2cuzXeBUxXLBxmIfipN71GYEvRCJ1V/wfNj
	 zLcPLusyj+D3A==
Date: Mon, 5 Aug 2024 19:20:02 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: KP Singh <kpsingh@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, bp@alien8.de,
	sfr@canb.auug.org.au, peterz@infradead.org
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
Message-ID: <20240806022002.GA1570554@thelio-3990X>
References: <20240801171747.3155893-1-kpsingh@kernel.org>
 <CAHC9VhRO-weTJPGcrkgntFLG3RPRCUvHh9m+uduDN+q4hzyhGg@mail.gmail.com>
 <CACYkzJ6486mzW97LF+QrHhM9-pZt0QPWFH+oCrTmubGkJVvGhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACYkzJ6486mzW97LF+QrHhM9-pZt0QPWFH+oCrTmubGkJVvGhw@mail.gmail.com>

On Tue, Aug 06, 2024 at 01:29:37AM +0200, KP Singh wrote:
> On Mon, Aug 5, 2024 at 9:58 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Thu, Aug 1, 2024 at 1:17 PM KP Singh <kpsingh@kernel.org> wrote:
> > >
> > > With LSMs using static calls, early_lsm_init needs to wait for setup_arch
> > > for architecture specific functionality which includes jump tables and
> > > static calls to be initialized.
> > >
> > > This only affects "early LSMs" i.e. only lockdown when
> > > CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is set.
> > >
> > > Fixes: 2732ad5ecd5b ("lsm: replace indirect LSM hook calls with static calls")
> > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > ---
> > >  init/main.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Considering the problems we've had, I'd like to hear more about how
...
> I guess it would not harm Boris, Nathan and others to look at it as
> well and see if it breaks any of their tests.

For what it's worth, I have not noticed any issues in my -next testing
with this patch applied but I only build architectures that build with
LLVM due to the nature of my work. If exposure to more architectures is
desirable, perhaps Guenter Roeck would not mind testing it with his
matrix?

Cheers,
Nathan

> > > diff --git a/init/main.c b/init/main.c
> > > index 206acdde51f5..a0e3f3c720e6 100644
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -922,8 +922,8 @@ void start_kernel(void)
> > >         boot_cpu_init();
> > >         page_address_init();
> > >         pr_notice("%s", linux_banner);
> > > -       early_security_init();
> > >         setup_arch(&command_line);
> > > +       early_security_init();
> > >         setup_boot_config();
> > >         setup_command_line(command_line);
> > >         setup_nr_cpu_ids();
> > > --
> > > 2.46.0.rc2.264.g509ed76dc8-goog
> >
> > --
> > paul-moore.com
