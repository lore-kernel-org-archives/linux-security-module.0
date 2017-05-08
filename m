From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 08 May 2017 11:44:35 -0400
Subject: [PATCH] ima: use memdup_user_nul
In-Reply-To: <044d541d7d33c997f9661ae625d1374bc1e5dab8.1493782979.git.geliangtang@gmail.com>
References: <6baf3aa45d0b5e0fd016b508bac905ebf8443aac.1493779294.git.geliangtang@gmail.com>
	<044d541d7d33c997f9661ae625d1374bc1e5dab8.1493782979.git.geliangtang@gmail.com>
Message-ID: <1494258275.5871.1.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 2017-05-06 at 23:40 +0800, Geliang Tang wrote:
> Use memdup_user_nul() helper instead of open-coding to simplify the
> code.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Thanks, this patch will be queued.

Mimi

> ---
>  security/integrity/ima/ima_fs.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index ca303e5..ad491c5 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -323,16 +323,11 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
>  	if (*ppos != 0)
>  		goto out;
> 
> -	result = -ENOMEM;
> -	data = kmalloc(datalen + 1, GFP_KERNEL);
> -	if (!data)
> +	data = memdup_user_nul(buf, datalen);
> +	if (IS_ERR(data)) {
> +		result = PTR_ERR(data);
>  		goto out;
> -
> -	*(data + datalen) = '\0';
> -
> -	result = -EFAULT;
> -	if (copy_from_user(data, buf, datalen))
> -		goto out_free;
> +	}
> 
>  	result = mutex_lock_interruptible(&ima_write_mutex);
>  	if (result < 0)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
