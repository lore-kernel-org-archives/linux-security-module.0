Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF1C610B
	for <linux-security-module@vger.kernel.org>; Tue, 30 Sep 2025 02:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199720; cv=none; b=XwUmx2C67QxWzQTo+pTPB4XMOnOfou9rcKN0tnSG97EH/cBPCnXxAviDPMF8q1xri6pfd4k9qDUFJafYF4jcbZeiy3zf0YYYOXQggXzNP68zj5sj1tZBN3rrjoRLrrf4z9U6PQGREsQ6ddUeIFIUYPhT7Kj0/4xCy0WTbjebnyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199720; c=relaxed/simple;
	bh=wJQGgVCMFj3J2tRZt+e5H18nK9hedKnUGtmvcZcCFLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=reZGO8Bh9EFHaI72sToUBoTWaQPBu9T+7jjtaImazrBIZHZ3GghMkTiQeu7aE08QgFtTDyoc0DfhNNok500tvT71P1Cfe57YYwfwTFhQwOUIUDHUY9na8bJAEtWDiTLcdLQZv02f9b8VhXjqu6CTQcsqajYMcey0+UlV4o0tLC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpkN4hYz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpkN4hYz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759199717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=03NexLO5UHcDiL6BtGZCzs9TJxia4xSP+LO1xkJ8UJI=;
	b=OpkN4hYz7vQomBRNL4cjZlCLqajEkUk78GOE5W9YcQEDE00HmArJjdQqyTFJvAuFTQWPB5
	vXuxiOBmEYDQKku1ARCRqvaj3xs7QsjzdInvdnNYhrtEKCJshpgLIum6/rx6Do2ASs5AaO
	hkK8/6B81uj+B24rR0mRC6PHT4G0B4w=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-obVEc0EbMqCMyp9PxPCrrg-1; Mon, 29 Sep 2025 22:35:15 -0400
X-MC-Unique: obVEc0EbMqCMyp9PxPCrrg-1
X-Mimecast-MFC-AGG-ID: obVEc0EbMqCMyp9PxPCrrg_1759199715
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7847cc45409so2071017b3a.3
        for <linux-security-module@vger.kernel.org>; Mon, 29 Sep 2025 19:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759199714; x=1759804514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03NexLO5UHcDiL6BtGZCzs9TJxia4xSP+LO1xkJ8UJI=;
        b=kL9uNoPOgx6W7f7LTB8tBL2RlbBXFk0UN0cUdr0AmEvkzVCCBPEegvofvAxgNRueKL
         HzCwENnFBWOQAPYYv//nNmK5U8olCd3dJEcfem0kkB3dRIV10U3Bs6RvFWJ4wfWCu0+K
         aPjcnEw0mKLe2xGadu9Cak3SXG13dVqO1J0+es5KeVl+OdKJhUtw3aWuQC6aKKfLRSc/
         Yu+rwoaS/UDGZIwMOUeS1rxYTUaTo+AupRTh+5pz+2KXPHxrUgJkFwG7gMh3wCfF22Se
         MuNqovIW6WLoMpm3hmPz5WJFsSgegAB4leeUAnlzrREUVLnZO7L4g2HD3hvZj2o35CIi
         AfnA==
X-Forwarded-Encrypted: i=1; AJvYcCWfSsgHflc+Z1IHdwXikG/udJd/QsaISQVUShLXrjsW2GKPoVDXUNQETrmHTPYix1ESYjYwibFrEncxslRDXTCp/b6DpWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwRbSVdmeYnL+mpD0CkYK66mU+XqLst8PkDkQdRWdktef4BIEi
	8dGjViku5z1TItwCgk29L/lbQn951ZgYKQvtdxBMiGybDsmzN3BDaKYswk9yIFx5jyEWp1TFZKu
	QZOqe7AJf1XnjWA2PZl3kSdhC4dLUIVFri5hRdUS5MAbfxpcRjZ2lXfNzl4ojeuZNO6oujsib7U
	g+Ow==
X-Gm-Gg: ASbGncu6/xfzhrwlFSMR5jqik7ZPZ9cYnFxlbw/caxA1B5MXDfEjdMxXi2MtgqsMgvM
	fBkcDQ6sKihA0Pxo4McdwqqcyU60zSPgBhFmGil6z2oegg5ztph43dBQdeT/JKK2/+i6A1KNtXd
	ONFt2QY1UX+82Hk2D6wt2Z6DPNTE4Ril95XS7KrSyuVVhIKnVQVm/LnIhdkXjuziQS0T/kSHzem
	rkVWxX4c/mHlF9aq1qjkfJ7pP2HEbhxApY8EgY0byZlGKaGv+PXKA2CqQw4W6k70yDrUOua49jR
	7+htA1IpFCKcJB2/atlcFX2k8s7A2FYdjG2e
