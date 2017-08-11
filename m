From: hch@lst.de (Christoph Hellwig)
Date: Fri, 11 Aug 2017 12:18:09 +0200
Subject: [PATCH v5 1/4] ima: always measure and audit files in policy
In-Reply-To: <1502408507-4257-2-git-send-email-zohar@linux.vnet.ibm.com>
References: <1502408507-4257-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1502408507-4257-2-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <20170811101809.GB11531@lst.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> +	i_version = file_inode(file)->i_version;

This probably wants a comment that i_version might be unreliable
unless the file system supports the change attribute.

> +	result = (!buf) ?  ima_calc_file_hash(file, &hash.hdr) :
> +		ima_calc_buffer_hash(buf, size, &hash.hdr);

Please write this like proper C code:

	if (buf)
		result = ima_calc_buffer_hash(buf, size, &hash.hdr);
	else
		result = ima_calc_file_hash(file, &hash.hdr);

> +++ b/security/integrity/ima/ima_crypto.c
> @@ -441,6 +441,16 @@ int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash)
>  	loff_t i_size;
>  	int rc;
>  
> +	/*
> +	 * O_DIRECT not supported for buffered read. For consistency,
> +	 * don't support O_DIRECT on DAX either.
> +	 */

I can't parse this - O_DIRECT is the opposite of a buffered I/O, including
reads.

> +	if ((rc == 0) && (action & IMA_APPRAISE_SUBMASK))

no need for the first set of inner braces.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
