From: serge@hallyn.com (Serge E. Hallyn)
Date: Wed, 22 Aug 2018 08:58:25 -0500
Subject: [PATCH v1] security/capabilities: remove check for -EINVAL
In-Reply-To: <20180822115240.18196-1-christian@brauner.io>
References: <20180822115240.18196-1-christian@brauner.io>
Message-ID: <20180822135825.GA7223@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Christian Brauner (christian at brauner.io):
> bprm_caps_from_vfs_caps() never returned -EINVAL so remove the
> rc == -EINVAL check.
> 
> Signed-off-by: Christian Brauner <christian@brauner.io>

Thanks.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
> v0 -> v1
> - non-functional changes:
>   adapt commit message to reflect the fact that
>   bprm_caps_from_vfs_caps() never actuall returned -EINVAL.
> ---
>  security/commoncap.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index f4c33abd9959..6012f0cd8157 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -684,9 +684,6 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_f
>  	}
>  
>  	rc = bprm_caps_from_vfs_caps(&vcaps, bprm, effective, has_fcap);
> -	if (rc == -EINVAL)
> -		printk(KERN_NOTICE "%s: cap_from_disk returned %d for %s\n",
> -		       __func__, rc, bprm->filename);
>  
>  out:
>  	if (rc)
> -- 
> 2.17.1
