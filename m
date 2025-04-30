Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8B31DFDA5;
	Wed, 30 Apr 2025 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746039374; cv=none; b=B6qjAzvGdTGIcijGmL/SzfMLJblRqRC7+XfvduC81h1tysH6fNfOzZCcC04/WZnW+SAAl1RJK5aLVFHmwzGW7LXUa4/K7xahEhImXuHmzEwZpm3IZWx2PkVpH6EObpROAZipUdIxtpVOfx244nqZb47lAP3r8neXX9rSS+lmYRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746039374; c=relaxed/simple;
	bh=KeBZqBOT3TzcA4gh+7KvDD9sCKhrBLcUomzdBKW+FUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FitE6VT25KBaw5D5OFia4RRcnr74/JjEssR3XmJBJriojCc8oXXGRbjkgsSYzK95ukiTE8wYxBcWjC1Hk5ggTdigD1nT+9bP6EvLvHo8+r59iN1AA5DJaDl4+H3Cp9M6vWPmmADs36bMp4LFOHCzW83fyB91H/M1SekfpxvG21Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfMpuZ2K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfMpuZ2K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B69C4CEE7;
	Wed, 30 Apr 2025 18:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746039372;
	bh=KeBZqBOT3TzcA4gh+7KvDD9sCKhrBLcUomzdBKW+FUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LfMpuZ2KiT2J+K25zQgy7Knsn5liQBwAFXi/0YV16OeKryjOcvgVZ73DP2vEHtfUd
	 c549Ony4evs3/aVwbStezDnnjKON9HnDi5A3nhUzacHGjvw/uvGACxhxCKR+7YUCSR
	 j4cDZ7tsUxwdvsFgvfCFveXHa8G3cI/k7/q50gp6QyvB4Evrv9MAm1fildh2qUWx+t
	 uYX79u1gUvCjpeiGp1awM4eWDy2XHhkrP/WD3UKA+DnxiUmCjSgkciLraOWyGch4i4
	 gJ1Zdhs7uzHZOhl/4Qaf5HYsJFQjBUq1QqEL+w2K/c6Jo46uDaGvOSjXW0lRsfjMeD
	 8HYufAGD9w3nQ==
Date: Wed, 30 Apr 2025 11:56:09 -0700
From: Kees Cook <kees@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Petr Mladek <pmladek@suse.com>, Rae Moar <rmoar@google.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Diego Vieira <diego.daniel.professional@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>, llvm@lists.linux.dev,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Mark Brown <broonie@kernel.org>, WangYuli <wangyuli@uniontech.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH 2/3] lib/tests: Add randstruct KUnit test
Message-ID: <202504301154.1A83E92@keescook>
References: <20250427013604.work.926-kees@kernel.org>
 <20250427013836.877214-2-kees@kernel.org>
 <CABVgOSn1Lrkp96tucPniwPkVbpsBvTRZey=mCVDw7xS+Jro_AA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSn1Lrkp96tucPniwPkVbpsBvTRZey=mCVDw7xS+Jro_AA@mail.gmail.com>

On Tue, Apr 29, 2025 at 03:44:01PM +0800, David Gow wrote:
> On Sun, 27 Apr 2025 at 09:38, Kees Cook <kees@kernel.org> wrote:
> >
> > Perform basic validation about layout randomization and initialization
> > tracking when using CONFIG_RANDSTRUCT=y. Tested using:
> >
> > $ ./tools/testing/kunit/kunit.py run \
> >         --kconfig_add CONFIG_RANDSTRUCT_FULL=y \
> >         randstruct
> > [17:22:30] ================= randstruct (2 subtests) ==================
> > [17:22:30] [PASSED] randstruct_layout
> > [17:22:30] [PASSED] randstruct_initializers
> > [17:22:30] =================== [PASSED] randstruct ====================
> > [17:22:30] ============================================================
> > [17:22:30] Testing complete. Ran 2 tests: passed: 2
> > [17:22:30] Elapsed time: 5.091s total, 0.001s configuring, 4.974s building, 0.086s running
> >
> > Adding "--make_option LLVM=1" can be used to test Clang, which also
> > passes.
> >
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> 
> This works here for me. I'm a little wary of the prospect of the
> "unlucky or broken" message making the test fail if we're just
> unlucky, but it seems unlikely enough that we can deal with it later
> if it ever becomes a problem.
> 
> Acked-by: David Gow <davidgow@google.com>

Thanks!

Yeah, I wonder if it might be an interesting adjustment to the shuffling
to make sure it isn't a no-op? Like, it would shuffle with the original
hash, and if it's a no-op, it could permute the hash again, and then try
again? Hmmm...

-- 
Kees Cook
