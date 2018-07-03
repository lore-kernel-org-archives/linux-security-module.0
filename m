From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 03 Jul 2018 09:13:47 -0400
Subject: [PATCH] ima: Remove unused is_ima_appraise_enabled() function.
In-Reply-To: <20180703111917.3265212-1-stefanb@linux.vnet.ibm.com>
References: <20180703111917.3265212-1-stefanb@linux.vnet.ibm.com>
Message-ID: <1530623627.3452.31.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-07-03 at 07:19 -0400, Stefan Berger wrote:
> Remove the unused is_ima_appraise_enabled() function.

is_ima_appraise_enabled() was introduced to coordinate between IMA and
the lockdown patch set. ?Before removing it, let's wait and see if it
is still needed by the lockdown patches.

Mimi

> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  include/linux/ima.h                   |  6 ------
>  security/integrity/ima/ima_appraise.c | 10 ----------
>  2 files changed, 16 deletions(-)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 0e4647e0eb60..7f6952f8d6aa 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -75,17 +75,11 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
>  #endif
> 
>  #ifdef CONFIG_IMA_APPRAISE
> -extern bool is_ima_appraise_enabled(void);
>  extern void ima_inode_post_setattr(struct dentry *dentry);
>  extern int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
>  		       const void *xattr_value, size_t xattr_value_len);
>  extern int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name);
>  #else
> -static inline bool is_ima_appraise_enabled(void)
> -{
> -	return 0;
> -}
> -
>  static inline void ima_inode_post_setattr(struct dentry *dentry)
>  {
>  	return;
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 8bd7a0733e51..7bf7fcacfdbb 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -33,16 +33,6 @@ static int __init default_appraise_setup(char *str)
> 
>  __setup("ima_appraise=", default_appraise_setup);
> 
> -/*
> - * is_ima_appraise_enabled - return appraise status
> - *
> - * Only return enabled, if not in ima_appraise="fix" or "log" modes.
> - */
> -bool is_ima_appraise_enabled(void)
> -{
> -	return ima_appraise & IMA_APPRAISE_ENFORCE;
> -}
> -
>  /*
>   * ima_must_appraise - set appraise flag
>   *

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
