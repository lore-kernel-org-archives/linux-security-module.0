Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5502989A0
	for <linux-security-module@vger.kernel.org>; Tue, 22 Apr 2025 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745351601; cv=none; b=cW+ST9qiv5eeUfH9anbXqOVMPIgXFblYZvI/Pebj8QuEqkGF9rxgPIvc40waazdXyNx7qi4mSxkhHgM7zqI3Tv/EciTec6qDX43XGCHQXZfJmw/IdOyqfTKixT+XbTw0WPp5twEvZTRyL6yRTm8lUiYf5wkBnyoh87qY+r2Sz9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745351601; c=relaxed/simple;
	bh=PWxS3vH5MIya4Y1XE+8v8lo5FbaHNORUq5X/mTmli3w=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=AMB+BrNsNYgmTtBt7/mZIexO/Fxs+G49g64Acf20vUoV0yQEbcUnrFXho2RJ7kh7zmc+doU1BEnKnBgALoTk+p4h+tUP0kTdzk91pGQQ+bh4meTVaSM+fZed+/luwjL4iaYwwO6DdHpv0JriVkZl8JpBAXBpE/HaVNgQruMH82M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=M1u1LZv/; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="M1u1LZv/"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c55b53a459so565590185a.3
        for <linux-security-module@vger.kernel.org>; Tue, 22 Apr 2025 12:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745351598; x=1745956398; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CJeE91ey+OTutpPH1TtR3ZwONivHtJTNBwvGlSaUkMA=;
        b=M1u1LZv/B+p9P6GfqdJpTV4miwwvNgvGpmyz/5iakgkEjio6TocDjohtYBZoB2UMfd
         w9vP4WMQ5WZ7KSDQU8yoR2KRoeSHjjAo0g180MqZOpzKyCwNSwBpqqYnv4gbrrFSqYz3
         KzH9yqve2hUuGUUuPv7vUjtRjifLU8KdE1K1HMtznM0WGxp8gMyu0Qz7JR/ar9PZhMbt
         3kiAXjW/59iRAL6KgQ9n98xdlnuLV1/MtDskV68gM7P72tgF/+fhbEC/yr9u9+QAk/2z
         qXJVN1SvxnKNREjS9Ae+A4ZacN2dzag6dOUbsJ14WxK5HqCD8xBV0X7jPi5MkQOXEOOj
         /STw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745351598; x=1745956398;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CJeE91ey+OTutpPH1TtR3ZwONivHtJTNBwvGlSaUkMA=;
        b=Ua9bTVUpkxE+rxtJNsKwxAGjfoZx9GK02HC3vJyOdhn5eAXtVplSsW62EJpcUkkJEL
         Akm7BX7Uk8oqdYt6b3Phe49mL1el3jjj+YbAcyfNkCcwSFNa9sN1RD2R41Uyi0uqS4Rw
         IVzDac7tbAwz84P2i1KlB4nkb+SKOQCB1ZZ5mhZg5JNlx/apCh29gRX1XMxtOsb6qHq1
         GRtUyUReUxoBevQGNAwCtr2gcVmOM7fdEC/xCGwg5RqWdxD40I5dju2mXOYkOZljSVqV
         d83QZ+RXWh9muRynRlWA7DAVBYo2UcFbbRbTCdBYc7u27js47DpZ+9gE8o0atwJdFYP3
         q9WA==
X-Forwarded-Encrypted: i=1; AJvYcCUDFGDYbHUADMSSqLvUupQ+iKG5WP9SbCgAjgaLlGdYg54sn5huuaoBW0IHhkk+jvqe2mD7VbZUs75azeH4SLwMEGgJyRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBPCsdHeOMvYj+UwxnPfd6MKGE0MQu8cQCFe8Cn4hu7zFua6DV
	3PhNCMkRzyR5Yr2qGNzdTB/r76z2dZUCuOC7CIkCVEE1fgdHgj0H7rAxV4f8cg==