X-Received: by 2002:a05:6a00:2e2a:b0:781:22cf:b916 with SMTP id d2e1a72fcca58-78122cfbb2cmr10060859b3a.23.1759199714597;
        Mon, 29 Sep 2025 19:35:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk6lf5UdCs5HU9KjvZY3Dx8H8dMrpHuoGYVyn5iK1EraZ+Yd9xN0D7C0jcRRi5VYye/wwQ0w==
X-Received: by 2002:a05:6a00:2e2a:b0:781:22cf:b916 with SMTP id d2e1a72fcca58-78122cfbb2cmr10060841b3a.23.1759199714246;
        Mon, 29 Sep 2025 19:35:14 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023edda8sm12356376b3a.43.2025.09.29.19.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:35:13 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:31:45 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: setting security.ima to fix security.evm for a file
 with IMA signature
Message-ID: <22ya7mhqv3fenf5olfa6nrtpj7ch6vbdhngiblhqaml3zlrbx4@fqf46sgckoay>
References: <20250909041954.1626914-1-coxu@redhat.com>
 <5aeecf1aa6eff8ae0ea0a9e95d5df79aee338b32.camel@linux.ibm.com>
 <r3himk4z2aiyqsjstlpnda4wafeo7i4oum3n2dbvnasmtep5ex@zqodcpjmyx5b>
 <cbcbdb3e4aed17f387ae1d357906796551e2f470.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cbcbdb3e4aed17f387ae1d357906796551e2f470.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nBSOxfAiB-QwaIoPbQv1Y1Kvli23eIk5giJLIhetegU_1759199715
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Sep 10, 2025 at 07:15:19AM -0400, Mimi Zohar wrote:
>On Wed, 2025-09-10 at 09:20 +0800, Coiby Xu wrote:
>> On Tue, Sep 09, 2025 at 11:31:20AM -0400, Mimi Zohar wrote:
>> > On Tue, 2025-09-09 at 12:19 +0800, Coiby Xu wrote:
>> > > When both IMA and EVM fix modes are enabled, accessing a file with IMA
>> > > signature won't cause security.evm to be fixed. But this doesn't happen
>> > > to a file with correct IMA hash already set because accessing it will
>> > > cause setting security.ima again which triggers fixing security.evm
>> > > thanks to security_inode_post_setxattr->evm_update_evmxattr.
>> > >
>> > > Let's use the same mechanism to fix security.evm for a file with IMA
>> > > signature.
>> > >
>> > > Signed-off-by: Coiby Xu <coxu@redhat.com>
>> >
>> > Agreed, re-writing the file signature stored as security.ima would force
>> > security.evm to be updated.
>> >
>> > Unfortunately, I'm missing something. ima_appraise_measurement() first verifies
>> > the existing security.evm xattr, before verifying the security.ima xattr.  If
>> > the EVM HMAC fails to verify, it immediately exits ima_appraise_measurement().
>> > security.ima in this case is never verified.
>> >
>> > This patch seems to address the case where the existing security.evm is valid,
>> > but the file signature stored in security.ima is invalid.  (To get to the new
>> > code, the "status" flag is not INTEGRITY_PASS.)  Re-writing the same invalid
>> > file signature would solve an invalid security.evm, but not an invalid IMA file
>> > signature.  What am I missing?
>>
>> Hi, Mimi,
>>
>> Thanks for raising the question! This patch is to address the case where
>> IMA signature is already added but security.evm doesn't yet exist. So
>> EVM HMAC fails to verify but there is no exiting
>> ima_appraise_measurement immediately.
>>
>> And you are right that re-writing an invalid IMA file won't fix an
>> invalid IMA file signature. And even when IMA signature is valid, the
>> verification may fail because the key is missing from .ima keyring. This
>> happens because we need to turn off secure boot to enable fix mode. As a
>> result, CA keys won't be loaded into .machine keyring.
>
>> Btw, if I'm not
>> mistaken, current IMA code assumes we are not supposed to fix IMA file
>> signature.
>
>Right, unlike file hashes, new or the same file signature can be written, but
>cannot be "fixed" in the literal sense, as that would require calculating the
>file hash and signing it with a private key.

Thanks for the confirmation! I also added some code comments to explain
the IMA iint cache atomic_flags including IMA_DIGSIG in v2.

>
>This patch triggers "fixing" the EVM HMAC by re-writing the existing IMA file
>signature.  I assume the same result could be achieved by simply re-installing
>the file signature.  In both cases, the EVM HMAC key needs to exist and be
>loaded.


-- 
Best regards,
Coiby

