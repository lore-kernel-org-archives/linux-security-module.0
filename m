Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B200F191F84
	for <linux-security-module@vger.kernel.org>; Sat, 24 Jan 2026 00:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769214060; cv=none; b=Y5WaPkyPbGVf+ErFVQvCGRc7xmpfxz0GqdSiJzxYaxokSFE+uKwhwZ1678CmK2XTdHdmCJFBDzBn9qiZt8DGP1kLNd6fI2LKKRmsIn8VT5Dl08EmAthB1D4nQQ8sGeumzXlcVirPkNqgRevaFXl5XmMxQhhX4nsDmW06qit8Qo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769214060; c=relaxed/simple;
	bh=j2cnf66j7Tyeo03Ht3nxIfKsvE0nQ1mv6D7kqhjkBJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dMJuWGCzQim34puYJGF0xlTauO2VmAO9kY8MwaxZZndMFl5t5S9JR9GT4ttM1UWnGuzwebFa7GGHUbS+o2ppPyH7DZ/ZuWk4xLpJmO+nT/amm9fbzLukK1Tw0H2cbJXBR5FISDcwqVXkHcEQy30Z+aN14rgQLmEE8IVIpg98lLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gPqAskv8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPqAskv8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769214056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xhgLPiYR6xEsxXnQ/SeaMjXXghHvMuOe7YsndhfrobA=;
	b=gPqAskv8/iuAIelkAE02Mn5AzPTZq+2afA8ZwLjZq6cnB+hM2uk9a5HD1oPkITCfuYbXHx
	+rKoOhUta5LfNYV+2z8Yy3XT9ueZYtv3n+bT9J9aGBcAaf6Ew1rZaPWdz+E0FLTZKK8Q/b
	2+LbOmXOchBuzQEPEdQ8Dlt75VTeVJw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-eS67UY5MNQmSFFvFTLitBQ-1; Fri, 23 Jan 2026 19:20:55 -0500
X-MC-Unique: eS67UY5MNQmSFFvFTLitBQ-1
X-Mimecast-MFC-AGG-ID: eS67UY5MNQmSFFvFTLitBQ_1769214054
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a090819ed1so17296945ad.2
        for <linux-security-module@vger.kernel.org>; Fri, 23 Jan 2026 16:20:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769214054; x=1769818854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhgLPiYR6xEsxXnQ/SeaMjXXghHvMuOe7YsndhfrobA=;
        b=OaKeP+tjGCcNcbYiDL9PrFKHo8Rkrn1AAtqKBKIc3CYJ3QznZK4ZGkJwQYug/Mwvb3
         jwxsMjjLALafKsmV7dkxv/9HSRPx8JHXPjIHvn4IR8BCXTr8NH79zSQ3YWpR2B3d7ZHH
         ZnilYjB+kw2/LWLR7pEZmCSZjmJw5x/tgkXM0sZurF4gFcU633IFj3TAaYamEtPk4OpD
         DJJOiHrVVraKyuvbH4qs74PqeRnUX3Ciusm0DpUueW/aSAyjHWrM79ryOGdo3PGaeio7
         otQMbod6YsN606lL9Kas9nDKjJbPHA0k4kL+G0lpKJKNT1ypV6L7cpTTH7iNSudPLNNl
         Rw/g==
X-Forwarded-Encrypted: i=1; AJvYcCV1vsUCBhG2Z2IQjAa1dm2xf9l3ByFaj6MQgGxeELpDv3r87KQe0G1kkRvL7RRO2deryYNRh3CtRZA5UFA1x2STPh5nkr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWjcw52kXZpvQz4e5NLL2NgClCPzBXM3mQ5ywRaB4Wr9YhVPQb
	SyQOIDeqKQG8o1Vakmir7YJ0bZ9rulA5xKUfDnyKXfjFD5CmtLRbzXNsHqibqi7g2DZ/AJhHnYx
	dGvXOZ+pYdTDkoW+6KDT8z3dy82LItPlhR7RuiB07DNdTKBFk6WFdQd5c+owqamdbCS1cJ/qAWb
	W2NA==
X-Gm-Gg: AZuq6aKy31AG4BIdDkM3JFljJ7p2+a0jN1q8jyXv3W9ZOq8k+relgaPAaxsWZwQiY4/
	MFYfmY3KMQo05Mj8DnCM4oEOm5M3uoNQlSetdprZqtjuD9z2iV05QtAvwE8o4P0ReyOHo3V9YKK
	oCFcd/hlED7Fs826GDm7VrAu0bERhK1i6YHgmsx8GcCbS5AEcKs9K5pMiapISeo4MCj7bTA3rHg
	Pm7uk/COyRtLQFVuCvJ5CICMBUVMpMfdusl9A1CrFFLUVAUOpEi6CksF8rBFWhYuZ4Vg6IzTqXc
	9C6GEglvXUWoge4fupNyN2DdPApRywmCrQc4mU0XxKurd3x1IDUSte+A8HXAbrSA/g+/gB/lnpw
	W
