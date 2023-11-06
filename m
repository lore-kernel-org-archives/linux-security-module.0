Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56BEC4167D
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Nov 2023 19:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjKFTiu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 Nov 2023 14:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjKFTid (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Nov 2023 14:38:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042EE1BCE
        for <linux-security-module@vger.kernel.org>; Mon,  6 Nov 2023 11:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699299392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/7nXQhaGb4pY7ry3e+e6wtXTEqqn1g4LsKBGCFFbdOs=;
        b=ERzm/1QwOow7iXN98aJ9Cld1a/1q7EBVufwm9bHA5dss7T3mXDyPVYG5UUglRJyplY62/3
        ufkFPHoTUd846EaU4U/YAOKvaAawVH2Z3aF24KQgOskISlHOiLbAZla3Ex+JZgbxyac/fq
        8KxaCoIopQZB+hCKAh5k05LnnqySFDw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-15JXefsWNKGUau_hSunS6A-1; Mon, 06 Nov 2023 14:36:31 -0500
X-MC-Unique: 15JXefsWNKGUau_hSunS6A-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-77a51a90d6cso531283385a.0
        for <linux-security-module@vger.kernel.org>; Mon, 06 Nov 2023 11:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699299391; x=1699904191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7nXQhaGb4pY7ry3e+e6wtXTEqqn1g4LsKBGCFFbdOs=;
        b=hHOUjYpVBU0IZltUGClBLqyj7ngp2SzX6XfDZrWbcvhBQtBMEo4l1lpNJwS//JFdVP
         tr3i2AEJ65E+RLJaad1lqVjnEGErhkWKDrujlEB+EmmcaYUXcwBntUeXfh4r4ChalQhU
         2eSTHMtB46ID0VPsccbyHmqjhra2PaXZWGEUWf6gpMpQth86aNhk6A43JxbGOwy8r3vW
         2ZAu1d+vMbOiADXn0nFlVi0g1NOrAJh2ouThmlsty+cb9nYPnYJ1BElwU4g/KZrI3kzE
         6rtkReNecKIw+d1M4uOlH4VXyODyXM5LKKVsFfr3RqvZcqXgPsWeJ7HqIcB9y4Sgv+O0
         V09w==
X-Gm-Message-State: AOJu0Ywkzv7bKnTZ43+lBxepqeG9Cky+SXuoph/soAQQmBDseIk7EPjS
        BBPMP7dr1ywO/B8MTaHV89/gLsmDP7A66yEQYfWEwRI9xpY0a1DPMhhwu6vMhdSqENAYQA0+V2B
        qI4ZzEX98a2LJA168jA4QTE8wSkJFO4PLm6nG
X-Received: by 2002:a05:620a:118e:b0:775:f1bd:f75e with SMTP id b14-20020a05620a118e00b00775f1bdf75emr29927583qkk.39.1699299391176;
        Mon, 06 Nov 2023 11:36:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNkybdYX04EQtC/tz+Zpa+0fOVbb/hUPD57Vng3tHmEY+2ovmvEntRX3G/+cgNqoXu8DTZmg==
X-Received: by 2002:a05:620a:118e:b0:775:f1bd:f75e with SMTP id b14-20020a05620a118e00b00775f1bdf75emr29927560qkk.39.1699299390943;
        Mon, 06 Nov 2023 11:36:30 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id qs16-20020a05620a395000b00774133fb9a3sm3537442qkn.114.2023.11.06.11.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 11:36:30 -0800 (PST)
Date:   Mon, 6 Nov 2023 12:36:29 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Julien Gomes <julien@arista.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] tpm: Store TPM buffer length
Message-ID: <4gyb46g6makecsv7mq67qdp5hilytpymvdbffz5q64tday5dva@wjg3achi5rrv>
References: <20231024011531.442587-1-jarkko@kernel.org>
 <20231024011531.442587-3-jarkko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231024011531.442587-3-jarkko@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 24, 2023 at 04:15:20AM +0300, Jarkko Sakkinen wrote:
> Both TPM commands and sized buffers (TPM2B) have a fixed size header, which
> is followed by the body. Store TPM buffer length to a new field in the
> struct tpm_buf.
> 
> The invariant here is that the length field must always contain the total
> length of the buffer, i.e. the sum header and body length. The value must
> then be mapped to the length representation of the buffer type, and this
> correspondence must be maintained.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm-buf.c                | 36 ++++++++++++++++-------
>  drivers/char/tpm/tpm-interface.c          | 18 +++++++++---
>  include/linux/tpm.h                       | 10 +++----
>  security/keys/trusted-keys/trusted_tpm1.c |  8 ++---
>  4 files changed, 49 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index 88ce1a5402de..8dc6b9db006b 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -18,6 +18,12 @@ int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_init);
>  
> +/**
> + * tpm_buf_reset() - Initialize a TPM command
> + * @buf:	A @tpm_buf

One minor thing I meant to mention, did you intend this to be &tpm_buf like it
is for tpm_buf_append?

Regards,
Jerry

