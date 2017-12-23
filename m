From: serge@hallyn.com (Serge E. Hallyn)
Date: Fri, 22 Dec 2017 22:03:48 -0600
Subject: [PATCH 11/11] evm: Don't update hmacs in user ns mounts
In-Reply-To: <1f2233a1a028f1eb1e9bea7d06efa6d34e69e752.1512041070.git.dongsu@kinvolk.io>
References: <cover.1512741134.git.dongsu@kinvolk.io>
	<1f2233a1a028f1eb1e9bea7d06efa6d34e69e752.1512041070.git.dongsu@kinvolk.io>
Message-ID: <20171223040348.GK6837@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Dec 22, 2017 at 03:32:35PM +0100, Dongsu Park wrote:
> From: Seth Forshee <seth.forshee@canonical.com>
> 
> The kernel should not calculate new hmacs for mounts done by
> non-root users. Update evm_calc_hmac_or_hash() to refuse to
> calculate new hmacs for mounts for non-init user namespaces.
> 
> Cc: linux-integrity at vger.kernel.org
> Cc: linux-security-module at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: James Morris <james.l.morris@oracle.com>
> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>

Hi Mimi,

does this change seem sufficient to you?

> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> Signed-off-by: Dongsu Park <dongsu@kinvolk.io>
> ---
>  security/integrity/evm/evm_crypto.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> index bcd64baf..729f4545 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -190,7 +190,8 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
>  	int error;
>  	int size;
>  
> -	if (!(inode->i_opflags & IOP_XATTR))
> +	if (!(inode->i_opflags & IOP_XATTR) ||
> +	    inode->i_sb->s_user_ns != &init_user_ns)
>  		return -EOPNOTSUPP;
>  
>  	desc = init_desc(type);
> -- 
> 2.13.6
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
