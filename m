From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 5 Mar 2018 13:50:56 +0200
Subject: [PATCH 1/2] tpm2-sessions: Add full HMAC and encrypt/decrypt
	session handling
In-Reply-To: <20180305113533.GJ25377@linux.intel.com>
References: <1520057094.27452.16.camel@HansenPartnership.com>
	<1520057175.27452.18.camel@HansenPartnership.com>
	<20180305113533.GJ25377@linux.intel.com>
Message-ID: <20180305115056.GK25377@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Mar 05, 2018 at 01:35:33PM +0200, Jarkko Sakkinen wrote:
> On Fri, Mar 02, 2018 at 10:06:15PM -0800, James Bottomley wrote:
> > diff --git a/drivers/char/tpm/tpm2b.h b/drivers/char/tpm/tpm2b.h
> > new file mode 100644
> > index 000000000000..c7726f2895aa
> > --- /dev/null
> > +++ b/drivers/char/tpm/tpm2b.h
> > @@ -0,0 +1,82 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _TPM2_TPM2B_H
> > +#define _TPM2_TPM2B_H
> > +/*
> > + * Handing for tpm2b structures to facilitate the building of commands
> > + */
> > +
> > +#include "tpm.h"
> > +
> > +#include <asm/unaligned.h>
> > +
> > +struct tpm2b {
> > +	struct tpm_buf buf;
> > +};
> > +
> > +/* opaque structure, holds auth session parameters like the session key */
> > +struct tpm2_auth;
> > +
> > +static inline int tpm2b_init(struct tpm2b *buf)
> > +{
> > +	return tpm_buf_init(&buf->buf, 0, 0);
> > +}
> > +
> > +static inline void tpm2b_reset(struct tpm2b *buf)
> > +{
> > +	struct tpm_input_header *head;
> > +
> > +	head = (struct tpm_input_header *)buf->buf.data;
> > +	head->length = cpu_to_be32(sizeof(*head));
> > +}
> > +
> > +static inline void tpm2b_append(struct tpm2b *buf, const unsigned char *data,
> > +				unsigned int len)
> > +{
> > +	tpm_buf_append(&buf->buf, data, len);
> > +}
> > +
> > +#define TPM2B_APPEND(type) \
> > +	static inline void tpm2b_append_##type(struct tpm2b *buf, const type value) { tpm_buf_append_##type(&buf->buf, value); }
> > +
> > +TPM2B_APPEND(u8)
> > +TPM2B_APPEND(u16)
> > +TPM2B_APPEND(u32)
> > +
> > +static inline void *tpm2b_buffer(const struct tpm2b *buf)
> > +{
> > +	return buf->buf.data + sizeof(struct tpm_input_header);
> > +}
> > +
> > +static inline u16 tpm2b_len(struct tpm2b *buf)
> > +{
> > +	return tpm_buf_length(&buf->buf) - sizeof(struct tpm_input_header);
> > +}
> > +
> > +static inline void tpm2b_destroy(struct tpm2b *buf)
> > +{
> > +	tpm_buf_destroy(&buf->buf);
> > +}
> > +
> > +static inline void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm2b *tpm2b)
> > +{
> > +	u16 len = tpm2b_len(tpm2b);
> > +
> > +	tpm_buf_append_u16(buf, len);
> > +	tpm_buf_append(buf, tpm2b_buffer(tpm2b), len);
> > +	/* clear the buf for reuse */
> > +	tpm2b_reset(tpm2b);
> > +}
> > +
> > +/* Macros for unmarshalling known size BE data */
> > +#define GET_INC(type)					\
> > +static inline u##type get_inc_##type(const u8 **ptr) {	\
> > +	u##type val;					\
> > +	val = get_unaligned_be##type(*ptr);		\
> > +	*ptr += sizeof(val);				\
> > +	return val;					\
> > +}
> > +
> > +GET_INC(16)
> > +GET_INC(32)
> > +
> > +#endif
> > -- 
> > 2.12.3
> > 
> 
> Some meta stuff:
> 
> * Add me to TO-field because I should probably review and eventually
>   test these, right?
> * CC to linux-security-module
> * Why there is no RFC tag given that these are so quite large changes?
> * Why in hell tpm2b.h?
> 
> /Jarkko

Some other large scale level stuff that I saw:

* Do not document functions in the file header.
* Make the stuff in the header (expect functio descriptions) as
  documentation block:
  https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt
  If you don't want to do this, then just move the documentation to
  the commit message. I rather do not have the documentation at all
  in the files than have it in unmaintanable form.
* Create structs for complex things that you add inside TPM commands
  and declare these helpers right before the function and add them
  with tpm_buf_append(). A good metric for this is when you see your
  self?adding field names as a comment. This should make these patches
  a factor cleaner. We use this approach in some places such as
  tpm2_get_pcr_allocation().
* Please, oh please get rid of this tpm2b.h. It is a definitive NAK (OK
  I said it already above but cannot really over emphasize it).
* Short summary should be "tpm: add encrypted and integrity protected
  sessions" or something along the lines.

I guess this is enough for first review round?

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
