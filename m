Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC811AC88B
	for <linux-security-module@vger.kernel.org>; Tue, 22 Jul 2025 12:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753188857; cv=none; b=dlduqn5hv207yBlUbJmlB5PhuP7qJ5ErK61cgpY2e0M6+wqUmbOL96DIAL1yUlfCPyS8FFfN/7n2PFf/A8KLgA2sJLMw/XTwvN9ryI3Bl9Cmzg7JCk984Z+PYMOuaIv57ve3JnMksEY9P49dsF54jmXUdm1NtU25L3LLdtTXCZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753188857; c=relaxed/simple;
	bh=l1pjhmn+os5vU1bYmN2siBwN7ztuvZS3LuDqr/BLGN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3zBiQd0Xuzz+kWssim/OIgstmyUnGwQVupIz4rfCWwIvjDXpWE4aT+Kd5NCULep2XBGRsav0un12+Wr7aGzoluITAL6vwLs1y5l5aboBwlcZy27rp50RWdCP4O0Pcfqik3oJTXlphAZ7vM/NqMJ/l8gJFlGTdRC8drMSiUFq6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=pLPJ1GYK; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="pLPJ1GYK"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bmcf52RgFzkNC;
	Tue, 22 Jul 2025 14:54:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1753188845;
	bh=cP5SnByLdcIjrCHEGaUgRQChFWyWTB7bf9Yn2XJjM3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pLPJ1GYKv1My5vFuRk335E0Yo7SS3/NAb+Az1YwJFqmvYE2UfT14CWqn8ktDe/lAs
	 f8VeKXKgeNh3HB2usDEc/AnkPIueomObDjpFFcE/gxXN/EYjA7mSw7iKT6rUAEf/FF
	 tlhzv7mzEJYInsCZ2ZafRzibz3zCpH7vyTxyQsgI=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bmcf46lgSztBr;
	Tue, 22 Jul 2025 14:54:04 +0200 (CEST)
Date: Tue, 22 Jul 2025 14:54:04 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] landlock/ruleset: Minor comments improvements
Message-ID: <20250722.ahCe4yi4thou@digikod.net>
References: <20297185fd71ffbb5ce4fec14b38e5444c719c96.1748379182.git.m@maowtm.org>
 <20250603215636.111939-1-m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603215636.111939-1-m@maowtm.org>
X-Infomaniak-Routing: alpha

I updated the comments with the disconnected directory patch series, and
I took this patch into account.  Thanks!

On Tue, Jun 03, 2025 at 10:56:35PM +0100, Tingmao Wang wrote:
> As discussed in chat, here is another one for you to consider and squash :)
> 
> Current comment here is IMO a bit confusing - it says "Only allow ...
> internal filesystems" but that's not the case.
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
>  security/landlock/fs.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 9396d2d9df40..11b469002c03 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -911,9 +911,10 @@ static bool is_access_to_paths_allowed(
>  		}
>  		if (unlikely(IS_ROOT(walker_path.dentry))) {
>  			/*
> -			 * Stops at disconnected root directories.  Only allows
> -			 * access to internal filesystems (e.g. nsfs, which is
> -			 * reachable through /proc/<pid>/ns/<namespace>).
> +			 * Stops at disconnected root directories.  Allows access to
> +			 * internal filesystems (e.g. nsfs, which is reachable through
> +			 * /proc/<pid>/ns/<namespace>), in addition to what's already
> +			 * allowed.
>  			 */
>  			if (walker_path.mnt->mnt_flags & MNT_INTERNAL) {
>  				allowed_parent1 = true;
> --
> 2.49.0
> 
