From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 31 May 2018 11:00:39 -0400
Subject: [PATCH] EVM: prevent array underflow in evm_write_xattrs()
In-Reply-To: <20180529131128.3rkzzv66uy6h5ts7@kili.mountain>
References: <20180529131128.3rkzzv66uy6h5ts7@kili.mountain>
Message-ID: <1527778839.3427.14.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-05-29 at 16:11 +0300, Dan Carpenter wrote:
> If the user sets xattr->name[0] to NUL then we would read one character
> before the start of the array.  This bug seems harmless as far as I can
> see but perhaps it would trigger a warning in KASAN.
> 
> Fixes: fa516b66a1bf ("EVM: Allow runtime modification of the set of verified xattrs")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, this patch is now queued in the next-integrity branch.

Mimi

> ---
> The user can pass a zeroed buffer to memdup_user_nul() so we can't rely
> on "count" to test this.
> 
> diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
> index a7a0a1acae99..94c739180a0b 100644
> --- a/security/integrity/evm/evm_secfs.c
> +++ b/security/integrity/evm/evm_secfs.c
> @@ -207,7 +207,7 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
> 
>  	/* Remove any trailing newline */
>  	len = strlen(xattr->name);
> -	if (xattr->name[len-1] == '\n')
> +	if (len && xattr->name[len-1] == '\n')
>  		xattr->name[len-1] = '\0';
> 
>  	if (strcmp(xattr->name, ".") == 0) {
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
