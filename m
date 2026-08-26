Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DE63B6C1D;
	Wed, 26 Aug 2026 08:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731650; cv=none; b=gYLdMx6dMqCL+j7fuc6PJKYvkIegguldYO+pF03SW9pFJIJeA9EXfQ/jnVpNuq6eCeDU2lp/bURmOg49sDOHRmwCmkU5atOmxAl/Lhcdg19N6efUljrd73dSLYur39vAe55xllJ9K7K05KmWaI6eugVH5eG9TA7xaXb2ogy2UVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731650; c=relaxed/simple;
	bh=c/6R1lLfTkAoRxyb2vsG3S5EmBxh1S4AbvUEYo0SuUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tg7hXDE8aFfsYxvep9Ovxq80f6ogD2hcQlA2kdt1x096gmaw34afsFXP/RHOKnONF01P+N4+COFWv+7qNdyYO0Js9NXmy87BbzvE7KJh4yGJz08HuNm8OPbGotgiIoGgUW3PPPNn7XqbYOzBy6MXNCVpx2KsVozqplUbclZEfyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=QNScrMMK; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="QNScrMMK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Qf1Wnd2NzsppL+cNsjENmaon+19vvXFQ24dXyoWeaSM=; b=QNScrMMKhMoxPWCDYfhkC9iXdF
	N+XcGcP4LyEadW4wIssaoAIIljZCsGShS0BZi7xINgzK04NMu589MdezJZlw2qcNO8R7xLMifdks3
	noPfWI3qvQoRwjkMNQ7xRerrqyAZz0AZaRWYnG8cTHFt0uk1zTahRMDhWDTj53BT5X8BIFyIrP3XT
	XVkjqglg2rjn3siY1MLKdxMtoBq/3Acr2EK+AiMBa+QE4mJv1UfGj2UmRM2XHgJ4+PBSw3JIiCY1z
	6YCVPIK6DgJpsm1/xRVjzkeTBhwfQH6iZpWwKfh0feHnjgl1Ir0cNl8kuMr+M+30g+5A6NGed2bOp
	kGhIksDg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wz8f4-00F4cT-27;
	Wed, 26 Aug 2026 08:07:06 +0000
Date: Wed, 26 Aug 2026 01:07:01 -0700
From: Breno Leitao <leitao@debian.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Frederick Lawler <fred@cloudflare.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH v2 1/2] configfs: move CONFIGFS_MAGIC definition to
 magic.h
Message-ID: <ao6ejs3oWcRAea4h@gmail.com>
References: <20260819-configfs-v2-0-cb6e65d11589@cloudflare.com>
 <20260819-configfs-v2-1-cb6e65d11589@cloudflare.com>
 <ao2iHWDZAJf0FRqh@gmail.com>
 <6k67quhqhibslnmavtbvgnlzbohpgmyfm4yxekl4k5lzqdvr5o@xg3wbmdl5wbt>
 <46bde670fa25f07cc99dddc61ecc6de4d0ee125e.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46bde670fa25f07cc99dddc61ecc6de4d0ee125e.camel@linux.ibm.com>
X-Debian-User: leitao

On Tue, Aug 25, 2026 at 01:49:53PM -0400, Mimi Zohar wrote:
> On Tue, 2026-08-25 at 11:47 -0500, Frederick Lawler wrote:
> > Hi Breno,
> > 
> > On Tue, Aug 25, 2026 at 07:10:02AM -0700, Breno Leitao wrote:
> > > On Wed, Aug 19, 2026 at 06:45:22PM -0500, Frederick Lawler wrote:
> > > > IMA shouldn't measure or appraise configfs, but currently does because
> > > > it's missing from the default exclusion policies. Move CONFIGFS_MAGIC to
> > > > magic.h to expose the file system's magic to IMA, as well as other userland
> > > > applications.
> > > > 
> > > > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> > > 
> > > Do you want this change to go thorugh the configfs tree, or the tree
> > > specific for IMA?
> > > ?
> > 
> > Unless you have a user asking for it, I personally think it makes sense
> > for linux-integrity to take it since the two patches are related.
> > 
> > I don't mind spinning a v3 for integrity if you choose to take it now.
> > 
> > Best,
> > Fred
> > 
> > PS. Sorry for not keeping the Reviewed-by tag from v1. I usually
> > forget _something_ with re-spins until after the fact.
> 
> Breno, thank you for the Reviewed-by.  The patch set didn't quite make it in
> time for the open window, but I plan on upstreaming them.  Can we change the
> Reviewed-by to an Acked-by?

Sure. Feel free to do it.

Acked-by: Breno Leitao <leitao@debian.org>
