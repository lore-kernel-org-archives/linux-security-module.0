Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35F956B81
	for <linux-security-module@vger.kernel.org>; Tue, 30 Sep 2025 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759238420; cv=none; b=KlNKvYvvEOXNMxO000bS0/Sb9oFoQFhRtKD/U/4yrPmRBMrjytNEw9/SWBFuCEIYooTBfaMVMmZcICyqzriDsJxnBeEpMdjiwYQfb7f2nwNJ4B98nzCOtQpF7mpyfgWu1r43jMJ1pF5IttvdWO133RFFXrbKgDOsy0QWeAP3E0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759238420; c=relaxed/simple;
	bh=0gt7Imcha5nhBbjTVRVb9VCIjM5iV2M2me59OvgGD/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ky2hi1ZJ75K+lPsx/T7P4+2WTtm0QeufqPuQfLVdOnDpm2ruYp9L++3x+g10UyYx2qdU0xY2kquV1kU0e3X2QWq/LE6zLe/h58PcS8GIQ0XWHTW291r10sznCAzYiT8wxPt6yka8THJwh3GDI1gdXsZ68t25xOv3xHXQBcQZ4ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zb3ZCTJ0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zb3ZCTJ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759238417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EyxTKauyxVNianX8/+votp7jB4vVMi9cSLVUSmppWwE=;
	b=Zb3ZCTJ0Dmfs6fe2jeaUDcJicxDgkwbyFirYInX1G70U7RY/fgG5CuTmrBBeej8khPx4np
	4OhfmkcGibhh0Ir1SvJdRFl0E9ka4/Ub748o7/cwBx1CyE0Gn05/odIQW3ik6aOLNizOIR
	ygGgbzDv0sZAhY0M20T7wJ8Vmd+XUiQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-b-yqyJw9NgOYDT12r671lA-1; Tue, 30 Sep 2025 09:20:16 -0400
X-MC-Unique: b-yqyJw9NgOYDT12r671lA-1
X-Mimecast-MFC-AGG-ID: b-yqyJw9NgOYDT12r671lA_1759238415
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-afe81959e5cso730343566b.1
        for <linux-security-module@vger.kernel.org>; Tue, 30 Sep 2025 06:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759238415; x=1759843215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyxTKauyxVNianX8/+votp7jB4vVMi9cSLVUSmppWwE=;
        b=AZy0aJk2HegjmpSygneceMsQGa4UxoYbMwdYM2lYfT2uwcdcoUUjE9WMimmdHuYxAK
         bf0hV0XCJNvOUxRUaKk4ZXmkrAdrpakqfkGjD6lpZTf4OU0LK/iwVpz2vHIzgw6G4DZs
         N3vlw0ZJhrk9QzhZLhoYlzekIrck8DNtbK4//29up50KGOrS/tQwPkcVP3lpM3JdXcAe
         xmHyoGvrLWFIKahHBw7UAGHYrkY0MJrfwkRrAlTBP7o1jfAbq9TAsRAjyrdMPelMTnrz
         NyUKvn9mIqpcmomWuc2ZSjbuQ0a6Q10WufSyL6r465h6RROq+13MpEJcmHHhbBNN7YDa
         VTTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcB0A8NLOEkComPjgqSIbxsaKu/EcgxqyL34ABDIwmaOKQvNxOJjIqDQZ5OhRGzakpeK3yVhN7sXtcMjVmoLkj0868Lpw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyha6JLX0+swRU6phlINHq1DzowQM4CGH4SgSc/vMx9IbPRdrrt
	UA6YlULvcT/g9L91QumbUOQByjl2lVbxefHAJOcQ/ji6zxAFnJxG/gcW34L2vdUOWL53ULiC3CD
	uPnmbYkpdyyzNJIQNiDFTE4LuVG2lT1eK3yKEQVnZ0uO/csB2zRGPccyU+xmtZzNzQQAgXMqNKR
	/zQQ==
X-Gm-Gg: ASbGncublZlXK0+vAxkP2LeAVt3fPvBMNF2QzrRwbfWkNufuj0q86G7aMQN8tdOqksO
	6Uy9GyZ5PrOZW93gTq6/OMzumA/fQIN5oeTG7KnbBkdKgKgsevnRBFvo7MHELfWZLxDiyuWC6o+
	O+eUciD0T1PaCZhlsM9RbIgZ7xP4gVU5BeNs/lth1AH2LWvMnyeTU3Cx5c+ZmpY7TDV2rNJqYoi
	brHlky4LHTqe4bf+Ua/TNMO7RYCIFQ1tw7qs2Sm4z8zfbd8EYo6YenrCW88ADIZUPynM25TPbf5
	/3mXtbeZLRR3ow+jPdDFxox+rJOYyOybSYiuyuUDrGMkeIm8zMPFrtGPzenJjnS8Nh6fBQrGXn8
	e6hz1qBKPrfe2tRrCRGu+Ww==
