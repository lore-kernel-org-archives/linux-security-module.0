From: jmorris@namei.org (James Morris)
Date: Wed, 2 May 2018 04:34:24 +1000 (AEST)
Subject: [PATCH v7 1/6] security: Move LSM registration arguments to
	struct lsm_info
In-Reply-To: <4184e7f3f244968a4fa411b8b91842665f317202.1524645853.git.sargun@sargun.me>
References: <cover.1524645853.git.sargun@sargun.me>
	<4184e7f3f244968a4fa411b8b91842665f317202.1524645853.git.sargun@sargun.me>
Message-ID: <alpine.LRH.2.21.1805020429470.7512@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 25 Apr 2018, Sargun Dhillon wrote:

> +	/* This field is not currently in use */
> +	struct lsm_info			*info;

It does seem to be in use.

>  static const struct file_operations lsm_ops = {
> -	.read = lsm_read,
> -	.llseek = generic_file_llseek,
> +	.open		= lsm_ops_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= seq_release,
>  };

Please mention this change in the changelog, or probably better, make it a 
separate patch.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
