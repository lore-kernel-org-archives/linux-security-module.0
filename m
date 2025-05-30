Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09D513A244;
	Fri, 30 May 2025 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748644319; cv=none; b=Xijz95AJ6KJhpq1NLEjiLgxTp3ufN2nUnexZbv37x2f3BQOpYiyk7vPAankdnjNLfP0IAft6t6oEZd2pyPC/f3WDasaNh5yTY/RJgwe7KEB+99WquerHgwJ9xTBOPg37P1fl+GIX8PhfWB07jLJFvY9ipS4+9voPJCwr12rT1QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748644319; c=relaxed/simple;
	bh=FVBTH511d446AqvY6nbOy4XhJODJHimISDg6XLeq2us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzK4UqnaL3poWxTruiXZVARGizxc5SE5SfpDsQjmxjh/yvdK4oGhLEL+eH5+arFb9tdEULzGEdsCRB2KmBc6R+d5uH/CaZkFSYUHMpE4GLV92i2gQwPtaV9Yg1F8iZ0P1R9acvUxQdm6nN/1yzLLPl6otmfqrw85MVavM9a2GXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/gYDrkF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/gYDrkF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12914C4CEE9;
	Fri, 30 May 2025 22:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748644319;
	bh=FVBTH511d446AqvY6nbOy4XhJODJHimISDg6XLeq2us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q/gYDrkFUXw4VBPkMC1zV85fH+HnIvIPz3R5g5OMYZJxMDZg+BcqM3G0SthKSeJVw
	 jF2UnloiCq2cBCg5jJ/yaX0NIauanvnqGX2A1D2Cb/oc20xsWEMKaRhvHve+Fx6CQQ
	 GJePmidRpIwwnBJiWs35p8Pl8sEcfmnSn4fK2vPH92iiGgFhNp4WE+BmQXOWwKaYw/
	 Or19zGZyExzjOCY9XWnsWJw8dRGYcsGgPtb2wlqoO3CYnYnzZHo4XVvauhmNxlpaWw
	 hThkP+5Fg6UwZMgeE73l7IEJE9TDvTo4Rn8pRQVILm404hoItrjDLsqlYeBtK/tOfe
	 g1zU6OpOX0ZuA==
Date: Fri, 30 May 2025 15:31:54 -0700
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	akpm@linux-foundation.org, arnd@arndb.de, broonie@kernel.org,
	davidgow@google.com, diego.daniel.professional@gmail.com,
	gnoack@google.com, gustavoars@kernel.org, jmorris@namei.org,
	justinstitt@google.com, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux@treblig.org, llvm@lists.linux.dev, mcgrof@kernel.org,
	mic@digikod.net, morbo@google.com, nick.desaulniers+lkml@gmail.com,
	paul@paul-moore.com, pmladek@suse.com, rmoar@google.com,
	serge@hallyn.com, tamird@gmail.com, wangyuli@uniontech.com
Subject: Re: [PATCH 3/3] Revert "hardening: Disable GCC randstruct for
 COMPILE_TEST"
Message-ID: <202505301531.763B776@keescook>
References: <20250427013836.877214-3-kees@kernel.org>
 <20250530000646.104457-1-thiago.bauermann@linaro.org>
 <202505292153.14B0A688F8@keescook>
 <20250530190904.GA1159814@ax162>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530190904.GA1159814@ax162>

On Fri, May 30, 2025 at 12:09:04PM -0700, Nathan Chancellor wrote:
> On Thu, May 29, 2025 at 10:12:22PM -0700, Kees Cook wrote:
> > On Thu, May 29, 2025 at 09:06:46PM -0300, Thiago Jung Bauermann wrote:
> > > This commit was reported by our CI as breaking the allmodconfig build for
> > > the arm and arm64 architectures when using GCC 15. This is due to
> > > https://github.com/KSPP/linux/issues/367 :
> > > 
> > > 00:05:08 arch/arm64/kernel/kexec_image.c:132:14: internal compiler error: in comptypes_check_enum_int, at c/c-typeck.cc:1519
> > > 00:05:08   132 | const struct kexec_file_ops kexec_image_ops = {
> > > 00:05:08       |              ^~~~~~~~~~~~~~
> > 
> > I'm not able to reproduce this. Which specific version of GCC 15 and
> > on what distro are you seeing this?
> 
> It looks like this was also reported to Debian (I originally noticed it
> in the #gcc channel on OFTC a couple of weeks ago but forgot to mention
> it):
> 
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1104745
> 
> It looks like the difference might be whether GCC was built with
> additional checks or not based on the last couple of comments in that
> bug.

Proposed fix here:
https://lore.kernel.org/lkml/20250530221824.work.623-kees@kernel.org/

-- 
Kees Cook
