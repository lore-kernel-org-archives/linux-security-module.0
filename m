Return-Path: <SRS0=XO9p=ND=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D19C7112C
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Oct 2018 19:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF6920813
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Oct 2018 19:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF6920813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbeJXDhd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:37:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:9725 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbeJXDhc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Oct 2018 23:37:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 12:12:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,417,1534834800"; 
   d="scan'208";a="80341520"
Received: from pwolsza-mobl1.ger.corp.intel.com ([10.249.254.37])
  by fmsmga007.fm.intel.com with ESMTP; 23 Oct 2018 12:12:46 -0700
Date:   Tue, 23 Oct 2018 22:12:44 +0300 (EEST)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-X-Sender: jsakkine@jsakkine-mobl1
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
cc:     linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v4 1/7] tpm-buf: create new functions for handling TPM
 buffers
In-Reply-To: <1540193734.3202.9.camel@HansenPartnership.com>
Message-ID: <alpine.DEB.2.21.1810232156470.8524@jsakkine-mobl1>
References: <1540193596.3202.7.camel@HansenPartnership.com> <1540193734.3202.9.camel@HansenPartnership.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 22 Oct 2018, James Bottomley wrote:
> This separates out the old tpm_buf_... handling functions from static
> inlines into tpm.h and makes them their own tpm-buf.c file.  It also
> adds handling for tpm2b structures and also incremental pointer
> advancing parsers.

Nitpicking: when my SGX patch set has been reviewed one of the comments
has been that commit messages should be in imperative form e.g.

"Separate out the old tpm_buf handling functions from static inlines
into tpm.h and make them their..."

> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>
> ---
>
> v2: added this patch to separate out the API changes
> v3: added tpm_buf_reset_cmd()
> v4: renamed tpm_buf_reset_cmd() to tpm_buf_reset()
> ---
> drivers/char/tpm/Makefile  |   2 +-
> drivers/char/tpm/tpm-buf.c | 191 +++++++++++++++++++++++++++++++++++++++++++++
> drivers/char/tpm/tpm.h     |  96 ++++-------------------
> 3 files changed, 208 insertions(+), 81 deletions(-)
> create mode 100644 drivers/char/tpm/tpm-buf.c
>
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 3655258bee73..65d165cce530 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -5,7 +5,7 @@
> obj-$(CONFIG_TCG_TPM) += tpm.o
> tpm-y := tpm-interface.o tpm-dev.o tpm-sysfs.o tpm-chip.o tpm2-cmd.o \
> 	 tpm-dev-common.o tpmrm-dev.o eventlog/common.o eventlog/tpm1.o \
> -	 eventlog/tpm2.o tpm2-space.o
> +	 eventlog/tpm2.o tpm2-space.o tpm-buf.o
> tpm-$(CONFIG_ACPI) += tpm_ppi.o eventlog/acpi.o
> tpm-$(CONFIG_EFI) += eventlog/efi.o
> tpm-$(CONFIG_OF) += eventlog/of.o
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> new file mode 100644
> index 000000000000..faa22bb09d99
> --- /dev/null
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Handing for tpm2b structures to facilitate the building of commands
> + */
> +
> +#include "tpm.h"
> +
> +#include <linux/module.h>
> +
> +#include <asm/unaligned.h>
> +
> +static int __tpm_buf_init(struct tpm_buf *buf)
> +{
> +	buf->data_page = alloc_page(GFP_HIGHUSER);
> +	if (!buf->data_page)
> +		return -ENOMEM;
> +
> +	buf->flags = 0;
> +	buf->data = kmap(buf->data_page);
> +
> +	return 0;
> +}
> +
> +void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
> +{
> +	struct tpm_input_header *head;
> +
> +	head = (struct tpm_input_header *) buf->data;
> +
> +	head->tag = cpu_to_be16(tag);
> +	head->length = cpu_to_be32(sizeof(*head));
> +	head->ordinal = cpu_to_be32(ordinal);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_reset);
> +
> +int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> +{
> +	int rc;
> +
> +	rc = __tpm_buf_init(buf);
> +	if (rc)
> +		return rc;
> +
> +	tpm_buf_reset(buf, tag, ordinal);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_init);
> +
> +int tpm_buf_init_2b(struct tpm_buf *buf)
> +{
> +	struct tpm_input_header *head;
> +	int rc;
> +
> +	rc = __tpm_buf_init(buf);
> +	if (rc)
> +		return rc;
> +
> +	head = (struct tpm_input_header *) buf->data;
> +
> +	head->length = cpu_to_be32(sizeof(*head));
> +
> +	buf->flags = TPM_BUF_2B;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_init_2b);
> +
> +void tpm_buf_destroy(struct tpm_buf *buf)
> +{
> +	kunmap(buf->data_page);
> +	__free_page(buf->data_page);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_destroy);
> +
> +static void *tpm_buf_data(struct tpm_buf *buf)
> +{
> +	if (buf->flags & TPM_BUF_2B)
> +		return buf->data + TPM_HEADER_SIZE;
> +	return buf->data;
> +}
> +
> +u32 tpm_buf_length(struct tpm_buf *buf)
> +{
> +	struct tpm_input_header *head = (struct tpm_input_header *)buf->data;
> +	u32 len;
> +
> +	len = be32_to_cpu(head->length);
> +	if (buf->flags & TPM_BUF_2B)
> +		len -= sizeof(*head);
> +	return len;
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_length);
> +
> +u16 tpm_buf_tag(struct tpm_buf *buf)
> +{
> +	struct tpm_input_header *head = (struct tpm_input_header *)buf->data;
> +
> +	return be16_to_cpu(head->tag);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_tag);
> +
> +void tpm_buf_append(struct tpm_buf *buf,
> +		    const unsigned char *new_data,
> +		    unsigned int new_len)
> +{
> +	struct tpm_input_header *head = (struct tpm_input_header *) buf->data;
> +	u32 len = be32_to_cpu(head->length);
> +
> +	/* Return silently if overflow has already happened. */
> +	if (buf->flags & TPM_BUF_OVERFLOW)
> +		return;
> +
> +	if ((len + new_len) > PAGE_SIZE) {
> +		WARN(1, "tpm_buf: overflow\n");
> +		buf->flags |= TPM_BUF_OVERFLOW;
> +		return;
> +	}
> +
> +	memcpy(&buf->data[len], new_data, new_len);
> +	head->length = cpu_to_be32(len + new_len);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_append);
> +
> +void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value)
> +{
> +	tpm_buf_append(buf, &value, 1);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_append_u8);
> +
> +void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value)
> +{
> +	__be16 value2 = cpu_to_be16(value);
> +
> +	tpm_buf_append(buf, (u8 *) &value2, 2);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_append_u16);
> +
> +void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
> +{
> +	__be32 value2 = cpu_to_be32(value);
> +
> +	tpm_buf_append(buf, (u8 *) &value2, 4);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
> +
> +static void tpm_buf_reset_int(struct tpm_buf *buf)
> +{
> +	struct tpm_input_header *head;
> +
> +	head = (struct tpm_input_header *)buf->data;
> +	head->length = cpu_to_be32(sizeof(*head));
> +}
> +
> +void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b)
> +{
> +	u16 len = tpm_buf_length(tpm2b);
> +
> +	tpm_buf_append_u16(buf, len);
> +	tpm_buf_append(buf, tpm_buf_data(tpm2b), len);
> +	/* clear the buf for reuse */
> +	tpm_buf_reset_int(tpm2b);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_append_2b);

I think it would be more clean to rename tpm_buf_reset_int() as
tpm_buf_reset_2b() and call it outside tpm_buf_append_2b(). Easier
to understand later on in the call site what is going on.

> +
> +/* functions for unmarshalling data and moving the cursor */
> +u8 tpm_get_inc_u8(const u8 **ptr)
> +{
> +	return *((*ptr)++);
> +}
> +EXPORT_SYMBOL_GPL(tpm_get_inc_u8);
> +
> +u16 tpm_get_inc_u16(const u8 **ptr)
> +{
> +	u16 val;
> +
> +	val = get_unaligned_be16(*ptr);
> +	*ptr += sizeof(val);
> +	return val;
> +}
> +EXPORT_SYMBOL_GPL(tpm_get_inc_u16);
> +
> +u32 tpm_get_inc_u32(const u8 **ptr)
> +{
> +	u32 val;
> +
> +	val = get_unaligned_be32(*ptr);
> +	*ptr += sizeof(val);
> +	return val;
> +}
> +EXPORT_SYMBOL_GPL(tpm_get_inc_u32);

