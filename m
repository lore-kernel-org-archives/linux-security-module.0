Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0085B27F74C
	for <linux-security-module@vger.kernel.org>; Mon, 22 Sep 2025 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530810; cv=none; b=YlIhplxc0XJfrnfuV2jt9BDC5m9dKvsx5F2M2DAgWcDjfX08qPHQLqxOs01WXDLeQ3P1cntWs2GH0NzyTUyG6lGGbG72DPhB6Ep24uNIiHBExmCOwXjJikRmaKSWuO5bpmgNWAjAjqvF8LmvdxLAgXSPwUf9nzNLojzMWkS5bnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530810; c=relaxed/simple;
	bh=rux0nTQ+9Ps75XEuL7CDS6cf7zTXqlLDg+FoU++9teE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nlsMwrh+5g6VcxkWFm9XocgQ1QmWeXMoi9EHBd2BTmN1zOlkep0wW4yHM8Os6LiK/IpjJXaRNIHbqD9aIFSaVxczDQ5+3hYDRV8Ff8QlcXeGon1AvxHhA+oTRH4GfBGcJC1OLGcrnsztkKyumzqL6in7PHjGVWYFF+gSy6XoFQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K30FBRK0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K30FBRK0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758530808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l8GHbp8D2RtGBXa6TMzqbqe1udm4TgsD2fx15EVhrsY=;
	b=K30FBRK0iqtzfioW71y7bBOOPdc13TFqWuW93zTSLq4AJuEOs5gadB9/KLcZ3HrVFFPKgB
	REiT4mxAYy2enZDT0zGPzsUT4MpDJg95XHmGzwUf1wq4RQ686eheC2a7obJtTlESFq8BKo
	vrpsqHOO4LwBc0uEfBqb3aDM0P3BwB0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-J2IpvFbSOX2FcrF6AtUiIw-1; Mon, 22 Sep 2025 04:46:45 -0400
X-MC-Unique: J2IpvFbSOX2FcrF6AtUiIw-1
X-Mimecast-MFC-AGG-ID: J2IpvFbSOX2FcrF6AtUiIw_1758530805
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3fba0d9eb87so369502f8f.0
        for <linux-security-module@vger.kernel.org>; Mon, 22 Sep 2025 01:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758530804; x=1759135604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8GHbp8D2RtGBXa6TMzqbqe1udm4TgsD2fx15EVhrsY=;
        b=Zs78CTksHkalLtigXuF2tljwjpZLIz9kYPxplfGLODEPWwoIe4Y27r/SfHWCj6/RyG
         766BZsqMnUOLx6rEpIK037C1aJ11j98BuK38HJVZOBEGqXnKWDibI2dALU6fuB/AWlQ5
         kbVrx7VfFdKytqkw3Dc78aAdBIQ0Q/+fRJdlQEkBYTGqlGzNZc1QV9WA5NMk3+9NfqwI
         XZ1KUe8gkW7oBEkyWJHNAapY1ESfW6lq46tIl7i/teL9CjawhNP2cfdL114Bpbr3OFxO
         D4rIhek4GSTUQ8olgZ9oZl7a/m/oVLOCG6uoQc8NnEPhmBMLRPpQcBEltEd2NxUWqHXi
         lG5w==
X-Forwarded-Encrypted: i=1; AJvYcCV0O96UYCbxA0aPwMwDigr60xwcJJEhBNZNoKmpOl1pbTs4I9B9eLOTbciZSNDCS7OFk1w2XI+yKv/Lo6zSy9WkG8ScUKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyryh/wLoqRoTLQcR0N6+zk4lM2uwVUGH6a8d2ow2vl8ttwcmUC
	v1Ry6RJVWvNVaLWVLLkirQQ+6tMUdNJV4+WUKFkKr9A6w8Hc4C0eTgn/pj3vLj8k3dbXa0wBgfr
	2cywof4dDbeJdJv3VpAc4duDTbrVdz1fpzAPtfCHyJ9mGueBY9CDIwt9EPgGYDuVQrcub92HE6V
	wJKA==
