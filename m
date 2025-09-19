Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCE11F4C8C
	for <linux-security-module@vger.kernel.org>; Fri, 19 Sep 2025 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297805; cv=none; b=cPq5RX4jhTGcipcu3sBV1f8bB7vadB6iZh9r71MXuXIYmgZ+LqcXl+v2cN2EsCshn7Kgqa0slkXhW85whLeXntaXEI2MjrUxLbtjp5h2n1rwgqcfzP5AQE4BXAmpmy7jcPUhn8+nXob4It+i4KY3PjL5F7+hq93pw8qhc5WpTBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297805; c=relaxed/simple;
	bh=E/1PKOBA0I+KmqiEls00IfmoHaJ8DsKuk2tbfqheKnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsPFKVRO4EPwBTmq6U6lenb70j+6cL+zhoql0ufzLVK+Cru02QXBoYf89pEOtbA+gaF4V+pecy7P1fu6zNTprEnK49i/POQyq0yzlIRwQVKFCTwViDKV1meDV8BrEMoyq9pU0c3CgyAbaqJCQAGwt09QBkaypMPajlyMJAkMi84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=RYulmSx7; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="RYulmSx7"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cSy364g4dzWmg;
	Fri, 19 Sep 2025 18:03:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1758297794;
	bh=rPsv3B1EkRq7VqcmcbOD8rYsb2c/+B42C648hJleUkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RYulmSx7wm9qtVh5Cahnjo7pTMl3XEB3eGM2kup/njFKDJNdnZhyPvr4IRzIg7zl5
	 jXHp1v4WewaZ3EBNgLbOIoBbwCxoDHiIqPp2tPPkqNDfZI81rlNCo6KRVblB4G9sA2
	 08w+MlYcB/UQYxneioQZujfgniebARJsd0eGLPSk=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4cSy360dFfzqx;
	Fri, 19 Sep 2025 18:03:14 +0200 (CEST)
Date: Fri, 19 Sep 2025 18:03:13 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 4/6] landlock/audit: Fix wrong type usage
Message-ID: <20250919.foh6Zea7ugie@digikod.net>
References: <cover.1757376311.git.m@maowtm.org>
 <ad6c155f38dda6ed31be1f1cbc6def6cdbd9769c.1757376311.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad6c155f38dda6ed31be1f1cbc6def6cdbd9769c.1757376311.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Tue, Sep 09, 2025 at 01:06:38AM +0100, Tingmao Wang wrote:
> I think, based on my best understanding, that this type is likely a typo
> (even though in the end both are u16)
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>

Indeed, good catch!

You can add:

Fixes: 2fc80c69df82 ("landlock: Log file-related denials")

> ---
>  security/landlock/audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index 2b3edd1ab374..a67155c7f0c3 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -191,7 +191,7 @@ static size_t get_denied_layer(const struct landlock_ruleset *const domain,
>  	long youngest_layer = -1;
>  
>  	for_each_set_bit(access_bit, &access_req, layer_masks_size) {
> -		const access_mask_t mask = (*layer_masks)[access_bit];
> +		const layer_mask_t mask = (*layer_masks)[access_bit];
>  		long layer;
>  
>  		if (!mask)
> -- 
> 2.51.0
> 
> 