X-Received: by 2002:a17:902:e54d:b0:2a7:682b:50ac with SMTP id d9443c01a7336-2a7fe625118mr44257305ad.28.1769214054340;
        Fri, 23 Jan 2026 16:20:54 -0800 (PST)
X-Received: by 2002:a17:902:e54d:b0:2a7:682b:50ac with SMTP id d9443c01a7336-2a7fe625118mr44257045ad.28.1769214053812;
        Fri, 23 Jan 2026 16:20:53 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802faf6f9sm29695045ad.71.2026.01.23.16.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 16:20:53 -0800 (PST)
Date: Sat, 24 Jan 2026 08:18:46 +0800
From: Coiby Xu <coxu@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-integrity@vger.kernel.org, 
	Heiko Carstens <hca@linux.ibm.com>, Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, 
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, "open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>, 
	"open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" <linux-efi@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, "open list:KEYS/KEYRINGS_INTEGRITY" <keyrings@vger.kernel.org>
Subject: Re: [PATCH 1/3] integrity: Make arch_ima_get_secureboot
 integrity-wide
Message-ID: <aXQN-ZNhT5olbf6X@Rk>
References: <20260115004328.194142-2-coxu@redhat.com>
 <CAMj1kXFXNo1-pMbo-VZrjQ3TYe1tufebrLr_avL12A0nHMSGnA@mail.gmail.com>
 <8bfa859ed3a4f1cf0db0ab64d8c1c3b24684582a.camel@linux.ibm.com>
 <CAMj1kXHsJNZoUEnbD1y=v4Ftuv9d2c08VckRV7ru4k4P83vZbQ@mail.gmail.com>
 <97b69bc79a5d9246f7a399510908c7b95b2e95e7.camel@linux.ibm.com>
 <CAMj1kXGx4ebaK87W7k0SNUNQnO9+=z1nmYxXC7retmp3OqRRFg@mail.gmail.com>
 <ac5e5e45c12e9b0bda19807e60b06057d74be0b3.camel@linux.ibm.com>
 <aW2i3yacr5TvWU-m@Rk>
 <1a0b6e5601a673a81f8823de0815f92b7afbeb60.camel@linux.ibm.com>
 <CAMj1kXFBMSEdRL8FotASbQO3dcfNG0bpp9Vnm5JPn-yjyDr=GA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMj1kXFBMSEdRL8FotASbQO3dcfNG0bpp9Vnm5JPn-yjyDr=GA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PLHAi96T029UE00eofj1R34Xt_SxhdQd_1BKJHlQSMQ_1769214054
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jan 21, 2026 at 05:25:39PM +0100, Ard Biesheuvel wrote:
>On Wed, 21 Jan 2026 at 16:41, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>
>> On Mon, 2026-01-19 at 12:04 +0800, Coiby Xu wrote:
>>
>> > diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
>> > index 976e75f9b9ba..5dce572192d6 100644
>> > --- a/security/integrity/ima/Kconfig
>> > +++ b/security/integrity/ima/Kconfig
>> > @@ -311,6 +311,7 @@ config IMA_QUEUE_EARLY_BOOT_KEYS
>> >   config IMA_SECURE_AND_OR_TRUSTED_BOOT
>> >          bool
>> >          depends on IMA_ARCH_POLICY
>> > +       depends on INTEGRITY_SECURE_BOOT
>> >
>> >
>> > Another idea is make a tree-wide arch_get_secureboot i.e. to move
>> > current arch_ima_get_secureboot code to arch-specific secure boot
>> > implementation. By this way, there will no need for a new Kconfig option
>> > INTEGRITY_SECURE_BOOT. But I'm not sure if there is any unforeseen
>> > concern.
>>
>> Originally basing IMA policy on the secure boot mode was an exception.  As long
>> as making it public isn't an issue any longer, this sounds to me.  Ard, Dave, do
>> you have any issues with replacing arch_ima_get_secureboot() with
>> arch_get_secureboot()?
>
>I don't see an issue with that. If there is a legitimate need to
>determine this even if IMA is not enabled, then this makes sense.

Thanks for the confirmation! Here's the updated patch
https://github.com/coiby/linux/commit/c222c1d08d90ef1ec85ef81ece90afc9efde7937.patch

If there is no objection, I'll send v2.

-- 
Best regards,
Coiby

