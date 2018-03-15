From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Thu, 15 Mar 2018 17:33:42 -0300
Subject: [PATCH 3/4] ima: Improvements in ima_appraise_measurement()
In-Reply-To: <1521141514.3547.637.camel@linux.vnet.ibm.com>
References: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
	<20180314202020.3794-4-bauerman@linux.vnet.ibm.com>
	<20180314214045.GC14289@mail.hallyn.com>
	<87efkmjjc7.fsf@morokweng.localdomain>
	<1521141514.3547.637.camel@linux.vnet.ibm.com>
Message-ID: <874llhoz89.fsf@morokweng.localdomain>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> On Wed, 2018-03-14 at 21:03 -0300, Thiago Jung Bauermann wrote:
>> Hello Serge,
>> 
>> Thanks for quickly reviewing these patches!
>> 
>> Serge E. Hallyn <serge@hallyn.com> writes:
>> 
>> > Quoting Thiago Jung Bauermann (bauerman at linux.vnet.ibm.com):
>> >> From: Mimi Zohar <zohar@linux.vnet.ibm.com>
>> >> @@ -241,16 +241,20 @@ int ima_appraise_measurement(enum ima_hooks func,
>> >>  	}
>> >>  
>> >>  	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value, rc, iint);
>> >> -	if ((status != INTEGRITY_PASS) &&
>> >> -	    (status != INTEGRITY_PASS_IMMUTABLE) &&
>> >> -	    (status != INTEGRITY_UNKNOWN)) {
>> >> -		if ((status == INTEGRITY_NOLABEL)
>> >> -		    || (status == INTEGRITY_NOXATTRS))
>> >> -			cause = "missing-HMAC";
>> >> -		else if (status == INTEGRITY_FAIL)
>> >> -			cause = "invalid-HMAC";
>> >> +	switch (status) {
>> >> +	case INTEGRITY_PASS:
>> >> +	case INTEGRITY_PASS_IMMUTABLE:
>> >> +	case INTEGRITY_UNKNOWN:
>> >
>> > Wouldn't it be more future-proof to replace this with a 'default', or
>> > to at least add a "default: BUG()" to catch new status values?
>> 
>> I agree. I like the "default: BUG()" option.
>
> Agreed. I would put it at the end after INTEGRITY_FAIL.

Ok, what about the version below?

>> 
>> >> +		break;
>> >> +	case INTEGRITY_NOXATTRS:	/* No EVM protected xattrs. */
>> >> +	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
>> >> +		cause = "missing-HMAC";
>> >> +		goto out;
>> >> +	case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
>> >> +		cause = "invalid-HMAC";
>> >>  		goto out;
>> >>  	}
>> >> +
>> >>  	switch (xattr_value->type) {
>> >>  	case IMA_XATTR_DIGEST_NG:
>> >>  		/* first byte contains algorithm id */
>> >> @@ -316,17 +320,20 @@ int ima_appraise_measurement(enum ima_hooks func,
>> >>  		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
>> >>  				    op, cause, rc, 0);
>> >>  	} else if (status != INTEGRITY_PASS) {
>> >> +		/* Fix mode, but don't replace file signatures. */
>> >>  		if ((ima_appraise & IMA_APPRAISE_FIX) &&
>> >>  		    (!xattr_value ||
>> >>  		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
>> >>  			if (!ima_fix_xattr(dentry, iint))
>> >>  				status = INTEGRITY_PASS;
>> >> -		} else if ((inode->i_size == 0) &&
>> >> -			   (iint->flags & IMA_NEW_FILE) &&
>> >> -			   (xattr_value &&
>> >> -			    xattr_value->type == EVM_IMA_XATTR_DIGSIG)) {
>> >> +		}
>> >> +
>> >> +		/* Permit new files with file signatures, but without data. */
>> >> +		if (inode->i_size == 0 && iint->flags & IMA_NEW_FILE &&
>> >
>> > This may be correct, but it's not identical to what you're replacing.
>> > Since in either case you're setting status to INTEGRITY_PASS the final
>> > result is the same, but with a few extra possible steps.  Not sure
>> > whether that matters.
>> 
>> Good point. I'll have to defer this one to Mimi though.
>
> The end result is the same, but add some needed comments.

The patch is unchanged here, then.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center


>From 343bf4ed2974421e254fb4d5cd79aed79c66f016 Mon Sep 17 00:00:00 2001
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Mon, 21 Aug 2017 19:28:51 -0300
Subject: [PATCH] ima: Improvements in ima_appraise_measurement()

Replace nested ifs in the EVM xattr verification logic with a switch
statement, making the code easier to understand.

Also, add comments to the if statements in the out section and constify the
cause variable.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_appraise.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 0c5f94b7b9c3..8bd7a0733e51 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -215,7 +215,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 			     int xattr_len, int opened)
 {
 	static const char op[] = "appraise_data";
-	char *cause = "unknown";
+	const char *cause = "unknown";
 	struct dentry *dentry = file_dentry(file);
 	struct inode *inode = d_backing_inode(dentry);
 	enum integrity_status status = INTEGRITY_UNKNOWN;
@@ -241,16 +241,22 @@ int ima_appraise_measurement(enum ima_hooks func,
 	}
 
 	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value, rc, iint);
-	if ((status != INTEGRITY_PASS) &&
-	    (status != INTEGRITY_PASS_IMMUTABLE) &&
-	    (status != INTEGRITY_UNKNOWN)) {
-		if ((status == INTEGRITY_NOLABEL)
-		    || (status == INTEGRITY_NOXATTRS))
-			cause = "missing-HMAC";
-		else if (status == INTEGRITY_FAIL)
-			cause = "invalid-HMAC";
+	switch (status) {
+	case INTEGRITY_PASS:
+	case INTEGRITY_PASS_IMMUTABLE:
+	case INTEGRITY_UNKNOWN:
+		break;
+	case INTEGRITY_NOXATTRS:	/* No EVM protected xattrs. */
+	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
+		cause = "missing-HMAC";
+		goto out;
+	case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
+		cause = "invalid-HMAC";
 		goto out;
+	default:
+		WARN_ONCE(true, "Unexpected integrity status %d\n", status);
 	}
+
 	switch (xattr_value->type) {
 	case IMA_XATTR_DIGEST_NG:
 		/* first byte contains algorithm id */
@@ -316,17 +322,20 @@ int ima_appraise_measurement(enum ima_hooks func,
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
 				    op, cause, rc, 0);
 	} else if (status != INTEGRITY_PASS) {
+		/* Fix mode, but don't replace file signatures. */
 		if ((ima_appraise & IMA_APPRAISE_FIX) &&
 		    (!xattr_value ||
 		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
 			if (!ima_fix_xattr(dentry, iint))
 				status = INTEGRITY_PASS;
-		} else if ((inode->i_size == 0) &&
-			   (iint->flags & IMA_NEW_FILE) &&
-			   (xattr_value &&
-			    xattr_value->type == EVM_IMA_XATTR_DIGSIG)) {
+		}
+
+		/* Permit new files with file signatures, but without data. */
+		if (inode->i_size == 0 && iint->flags & IMA_NEW_FILE &&
+		    xattr_value && xattr_value->type == EVM_IMA_XATTR_DIGSIG) {
 			status = INTEGRITY_PASS;
 		}
+
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
 				    op, cause, rc, 0);
 	} else {

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