X-Gm-Gg: ASbGncu1tqu7BP1UbBrg6VQ55WkyBLuBxshQA1t9Oa+s+fxm8oxvTTcO2f17bgJAX64
	ByFFO/Ai4ir5nZvhobaNvjCrDAIile7BTH+EnwUqUExbfpDMOeHX2B0Vjk7Vp6h8yK818vLdtMZ
	NGoIU5TTGeSJ8o+UK55ssL0lbyEjdgKyeN1PYhaGtL37fO6RP/LhK1w8xMqfaA/SN3Hc54TfPHQ
	Kfcd/EZ6Bmpz9LqAW67LUlivZmVor1mXPh121s1quxjuO1Mz4xNHfbMSuR9+uLvaLG0j7uN5/K0
	dOMwPxA3vxkC+sGMBv7hLHBPuseXlPlsCfmoUuynR5gMX7+nXTNhzPoa0G93lS42UMj3i5zutEl
	97gI+UTH78A==
X-Google-Smtp-Source: AGHT+IEGx7RCSCPaBRlt4UyCxjeo8v0BkqRfujpf5izCF+XU0PoqJ0u/vaTxrHfxrjXPAyu1zRaLhw==
X-Received: by 2002:a05:620a:40d4:b0:7c8:4634:51d3 with SMTP id af79cd13be357-7c92805f620mr2982740285a.55.1745351597988;
        Tue, 22 Apr 2025 12:53:17 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c925a6e7b4sm594526685a.4.2025.04.22.12.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 12:53:17 -0700 (PDT)
Date: Tue, 22 Apr 2025 15:53:17 -0400
Message-ID: <973cedc0d38496b2096992bf68c72e67@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250422_1524/pstg-lib:20250422_1524/pstg-pwork:20250422_1524
From: Paul Moore <paul@paul-moore.com>
To: Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, kernel-team@meta.com, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Song Liu <song@kernel.org>
Subject: Re: [PATCH] lsm: make SECURITY_PATH always enabled
References: <20250422184407.3257964-1-song@kernel.org>
In-Reply-To: <20250422184407.3257964-1-song@kernel.org>

On Apr 22, 2025 Song Liu <song@kernel.org> wrote:
> 
> Only TOMOYO needed CONFIG_SECURITY_PATH when it was introduced. But now,
> AppArmor, EVM, IMA and LandLock also need it. And kernels are likely built
> with at least one of these enabled if CONFIG_SECURITY is enabled. Let's
> simplify the dependency.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
> This was initially proposed in [1], but got Nacked by Paul.

I chose not to merge the patch with the following comment:

 "If a Kconfig option is only needed by a subset of LSMs, which is the
  case for CONFIG_SECURITY_PATH, it should remain a build-time option."

... and that reasoning still sounds reasonable to me today.

> ... but it is really up to the LSMs to decide how
> they use struct path.

LSMs are currently free to select CONFIG_SECURITY_PATH as needed.  In
fact, if you look any modern Linux tree you'll see that TOMOYO, AppArmor,
Landlock, IMA, and EVM all select CONFIG_SECURITY_PATH based on their
individual Kconfig settings.

> The separation of CONFIG_SECURITY and CONFIG_SECURITY_PATH has actually
> caused confusion. In some of our early kernels, we enabled CONFIG_SECURITY
> but not CONFIG_SECURITY_PATH. Now, we have to add separate logic in user
> space to deal with missing CONFIG_SECURITY_PATH in these systems.

I'm sorry that you made some Kconfig choices on a production kernel that
you now regret, but that doesn't change things from an upstream
perspective.  The exception of course would be if there was a LSM that
*required* CONFIG_SECURITY_PATH but did not enable it or mark it as a
dependency in the LSM's Kconfig.  It doesn't sound like that is the case
here, but please let me know if that was the root cause so we can work
with the individual LSM to fix the associated Kconfig.

As you likely know, the LSM subsystem as a whole (framework and
individual LSMs) is often criticized over various performance impacts;
one of the easiest ways to limit the impact of the LSM on overall system
performance is to remove LSM hooks that are not needed.  Keeping the
CONFIG_SECURITY_PATH hooks as-is and allowing individual LSMs to opt-in
as needed is a reasonable balance between providing the necessary LSM
hook support and limiting performance impacts.

--
paul-moore.com
