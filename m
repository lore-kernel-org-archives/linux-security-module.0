Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF75A271A9A
	for <linux-security-module@vger.kernel.org>; Wed, 19 Nov 2025 03:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763524528; cv=none; b=hj0eykZNxjF8Q+p0o6pPiXepHBjQZf93Da5FwwMpH8L4CaAbdkWqO26vEZzWv9sNf/PrKbOrpnieoxhw+q8LuZtZ8gTrpVgfu7MmF8nJ9WxVzBPbh+bdygiPxBrnmEG8IbxpdkwQhSDFaBlF1zQeU8hzh2wUHPJSlRah4Vv4w0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763524528; c=relaxed/simple;
	bh=fexWQRxO1qDL1NeW3IczgGoSbv++XLaMMQy8gWodcVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XdcMh+luxymOSoTzj9sfuco7RGlkpxsH+Oa+u6CWUAjohWK+UJoZbFO15OlL95vhgXXjrGH+G6/H2NZSehUnlJbGmXi7eGBQVYSMXKRzbAl9tP12w0+h+HSqSvw8XovXtryAivLvLoD434YKympvcemTnrEx+D4yQosiHFTcLnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AUg1qrkj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUg1qrkj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763524525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ooCsRVhcTHqfbP0l9J8al+EICyTsRGhauAL5pmZkQRo=;
	b=AUg1qrkj+sMoHTJertH7D1hASiJesk5lJKEFzsyVbd2Ii+nsgROavD6xnu459upqs/axGm
	dc7993lhf8UXoiCE6j1N+GzpePjm/ow/LjGs4rFp0qYUI1318rX7CY1TVYtigzXZpKwHs3
	hzzp9Ds1uIxZ+qiFTleqy/FXV5aJMGE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-FlzhmF6GNnS3-qGK2w5QZg-1; Tue, 18 Nov 2025 22:55:24 -0500
X-MC-Unique: FlzhmF6GNnS3-qGK2w5QZg-1
X-Mimecast-MFC-AGG-ID: FlzhmF6GNnS3-qGK2w5QZg_1763524523
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-340ad9349b3so15504720a91.1
        for <linux-security-module@vger.kernel.org>; Tue, 18 Nov 2025 19:55:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763524523; x=1764129323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ooCsRVhcTHqfbP0l9J8al+EICyTsRGhauAL5pmZkQRo=;
        b=LbUwuofgekTJhIwoiHE2M5JJoH9P9S+1cYkAFIe8lwMH48GsTs4G1VcoSkVBW9uWOZ
         lKjRE1sl7LFdxJAL3fJBqiFdqkPzUMkkSMu8JaTQ3j2W7wzYf6HOTguhvBJEFGMa+Jmm
         m10Et4faO5O0hObkB1oRt/+Gtkq9WfCPS03C8WZA4bMtuvg3203i74rkuF8FrmAGGYAd
         j0p+9gUV8DgDJb3MAfqR/KivAjL5VbFP+frdcz9JJWDl0qU84QlidmFbJoaFZJOYsP5f
         FgahuHok919D+Rd7GlaArvF1ouk4v2t55aNJnZYHu9CNt5nb8KFegevXQdR3lb9Ae/Yx
         LwZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPpXsgJ48R95v6mYjhrwRPBlqrG+V8Qjc/qSU44P2G23dJG7RqhwLKa7byPLHtSgB3m6jvEuoq0BFvDzh3NwrfBWcL2fI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyobRASWJas1efX6zk8omhJwxmNxpUgGgoBUnicOeQRGstV+Yug
	QJDW4CLB7CtKkaY0D++J9h5inQtEVM58qI2SAITXakRbBOFAjlaqGfbKyCwBz++VOKruesewyub
	Yf+KfxH2DGSl0JvkwWL499qJ6OUQk/huGmTWCSMl6Ln74G3KtpktzAuQtZszncjjLP0zPU3im/x
	Cdbg==
