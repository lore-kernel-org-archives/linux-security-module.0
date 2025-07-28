Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11F5221265;
	Mon, 28 Jul 2025 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753706752; cv=none; b=bAzJxrqruHPtLnmZfAGYTVzEx2N8ThXo7/aUoe/wMGpq/AsUhjnLsHGwI/PuWIs3StQ7Ksa+8CSedYsBGGVcjlSdB2GGbrI9wr209U5j1u9E51Y6RQxgxL3wfmJYiOvlMZrxIpghM8v89Zntc1UzYSHBgek4Ybh/uOhsY+hYU1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753706752; c=relaxed/simple;
	bh=qi1AB0E2pJMpmsJjAdKlaOwSzQ3Bg5lVUCIXcQbs9ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nreQTNI0jtVmF+aupLfBlXKtL+elXXYADQ9mMr6plIsKb6UJcoYbhXs2mCC0cFxa80QPgJX3dJncjOq7+utSEW0yj8Wk6kEPFhqhZDkF0To67PpvZcvSQEHTp+wptDxS/gDmXVnYWnItQJNnJRoDHOuOfmsCBtQVBZ6A7m5LX68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 36B78357; Mon, 28 Jul 2025 07:39:32 -0500 (CDT)
Date: Mon, 28 Jul 2025 07:39:32 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	paul@paul-moore.com, serge@hallyn.com, jmorris@namei.org,
	dan.j.williams@intel.com
Subject: Re: [PATCH v2 3/3] lockdown: Use snprintf in lockdown_read
Message-ID: <aIdvhOEiiPMDY4gW@mail.hallyn.com>
References: <20250728111517.134116-1-nik.borisov@suse.com>
 <20250728111517.134116-4-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728111517.134116-4-nik.borisov@suse.com>

On Mon, Jul 28, 2025 at 02:15:17PM +0300, Nikolay Borisov wrote:
> Since individual features are now locked down separately ensure that if
> the printing code is change to list them a buffer overrun won't be
> introduced.  As per Serge's recommendation switch from using sprintf to
> using snprintf and return EINVAL in case longer than 80 char string hasi
> to be printed.
> 
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>

Thanks, 2 comments below

> ---
>  security/lockdown/lockdown.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 412184121279..ed1dde41d7d3 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -112,11 +112,19 @@ static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,
> 
>  		if (lockdown_reasons[level]) {
>  			const char *label = lockdown_reasons[level];
> +			int ret = 0;
> +			int write_len = 80-offset;

80 should really be a #define (and used to declare the length of temp as
well).

> +
> 
>  			if (test_bit(level, kernel_locked_down))
> -				offset += sprintf(temp+offset, "[%s] ", label);
> +				ret = snprintf(temp+offset, write_len, "[%s] ", label);
>  			else
> -				offset += sprintf(temp+offset, "%s ", label);
> +				ret = snprintf(temp+offset, write_len, "%s ", label);
> +
> +			if (ret < 0 || ret >= write_len)
> +				return -ENOMEM;

is ENOMEM right here, or should it be something like EINVAL or E2BIG?

> +
> +			offset += ret;
>  		}
>  	}
> 
> --
> 2.34.1
> 
