Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF1713AD05
	for <linux-security-module@vger.kernel.org>; Thu,  5 Jun 2025 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749112541; cv=none; b=Uteuj3kELOF6v0Lne+PQLrLGtyvbo0UoNJZkis28BIbylB3Trr4D9t6SUlBozY6N7Jz7I8jLpiEFMIIpp8eNvlO2yrUvLvgyiKwVUy3x0KEg/Wd1C99ZUiEDnLXGgldrHsxbceG4oGYPCUc1EMaCmuyCy461IXbU4HO7A0WJ5DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749112541; c=relaxed/simple;
	bh=NRoDy9oPqPmwUYRp1IJc6lJX14zHgjomcJR0myjnx68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SgAuhcJpRvYEu4a+VJymGICxJyrpMThX0heoKgO+0WIpZWq53JXF0n6ligp9/ReAuDu+heHj9cUSjTTfMUAhkhdFyC5fYfVTIfIy0DfKaEf+5gO9QFCMA3zTt04Gt0uJQALJqoJu6j+7MTlywmbAmEXfIrnXMfzpAeJKRrZ2vuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsFwcP+G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsFwcP+G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749112538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J7OP291cCHEccCOVb5GqF2fJ19heqtSc19LUMzhHmhc=;
	b=gsFwcP+Gwp92+gv8SnuYBZHDivx/wUHTATRQT+LjRybXG7b8Fzq+P21eW8byuYgNzXXsUU
	kGYOP7/ELdZJewG5WCVawE4MV6AOcU8yXIT2e0nzoLpg3wxca0WFZH63pZ3v/idQavDxvj
	OmGM6S82FNk6kDWUQDy6OXhZrZPJJDg=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-GNLBMt-NO72GhhltTCVNtw-1; Thu, 05 Jun 2025 04:35:37 -0400
X-MC-Unique: GNLBMt-NO72GhhltTCVNtw-1
X-Mimecast-MFC-AGG-ID: GNLBMt-NO72GhhltTCVNtw_1749112536
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7370e73f690so1091691b3a.3
        for <linux-security-module@vger.kernel.org>; Thu, 05 Jun 2025 01:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749112536; x=1749717336;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J7OP291cCHEccCOVb5GqF2fJ19heqtSc19LUMzhHmhc=;
        b=euBVCW+7+kDK8BR3Hhcbj8f4bincZljPx2gZCGt8QuM4zua08vxll24IaisYQDySO6
         pCy3jeBuB/qXC5R7gM+dwRsAKfYJMAprKiK6NAW/o1k/VIkrUs2wHzC8uHpDXB1og3H5
         slnnj47Ogy1ZmVF9px8NxKZmsT3DEyYStYAqV9u4MI3kF/+M3x5TXkMwOeBPAz70HELn
         N9VpFb0qGKragRqmlza+Tpm6YQ+ziOF2K/fFrB5w1Ri4S1JCgNkKNnYD5YVJ1z2JgfF7
         Y15lHmN6zkUW0aIzBPVHXWkiw3psduy12v5Bk+oohJQAQVu+Mz8tyvRfoVQG6+UJ1hTW
         UpWg==
X-Forwarded-Encrypted: i=1; AJvYcCXioJ0FSBol9+yfZ0Zn2O6DHYp9GapMn8UOJcfv0lGibIg2dA4s4tAy5+CUcBNzl9ftcMmaFDI+DGI2UDh+MnEcgeiILyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyb0fFUIxUoQuQ4IoQtVHSMq2ZsKtiT/anUKeR3JaHi4nf0ft2
	XIMdAAJdoWQ7NGwvD29pLhFeOL5qdmU4SoJgJ1owHlMRMQAMdl52li7ZxzHJaoJc/X6wSE5rTnS
	c45omF4eEYm3/KX0VYjOrkAW6PSgDllnYZBfTaqz8EURLXDX2czW612NPa9OOfQmQXFkhDNzFTP
	kWCA==
X-Gm-Gg: ASbGnct3r2GIQXlsG6+99xHzdErT+rLc/rQhMHhHTigx6b5dW035qH0OAs258625/KF
	8KzvC93no3UIJJ8K1fa9o4Sih3ZxQbscs6WlZ9Aqg2EB0l4DcVMEC9qVK+/7olxvTBWdvboF0OZ
	Dm750H+YcZNtkTLvXkqkiScOVIwm0QKEtf9K8iFnh+DlcYT+O+LiFhQjM/fkezXFHMaTVLky3Er
	/CjNiTWldmtjka4dr81TabQxzrNFD03h68ZURzuFTCH9EIO2c4G+vnjHfcP4xIsbmR97g+lfzyq
	g0g=
