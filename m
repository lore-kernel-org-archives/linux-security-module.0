From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 25 Jan 2018 06:56:41 -0500
Subject: [RFC PATCH v3 2/2] ima: force re-appraisal on filesystems with
	FS_IMA_NO_CACHE
In-Reply-To: <20180124175234.GA29811@mail.hallyn.com>
References: <20180122162452.8756-1-alban@kinvolk.io>
	<20180122162452.8756-3-alban@kinvolk.io>
	<20180124175234.GA29811@mail.hallyn.com>
Message-ID: <1516881401.3751.37.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


> > @@ -228,9 +229,28 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
> >  				 IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
> >  				 IMA_ACTION_FLAGS);
> >  
> > -	if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags))
> > -		/* reset all flags if ima_inode_setxattr was called */
> > +	/*
> > +	 * Reset the measure, appraise and audit cached flags either if:
> > +	 * - ima_inode_setxattr was called, or
> > +	 * - based on filesystem feature flag
> > +	 * forcing the file to be re-evaluated.
> > +	 */
> > +	if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags)) {
> >  		iint->flags &= ~IMA_DONE_MASK;
> > +	} else if (inode->i_sb->s_type->fs_flags & FS_IMA_NO_CACHE) {
> > +		if (action & IMA_MEASURE) {
> > +			iint->measured_pcrs = 0;
> > +			iint->flags &=
> > +			    ~(IMA_COLLECTED | IMA_MEASURE | IMA_MEASURED);
> > +		}
> > +		if (action & IMA_APPRAISE)
> > +			iint->flags &=
> > +			    ~(IMA_COLLECTED | IMA_APPRAISE | IMA_APPRAISED |
> > +			      IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK);
> > +		if (action & IMA_AUDIT)
> > +			iint->flags &=
> > +			    ~(IMA_COLLECTED | IMA_AUDIT | IMA_AUDITED);
> > +	}
> > 

Alban, I don't know what I was thinking, but this can be simplified
like for the IMA_CHANGE_XATTR case. ?Except in the IMA_CHANGE_XATTR
case, "measured_pcrs" was already reset, whereas in this case
"measured_pcrs" needs to be reset.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
