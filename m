Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA83C3806DB
	for <linux-security-module@vger.kernel.org>; Mon,  9 Feb 2026 17:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658102; cv=none; b=ZyMpWBqEB7pH9MVjtdU7Yx1Q4b6wl83fZ+UKlkklNomfHzcL4zI4vAIF9G7VJEHoio2t/tkTXThwprV/kfW2ETsRAE7mYbhh9J0YK4DIfdjO2FWOEsr+aNBQEI5mrEPNX0lqHxh2rF+YtevqX9vq8Wa9ID55Vt0ZWThZ1sRJUKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658102; c=relaxed/simple;
	bh=6gXvKJAjqcdidYKxK1Kqtn6IlV9+aL3dZgg/6L0BwDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSVvZA19GtsMYw/br7W9HRgtfCkIxxIJyHSFUiwJb3znl/hSpRV7NawUhP6qYW5U+/IiTkeE3JY9NPcHI8TpZxiQLZ4c8fjr3CQ3S/rN5Oz/kR5RVN/3sePvJNgUPZOaLJU1InZV1Vs/1tiZ3WFIcB4AgcTYNvsY1FamjXRxOWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=pJZNJ9W+; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="pJZNJ9W+"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f8s975tQ4zxZp;
	Mon,  9 Feb 2026 18:28:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1770658091;
	bh=3gqUhixltclqIPX1OXG+VLBKMkJ07fmwSbxtaajMQF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pJZNJ9W+wf3ve/Y51pFeIBLDUzsY6Sgcto7YDYjm0cB9o4icf4tZpiOv8GlUeSSkB
	 XxZZyoQqb5SxW3f1aDOfL7cuxcEuPC27+CN17aOtM4jimqC80OmsjhOGAwkob8BC5G
	 Ei+hdaix87Y3SjW7K6lTRdyxoYwKRivklNGKcfjk=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4f8s971vrhzNPq;
	Mon,  9 Feb 2026 18:28:11 +0100 (CET)
Date: Mon, 9 Feb 2026 18:28:05 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] landlock: Add counted_by and fix comment in
 landlock_ruleset
Message-ID: <20260209.aexahm7thuoR@digikod.net>
References: <20260208235449.1124354-1-m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260208235449.1124354-1-m@maowtm.org>
X-Infomaniak-Routing: alpha

Thanks!

On Sun, Feb 08, 2026 at 11:54:48PM +0000, Tingmao Wang wrote:
> For a domain, this array stores the access masks for each layer (of
> which there are num_layers of them).  For an unmerged ruleset, we have
> one "layer", and one element in this array.  This annotation serves as
> useful documentation.
> 
> This also removes a comment saying that num_layers = 0 for unmerged
> rulesets, which is incorrect (it is 1).
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
> 
> I'm not sure if I should add a Fixes tag, but if I should had, it would
> be ae271c1b14 ("landlock: Add ruleset and domain management").
> 
>  security/landlock/ruleset.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index 9d6dc632684c..7005840ac641 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -168,8 +168,7 @@ struct landlock_ruleset {
>  			/**
>  			 * @num_layers: Number of layers that are used in this
>  			 * ruleset.  This enables to check that all the layers
> -			 * allow an access request.  A value of 0 identifies a
> -			 * non-merged ruleset (i.e. not a domain).
> +			 * allow an access request.
>  			 */
>  			u32 num_layers;
>  			/**
> @@ -184,7 +183,8 @@ struct landlock_ruleset {
>  			 * layers are set once and never changed for the
>  			 * lifetime of the ruleset.
>  			 */
> -			struct access_masks access_masks[];
> +			struct access_masks
> +				access_masks[] __counted_by(num_layers);
>  		};
>  	};
>  };
> 
> base-commit: f179e1859c711214412876c57f56f9b0cfb13264
> -- 
> 2.53.0
> 
