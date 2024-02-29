Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757047A156
	for <linux-security-module@vger.kernel.org>; Thu, 29 Feb 2024 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231099; cv=none; b=sVj+A4Wsp6mKHLNsPHS+27r6A98NlIpM1y83ksMjyPaQ03k0NA2Q0iS9S1dKfnC6E6MOabtI0Yq4m8Y/iVBR5AnIo7sAiauBc9eNpjDbmc1VbIDJ/ts8sU/6yzShObq7+pDSi1uI01GaR/9hfrB8/sBW2+/+jU61NSg0DetG7bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231099; c=relaxed/simple;
	bh=Ce5pyQnb9GRcPSheUoJZhjpUrjGnCB77xYc5gcYNlxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKaH9GSww5CUvFyCWJXo2D8oOtgvMvdL6jfzioIfYD6VaN5uoHqmI52lGbtENG5LM+n8eU50g2+7JTRBDylA//dbTrFJGEK3ULw6g/yYCD5eTDdFob0KxPcACwEeNbeHU2W3kFEiRfhpwYz4AXcyd9tkoyHjdvuQLjratBCHD4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ENGQZjPM; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ENGQZjPM"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-299b818d63aso999553a91.0
        for <linux-security-module@vger.kernel.org>; Thu, 29 Feb 2024 10:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709231098; x=1709835898; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vqInfZ8mOq8nYZAY0kAdxi4SUGFvyqMPNmMOUUeoyfg=;
        b=ENGQZjPMfEh2sAf36guydCaOXrhzFaPN4I3K5F3QN2g7nWsuX9IC1WQj2/cLxkTHdi
         Qo5DZpoRSvdZZ7OuoVu0wrLcKPFz6BMXzeCZhehz9AbQaFwUOvTLl5YX7GMzj4yrJXJZ
         N8m53e6FL/rmWDTyAqgK+cvAkxUMAA5y2bUUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709231098; x=1709835898;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vqInfZ8mOq8nYZAY0kAdxi4SUGFvyqMPNmMOUUeoyfg=;
        b=q1PJKmcaw3dVSsvn6VcyjHYqMSg8RP8QR/NnwJ2h9Cs/cZwp4oaLpVIhLwJ0HTJOCK
         FdUYJ4MFeQ7GVSB7Yy7j1a4fb++8+UTdeAuaN9KSUp2omFkOxQpHZViF2cVZy3ELqzB3
         /gKlqZu4fZDgLEUxgL91nziVlEA79XVImcD4HUuYhlH8BMtB77qEy/lwc2btyCm1spz4
         nNEosUi3b2bGew+S22obZDsa75lb4qE0j3HBEAi0SEVPvyh9xt5LZ5y/bvBC0j3l5syJ
         LNT2ckYoGZgeI9XXdzWYGVt1M8+6injfjTtlB9trbXEqvaFokCRhse8rRBSCO9MJmopl
         lkew==
X-Forwarded-Encrypted: i=1; AJvYcCUDKfbNJ0HBGqWev9B9BQiAwrZw15rB8BN/bJOOot6vPTYkWih2//OAfk29nALMNchvMcUsXCnw3TdlC5fabmA0Mx7UMgVIq/JoqKvqOyK7vHWUp43Q
X-Gm-Message-State: AOJu0YxrO4jx5s7Tv5XZoz+jFvG06KwdveMk9/Kj5fcIempPybpIMKIk
	CfDD/0eIQO8RPuWmYAAZXGkZg7/99ugp2VlQ/J2OoCcWSm3A4diSIrbGkb5OCg==
X-Google-Smtp-Source: AGHT+IExuEVVJmKP2BNOyB+LtexDDJxYmvvXcikwCbgKNASK/A5xRah0QTnX1g4AE8/nsBFkMxCoNQ==
X-Received: by 2002:a17:90b:343:b0:29a:c992:198e with SMTP id fh3-20020a17090b034300b0029ac992198emr3923483pjb.15.1709231097697;
        Thu, 29 Feb 2024 10:24:57 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id pl4-20020a17090b268400b0029af4116662sm3911274pjb.21.2024.02.29.10.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:24:57 -0800 (PST)
Date: Thu, 29 Feb 2024 10:24:56 -0800
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Marco Pagani <marpagan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thara Gopinath <tgopinath@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Zahra Tarkhani <ztarkhani@microsoft.com>, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v1 6/8] kunit: Fix KUNIT_SUCCESS() calls in iov_iter tests
Message-ID: <202402291024.CE0082115@keescook>
References: <20240229170409.365386-1-mic@digikod.net>
 <20240229170409.365386-7-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229170409.365386-7-mic@digikod.net>

On Thu, Feb 29, 2024 at 06:04:07PM +0100, Mickaël Salaün wrote:
> Fix KUNIT_SUCCESS() calls to pass a test argument.
> 
> This is a no-op for now because this macro does nothing, but it will be
> required for the next commit.
> 
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
