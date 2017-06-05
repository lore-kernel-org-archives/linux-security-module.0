From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 05 Jun 2017 01:54:26 -0400
Subject: [Linux-ima-devel] [PATCH 1/7] ima: introduce ima_parse_buf()
In-Reply-To: <20170516125347.10574-2-roberto.sassu@huawei.com>
References: <20170516125347.10574-1-roberto.sassu@huawei.com>
	<20170516125347.10574-2-roberto.sassu@huawei.com>
Message-ID: <1496642066.2998.96.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Roberto,

On Tue, 2017-05-16 at 14:53 +0200, Roberto Sassu wrote:
> ima_parse_buf() takes as input the buffer start and end pointers, and
> stores the result in a static array of ima_field_data structures,
> where the len field contains the length parsed from the buffer, and
> the data field contains the address of the buffer just after the length.
> Optionally, the function returns the current value of the buffer pointer
> and the number of array elements written.
> 
> A bitmap has been added as parameter of ima_parse_buf() to handle
> the cases where the length is not prepended to data. Each bit corresponds
> to an element of the ima_field_data array. If a bit is set, the length
> is not parsed from the buffer, but is read from the corresponding element
> of the array (the length must be set before calling the function).
> 
> ima_parse_buf() can perform three checks upon request by callers,
> depending on the enforce mask passed to it:
> 
> - ENFORCE_FIELDS: matching of number of fields (length-data combination)
>   - there must be enough data in the buffer to parse the number of fields
>     requested (output: current value of buffer pointer)
> - ENFORCE_BUFEND: matching of buffer end
>   - the ima_field_data array must be large enough to contain lengths and
>     data pointers for the amount of data requested (output: number
>     of fields written)
> - ENFORCE_FIELDS | ENFORCE_BUFEND: matching of both
> 
> Use cases
> 
> - measurement entry header: ENFORCE_FIELDS | ENFORCE_BUFEND
>   - four fields must be parsed: pcr, digest, template name, template data
>   - ENFORCE_BUFEND is enforced only for the last measurement entry
> - template digest (Crypto Agile): ENFORCE_BUFEND
>   - since only the total template digest length is known, the function
>     parses length-data combinations until the buffer end is reached
> - template data: ENFORCE_FIELDS | ENFORCE_BUFEND
>   - since the number of fields and the total template data length
>     are known, the function can perform both checks
> 

Thanks, Roberto. ?Patches 1 - 3, and 7 look good. ?I wish we didn't
need the len_mask or the enforce_mask fields.

Mimi

> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/ima/ima_template_lib.c | 61 +++++++++++++++++++++++++++++++
>  security/integrity/ima/ima_template_lib.h |  6 +++
>  2 files changed, 67 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
> index f9ba37b..28af43f 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> @@ -159,6 +159,67 @@ void ima_show_template_sig(struct seq_file *m, enum ima_show_type show,
>  	ima_show_template_field_data(m, show, DATA_FMT_HEX, field_data);
>  }
> 
> +/**
> + * ima_parse_buf() - Parses lengths and data from an input buffer
> + * @bufstartp:       Buffer start address.
> + * @bufendp:         Buffer end address.
> + * @bufcurp:         Pointer to remaining (non-parsed) data.
> + * @maxfields:       Length of fields array.
> + * @fields:          Array containing lengths and pointers of parsed data.
> + * @curfields:       Number of array items containing parsed data.
> + * @len_mask:        Bitmap (if bit is set, data length should not be parsed).
> + * @enforce_mask:    Check if curfields == maxfields and/or bufcurp == bufendp.
> + * @bufname:         String identifier of the input buffer.
> + *
> + * Return: 0 on success, -EINVAL on error.
> + */
> +int ima_parse_buf(void *bufstartp, void *bufendp, void **bufcurp,
> +		  int maxfields, struct ima_field_data *fields, int *curfields,
> +		  unsigned long *len_mask, int enforce_mask, char *bufname)
> +{
> +	void *bufp = bufstartp;
> +	int i;
> +
> +	for (i = 0; i < maxfields; i++) {
> +		if (len_mask == NULL || !test_bit(i, len_mask)) {
> +			if (bufp > (bufendp - sizeof(u32)))
> +				break;
> +
> +			fields[i].len = *(u32 *)bufp;
> +			if (ima_canonical_fmt)
> +				fields[i].len = le32_to_cpu(fields[i].len);
> +
> +			bufp += sizeof(u32);
> +		}
> +
> +		if (bufp > (bufendp - fields[i].len))
> +			break;
> +
> +		fields[i].data = bufp;
> +		bufp += fields[i].len;
> +	}
> +
> +	if ((enforce_mask & ENFORCE_FIELDS) && i != maxfields) {
> +		pr_err("%s: nr of fields mismatch: expected: %d, current: %d\n",
> +		       bufname, maxfields, i);
> +		return -EINVAL;
> +	}
> +
> +	if ((enforce_mask & ENFORCE_BUFEND) && bufp != bufendp) {
> +		pr_err("%s: buf end mismatch: expected: %p, current: %p\n",
> +		       bufname, bufendp, bufp);
> +		return -EINVAL;
> +	}
> +
> +	if (curfields)
> +		*curfields = i;
> +
> +	if (bufcurp)
> +		*bufcurp = bufp;
> +
> +	return 0;
> +}
> +
>  static int ima_eventdigest_init_common(u8 *digest, u32 digestsize, u8 hash_algo,
>  				       struct ima_field_data *field_data)
>  {
> diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
> index c344530..6a3d8b8 100644
> --- a/security/integrity/ima/ima_template_lib.h
> +++ b/security/integrity/ima/ima_template_lib.h
> @@ -18,6 +18,9 @@
>  #include <linux/seq_file.h>
>  #include "ima.h"
> 
> +#define ENFORCE_FIELDS 0x00000001
> +#define ENFORCE_BUFEND 0x00000002
> +
>  void ima_show_template_digest(struct seq_file *m, enum ima_show_type show,
>  			      struct ima_field_data *field_data);
>  void ima_show_template_digest_ng(struct seq_file *m, enum ima_show_type show,
> @@ -26,6 +29,9 @@ void ima_show_template_string(struct seq_file *m, enum ima_show_type show,
>  			      struct ima_field_data *field_data);
>  void ima_show_template_sig(struct seq_file *m, enum ima_show_type show,
>  			   struct ima_field_data *field_data);
> +int ima_parse_buf(void *bufstartp, void *bufendp, void **bufcurp,
> +		  int maxfields, struct ima_field_data *fields, int *curfields,
> +		  unsigned long *len_mask, int enforce_mask, char *bufname);
>  int ima_eventdigest_init(struct ima_event_data *event_data,
>  			 struct ima_field_data *field_data);
>  int ima_eventname_init(struct ima_event_data *event_data,

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
