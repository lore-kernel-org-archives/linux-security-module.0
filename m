From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Mon, 06 Aug 2018 16:05:48 -0700
Subject: [PATCH v3 RESEND 2/2] tpm: add support for nonblocking operation
In-Reply-To: <153359005823.27531.1050952672299708433.stgit@tstruk-mobl1.jf.intel.com>
References: <153358975874.26901.16081444242758666628.stgit@tstruk-mobl1.jf.intel.com>
	<153359005823.27531.1050952672299708433.stgit@tstruk-mobl1.jf.intel.com>
Message-ID: <1533596748.3159.19.camel@HansenPartnership.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2018-08-06 at 14:14 -0700, Tadeusz Struk wrote:
[...]
> +static void tpm_async_work(struct work_struct *work)
> +{
> +	struct file_priv *priv =
> +			container_of(work, struct file_priv,
> async_work);
> +	ssize_t ret;
> +
> +	ret = tpm_transmit(priv->chip, priv->space, priv-
> >data_buffer,
> +			???sizeof(priv->data_buffer), 0);

Here' you assume the buffer_mutex was taken in write, which is done
(see below).  However, here, since there was no change to tpm_transmit,
you'll sleep in the context of the worker queue waiting for the command
to complete and return.

> +	tpm_put_ops(priv->chip);
> +	if (ret > 0) {
> +		priv->data_pending = ret;
> +		mod_timer(&priv->user_read_timer, jiffies + (120 *
> HZ));
> +	}
> +	mutex_unlock(&priv->buffer_mutex);

But you don't release buffer_mutex here until the tpm command has
completed.

> +	wake_up_interruptible(&priv->async_wait);
> +}
> +

[...]
> @@ -118,25 +155,48 @@ ssize_t tpm_common_write(struct file *file,
> const char __user *buf,
> ?	?* the char dev is held open.
> ?	?*/
> ?	if (tpm_try_get_ops(priv->chip)) {
> -		mutex_unlock(&priv->buffer_mutex);
> -		return -EPIPE;
> +		ret = -EPIPE;
> +		goto out;
> ?	}
> -	out_size = tpm_transmit(priv->chip, priv->space, priv-
> >data_buffer,
> -				sizeof(priv->data_buffer), 0);
> ?
> -	tpm_put_ops(priv->chip);
> -	if (out_size < 0) {
> -		mutex_unlock(&priv->buffer_mutex);
> -		return out_size;
> +	/*
> +	?* If in nonblocking mode schedule an async job to send
> +	?* the command return the size.
> +	?* In case of error the err code will be returned in
> +	?* the subsequent read call.
> +	?*/
> +	if (file->f_flags & O_NONBLOCK) {
> +		queue_work(tpm_dev_wq, &priv->async_work);
> +		return size;

Here you return holding the buffer_mutex, waiting for tpm_async_work to
release it.

But now I've written my tpm work item and got it queued, I can't write
another one without blocking on the buffer_mutex at the top of
tpm_common_write(), and since that doesn't get released until the
previous command completed, I can only queue one command before I
block.  For an async interface, shouldn't I be able to queue an
arbitrary number of commands without blocking?

James

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
