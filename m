From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Wed, 14 Mar 2018 21:03:36 -0300
Subject: [PATCH 3/4] ima: Improvements in ima_appraise_measurement()
In-Reply-To: <20180314214045.GC14289@mail.hallyn.com>
References: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
	<20180314202020.3794-4-bauerman@linux.vnet.ibm.com>
	<20180314214045.GC14289@mail.hallyn.com>
Message-ID: <87efkmjjc7.fsf@morokweng.localdomain>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


Hello Serge,

Thanks for quickly reviewing these patches!

Serge E. Hallyn <serge@hallyn.com> writes:

> Quoting Thiago Jung Bauermann (bauerman at linux.vnet.ibm.com):
>> From: Mimi Zohar <zohar@linux.vnet.ibm.com>
>> @@ -241,16 +241,20 @@ int ima_appraise_measurement(enum ima_hooks func,
>>  	}
>>  
>>  	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value, rc, iint);
>> -	if ((status != INTEGRITY_PASS) &&
>> -	    (status != INTEGRITY_PASS_IMMUTABLE) &&
>> -	    (status != INTEGRITY_UNKNOWN)) {
>> -		if ((status == INTEGRITY_NOLABEL)
>> -		    || (status == INTEGRITY_NOXATTRS))
>> -			cause = "missing-HMAC";
>> -		else if (status == INTEGRITY_FAIL)
>> -			cause = "invalid-HMAC";
>> +	switch (status) {
>> +	case INTEGRITY_PASS:
>> +	case INTEGRITY_PASS_IMMUTABLE:
>> +	case INTEGRITY_UNKNOWN:
>
> Wouldn't it be more future-proof to replace this with a 'default', or
> to at least add a "default: BUG()" to catch new status values?

I agree. I like the "default: BUG()" option.

>> +		break;
>> +	case INTEGRITY_NOXATTRS:	/* No EVM protected xattrs. */
>> +	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
>> +		cause = "missing-HMAC";
>> +		goto out;
>> +	case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
>> +		cause = "invalid-HMAC";
>>  		goto out;
>>  	}
>> +
>>  	switch (xattr_value->type) {
>>  	case IMA_XATTR_DIGEST_NG:
>>  		/* first byte contains algorithm id */
>> @@ -316,17 +320,20 @@ int ima_appraise_measurement(enum ima_hooks func,
>>  		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
>>  				    op, cause, rc, 0);
>>  	} else if (status != INTEGRITY_PASS) {
>> +		/* Fix mode, but don't replace file signatures. */
>>  		if ((ima_appraise & IMA_APPRAISE_FIX) &&
>>  		    (!xattr_value ||
>>  		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
>>  			if (!ima_fix_xattr(dentry, iint))
>>  				status = INTEGRITY_PASS;
>> -		} else if ((inode->i_size == 0) &&
>> -			   (iint->flags & IMA_NEW_FILE) &&
>> -			   (xattr_value &&
>> -			    xattr_value->type == EVM_IMA_XATTR_DIGSIG)) {
>> +		}
>> +
>> +		/* Permit new files with file signatures, but without data. */
>> +		if (inode->i_size == 0 && iint->flags & IMA_NEW_FILE &&
>
> This may be correct, but it's not identical to what you're replacing.
> Since in either case you're setting status to INTEGRITY_PASS the final
> result is the same, but with a few extra possible steps.  Not sure
> whether that matters.

Good point. I'll have to defer this one to Mimi though.

>
>> +		    xattr_value && xattr_value->type == EVM_IMA_XATTR_DIGSIG) {
>>  			status = INTEGRITY_PASS;
>>  		}
>> +
>>  		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
>>  				    op, cause, rc, 0);
>>  	} else {


-- 
Thiago Jung Bauermann
IBM Linux Technology Center

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