X-Gm-Gg: ASbGncuh+Xf8CRgv4q3bODb5M51Pu3wuGv1C5lZls6LmmGcUKphDbmNhy3sf5F1tf46
	mwK24fwNsDF9YlRvauG7ebCA7QAlGE/XaLaI5AODnsScJ5BJtAF+h+UvkcTpxClVcu2YtIbUP4S
	49xtgWDYv2b+V1KdIY+YaDANFnABhF3yCn1qj2d8L8DT3Ka1qLyFuzYguf/y9XcLzWY6LuLq/Tb
	FEbYwhFZPm1yECRj/GtCaQl5LPwCp/k6mrX+O6gSs+9x3zVmoJqfmaqevL765kOHUJFt62llYZ+
	0Y23CUDCJccjbpGPmXAd9092fusuUZMKUjnywygZhBLws/GP+z1wMsKozUbQtn+0SgiQ/RQJotY
	c
X-Received: by 2002:a17:90b:2e0b:b0:343:747e:2cac with SMTP id 98e67ed59e1d1-343fa761482mr20567682a91.31.1763524523263;
        Tue, 18 Nov 2025 19:55:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFssyPLkzi1egxM+wSUcJO1UnhvGQOb9QwQq0/MObXjomISK4Uyzbq1QhFXSSzRMUYO4Aev6Q==
X-Received: by 2002:a17:90b:2e0b:b0:343:747e:2cac with SMTP id 98e67ed59e1d1-343fa761482mr20567648a91.31.1763524522734;
        Tue, 18 Nov 2025 19:55:22 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc3760d9887sm16384031a12.28.2025.11.18.19.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 19:55:22 -0800 (PST)
Date: Wed, 19 Nov 2025 11:52:15 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Karel Srot <ksrot@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	open list <linux-kernel@vger.kernel.org>, "open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v2] lsm,ima: new LSM hook
 security_kernel_module_read_file to access decompressed kernel module
