From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Tue, 7 Aug 2018 12:20:13 -0600
Subject: [PATCH v3 RESEND 2/2] tpm: add support for nonblocking operation
In-Reply-To: <1533596748.3159.19.camel@HansenPartnership.com>
References: <153358975874.26901.16081444242758666628.stgit@tstruk-mobl1.jf.intel.com>
	<153359005823.27531.1050952672299708433.stgit@tstruk-mobl1.jf.intel.com>
	<1533596748.3159.19.camel@HansenPartnership.com>
Message-ID: <20180807182013.GC4960@ziepe.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Aug 06, 2018 at 04:05:48PM -0700, James Bottomley wrote:

> > @@ -118,25 +155,48 @@ ssize_t tpm_common_write(struct file *file,
> > const char __user *buf,
> > ?	?* the char dev is held open.
> > ?	?*/
> > ?	if (tpm_try_get_ops(priv->chip)) {
> > -		mutex_unlock(&priv->buffer_mutex);
> > -		return -EPIPE;
> > +		ret = -EPIPE;
> > +		goto out;
> > ?	}
> > -	out_size = tpm_transmit(priv->chip, priv->space, priv-
> > >data_buffer,
> > -				sizeof(priv->data_buffer), 0);
> > ?
> > -	tpm_put_ops(priv->chip);
> > -	if (out_size < 0) {
> > -		mutex_unlock(&priv->buffer_mutex);
> > -		return out_size;
> > +	/*
> > +	?* If in nonblocking mode schedule an async job to send
> > +	?* the command return the size.
> > +	?* In case of error the err code will be returned in
> > +	?* the subsequent read call.
> > +	?*/
> > +	if (file->f_flags & O_NONBLOCK) {
> > +		queue_work(tpm_dev_wq, &priv->async_work);
> > +		return size;
> 
> Here you return holding the buffer_mutex, waiting for tpm_async_work to
> release it.

Doesn't lockdep complain when locks are left held after returning to
user space? Even if it doesn't, that is a pretty ugly thing to do.

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
