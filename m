Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EEC21ABAC;
	Fri,  7 Mar 2025 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356955; cv=none; b=C0tEDs6F1SZ0TcxeiWYjHQQDPu70H5RiSUqhxGw05tFNHqzD3xxqDkmnL4rwuIwXPv3GaIIl192OiO492U/ygCA2ORDUAk63rPBvk6r/b+hC4DBMMIqJzto3V2urXK7rI3AcK1T2OXNb9mnPMI/uFoRVp3SY4rFMMzeaqW3wWog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356955; c=relaxed/simple;
	bh=taP3F99W38M9kOmq3WxGykgtM2k764o1KKtTPDuFYV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XL3YoXqTXWWykz7p0TgIJriEyzpp9QoZREMZEJU06k9YnlBR49jsgb5puH5T++7et9fiUnVxPkEweviddcMt8FYpEbuIw0Gv492RrPchwdq5SFsrSIyYfVryzi9qAIJ2KIovYdJKpi3Y6rD1i3y8bRW52X6k7G0sXmY4Qn5w+W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hd9xcTAo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hd9xcTAo"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bc6a6aaf7so14810025e9.2;
        Fri, 07 Mar 2025 06:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741356951; x=1741961751; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kFwKmzBhAxlpLaATkDCjvlsMFFHGTZg+V5EA1F4aNnw=;
        b=Hd9xcTAoga5Fn636t00mkP+Xpff9ItuZ6+LoQs6zX68nAba9u0hKsYfo0PZm+Gov6W
         S9q38Yo2t2+v1UcqBlbDLa4CXPDrkfZKCHWHuCeIqhFzEbYG/u0KhjPqG97Jw+rbMRcP
         aTggIjXse9XLpUbsY43VO9p/6GWCCFijUEOHVcEeyMdeEdWvAi23kbyilFl3KKDNuTHS
         INwnV0BCZeutx3KaCy8JgAaOknuoXZGfE3nfv47OwZo+xzFrInF2n0oJaJczufldDFQZ
         8uocFDvPLzsUw30icorFaK7GfKa2ITZXgIL9xzvDx3qg/6k80mKFvQlD2KDTgrocNvri
         UH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741356951; x=1741961751;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFwKmzBhAxlpLaATkDCjvlsMFFHGTZg+V5EA1F4aNnw=;
        b=AbP7J7jYFYcJjpl7yPAgEY4N4y1yUaztC1o/6HpcCEHh5nc8cDOpvNGUcCAJGwz4NU
         b86KQzfbMond490q8KS4P/9Mlw64VNBAP2oEeeFKsPSdBnE/fIOzBMnhjDhA2wpq4JBR
         ehSMu9e3jNnTM1AXvkdwNbcUjbgI8hbztK2nknE9Rs5YCFpyzejA9DTyr8GVO/kcyazO
         SYkex85vwYlwcNM3ORjx/N2EgpALNGGr/y8Ir4GQmHi7h1xkKogxkGOrUXADQpfJhXfA
         E9nCvLAJnYKU4sdlVYul5H4O49jm/ZclsmAC3Fm3Bpjviofb6jOuZK3nMbHAGOavrNHi
         e6gg==
X-Forwarded-Encrypted: i=1; AJvYcCVn3d/HUKLxOS+T1RMSN8k48Dh6vHxyulU7699GaUAZpFN1hk4jYFFcom5mbl/kvc79+CQPkgW4TdqyYtLx@vger.kernel.org, AJvYcCWQuthK10kN7KaKxuUATubkpzw9VaWbgD60psvZsa3Z93M0Xm0+XhIDX34FPImUflm4r77nIw==@vger.kernel.org, AJvYcCXMXOgP75a7npwGuqpYhdCByy3QHKCe0WJCwNTXdGkpT2YaESDq4dQatLcWfzz55L9uRyO/JLXOptWXGrPVqg3cj0/4lzDj@vger.kernel.org
X-Gm-Message-State: AOJu0YztgE9HQKX2PVJ1DbCpPfZ5+Q0CLH+ElY9Zet7LyIOXPO8Sakxv
	JukbX8zX32NFWiOtDccOwmwx8jF+R4UzkcVJZE2VANw0w5mfrBUT/t1bGMjI
