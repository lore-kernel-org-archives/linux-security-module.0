Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4271E1F4CA9
	for <linux-security-module@vger.kernel.org>; Thu,  6 Nov 2025 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435820; cv=none; b=LOP6CT8Q1RlsiyYKr9vfDZ1GhjCT/pmNCCuHAvdo7unRxVwmt0/RxJJdcMF3pFMdZBPFLTnBLytY914L9M7HaqqUecdH/BE+65OpEsV41yLzu5H/lI7mnPUgpCE0ZHu8clN6QgLrkJY0Yffnmo0yd59PXGdW78bClWRYOvG+z3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435820; c=relaxed/simple;
	bh=CmB1MWecEBBp4OgxfqCuQiSEAV5QOXrCNuLXgiG46GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YXCIZd2S2/4FIQEyKCyK8aTEJGb8jztcBXIAgFhTMLjK8Mt9KYzeQARgcFGKlaOUX7WAGlPCvG23ZWZy9rJrOZTRFLB1O+qMjdsK/EbODFzlbFTZld4fgOCKD44Uki8StmYQrCagYaQGkI8uvGQNaV4f12ewbcLUw1H+GMkBQ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nzz+3Fn6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nzz+3Fn6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762435818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GKaQ6ZP+peJ5RMaPGONMdp62mSGMz4ih+kVgJblXjSY=;
	b=Nzz+3Fn67GuaSmhGPoL4lqXFIU1ofvtvh5k9Qu/RSalr4sAzasL1Z+1qYqhYtIV+lzr3XE
	E+r4bF83RbdCzoAIEv5xHosrGK3wKYkFF+o/wAlrpiU2I9YA5smrLZxnUFokZK4LIDBOa6
	wFFHy2ZYsYyr4GsG1dE62YsWcmtekDE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-1Ta1BWNIO9-sTi40iVHX8A-1; Thu, 06 Nov 2025 08:30:14 -0500
X-MC-Unique: 1Ta1BWNIO9-sTi40iVHX8A-1
X-Mimecast-MFC-AGG-ID: 1Ta1BWNIO9-sTi40iVHX8A_1762435814
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b993eb2701bso853239a12.0
        for <linux-security-module@vger.kernel.org>; Thu, 06 Nov 2025 05:30:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435814; x=1763040614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKaQ6ZP+peJ5RMaPGONMdp62mSGMz4ih+kVgJblXjSY=;
        b=NqTGOijnQ8BoEcMmqsgGRs10iezlT9gKS6eeauaMUKbECG/pJk+ZpZcKX+inVCX9oK
         XItzijcVCJt6IsXFofKlnG0B93PBap/ezV+EmDAjfWbZD7rdE07JkPantrKSXn2XEx4o
         mb5yRhdo3Zrpnbn3wy4a3dABsHHktA7qk3kRZFJBi25oM4JJtRIo+FdptRRNsdUV362Y
         r+2i/X9AlF4hT5JblPCdPtzmVpqHl43gMSVZRNh7stC3BZ799rA9C1wS01TkzCWcgvkR
         d2L796MVLXFOLiqE/50oZqFBBQkAcDZGOFZygMqMixelq7w8QiZkPqYPmUqB+9ZviQFa
         Z0MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtHyXOwC76AYRh99j9HOD/AIoP2g7F0vDZrFACW3rmpUsZqIA6KxzSBtYGnAS+eMkrA6kuIgq8KogXHpwi5EizSJOUBMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDMEyvBKvyKjgreAI7UHGXIteB7nJ0NAF/KQxRPstkltr7/RV9
	UBeOwpjrAXsGxr1xKQyWbiEhvkFrpkkykXHk3NYdZtjAF4fFG6hjUaUUup6C49oXLs5fxptmWUj
	E4JTw8Bdu3uLZlgSfttgI/qfek//PrHcaXfzQAwZ0P+VYjhG0W9uyMRONwsAfFLQaPezOxkQAi/
	E/LA==
