From: john.johansen@canonical.com (John Johansen)
Date: Thu, 13 Jul 2017 13:22:31 -0700
Subject: [PATCH] apparmor: Fix an error code in aafs_create()
In-Reply-To: <20170713073920.tdhewrs2ggtxylfs@mwanda>
References: <20170713073920.tdhewrs2ggtxylfs@mwanda>
Message-ID: <46c023ef-98e2-bf4f-4da3-9c6237d3f3de@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 07/13/2017 12:39 AM, Dan Carpenter wrote:
> We accidentally forgot to set the error code on this path.  It means we
> return NULL instead of an error pointer.  I looked through a bunch of
> callers and I don't think it really causes a big issue, but the
> documentation says we're supposed to return error pointers here.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
Acked-by: John Johansen <john.johansen@canonical.com>

I've pulled it into my tree

> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index 853c2ec8e0c9..2caeb748070c 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -248,8 +248,10 @@ static struct dentry *aafs_create(const char *name, umode_t mode,
>  
>  	inode_lock(dir);
>  	dentry = lookup_one_len(name, parent, strlen(name));
> -	if (IS_ERR(dentry))
> +	if (IS_ERR(dentry)) {
> +		error = PTR_ERR(dentry);
>  		goto fail_lock;
> +	}
>  
>  	if (d_really_is_positive(dentry)) {
>  		error = -EEXIST;
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
