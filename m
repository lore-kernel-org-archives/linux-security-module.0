Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03B919C546
	for <linux-security-module@vger.kernel.org>; Sun, 23 Nov 2025 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763916194; cv=none; b=SMCaXnpf8w0oukj8AHg8VeUk88UeA7WooYYk7jlD9UvgfyOVQBQapPTSpOnQgBR3oSEenNUQpRNYWrvvDjW+a94+UHxG2NzJi418aBuBvc+Sr8YjzLS0RgPwtxsSkz3ny84LWY9hh53vD/ZNgaQWj7Q/pgUkbVLi+we3N+yBa/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763916194; c=relaxed/simple;
	bh=yD8J2olIKgPHe37dofjigV9VmdZgEFl+iE9bgQC2sco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItKvdUnrQcH6xhTIbjjk6u5NAqg+dBntlSqJy3GaFVuhtTMeHWvCYQ7R84BnhK7KBTfhNsCG03DKBXBxqSB3TheYp1o/h41cFe0NIlBvAlvZJtyNdwgsLcHs8vasqVygj7RGXW0n5peqUD1A01XsCRRwFpcTErRSIQkxhIkzmqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fq5amoP5; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fq5amoP5"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-786943affbaso25373587b3.0
        for <linux-security-module@vger.kernel.org>; Sun, 23 Nov 2025 08:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763916191; x=1764520991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fN0yUJGuN6tfDMta/3VKFoDULumIxwwcMff04lMaDho=;
        b=Fq5amoP5pyA45+FTBBW8Ta35yMzv3CI6hPfNcZZftGhQOt4MH1PrSG4y/H0UMIGa/l
         OGe+t2ZatwhDm5HvLOn7CeXof7oqj/dyrVyKEGCR1wpepdMsAaQmNzz09tHEGlhnbVSr
         xMbWJzmFiCf+NFZjgc4CLrwWLufzHdzxNVQOTGplfCwywxB87bnLmKMAdxI+2oUH35xK
         bgPfssgdaf0sgiMx9lYEWrCy9osN6GfQ1n9FyAU3JzEpQ8nmFq5Uo5xi1s8WCwPyAyTd
         6zDTwLSqDLqxXGPYVAwivtnbvHIsJa5zHcfIVizussogqLHNoYT+53oRHEqVx66c3Xwv
         GVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763916191; x=1764520991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fN0yUJGuN6tfDMta/3VKFoDULumIxwwcMff04lMaDho=;
        b=iU6n3hjdiCI1gtcAHTqvHbL/mN64GQos9pZHv5IeD9KgEUgMAZ/OX5wmIHw4TlciAo
         r+30rPLzOGe8g0tiYahl1pBfoe1Ac2RvEPyjQoT87rxewVfLJpQKplOgdOYgjcmO4g72
         bVzSV0tIo/4lAwttbLL1wH35FzBUVW9EAzIxJxdJs6fm1iUN6yr9UmENMFQ4eGxsJqyU
         8pa5fRy9Y4G+GRD4GdF2/DhiGPcQmBYcjNHR107hiicgG+QkZ1JAp6OdcQ7RjSY81tQw
         4qgsBNUHEaLOPxhc3Q/W7up0N+cXw0qD0VtFPCT8Gqp86uPYx9O7eTi908OB+9XM5ITl
         j+7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJvqvpg+NbL7fd1I0tmOOgEgpyhhLDi/F8VHkcm2y9jd24LsK3kcW6uFd+uh3239jNnEZ5SdGt8L1NY/e6i4XkZuy936I=@vger.kernel.org
X-Gm-Message-State: AOJu0YysfcdxhpFsVKyqbRxSIpA5Sg6MhhlyaKtpjNzHVICXIL4pBBQ7
	T6wHlM5Gsl/IAH+abDOVa3vD5c9xB7A+5IFnRUEYHRUTKR5VhQ62tmbqWyYbTs508eA=
X-Gm-Gg: ASbGnctaiVIzo60h3E8Mv1LFf+chNvLZEol3OmNtTtcQrpbh0ZLYQOZNo26i9p2k2BO
	gZyrxNhg2QCSeLwckH+osC8wZ/N8vjttqF2ETJbCq86Wa3+mehZGlRPE2WGmC3D5jxL2mYsDHbj
	AP7C7bywTxDrj4ykxTtD+Fzu/OfeGNkDHB3ycqgMBzEf1h/iRWjo2OHxngpeq1fhul4KfN2lAUs
	3hh+GPwW7kDTdeHJae6IbMF/xpaYsHh65nB/8O+tccine2w0p2SiWkYfqIWwAuzhoBLx/yjCrMM
	8m7jhP3T3o6GooqS4LGVbVrSxDEFNRQxJBTG4uExsK0f7oXw3wciryorkzZnU6N3V7v2qmFWj4i
	4srwQlnuXq8Z6iwmi/ObakqDrZLAGBblix2gVQoJHt8BuxjaNV0K7oskxoPQVdVLTvh4JRxZaML
	RMSkRTaRYJNqCTkHh8cEKgz0Kqa2qixv98eltRBK3Em3iBUYRC98KOb1G6z0Mx
X-Google-Smtp-Source: AGHT+IFPSJpEoAd3hZVMxH6yI9UvB0MGpOv+SvctGIpuf98ABtgPl48Qs8Pv1GTFJzy3SdDP1XTd/A==
X-Received: by 2002:a05:690c:a85:b0:786:56ec:e3cf with SMTP id 00721157ae682-78a8b5754famr67556707b3.61.1763916191557;
        Sun, 23 Nov 2025 08:43:11 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a7993cc25sm36004917b3.44.2025.11.23.08.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 08:43:11 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: m@maowtm.org
Cc: gnoack@google.com,
	jack@suse.cz,
	linux-security-module@vger.kernel.org,
	mic@digikod.net,
	utilityemal77@gmail.com,
	xandfury@gmail.com
Subject: Re: [PATCH 5/6] landlock: Fix compilation error for kunit tests when CONFIG_AUDIT is disabled.
Date: Sun, 23 Nov 2025 11:43:07 -0500
Message-ID: <20251123164307.2639763-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <baa3449e-e238-4caa-a16e-c252016bf480@maowtm.org>
References: <baa3449e-e238-4caa-a16e-c252016bf480@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No problem it was an easy fix. I'll reply directly to your patch in the
future, I'm still figuring out mailing list development and kernel
development workflows.

I do realize now I have some behaviors in this series that impact the 
quiet flag that I want your input on. I'll add those as replies to 
your patch series as well. 

I plan to keep rebasing this patch off the quiet flag series as you release
new versions. I also plan to introduce some selftests combining the two flags
and ensuring they interact with eachother as expected.

The next version of this patch is going to include some big refactorings
(most likely removing the xarrays) and fix some edge cases I discovered.

King Regards,

Justin Suess

