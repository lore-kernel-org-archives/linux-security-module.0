Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C8A3277AF;
	Mon, 22 Dec 2025 23:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766445172; cv=none; b=obO7mz+oVrLPpDRJhnRlQL3rIsHnUgSSq+6BdH2l9fQBo7yH908m6YF+8KbqGVmKMz5IqVB8htGIyLqVXv5NgJ/q5v07TkC3ZtdfsCoTIBzhnzuA9P+cLa+QILvuJATYSeOzSB4V9WSgexv0mcM/WDmwjw+wZC2Qmo5gpETsMys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766445172; c=relaxed/simple;
	bh=dcbk2iMhEByZLNLsC/JFL//pNqneePUFeJBLzl7wc6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=do/SER9ECsDO4hXLU1q4DDATaIVV+m8kftnseo/na6TQKDI/Qw2ZXu3hdJPwG8jUsG2rNrE/33nb/Q1wpBitP2Xsp+K3FaHR8by9M8d39dacfv5P9W9Do1Aq+HNoTwR2ZtXnrcbP+DAQ2y8sRKQk0zcMP0GA9y2pvKJHBBObFSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8yUbWc2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8yUbWc2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2F6C116C6;
	Mon, 22 Dec 2025 23:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766445170;
	bh=dcbk2iMhEByZLNLsC/JFL//pNqneePUFeJBLzl7wc6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8yUbWc2tWxamWTdvvTPAaQ/b2UXT2IVyoB1W1FtNYZKvuuc2H12BFPVMvKs4YHff
	 1Q5oUqh09ZWil2p5FbqKyTX60n3HriaYEUCoRKEeK7e1GRikboExl7ZlbAhVs9gVaE
	 CdR0asRVdvOOp4wYvJU1mVUrqOSW/rGHTs4B5nERvGN/duSSq+oaAy5DS9+PHzbycG
	 KAJPDBgZ/X+GFrWjyT0cf0oRIvFNp3Vc8/wsTPxdTWkY6cw6yvM4sgGMy1xJaiMWIj
	 erCLrgJhckeOySBGV1GcueBZytPV562HSEv9QQdp3ygToGXd/KH6RbsWjKHW1x4m98
	 Xve2adY6vgHlw==
Date: Mon, 22 Dec 2025 15:12:49 -0800
From: Kees Cook <kees@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] loadpin: Implement custom proc_handler for enforce
Message-ID: <202512221511.603BF6E3@keescook>
References: <20251222-jag-const_loadpin-v3-1-6463c440fb90@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222-jag-const_loadpin-v3-1-6463c440fb90@kernel.org>

