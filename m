Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13BD1514F6;
	Fri, 21 Mar 2025 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589282; cv=none; b=uv134ij3bMm3Ea/1fBZA7CdHR5wk5GX8Z0eNHofPRk8HhGvMunPOtF9mfXoZKlRUbFVGJkFbOdhIW/ilHb2VzYA2sDd8EeDfBesoBGrLjPIEEWX6lCxBeZSNtkp2OQEqJUUfKSsehAmf0runC5dQIyNnobPPlWxRm+zNH61YLng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589282; c=relaxed/simple;
	bh=ESuQxc1uo2rrbnn2JcOtucq5e7Bg+IxPDoWM/kKHcd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pd/byEfQpbl2a1QIqp94mtDFGIZcBtfJq0LqigbXhKyZP6g0mf3ZN1ATvxzP9RiNe35sPsXTOJpzFqiJgBAzxhxS2QXPiV+VMMXwFeJzR2qzNeGFALv4Bf1sl9YI9A2pdB4zDCG1GaUhZA0h/bv1UELYxVHVwD5mlkdYDfhCFus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzFWRekB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzFWRekB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADECAC4CEEA;
	Fri, 21 Mar 2025 20:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742589280;
	bh=ESuQxc1uo2rrbnn2JcOtucq5e7Bg+IxPDoWM/kKHcd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rzFWRekBJPwEGvbHtbrGUGtb8eplO2ree3EZf/OaCNzl5PY0Q/KAtSvAdXH+GtNAm
	 T5A1Wtw1W2QZV0vBTiWfXF1ggx8kkylGKo7ElOdNQdD/hN1PPkpSR5+atMHpaFWhL5
	 a6YkRlGyRn4TX/5C/0pNt6GQHiVeaQA/GcRvc9bhPasSSiKuW6pE5DyNBGOaqFeHDK
	 Mw1W5EgxwAQ2lHU7NU5STndVPhO2nnnhVa0einiOVStpAicC5+F4DxYQM2UNRl3k9s
	 p+Xssx8WC50e3srHz7eJu3abIHa5RgTOVVZJOydi3Zn83tVZ4+eS9Poo5Wok3hguRb
	 re9bmBDf/ovaQ==
Date: Fri, 21 Mar 2025 20:34:35 +0000
From: sergeh@kernel.org
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-security-module@vger.kernel.org, paul@paul-moore.com,
	serge@hallyn.com, kees@kernel.org, linux-kernel@vger.kernel.org,
	kirill.shutemov@linux.intel.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH 1/2] lockdown: Switch implementation to using bitmap
Message-ID: <Z93NW3za1ilzVxLK@lei>
References: <20250321102422.640271-1-nik.borisov@suse.com>
 <20250321102422.640271-2-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321102422.640271-2-nik.borisov@suse.com>

On Fri, Mar 21, 2025 at 12:24:20PM +0200, Nikolay Borisov wrote:
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

Reviewed-by: Serge Hallyn <sergeh@kernel.org>

but one comment below

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

Context here is:

static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,
                             loff_t *ppos)
{
        char temp[80] = "";
        int i, offset = 0;

        for (i = 0; i < ARRAY_SIZE(lockdown_levels); i++) {
                enum lockdown_reason level = lockdown_levels[i];

...

>  		if (lockdown_reasons[level]) {
>  			const char *label = lockdown_reasons[level];
>  
> -			if (kernel_locked_down == level)
> +			if (test_bit(level, kernel_locked_down))

Right now this is still just looping over the lockdown_levels, and so
it can't get longer than "none [integrity] [confidentiality]" which fits
easily into the 80 chars of temp.  But I'm worried that someone will
change this loop i a way that violates that.  Could you just switch
this to a snprintf that checks its result for < 0 and >= n , or some
other sanity check?

>  				offset += sprintf(temp+offset, "[%s] ", label);
>  			else
>  				offset += sprintf(temp+offset, "%s ", label);
> -- 
> 2.43.0
> 
