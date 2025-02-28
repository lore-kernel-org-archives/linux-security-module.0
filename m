Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C091F874A;
	Fri, 28 Feb 2025 19:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740771769; cv=none; b=mGg38uHfVV5qeD8Z5y8PKMzwfzn3eBlCP+CsDVr74KoK7swo4YkttIuTUbp4kgs/oNSm4Wb7Ml8C/JIP1bqmzxdbIQijyoXdDHhxGu7U9vlDfC/DDHG6++O1uRrXRJpKz+tMGmJd+GipMAHEX3O+1fSmC1RRK2Leulh+XJNffY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740771769; c=relaxed/simple;
	bh=gExOLcizIkF4331d6cLwI3tyM1IePyHWYkOIjhVfIrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gm/gPmLWSUeaBy8SzcGDBh6aj5k+Wtw8yotFefNM8Zxt0v/vlK4LLQQMz30NJIHN54nAi/bZ9Pan9AzxpxUHXlnJ0BMFijWY3fsWRqXcdGBTKPINadOhocn8T1hZN9Azt7u/Phg22tKajxyh0+oDxmJ3l3ZjDkk6pwjEbG0Nulk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dhe9AwTL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dhe9AwTL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77ACC4CED6;
	Fri, 28 Feb 2025 19:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740771768;
	bh=gExOLcizIkF4331d6cLwI3tyM1IePyHWYkOIjhVfIrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dhe9AwTLSwb7GUrOthzez/JO4JCq/08Qu4Iqy37GtSZOo+BvpsnXpa+IKMydFUj0m
	 +2mMGjChKTNWmkDexnah9uy4boJ77UcoTvEXVBcdAgGtWdHmm+7BqH+8wxseFVpGNm
	 bcMRu/1iFX9I/f6bv5m0hUzOD74a77swOifJQOy4779vefSsSpPfEcetOfeT+O8+gi
	 n+M7sbJkE2Or9s7qHIrBw7KFTVhBJCduOb1Ia3vkeFXBDCobGlVYCY0AgnxhE3aqoM
	 7BVDUU+KmaJoZIntPMfkEXMnv+cbeRq3+W0cfeWIrFiRcZXZY8iVh20xZTXnsbjqah
	 kwiMVkVJI7AZQ==
Date: Fri, 28 Feb 2025 11:42:45 -0800
From: Kees Cook <kees@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>,
	linux-security-module@vger.kernel.org,
	linux-modules@vger.kernel.org, cedric.hombourger@siemens.com,
	srikanth.krishnakar@siemens.com
Subject: Re: [PATCH] loadpin: remove MODULE_COMPRESS_NONE as it is no longer
 supported
Message-ID: <202502281136.66F12960A1@keescook>
References: <20250114161729.77142-1-arulpandiyan.vadivel@siemens.com>
 <CAHC9VhR8Ny3McMo7ZDw06ry0VdUHEQcym8yvSJHdYdUUoVMAKQ@mail.gmail.com>
 <CAHC9VhR41PLeO-TZvDt8jM2j5oDr_VyHPmsWh-B0ND4Ynot4HQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhR41PLeO-TZvDt8jM2j5oDr_VyHPmsWh-B0ND4Ynot4HQ@mail.gmail.com>

On Wed, Feb 26, 2025 at 07:17:33PM -0500, Paul Moore wrote:
> On Tue, Jan 14, 2025 at 10:20 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Jan 14, 2025 at 11:16 AM Arulpandiyan Vadivel
> > <arulpandiyan.vadivel@siemens.com> wrote:
> > >
> > > Updated the MODULE_COMPRESS_NONE with MODULE_COMPRESS as it was no longer
> > > available from kernel modules.
> > >
> > > Fixes: c7ff693fa209 ("module: Split modules_install compression and in-kernel decompression")
> > > Signed-off-by: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
> > > ---
> > > Changes in v2:
> > > Reword the commit message
> > > Modify logic and add Fixes tag.
> > > ---
> > >  security/loadpin/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > For what it's worth, this looks fine to me.
> >
> > Reviewed-by: Paul Moore <paul@paul-moore.com>
> 
> Kees, did you ever merge this into your LoadPin tree?

Hi! This slipped through the cracks.

> 
> > > diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
> > > index 848f8b4a60190..d82bcdb34cc8a 100644
> > > --- a/security/loadpin/Kconfig
> > > +++ b/security/loadpin/Kconfig
> > > @@ -16,7 +16,7 @@ config SECURITY_LOADPIN_ENFORCE
> > >         depends on SECURITY_LOADPIN
> > >         # Module compression breaks LoadPin unless modules are decompressed in
> > >         # the kernel.
> > > -       depends on !MODULES || (MODULE_COMPRESS_NONE || MODULE_DECOMPRESS)
> > > +       depends on !MODULES || (!MODULE_COMPRESS || MODULE_DECOMPRESS)

MODULE_COMPRESS depends on MODULES, so I think this can be reduced to:

	depends on !MODULE_COMPRESS || MODULE_DECOMPRESS

-Kees

-- 
Kees Cook
