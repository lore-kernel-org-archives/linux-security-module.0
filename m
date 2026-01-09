Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACC2311C09
	for <linux-security-module@vger.kernel.org>; Fri,  9 Jan 2026 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767974777; cv=none; b=bMeV62+BmLOvmaIGxcxx1lgxnRI8d7a/sgAnAJZCAfzTpmrngyCX9Euv7UdakKsjO/8PvB/LdpO1CzjpUrGRty0EMAaoMqVuwV4CmzSGxO1khAkJxZWYbuVAGz91qxR2TN9xj9/RiMBa5pQcf2ma+20NEB9t62swF93377pxevw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767974777; c=relaxed/simple;
	bh=AUYXBX8UYrFeX5/E2sVtCcPRT+U3+8C2atJ6I/p0U9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAxrbx2AB1xvSUdrzgQjNDxH8iniCLk753UXVkReflUBFB5TlbLzWB+p1YyME43pPWi3gPD3YRroB3SSw4CDC+iWTPeeK20utApw4+WMQY+gsevTDbaPwlqDqtGhQ3XD/Xv1uBfl+g9iVt0gGRdd8EOQJjcMiBkMqBTggP2L87k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=FRpnKUdq; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="FRpnKUdq"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dnmps1MVvz177D;
	Fri,  9 Jan 2026 17:06:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1767974773;
	bh=5EHNRILuUrAb/+7fWraQiAGEJlFhFtRPqoiJGBkkGvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FRpnKUdq49iqNyVUEZpPfAJntunvlAaXnA7WiXzqqL2N/GqyQCPgu9uNJfGsGrICX
	 aDiIPs7BWyiOMVvTK8obfRGJws/DrrtfPoG87k6PXGy9WcVBY6PH23vUoU+jHdViFU
	 dI8bawgVdcP/Q6zXfiJZ3DS67cSIG5hwo19kzhD0=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dnmpr4KGyzD3C;
	Fri,  9 Jan 2026 17:06:12 +0100 (CET)
Date: Fri, 9 Jan 2026 17:06:10 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com
Subject: Re: [RFC PATCH 1/2] landlock: access_mask_subset() helper
Message-ID: <20260109.Te8xoaceiqu3@digikod.net>
References: <20251230103917.10549-3-gnoack3000@gmail.com>
 <20251230103917.10549-5-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251230103917.10549-5-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

On Tue, Dec 30, 2025 at 11:39:19AM +0100, Günther Noack wrote:
> This helper function checks whether an access_mask_t has a subset of the
> bits enabled than another one.  This expresses the intent a bit smoother
> in the code and does not cost us anything when it gets inlined.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  security/landlock/fs.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index fe794875ad461..b4ce03bef4b8e 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -398,6 +398,15 @@ static const struct access_masks any_fs = {
>  	.fs = ~0,
>  };
>  
> +/*
> + * Returns true iff a has a subset of the bits of b.
> + * It helps readability and gets inlined.
> + */
> +static bool access_mask_subset(access_mask_t a, access_mask_t b)
> +{
> +	return (a | b) == b;

I'm curious about why this switches to a binary OR instead of the
original AND.

> +}
> +
>  /*
>   * Check that a destination file hierarchy has more restrictions than a source
>   * file hierarchy.  This is only used for link and rename actions.
> @@ -1696,7 +1705,7 @@ static int hook_file_open(struct file *const file)
>  		ARRAY_SIZE(layer_masks));
>  #endif /* CONFIG_AUDIT */
>  
> -	if ((open_access_request & allowed_access) == open_access_request)
> +	if (access_mask_subset(open_access_request, allowed_access))
>  		return 0;
>  
>  	/* Sets access to reflect the actual request. */
> -- 
> 2.52.0
> 
> 
