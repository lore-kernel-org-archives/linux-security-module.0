Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD96F221D9E
	for <linux-security-module@vger.kernel.org>; Tue, 30 Sep 2025 12:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236306; cv=none; b=XsdIJx4OODxTzV7dJsF5wdjzUgW55Uo3+yytO5SVB0Ztxf14cT4rSmzN/j+VmbW2lr+r3xRm7Za19THxcdIjQYDb1RtN9fltFVTqGI06GJhs6Td5IR1Kckn6FJs5c9hu1fIFLi039w3vH95ly99mSOVCLv8MzhNRrdLQ31aY4Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236306; c=relaxed/simple;
	bh=plNWFStnmBr3tHuQHipBbeJxTWpo2Yn2Mw/O70BkNRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rGMCt2Q7rzQ9UYo4fhLXqKYG3BAf1LN5zdNHQaL5dgjoee7YCotX0vkX5qfYIKhLDaiUd6zexYTyVUSYclgv2x8kPjYgp2NhLygGcyWSiY9G5oLpXiz64k/MTxUJk9LsEQJc9TnvCOEzu+khPd6nqdkee49yKf2A4KaV6+66WPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gvphLpzu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvphLpzu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759236301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QDfkkiLno7LKSndyeERgNrn5us3hUZ9m47HxXngB3Bw=;
	b=gvphLpzuAmuPFLACsTZB/Co6koimJJxllukw9mdufjPdAg2qFf9AETU4s6MsV0eY1eUS9c
	8u9SYGqPnJcJLMHwZovfcGD7k1a8BF4iT7Zyugljdsx/LvN4iOaheXKth3+VNxQfcklw82
	MiZ1ZtnOsu8MHfWKJcZTdP+4dbgiEeA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-XkEM0zotN-aTfYqqp89kAA-1; Tue, 30 Sep 2025 08:45:00 -0400
X-MC-Unique: XkEM0zotN-aTfYqqp89kAA-1
X-Mimecast-MFC-AGG-ID: XkEM0zotN-aTfYqqp89kAA_1759236299
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-632d1317f48so6996488a12.0
        for <linux-security-module@vger.kernel.org>; Tue, 30 Sep 2025 05:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759236299; x=1759841099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDfkkiLno7LKSndyeERgNrn5us3hUZ9m47HxXngB3Bw=;
        b=j244gqOp4aznssR1pzHnF4MjAkdtHLp8/1DwqrYEDEkei9ToHn8xUi9Wvhy7mtwLt4
         m8KBxaC5N4s+ZrNrhxDgsJBkEjjto4L/2/9pGOiGu06ZyAIxuPslMTb1PqLzl+f1qhqD
         c2uE4l6ZIqA84T/HnmJhYdaBWd+HzFoA7ql/CQz1a3MxujQOFhZQzA7jhsGGTP/UV/ZH
         bKQk8esGA5Yr0LaOoi1oQzFba6FKT9KaePmMu3q9I+er39TbTFwwwy4aZzlFAnfSZQAN
         sZ7TxPM6ujl+VSlGPtI5asDNj7qLHvZ9cIB+Hxe7Y3Xc4+m8u57Qb7r6vPkXmbn7jFot
         3kpw==
X-Forwarded-Encrypted: i=1; AJvYcCVrILAGRjNpA9dPAJcULplUsTBEN9Hdq2m1hc+GR0ihAKs305tE9jYVTCdy/TGVGdhKY8jJgLRkcSbAwF6kl9MRGiQKGNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1hBUrDT61Q+ptnCgSpJCXjqFmwQ2QfBZIYHcM1FGxevaHaWzp
	a5MKYjjHX3RYIAo/PSLqc5mjUSqDF9pOlPeqZof/Ur2lq2kUwCQHg5oQ1zq5JrRPB1xqsfB6sm/
	y3k9rfZVXGBjw8wpCdWFeJgvhlaXn4oIf51Cv/13JxrJCQYx+Wf7sjo4Ef+qBHEGB0l/vBsa7Eo
	qpdw==
X-Gm-Gg: ASbGncsGd65JMQlSZl61t2EB8NaxufSrs5DgzwsTcVc2UO6IlIDkj2E91GMqagC69m3
	KIQGfgyEzXhr/j9Mh+VK3j3Ga2omm73hJGcX7xA0Pl7rr7dA/TPS7OCs1UBpkjiJuUBy4oOZHUg
	lUAJ0vHI1MQvhpfWFmgKJPSgjt3JeNUaWNw6vB0z9eWJxYl8A8lt+AE4zRHm311/aPEKOjFnX+Z
	AZXtBf/ER6oEhde3oTBu+fKmTciwFR4FfuXQbnbXLOoKY3j1S5U8kUywok3pNXF7tS0GuxfcGGX
	lDLfh40cKQVewVoP5wYM50k2Wj+uZptY148vgaoe0AvQt0rkDe2ZKDLSQRQnkr+Hi87i9wiEcmM
	DW6c9Zl3/yg4/3pi0W3yBTg==