X-Gm-Gg: ASbGnctIOLBC5BlPG0dMsqfVEdkCWbgjQ1+JKyat2/HFCGsMBpcpnH3NjMfCpvUKIS5
	JWLjhlehhzzciz1FVQ++flI7vGrNQiL0O/cPbdpvZCRPS6Dtp6qcARfsRhrbZVA+dR3AayPICQp
	9BOz7yQDDp1xBZsO+U3G+EHvEt0Jl8TqooicnKOiPV2wMQSFJrf+ADriMqx6CHeAotskWkiZ79S
	GaNsSMn5oTjyekqihGLsqCjXUnCsKalwpgGBEc2Ay6sVCkPSkuHH/UboukES8iNHAjzIJ4ovdN8
	IHxDelyAFIxV5Qj4WAmTLS/DqNBYYUxzIPW301B+oxgHXt/sD9QTlRfi7rBZTUYpZw==
X-Received: by 2002:a05:6a20:6a11:b0:342:1265:158f with SMTP id adf61e73a8af0-34f85f23889mr10202194637.51.1762435813476;
        Thu, 06 Nov 2025 05:30:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF58+7mJo3sNtAxMb3Nqi6GJVi04D/CfZ0QveWCpOETxQnk4AuJy1ge7Ljn9GwytoZbabtjJg==
X-Received: by 2002:a05:6a20:6a11:b0:342:1265:158f with SMTP id adf61e73a8af0-34f85f23889mr10202143637.51.1762435812912;
        Thu, 06 Nov 2025 05:30:12 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba902207227sm2527090a12.33.2025.11.06.05.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:30:12 -0800 (PST)
Date: Thu, 6 Nov 2025 21:29:42 +0800
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
Message-ID: <d24wnmefebnheerigmh6ts5yskkutz726l6a2f6g5s3s5fhhrv@osaactobwb5g>
References: <20250928030358.3873311-1-coxu@redhat.com>
 <20251031074016.1975356-1-coxu@redhat.com>
 <CAHC9VhRBXkW+XuqhxJvEOYR_VMxFh4TRWUtXzZky=AG_nyBYEQ@mail.gmail.com>
 <baa39fcd1b6b485f14b8f06dcd96b81359e6e491.camel@linux.ibm.com>
 <CAHC9VhToe-VNqbh6TY2iYnRvqTHRfQjnHYSRWYgt8K7NcLKMdg@mail.gmail.com>
 <fftfj4o3kqxmfu3hb655xczqcddoeqjv55llsnwkrdu5isdm4z@6sqe3k24a6kk>
 <84a0e1785c7f0ff816b3246be49012092ae12126.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <84a0e1785c7f0ff816b3246be49012092ae12126.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RajsEs7FeKZDuUvnomIfdPgTk9fXIiPhnt47S4QuE_0_1762435814
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Nov 05, 2025 at 03:47:25PM -0500, Mimi Zohar wrote:
>On Wed, 2025-11-05 at 08:18 +0800, Coiby Xu wrote:
[...]
>
>Hi Coiby,
>
>Based on the conversation with Paul, there is no reason to remove the existing
>security_kernel_post_read_file() call.
>
>The changes are similar to the 2nd link, but a bit different.
>- Define a single enumeration named READING_MODULE_COMPRESSED.
>
>- In module/main.c add a new security_kernel_post_read_file() call immediately
>after decompressing the kernel module.  Like a previous version of this patch,
>call kernel_read_file() with either READING_MODULE or READING_MODULE_COMPRESSED
>based on MODULE_INIT_COMPRESSED_FILE.
>
>- In ima_post_read_file() defer verifying the signature when the enumeration is
>READING_MODULE_COMPRESSED.  (No need for a new function ima_read_kernel_module.)

Hi Mimi,

Thanks for summarizing your conversation with Paul! I can confirm Paul's
approach works
https://github.com/coiby/linux/tree/in_kernel_decompression_ima_no_lsm_hook_paul

While testing the patch today, I realized there is another
issue/challenge introduced by in-kernel module decompression. IMA
appraisal is to verify the digest of compressed kernel module but
currently the passed buffer is uncompressed module. When IMA uses
uncompressed module data to calculate the digest, xattr signature
verification will fail. If we always make IMA read the original kernel
module data again to calculate the digest, does it look like a
quick-and-dirty fix? If we can assume people won't load kernel module so
often, the performance impact is negligible. Otherwise we may have to
introduce a new LSM hook so IMA can access uncompressed and original
module data one time.

>
>thanks,
>
>Mimi
>

-- 
Best regards,
Coiby

