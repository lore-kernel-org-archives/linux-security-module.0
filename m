Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6F97A129
	for <linux-security-module@vger.kernel.org>; Thu, 29 Feb 2024 18:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231062; cv=none; b=dFnvCNboVwkWuuE1y6yMJzuuRXo0bDhv9uzlM1JDIFJ5fCGSEZqORSm8xM1vXmrJ0MAaLi5FqfseCylq5u0B0iHqx/t3CgTlk10VrfGzCEEi8lgG7FOGeMJWuFDNGqZsCDz/3A31x36ZQNd+dGNpPotjThsUlr8atbvS3pj7NmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231062; c=relaxed/simple;
	bh=Y9KRbZhBlGJ/L8+onTzy/F5qfnhONJecU4/IHZrT6pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6ofKnBKToJwnIv6sp1scP85SsZnNjpobUa+Wem1bt1FCwKxTWBqo8ObZW8SOwJbbgaCqWH8+NcesszmcyX7+C8kp+lZhS7wlHWiErPdRLMrKzrgx1S4oeN6ZdLXtOjIm66k0vsHhu2nM9q/VFKTh7Y/1D8b+gYmC6ah/PJ5x6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DGB8d3AQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DGB8d3AQ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dca3951ad9so11569955ad.3
        for <linux-security-module@vger.kernel.org>; Thu, 29 Feb 2024 10:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709231060; x=1709835860; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pi3TKYGbYkDedreuD0VF7nTXnRCpQ3DLSOdVsFC+ytE=;
        b=DGB8d3AQl2+iH13eetsKydo3vb3vKmNPvdwsANlX2BfGL1DAG3u6KjA12l5TgeafeN
         9ds6vKjxHstX5iBQRgKg5KHOSOF0WV0/Z9kUXF6cBZZJbR924zVB3M9ievzHMEO/hDkx
         cgpQVyk+n/MzWXXKylu8Cz+BC8oJILk7P8g00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709231060; x=1709835860;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi3TKYGbYkDedreuD0VF7nTXnRCpQ3DLSOdVsFC+ytE=;
        b=ePJPw0cDIo7UhEGGJSTeGxEQLimDyJwQX3jYCJ57UqQDqN4H/9IJAbl1ID5Uu93ekc
         s00VgLshmVuDzemhGAe2SOUSSmSnCQxfS5afV7QD8VmzhpSAgB5WxsQ312kX0wkW0V0O
         19Yfv5OC/r8dVW521AwFtT5ePpmIo/1llHWmhVJE8oj/io6fzAMsOlDmDCPvW98tsmFV
         A9CtGYZKAZ9y1eWIC/XzlI0z5THjmIagpNWd3y2LPmVZe1cjNSsEPNr3to9P6o6O4yyS
         QM4NcB8DHPEojKsUAN7qBveeQEO2DqSjMaxXLhb+s+KsDkSvKG/EHJeZepGP76wqbbOG
         KU7w==
X-Forwarded-Encrypted: i=1; AJvYcCV7rD8cuGLuGFq07X5EDtDEnT/ji76BQKDukMRuuYbMc/I5+bGlYd8c2YrrzlRQcwKOcyl5vHc6WWBCmUZUBJq3fZwv90TTJ4rZklMtcy6Y9uKbfIh1
X-Gm-Message-State: AOJu0YzB3zpZAhEJy5PReHqdI7CGRa775GUSA1wUcBmr3BnqT+Nmktfw
	j3TputD6WPURpoO6DV1W8zCzjxIcEio5gpZCLM2+7vAaPvHZHBwgxjTCqbgTUw==
X-Google-Smtp-Source: AGHT+IGaWIUafiUvWzOx6gFaLolklPJ+XzrkV3hrkkZkuSARRfVzagRox8BqzdDqYvItAAhiU4VzEg==
X-Received: by 2002:a17:902:da85:b0:1dc:a60f:1b6a with SMTP id j5-20020a170902da8500b001dca60f1b6amr3395287plx.13.1709231060211;
        Thu, 29 Feb 2024 10:24:20 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u11-20020a170903124b00b001db2b8b2da7sm1793216plh.122.2024.02.29.10.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:24:19 -0800 (PST)
Date: Thu, 29 Feb 2024 10:24:19 -0800
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
Subject: Re: [PATCH v1 5/8] kunit: Handle test faults
Message-ID: <202402291023.071AA58E3@keescook>
References: <20240229170409.365386-1-mic@digikod.net>
 <20240229170409.365386-6-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229170409.365386-6-mic@digikod.net>

On Thu, Feb 29, 2024 at 06:04:06PM +0100, Mickaël Salaün wrote:
> Previously, when a kernel test thread crashed (e.g. NULL pointer
> dereference, general protection fault), the KUnit test hanged for 30
> seconds and exited with a timeout error.
> 
> Fix this issue by waiting on task_struct->vfork_done instead of the
> custom kunit_try_catch.try_completion, and track the execution state by
> initially setting try_result with -EFAULT and only setting it to 0 if
> the test passed.
> 
> Fix kunit_generic_run_threadfn_adapter() signature by returning 0
> instead of calling kthread_complete_and_exit().  Because thread's exit
> code is never checked, always set it to 0 to make it clear.
> 
> Fix the -EINTR error message, which couldn't be reached until now.
> 
> This is tested with a following patch.
> 
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

I assume we can start checking for "intentional" faults now?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
