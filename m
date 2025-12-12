Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CD7482EB
	for <linux-security-module@vger.kernel.org>; Fri, 12 Dec 2025 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765539155; cv=none; b=TyJ0EkDy8PzKY6FsKdrK5IoIIfJmBUMehg9TURMzPLtm9wGZQPAkKdRJiUmmtuHQQdudDLrBlFTemVxSPuq/dm+rCxL378RpszuStY0SxBMZRHTWWprNcn00fdWVo53sYYsyZHs8/rpOLxiXY2WxbqsSwZ8erOaQZqYbUYXtCtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765539155; c=relaxed/simple;
	bh=4NKZc50/SQFt89pDyBNeRi1V6IC2C0B4v+2M9dzTmG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRP2JeyJKlfRlZkhsctVVEMu1ljfy8JWH5Bhyj5BFGgHA7ltd706P+jbdsg86KTJcWpnJ10xXAkLF1A5vUzMczQKZXnemH9Wqdm90VoDN1keyxjGPm2ViObkTA6os4VA+ZoDq3AfP1o5LKQFnkl+syUJLFauL0kbN3FsGHHwsU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=qbd+ctei; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="qbd+ctei"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dSRfG5l7Mzf0y;
	Fri, 12 Dec 2025 12:13:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1765538022;
	bh=WCTx5waN0ym1PvmXfvBwG0aSoArzP/t6SDEcLsBhjiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qbd+cteirOtUlZpH2SzJ3n5RDZCX+Oe5S/CjncslLDfU5bMXrrQbhG1EL2nqFO+t4
	 N+MRJk7G2m6jtzrIwcerQIQ3c8K0bt2z2oW4dB10ZxRwIttlaYyyEvbt2M1XQJRia6
	 Jv64R9LJx8f+ZLXovDNPOULVHMQGBE4hzJEGuwbU=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dSRfG0wQczmvw;
	Fri, 12 Dec 2025 12:13:42 +0100 (CET)
Date: Fri, 12 Dec 2025 12:13:35 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>, 
	Jan Kara <jack@suse.cz>, Abhinav Saxena <xandfury@gmail.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v6 04/10] landlock: Fix wrong type usage
Message-ID: <20251212.Ohme7Thee9Bu@digikod.net>
References: <cover.1765040503.git.m@maowtm.org>
 <7339ad7b47f998affd84ca629a334a71f913616d.1765040503.git.m@maowtm.org>
 <aTvqrOomA3v52sIg@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aTvqrOomA3v52sIg@google.com>
X-Infomaniak-Routing: alpha

On Fri, Dec 12, 2025 at 11:13:19AM +0100, Günther Noack wrote:
> On Sat, Dec 06, 2025 at 05:11:06PM +0000, Tingmao Wang wrote:
> > I think, based on my best understanding, that this type is likely a typo
> > (even though in the end both are u16)
> > 
> > Signed-off-by: Tingmao Wang <m@maowtm.org>
> > Fixes: 2fc80c69df82 ("landlock: Log file-related denials")
> > ---
> > 
> > Changes in v2:
> > - Added Fixes tag
> > 
> >  security/landlock/audit.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> > index 1a9d3f4e3369..d51563712325 100644
> > --- a/security/landlock/audit.c
> > +++ b/security/landlock/audit.c
> > @@ -191,7 +191,7 @@ static size_t get_denied_layer(const struct landlock_ruleset *const domain,
> >  	long youngest_layer = -1;
> >  
> >  	for_each_set_bit(access_bit, &access_req, layer_masks_size) {
> > -		const access_mask_t mask = (*layer_masks)[access_bit];
> > +		const layer_mask_t mask = (*layer_masks)[access_bit];
> >  		long layer;
> >  
> >  		if (!mask)
> > -- 
> > 2.52.0
> 
> Agreed, thanks!
> 
> Reviewed-by: Günther Noack <gnoack@google.com>

Thanks, I pushed it to the next branch.

> 
> —Günther
> 
