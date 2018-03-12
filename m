From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Mon, 12 Mar 2018 10:59:13 -0700
Subject: [PATCH v3 1/6] tpm-buf: create new functions for handling TPM
	buffers
In-Reply-To: <277bd8a1-9e7f-f6e8-bede-5208f0456adf@gmail.com>
References: <1520720026.4495.11.camel@HansenPartnership.com>
	<1520720090.4495.12.camel@HansenPartnership.com>
	<277bd8a1-9e7f-f6e8-bede-5208f0456adf@gmail.com>
Message-ID: <1520877553.4522.25.camel@HansenPartnership.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2018-03-12 at 09:00 -0700, J Freyensee wrote:
> > 
> > +int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> > +{
> > +	int rc;
> > +
> > +	rc = __tpm_buf_init(buf);
> 
> 
> Assuming that functions like tpm_buf_init() are the top-level API
> being defined in this patch, shouldn't it check if buf is valid
> before passing into the internal functions like __tpm_buf_init(buf)
> (maybe WARN()/BUG_ON()?).? Or does __tpm_buf_init(buf) do this check?

These are kernel internal APIs designed for on stack struct tpm_buf
usage, so I can't think of a viable threat model that would require
this type of checking ... do you have one?

James

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
