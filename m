From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Fri, 16 Mar 2018 14:02:26 +0200
Subject: [PATCH v3 1/6] tpm-buf: create new functions for handling TPM
	buffers
In-Reply-To: <6da309e727bec176fed7253ba5276f47f784d759.camel@linux.intel.com>
References: <1520720026.4495.11.camel@HansenPartnership.com>
	<1520720090.4495.12.camel@HansenPartnership.com>
	<6da309e727bec176fed7253ba5276f47f784d759.camel@linux.intel.com>
Message-ID: <f1521f6afa2e89ce666503148d6fad425cb5b813.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2018-03-16 at 13:58 +0200, Jarkko Sakkinen wrote:
> On Sat, 2018-03-10 at 14:14 -0800, James Bottomley wrote:
> >  	TPM_BUF_OVERFLOW	= BIT(0),
> > +	TPM_BUF_2B		= BIT(1),
> 
> Instead of re-using this I would prefer to have another enum for
> buffer type. tpm_buf_init() could have the signature:
> 
> int tpm_buf_init(unsigned int type);
> 
> For commands there should be a function:
> 
> void tpm_buf_set_command_header(struct tpm_buf *buf, u16 tag, u32 ordinal);
> 
> And tpm_buf_append_2b() should not exist at all. It should be
> maintained automatically by other append commands.

Can you send the next version this patch as a separate entity? Once
I can land this we have kind of stable ground for the following
patches. After that it is easier test and review them.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
