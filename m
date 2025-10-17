Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB43924728F
	for <linux-security-module@vger.kernel.org>; Fri, 17 Oct 2025 03:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760671198; cv=none; b=mNHdwLQr3mPZ4PXcLAWrkZ/qN5vQqrsLRzHhdnyPM9jsCd9DEfiC5weFNIRuDcPi3Tz8AvaMR1dZXE7SpCCReEDxsbgusKDvc94mQfiv+GixlTA595YM0eG0fvbuqLQrNL90ksxWnN+MR/7Q3pQqfg3hfczvT3zoUREqha4NqZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760671198; c=relaxed/simple;
	bh=uypAUXaJ5tCbymYlHt7YPIm+ehtbdEvJWSNK1ujayaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=AXKIHLJQAfZ93alESCtsiK+EdxnUfpU7PzOQtOY98PZ/lbVtBGWcUxL2erLBZhAZXSr6bzGuSUsJVj2ypQbwsrlLynd3PQpRhQ72EW6xkB2GJ3cMNYwLhM/vt+V+vV1870xinjf6zqXSinefLkZEOzacjOm2c1fgCq7qFwXuclg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VIEW9HVu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VIEW9HVu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760671194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+TfM6IPe6IXk1dWT/6Pijnzc7MtwzwWjeP0hvjpYeVk=;
	b=VIEW9HVuvCWqi3S9elpC6Jj7/K8a7VGqNx1GZxd1ltKh6RFdwhQlzGodn9T/eNNTA51LBP
	B7PCY8mm3gzJTxnYUXf9p0/8OfI70O+prQjklzTAXpgOSd8NFc1U+fsVHyNLTg4abDyzD1
	lRa3m+6EMuBgXjnFC+IryYw5OpyFWL0=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-0dp-dalKP768CUm7L1uCyg-1; Thu, 16 Oct 2025 23:19:53 -0400
X-MC-Unique: 0dp-dalKP768CUm7L1uCyg-1
X-Mimecast-MFC-AGG-ID: 0dp-dalKP768CUm7L1uCyg_1760671192
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-782063922ceso1464426b3a.0
        for <linux-security-module@vger.kernel.org>; Thu, 16 Oct 2025 20:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760671192; x=1761275992;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+TfM6IPe6IXk1dWT/6Pijnzc7MtwzwWjeP0hvjpYeVk=;
        b=wqqX1iADDkDd1oBZuJ4Xw109cb8Hnn3XFwwJcEftLorVrIz53GmXaEIMZ7q1nnTiB8
         fRLb1J6w4U6+AETCP3IQCFKvg652ld13L6Y3iwGxFcX++zcO6Fp08HPBCILMPrLTJcf9
         zJMgf5RdCVzCx0EaBH0ILY58HnzvJzeBe/kvsrQ8ehyopmztIRBq1Elgdia/yO3dcLtH
         uX/IapDMbmGUuquhbJUDFEOh4mrSeHJ5YFB4bxhVIjnauRM5NQ5/y2H6tA3/YsrppXzT
         889LiGkuWs1eJV778KIPhOPa+Yuzw2qXhcjNHPAcWclP0Xv4j10HqygZpO4G+5Y/sBGB
         SvlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwaLcNIcVuMOgrUafYEcMNO39kFYHzbKtxVhN3EooqBx58bK/vpbAfM+Z3ijp5LMfqLKtYEPgI0ynvV/DRUdq8KHi9kLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSTq9LzcWbuzoeax+6FhRY0SVfv6LYSxp3tn0pHW1x78T5iHpk
	B0PV7mXlhf3LkWid3wpB6xqKfRvR8YakxTyYMnc6GjdBJWhasW6ympk2+9t6QjQIrpX4DXWlJhY
	nryj2wSuZFkNewUM4GUHtMUJO0HEZA/sUTOJcs2f0BoK8vGxybBoiBeMV4vGI1K6NGrbw7xFgim
	7irQ==
X-Gm-Gg: ASbGncuaZX+JgzCSGY3kjPX2Ni91BMU4JHQCtYh8RiSqCX26tHkNVv/E8IKkwt//zS/
	sfnmCBDX8UYNHMR4UTPAK3I+1CZQWumcpvfHZDm5Smdq8pqLDX8KZbe0r7j18EaaQWO8tsyKFva
	+s02sSt7LXWae6w7ZJsy6sT30faKPji558SyTYd85jW15iuUjPlCX60aFaGi7dMMwHV8HVKpBPT
	qMfPSoG7Dy0dxjXZDzXJS78zLbp/VzMbMnO/PfOr5bB6vgsr0xpsr/jWKdPAwlzsj11Z24rU6Zc
	gyigZz/uhUvngIVG2eEb99LZreP9ZIwBlp3sR+BGOabzdtB0BBcEeiex2jHOBn1WWg==
