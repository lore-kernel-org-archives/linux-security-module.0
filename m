From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 31 May 2018 11:00:22 -0400
Subject: [PATCH][next] EVM: fix memory leak of temporary buffer 'temp'
In-Reply-To: <20180527221502.25073-1-colin.king@canonical.com>
References: <20180527221502.25073-1-colin.king@canonical.com>
Message-ID: <1527778822.3427.13.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, 2018-05-27 at 23:15 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The allocation of 'temp' is not kfree'd and hence there is a memory
> leak on each call of evm_read_xattrs.  Fix this by kfree'ing it
> after copying data from it back to the user space buffer 'buf'.
> 
> Detected by CoverityScan, CID#1469386 ("Resource Leak")
> 
> Fixes: fa516b66a1bf ("EVM: Allow runtime modification of the set of verified xattrs")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, this patch and "EVM: Fix null dereference on xattr when xattr
fails to allocate" are queued in the next-integrity branch.

Mimi

> ---
>  security/integrity/evm/evm_secfs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
> index a7a0a1acae99..fb8bc950aceb 100644
> --- a/security/integrity/evm/evm_secfs.c
> +++ b/security/integrity/evm/evm_secfs.c
> @@ -158,6 +158,8 @@ static ssize_t evm_read_xattrs(struct file *filp, char __user *buf,
>  	mutex_unlock(&xattr_list_mutex);
>  	rc = simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
> 
> +	kfree(temp);
> +
>  	return rc;
>  }
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
