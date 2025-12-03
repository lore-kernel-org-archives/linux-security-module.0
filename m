Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1228D2E091D
	for <linux-security-module@vger.kernel.org>; Wed,  3 Dec 2025 09:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764755337; cv=none; b=ZqQLOzIZbKnYKjobc9f1Reryz8dqZpfZeyVURZl/g6PPkZGgkuUXRjW7BoToiKletxrKg67i3E0phZfH3MRJNMJy8c5zH2GYMz7vlOuZ3Acy8NW7cu1Zw0OsRl8c1f2msffGlXlvs2ieRys2Hwf2ZCV7tR0LRY2dpjlIOR94FEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764755337; c=relaxed/simple;
	bh=3ZnWUK3HKDGk4zdoh5GqOErgrhko8OLlM5T1yiLy6qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWv1t0ENxQMKlJ2DTTG/0tSORiiUVFaMjpmxauBboYdAtdb/SNHNEIXWLKzT4y7FNVNl4qi57I2/V2XiW4tYlWWg8J+k8Dh4utUxZkTwTUpLgNJa1qoZKKau0+Eqt2GNeb/LlPqlWNSDzHviJToAOuUfomoh0xwdgiOi24D2AKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v/JRjOw0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v/JRjOw0"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso59959445e9.3
        for <linux-security-module@vger.kernel.org>; Wed, 03 Dec 2025 01:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764755331; x=1765360131; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bGDvF9yZLM3odfHvAF5/G4Kp5oJYIcIwRjw6e7mbYj0=;
        b=v/JRjOw0NEyBnH6SJEjgR/L6bc1y1bfYoVf+bghd0vEqUnfEcNzGC0FN0K97AKHRaF
         TSBdcJFe7zpN0QpiY56eO+Fx2h6cwmq641bxGYe31mMcdpuz5YhyReMuwhoYPhmKVQA5
         dyCm13bCqizE4V5pTKfhyGGXmKkeERswSgoiVsw1M53+JUlH5zIGtIteX9chKlJvvTE+
         fR2MvBWf8UgccXlWKEyD9ntLBDSrXZSFwKZXRNTkskKOPMFKpWEIb33td5Q6J5JBQOEK
         cT+HpbMpGD6YBwF4yxf6XtPa3GMDQU4iN6Ih+SSU8EqzONsmkGvRk0z2QwWEPfgcH4Mr
         AYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764755331; x=1765360131;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bGDvF9yZLM3odfHvAF5/G4Kp5oJYIcIwRjw6e7mbYj0=;
        b=VqY2C2ic+qo9+xvWTwZLryiO3inFyEiD6hs/sxaTLW/nWlQw7XzLStFcn5BfKlurAD
         GSP7jH6uL64uviFCTA/J1jeKVJVrRbIeTgrtl+rdfDuXmeqgIhrD3cDAQm9IuysdvsqT
         J2WxdZfly9DJotjMhezSqfDoMd96CmOxDCOHoh8dlHDi5mXq0Q7VVzuI+TkE743/9a6s
         F6j3eIEjI/YaEDp2R8vyhjVpwtEH2agmdvOsrJfo8XMrH1VCN7/VdJHcTc50t+9JurJm
         dR61vttLcsWf/hywDZtC/Lxti6KlkBkUliKGWmf0f136Pnm9qWVNDf0+z0PIbovQvPNG
         UPiw==
X-Forwarded-Encrypted: i=1; AJvYcCU4X5RQdYf/YqgmrY0sp1mGEQWp10+N03SF0JuSEq6PqlEAW0Kg0zpsNKp22j0JJNb0MK81dokZ6/5iemiJpj/6lCxQ2mw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2nwOMBGnc651KciW5httKhRmBWYfumsGLsp9205pzt6DGRtAR
	qxKFVHGOThHCYIwd7J1L4hPMgPJnggFy/Rjky1MuqmNI0j/IMmakk+Gjx99Augyidw==
X-Gm-Gg: ASbGncvrLb7G6pOCYAqILUfMTuwZaxD5v6x4M3aYT4yHkX0kDDeNkv+wNmnKZuED47u
	dxySDqtwjfG2MxgsOU4j5/RjkvYUbm/Po+tBDif3oIhlMWspT4mwIpN9+adVJQiFWoWBwBxEzRv
	w25R+LUXsDYdOL/3/vGxUXaJtDJj9VLErxW6k0Q8IxacJ4bT59Ni3mranb9wvyxm901CVrddwIR
	LLfD5vsv1OKvxYteqDtPhdHuomZIlpEknMEB1bXHFexIexfvGcEOFP55a1azcJB1nnYHfJvGvNQ
	Z8comCBI6FCBym+MLvvPTBJ/SQ7lRaoXIHAszzO5gf9yKV+p6om7qiET+H0SlkMW4zdAZuovFeG
	KFFiha8zTehFLf8/8XfcBw+yRDFt6oe//t3PgyrD43P4hwS4iPMAZM67NDT/9pEC2TK0geUa0kr
	6Jf/08JsTCXBftQy6Nm3Pch88asrc2pVzbbg18y9de/nPPZa1wIf5C
X-Google-Smtp-Source: AGHT+IGMmS0ddz6ffhi3ZUmetVnu+hu6kkoTurTLMwu9Cl6Jwx7YyWjy9Xutlc8Ku0N3yY2VVSDPGA==
X-Received: by 2002:a05:600c:1c28:b0:477:7b16:5fb1 with SMTP id 5b1f17b1804b1-4792aedf7ddmr21101955e9.7.1764755331077;
        Wed, 03 Dec 2025 01:48:51 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:ad7f:c764:2025:fcfc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792a79ed9asm37590805e9.6.2025.12.03.01.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 01:48:50 -0800 (PST)
Date: Wed, 3 Dec 2025 10:48:45 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] selftests/landlock: NULL-terminate unix pathname
 addresses
Message-ID: <aTAHfes90YxsXWt0@google.com>
References: <c2780073-9e74-4303-9e07-6b825963148e@buffet.re>
 <20251202215141.689986-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251202215141.689986-1-matthieu@buffet.re>

On Tue, Dec 02, 2025 at 10:51:41PM +0100, Matthieu Buffet wrote:
> The size of Unix pathname addresses is computed in selftests using
> offsetof(struct sockaddr_un, sun_path) + strlen(xxx). It should have
> been that +1, which makes addresses passed to the libc and kernel
> non-NULL-terminated. unix_mkname_bsd() fixes that in Linux so there is
> no harm, but just using sizeof(the address struct) should improve
> readability.
> 
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
> [...]

Thank you very much, this looks good!

Reviewed-by: Günther Noack <gnoack@google.com>

—Günther