These tpm_get_ functions should be first of all documented and I would
use tpm_buf_ prefix also in these simply because they are used in
conjuction with that stuff. Maybe we could call the parameter simply as
'iter' as that is what it is? These definitely should be in their own
commit.

> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index f3501d05264f..d73701e36eba 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -416,6 +416,7 @@ struct tpm_cmd_t {
>
> enum tpm_buf_flags {
> 	TPM_BUF_OVERFLOW	= BIT(0),
> +	TPM_BUF_2B		= BIT(1),
> };
>
> struct tpm_buf {
> @@ -424,86 +425,21 @@ struct tpm_buf {
> 	u8 *data;
> };
>
> -static inline void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
> -{
> -	struct tpm_input_header *head;
> -	head = (struct tpm_input_header *)buf->data;
> -	head->tag = cpu_to_be16(tag);
> -	head->length = cpu_to_be32(sizeof(*head));
> -	head->ordinal = cpu_to_be32(ordinal);
> -}
> -
> -static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> -{
> -	buf->data_page = alloc_page(GFP_HIGHUSER);
> -	if (!buf->data_page)
> -		return -ENOMEM;
> -
> -	buf->flags = 0;
> -	buf->data = kmap(buf->data_page);
> -	tpm_buf_reset(buf, tag, ordinal);
> -	return 0;
> -}
> -
> -static inline void tpm_buf_destroy(struct tpm_buf *buf)
> -{
> -	kunmap(buf->data_page);
> -	__free_page(buf->data_page);
> -}
> -
> -static inline u32 tpm_buf_length(struct tpm_buf *buf)
> -{
> -	struct tpm_input_header *head = (struct tpm_input_header *) buf->data;
> -
> -	return be32_to_cpu(head->length);
> -}
> -
> -static inline u16 tpm_buf_tag(struct tpm_buf *buf)
> -{
> -	struct tpm_input_header *head = (struct tpm_input_header *) buf->data;
> -
> -	return be16_to_cpu(head->tag);
> -}
> -
> -static inline void tpm_buf_append(struct tpm_buf *buf,
> -				  const unsigned char *new_data,
> -				  unsigned int new_len)
> -{
> -	struct tpm_input_header *head = (struct tpm_input_header *) buf->data;
> -	u32 len = tpm_buf_length(buf);
> -
> -	/* Return silently if overflow has already happened. */
> -	if (buf->flags & TPM_BUF_OVERFLOW)
> -		return;
> -
> -	if ((len + new_len) > PAGE_SIZE) {
> -		WARN(1, "tpm_buf: overflow\n");
> -		buf->flags |= TPM_BUF_OVERFLOW;
> -		return;
> -	}
> -
> -	memcpy(&buf->data[len], new_data, new_len);
> -	head->length = cpu_to_be32(len + new_len);
> -}
> -
> -static inline void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value)
> -{
> -	tpm_buf_append(buf, &value, 1);
> -}
> -
> -static inline void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value)
> -{
> -	__be16 value2 = cpu_to_be16(value);
> -
> -	tpm_buf_append(buf, (u8 *) &value2, 2);
> -}
> -
> -static inline void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
> -{
> -	__be32 value2 = cpu_to_be32(value);
> -
> -	tpm_buf_append(buf, (u8 *) &value2, 4);
> -}
> +int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
> +void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
> +int tpm_buf_init_2b(struct tpm_buf *buf);
> +void tpm_buf_destroy(struct tpm_buf *buf);
> +u32 tpm_buf_length(struct tpm_buf *buf);
> +void tpm_buf_append(struct tpm_buf *buf, const unsigned char *new_data,
> +		    unsigned int new_len);
> +void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
> +void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
> +void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
> +void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b);
> +
> +u8 tpm_get_inc_u8(const u8 **ptr);
> +u16 tpm_get_inc_u16(const u8 **ptr);
> +u32 tpm_get_inc_u32(const u8 **ptr);
>
> extern struct class *tpm_class;
> extern struct class *tpmrm_class;
> -- 
> 2.16.4
>
>

Please, split this into three commits:

1. Move tpm-buf functions to tpm-buf.c.
2. Extensions to the buffer construction (i.e. TPM2B).
3. The parsing code.

Then we can see clearly what is going on and properly evaluate these
changes.

/Jarkko
