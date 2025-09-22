Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A4E275860
	for <linux-security-module@vger.kernel.org>; Mon, 22 Sep 2025 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530691; cv=none; b=oOY1g3+QdpCsq5yLN7SZRFznZT+kHdxzzHhxMuqrPU1vGtLuz04qHDvhjZFiurC7xCT4taBPAxczKp6TEm6gQhynG56/xVibnq5+wcQmEBZ5XB5h0VNqNDSJueNaBvqsro9nWt9Hz8/s+PUF7FhVd4oGi2DxZnvM6kLaV/YNuus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530691; c=relaxed/simple;
	bh=/lYY992jo6dwvyOrykn/QqtoSYN8ghdvttCaoUSP4Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ocHSlKbPczi/0Z2nkA5NAQGzIIJ4pezBAh5yNDmIMHJxQs2P0fBETOAPtstR79DJwkolM8SriYmewJ/t3HIaH7k2ei4ho+iEsY5euM6goFwfX3/C4hpoLcn11jes++UWnjo6r9kPvDsi4lGqmabZpywRqkGVmXBvpGEGV9hQ+x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQwGPNYD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQwGPNYD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758530688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P/+uxcjP9fWI+c2xTF/N/+clN0TairK0JazX06lfdQc=;
	b=dQwGPNYDol3rXyQ1+vuLYnJBxTKF4ob3AQjis+35PRrlCzrJr4DAOnTddfv1sOVXRhF5r0
	7m6QyN6okCMcBz5zpdaO58n+uD8mvh8TPg6nabn467HkwLdVPSyUxEw7WkaXmT2SB2bF/r
	ub/FKxJ2WKlg+RmeBd6gsZrLtnCzDSM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-ntkd0rztPvWzRFZPXOW30w-1; Mon, 22 Sep 2025 04:44:46 -0400
X-MC-Unique: ntkd0rztPvWzRFZPXOW30w-1
X-Mimecast-MFC-AGG-ID: ntkd0rztPvWzRFZPXOW30w_1758530684
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ccd58af2bbso2128988f8f.0
        for <linux-security-module@vger.kernel.org>; Mon, 22 Sep 2025 01:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758530684; x=1759135484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/+uxcjP9fWI+c2xTF/N/+clN0TairK0JazX06lfdQc=;
        b=MH7UERQiRSESpH9LUd1ntVCsPBQXClL4GzdlogzL5nHTFILlZYYlOnkHrs+ensHkO5
         dysgKIvrnGY7t+MwwvTSZ9JR0SxMJsR2tpTa+MOZeNkcjQ9g0LIRhO9aj2M1Ok1+gA4R
         meMea1UKJFyN7mAS6X1IoCj82StlyQMrdZvpn3jYHQia9ufelr/ix0Otvw9ErGErRbdr
         iJxzmqTMTnYyCXxqOV/064jZbpMvyQRrx5LeFhBFNMVwi0nqWfqGf6MXtKKuN22dCEEi
         IYp1T49m9giRCswVgt/cWY5IRKK68pqOaorkDXWiNhKE20SnxwsjTqARikKkIUDAfBsz
         FJAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVHHJdD7PgQFqpXYcka2Y5F4To8J5DteU0ZKlsftRS4NooSSFj4l00irtof9tVBMQ1Pi5l554O8T3tOkIXlU+Z0OCu+fY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNY96B2DDobHyi9ABzq7zHgWGXlhH07yWG9gfWFbD2p3qTLDcr
	dv9VPNWxG9WYjlPJG5XA6HeegScYueAoV9JdT/K5jcxZymEyP6a+ELocVK3PKJ6Cb23Uh7BabCt
	BUtXc9dpNiZJVJ2c1qJ5ISvtlMM/4xbHYhOcXyn1GoCmJQxz2HMaXM4nrXqFMKj+GKOzsLtMAKN
	Z6PA==