X-Received: by 2002:a17:907:3f08:b0:b30:c9d5:3adc with SMTP id a640c23a62f3a-b34be8c494cmr2118417566b.49.1759238415133;
        Tue, 30 Sep 2025 06:20:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaYcvIMKoSQC/Zi4TpQRN/u0+h50CyMz6seRvb6OBrTemNIW+nvVtdLh5QN4h5O7N8P4Lpaw==
X-Received: by 2002:a17:907:3f08:b0:b30:c9d5:3adc with SMTP id a640c23a62f3a-b34be8c494cmr2118409866b.49.1759238414408;
        Tue, 30 Sep 2025 06:20:14 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353efa46b2sm1142788766b.24.2025.09.30.06.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 06:20:13 -0700 (PDT)
Date: Tue, 30 Sep 2025 15:20:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, dpsmith@apertussolutions.com, 
	ross.philipson@oracle.com, Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>, 
	Stefan Berger <stefanb@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	open list <linux-kernel@vger.kernel.org>, "open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 10/10] tpm-buf: Enable managed and stack allocations.
Message-ID: <g3ayj2gxzbjmkghbwskrbza2fn546obkul3zistnxvoeie7ync@fpejz33wnpmq>
References: <20250929194832.2913286-1-jarkko@kernel.org>
 <20250929194832.2913286-11-jarkko@kernel.org>
 <u7zay2gb3dff4ptbh34qw7ini63ar3246ivd4xnxtdxc6ijktx@lutatpeg7f7z>
 <aNvW5KMUO2C0i233@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aNvW5KMUO2C0i233@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wNeG1stf9PqBFLpsDK59UQn0pxX-wrGPgnjnXIABOlA_1759238415
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Sep 30, 2025 at 04:11:00PM +0300, Jarkko Sakkinen wrote:
>On Tue, Sep 30, 2025 at 02:44:52PM +0200, Stefano Garzarella wrote:
>> On Mon, Sep 29, 2025 at 10:48:32PM +0300, Jarkko Sakkinen wrote:
>> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>> >
>> > Decouple kzalloc from buffer creation, so that  a managed allocation can be
>> > done trivially:
>> >
>> > 	struct tpm_buf *buf __free(kfree) buf = kzalloc(TPM_BUFSIZE,
>>                                                         ^
>> In the code, we use PAGE_SIZE instead of TPM_BUFSIZE with kzalloc().
>> Should we do the same in this example? (Perhaps adding the reason, if you
>> think it would be useful)
>
>I think that should be fixed up in the patch and use TPM_BUFSIZE
>consistently for kzallocs. Thanks for the remark.

I thought it was done on purpose to alleviate pressure on the allocator 
regardless of the page size value.
In any case, it's up to you, I would just be consistent between the 
example in the commit and the code.

>
>>
>> > 							GFP_KERNEL);
>> > 	if (!buf)
>> > 		return -ENOMEM;
>> > 	tpm_buf_init(buf, TPM_BUFSIZE);
>> >
>> > Alternatively, stack allocations are also possible:
>> >
>> > 	u8 buf_data[512];
>> > 	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
>> > 	tpm_buf_init(buf, sizeof(buf_data));
>> >
>> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>> > ---
>> > v3:
>> > - A new patch from the earlier series with more scoped changes and
>> >  less abstract commit message.
>> > ---
>> > drivers/char/tpm/tpm-buf.c                | 122 +++++----
>> > drivers/char/tpm/tpm-sysfs.c              |  20 +-
>> > drivers/char/tpm/tpm.h                    |   1 -
>> > drivers/char/tpm/tpm1-cmd.c               | 147 +++++------
>> > drivers/char/tpm/tpm2-cmd.c               | 290 ++++++++++------------
>> > drivers/char/tpm/tpm2-sessions.c          | 121 +++++----
>> > drivers/char/tpm/tpm2-space.c             |  44 ++--
>> > drivers/char/tpm/tpm_vtpm_proxy.c         |  30 +--
>> > include/linux/tpm.h                       |  18 +-
>> > security/keys/trusted-keys/trusted_tpm1.c |  34 ++-
>> > security/keys/trusted-keys/trusted_tpm2.c | 176 ++++++-------
>> > 11 files changed, 482 insertions(+), 521 deletions(-)
>> >
>> > diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
>> > index c9e6e5d097ca..1cb649938c01 100644
>> > --- a/drivers/char/tpm/tpm-buf.c
>> > +++ b/drivers/char/tpm/tpm-buf.c
>> > @@ -7,82 +7,109 @@
>> > #include <linux/module.h>
>> > #include <linux/tpm.h>
>> >
>> > -/**
>> > - * tpm_buf_init() - Allocate and initialize a TPM command
>> > - * @buf:	A &tpm_buf
>> > - * @tag:	TPM_TAG_RQU_COMMAND, TPM2_ST_NO_SESSIONS or TPM2_ST_SESSIONS
>> > - * @ordinal:	A command ordinal
>> > - *
>> > - * Return: 0 or -ENOMEM
>> > - */
>> > -int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
>> > +static void __tpm_buf_size_invariant(struct tpm_buf *buf, u16 buf_size)
>> > {
>> > -	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
>> > -	if (!buf->data)
>> > -		return -ENOMEM;
>> > -
>> > -	tpm_buf_reset(buf, tag, ordinal);
>> > -	return 0;
>> > +	u32 buf_size_2 = (u32)buf->capacity + (u32)sizeof(*buf);
>> > +
>> > +	if (!buf->capacity) {
>> > +		if (buf_size > TPM_BUFSIZE) {
>> > +			WARN(1, "%s: size overflow: %u\n", __func__, buf_size);
>> > +			buf->flags |= TPM_BUF_INVALID;
>> > +		}
>> > +	} else {
>> > +		if (buf_size != buf_size_2) {
>> > +			WARN(1, "%s: size mismatch: %u != %u\n", __func__, buf_size,
>> > +			     buf_size_2);
>> > +			buf->flags |= TPM_BUF_INVALID;
>> > +		}
>> > +	}
>> > }
>> > -EXPORT_SYMBOL_GPL(tpm_buf_init);
>> >
>> > -/**
>> > - * tpm_buf_reset() - Initialize a TPM command
>> > - * @buf:	A &tpm_buf
>> > - * @tag:	TPM_TAG_RQU_COMMAND, TPM2_ST_NO_SESSIONS or TPM2_ST_SESSIONS
>> > - * @ordinal:	A command ordinal
>> > - */
>> > -void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
>> > +static void __tpm_buf_reset(struct tpm_buf *buf, u16 buf_size, u16 tag, u32 ordinal)
>> > {
>> > 	struct tpm_header *head = (struct tpm_header *)buf->data;
>> >
>> > +	__tpm_buf_size_invariant(buf, buf_size);
>> > +
>> > +	if (buf->flags & TPM_BUF_INVALID)
>> > +		return;
>> > +
>> > 	WARN_ON(tag != TPM_TAG_RQU_COMMAND && tag != TPM2_ST_NO_SESSIONS &&
>> > 		tag != TPM2_ST_SESSIONS && tag != 0);
>> >
>> > 	buf->flags = 0;
>> > 	buf->length = sizeof(*head);
>> > +	buf->capacity = buf_size - sizeof(*buf);
>> > +	buf->handles = 0;
>> > 	head->tag = cpu_to_be16(tag);
>> > 	head->length = cpu_to_be32(sizeof(*head));
>> > 	head->ordinal = cpu_to_be32(ordinal);
>> > +}
>> > +
>> > +static void __tpm_buf_reset_sized(struct tpm_buf *buf, u16 buf_size)
>> > +{
>> > +	__tpm_buf_size_invariant(buf, buf_size);
>> > +
>> > +	if (buf->flags & TPM_BUF_INVALID)
>> > +		return;
>> > +
>> > +	buf->flags = TPM_BUF_TPM2B;
>> > +	buf->length = 2;
>> > +	buf->capacity = buf_size - sizeof(*buf);
>> > 	buf->handles = 0;
>> > +	buf->data[0] = 0;
>> > +	buf->data[1] = 0;
>> > }
>> > -EXPORT_SYMBOL_GPL(tpm_buf_reset);
>> >
>> > /**
>> > - * tpm_buf_init_sized() - Allocate and initialize a sized (TPM2B) buffer
>> > - * @buf:	A @tpm_buf
>> > - *
>> > - * Return: 0 or -ENOMEM
>> > + * tpm_buf_init() - Initialize a TPM command
>> > + * @buf:	A &tpm_buf
>> > + * @buf_size:	Size of the buffer.
>> >  */
>> > -int tpm_buf_init_sized(struct tpm_buf *buf)
>> > +void tpm_buf_init(struct tpm_buf *buf, u16 buf_size)
>> > {
>> > -	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
>> > -	if (!buf->data)
>> > -		return -ENOMEM;
>> > +	memset(buf, 0, buf_size);
>> > +	__tpm_buf_reset(buf, buf_size, TPM_TAG_RQU_COMMAND, 0);
>> > +}
>> > +EXPORT_SYMBOL_GPL(tpm_buf_init);
>> >
>> > -	tpm_buf_reset_sized(buf);
>> > -	return 0;
>> > +/**
>> > + * tpm_buf_init_sized() - Initialize a sized buffer
>> > + * @buf:	A &tpm_buf
>> > + * @buf_size:	Size of the buffer.
>> > + */
>> > +void tpm_buf_init_sized(struct tpm_buf *buf, u16 buf_size)
>> > +{
>> > +	memset(buf, 0, buf_size);
>> > +	__tpm_buf_reset_sized(buf, buf_size);
>> > }
>> > EXPORT_SYMBOL_GPL(tpm_buf_init_sized);
>> >
>> > /**
>> > - * tpm_buf_reset_sized() - Initialize a sized buffer
>> > + * tpm_buf_reset() - Re-initialize a TPM command
>> >  * @buf:	A &tpm_buf
>> > + * @tag:	TPM_TAG_RQU_COMMAND, TPM2_ST_NO_SESSIONS or TPM2_ST_SESSIONS
>> > + * @ordinal:	A command ordinal
>> >  */
>> > -void tpm_buf_reset_sized(struct tpm_buf *buf)
>> > +void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
>> > {
>> > -	buf->flags = TPM_BUF_TPM2B;
>> > -	buf->length = 2;
>> > -	buf->data[0] = 0;
>> > -	buf->data[1] = 0;
>> > +	u16 buf_size = buf->capacity + sizeof(*buf);
>> > +
>> > +	__tpm_buf_reset(buf, buf_size, tag, ordinal);
>> > }
>> > -EXPORT_SYMBOL_GPL(tpm_buf_reset_sized);
>> > +EXPORT_SYMBOL_GPL(tpm_buf_reset);
>> >
>> > -void tpm_buf_destroy(struct tpm_buf *buf)
>> > +/**
>> > + * tpm_buf_reset_sized() - Re-initialize a sized buffer
>> > + * @buf:	A &tpm_buf
>> > + */
>> > +void tpm_buf_reset_sized(struct tpm_buf *buf)
>> > {
>> > -	free_page((unsigned long)buf->data);
>> > +	u16 buf_size = buf->capacity + sizeof(*buf);
>> > +
>> > +	__tpm_buf_reset_sized(buf, buf_size);
>> > }
>> > -EXPORT_SYMBOL_GPL(tpm_buf_destroy);
>> > +EXPORT_SYMBOL_GPL(tpm_buf_reset_sized);
>> >
>> > /**
>> >  * tpm_buf_length() - Return the number of bytes consumed by the data
>> > @@ -92,6 +119,9 @@ EXPORT_SYMBOL_GPL(tpm_buf_destroy);
>> >  */
>> > u32 tpm_buf_length(struct tpm_buf *buf)
>>
>> Should we update the return value to u16?
>>
>> > {
>> > +	if (buf->flags & TPM_BUF_INVALID)
>> > +		return 0;
>> > +
>> > 	return buf->length;
>> > }
>> > EXPORT_SYMBOL_GPL(tpm_buf_length);
>> > @@ -104,10 +134,12 @@ EXPORT_SYMBOL_GPL(tpm_buf_length);
>> >  */
>> > void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
>> > {
>> > +	u32 total_length = (u32)buf->length + (u32)new_length;
>> > +
>> > 	if (buf->flags & TPM_BUF_INVALID)
>> > 		return;
>> >
>> > -	if ((buf->length + new_length) > PAGE_SIZE) {
>> > +	if (total_length > (u32)buf->capacity) {
>> > 		WARN(1, "tpm_buf: write overflow\n");
>> > 		buf->flags |= TPM_BUF_INVALID;
>> > 		return;
>>
>> [...]
>>
>> > diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
>> > index 636acb66a4f6..6e6a9fb48e63 100644
>> > --- a/security/keys/trusted-keys/trusted_tpm1.c
>> > +++ b/security/keys/trusted-keys/trusted_tpm1.c
>> > @@ -310,9 +310,8 @@ static int TSS_checkhmac2(unsigned char *buffer,
>> >  * For key specific tpm requests, we will generate and send our
>> >  * own TPM command packets using the drivers send function.
>> >  */
>> > -static int trusted_tpm_send(unsigned char *cmd, size_t buflen)
>> > +static int trusted_tpm_send(void *cmd, size_t buflen)
>> > {
>> > -	struct tpm_buf buf;
>> > 	int rc;
>> >
>> > 	if (!chip)
>> > @@ -322,15 +321,12 @@ static int trusted_tpm_send(unsigned char *cmd, size_t buflen)
>> > 	if (rc)
>> > 		return rc;
>> >
>> > -	buf.flags = 0;
>> > -	buf.length = buflen;
>> > -	buf.data = cmd;
>> > 	dump_tpm_buf(cmd);
>> > -	rc = tpm_transmit_cmd(chip, &buf, 4, "sending data");
>> > +	rc = tpm_transmit_cmd(chip, cmd, 4, "sending data");
>>
>> Is it fine here to remove the intermediate tpm_buf ?
>>
>> IIUC tpm_transmit_cmd() needs a tpm_buf, while here we are passing just
>> the "data", or in some way it's a nested tpm_buf?
>>
>> (Sorry if it's a stupid question, but I'm still a bit new with this code).
>>
>> > 	dump_tpm_buf(cmd);
>> >
>> > +	/* Convert TPM error to -EPERM. */
>> > 	if (rc > 0)
>> > -		/* TPM error */
>> > 		rc = -EPERM;
>> >
>> > 	tpm_put_ops(chip);
>> > @@ -624,23 +620,23 @@ static int tpm_unseal(struct tpm_buf *tb,
>> > static int key_seal(struct trusted_key_payload *p,
>> > 		    struct trusted_key_options *o)
>> > {
>> > -	struct tpm_buf tb;
>> > 	int ret;
>> >
>> > -	ret = tpm_buf_init(&tb, 0, 0);
>> > -	if (ret)
>> > -		return ret;
>> > +	struct tpm_buf *tb __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
>> > +	if (!tb)
>> > +		return -ENOMEM;
>> > +
>> > +	tpm_buf_init(tb, TPM_BUFSIZE);
>> >
>> > 	/* include migratable flag at end of sealed key */
>> > 	p->key[p->key_len] = p->migratable;
>> >
>> > -	ret = tpm_seal(&tb, o->keytype, o->keyhandle, o->keyauth,
>> > +	ret = tpm_seal(tb, o->keytype, o->keyhandle, o->keyauth,
>> > 		       p->key, p->key_len + 1, p->blob, &p->blob_len,
>> > 		       o->blobauth, o->pcrinfo, o->pcrinfo_len);
>> > 	if (ret < 0)
>> > 		pr_info("srkseal failed (%d)\n", ret);
>> >
>> > -	tpm_buf_destroy(&tb);
>> > 	return ret;
>> > }
>> >
>> > @@ -650,14 +646,15 @@ static int key_seal(struct trusted_key_payload *p,
>> > static int key_unseal(struct trusted_key_payload *p,
>> > 		      struct trusted_key_options *o)
>> > {
>> > -	struct tpm_buf tb;
>> > 	int ret;
>> >
>> > -	ret = tpm_buf_init(&tb, 0, 0);
>> > -	if (ret)
>> > -		return ret;
>> > +	struct tpm_buf *tb __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
>> > +	if (!tb)
>> > +		return -ENOMEM;
>> > +
>> > +	tpm_buf_init(tb, TPM_BUFSIZE);
>> >
>> > -	ret = tpm_unseal(&tb, o->keyhandle, o->keyauth, p->blob, p->blob_len,
>> > +	ret = tpm_unseal(tb, o->keyhandle, o->keyauth, p->blob, p->blob_len,
>> > 			 o->blobauth, p->key, &p->key_len);
>> > 	if (ret < 0)
>> > 		pr_info("srkunseal failed (%d)\n", ret);
>> > @@ -665,7 +662,6 @@ static int key_unseal(struct trusted_key_payload *p,
>> > 		/* pull migratable flag out of sealed key */
>> > 		p->migratable = p->key[--p->key_len];
>> >
>> > -	tpm_buf_destroy(&tb);
>> > 	return ret;
>> > }
>>
>> The rest LGTM, but it's a huge patch (not your issue at all), so yeah not
>> sure :-)
>
>It's still a single logical change :-)

Yep, and good set of patches to prepare this!

BTW I'm still bit concerned about the changes in trusted_tpm_send() 
which I left a few lines above, can you check it?

Thanks,
Stefano

