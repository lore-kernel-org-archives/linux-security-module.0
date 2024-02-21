Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3EE1C33
	for <linux-security-module@vger.kernel.org>; Wed, 21 Feb 2024 00:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476621; cv=none; b=kDJlrE99N7SzSw2wncQf8pOnCyS2rm7r895KquaZAV9eIcWekxo8lVYAsVyfArEc0hH/htOODLpz/jXrupST1nDvDs0cY8QDcQphH0ty8Rvdwb1EplSSopKCpWFDhjDEZu5yelBdhra3oIamnnBJ4DPaQgNpaVs2YqpfVIlZoWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476621; c=relaxed/simple;
	bh=f9TmN17be0BaI4aB4G2ImJIieb6TnIzTskoR+maJi9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhO2YZD00Iquzc4zW/L1m+++87/rgcwHI1rXP9DEPtzCZPyAlQ/BeIY46HRe2gpTUJb1tU9ih6j6gcXfwBhVvY6JqRyRbyZ2zQoehCxUqSuNMHRTkZ+jTlCZcWlwLG6QeON6zKqSKL78nfvZuqVrqVVo1LYcWEHz4F99jaNyOQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lE0dubW5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lE0dubW5"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d746ce7d13so41668555ad.0
        for <linux-security-module@vger.kernel.org>; Tue, 20 Feb 2024 16:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708476619; x=1709081419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nKM5GL8m3XPROV8hICjNZ8s5cqcbwcRO2YeI2T2e7Ec=;
        b=lE0dubW5kPAvNG0fg01b8yevuMMXGZdrQ0IfjtD25Otmsy2zKUackh8v8Jwi/fTUq1
         sCyxU9NM5j5egrHrsW9VBZ6zbKMLJ0Cfs725Chds6rECRRybcCFMsQU4776s6kZwDNY0
         3nmQmMA9j+HJUuV7NVGt7Lw/a0wCFfZ6N0Wv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708476619; x=1709081419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKM5GL8m3XPROV8hICjNZ8s5cqcbwcRO2YeI2T2e7Ec=;
        b=KKXbJn/QvWvhD4o12VlHicyLH7BLhHjzWf0FnsIZa+efoBbfBF7kD98lFXoXZqZDJ3
         UcuwY6DNrzd/hJqOockTbTTVuvlqG65RXok5PdbvhGYrzcRin1NbBv1hTYEhs3+01XJD
         mkddom0g0KG+kJMwmxe/0ctOjNj28AmAt8Yxs9ai1BaNhGVnDdSgrsfnNYray41//rwX
         2AqZpbz8d52W2MZ98nPdnb/WbdyGf1ysJFr2JqF/NjPYq7FdSX8p88s/4YZ79Oe4D3sY
         bu/pV7cg8qV/n86QYQoHZvSEukCYOMO976Zb40y9WEFagNICa+vT+Cei+o3jQmLTmXZQ
         qEWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMyrAp9rwnl3VP5Z0F2VZ851A5YELtmpmwWhpZmrei3ncN9oa0kNflU6XQT/j0/GE6NvH6rHTgigm+4F2x2dlXopPcG6tF7SG3ekW2Jy9v9CIE+Sv8
X-Gm-Message-State: AOJu0Yy76fUGLxohDQOOGuaxTXsdPimdYvNAgzhdgjsm6T8hAl6FTMF7
	sKlmt/Z60Jqi8mCHk6P4eyb9TFktmcbMrfgNsB8IxCZDHbb0uVPWbBO+ndCpqg==
X-Google-Smtp-Source: AGHT+IEazzxps3jRajILlFOY+5/E6qDJS761uzHL3rRBg0GvHV+XLM76OnqMweREN/0hvlp4UejQSw==
X-Received: by 2002:a17:902:f68f:b0:1db:ca53:41d with SMTP id l15-20020a170902f68f00b001dbca53041dmr15021488plg.31.1708476618971;
        Tue, 20 Feb 2024 16:50:18 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kx11-20020a170902f94b00b001dbad2172cbsm6863205plb.8.2024.02.20.16.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 16:50:18 -0800 (PST)
Date: Tue, 20 Feb 2024 16:50:18 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, mic@digikod.net,
	linux-security-module@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH net-next v3 07/11] selftests: kselftest_harness: print
 test name for SKIP
Message-ID: <202402201650.5B12F716@keescook>
References: <20240220192235.2953484-1-kuba@kernel.org>
 <20240220192235.2953484-8-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220192235.2953484-8-kuba@kernel.org>

On Tue, Feb 20, 2024 at 11:22:31AM -0800, Jakub Kicinski wrote:
> Jakub points out that for parsers it's rather useful to always
> have the test name on the result line. Currently if we SKIP
> (or soon XFAIL or XPASS), we will print:
> 
> ok 17 # SKIP SCTP doesn't support IP_BIND_ADDRESS_NO_PORT
> 
>      ^
>      no test name
> 
> Always print the test name.
> KTAP format seems to allow or even call for it, per:
> https://docs.kernel.org/dev-tools/ktap.html
> 
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Link: https://lore.kernel.org/all/87jzn6lnou.fsf@cloudflare.com/
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
