From: serge@hallyn.com (Serge E. Hallyn)
Date: Wed, 11 Jul 2018 10:15:10 -0500
Subject: [PATCH -next] EVM: fix return value check in evm_write_xattrs()
In-Reply-To: <1531315720-4191-1-git-send-email-weiyongjun1@huawei.com>
References: <1531315720-4191-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <20180711151510.GA23645@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Wei Yongjun (weiyongjun1 at huawei.com):
> In case of error, the function audit_log_start() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check should be
> replaced with NULL test.
> 
> Fixes: fa516b66a1bf ("EVM: Allow runtime modification of the set of verified xattrs")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/integrity/evm/evm_secfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
> index 637eb99..77de71b 100644
> --- a/security/integrity/evm/evm_secfs.c
> +++ b/security/integrity/evm/evm_secfs.c
> @@ -193,8 +193,8 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
>  		return -E2BIG;
>  
>  	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_EVM_XATTR);
> -	if (IS_ERR(ab))
> -		return PTR_ERR(ab);
> +	if (!ab)
> +		return -ENOMEM;
>  
>  	xattr = kmalloc(sizeof(struct xattr_list), GFP_KERNEL);
>  	if (!xattr) {
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