X-Received: by 2002:aa7:cf8f:0:b0:634:5705:5719 with SMTP id 4fb4d7f45d1cf-6349f9cbc0cmr15654172a12.5.1759236299069;
        Tue, 30 Sep 2025 05:44:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWjX0lAIHN77rTFgsGAB1ZWIvuPTnEmj+YJ9jSx5d90cxaiPJqKI2VaCZxNG01vp+wO4XrHA==
X-Received: by 2002:aa7:cf8f:0:b0:634:5705:5719 with SMTP id 4fb4d7f45d1cf-6349f9cbc0cmr15654146a12.5.1759236298540;
        Tue, 30 Sep 2025 05:44:58 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a362986dsm9595887a12.1.2025.09.30.05.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:44:57 -0700 (PDT)
Date: Tue, 30 Sep 2025 14:44:52 +0200
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
Message-ID: <u7zay2gb3dff4ptbh34qw7ini63ar3246ivd4xnxtdxc6ijktx@lutatpeg7f7z>
References: <20250929194832.2913286-1-jarkko@kernel.org>
 <20250929194832.2913286-11-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250929194832.2913286-11-jarkko@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5TJITCUVcLpNrnfy5tiOHAMaXpECddhwtSpxkRO4ha0_1759236299
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Sep 29, 2025 at 10:48:32PM +0300, Jarkko Sakkinen wrote:
>From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>
>Decouple kzalloc from buffer creation, so that  a managed allocation can be
>done trivially:
>
>	struct tpm_buf *buf __free(kfree) buf = kzalloc(TPM_BUFSIZE,
                                                         ^
In the code, we use PAGE_SIZE instead of TPM_BUFSIZE with kzalloc().
Should we do the same in this example? (Perhaps adding the reason, if 
you think it would be useful)

>							GFP_KERNEL);
>	if (!buf)
>		return -ENOMEM;
>	tpm_buf_init(buf, TPM_BUFSIZE);
>
>Alternatively, stack allocations are also possible:
>
>	u8 buf_data[512];
>	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
>	tpm_buf_init(buf, sizeof(buf_data));
>
>Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>---
>v3:
>- A new patch from the earlier series with more scoped changes and
>  less abstract commit message.
>---
> drivers/char/tpm/tpm-buf.c                | 122 +++++----
> drivers/char/tpm/tpm-sysfs.c              |  20 +-
> drivers/char/tpm/tpm.h                    |   1 -
> drivers/char/tpm/tpm1-cmd.c               | 147 +++++------
> drivers/char/tpm/tpm2-cmd.c               | 290 ++++++++++------------
> drivers/char/tpm/tpm2-sessions.c          | 121 +++++----
> drivers/char/tpm/tpm2-space.c             |  44 ++--
> drivers/char/tpm/tpm_vtpm_proxy.c         |  30 +--
> include/linux/tpm.h                       |  18 +-
> security/keys/trusted-keys/trusted_tpm1.c |  34 ++-
> security/keys/trusted-keys/trusted_tpm2.c | 176 ++++++-------
> 11 files changed, 482 insertions(+), 521 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
>index c9e6e5d097ca..1cb649938c01 100644
>--- a/drivers/char/tpm/tpm-buf.c
>+++ b/drivers/char/tpm/tpm-buf.c
>@@ -7,82 +7,109 @@
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
>+	u32 buf_size_2 = (u32)buf->capacity + (u32)sizeof(*buf);
>+
>+	if (!buf->capacity) {
>+		if (buf_size > TPM_BUFSIZE) {
>+			WARN(1, "%s: size overflow: %u\n", __func__, buf_size);
>+			buf->flags |= TPM_BUF_INVALID;
>+		}
>+	} else {
>+		if (buf_size != buf_size_2) {
>+			WARN(1, "%s: size mismatch: %u != %u\n", __func__, buf_size,
>+			     buf_size_2);
>+			buf->flags |= TPM_BUF_INVALID;
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
>+	if (buf->flags & TPM_BUF_INVALID)
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
>+	if (buf->flags & TPM_BUF_INVALID)
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
>@@ -92,6 +119,9 @@ EXPORT_SYMBOL_GPL(tpm_buf_destroy);
>  */
> u32 tpm_buf_length(struct tpm_buf *buf)

Should we update the return value to u16?

> {
>+	if (buf->flags & TPM_BUF_INVALID)
>+		return 0;
>+
> 	return buf->length;
> }
> EXPORT_SYMBOL_GPL(tpm_buf_length);
>@@ -104,10 +134,12 @@ EXPORT_SYMBOL_GPL(tpm_buf_length);
>  */
> void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
> {
>+	u32 total_length = (u32)buf->length + (u32)new_length;
>+
> 	if (buf->flags & TPM_BUF_INVALID)
> 		return;
>
>-	if ((buf->length + new_length) > PAGE_SIZE) {
>+	if (total_length > (u32)buf->capacity) {
> 		WARN(1, "tpm_buf: write overflow\n");
> 		buf->flags |= TPM_BUF_INVALID;
> 		return;

[...]

>diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
>index 636acb66a4f6..6e6a9fb48e63 100644
>--- a/security/keys/trusted-keys/trusted_tpm1.c
>+++ b/security/keys/trusted-keys/trusted_tpm1.c
>@@ -310,9 +310,8 @@ static int TSS_checkhmac2(unsigned char *buffer,
>  * For key specific tpm requests, we will generate and send our
>  * own TPM command packets using the drivers send function.
>  */
>-static int trusted_tpm_send(unsigned char *cmd, size_t buflen)
>+static int trusted_tpm_send(void *cmd, size_t buflen)
> {
>-	struct tpm_buf buf;
> 	int rc;
>
> 	if (!chip)
>@@ -322,15 +321,12 @@ static int trusted_tpm_send(unsigned char *cmd, size_t buflen)
> 	if (rc)
> 		return rc;
>
>-	buf.flags = 0;
>-	buf.length = buflen;
>-	buf.data = cmd;
> 	dump_tpm_buf(cmd);
>-	rc = tpm_transmit_cmd(chip, &buf, 4, "sending data");
>+	rc = tpm_transmit_cmd(chip, cmd, 4, "sending data");

Is it fine here to remove the intermediate tpm_buf ?

IIUC tpm_transmit_cmd() needs a tpm_buf, while here we are passing just
the "data", or in some way it's a nested tpm_buf?

(Sorry if it's a stupid question, but I'm still a bit new with this 
code).

> 	dump_tpm_buf(cmd);
>
>+	/* Convert TPM error to -EPERM. */
> 	if (rc > 0)
>-		/* TPM error */
> 		rc = -EPERM;
>
> 	tpm_put_ops(chip);
>@@ -624,23 +620,23 @@ static int tpm_unseal(struct tpm_buf *tb,
> static int key_seal(struct trusted_key_payload *p,
> 		    struct trusted_key_options *o)
> {
>-	struct tpm_buf tb;
> 	int ret;
>
>-	ret = tpm_buf_init(&tb, 0, 0);
>-	if (ret)
>-		return ret;
>+	struct tpm_buf *tb __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
>+	if (!tb)
>+		return -ENOMEM;
>+
>+	tpm_buf_init(tb, TPM_BUFSIZE);
>
> 	/* include migratable flag at end of sealed key */
> 	p->key[p->key_len] = p->migratable;
>
>-	ret = tpm_seal(&tb, o->keytype, o->keyhandle, o->keyauth,
>+	ret = tpm_seal(tb, o->keytype, o->keyhandle, o->keyauth,
> 		       p->key, p->key_len + 1, p->blob, &p->blob_len,
> 		       o->blobauth, o->pcrinfo, o->pcrinfo_len);
> 	if (ret < 0)
> 		pr_info("srkseal failed (%d)\n", ret);
>
>-	tpm_buf_destroy(&tb);
> 	return ret;
> }
>
>@@ -650,14 +646,15 @@ static int key_seal(struct trusted_key_payload *p,
> static int key_unseal(struct trusted_key_payload *p,
> 		      struct trusted_key_options *o)
> {
>-	struct tpm_buf tb;
> 	int ret;
>
>-	ret = tpm_buf_init(&tb, 0, 0);
>-	if (ret)
>-		return ret;
>+	struct tpm_buf *tb __free(kfree) = kzalloc(PAGE_SIZE, 
>GFP_KERNEL);
>+	if (!tb)
>+		return -ENOMEM;
>+
>+	tpm_buf_init(tb, TPM_BUFSIZE);
>
>-	ret = tpm_unseal(&tb, o->keyhandle, o->keyauth, p->blob, p->blob_len,
>+	ret = tpm_unseal(tb, o->keyhandle, o->keyauth, p->blob, p->blob_len,
> 			 o->blobauth, p->key, &p->key_len);
> 	if (ret < 0)
> 		pr_info("srkunseal failed (%d)\n", ret);
>@@ -665,7 +662,6 @@ static int key_unseal(struct trusted_key_payload *p,
> 		/* pull migratable flag out of sealed key */
> 		p->migratable = p->key[--p->key_len];
>
>-	tpm_buf_destroy(&tb);
> 	return ret;
> }

The rest LGTM, but it's a huge patch (not your issue at all), so yeah 
not sure :-)

Thanks,
Stefano

