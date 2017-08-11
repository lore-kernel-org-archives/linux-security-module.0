From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 11 Aug 2017 09:20:06 -0400
Subject: [PATCH v5 2/4] ima: use fs method to read integrity data
In-Reply-To: <20170811102113.GC11531@lst.de>
References: <1502408507-4257-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1502408507-4257-3-git-send-email-zohar@linux.vnet.ibm.com>
	<20170811102113.GC11531@lst.de>
Message-ID: <1502457606.3579.87.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2017-08-11 at 12:21 +0200, Christoph Hellwig wrote:
> On Thu, Aug 10, 2017 at 07:41:45PM -0400, Mimi Zohar wrote:
> > From: Christoph Hellwig <hch@lst.de>
> > 
> > Add a new ->integrity_read file operation to read data for integrity
> > hash collection.  This is defined to be equivalent to ->read_iter,
> > except that it will be called with the i_rwsem held exclusively.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Btw, most of this is yours now, feel free to take over the authorship
> with a little credit to me for the initial patch if you want.

Thank you so much for the initial design and patch!

> > Cc: Matthew Garrett <matthew.garrett@nebula.com>
> 
> I don't think that will reach Matthew anymore :)

Trying his other address as listed in MAINTAINERS.

> 
> > -static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
> > -		size_t count, loff_t *ppos)
> > +static ssize_t efivarfs_file_read_iter(struct kiocb *iocb,
> > +				       struct iov_iter *iter)
> 
> The efivars switch to read_iter should be a separate patch before
> this one.

Agreed

> >  /**
> > + * simple_read_iter_from_buffer - copy data from the buffer to user space
> > + * @iocb: struct containing the file, the current position and other info
> > + * @to: the user space buffer to read to
> > + * @from: the buffer to read from
> > + * @available: the size of the buffer
> > + *
> > + * The simple_read_iter_from_buffer() function reads up to @available bytes
> > + * from the current buffer into the user space buffer.
> > + *
> > + * On success, the current buffer offset is advanced by the number of bytes
> > + * read, or a negative value is returned on error.
> > + **/
> > +ssize_t simple_read_iter_from_buffer(struct kiocb *iocb, struct iov_iter *to,
> > +				     const void *from, size_t available)
> 
> The addition of simple_read_iter_from_buffer should be another separate
> patch, before efivars starts using it.

Agreed

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
