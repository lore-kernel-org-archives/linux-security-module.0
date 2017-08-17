From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 17 Aug 2017 11:43:30 -0400
Subject: [PATCH v4 7/7] ima: Support module-style appended signatures
	for appraisal
In-Reply-To: <20170804220330.30026-8-bauerman@linux.vnet.ibm.com>
References: <20170804220330.30026-1-bauerman@linux.vnet.ibm.com>
	<20170804220330.30026-8-bauerman@linux.vnet.ibm.com>
Message-ID: <1502984610.3172.41.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 87d2b601cf8e..5a244ebc61d9 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -190,6 +190,64 @@ int ima_read_xattr(struct dentry *dentry,
>  	return ret;
>  }
> 
> +static void process_xattr_error(int rc, struct integrity_iint_cache *iint,
> +				int opened, char const **cause,
> +				enum integrity_status *status)
> +{
> +	if (rc && rc != -ENODATA)
> +		return;
> +
> +	*cause = iint->flags & IMA_DIGSIG_REQUIRED ?
> +		"IMA-signature-required" : "missing-hash";
> +	*status = INTEGRITY_NOLABEL;
> +
> +	if (opened & FILE_CREATED)
> +		iint->flags |= IMA_NEW_FILE;
> +
> +	if ((iint->flags & IMA_NEW_FILE) &&
> +	    !(iint->flags & IMA_DIGSIG_REQUIRED))
> +		*status = INTEGRITY_PASS;
> +}
> +
> +static int appraise_modsig(struct integrity_iint_cache *iint,
> +			   struct evm_ima_xattr_data *xattr_value,
> +			   int xattr_len)
> +{
> +	enum hash_algo algo;
> +	const void *digest;
> +	void *buf;
> +	int rc, len;
> +	u8 dig_len;
> +
> +	rc = ima_modsig_verify(INTEGRITY_KEYRING_IMA, xattr_value);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * The signature is good. Now let's put the sig hash
> +	 * into the iint cache so that it gets stored in the
> +	 * measurement list.
> +	 */
> +
> +	rc = ima_get_modsig_hash(xattr_value, &algo, &digest, &dig_len);
> +	if (rc)
> +		return rc;
> +
> +	len = sizeof(iint->ima_hash) + dig_len;
> +	buf = krealloc(iint->ima_hash, len, GFP_NOFS);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	iint->ima_hash = buf;
> +	iint->flags |= IMA_DIGSIG;
> +	iint->ima_hash->algo = algo;
> +	iint->ima_hash->length = dig_len;
> +
> +	memcpy(iint->ima_hash->digest, digest, dig_len);
> +
> +	return 0;
> +}

Depending on the IMA policy, the file could already have been
measured. ?That measurement list entry might include the file
signature, as stored in the xattr, in the ima-sig template data.

I think even if a measurement list entry exists, we would want an
additional measurement list entry, which includes the appended
signature in the ima-sig template data.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
