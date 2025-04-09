Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97812268C49
	for <linux-security-module@vger.kernel.org>; Wed,  9 Apr 2025 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212812; cv=none; b=CAXbkDK9GmhH6iL5ihmyeACB0xjytAm0hoE32lBwZ6LCuuoJglAI0V3ltQh9Arj9P9Gm9Yz2WWstlVmGietDIsd6QaKfqDd35OOkTmDK3iYScgF3lvmMjnfOWbLxNMFmWX/gWUWOj6Qlm1xepnq9pAZH7zXfhaf8dSdmjF6GQCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212812; c=relaxed/simple;
	bh=Q+E+gm5uopjkervKkp2H2F4qs52H2bSWJcrVdOv471I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rb2umJeQakW6tMH18vIC+4oii7ISbxSGQPTau2FmsA6Te3785987UnakmFQkaAwA+A+BtL9UsPgRyh3g6FxQUX1hgoMdCeJ6cQ3IY0m93u8JRjkGsm2VNiddXqmZNXZizH93c8+1SIDnJirEFLwSIh0X7SBmHW3akTIV4vNeqiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LdTC/CCz; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LdTC/CCz"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86d3907524cso2927441241.0
        for <linux-security-module@vger.kernel.org>; Wed, 09 Apr 2025 08:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1744212809; x=1744817609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TdxP6TrUHsK7q8J2aaqhZA0bVAluAt8YBqPZ1F5Nh/M=;
        b=LdTC/CCzxEDHcpl+vmw0+nZoiNNPJWQyHMiRmY8lgDaIrVUH2KYHysKgMCUVVGO3f+
         v8Ky9SFRkr9RVqGyMKdfGoP7wNDgazr9gi6y0n4BXaFJ6rLXHOgw/OCCYM9v7p4/t1Vk
         0uuSEZVIuhlE6r48TQSRFYU3lbQ07Dt8XZNec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744212809; x=1744817609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TdxP6TrUHsK7q8J2aaqhZA0bVAluAt8YBqPZ1F5Nh/M=;
        b=BIEhYmrTxa9BeOwujQRLVg437vGPxL7cit/NhgfxDejk6MjorJD27BRV1mi5BI7PfB
         osI7vt67/q+T4/7kaNkHRLr+VXzSxlOZLyzt4ZkOkcO3wVGuU6GoKO7lui/je1/hfs9c
         dgye08KFIb+5zV0MSlLQHRrX4YKUWkE/QBlRsxg1NI3p/9bzDNaWhfbh3u8joI02kuaq
         UV/VMv9Z9ztmDkQBFJGBI0c8KshtWp7CCoMl33QfCVTtDvHH6wbgN7UUyNuW702b4vXD
         WIggM0Rcik2RfbQXvKwNKpFVm5jPdfFhz6equBMRvDQSE+/SPyWt/gx2/rbYVAA1GD1h
         eAng==
X-Forwarded-Encrypted: i=1; AJvYcCXiuvKlYxrmj3B361uNi9d9kAAooHrKQbersbukC8ZDpOmG6ToLCBez5Am1ROTF+LqJGLdR0o81Ih2xlYOMIsZds86Bb+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyOQz00hhAFDRGTi2zUUtkvYv5fuloh5cZwtqUpjQr8Y6xvDAL
	INvGgfeeVUReuwshBSIRC+CES9fXK38D035juxqqFqoq+zPipFHbdAzSV7DxmChrGK9yHQt4Hsa
	mGp/PaA==
X-Gm-Gg: ASbGncsmM2KB0tnZ5C484wBiQRlDM60ZiibxmAp8kDac4J6RXKiAI8wGpPikYtcTX2C
	t0XMqVM5tkpmM5g10eitRq10yGlIJp1RYXaWyaO2jLSAg1Gb7R1ZKFX+XPAY6vw8LU/Ws1MwoJN
	cJlL8emhscXlnVrRrBw2PYa2OAu0EIyE7CyqTiaLv4nIj/uPoJxxsyu7pG1ujT+xnTPodfHwXlK
	KFwn53W4CFlkf0JWGw7z5hKSKvsJV125SyuKBhTtQr5PLAABB0zv7+P/Tfxk91DzwFgoMSEor1i
	b3ywapvvkJ+4hbIII3sNiCjmY5J0WAAxMun7KnyfemgJjL63omdjHTUYRO/7jt6AWEKx/mktfhz
	YMzKZmft7oAlrkf+VrUIkRyaO4A==
X-Google-Smtp-Source: AGHT+IEzYIqx4AV545TyEDwO1ShU8ISZuhhPxUTJj+D9xnMSHai1CUEBI+yLGZqwbdfQwmkZCiF8HA==
X-Received: by 2002:a05:6102:2d05:b0:4c3:c9:c667 with SMTP id ada2fe7eead31-4c9c44957d0mr3503972137.24.1744212809294;
        Wed, 09 Apr 2025 08:33:29 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c9c98edc91sm209278137.29.2025.04.09.08.33.28
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 08:33:28 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86d5e3ddb66so3223520241.2
        for <linux-security-module@vger.kernel.org>; Wed, 09 Apr 2025 08:33:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVY/YBdAvmJWdLpl+ZXfpb3raDSSRBe+HBKurfqQZgj24aSJVPTJ9dNCudwlsS9FjbYo8NM/qXyS2KsFN7uXF9vqZVAM3k=@vger.kernel.org
X-Received: by 2002:a05:6102:91c:b0:4c1:6feb:83aa with SMTP id
 ada2fe7eead31-4c9c41a2f70mr3107478137.9.1744212808088; Wed, 09 Apr 2025
 08:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org>
 <202504081630.4CE88E855@keescook> <db50faff-7290-4193-b861-f60e36f1d1e3@sirena.org.uk>
In-Reply-To: <db50faff-7290-4193-b861-f60e36f1d1e3@sirena.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 9 Apr 2025 08:33:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjc+piYyUw36s4ttEkY32jVkxhRtyrt431wew7XcDS2Qg@mail.gmail.com>
X-Gm-Features: ATxdqUE2pdW27qPIvkrpo9DrN9_CijkuWYa_if9ESQH0ro1aFZDLb4UaGrE4hZA
Message-ID: <CAHk-=wjc+piYyUw36s4ttEkY32jVkxhRtyrt431wew7XcDS2Qg@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: Disable GCC plugins for compile test builds
To: Mark Brown <broonie@kernel.org>
Cc: Kees Cook <kees@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Apr 2025 at 05:20, Mark Brown <broonie@kernel.org> wrote:
>
> Note that the patch is only disabling for build coverage builds where
> the resulting binaries generally aren't going to actually be run.

Well, there's a reason we do build coverage - we also want to test
that the non-build coverage case builds.

And it's not actually obvious that it does - it's in fact rather
likely that the gcc plugin is broken in general, and it just so
happens that it's the build bots that find it.

Which is why I honestly would prefer to just disable the plugins in general.

Because the problem is the plugin, not the build coverage.

             Linus