X-Received: by 2002:a05:6a00:23c6:b0:736:43d6:f008 with SMTP id d2e1a72fcca58-7480b2e0361mr8190452b3a.12.1749112536505;
        Thu, 05 Jun 2025 01:35:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrN0PqOUdKalMaeAG7aIgHJtiglVXWjEwD24TEHI4LYox9Gd70kryUZzyeMjHmJRalEgOnRg==
X-Received: by 2002:a05:6a00:23c6:b0:736:43d6:f008 with SMTP id d2e1a72fcca58-7480b2e0361mr8190429b3a.12.1749112536110;
        Thu, 05 Jun 2025 01:35:36 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeab75csm12734762b3a.52.2025.06.05.01.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 01:35:35 -0700 (PDT)
Date: Thu, 5 Jun 2025 16:34:20 +0800
From: Coiby Xu <coxu@redhat.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, keyrings@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Peter Jones <pjones@redhat.com>, Robert Holmes <robeholmes@gmail.com>, 
	Jeremy Cline <jcline@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH RFC 1/1] module: Make use of platform keyring for module
 signature verify
Message-ID: <ibosm332sa2kz6vqrru5qsfk4tybsxepo4vascc3zsetmyckvv@pml7puc5jyl6>
References: <20250602132535.897944-1-vkuznets@redhat.com>
 <20250602132535.897944-2-vkuznets@redhat.com>
 <948f5567fe4d9ae39aa2528965f123e42bf82b46.camel@HansenPartnership.com>
 <87r001yzob.fsf@redhat.com>
 <d34555e2b0c4746fc01d5295959a434befcf8b18.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d34555e2b0c4746fc01d5295959a434befcf8b18.camel@HansenPartnership.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5XeBcYXSQMUhY9nIohtLc2H97ZJmy7SrYeUInzV6WCs_1749112536
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jun 03, 2025 at 09:03:22AM -0400, James Bottomley wrote:
>On Tue, 2025-06-03 at 10:52 +0200, Vitaly Kuznetsov wrote:
>> James Bottomley <James.Bottomley@HansenPartnership.com> writes:
>[...]
>> > Also, are you sure a config option is the right thing?  Presumably
>> > Red Hat wants to limit its number of kernels and the design of just
>> > linking the machine keyring (i.e. MoK) was for the use case where
>> > trust is being pivoted away from db by shim, so users don't want to
>> > trust the db keys they don't control.  If the same kernel gets used
>> > for both situations (trusted and untrusted db) you might want a
>> > runtime means to distinguish them.
>>
>> I was not personally involved when RH put the patch downstream (and
>> wasn't very successful in getting the background story) but it
>> doesn't even have an additional Kconfig, e.g.:
>> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/commit/03d4694fa6511132989bac0da11fa677ea5d29f6
>> so apparently there's no desire to limit anything, basically,
>> .platform is always trusted on Fedora/RHEL systems (for a long time
>> already).
>
>It sounds like that's just distro politics:  RH wants to enable binary
>modules (by allowing them to be signed) but doesn't want to be seen to
>be signing them (so they can't be signed with the embedded RH key) so
>that gamers can have performant graphics drivers and the like.  Thus it
>mixes in the db keyring, which usually contains several Microsoft
>certificates and also one from the ODM manufacturer, so now it can send
>would be shippers of binary modules to those groups to get them signed.
>If you only have the built in and MoK keyrings, the only possible
>signers are either RH or the machine owner ... who isn't a single
>entity to deal with.  Personally I think this is a bit daft: Debian
>manages an out of tree module infrastructure using DKMS and MoK
>signing, so I can't see why RH can't get it to work in the same way.

It's interesting to find that although Debian's wiki page [1] only
mentions DKMS and MOK, it actually has the same downstream kernel patch
[2][3] as Fedora/RHEL to allow using db keys to verify kernel modules.

[1] https://wiki.debian.org/SecureBoot
[2] https://salsa.debian.org/kernel-team/linux/-/blob/debian/latest/debian/patches/features/all/db-mok-keyring/KEYS-Make-use-of-platform-keyring-for-module-signature.patch?ref_type=heads
[3] https://sources.debian.org/patches/linux/6.12.30-1/features/all/db-mok-keyring/KEYS-Make-use-of-platform-keyring-for-module-signature.patch/

-- 
Best regards,
Coiby

