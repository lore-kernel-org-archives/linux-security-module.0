Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B1E76025;
	Mon, 28 Jul 2025 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708883; cv=none; b=lWBn3eDLeJrQBSTvVhXMVMpDC4hVx0IRpBUxJpC/O78MyxrFctLKW29PMuPHyfqxAQqQeSxTGcSxpxqN+vrgthjyCVZsKNS/Pvq2gzliLz0INQS3INDPijmSPlPuIsWmQ2Gp/p7O3Sw04prtmgAvh23qArBaLy0ECRZ/fIqH1iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708883; c=relaxed/simple;
	bh=FU0TWOhMcQPcrjEidhtHqffEtq+nMO4IiO8P1ZFaiu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auE8e9lNjua0sibm8c7g0rRueF68sbz79lt0aE4r+h1vFqE2nS0pxgzmKmvTeuOmU1G8oOqgYIKBG9kXtTa2MT5BieqPfYPhxBBP+7I6ohpLwizh7Rj5s0OnxRNZrq7vIgmQzvzE1R5bcdbzRMVdEoKhfyO78Zl6TOo57M6BTAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id F0A8F608; Mon, 28 Jul 2025 08:21:17 -0500 (CDT)
Date: Mon, 28 Jul 2025 08:21:17 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	paul@paul-moore.com, serge@hallyn.com, jmorris@namei.org,
	dan.j.williams@intel.com
Subject: Re: [PATCH v2 1/3] lockdown: Switch implementation to using bitmap
Message-ID: <aId5TYh6ckjelddG@mail.hallyn.com>
References: <20250728111517.134116-1-nik.borisov@suse.com>
 <20250728111517.134116-2-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728111517.134116-2-nik.borisov@suse.com>

On Mon, Jul 28, 2025 at 02:15:15PM +0300, Nikolay Borisov wrote:
> Tracking the lockdown at the depth granularity rather than at the
> individual is somewhat inflexible as it provides an "all or nothing"
> approach. Instead there are use cases where it  will be useful to be
> able to lockdown individual features - TDX for example wants to disable
> access to just /dev/mem.
> 
> To accommodate this use case switch the internal implementation to using
> a bitmap so that individual lockdown features can be turned on. At the
> same time retain the existing semantic where
> INTEGRITY_MAX/CONFIDENTIALITY_MAX are treated as wildcards meaning "lock
> everything below me".
> 
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>

Would still like to see the comment, but, with or without it,
looks good, thank you.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/lockdown/lockdown.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index cf83afa1d879..5014d18c423f 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -10,12 +10,13 @@
>   * 2 of the Licence, or (at your option) any later version.
>   */
>  
> +#include <linux/bitmap.h>
>  #include <linux/security.h>
>  #include <linux/export.h>
>  #include <linux/lsm_hooks.h>
>  #include <uapi/linux/lsm.h>
>  
> -static enum lockdown_reason kernel_locked_down;
> +static DECLARE_BITMAP(kernel_locked_down, LOCKDOWN_CONFIDENTIALITY_MAX);
>  
>  static const enum lockdown_reason lockdown_levels[] = {LOCKDOWN_NONE,
>  						 LOCKDOWN_INTEGRITY_MAX,
> @@ -26,10 +27,15 @@ static const enum lockdown_reason lockdown_levels[] = {LOCKDOWN_NONE,
>   */
>  static int lock_kernel_down(const char *where, enum lockdown_reason level)
>  {
> -	if (kernel_locked_down >= level)
> -		return -EPERM;
>  
> -	kernel_locked_down = level;
> +	if (level > LOCKDOWN_CONFIDENTIALITY_MAX)
> +		return -EINVAL;
> +
> +	if (level == LOCKDOWN_INTEGRITY_MAX || level == LOCKDOWN_CONFIDENTIALITY_MAX)
> +		bitmap_set(kernel_locked_down, 1, level);
> +	else
> +		bitmap_set(kernel_locked_down, level, 1);
> +
>  	pr_notice("Kernel is locked down from %s; see man kernel_lockdown.7\n",
>  		  where);
>  	return 0;
> @@ -62,13 +68,12 @@ static int lockdown_is_locked_down(enum lockdown_reason what)
>  		 "Invalid lockdown reason"))
>  		return -EPERM;
>  
> -	if (kernel_locked_down >= what) {
> +	if (test_bit(what, kernel_locked_down)) {
>  		if (lockdown_reasons[what])
>  			pr_notice_ratelimited("Lockdown: %s: %s is restricted; see man kernel_lockdown.7\n",
>  				  current->comm, lockdown_reasons[what]);
>  		return -EPERM;
>  	}
> -
>  	return 0;
>  }
>  
> @@ -105,7 +110,7 @@ static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,
>  		if (lockdown_reasons[level]) {
>  			const char *label = lockdown_reasons[level];
>  
> -			if (kernel_locked_down == level)
> +			if (test_bit(level, kernel_locked_down))
>  				offset += sprintf(temp+offset, "[%s] ", label);
>  			else
>  				offset += sprintf(temp+offset, "%s ", label);
> -- 
> 2.34.1
> 
