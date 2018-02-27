From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 27 Feb 2018 10:33:57 -0500
Subject: [PATCH v2 1/4] ima: fail file signature verification on
	non-init mounted filesystems
In-Reply-To: <87bmgbyzhx.fsf@xmission.com>
References: <1519335184-17808-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1519335184-17808-2-git-send-email-zohar@linux.vnet.ibm.com>
	<87bmgbyzhx.fsf@xmission.com>
Message-ID: <1519745637.3562.364.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2018-02-26 at 19:47 -0600, Eric W. Biederman wrote:

> > diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> > index 1b177461f20e..f34901069e78 100644
> > --- a/security/integrity/ima/ima_appraise.c
> > +++ b/security/integrity/ima/ima_appraise.c
> > @@ -302,7 +302,18 @@ int ima_appraise_measurement(enum ima_hooks func,
> >  	}
> >  
> >  out:
> > -	if (status != INTEGRITY_PASS) {
> > +	/*
> > +	 * File signatures on some filesystems can not be properly verified.
> > +	 * On these filesytems, that are mounted by an untrusted mounter,
> > +	 * fail the file signature verification.
> > +	 */
> > +	if (inode->i_sb->s_iflags &
> > +	    (SB_I_IMA_UNVERIFIABLE_SIGNATURE | SB_I_UNTRUSTED_MOUNTER))
> > {
> 
> I like this test.
> 
> This test does not match your comments.  This test returns true if
> either SB_I_IMA_UNVERIFIABLE_SIGNATURE or SB_I_UNTRUSTED_MOUNTER.

Thanks, you're right. ?The test should have been:

        if ((inode->i_sb->s_iflags &
            (SB_I_IMA_UNVERIFIABLE_SIGNATURE | SB_I_UNTRUSTED_MOUNTER)) ==
            (SB_I_IMA_UNVERIFIABLE_SIGNATURE | SB_I_UNTRUSTED_MOUNTER)) {

Mimi

> 
> > +		status = INTEGRITY_FAIL;
> > +		cause = "unverifiable-signature";
> > +		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
> > +				    op, cause, rc, 0);
> > +	} else if (status != INTEGRITY_PASS) {
> >  		if ((ima_appraise & IMA_APPRAISE_FIX) &&
> >  		    (!xattr_value ||
> >  		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
> 
> Eric
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
