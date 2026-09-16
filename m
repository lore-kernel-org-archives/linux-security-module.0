Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B66348C6F
	for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2026 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570395; cv=none; b=KmuLdP7hQ88snfV5ZathTml4gOtkEWjlEpLJXPrp7qIU9zXN7GrFQi98SQGgWTOP9ucq6qlZySujJXQzrWvsNCd8m6oo5NDmpl6y+E2kn+y2l7aOi3ekpR31Rm55zjIpdMA3Po4sfReiBvD8TI2JqQZv6VxxNiv1hageA0UPjrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570395; c=relaxed/simple;
	bh=OuC/W/DNESdwVjHCYITglUUqtb1LIzuHPvq0FWVR0VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fk4TmsysRCIhIJecspGUTUL2yWtBfeC0a8L9DNC1EjqN7UmFfCh3B+o3gpcPfPz/BPHd1jVywD31MgyTmnQb/wA1RX/f6wobuwC50D4KvM7H2zS6JkT4G8r4h8/ICcb1jX2g/yZA7pAIz5m2HypLyQ9WZ0DCMr2hsLPa3DTr2uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=XZmh/oNP; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="XZmh/oNP"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66d20e873c7so124356d50.0
        for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2026 07:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1789570393; x=1790175193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RW23e0CCUw23TNIxrY8dug480YZmKW8Fw0A6LLlcPJA=;
        b=XZmh/oNP32aU78zXe69kHDDX9SVy4LiEvpPNDqLOmx6LS6a7Yck4tikMYUWR9sxUea
         JA9AELJJVIldGwQDuKTD2SzXO428XaiiAckas9kVYi4+XCJbCL2N7iI5R6GuH45f2+p7
         uLZrU4a4bYKtwP47sMacr7DGSTc9e9UV5hLJMSgAcDvP1ir8dMw1dy3bgWOmFLLO6s0r
         7QTRV/cWymqw0Sg+SujDWvX+ZUotS599nnPMPXMPdKtQKULJOnrah3k92oT4b2LD9/36
         OlL2DnI0TcBW+K5qKbc/wF+nCavAe5jBWcZ3jBLIHH827BFmw6Fo3b7lFnirSMXB0Q7D
         8HyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789570393; x=1790175193;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RW23e0CCUw23TNIxrY8dug480YZmKW8Fw0A6LLlcPJA=;
        b=jLhDD3VmIYPIrrgInrKuX9SrqT4Z6+8NVDN4MmfuteH9e/eoMC2lWvkJXsaZ6i+o6c
         sRymq9hviznGGojqYn6lItEhxtMZ7fMIwViLFXQzdSvhdnNDI/9y12/qXIzwJwRfuMaS
         z+9uGL4tPZitPaxfQ1jYcmEUtDI8w1in2Xm0bP4oWrOlPLLcjpJg6hjKYcOWoi4Eo4Y6
         U7ZpUtZWXOE2oHXDupVckqtACuvbql9R0KSunAtCVHZoZCn837sg8nJLvbeUnIUlCtg4
         tQPgGrOotsWXquuSlCAkmWhkhpYa/t+IGtvtzaa90V90Zy3OW9ogrN5bDZ3Yj02j59lx
         rJcA==
X-Forwarded-Encrypted: i=1; AKwUvBwfnw2RF3HPxIY10uGiREbgbpP2AGcz3vu8IngmzK944TsBjGcVB8ARvUbAg3SsDrMZr4PoSa9mGcnWZDWU6oKFL6eAAJY=@vger.kernel.org
X-Gm-Message-State: AFuF++nLyZcD0OZ+mgVsKpPv32Vwt5cIwJ5WwHchVERGZcYniyji+EIW
	Zy4NNqRUVkwP2bsCizZCmRFrNROkR/tnyxqXUyBfwq3JDB5I25v/CiZXLXX8ldoZb/ta
X-Gm-Gg: AYBFou0zu77R5hI6n+bSJ0B7ZXDqMZ2PntO3cE4SY4H3PDpDi1M7ujzjrO0mLOeffGG
	mhVTkOiJZJPVtIGw5jMbzwQa8WzonrwtttPTvEAt/q+fG24YlGGQ74cJ1zRwNbbXcVEw5yZwvj0
	PJ1dZTfXe4ZpbVm8PKGS2wEjkEeIEt3vHRibN3IpPLrnlPFgOAJIJy7U5R2fxKnX8Wgjyq0I9VD
	CckNw4J3890AtDqgVjUe7Ueyc4k+AMi5C+sSJFNv7L1bpgLMdMakWOEWSoZi/eHgybWQppPM8qM
	SOOPev5EPpSO0pbWykBe5H87eoSLAAm3fXi0uIp1X5TByzpMvD3YbHpHgTZfb6ytjs52j65DZQw
	yMD50oqga5zy3sLMT1OpM/iWzHcAN6hwTPPMeq9k0BNaQTwNxpC9lPykEuztEcyeQXCFwg0bCdR
	oT7bgLNpROFHmnxSuVxt8c2UGTV19jy9Hsc97qpqh1n/R4p9YleFDnLyMj1SJoVs2JBz9o9doHP
	aEwDw/1w9InCAbeBQBuGcX9Rp9Mjt5p7ZzEcyk=
X-Received: by 2002:a53:cd11:0:b0:66f:c852:209f with SMTP id 956f58d0204a3-671631f60fdmr1054076d50.2.1789570393120;
        Wed, 16 Sep 2026 07:53:13 -0700 (PDT)
Received: from kelso (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6715f787276sm1397653d50.19.2026.09.16.07.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 07:53:12 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: landlock: clarify TTY signal scoping
Date: Wed, 16 Sep 2026 10:52:55 -0400
Message-ID: <20260916145255.1587381-1-clusk@northecho.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <aqqJAZfG9FC7PgMW@google.com>
References: <20260914.b8a029f9abb8@gnoack.org> <20260914180946.1462099-1-clusk@northecho.dev> <aqqJAZfG9FC7PgMW@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Günther,

Thank you for the careful review.

The phrase "or otherwise driving a terminal" was LLM over-generalization,
not a separate mechanism.  I checked the paths I had in mind against the
source, and none justifies that broader wording.  I am dropping it.

You are also right about the verbosity.  The generated text expanded a
two-line distinction into 15 lines and obscured the main point.  I will use
your suggested sentence and remove the signal enumeration.  I do not have a
stable kernel documentation URL for that list, so I will not add a citation.

v2 will contain your sentence and a short LANDLOCK_SCOPE_SIGNAL remark in
landlock.h, matched to the recent MAKE_REG whiteout remark.  I will post it
as a new top-level patch with a Link back to this discussion.

I will keep the positive selftest you suggested as a separate follow-up so
the documentation clarification can be reviewed independently.

Christopher
