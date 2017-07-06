From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Thu, 6 Jul 2017 13:45:59 +0100
Subject: [RFC PATCH] efivarfs: define integrity_read method
In-Reply-To: <1499343241.5500.15.camel@linux.vnet.ibm.com>
References: <1499343241.5500.15.camel@linux.vnet.ibm.com>
Message-ID: <20170706124559.GO10672@ZenIV.linux.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Jul 06, 2017 at 08:14:01AM -0400, Mimi Zohar wrote:
> This patch defines an ->integrity_read file operation method to read data for
> integrity hash collection.

> -static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
> -		size_t count, loff_t *ppos)
> +static ssize_t __efivarfs_file_read(struct file *file, char __user *userbuf,
> +				    size_t count, loff_t *ppos,
> +				    struct iov_iter *iter)
>  {
>  	struct efivar_entry *var = file->private_data;
>  	unsigned long datasize = 0;
> @@ -96,14 +98,32 @@ static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
>  		goto out_free;
>  
>  	memcpy(data, &attributes, sizeof(attributes));
> -	size = simple_read_from_buffer(userbuf, count, ppos,
> -				       data, datasize + sizeof(attributes));
> +
> +	if (!iter)
> +		size = simple_read_from_buffer(userbuf, count, ppos, data,
> +					       datasize + sizeof(attributes));
> +	else
> +		size = copy_to_iter(data, datasize + sizeof(attributes), iter);

Egads...  This kind of kludges is too ugly to exist.  What the hell for?  If you
want to define something that looks like ->read_iter(), bloody make it proper
read_iter.  Really working one, that is - without this "our oh-so-special needs
do not include file position" crap.

Seriously, this kind of calling conventions alone is enough for a NAK with
extreme prejudice.  Something like
ssize_t simple_read_iter_from_buffer(struct kiocb *iocb, struct iov_iter *to,
                                const void *from, size_t available)
{
        loff_t pos = iocb->ki_pos;
        size_t ret;

        if (pos < 0)
                return -EINVAL;
        if (pos >= available)
                return 0;
        ret = copy_to_iter(to, from + pos, available - pos);
        if (!ret && iov_iter_count(to))
                return -EFAULT;
        iocb->ki_pos = pos + ret;
        return ret;
}
EXPORT_SYMBOL(simple_read_iter_from_buffer);

in fs/libfs.c and turn the efivarfs_file_read() into a real ->read_iter() by
replacing simple_read_from_buffer to simple_read_iter_from_buffer (and adjusting
the arguments, of course).  All there is to it.  Sheesh...
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
