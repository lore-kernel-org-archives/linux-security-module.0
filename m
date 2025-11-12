Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7D334253C
	for <linux-security-module@vger.kernel.org>; Wed, 12 Nov 2025 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762967084; cv=none; b=cj1ioOl3Wu2z0j+XmiFofS9kHTdTvkmmACu7S1dWDTJ7afkbhbgGdzhN1hsz2D3lV97cAKKfMcLQhSdTeQmxC7mMuqklUxJM4Ux9aLmmAjptCpkMROApKJV/d+Tcudes7bbMxw3zUBINGpUs8lUOt/F8yNZIpHH/eVk5SC+R3Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762967084; c=relaxed/simple;
	bh=pJcqMPl3DNfgRBHZpDA71N51LBtY4aTf2vCLAL2jWLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olcerbel8W+ZlHU2Pe+Sosb7g3BqWARsv/CUaHau2ilnqUB/zdFj+ndgCyyWVvBGVuUhDPgrTCi0ZhDmWQpwGgIK7zYPt9d4bh82SIfVU6fZJjkqJSBw9X31J7/J/VCM0bPRsEOAjd1LoLopSFLDpOvgJomjmL24NckcjxGkRxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=vLPpFQgM; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="vLPpFQgM"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d68rv03GbzPvF;
	Wed, 12 Nov 2025 18:04:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1762967070;
	bh=8wHegL/s+r0XTkiTt++F4YZb9EEoyywfISncobLyDeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vLPpFQgMfgSuP9WkIqdCGfeQHjvF17SBS/B1KLtE0Rl+sKJ5az/wNp22tUs36+mFQ
	 fl88QmAjZc/lq2PINmXSmBXcVKv+NkEfN7mA3go0HrQ0UeyWEwop4ODjGBgoqkKBFh
	 R11tFXBezaeZuppCK7qYX7s2buYgbk7NREK9mjko=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4d68rt4Dc3zR9V;
	Wed, 12 Nov 2025 18:04:30 +0100 (CET)
Date: Wed, 12 Nov 2025 18:04:29 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] Documentation/landlock: Make docs in cred.h and domain.h
 visible.
Message-ID: <20251112.Ohd2daighuuc@digikod.net>
References: <6050e764c2679cba01715653e5f1f4f17091d8f8.1759103277.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6050e764c2679cba01715653e5f1f4f17091d8f8.1759103277.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Mon, Sep 29, 2025 at 12:49:49AM +0100, Tingmao Wang wrote:
> Currently even though the structures in these files have documentation,
> they are not shown in the "Landlock LSM: kernel documentation" page.
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>

Thanks! I'll merge this patch in -next.


> ---
>  Documentation/security/landlock.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
> index e0fc54aff09e..5066f8c3091e 100644
> --- a/Documentation/security/landlock.rst
> +++ b/Documentation/security/landlock.rst
> @@ -110,6 +110,12 @@ Filesystem
>  .. kernel-doc:: security/landlock/fs.h
>      :identifiers:
>  
> +Process credential
> +------------------
> +
> +.. kernel-doc:: security/landlock/cred.h
> +    :identifiers:
> +
>  Ruleset and domain
>  ------------------
>  
> @@ -128,6 +134,9 @@ makes the reasoning much easier and helps avoid pitfalls.
>  .. kernel-doc:: security/landlock/ruleset.h
>      :identifiers:
>  
> +.. kernel-doc:: security/landlock/domain.h
> +    :identifiers:
> +
>  Additional documentation
>  ========================
>  
> 
> base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
> -- 
> 2.51.0
> 
> 
