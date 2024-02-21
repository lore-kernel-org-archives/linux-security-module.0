Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4A84C86
	for <linux-security-module@vger.kernel.org>; Wed, 21 Feb 2024 00:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476758; cv=none; b=hJ8Tj+lo+lb9chowz3beThkDq724+aACx0RwYqMP1TJ5Zkh7khaUHzRdA/HlnWLY3dG2ILFkJZO1KnqWHCPNQIqjxTf60KomvIfQSCY3Bew5Cf09D4C2c2VgORzkHnW1+UTRw3wQ/xyWXO3PfbgsjiCDhq3V7GbPUIvv1ELaPJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476758; c=relaxed/simple;
	bh=J92N7oppbKokaymoordlHfEGYpccRePizL+hh7TZ1dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFXM0EBLKWHKU/v2p6S4d6pz6q4qoK4mcZCN6dqvPfGdePDvfQcnyBa1gZ7hSLgnt/GIhpLrTDLslsghDvDvZy0XlooeaprTU1B4spsPCaCVMjWp8sKWSdP8YrH58fjZUpFeRS2hVI4dmjvAKDJSqBln7fnpwOFAXaQIFUEl2Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nLeHnXDS; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nLeHnXDS"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c03b92998eso4835234b6e.3
        for <linux-security-module@vger.kernel.org>; Tue, 20 Feb 2024 16:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708476755; x=1709081555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R+X3D1ev8b07YP6AkHk335qZFq2tm6Peno4gQaQD+cI=;
        b=nLeHnXDSkzY9OXSC2jWJtHHRiimsg/sJcZdHgcUYmA5dHoJT586otcHXeGWqXqjr4f
         ijDM2RHzxgZDdjyL7NYFnVKZxnh2cpNsc+n4+VAwelNtbyQbGr8vwfBA33Zz32vCdWix
         rOMbdsDUdXEzGH7XbVr2MlNsFHI4q6p+8geCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708476755; x=1709081555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+X3D1ev8b07YP6AkHk335qZFq2tm6Peno4gQaQD+cI=;
        b=WN0NiHaulS46oMCtnrC0eOenKWypYGVaUUG5QiDmTokEvw41ENO+ukALm/YpILbkdh
         QczTXRTEOj7+OJvMSU7+lBXglT2SitHo8L8Garne6Q76LZHjlXkiIDqCiVmMGsa+DS1t
         wc1NK6qLj8DUDhhmfYIHqqEjhyVpYfGtYpmMKYlsCb+xJhWTuyRMhlNCd1+7r4CWyib+
         DwgSfStqicTOE6ZKqdpXt4oYh9/b2t3EyRWvXNKpeNVnPjuMFVqScSckcVl2u0h5Wt0i
         iM1tKFfAQxWKoS5YGhhN1rPUDWI5cLZy2sy6aKSfu57mAAFQJpxXCE5v2wVNuwm5E9ts
         tz4A==
X-Forwarded-Encrypted: i=1; AJvYcCVIdiCHDBX+/8eUwk7XvwXQsOHK3LQo79DJHkALrX/+o4o9Pd7WhThDbKMinymWRsyCvfWJCLZ0aMc0/EobOYgrTmeLT5KxgCy8maSGXeZ1BweHGsNy
X-Gm-Message-State: AOJu0YwSGEFyXvF+kkAJFeLodVQ347iqWDxubDvGQasTRvm6kcyhqWnY
	2jI5JqJFKWKlszy0p8KjCThel9gz93+nSUfJ+4iaIDhaSsS02fGzdwZa8KE3jA==
X-Google-Smtp-Source: AGHT+IHQovIj/E8PPhTSxpkjPpb9Wj6cTXiVUJOisMr+S4qxc/4l1FXONqKBXYMEfc0hZP57LGgaUg==
X-Received: by 2002:a05:6808:f08:b0:3c1:57a1:bb87 with SMTP id m8-20020a0568080f0800b003c157a1bb87mr7875013oiw.19.1708476755611;
        Tue, 20 Feb 2024 16:52:35 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id du22-20020a056a002b5600b006e45d5f0645sm5211431pfb.101.2024.02.20.16.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 16:52:35 -0800 (PST)
Date: Tue, 20 Feb 2024 16:52:34 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, mic@digikod.net,
	linux-security-module@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH net-next v3 09/11] selftests: kselftest_harness: let PASS
 / FAIL provide diagnostic
Message-ID: <202402201652.599B4134C@keescook>
References: <20240220192235.2953484-1-kuba@kernel.org>
 <20240220192235.2953484-10-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220192235.2953484-10-kuba@kernel.org>

On Tue, Feb 20, 2024 at 11:22:33AM -0800, Jakub Kicinski wrote:
> Switch to printing KTAP line for PASS / FAIL with ksft_test_result_code(),
> this gives us the ability to report diagnostic messages.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
