From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Fri, 16 Mar 2018 13:58:08 +0200
Subject: [PATCH v3 1/6] tpm-buf: create new functions for handling TPM
	buffers
In-Reply-To: <1520720090.4495.12.camel@HansenPartnership.com>
References: <1520720026.4495.11.camel@HansenPartnership.com>
	<1520720090.4495.12.camel@HansenPartnership.com>
Message-ID: <6da309e727bec176fed7253ba5276f47f784d759.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 2018-03-10 at 14:14 -0800, James Bottomley wrote:
>  	TPM_BUF_OVERFLOW	= BIT(0),
> +	TPM_BUF_2B		= BIT(1),

Instead of re-using this I would prefer to have another enum for
buffer type. tpm_buf_init() could have the signature:

int tpm_buf_init(unsigned int type);

For commands there should be a function:

void tpm_buf_set_command_header(struct tpm_buf *buf, u16 tag, u32 ordinal);

And tpm_buf_append_2b() should not exist at all. It should be
maintained automatically by other append commands.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
