From: wharms@bfs.de (walter harms)
Date: Tue, 23 May 2017 17:19:52 +0200
Subject: [PATCH] apparmor: Fix error cod in __aa_fs_profile_mkdir()
In-Reply-To: <20170523143346.GB28152@elgon.mountain>
References: <20170523143346.GB28152@elgon.mountain>
Message-ID: <59245318.4000809@bfs.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



Am 23.05.2017 16:33, schrieb Dan Carpenter:
> We can either return PTR_ERR(NULL) or a PTR_ERR(a valid pointer) here.
> Returning NULL is probably not good, but since this happens at boot
> then we are probably already toasted if we were to hit this bug in real
> life.  In other words, it seems like a very low severity bug to me.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index 4f6ac9dbc65d..18f0d105084d 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -728,8 +728,10 @@ int __aa_fs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
>  		id_len = snprintf(NULL, 0, ".%ld", profile->ns->uniq_id);
>  
>  		profile->dirname = kmalloc(len + id_len + 1, GFP_KERNEL);
> -		if (!profile->dirname)
> -			goto fail;
> +		if (!profile->dirname) {
> +			error = -ENOMEM;
> +			goto fail2;
> +		}
>  
>  		mangle_name(profile->base.name, profile->dirname);
>  		sprintf(profile->dirname + len, ".%ld", profile->ns->uniq_id++);

Can mangle_name made to return a propper string ?
IFF this can be reduced to
	profile->dirname =kasprintf(GFP_KERNEL,"%s.%ld",mangle_name(),profile->ns->uniq_id);
	if (!profile->dirname) ....

just a hint.

re,
 wh

> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