On Mon, Dec 22, 2025 at 11:36:35PM +0100, Joel Granados wrote:
> Add a new static variable (loadpin_root_writable) to keep the
> write-ability state of enforce. Remove set_sysctl and const qualify
> loadpin_sysctl_table (moves into .rodata) as there is no longer need to
> change the value of extra1. The new proc_handler_loadpin returns -EINVAL
> when loadpin_root_writable is false and the kernel var (enforce) is
> being written. The old way of modifying the write-ability of enforce
> stayes in loadpin_check and is still set by calling sb_is_writable.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>
> ---
> Const qualifying ctl tables is part of the hardening effort in the linux
> kernel.
> 
> Changes in v3:
> - Fix compilation for CONFIG_SYSCTL=n
> - Link to v2: https://lore.kernel.org/r/20251219-jag-const_loadpin-v2-1-a1490ab35a1d@kernel.org
> 
> Changes in v2:
> - Removed set_sysctl
> - Added new static loadpin_root_writable var to hold the writable state
> - Renamed the variable holding the writable state to loadpin_root_writable
> - Link to v1: https://lore.kernel.org/r/20251215-jag-const_loadpin-v1-1-6842775f4e90@kernel.org
> ---
> Signed-off-by: Joel Granados <joel.granados@kernel.org>
> ---
>  security/loadpin/loadpin.c | 43 +++++++++++++++++++------------------------
>  1 file changed, 19 insertions(+), 24 deletions(-)
> 
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index 273ffbd6defe1324d6688dec5f9fe6c9401283ed..a6c7e4bfa45d3568e8c36e184388ee7858ba022e 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -52,45 +52,42 @@ static DEFINE_SPINLOCK(pinned_root_spinlock);
>  static bool deny_reading_verity_digests;
>  #endif
>  
> +static bool loadpin_root_writable;
>  #ifdef CONFIG_SYSCTL
> -static struct ctl_table loadpin_sysctl_table[] = {
> +// initialized to false
> +
> +static int proc_handler_loadpin(const struct ctl_table *table, int dir,
> +				void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	if (!loadpin_root_writable && SYSCTL_USER_TO_KERN(dir))
> +		return -EINVAL;
> +	return proc_dointvec_minmax(table, dir, buffer, lenp, ppos);
> +}
> +
> +static const struct ctl_table loadpin_sysctl_table[] = {
>  	{
>  		.procname       = "enforce",
>  		.data           = &enforce,
>  		.maxlen         = sizeof(int),
>  		.mode           = 0644,
> -		.proc_handler   = proc_dointvec_minmax,
> -		.extra1         = SYSCTL_ONE,
> +		.proc_handler   = proc_handler_loadpin,
> +		.extra1         = SYSCTL_ZERO,
>  		.extra2         = SYSCTL_ONE,
>  	},
>  };
> -
> -static void set_sysctl(bool is_writable)
> -{
> -	/*
> -	 * If load pinning is not enforced via a read-only block
> -	 * device, allow sysctl to change modes for testing.
> -	 */
> -	if (is_writable)
> -		loadpin_sysctl_table[0].extra1 = SYSCTL_ZERO;
> -	else
> -		loadpin_sysctl_table[0].extra1 = SYSCTL_ONE;
> -}
> -#else
> -static inline void set_sysctl(bool is_writable) { }
>  #endif
>  
> -static void report_writable(struct super_block *mnt_sb, bool writable)
> +static void report_writable(struct super_block *mnt_sb)
>  {
>  	if (mnt_sb->s_bdev) {
>  		pr_info("%pg (%u:%u): %s\n", mnt_sb->s_bdev,
>  			MAJOR(mnt_sb->s_bdev->bd_dev),
>  			MINOR(mnt_sb->s_bdev->bd_dev),
> -			writable ? "writable" : "read-only");
> +			loadpin_root_writable ? "writable" : "read-only");
>  	} else
>  		pr_info("mnt_sb lacks block device, treating as: writable\n");
>  
> -	if (!writable)
> +	if (!loadpin_root_writable)
>  		pr_info("load pinning engaged.\n");
>  }
>  
> @@ -131,7 +128,6 @@ static int loadpin_check(struct file *file, enum kernel_read_file_id id)
>  	struct super_block *load_root;
>  	const char *origin = kernel_read_file_id_str(id);
>  	bool first_root_pin = false;
> -	bool load_root_writable;
>  
>  	/* If the file id is excluded, ignore the pinning. */
>  	if ((unsigned int)id < ARRAY_SIZE(ignore_read_file_id) &&
> @@ -152,7 +148,6 @@ static int loadpin_check(struct file *file, enum kernel_read_file_id id)
>  	}
>  
>  	load_root = file->f_path.mnt->mnt_sb;
> -	load_root_writable = sb_is_writable(load_root);
>  
>  	/* First loaded module/firmware defines the root for all others. */
>  	spin_lock(&pinned_root_spinlock);
> @@ -168,8 +163,8 @@ static int loadpin_check(struct file *file, enum kernel_read_file_id id)
>  	spin_unlock(&pinned_root_spinlock);
>  
>  	if (first_root_pin) {
> -		report_writable(pinned_root, load_root_writable);
> -		set_sysctl(load_root_writable);
> +		report_writable(pinned_root);
> +		loadpin_root_writable = sb_is_writable(pinned_root);

The report_writable() has to follow the assignment of
loadpin_root_writable. Let's leave the "writable" argument in place for
report_writable(), which would have made this more obvious.

-Kees

>  		report_load(origin, file, "pinned");
>  	}
>  
> 
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251215-jag-const_loadpin-761f052f76c4
> 
> Best regards,
> -- 
> Joel Granados <joel.granados@kernel.org>
> 
> 

-- 
Kees Cook