X-Gm-Gg: ASbGncv6RUS813ckTGNB0NxJ4sy6wV1jEjbXyjkZZ3gq1rk0nxNkSnlO+W2K0l8ztse
	B8d0EjW9Efp2s11cWL/W1Pvlg7QiB9xIdU4D+WbetwCiKY6FdzcFWpqFQSOXo3GIplX7DNSIpqp
	MsdnnfNDVHj52ReRByK6ZBTCpuxyBwssYADApdds/6p2f9O9UZ+wotrPNq+CgUUxAgwa8i1ArZl
	gzzbC1zVLL4k/X4xi02YiF6q2B5zafq/JHokRBAWs+EBdFxWC7tInFmVKcC4vu7QKijzUOVE6lR
	JHfd9QniyLJRaDFJKTGxC0OD38ms3bl9XZL/sY2st5uWzg==
X-Google-Smtp-Source: AGHT+IEeQbp0KPTtaRkHZdgqyWieJ4Lpbt+72nb/jjZnESc+t/wQXHMLHCm49p2mTJWtWxtSzfV9sg==
X-Received: by 2002:a05:600c:548c:b0:439:8bc3:a697 with SMTP id 5b1f17b1804b1-43c5a5e4f54mr26703145e9.4.1741356951169;
        Fri, 07 Mar 2025 06:15:51 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:a201:48ff:95d2:7dab:ae81])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912c0193bfsm5536881f8f.55.2025.03.07.06.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 06:15:50 -0800 (PST)
Date: Fri, 7 Mar 2025 15:15:44 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 02/24] landlock: Add unique ID generator
Message-ID: <20250307.db38587e80e7@gnoack.org>
References: <20250131163059.1139617-1-mic@digikod.net>
 <20250131163059.1139617-3-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250131163059.1139617-3-mic@digikod.net>

On Fri, Jan 31, 2025 at 05:30:37PM +0100, Mickaël Salaün wrote:
> --- /dev/null
> +++ b/security/landlock/id.c
> +static atomic64_t next_id = ATOMIC64_INIT(COUNTER_PRE_INIT);
> +
> +static void __init init_id(atomic64_t *const counter, const u32 random_32bits)
> +{
> +	u64 init;
> +
> +	/*
> +	 * Ensures sure 64-bit values are always used by user space (or may
> +	 * fail with -EOVERFLOW), and makes this testable.
> +	 */
> +	init = 1ULL << 32;
> +
> +	/*
> +	 * Makes a large (2^32) boot-time value to limit ID collision in logs
> +	 * from different boots, and to limit info leak about the number of
> +	 * initially (relative to the reader) created elements (e.g. domains).
> +	 */
> +	init += random_32bits;
> +
> +	/* Sets first or ignores.  This will be the first ID. */
> +	atomic64_cmpxchg(counter, COUNTER_PRE_INIT, init);

It feels like this should always need to succeed.  Or to say it the
other way around: If this cmpxchg were to fail, the guarantees from
your commit message would be broken.  Maybe it would be worth handling
that error case in a more direct way?


> +static void __init test_init_once(struct kunit *const test)
> +{
> +	const u64 first_init = 1ULL + U32_MAX;
> +	atomic64_t counter = ATOMIC64_INIT(COUNTER_PRE_INIT);
> +
> +	init_id(&counter, 0);
> +	KUNIT_EXPECT_EQ(test, atomic64_read(&counter), first_init);
> +
> +	init_id(&counter, ~0);
> +	KUNIT_EXPECT_EQ(test, atomic64_read(&counter), first_init);

Maybe we can annotate this with an explanatory message,
to make it slightly clearer that this is the point of the test:

KUNIT_EXPECT_EQ_MSG(test, atomic64_read(&counter), first_init,
    "should still have the same value after the subsequent init_id()");

–Günther
