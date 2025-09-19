Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7877314A6E
	for <linux-security-module@vger.kernel.org>; Fri, 19 Sep 2025 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297864; cv=none; b=iLY//lkgeY4QnlR8IJq4iTSkMW96GJdJBwXioiRLcO5HnwLJTLvRDJDsivx/Gq1TqTXxf63lbhGBWg8TZ6I/yL5/WRE2HZgmwFjZ0qSqxhQc4UKlqtwr/qn6D2Bja6DOYDblyOtpVwpS77TiJCjjQgv5AJfy/SbDwTmfpoEK6fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297864; c=relaxed/simple;
	bh=hZYGdsofAarDHasY5NsztkYKqEGT6GUQoftq2uILlV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TK+XVM+yYrYwhMwUmeux6oBd1qCCuOKOHZlxIb6kQ1CaCBLEjZyK6zj+3frOYtfns/f98Qno/DaiaoMdusTn1uOsA8Nbby+ylcPOxwgpFkVz1nvqkSMRRMbV89mDH6/qbwUYm0S7eySXHU2L1R/Bpxs4FkjdSKzRDwuubmAQl5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=JS8Lbo7A; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="JS8Lbo7A"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cSy4F1JC3zFbH;
	Fri, 19 Sep 2025 18:04:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1758297853;
	bh=cphbkaXht26hcXe2zinMwsltvQJ7Yuce57bNylp6aTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JS8Lbo7AQsAK9TKeVlPqn5suRAX7nHtaceZJt+yy1yiRa9jjOl05XZlUd+o7Dkm7E
	 +M5Jl7Tl92m1cdCFfaPOQcpz0OS/75pIePNPPD11gEeNEAHXX6dHshUXRNc6zYgvrg
	 Q1SpRs0dPVZoZsMMlADsGENYWzyMgy+h2+rZfYZY=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4cSy4D4gCJzvjL;
	Fri, 19 Sep 2025 18:04:12 +0200 (CEST)
Date: Fri, 19 Sep 2025 18:04:11 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 5/6] landlock/access: Improve explanation on the
 deny_masks_t
Message-ID: <20250919.loh1Oor4busa@digikod.net>
References: <cover.1757376311.git.m@maowtm.org>
 <9253127a0386f53f84897f62a2beaa5aa5959360.1757376311.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9253127a0386f53f84897f62a2beaa5aa5959360.1757376311.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

Looks good, I'll take it.

On Tue, Sep 09, 2025 at 01:06:39AM +0100, Tingmao Wang wrote:
> Not really related to this series, but just something which took me a
> while to realize, and would probably be helpful as a comment.

Please just describe the change in the main commit message and move this
kind of explanation bellow a "---", just after your SoB.  This is useful
for review and avoid unrelated information when picking a patch out of
this context.

> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
>  security/landlock/access.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/security/landlock/access.h b/security/landlock/access.h
> index 7961c6630a2d..5e2285575479 100644
> --- a/security/landlock/access.h
> +++ b/security/landlock/access.h
> @@ -67,8 +67,10 @@ typedef u16 layer_mask_t;
>  static_assert(BITS_PER_TYPE(layer_mask_t) >= LANDLOCK_MAX_NUM_LAYERS);
>  
>  /*
> - * Tracks domains responsible of a denied access.  This is required to avoid
> - * storing in each object the full layer_masks[] required by update_request().
> + * Tracks domains responsible of a denied access, stored in the form of
> + * two 4-bit layer numbers packed into a byte (one for each optional
> + * access).  This is required to avoid storing in each object the full
> + * layer_masks[] required by update_request().
>   */
>  typedef u8 deny_masks_t;
>  
> -- 
> 2.51.0
> 
> 