Message-ID: <7unk23jlwh3gy477ose6r5mvov5apxoflxmzhhpeanvrgg4ejb@h74hvym5r67s>
References: <CAHC9VhRBXkW+XuqhxJvEOYR_VMxFh4TRWUtXzZky=AG_nyBYEQ@mail.gmail.com>
 <baa39fcd1b6b485f14b8f06dcd96b81359e6e491.camel@linux.ibm.com>
 <CAHC9VhToe-VNqbh6TY2iYnRvqTHRfQjnHYSRWYgt8K7NcLKMdg@mail.gmail.com>
 <fftfj4o3kqxmfu3hb655xczqcddoeqjv55llsnwkrdu5isdm4z@6sqe3k24a6kk>
 <84a0e1785c7f0ff816b3246be49012092ae12126.camel@linux.ibm.com>
 <d24wnmefebnheerigmh6ts5yskkutz726l6a2f6g5s3s5fhhrv@osaactobwb5g>
 <b9eb78105115a00731b3677a5f3a39d5dde4d2ec.camel@linux.ibm.com>
 <0dfec96bf98b1c18d51bf40f4329c3ede48a9f32.camel@linux.ibm.com>
 <42qcfcxxlmwphctzvji76hy5tycfabiiv5u6zw6lgg2p3e2jwv@fp4g2y7ecf2y>
 <fca9a7b41a5e428fadfe2d7e3b004ada2763375c.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <fca9a7b41a5e428fadfe2d7e3b004ada2763375c.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LLKxTUkEGMUS_jM3kfPCGD908dzDpJkQd6ebQKJsELM_1763524523
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Nov 18, 2025 at 07:19:50AM -0500, Mimi Zohar wrote:
>On Thu, 2025-11-13 at 12:06 +0800, Coiby Xu wrote:
>> On Fri, Nov 07, 2025 at 02:28:13PM -0500, Mimi Zohar wrote:
>> > On Thu, 2025-11-06 at 17:15 -0500, Mimi Zohar wrote:
>> > > On Thu, 2025-11-06 at 21:29 +0800, Coiby Xu wrote:
>> > > > On Wed, Nov 05, 2025 at 03:47:25PM -0500, Mimi Zohar wrote:
>> > > > > On Wed, 2025-11-05 at 08:18 +0800, Coiby Xu wrote:
>> > > > [...]
>> > > > >
>> > > > > Hi Coiby,
>> > > > >
>> > > > > Based on the conversation with Paul, there is no reason to remove the existing
>> > > > > security_kernel_post_read_file() call.
>> > > > >
>> > > > > The changes are similar to the 2nd link, but a bit different.
>> > > > > - Define a single enumeration named READING_MODULE_COMPRESSED.
>> > > > >
>> > > > > - In module/main.c add a new security_kernel_post_read_file() call immediately
>> > > > > after decompressing the kernel module.  Like a previous version of this patch,
>> > > > > call kernel_read_file() with either READING_MODULE or READING_MODULE_COMPRESSED
>> > > > > based on MODULE_INIT_COMPRESSED_FILE.
>> > > > >
>> > > > > - In ima_post_read_file() defer verifying the signature when the enumeration is
>> > > > > READING_MODULE_COMPRESSED.  (No need for a new function ima_read_kernel_module.)
>> > > >
>> > > > Hi Mimi,
>> > > >
>> > > > Thanks for summarizing your conversation with Paul! I can confirm Paul's
>> > > > approach works
>> > > > https://github.com/coiby/linux/tree/in_kernel_decompression_ima_no_lsm_hook_paul
>> > > >
>> > > > While testing the patch today, I realized there is another
>> > > > issue/challenge introduced by in-kernel module decompression. IMA
>> > > > appraisal is to verify the digest of compressed kernel module but
>> > > > currently the passed buffer is uncompressed module. When IMA uses
>> > > > uncompressed module data to calculate the digest, xattr signature
>> > > > verification will fail. If we always make IMA read the original kernel
>> > > > module data again to calculate the digest, does it look like a
>> > > > quick-and-dirty fix? If we can assume people won't load kernel module so
>> > > > often, the performance impact is negligible. Otherwise we may have to
>> > > > introduce a new LSM hook so IMA can access uncompressed and original
>> > > > module data one time.
>> > >
>> > > ima_collect_measurement() stores the file hash info in the iint and uses that
>> > > information to verify the signature as stored in the security xattr.
>> > > Decompressing the kernel module shouldn't affect the xattr signature
>> > > verification.
>> >
>> > In the case when the compressed kernel module hasn't previously been measured or
>> > appraised before loading the kernel module, we need to "collect" the file data
>> > hash on READING_MODULE_COMPRESSED, but defer appraising/measuring it.
>> >
>> > An alternative to your suggestion of re-reading the original kernel module data
>> > to calculate the digest or defining a new hook, would be to define "collect" as
>> > a new "action" and pass the kernel_read_file_id enumeration to
>> > process_measurement().  IMA_COLLECTED already exists.  Only IMA_COLLECT would
>> > need to be defined.  The new collect "action" should be limited to
>> > func=MODULE_CHECK.
>> >
>> > The downside of this alternative is that it requires a new collect rule:
>> > collect func=MODULE_CHECK mask=MAY_READ uid=0
>> > appraise func=MODULE_CHECK appraise_type=imasig|modsig
>
>As it turns out, the "collect" rule is unnecessary.  On
>READING_MODULE_COMPRESSED, process_measurement() should calculate the compressed
>file hash.  Extending the IMA measurement list and verifying the signature can
>then be differed to READING_MODULE.
>
>>
>> Thank for suggesting an alternative! I've implemented the idea in
>> https://github.com/coiby/linux/tree/in_kernel_decompression_ima_collect
>>
>> Note besides a new collect rule, another change is needed. Currently,
>> process_measurement only accepts enum ima_hooks thus it can't tell if
>> it's READING_MODULE_COMPRESSED so to only do collect action. So I
>> create a fake MODULE_COMPRESSED_CHECK func.
>
>Correct, either extending process_measurement() with the read_idmap enum or
>defining the fake hook would work.
>
>>
>> And for the idea of re-reading the original kernel module data, it has
>> been implemented in
>> https://github.com/coiby/linux/tree/in_kernel_decompression_ima_no_lsm_hook_paul
>>
>> Both branches have applied your requested three changes including
>> respecting the 80 char line limit. Additionally, I made a change to the
>> IPE LSM because of the new READING_MODULE_COMPRESSED kernel_read_file_id
>> enumerate.
>>
>> After comparing the two implementations, personally I prefer re-reading
>> the original kernel module data because the change is smaller and it's
>> more user-friendly. But if there are other reasons I don't know, I'll
>> post the patches of the new collect action approach to the mailing list.
>
>The "re-reading" option fails some of the tests.  As the "collect" rule isn't
>needed, let's stick with the first option.

Thanks for evaluating the two options! Yeah, without the "collect" rule,
the 1st option is much better as it doesn't have the issue of re-reading
the module.

-- 
Best regards,
Coiby

