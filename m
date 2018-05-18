From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Fri, 18 May 2018 11:03:37 +0300
Subject: [PATCH v4 4/4] tpm: migrate tpm2_get_random() to use struct
	tpm_buf
In-Reply-To: <ad7a4070-6fff-38e3-0284-45f1d7e6722f@linux.vnet.ibm.com>
References: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
	<20180326121406.14548-5-jarkko.sakkinen@linux.intel.com>
	<ad7a4070-6fff-38e3-0284-45f1d7e6722f@linux.vnet.ibm.com>
Message-ID: <20180518080337.GA14777@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, May 18, 2018 at 11:39:16AM +0530, Nayna Jain wrote:
> 
> 
> On 03/26/2018 05:44 PM, Jarkko Sakkinen wrote:
> > In order to make struct tpm_buf the first class object for constructing
> > TPM commands, migrate tpm2_get_random() to use it. In addition, removed
> > remaining references to struct tpm2_cmd. All of them use it to acquire
> > the length of the response, which can be achieved by using
> > tpm_buf_length().
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >   drivers/char/tpm/tpm.h      | 19 ++++-----
> >   drivers/char/tpm/tpm2-cmd.c | 98 ++++++++++++++++++---------------------------
> >   2 files changed, 49 insertions(+), 68 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > index 7f2d0f489e9c..aa849a1b2641 100644
> > --- a/drivers/char/tpm/tpm.h
> > +++ b/drivers/char/tpm/tpm.h
> > @@ -421,23 +421,24 @@ struct tpm_buf {
> >   	u8 *data;
> >   };
> > 
> > -static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> > +static inline void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
> >   {
> >   	struct tpm_input_header *head;
> > +	head = (struct tpm_input_header *)buf->data;
> > +	head->tag = cpu_to_be16(tag);
> > +	head->length = cpu_to_be32(sizeof(*head));
> > +	head->ordinal = cpu_to_be32(ordinal);
> > +}
> > 
> > +static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> > +{
> >   	buf->data_page = alloc_page(GFP_HIGHUSER);
> >   	if (!buf->data_page)
> >   		return -ENOMEM;
> > 
> >   	buf->flags = 0;
> >   	buf->data = kmap(buf->data_page);
> > -
> > -	head = (struct tpm_input_header *) buf->data;
> > -
> > -	head->tag = cpu_to_be16(tag);
> > -	head->length = cpu_to_be32(sizeof(*head));
> > -	head->ordinal = cpu_to_be32(ordinal);
> > -
> > +	tpm_buf_reset(buf, tag, ordinal);
> >   	return 0;
> >   }
> > 
> > @@ -566,7 +567,7 @@ static inline u32 tpm2_rc_value(u32 rc)
> >   int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf);
> >   int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
> >   		    struct tpm2_digest *digests);
> > -int tpm2_get_random(struct tpm_chip *chip, u8 *out, size_t max);
> > +int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
> >   void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
> >   			    unsigned int flags);
> >   int tpm2_seal_trusted(struct tpm_chip *chip,
> > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> > index b3b52f9eb65f..d5c222f98515 100644
> > --- a/drivers/char/tpm/tpm2-cmd.c
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -27,25 +27,6 @@ enum tpm2_session_attributes {
> >   	TPM2_SA_CONTINUE_SESSION	= BIT(0),
> >   };
> > 
> > -struct tpm2_get_random_in {
> > -	__be16	size;
> > -} __packed;
> > -
> > -struct tpm2_get_random_out {
> > -	__be16	size;
> > -	u8	buffer[TPM_MAX_RNG_DATA];
> > -} __packed;
> > -
> > -union tpm2_cmd_params {
> > -	struct	tpm2_get_random_in	getrandom_in;
> > -	struct	tpm2_get_random_out	getrandom_out;
> > -};
> > -
> > -struct tpm2_cmd {
> > -	tpm_cmd_header		header;
> > -	union tpm2_cmd_params	params;
> > -} __packed;
> > -
> >   struct tpm2_hash {
> >   	unsigned int crypto_id;
> >   	unsigned int tpm_id;
> > @@ -300,67 +281,70 @@ int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
> >   }
> > 
> > 
> > -#define TPM2_GETRANDOM_IN_SIZE \
> > -	(sizeof(struct tpm_input_header) + \
> > -	 sizeof(struct tpm2_get_random_in))
> > -
> > -static const struct tpm_input_header tpm2_getrandom_header = {
> > -	.tag = cpu_to_be16(TPM2_ST_NO_SESSIONS),
> > -	.length = cpu_to_be32(TPM2_GETRANDOM_IN_SIZE),
> > -	.ordinal = cpu_to_be32(TPM2_CC_GET_RANDOM)
> > -};
> > +struct tpm2_get_random_out {
> > +	__be16 size;
> > +	u8 buffer[TPM_MAX_RNG_DATA];
> > +} __packed;
> > 
> >   /**
> >    * tpm2_get_random() - get random bytes from the TPM RNG
> >    *
> >    * @chip: TPM chip to use
> > - * @out: destination buffer for the random bytes
> > + * @dest: destination buffer for the random bytes
> >    * @max: the max number of bytes to write to @out
> >    *
> >    * Return:
> > - *    Size of the output buffer, or -EIO on error.
> > + * size of the output buffer when the operation is successful.
> > + * A negative number for system errors (errno).
> >    */
> > -int tpm2_get_random(struct tpm_chip *chip, u8 *out, size_t max)
> > +int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
> >   {
> > -	struct tpm2_cmd cmd;
> > -	u32 recd, rlength;
> > -	u32 num_bytes;
> > +	struct tpm2_get_random_out *out;
> > +	struct tpm_buf buf;
> > +	u32 recd;
> > +	u32 num_bytes = max;
> >   	int err;
> >   	int total = 0;
> >   	int retries = 5;
> > -	u8 *dest = out;
> > -
> > -	num_bytes = min_t(u32, max, sizeof(cmd.params.getrandom_out.buffer));
> > +	u8 *dest_ptr = dest;
> > 
> > -	if (!out || !num_bytes ||
> > -	    max > sizeof(cmd.params.getrandom_out.buffer))
> > +	if (!num_bytes || max > TPM_MAX_RNG_DATA)
> >   		return -EINVAL;
> > 
> > -	do {
> > -		cmd.header.in = tpm2_getrandom_header;
> > -		cmd.params.getrandom_in.size = cpu_to_be16(num_bytes);
> > +	err = tpm_buf_init(&buf, 0, 0);
> > +	if (err)
> > +		return err;
> > 
> > -		err = tpm_transmit_cmd(chip, NULL, &cmd, sizeof(cmd),
> > +	do {
> > +		tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_RANDOM);
> > +		tpm_buf_append_u16(&buf, num_bytes);
> > +		err = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE,
> >   				       offsetof(struct tpm2_get_random_out,
> >   						buffer),
> >   				       0, "attempting get random");
> >   		if (err)
> > -			break;
> > +			goto out;
> > 
> > -		recd = min_t(u32, be16_to_cpu(cmd.params.getrandom_out.size),
> > -			     num_bytes);
> > -		rlength = be32_to_cpu(cmd.header.out.length);
> > -		if (rlength < offsetof(struct tpm2_get_random_out, buffer) +
> > -			      recd)
> > -			return -EFAULT;
> > -		memcpy(dest, cmd.params.getrandom_out.buffer, recd);
> > +		out = (struct tpm2_get_random_out *)
> > +			&buf.data[TPM_HEADER_SIZE];
> > +		recd = min_t(u32, be16_to_cpu(out->size), num_bytes);
> > +		if (tpm_buf_length(&buf) <
> > +		    offsetof(struct tpm2_get_random_out, buffer) + recd) {
> > +			err = -EFAULT;
> > +			goto out;
> > +		}
> > +		memcpy(dest_ptr, out->buffer, recd);
> > 
> > -		dest += recd;
> > +		dest_ptr += recd;
> >   		total += recd;
> >   		num_bytes -= recd;
> >   	} while (retries-- && total < max);
> > 
> > +	tpm_buf_destroy(&buf);
> >   	return total ? total : -EIO;
> > +out:
> > +	tpm_buf_destroy(&buf);
> > +	return err;
> >   }
> 
> How about having it as :
> 
> ??? if (!total)
> ??? ??? err = -EIO;
> out:
> ??? tpm_buf_destroy(&buf);
> ??? return total?:err;

I think the former is actually more readable in this case albeit there
is one 

> 
> >   /**
> > @@ -434,7 +418,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> >   {
> >   	unsigned int blob_len;
> >   	struct tpm_buf buf;
> > -	u32 hash, rlength;
> > +	u32 hash;
> >   	int i;
> >   	int rc;
> > 
> > @@ -509,8 +493,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> >   		rc = -E2BIG;
> >   		goto out;
> >   	}
> > -	rlength = be32_to_cpu(((struct tpm2_cmd *)&buf)->header.out.length);
> > -	if (rlength < TPM_HEADER_SIZE + 4 + blob_len) {
> > +	if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 4 + blob_len) {
> >   		rc = -EFAULT;
> >   		goto out;
> >   	}
> > @@ -620,7 +603,6 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> >   	u16 data_len;
> >   	u8 *data;
> >   	int rc;
> > -	u32 rlength;
> > 
> >   	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
> >   	if (rc)
> > @@ -648,9 +630,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> >   			goto out;
> >   		}
> > 
> > -		rlength = be32_to_cpu(((struct tpm2_cmd *)&buf)
> > -					->header.out.length);
> > -		if (rlength < TPM_HEADER_SIZE + 6 + data_len) {
> > +		if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 6 + data_len) {
> >   			rc = -EFAULT;
> >   			goto out;
> >   		}
> Probably, all the changes related to the use of tpm_buf_length() could be a
> separate patch in itself ?

I think so but have to recheck with time.

I'll drop these now  from master (really not something that needs to be
rushed) and also update the comments according to standard that I
described to you in my own review comments (since they are not in that
standard).

> Otherwise,
> 
> Tested-by: Nayna Jain<nayna@linux.vnet.ibm.com>

Thank you.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
