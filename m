Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1935B264627;
	Mon, 28 Jul 2025 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753706824; cv=none; b=iKqdptqV37kvX66QKN/vpD61c/NLEO1nRbRWeTM0Oe3Ck/pEN0/ermXf+GncF+yXI1q0Z6wopC/bc1FlSfIiGjMMZ78qgyJ0101aH1JuusYc88hPWTffwNU9vrCUSYzH1XMD1z5cAIybQEnWiTc44Xl7lI16z6Po2whdGm1E9O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753706824; c=relaxed/simple;
	bh=fsnnLn1UnfpY4C73Oqup7ToKbZWZvKEup6NpnHAehaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1C3aj+Ees22GR3jl+e4LjwRuv4ZODXUmHv62mdujKIRw+VSf+gly9gc+hC2WYo+CTpTsTHVuimYVFG3Q2XaU/zBTa3W74sjzFkhezZe4BPP7aryoQxjSI6q46CQzhb8HVb9Yucg4ShJw/MPy7NhX1Yr0n4k6Zc4rGMj9KWc2JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 6421411B2; Mon, 28 Jul 2025 07:47:00 -0500 (CDT)
Date: Mon, 28 Jul 2025 07:47:00 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	paul@paul-moore.com, serge@hallyn.com, jmorris@namei.org,
	dan.j.williams@intel.com
Subject: Re: [PATCH v2 1/3] lockdown: Switch implementation to using bitmap
Message-ID: <aIdxRBW7HyJMNvkh@mail.hallyn.com>
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

For the reviewer (including me), it would be good to have a comment here or at
top of fn to ease our minds that this is really what's meant:  So if we lock
down with reason LOCKDOWN_INTEGRITY_MAX, we want to set all bits up to
LOCKDOWN_INTEGRITY_MAX, which is not the whole array, and if setting
LOCKDOWN_CONFIDENTIALITY_MAX, then we want to set *all* bits, right?
So LOCKDOWN_CONFIDENTIALITY_MAX is a supserset of LOCKDOWN_INTEGRITY_MAX?

And for anything else, set the single bit.

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
