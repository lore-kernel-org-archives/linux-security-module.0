Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E5627FD5B
	for <linux-security-module@vger.kernel.org>; Thu, 27 Nov 2025 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764236085; cv=none; b=mxVn9fYdcgqAXr3RNt8lPDzjxSL45XHBJ89YWHqwwn/iHwxxhtVysGmbRA21jlIQ/8gs1CH4Pc8oIVn2nARV+2eRvimArN5e0nbT+c8MfoIvCMnXsSadOzhotc5SdjvrjlBBlKMpCjzaHPfLeUN8QjwCGBoyX+Jb289kQpRRBio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764236085; c=relaxed/simple;
	bh=YWVbLI8rsQfNQcAEuHL9Z5FSPE89daK9SoHrwEqVbJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSWymBXjCwIZuWAHwXDZSCDjmHMM4P5m3W0RybaqhYiIsIi81jknpYwpIdJ1/BijRlfxX3K+uKt8S62Tb4upzRnafF10axYRplhAj9XiYppEav8Dr8ohyQ2bohkdYJNb/NxnU8FKb8gCrBuPtt2/8j6BiPBRNYm9RYWzhi/2bg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VYw4U9+b; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VYw4U9+b"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477770019e4so4447215e9.3
        for <linux-security-module@vger.kernel.org>; Thu, 27 Nov 2025 01:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764236082; x=1764840882; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D4iB86HiBqpIrNk+DpS2MBBPoLlvURkYL2oqUWOP1w4=;
        b=VYw4U9+bTZXUmnL/7CKgkjzOpyfeQ9nQ//la8faXbsg10KyFa0WzEQPOgoxPk/Mx/A
         Xqfkcat8u4F2LcyTFMkQNNOPTRuugITgWdgPHVjMdj6TfLv0RO6vrpnnOmy7KtglEW9t
         kx9sBhW0qyZNCAddyC0NU15wKuG+8ybsc0jwkRPX8Vy1u8+J/m9rHz56pnZMCSdNVzPc
         w/V5i8zxgEE7b05jX5L0qKdfn1r2abJqPXfmRQoODnvpHa7uUVbocgi17ccmeLUx7iQK
         ZKvmUijn1Cb9gsTwrzUB+0CDsLQms0/I5oNgeuNukettrUM589p6A8gcHOQttyzk0w5Z
         N5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764236082; x=1764840882;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4iB86HiBqpIrNk+DpS2MBBPoLlvURkYL2oqUWOP1w4=;
        b=UqBU2Bkr+eBarwqsKLPS9o/EIi0WBIyH3Z0OUgmJWGze1mPduyAzo5BXNqCuA8QwLs
         v95uBRc5SKY9m1wFcf7IKB5WDcxE9vi86uCnJUWPzWE/ROuVfu2o0JUaCwBiLVIl9kn4
         f+0yUqTBquDWIR84xoJEWtzluvMEHE1+b7jmh4VcoBOYosIfAWfc5NdURDa2pL/BUvKi
         AHlJw9e+AaUxMmd52QLdPAQxNvPPJtbitbVQUfhxa/lByG0PBdDv3Ax0f55t5aP7+wZ4
         bKUc4hmRuX7lYSA0WPoHzo6RVJhRahYBDrlzSRRWguBEBzckCo6rtOUN1Er2IbiSSIgu
         tmxA==
X-Forwarded-Encrypted: i=1; AJvYcCU0vrg09S68ZPGDm8kBP5O2az2WPq6688RuPEkwfBzZ9Pfg9dZ4tIoZC/O7Beg3LBhs3lzCnDNteVNxpmDktDaW2Qos3nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAj8E9Vhp+zrjXFId/3rFC8grRKdnCzMJWlY6bldEjtcjg6+49
	dWKPlNM2vtcAZR3fpXpCfahXGz3j5Y8Gxpn1j1h5eLlHy3aosVq68eOgQitXL9zCAw==
X-Gm-Gg: ASbGncvHBprzyzk9GwGFbA3SNkEvXHPEyYJ9f5TOiL+NqdMx3M8Vc+jNNOwbTPFJpPd
	XrCXZ2T28sfrOKXrh5JhKt1SMsOWBuKsTOXA2JkPwKkcUemQ+HimYk1inoFDa+Lpl91rCZMlBOo
	q69JsdevoqQe0qK0i4F8cPbap2unNEpsueyXcMWJujNZBZ1IggFluMKl7zobh0bMQQDi5y/FSHb
	dwoWXdW7vTZxi+IxbLGDq2tZYJjKwiDFjfEXA45UxopDTL2XFCMHm3jw575UE7lRaooQByePEtM
	1Yq/Uhg71ocKV2dDYwRWBmoH7TLuFdtb9Z8R9QCexUPS+oApM5PVCnqHoxOwOA04rouQB3tUyKN
	pmXZzGYRIkWsntDnfLMwL4Yq9H1ABJwT2zNoRtmWID4Mo4E7mHwsS6EIHNg+65tlrGUyJhDDgof
	B1vZWUbHpKkfXZzBe325vHE/Mod+WNIE53OKU3KKVM3w==
X-Google-Smtp-Source: AGHT+IHynBAZMCAv8bLxZ+2D8XZRd95/RvGIBcr986L2bu50ewc8Q/uQ6wrUdTSJCIDmduh4WTvbLg==
X-Received: by 2002:a05:600c:3112:b0:475:e09c:960e with SMTP id 5b1f17b1804b1-47904b2c36emr97631655e9.32.1764236082305;
        Thu, 27 Nov 2025 01:34:42 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:2372:89e8:ec59:7515])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790ade13ddsm86802205e9.8.2025.11.27.01.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 01:34:41 -0800 (PST)
Date: Thu, 27 Nov 2025 10:34:37 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Jann Horn <jannh@google.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Tingmao Wang <m@maowtm.org>, Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/2] landlock: Multithreading support for
 landlock_restrict_self()
Message-ID: <aSgbLXP2PDveutjq@google.com>
References: <20251001111807.18902-1-gnoack@google.com>
 <20251001111807.18902-2-gnoack@google.com>
 <20251017.ohthoos9Ogha@digikod.net>
 <CAG48ez2KoF6hVSJwdPfUpN3oroMww6Mu1+-bsBSbO8C5f91P6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2KoF6hVSJwdPfUpN3oroMww6Mu1+-bsBSbO8C5f91P6Q@mail.gmail.com>

Thank you for the thorough review!  You are correct about all three
points.  I replied in the response to the mail one above to have the
conversation in one place.

On Fri, Oct 24, 2025 at 11:18:39PM +0200, Jann Horn wrote:
> [...]

—Günther
