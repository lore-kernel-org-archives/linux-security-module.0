Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E37718AED
	for <linux-security-module@vger.kernel.org>; Thu,  4 Jul 2024 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112897; cv=none; b=dz+tEd6yFjgrOfekActrwk0F8VmLYr5A5uHOiP4M/aQrfiGs0u5IgavTehDofRPQZWE8W0tw3uxZNoyMQNGvBMlHv8O5NkjcXubLspKFdmkC3c/9nFDSB4jVlmeuO5QV3S+z9zIAeaDx39f6bbzItQC6v7SDiGi00x6Gkt2df30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112897; c=relaxed/simple;
	bh=QguQgLZBBttmrru34w9QMLWo5wJFt+WRZM0wpZpr6UY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/z//t3S/Wyn2oTNhA8fg88xmCtb0YoxmR4/+qkaxuetSodIx93azTBEyKjtymCs87Vt5rFZOXNt7a1TKpZiOhDrEYvk2c+/LrcarMRjlI+aWg6RcCBcWf2iNXt6rF0vI/vEETF66jH0Z4PbLhSDxXur2fTpe8JRKgkE7Pf9lXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SIg0F2GS; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SIg0F2GS"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52cdf2c7454so1709675e87.1
        for <linux-security-module@vger.kernel.org>; Thu, 04 Jul 2024 10:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720112892; x=1720717692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UlrKQa45wt6qlKqqrZr7W5l7lANNYZzO1+mSmOq7i9c=;
        b=SIg0F2GS99ypMCxZRJR+2us+SihOXLnjqVXJxIxllEyFpT+j2l5ZyBYWAB0uzKk+zn
         MAZzpgJA9kC+hbEw8Oumhz5jyAl+JtkXCed7EOCJPwtuKkx6L7DOmi7vzg328glkrdNE
         HsQ4ub/Wcrg9ET00rN87k+zfldXia043j64kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112892; x=1720717692;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UlrKQa45wt6qlKqqrZr7W5l7lANNYZzO1+mSmOq7i9c=;
        b=dWVMj0aZzDTi8bp4mTRg+X6xaWpEeqf49na2YGhBPXtgCEjK2ZRU5mxDyz8m/elHFc
         yndUGSN76ElwHszPjnB3JCUV4U8GoUIPPJLrCaMqpVUcl2EifW/wEptTmtAQEKmGOblu
         +IukkJpPXlhm19HPyKNu2QSy2ru3j2BCL5YCw5wSkvUbium87AsPMuI6BrpuZvMv5rpq
         xBqY2Ea6kEXaQNnK/hiG5TnYAvE6bX1WElz2U/iqIhJWZmDFZFvvpu+etP9BMiATYyi3
         oI92DYjk78TNQrO/riaFodntz9G2jXCGltrbJBgNi8yLpfIXMZh0MfKFln4m94NTVevX
         +scA==
X-Forwarded-Encrypted: i=1; AJvYcCXwJcyxlGkUTpTfXWl0UUZhRUf3uFmRoVO0bnM4Ex5qr5NKGVu/KhPrXNRSCCB7sYVWNJcRL4l2Jv2p1abXBndrNOSHvNPIpVrUGJuaetwrHVPh9KlG
X-Gm-Message-State: AOJu0YzcaMLiGuEQviuXSvYz5uyDRSTWxbJsdKWW10/OisJrlYG+BisL
	jy7ElbkFv6GUS2O4dvoIzCl7N/qdRZL3Look5H2FTqScCw7GYHzcjfDF0Ol5OuSl4aNiZvVY/0T
	jmrCEQQ==
X-Google-Smtp-Source: AGHT+IGheo2jhvbyq/mwzt03pNi5hPYDX6/ZvoKfNHtDm06OJ0yCrlXwgMMDMBsWqTuF7xUhZ6xCgg==
X-Received: by 2002:a19:ca07:0:b0:52c:8342:6699 with SMTP id 2adb3069b0e04-52ea06a67ccmr1870960e87.55.1720112892390;
        Thu, 04 Jul 2024 10:08:12 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab0bb3bsm2519072e87.59.2024.07.04.10.08.12
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 10:08:12 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52e9380add2so1406033e87.3
        for <linux-security-module@vger.kernel.org>; Thu, 04 Jul 2024 10:08:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlFuBtPhLmf7mIMOwO88fSgvvQwpPBn8hvaV4CYoqXgiaa6gV3gvRthKkNFqE5VJ5SDKjE/YZf3exZjtcRp/f43bScLadVRkyOSNSFlQK7G7a5SwC9
X-Received: by 2002:a05:6512:204:b0:52c:8075:4f3 with SMTP id
 2adb3069b0e04-52ea0632781mr2063767e87.36.1720112891664; Thu, 04 Jul 2024
 10:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703182453.1580888-1-jarkko@kernel.org> <20240703182453.1580888-3-jarkko@kernel.org>
 <922603265d61011dbb23f18a04525ae973b83ffd.camel@HansenPartnership.com>
In-Reply-To: <922603265d61011dbb23f18a04525ae973b83ffd.camel@HansenPartnership.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jul 2024 10:07:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiM=Cyw-07EkbAH66pE50VzJiT3bVHv9CS=kYR6zz5mTQ@mail.gmail.com>
Message-ID: <CAHk-=wiM=Cyw-07EkbAH66pE50VzJiT3bVHv9CS=kYR6zz5mTQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] tpm: Address !chip->auth in tpm_buf_append_name()
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org, 
	Thorsten Leemhuis <regressions@leemhuis.info>, stable@vger.kernel.org, 
	Stefan Berger <stefanb@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 13:11, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> if (__and(IS_ENABLED(CONFIG_TCG_TPM2_HMAC), chip->auth))

Augh. Please don't do this.

That "__and()" thing may work, but it's entirely accidental that it does.

It's designed for config options _only_, and the fact that it then
happens to work for "first argument is config option, second argument
is C conditional".

The comment says that it's implementing "&&" using preprocessor
expansion only, but it's a *really* limited form of it. The arguments
are *not* arbitrary.

So no. Don't do this.

Just create a helper inline like

    static inline struct tpm2_auth *chip_auth(struct tpm_chip *chip)
    {
    #ifdef CONFIG_TCG_TPM2_HMAC
        return chip->auth;
    #else
        return NULL;
    #endif
    }

and if we really want to have some kind of automatic way of doing
this, we will *NOT* be using __and(), we'd do something like

        /* Return zero or 'value' depending on whether OPTION is
enabled or not */
        #define IF_ENABLED(option, value) __and(IS_ENABLED(option), value)

that actually would be documented and meaningful.

Not this internal random __and() implementation that is purely a
kconfig.h helper macro and SHOULD NOT be used anywhere else.

             Linus
