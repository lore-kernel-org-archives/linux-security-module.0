From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 11 Aug 2017 08:34:22 -0400
Subject: [PATCH v5 1/4] ima: always measure and audit files in policy
In-Reply-To: <20170811101809.GB11531@lst.de>
References: <1502408507-4257-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1502408507-4257-2-git-send-email-zohar@linux.vnet.ibm.com>
	<20170811101809.GB11531@lst.de>
Message-ID: <1502454862.3579.65.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2017-08-11 at 12:18 +0200, Christoph Hellwig wrote:
> > +	i_version = file_inode(file)->i_version;
> 
> This probably wants a comment that i_version might be unreliable
> unless the file system supports the change attribute.
> 
> > +	result = (!buf) ?  ima_calc_file_hash(file, &hash.hdr) :
> > +		ima_calc_buffer_hash(buf, size, &hash.hdr);
> 
> Please write this like proper C code:
> 
> 	if (buf)
> 		result = ima_calc_buffer_hash(buf, size, &hash.hdr);
> 	else
> 		result = ima_calc_file_hash(file, &hash.hdr);

Sure

> 
> > +++ b/security/integrity/ima/ima_crypto.c
> > @@ -441,6 +441,16 @@ int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash)
> >  	loff_t i_size;
> >  	int rc;
> >  
> > +	/*
> > +	 * O_DIRECT not supported for buffered read. For consistency,
> > +	 * don't support O_DIRECT on DAX either.
> > +	 */
> 
> I can't parse this - O_DIRECT is the opposite of a buffered I/O, including
> reads.

Right. I'm trying to differentiate between a file opened with the
O_DIRECT flag on a filesystem mounted with/without DAX. ?For
consistency, it was recommended to fail both.

> 
> > +	if ((rc == 0) && (action & IMA_APPRAISE_SUBMASK))
> 
> no need for the first set of inner braces.

thanks,

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
