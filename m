Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D2B20E3
	for <linux-security-module@vger.kernel.org>; Wed, 21 Feb 2024 00:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476569; cv=none; b=Yw2YW4uI6UReLltHFrZpGK64At4jqRmpi4qYYGir5tEZ8JE/7TYtvpYPGH+H4slDRm7eSaDu4kSmJipWUzp7r1YYVDv3wwCAaHSaytLVyYKV0x2f5zXExbmWSU/qBjxmlNxWrWbVGjqFtdeQr6pvDVXDzX6J0Fk1ESHXC+bLyck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476569; c=relaxed/simple;
	bh=cIRuw18MgK3s3QPYG5bF8HaUdZMx7uHI+euu6IBW8e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhYVqsdz+c5yz0NDKQBvW5iyQKrrRj0QfJA05LlCZ5p00WX1iwCmTJuM5ygi02e0vHMmu/xlKiFaiTzgmsPHHI8iSLBFBkqcGYFlo5N/+cRCwsuOK4wYhUicPnntEkmLMW8rUc3y4j6reLLaDNaPSlID2OPhpGz6svU9PG0/StA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PEo0tGgy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PEo0tGgy"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1db5212e2f6so45004745ad.1
        for <linux-security-module@vger.kernel.org>; Tue, 20 Feb 2024 16:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708476567; x=1709081367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l6iZPQkJ9eVozTwMvVtiCWD1JWn1A/ViHwX542hh6CA=;
        b=PEo0tGgy8iKWLybFGwoJXcTltbGU1p3TqNEKJWGiLDhDlDgH9lkOtyG1WDia8JuaWn
         wYyDFYqOJHMABYWB2qmfvsNovoNoZ2Mk1kBNMcWffnb2WUtIwSZwMUbOsjBw3tThctWW
         ibYukAqdeBTArIYb9VgX8sEf/vXlZnbxss/G0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708476567; x=1709081367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6iZPQkJ9eVozTwMvVtiCWD1JWn1A/ViHwX542hh6CA=;
        b=ijm3xXuPtiF7VDN8AudKSljL2BQNM3W/pEgAhR/Lds9s5F/z2uZ3HmskaOWXFOli9D
         QpicYyJNkTJ7W9SnfiSsHQQryL8D6ejVNeZkT5VIJRbFDUvJwBcVLlNcZSbGg18vj1zo
         yvb/8+gemHXG0Fs+YNApAb/8cvgOpb6gKlwzl7vV4t6bdBCZ8PypaQ8PElmHvBSyKfWP
         khRllEV+Q9gUg4oHQDvXgaDv7XOfLAQJdDwINjX0FyL5hQ/oNRHtd6VR3JYYISYXnCTh
         zsoh5COvWOyq+yeyUmup7bMHRcY+YTQEk0wYQMO7KLWqOtOnNRE5Q+adHf4Xc/0Xj8vy
         3YDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKiMr27lniIgLtpCfkDf0/W4aFluYB/dJJPvsIvnqH3hf0vtgfFG2UDteZznN5Vys0T41qBMaiYojAi7rsbz6pc1hWDRHtTKVRhNVPbKr8Js/J+KzR
X-Gm-Message-State: AOJu0YzBokP77VVOMLqrI1M8ja7YAKy0N6zHftQo95+wiWyS/sah/FiP
	fmqL4vcWi5ZWZqM2qoylYoz8/pvFPRc4qmtVfg7mrxm6T9id2K3gsGCaCsgs5A==
X-Google-Smtp-Source: AGHT+IGrH8eYOJ+QTDt/PHAS3tq4N8QvcVgEEHaffSlr+I8HL+Yj6EPAOIVXls/P99vM+K5FbSBvRA==
X-Received: by 2002:a17:903:183:b0:1dc:2ee5:3f3a with SMTP id z3-20020a170903018300b001dc2ee53f3amr608581plg.0.1708476566981;
        Tue, 20 Feb 2024 16:49:26 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s2-20020a632c02000000b005dc98d9114bsm7242084pgs.43.2024.02.20.16.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 16:49:26 -0800 (PST)
Date: Tue, 20 Feb 2024 16:49:25 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, mic@digikod.net,
	linux-security-module@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH net-next v3 05/11] selftests: kselftest_harness: use exit
 code to store skip
Message-ID: <202402201649.C83025144D@keescook>
References: <20240220192235.2953484-1-kuba@kernel.org>
 <20240220192235.2953484-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220192235.2953484-6-kuba@kernel.org>

On Tue, Feb 20, 2024 at 11:22:29AM -0800, Jakub Kicinski wrote:
> We always use skip in combination with exit_code being 0
> (KSFT_PASS). This are basic KSFT / KTAP semantics.
> Store the right KSFT_* code in exit_code directly.
> 
> This makes it easier to support tests reporting other
> extended KSFT_* codes like XFAIL / XPASS.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
