From: why2jjj.linux@gmail.com (J Freyensee)
Date: Wed, 13 Jun 2018 10:55:32 -0700
Subject: [PATCH v3 2/2] tpm: add support for nonblocking operation
In-Reply-To: <152882631679.30206.9516257862583104447.stgit@tstruk-mobl1.jf.intel.com>
References: <152882630662.30206.8805136953394285180.stgit@tstruk-mobl1.jf.intel.com>
	<152882631679.30206.9516257862583104447.stgit@tstruk-mobl1.jf.intel.com>
Message-ID: <f2ed324e-8512-5ac1-7e5b-29943bbace53@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 6/12/18 10:58 AM, Tadeusz Struk wrote:
> Currently the TPM driver only supports blocking calls, which doesn't allow
> asynchronous IO operations to the TPM hardware.
> This patch changes it and adds support for nonblocking write and a new poll
> function to enable applications, which want to take advantage of this.
>
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
> ---
snip
.
.
.

> @@ -84,10 +124,9 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
>   			 size_t size, loff_t *off)
>   {
>   	struct file_priv *priv = file->private_data;
> -	size_t in_size = size;
> -	ssize_t out_size;
> +	int ret = 0;
>   
> -	if (in_size > TPM_BUFSIZE)
> +	if (size > TPM_BUFSIZE)
>   		return -E2BIG;
>   
>   	mutex_lock(&priv->buffer_mutex);
> @@ -97,20 +136,19 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
>   	 * buffered writes from blocking here.
>   	 */
>   	if (priv->data_pending != 0) {
> -		mutex_unlock(&priv->buffer_mutex);
> -		return -EBUSY;
> +		ret = -EBUSY;
> +		goto out;
>   	}
>   
> -	if (copy_from_user
> -	    (priv->data_buffer, (void __user *) buf, in_size)) {
> -		mutex_unlock(&priv->buffer_mutex);
> -		return -EFAULT;
> +	if (copy_from_user(priv->data_buffer, buf, size)) {
> +		ret = -EFAULT;
> +		goto out;
>   	}
>   
> -	if (in_size < 6 ||
> -	    in_size < be32_to_cpu(*((__be32 *) (priv->data_buffer + 2)))) {
> -		mutex_unlock(&priv->buffer_mutex);
> -		return -EINVAL;
> +	if (size < 6 ||
> +	    size < be32_to_cpu(*((__be32 *)(priv->data_buffer + 2)))) {
> +		ret = -EINVAL;
> +		goto out;
>   	}
>   
>   	/* atomic tpm command send and result receive. We only hold the ops
> @@ -118,25 +156,48 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
>   	 * the char dev is held open.
>   	 */
>   	if (tpm_try_get_ops(priv->chip)) {
> -		mutex_unlock(&priv->buffer_mutex);
> -		return -EPIPE;
> +		ret = -EPIPE;
> +		goto out;
>   	}
> -	out_size = tpm_transmit(priv->chip, priv->space, priv->data_buffer,
> -				sizeof(priv->data_buffer), 0);
>   
> -	tpm_put_ops(priv->chip);
> -	if (out_size < 0) {
> -		mutex_unlock(&priv->buffer_mutex);
> -		return out_size;
> +	/*
> +	 * If in nonblocking mode schedule an async job to send
> +	 * the command return the size.
> +	 * In case of error the err code will be returned in
> +	 * the subsequent read call.
> +	 */
> +	if (file->f_flags & O_NONBLOCK) {
> +		queue_work(tpm_dev_wq, &priv->async_work);
> +		return size;

Apologies for the question, but should there be a mutex_unlock() here?? 
It's about the only return statement I am seeing where I cannot tell if 
a mutex_unlock() will be called before return or is needed before 
return.? The rest of the code is pretty obvious the return statements 
are being re-factored to an out: block where the mutex_unlock() will 
always be called before returning.

Thanks,
Jay



--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