X-Gm-Gg: ASbGncvo9Wc1qTAqLRgT5Dv2zBfYoUXGQ7TY/uCaw32uFR/mj4zec/gEG0EH6NA+Bca
	RywXO5jfRZixlIP0OXu3XdlXlxlxQwXUAD/ZB6xDOMjnAYxeRHSjnT0cwpZsTmIzHwu6QMXIh3Z
	0PbxknRMdDfKtFOQGj4NqZOIFZRcOt4UNts4MQGZCN7o2uYvMRg/EWK/b39f5q2Hxbo0EVN8QvH
	6sW295Orcaoy4NQDlm1IUljriso9DyLofPUWQYCp1mUrgM4/HON24tK7vG+yYqvo2hdRdJg9sZu
	dEef3VXqcoKXuJBUuwRb+omzRwRvOySP32lbBuDEvg==
X-Received: by 2002:a5d:63cb:0:b0:3f7:ce62:ce17 with SMTP id ffacd0b85a97d-3f7ce62d110mr3512221f8f.38.1758530804588;
        Mon, 22 Sep 2025 01:46:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFIdF26ri8nPLU1h2hF0oUN4DiGv6MueO1DVBaFqmOzwLifco/ttVWeCoGXOHOK8CouN8qOA==
X-Received: by 2002:a5d:63cb:0:b0:3f7:ce62:ce17 with SMTP id ffacd0b85a97d-3f7ce62d110mr3512199f8f.38.1758530804128;
        Mon, 22 Sep 2025 01:46:44 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.126.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f829e01a15sm7668492f8f.57.2025.09.22.01.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:46:43 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:46:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, 
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	open list <linux-kernel@vger.kernel.org>, "open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v10 4/4] tpm_vpm_proxy: Use stack for TPM_CC_SET_LOCALITY
Message-ID: <swkdunznhlk5atrdfsiud57uzcvkmknnarzfh6esq3xzy74tmk@2qqsv6tvdtlw>
References: <20250921020804.1088824-1-jarkko@kernel.org>
 <20250921020804.1088824-5-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250921020804.1088824-5-jarkko@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O6nf3DDmr946ANQ_LdvXnpLf-OE1pvy3xCNDe4pH5XM_1758530805
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sun, Sep 21, 2025 at 05:08:04AM +0300, Jarkko Sakkinen wrote:
>From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>
>Use stack allocation for TPM_CC_SET_LOCALITY, as it has known fixed size.
>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>---
> drivers/char/tpm/tpm1-cmd.c       |  2 +-
> drivers/char/tpm/tpm_vtpm_proxy.c | 12 +++++-------
> 2 files changed, 6 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
>index 11c16ad9b2a7..433908cfb4a9 100644
>--- a/drivers/char/tpm/tpm1-cmd.c
>+++ b/drivers/char/tpm/tpm1-cmd.c
>@@ -328,7 +328,7 @@ static int tpm1_startup(struct tpm_chip *chip)
> 	int rc;
>
> 	dev_info(&chip->dev, "TPM_Startup\n");
>-	tpm_buf_init(buf, TPM_BUF_INT_SIZE);
>+	tpm_buf_init(buf, TPM_BUF_MIN_SIZE);

This change should be squashed in patch 2, right?

Thanks,
Stefano

> 	tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_STARTUP);
> 	tpm_buf_append_u16(buf, TPM_ST_CLEAR);
> 	rc = tpm_transmit_cmd(chip, buf, 0, "TPM_Startup");
>diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
>index e5de14379eb2..0f1b1b67ed4e 100644
>--- a/drivers/char/tpm/tpm_vtpm_proxy.c
>+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
>@@ -395,15 +395,13 @@ static bool vtpm_proxy_tpm_req_canceled(struct tpm_chip  *chip, u8 status)
>
> static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
> {
>-	int rc;
>-	const struct tpm_header *header;
> 	struct proxy_dev *proxy_dev = dev_get_drvdata(&chip->dev);
>+	u8 buf_data[TPM_BUF_MIN_SIZE];
>+	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
>+	const struct tpm_header *header;
>+	int rc;
>
>-	struct tpm_buf *buf __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
>-	if (!buf)
>-		return -ENOMEM;
>-
>-	tpm_buf_init(buf, TPM_BUF_MAX_SIZE);
>+	tpm_buf_init(buf, TPM_BUF_MIN_SIZE);
> 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> 		tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_SET_LOCALITY);
> 	else
>-- 
>2.39.5
>