X-Gm-Gg: ASbGncs6NrIUu+dyoun1oqcfeKxuAEb/4hqKHwo+ibl9LKYr+cKlFxBr38YvzeskgkG
	AJ347mOkTr0TuwkleEn/szb9OUG0oB2A5e093//I5MQzS+UCVRBf4TNr1gL79IKmplc+jBS2TzC
	z5ZQoLwWY724i/qtJceakprZQcS/xofFV7rpdrkFZwpZ1PCUeKUdPBsxjbCtMLdhlr3Dq29kBgU
	VTZ2JERyI2obLrPedDgAwuhhlqn9ZwCZAE+/Xk0XNpyWzSlmpVeEmOPb4euxweNL0bxRXB5FYJb
	0u+KUm/1c/I7Qpo8NWTzPMacFMa/izPMimWRaQ8u5A==
X-Received: by 2002:a5d:64e9:0:b0:3e9:978e:48dd with SMTP id ffacd0b85a97d-3ee15e39879mr12461064f8f.2.1758530683928;
        Mon, 22 Sep 2025 01:44:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtWt+UVR766wKTXxmYhZTMxtUVHEupY/D25v73MlecwxOwEeRqHkH93X6Dw9X2sTWtWdi2Iw==
X-Received: by 2002:a5d:64e9:0:b0:3e9:978e:48dd with SMTP id ffacd0b85a97d-3ee15e39879mr12461015f8f.2.1758530683289;
        Mon, 22 Sep 2025 01:44:43 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.126.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f3d68sm19113645f8f.10.2025.09.22.01.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:44:42 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:44:34 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, 
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	open list <linux-kernel@vger.kernel.org>, "open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v10 1/4] tpm: Make TPM buffer allocations more robust
Message-ID: <gg6tsuyhnopcwed3zr7p7ikjq3vqi4ijxwfxjqwscx5hjk7lk2@w7e32ofhufov>
References: <20250921020804.1088824-1-jarkko@kernel.org>
 <20250921020804.1088824-2-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250921020804.1088824-2-jarkko@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rIsE3o_wPrw3xiSQrTow0IF3IY1QkVs7voSCOdNjmEk_1758530684
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sun, Sep 21, 2025 at 05:08:01AM +0300, Jarkko Sakkinen wrote:
>From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>
>Create more ergonomic primitives to work with TPM buffers, where
>'tpm_buf_init*' initialize the memory and 'tpm_buf_reset*' (re)set a buffer
>for a particular use and purpose. The new primitives are ubiquitos when
>it comes to heap and stack usage.
>
>Given that the kzalloc is decoupled, a managed allocation can be done
>trivially:
>
>	struct tpm_buf *buf __free(kfree) buf = kzalloc(TPM_BUF_MAX_SIZE,
>							GFP_KERNEL);
>
>This effectively zeros out the odds having any memory leaks with TPM
>buffers. The new structures can be later used to widen the use of stack
>over heap in the subsystem in the critical code paths..
>
>Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>---
>v10:
>- No changes.
>v9:
>- Rename pre-existing TPM_BUFSIZE as TPM_BUF_MAX_SIZE and redeclare
>  it in include/linux/tpm.h, and use this constant instead of
>  PAGE_SIZE in tpm_buf_init*. Define TPM_BUF_MIN_SIZE to be a
>  sane placeholder value for stack allocations.
>- Fix and restructure invariant for the sake of clarity.
>- memset buffers to zero in tpm_buf_init* in order to guarantee a legit
>  initial state. This does not cause any regressions but once tpm_buf
>  is allocaed from stack at some site, this will zero out chance of
>  corrupted state.
>v8:
>- Decouple memory init i.e. bring tpm_init* back but with new fresh
>  form.
>- Cap buf_size to page size and also make checks in tpm_buf_append
>  safe:
>  https://lore.kernel.org/linux-integrity/hwsx2t2tkbos3g7k2syemxbvc6sfrsbviwm64ubcdl6ms7ljvo@toetomkhheht/
>- Fix trusted_tpm_send() and simplify the flow.
>v7:
>- Additional function comments and invariant was unfortunately left to
>  my staging area so here's the addition (does not affect functionality).
>v6:
>- Removed two empty lines as requested by Stefan:
>  https://lore.kernel.org/linux-integrity/be1c5bef-7c97-4173-b417-986dc90d779c@linux.ibm.com/
>- Add 'capacity' field as this makes easy to stretch tpm_buf into stack
>  allocation.
>v5:
>- I tested this version also with TPM 1.2 by booting up and checking
>  that sysfs attributes work.
>- Fixed the length check against capacity (James) with TPM_BUF_CAPACITY.
>- Fixed declaration style: do it at the site (Jason).
>- Improved commit message (Stefan).
>- Removed "out" label from tpm2_pcr_read() (Stefan).
>- Removed spurious "return rc;" from tpm2_get_pcr_allocation() (Stefan).
>v4:
>- Wrote a more a descriptive short summary and improved description.
>- Fixed the error in documentation: there is 4090 bytes of space left
>  for the payload - not 4088 bytes.
>- Turned tpm_buf_alloc() into inline function.
>v3:
>- Removed the cleanup class and moved on using __free(kfree) instead.
>- Removed `buf_size` (James).
>- I'm open for the idea of splitting still (Jason) but I'll hold
>  at least this revision just to check that my core idea here
>  is correct.
>v2:
>- Implement also memory allocation using the cleanup class.
>- Rewrote the commit message.
>- Implemented CLASS_TPM_BUF() helper macro.
>---
> drivers/char/tpm/tpm-buf.c                | 137 +++++++----
> drivers/char/tpm/tpm-dev-common.c         |   4 +-
> drivers/char/tpm/tpm-dev.h                |   2 +-
> drivers/char/tpm/tpm-interface.c          |   4 +-
> drivers/char/tpm/tpm-sysfs.c              |  20 +-
> drivers/char/tpm/tpm.h                    |   3 +-
> drivers/char/tpm/tpm1-cmd.c               | 149 ++++++------
> drivers/char/tpm/tpm2-cmd.c               | 282 ++++++++++------------
> drivers/char/tpm/tpm2-sessions.c          | 121 +++++-----
> drivers/char/tpm/tpm2-space.c             |  44 ++--
> drivers/char/tpm/tpm_tis_i2c.c            |   4 +-
> drivers/char/tpm/tpm_vtpm_proxy.c         |  32 ++-
> include/linux/tpm.h                       |  28 ++-
> security/keys/trusted-keys/trusted_tpm1.c |  34 ++-
> security/keys/trusted-keys/trusted_tpm2.c | 156 ++++++------
> 15 files changed, 493 insertions(+), 527 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
>index dc882fc9fa9e..82dce0350a41 100644
>--- a/drivers/char/tpm/tpm-buf.c
>+++ b/drivers/char/tpm/tpm-buf.c
>@@ -7,82 +7,107 @@
> #include <linux/module.h>
> #include <linux/tpm.h>
>
>-/**
>- * tpm_buf_init() - Allocate and initialize a TPM command
>- * @buf:	A &tpm_buf
>- * @tag:	TPM_TAG_RQU_COMMAND, TPM2_ST_NO_SESSIONS or TPM2_ST_SESSIONS
>- * @ordinal:	A command ordinal
>- *
>- * Return: 0 or -ENOMEM
>- */
>-int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
>+static void __tpm_buf_size_invariant(struct tpm_buf *buf, u16 buf_size)
> {
>-	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
>-	if (!buf->data)
>-		return -ENOMEM;
>-
>-	tpm_buf_reset(buf, tag, ordinal);
>-	return 0;
>+	if (!buf->capacity) {
>+		if (buf_size > TPM_BUF_MAX_SIZE) {
>+			WARN(1, "%s: size overflow: %u\n", __func__, buf_size);

IIUC here we will always print something like:
     "__tpm_buf_size_invariant: size overflow: XXX"

So, should we just remove `__func__` or maybe use a macro to print the 
name of the caller?

>+			buf->flags |= TPM_BUF_ERROR;
>+		}
>+	} else {
>+		if (buf_size != buf->capacity + sizeof(*buf)) {
>+			WARN(1, "%s: size mismatch: %u != %u\n", __func__, buf_size,
>+			     buf->capacity + sizeof(*buf));
>+			buf->flags |= TPM_BUF_ERROR;
>+		}
>+	}
> }
>-EXPORT_SYMBOL_GPL(tpm_buf_init);
>
>-/**
>- * tpm_buf_reset() - Initialize a TPM command
>- * @buf:	A &tpm_buf
>- * @tag:	TPM_TAG_RQU_COMMAND, TPM2_ST_NO_SESSIONS or TPM2_ST_SESSIONS
>- * @ordinal:	A command ordinal
>- */
>-void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
>+static void __tpm_buf_reset(struct tpm_buf *buf, u16 buf_size, u16 tag, u32 ordinal)
> {
> 	struct tpm_header *head = (struct tpm_header *)buf->data;
>
>+	__tpm_buf_size_invariant(buf, buf_size);
>+
>+	if (buf->flags & TPM_BUF_ERROR)
>+		return;
>+
> 	WARN_ON(tag != TPM_TAG_RQU_COMMAND && tag != TPM2_ST_NO_SESSIONS &&
> 		tag != TPM2_ST_SESSIONS && tag != 0);
>
> 	buf->flags = 0;
> 	buf->length = sizeof(*head);
>+	buf->capacity = buf_size - sizeof(*buf);
>+	buf->handles = 0;
> 	head->tag = cpu_to_be16(tag);
> 	head->length = cpu_to_be32(sizeof(*head));
> 	head->ordinal = cpu_to_be32(ordinal);
>+}
>+
>+static void __tpm_buf_reset_sized(struct tpm_buf *buf, u16 buf_size)
>+{
>+	__tpm_buf_size_invariant(buf, buf_size);
>+
>+	if (buf->flags & TPM_BUF_ERROR)
>+		return;
>+
>+	buf->flags = TPM_BUF_TPM2B;
>+	buf->length = 2;
>+	buf->capacity = buf_size - sizeof(*buf);
> 	buf->handles = 0;
>+	buf->data[0] = 0;
>+	buf->data[1] = 0;
> }
>-EXPORT_SYMBOL_GPL(tpm_buf_reset);
>
> /**
>- * tpm_buf_init_sized() - Allocate and initialize a sized (TPM2B) buffer
>- * @buf:	A @tpm_buf
>- *
>- * Return: 0 or -ENOMEM
>+ * tpm_buf_init() - Initialize a TPM command
>+ * @buf:	A &tpm_buf
>+ * @buf_size:	Size of the buffer.
>  */
>-int tpm_buf_init_sized(struct tpm_buf *buf)
>+void tpm_buf_init(struct tpm_buf *buf, u16 buf_size)
> {
>-	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
>-	if (!buf->data)
>-		return -ENOMEM;
>+	memset(buf, 0, buf_size);
>+	__tpm_buf_reset(buf, buf_size, TPM_TAG_RQU_COMMAND, 0);
>+}
>+EXPORT_SYMBOL_GPL(tpm_buf_init);
>
>-	tpm_buf_reset_sized(buf);
>-	return 0;
>+/**
>+ * tpm_buf_init_sized() - Initialize a sized buffer
>+ * @buf:	A &tpm_buf
>+ * @buf_size:	Size of the buffer.
>+ */
>+void tpm_buf_init_sized(struct tpm_buf *buf, u16 buf_size)
>+{
>+	memset(buf, 0, buf_size);
>+	__tpm_buf_reset_sized(buf, buf_size);
> }
> EXPORT_SYMBOL_GPL(tpm_buf_init_sized);
>
> /**
>- * tpm_buf_reset_sized() - Initialize a sized buffer
>+ * tpm_buf_reset() - Re-initialize a TPM command
>  * @buf:	A &tpm_buf
>+ * @tag:	TPM_TAG_RQU_COMMAND, TPM2_ST_NO_SESSIONS or TPM2_ST_SESSIONS
>+ * @ordinal:	A command ordinal
>  */
>-void tpm_buf_reset_sized(struct tpm_buf *buf)
>+void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
> {
>-	buf->flags = TPM_BUF_TPM2B;
>-	buf->length = 2;
>-	buf->data[0] = 0;
>-	buf->data[1] = 0;
>+	u16 buf_size = buf->capacity + sizeof(*buf);
>+
>+	__tpm_buf_reset(buf, buf_size, tag, ordinal);
> }
>-EXPORT_SYMBOL_GPL(tpm_buf_reset_sized);
>+EXPORT_SYMBOL_GPL(tpm_buf_reset);
>
>-void tpm_buf_destroy(struct tpm_buf *buf)
>+/**
>+ * tpm_buf_reset_sized() - Re-initialize a sized buffer
>+ * @buf:	A &tpm_buf
>+ */
>+void tpm_buf_reset_sized(struct tpm_buf *buf)
> {
>-	free_page((unsigned long)buf->data);
>+	u16 buf_size = buf->capacity + sizeof(*buf);
>+
>+	__tpm_buf_reset_sized(buf, buf_size);
> }
>-EXPORT_SYMBOL_GPL(tpm_buf_destroy);
>+EXPORT_SYMBOL_GPL(tpm_buf_reset_sized);
>
> /**
>  * tpm_buf_length() - Return the number of bytes consumed by the data
>@@ -92,6 +117,9 @@ EXPORT_SYMBOL_GPL(tpm_buf_destroy);
>  */
> u32 tpm_buf_length(struct tpm_buf *buf)
> {
>+	if (buf->flags & TPM_BUF_ERROR)
>+		return 0;
>+
> 	return buf->length;
> }
> EXPORT_SYMBOL_GPL(tpm_buf_length);
>@@ -104,13 +132,14 @@ EXPORT_SYMBOL_GPL(tpm_buf_length);
>  */
> void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
> {
>-	/* Return silently if overflow has already happened. */
>-	if (buf->flags & TPM_BUF_OVERFLOW)
>+	u32 total_length = (u32)buf->length + (u32)new_length;
>+
>+	if (buf->flags & TPM_BUF_ERROR)
> 		return;
>
>-	if ((buf->length + new_length) > PAGE_SIZE) {
>+	if (total_length > (u32)buf->capacity) {
> 		WARN(1, "tpm_buf: write overflow\n");
>-		buf->flags |= TPM_BUF_OVERFLOW;
>+		buf->flags |= TPM_BUF_ERROR;
> 		return;
> 	}
>
>@@ -157,8 +186,12 @@ EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
>  */
> void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle)
> {
>+	if (buf->flags & TPM_BUF_ERROR)
>+		return;
>+
> 	if (buf->flags & TPM_BUF_TPM2B) {
>-		dev_err(&chip->dev, "Invalid buffer type (TPM2B)\n");
>+		dev_err(&chip->dev, "%s: invalid for buffer type: TPM2B\n", __func__);
>+		buf->flags |= TPM_BUF_ERROR;
> 		return;
> 	}
>
>@@ -178,13 +211,13 @@ static void tpm_buf_read(struct tpm_buf *buf, off_t *offset, size_t count, void
> 	off_t next_offset;
>
> 	/* Return silently if overflow has already happened. */
>-	if (buf->flags & TPM_BUF_BOUNDARY_ERROR)
>+	if (buf->flags & TPM_BUF_ERROR)
> 		return;
>
> 	next_offset = *offset + count;
> 	if (next_offset > buf->length) {
> 		WARN(1, "tpm_buf: read out of boundary\n");
>-		buf->flags |= TPM_BUF_BOUNDARY_ERROR;
>+		buf->flags |= TPM_BUF_ERROR;
> 		return;
> 	}
>
>@@ -242,5 +275,3 @@ u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset)
> 	return be32_to_cpu(value);
> }
> EXPORT_SYMBOL_GPL(tpm_buf_read_u32);
>-
>-
>diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
>index f2a5e09257dd..4f5893555fb7 100644
>--- a/drivers/char/tpm/tpm-dev-common.c
>+++ b/drivers/char/tpm/tpm-dev-common.c
>@@ -147,7 +147,7 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
>
> 		rc = copy_to_user(buf, priv->data_buffer + *off, 
> 		ret_size);
> 		if (rc) {
>-			memset(priv->data_buffer, 0, TPM_BUFSIZE);
>+			memset(priv->data_buffer, 0, TPM_BUF_MAX_SIZE);
> 			priv->response_length = 0;
> 			ret_size = -EFAULT;
> 		} else {
>@@ -173,7 +173,7 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
> 	struct file_priv *priv = file->private_data;
> 	int ret = 0;
>
>-	if (size > TPM_BUFSIZE)
>+	if (size > TPM_BUF_MAX_SIZE)
> 		return -E2BIG;
>
> 	mutex_lock(&priv->buffer_mutex);
>diff --git a/drivers/char/tpm/tpm-dev.h b/drivers/char/tpm/tpm-dev.h
>index f3742bcc73e3..700e3d9d8b64 100644
>--- a/drivers/char/tpm/tpm-dev.h
>+++ b/drivers/char/tpm/tpm-dev.h
>@@ -18,7 +18,7 @@ struct file_priv {
> 	bool response_read;
> 	bool command_enqueued;
>
>-	u8 data_buffer[TPM_BUFSIZE];
>+	u8 data_buffer[TPM_BUF_MAX_SIZE];
> };
>
> void tpm_common_open(struct file *file, struct tpm_chip *chip,
>diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>index c9f173001d0e..b0d5098fb92b 100644
>--- a/drivers/char/tpm/tpm-interface.c
>+++ b/drivers/char/tpm/tpm-interface.c
>@@ -100,8 +100,8 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> 	if (bufsiz < TPM_HEADER_SIZE)
> 		return -EINVAL;
>
>-	if (bufsiz > TPM_BUFSIZE)
>-		bufsiz = TPM_BUFSIZE;
>+	if (bufsiz > TPM_BUF_MAX_SIZE)
>+		bufsiz = TPM_BUF_MAX_SIZE;
>
> 	count = be32_to_cpu(header->length);
> 	ordinal = be32_to_cpu(header->ordinal);
>diff --git a/drivers/char/tpm/tpm-sysfs.c 
>b/drivers/char/tpm/tpm-sysfs.c
>index 94231f052ea7..4213a8285ed0 100644
>--- a/drivers/char/tpm/tpm-sysfs.c
>+++ b/drivers/char/tpm/tpm-sysfs.c
>@@ -32,28 +32,30 @@ struct tpm_readpubek_out {
> static ssize_t pubek_show(struct device *dev, struct device_attribute *attr,
> 			  char *buf)
> {
>-	struct tpm_buf tpm_buf;
> 	struct tpm_readpubek_out *out;
> 	int i;
> 	char *str = buf;
> 	struct tpm_chip *chip = to_tpm_chip(dev);
> 	char anti_replay[20];
>
>+	struct tpm_buf *tpm_buf __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);

We're using PAGE_SIZE instead of TPM_BUF_MAX_SIZE to reduce the pressure 
on the allocator, right?

I was wondering if we could create an inline function or a macro that 
calls kzalloc() and tpm_buf_init().
Just because we do it often, it's not a strong opinion, just something 
that came to mind while doing the review.
I mean something like this (untested):

struct tpm_buf *tpm_buf_alloc_max(void) {
	struct tpm_buf *buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
	if (!buf)
		return NULL;

	tpm_buf_init(buf, TPM_BUF_MAX_SIZE);
	return buf;
}

Thanks,
Stefano

