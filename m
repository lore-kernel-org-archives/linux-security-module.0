Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93781BDE6
	for <linux-security-module@vger.kernel.org>; Sun, 15 Sep 2024 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726384287; cv=none; b=o1Hiq3RMZAMi19YWPiE3sdHZsOU9joAds25P0c9LlPw116QM9K4lEHx4lbh05hfA+TOV16x8PMP1fyxEuyz+crzcL+nHow6ur98KtDGtRQLG/leuD2QUURviAsthzRIgnVbk5OLvGKHhHYaFHsKGX0oMlVRoILwgl/n/FJmFiPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726384287; c=relaxed/simple;
	bh=xjWojUc1mLB5ktKYpFXYU5sO8vFqeC4TxRTtvNAcNTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOt2XmaLd+bUPT4lH4h+d9IjJ+299zhUK4sLltaOdXJ5tkKc7efB8/p8Vl8vwVR9+g1wJYbaWLtZQQtxlK6HY0o+MLp6HfS+S4LDOqCHW57dkFuVrgCQ3V/9z4SjlIP8BoZRlKjUAh1SLtnHUuMwT5vvxGIQziwMYEXCEYVft9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=g7MfO1ZT; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g7MfO1ZT"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c3ca32974fso3991266a12.3
        for <linux-security-module@vger.kernel.org>; Sun, 15 Sep 2024 00:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726384284; x=1726989084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yc55qxpiIVFj7PWD1KIvBrEfXf3cIQSNj9lFEjAYl9E=;
        b=g7MfO1ZTCqtEcsI2uxXwQYB41trv/aYnxKEeu/ZUWPq9H1MbiarpVfCXhjRQ4/cdfr
         a70CAIBqKCYm/2/woaPgbGTv3FMv6GVEpbrAcXvkH/UWoTmjiF8xWaSWZYYtoxxy9IPj
         h0R1zuhcy2MZg3z2EFD1uLOkeOSKPEOtpIBa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726384284; x=1726989084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yc55qxpiIVFj7PWD1KIvBrEfXf3cIQSNj9lFEjAYl9E=;
        b=nXQ0XKutecoPxJfzOY8QUJU90mx4gA+NDW94X5JM5iYgnRE1IeVxHi74GtrkeK4TpH
         uTBTiQL+mPgzhQexwMBEqkE64Vho6q1WGVVrHv8JrQpxkA3F2t0Edf0YT2KaIxEaoTVM
         oNOpk7C+nzdLLFnalBjX0BMIZyb5vqIinExoWPKWk1fXHye+a8YjnSMpxCPH+7SGj8wD
         tVgfM0qo7M/kLTWy7d2qfiJXh8Ry84a/BhXyFrgbHkK53UH8iFdfZmaLDHDu3hHAjZfV
         lEq18jT6L+ZD8JN6i7H9xPNjnyk88Zi598XEUQD+6VHu6yI0Ttnyy7SRUg6JBNd0sTGY
         7brQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAVU8VyYzXhpsBfhF2019csvFTCQ+d3zoNgRcK8tHmO6ZdR/uK6O+pYWjOonI37yBNZpE8gX6wNSCmjzEjI+A/v+fpkxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwscLubEk+V/T6pvL/H4tDn9plvnwbeSy81Ps0QiDTeBlZfmIMu
	uCcBRmwHmgo7yPzTk0SHPlQik9FaO6grbakgtOZWW37hclYM8r31zvhAjZ+1Xuhs6RYcn7yGTSe
	NBFkKaA==
X-Google-Smtp-Source: AGHT+IE9GbAQyzXBJodSMHL//Nw9vtzn/07dsPiy+hq20NMK+He15kA9/VA1uqM9VPXNviqz+3iVoQ==
X-Received: by 2002:a17:907:c7da:b0:a86:ac91:a571 with SMTP id a640c23a62f3a-a9029663027mr1067357066b.56.1726384283627;
        Sun, 15 Sep 2024 00:11:23 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b3a25sm160561066b.111.2024.09.15.00.11.21
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 00:11:21 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c42bda005eso1281961a12.0
        for <linux-security-module@vger.kernel.org>; Sun, 15 Sep 2024 00:11:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXa3JAOXrwlKJrSOMuiJnvgMfx0G7hSxuKyMM391D9DMiE5mzAFAyGC4NSRklrVpt4Q4Wk1Zc1+Lgn5JxyZgLteKnLatz4=@vger.kernel.org
X-Received: by 2002:a05:6402:5193:b0:5c2:7002:7cf8 with SMTP id
 4fb4d7f45d1cf-5c413e1f43bmr8669748a12.17.1726384281208; Sun, 15 Sep 2024
 00:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZuPDZL_EIoS60L1a@gondor.apana.org.au> <b4a3e55650a9e9f2302cf093e5cc8e739b4ac98f.camel@huaweicloud.com>
In-Reply-To: <b4a3e55650a9e9f2302cf093e5cc8e739b4ac98f.camel@huaweicloud.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 15 Sep 2024 09:11:04 +0200
X-Gmail-Original-Message-ID: <CAHk-=wiU24MGO7LZ1ZZYpQJr1+CSFG9VnB0Nyy4xZSSc_Zu0rg@mail.gmail.com>
Message-ID: <CAHk-=wiU24MGO7LZ1ZZYpQJr1+CSFG9VnB0Nyy4xZSSc_Zu0rg@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] KEYS: Add support for PGP keys and signatures
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dhowells@redhat.com, dwmw2@infradead.org, 
	davem@davemloft.net, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, zohar@linux.ibm.com, 
	linux-integrity@vger.kernel.org, roberto.sassu@huawei.com, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 10:30, Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Fri, 2024-09-13 at 12:45 +0800, Herbert Xu wrote:
> >
> > Does this address Linus's objections? If not then we cannot proceed.
>
> I hope to get an answer from him.

So honestly, just the series adding pgp key verification I have no
objection to. The use case where some firmware uses pgp to validate
allowed keys in EFI variables etc sounds like a "ok, then we need to
parse them".

The objections I had were against the whole "start doing policy in
kernel", with what sounded like actually parsing and unpacking rpm
contents and verifying them with a pgp key. *That* still sounds like a
disaster to me, and is the part that made me go "why isn't that done
in user space together with then generating the fsverifty
information"?

The argument that the kernel is the only part of the system you trust
is bogus. The kernel does nothing on its own (apart from device
enumeration etc of course), so if you have no trustworthy user space,
then you might as well just give up entirely. At a *minimum* you have
initrd, and that can then be the start of a chain of user space trust.

Parsing rpm files in the kernel really sounds horrendous. But that
doesn't mean that I hate *this* series that just adds pgp key handling
in case there are other valid uses for it.

But maybe I misunderstood the original suggestion from Roberto.

              Linus