X-Received: by 2002:a05:6a00:4602:b0:77f:324a:6037 with SMTP id d2e1a72fcca58-7a220a59102mr2212341b3a.7.1760671191988;
        Thu, 16 Oct 2025 20:19:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3SpXc/4R0YmtWXOa/WqPMg19qoO6KFp1YU0kvOBW/gBfHyIHwux/dUYEzsamCwWENFrIFGw==
X-Received: by 2002:a05:6a00:4602:b0:77f:324a:6037 with SMTP id d2e1a72fcca58-7a220a59102mr2212305b3a.7.1760671191294;
        Thu, 16 Oct 2025 20:19:51 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d096527sm23955666b3a.44.2025.10.16.20.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 20:19:50 -0700 (PDT)
Date: Fri, 17 Oct 2025 11:19:40 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Karel Srot <ksrot@redhat.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: Fall back to default kernel module signature
 verification
Message-ID: <5bzredottmp2tdm3uebzjfqjr6c7bwssqkrbdqvudruvzr764e@37j6ycjci2sk>
References: <20250928030358.3873311-1-coxu@redhat.com>
 <896f4fb0c0146512a66daf0b4c1e033aca4bd6d4.camel@linux.ibm.com>
 <bcd1f7b48311aff55711cdff4a6cdbb72aae1d04.camel@linux.ibm.com>
 <xq7bgyg63xlbogcik2we26yr5uf62f6kj3qn7ooljmqaoccrix@kkmuhza5cfdr>
 <9d279fd3d7b3cbb2778183ec777d6b9da8a64b82.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9d279fd3d7b3cbb2778183ec777d6b9da8a64b82.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: X01GCWlNZD0m24Me0ef-JeZRDaABVZ_Bhn69SuZds6w_1760671192
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Oct 16, 2025 at 10:31:35PM -0400, Mimi Zohar wrote:
>On Thu, 2025-10-16 at 11:46 +0800, Coiby Xu wrote:
>> On Tue, Sep 30, 2025 at 04:28:14PM -0400, Mimi Zohar wrote:
>> > On Tue, 2025-09-30 at 09:57 -0400, Mimi Zohar wrote:
>> > > On Sun, 2025-09-28 at 11:03 +0800, Coiby Xu wrote:
>> > > > Currently, for any IMA policy that requires appraisal for kernel modules
>> > > > e.g. ima_policy=secure_boot, PowerPC architecture specific policy,
>> > > > booting will fail because IMA will reject a kernel module which will
>> > > > be decompressed in the kernel space and then have its signature
>> > > > verified.
>> > > >
>> > > > This happens because when in-kernel module decompression
>> > > > (CONFIG_MODULE_DECOMPRESS) is enabled, kmod will use finit_module
>> > > > syscall instead of init_module to load a module. And IMA mandates IMA
>> > > > xattr verification for finit_module unless appraise_type=imasig|modsig
>> > > > is specified in the rule.  However currently initramfs doesn't support
>> > > > xattr. And IMA rule "func=MODULE_CHECK appraise_type=imasig|modsig"
>> > > > doesn't work either because IMA will treat to-be-decompressed kernel
>> > > > module as not having module signature as it can't decompress kernel
>> > > > module to check if signature exists.
>> > > >
>> > > > So fall back to default kernel module signature verification when we have
>> > > > no way to verify IMA xattr.
>> > > >
>> > > > Reported-by: Karel Srot <ksrot@redhat.com>
>> > > > Signed-off-by: Coiby Xu <coxu@redhat.com>
>> > > > ---
>> > > > Another approach will be to make IMA decompress the kernel module to
>> > > > check the signature. This requires refactoring kernel module code to
>> > > > make the in-kernel module decompressing feature modular and seemingly
>> > > > more efforts are needed. A second disadvantage is it feels
>> > > > counter-intuitive to verify the same kernel module signature twice. And
>> > > > we still need to make ima_policy=secure_boot allow verifying appended
>> > > > module signature.
>> > > >
>> > > > Anyways, I'm open to suggestions and can try the latter approach if
>> > > > there are some benefits I'm not aware of or a better approach.
>> > >
>> > > Coiby, there are multiple issues being discussed here.  Before deciding on an
>> > > appropriate solution, let's frame the issues(s) properly.
>>
>> Hi Mimi,
>>
>> Thanks for listing and framing the issues! Sorry, it took me a while to
>> go through your feedback as I also had a 8-day holiday.
>>
>> > >
>> > > 1. The finit_module syscall eventually calls init_module_from_file() to read the
>> > > module into memory and then decompress it.  The problem is that the kernel
>> > > module signature verification occurs during the kernel_read_file(), before the
>> > > kernel module is decompressed.  Thus, the appended kernel module signature
>> > > cannot be verified.
>>
>> Since IMA only accesses a kernel module as a fd or struct file*, even if
>> IMA hook is triggerd after kernel module is decompressed, IMA still
>> doesn't know the default verification has passed or can't access the
>> decompressed kernel buffer [2] to do the verification by itself.
>>
>> [2] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/module/main.c?h=v6.17#n3689
>>
>> > >
>> > > 2. CPIO doesn't have xattr support. There were multiple attempts at including
>> > > xattrs in CPIO, but none were upstreamed [1].  If file signatures stored in
>> > > security.ima were available in the initramfs, then finit_module() could verify
>> > > them, as opposed to the appended kernel module signature.
>>
>> Thanks you for pointing me to the work [1]. I'll take a more careful
>> look at [1]. I think CPIO supporting xattr can be a long-term solution
>> and also close a important security gap.
>>
>> > >
>> > > 3. The issues described above are generic, not limited to Power.  When
>> > > CONFIG_MODULE_SIG is configured, the arch specific IMA policy rules do not
>> > > include an "appraise func=MODULE_CHECK".
>>
>> Yes, the issue is not limited to Power. And thanks for correcting me
>> that Power arch specific IMA policy rules don't have this problem! Sorry
>> I misread the code.
>>
>> > >
>> > > 4. Unlike the arch specific IMA policy rules, the built-in secure boot IMA
>> > > policy, specified on the boot command line as "ima_policy=secure_boot", always
>> > > enforces the IMA signature stored in security.ima.
>> > >
>> > > Partial solutions without kernel changes:
>> > > - Enable CONFIG_MODULE_SIG  (Doesn't solve 4)
>> > > - Disable kernel module compression.
>> > >
>> > > Complete solution:
>> > > - Pick up and upstream Roberto Sassu's last version of initramfs support [1].
>> > > - Somehow prevent kernel_read_file() from failing when the kernel_read_file_id
>> > > enumeration is READING_MODULE and the kernel module is compressed.  The change
>> > > might be limited to ima_post_read_file().
>> >
>> > or perhaps not totally.
>> >
>> > init_module_from_file() doesn't pass the flags variable to kernel_read_file().
>> > You might want to consider defining a new kernel_read_file_id enumeration named
>> > READING_COMPRESSED_MODULE.
>>
>> Thanks for suggesting the solutions! I like the solution of CPIO
>> supporting xattr but it seems it won't land in upstream soon. So I
>> prefer the last approach. I've implemented one [3] by defining a new
>> kernel_read_file_id enumeration, would you like me to post the patches
>> to the mailing list directly?
>>
>> [3] https://github.com/coiby/linux/tree/in_kernel_decompression_ima
>
>A few thoughts, before you post the patch.

Thank you for sharing your thoughts!

>
>1. In the general case, the kernel module could be compressed, but without an
>appended signature.  The new code should only defer appended signature
>verification, if there isn't an xattr or appended signature.

I'll add these two condition checks, thanks!

>
>2. Instead of defining an additional process_measurement() argument to identify
>compressed kernel modules, to simplify the code it might be possible to define a
>new "func" named COMPRESSED_MODULE_CHECK.
>
> +       [READING_COMPRESSED_MODULE] = MODULE_CHECK,  -> COMPRESSED_MODULE_CHECK

I also thought about this approach. But IMA rule maps kernel module
loading to MODULE_CHECK. If we define a new rule and ask users to use
this new rule, ima_policy=secure_boot still won't work.

>
>3.  The patch title "ima: Use default kernel module signature verification for
>compressed ones" is a bit off.  It should be something along the lines of "ima:
>defer compressed kernel module appended signature verification".

>
>4. Simplify the patch description.

I'll rephrase the title and try simplifying it. Thanks!

>
>> >
>Mimi
>

-- 
Best regards,
Coiby

