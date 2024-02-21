Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579CCFC11
	for <linux-security-module@vger.kernel.org>; Wed, 21 Feb 2024 00:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476730; cv=none; b=YvvdY3V2uJ+yQYm/5tHNiIZqExoXJsZSJ+wcrgxLO/R753KDUcj1Vd5ZjEsngG0gSh+RxR3dURrdT5xEDswSDx+zyZ8cg32llZaydBnE6J1ERe/SLHXtj+kWO+pDeub3SMD8G5mFmiQJkHDkips9X1ZayGKF6uQvqW4YT7adJVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476730; c=relaxed/simple;
	bh=9WK94qUvGMIRtk5etx9mPVS0NZhg+Y0iswprAI7O23g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkgVu/j/dfXhTGMhUXzWKTpg3sDPUv7mJaGEi1EYbcclU5zi4WElfwHXPTZrVNgD/CRrno+9WFiP1iOskZsvGwpAym8VXjmizpL3Y7jf0L5sXdsAoIP56BJpcgx+3uTTu2XC7QN8h5WEI41ubmm5xvLEhcoD57nxaPxorN4Csi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KsyUGATl; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KsyUGATl"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e43ee3f6fbso3104603b3a.3
        for <linux-security-module@vger.kernel.org>; Tue, 20 Feb 2024 16:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708476729; x=1709081529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2lCsz+v1VYXLr/Jnw9QhtpXgqVzJI761uB6BfnSGSFk=;
        b=KsyUGATlaZzXszYjBLJulj5f/Z7Kazsm0oYKerlLwdKMzYN9Fl5TRD6KwUgKRocFgc
         CcGRHHqp4eWDVzOhXFwtg+NG8Yq+yaXGs0N4Q+jIm2wEC36QIQEz5KKe8+PbsjqgF+RH
         7+29cTGKNw37BA5olsmu+o7MYnPHrkP8oeAXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708476729; x=1709081529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lCsz+v1VYXLr/Jnw9QhtpXgqVzJI761uB6BfnSGSFk=;
        b=TT6/Nhs9hBseqF4GXh+639Gk/R+9dvImDReGdmWTUVOU81yYqVIcbErZc2aMSrQfpg
         YoOj9A3bRca0OkYWSd7VIg0Bqzl5shmQz3PLhWdWrLiRcAyh5hQFGlkVJ0tYnlAB9jUW
         Nd6ZpQ7xzWnqIkmoLqXubvuZiQGFcul4/nzamXcWbaRg9cBzB4mTEKVfLEX4oVh4KyPO
         ZaPyKLl5PFvRz+i/9QIG3PhtaR6+7wsK4NRhpOhjYxRSM4DJA/PVYTfzrKfFyFKPHWE5
         jqpQa0dE19whQ2FAK+BsKFbTkAHE9zphx3xigtzC7V9W3AKFXFPCCln7O4NN5Cc3CGUd
         QleA==
X-Forwarded-Encrypted: i=1; AJvYcCXoxV0V/jZiT+DzhLCdRbwHjLJLJXR4HwOje5X007sFgTyLFNUsd+Pi9KXMDxpqFM+54+s714TKMOAOHq5JtIg5jiFd49rPSvNfmxfVhWTyJsccO6h8
X-Gm-Message-State: AOJu0Yy2LS8ydaYLQQfX59NPOmA4Gjim/D67byXxV7uJznBUPb29OcvM
	+wGh5P1b4cofjJZH+3bCx/mOOKBYKYazwDplj8J1bi23OaU5jmqedCiqQgPShw==
X-Google-Smtp-Source: AGHT+IGDKq1WFUbJKN04lJUQbFzZp5Vh6ABFfgeZYdhAWawTlpOMDmSDbq+YYY1nfxnYxMDPBoRY+w==
X-Received: by 2002:a05:6a00:22cc:b0:6e4:5a51:80f9 with SMTP id f12-20020a056a0022cc00b006e45a5180f9mr11536963pfj.22.1708476728817;
        Tue, 20 Feb 2024 16:52:08 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c11-20020aa781cb000000b006e11455bebbsm7431202pfn.84.2024.02.20.16.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 16:52:08 -0800 (PST)
Date: Tue, 20 Feb 2024 16:52:07 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, mic@digikod.net,
	linux-security-module@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH net-next v3 10/11] selftests: kselftest_harness: support
 using xfail
Message-ID: <202402201651.7C25039529@keescook>
References: <20240220192235.2953484-1-kuba@kernel.org>
 <20240220192235.2953484-11-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220192235.2953484-11-kuba@kernel.org>

On Tue, Feb 20, 2024 at 11:22:34AM -0800, Jakub Kicinski wrote:
> Currently some tests report skip for things they expect to fail
> e.g. when given combination of parameters is known to be unsupported.
> This is confusing because in an ideal test environment and fully
> featured kernel no tests should be skipped.
> 
> Selftest summary line already includes xfail and xpass counters,
> e.g.:
> 
> but there's no way to use it from within the harness.
> 
> Add a new per-fixture+variant combination list of test cases
> we expect to fail.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks for this implementation; this will work nicely. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
