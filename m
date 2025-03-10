Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB08E1E0DFE;
	Mon, 10 Mar 2025 21:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642367; cv=none; b=JQEFcGkp1o9Lbx+4g9IpVc1kzbj5ODvw8sAIZfY2HClcWK49zRzvED99P+DWDPgxhK1391sLGI15Bqo5eySG3IOR3jhtMyeoYjQqvtrVx7RRUvjkWYcXUUzcJiZlLeMGaejjcH4NUV35fenm4to8ckY/C6A8ZdVlEMqpiSapZRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642367; c=relaxed/simple;
	bh=3Fxs7rJSV0qaeyavlJF+FRPmeiUQukJOaWpfRx2dHeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyufvPnlEkjc7X0xoasEH5X9ORbQbqDXMY9s+X7w3lh2gC/rEVZrMJ8jYyqtmVj2/6Cj6Tn9MlfykdGlCEPRXxNmDFxwccH3X3rIv19z4aPybpEpt0iJvOqT1aCp60oZX6+1N2OwyA00ZOX/HH3arcCXhmh6hxnrB/XF8Qe9br8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 447BD622; Mon, 10 Mar 2025 16:32:37 -0500 (CDT)
Date: Mon, 10 Mar 2025 16:32:37 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: sergeh@kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add Serge Hallyn as maintainer for creds
Message-ID: <20250310213237.GA195898@mail.hallyn.com>
References: <Z82Sug-XLC1r5wKE@lei>
 <f44bad6065bbf45c02dc7caf90ed0e7e@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f44bad6065bbf45c02dc7caf90ed0e7e@paul-moore.com>

On Mon, Mar 10, 2025 at 03:58:41PM -0400, Paul Moore wrote:
> On Mar  9, 2025 sergeh@kernel.org wrote:
> > 
> > Also add the documentation file as suggested by Günther Noack.
> > 
> > Signed-off-by: Serge Hallyn <sergeh@kernel.org>
> > ---
> >  MAINTAINERS | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> I adjusted the subject line to reflect that you chose the reviewer role,
> but otherwise this looks good, merged into lsm/dev.  Thanks!

Oh, did I?  I went back and forth, and actually *intended* M, but must
have left my git index out of sorts :)  No problem - reviewer probably
makes more sense.

thanks,
-serge

> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 68e4656c15ea..54b47bfc4abd 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6141,11 +6141,13 @@ F:	drivers/hid/hid-creative-sb0540.c
> >  
> >  CREDENTIALS
> >  M:	Paul Moore <paul@paul-moore.com>
> > +R:	Serge Hallyn <sergeh@kernel.org>
> >  L:	linux-security-module@vger.kernel.org
> >  S:	Supported
> >  T:	git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
> >  F:	include/linux/cred.h
> >  F:	kernel/cred.c
> > +F:	Documentation/security/credentials.rst
> >  
> >  INTEL CRPS COMMON REDUNDANT PSU DRIVER
> >  M:	Ninad Palsule <ninad@linux.ibm.com>
> > -- 
> > 2.34.1
> 
> --
> paul-moore.com
