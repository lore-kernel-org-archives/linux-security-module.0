Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05708371075
	for <linux-security-module@vger.kernel.org>; Mon,  2 Feb 2026 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770053827; cv=none; b=U40ROFn4FSb3yf/5AoN1hNWcTphEQCiqn/TyD3ETiWM1A40QCYZHOb5xNZsVb21BxwyToTPAMvd4HTSqv2+lpDKN4woKLuon9T3irn5yHokM1gsR1PQ1aPwj1AFsn2pRYeW1p69LuL+QsU6xtNILK/akPKyxE0Z8Z48ZiGSXanQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770053827; c=relaxed/simple;
	bh=QXaCuqWgBJHGHpBvIy2QGuy/IVah5Un6LUr7u4WB60M=;
	h=Date:Message-ID:From:To:Cc:Subject; b=s+/1HEYf4JdE2TXS1kgSf1ATIL3h5wAO8tkRIjgg1Zyw3/nkQVi/y/BiiISPie3OH4Txb73l2XQJvWz7+pBnVmILAY1kCZFul/2kgXYBiH5+Iq9xennLUtHTnQKte2McGjSWV2T4qsxCc2Ct4qclXO74IvXfdT8V+VTmYeEf3l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gciPp0T9; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gciPp0T9"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c52c67f64cso438640285a.0
        for <linux-security-module@vger.kernel.org>; Mon, 02 Feb 2026 09:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1770053824; x=1770658624; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zxkngtuq35HTzxqeFUrhct/sRo7IwSyEooPYTzLXoP0=;
        b=gciPp0T9mYRFdb4T53TK+9FWSxc03QYpwBumzftZCm7dO4jFVow+b9agPyHA3mk429
         6G1k1I/5nQC0iGDABmAVRlNLxuameo/Z4PqEY3kdj5yTbyvblaeaP7QeObXNeg0uJs9X
         2V4XxmRMcnQHrdOJL0y/d/+Xe4O2HFUQ2UdppEO3MQL82qevjnfARb1KeQFfvTYKkxJR
         emjGMjydaRRp23WEV45hudWjp4e7O7iV3PzcqHkSIlOC5nAsSpH0ZPpzslLN7piNK+Yx
         c6DxOeIyg5NFwUpOzsusk57nvm7r6xJM8hrh53+hFGfTaDkWSM0aI3+EkYQUHAnTV2BQ
         IS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770053824; x=1770658624;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zxkngtuq35HTzxqeFUrhct/sRo7IwSyEooPYTzLXoP0=;
        b=b/WGQbJTXBXwUQjxNKs5Evz1dDYgzjh0M38wF8vxs8ydwNIxodAQ6bVdc9jduZ1W3Q
         isvutqukYoyDCmmlZPx4LxDyUjAWh2Tm1Gb+2JVnngy1Bv7/IwTHaRzOIL+2eFVb1pHv
         kGKNPRbHf8RsGNfY4kb+INcBmGhdbT5g3HaXqpRhrCAV1L1/Q1HPvhDbAItUzlXStl+7
         omia9gyn7ApF2Z0L3AMM4of7MMvzdwouCMXvkBcoUpW/+XcYUOQkL98BTxd2D9cu3jdD
         nogTKxp93iSS1yX+rxzB21F56F75f6V/cyRPwBdwDHBYtPszQ2tcWxSBLfmjEY2zljZX
         QDvg==
X-Gm-Message-State: AOJu0Yz1jgfQw/xcU7CyRkPUEIVLh8YXWcfVRGaiIjceQQ7fPgBJyJmQ
	GLmKRRNCK9OayLjDkB1RrD0WfCpHE6Xfh+VMHYzTjgATIJkvx9gR93zgaUC7+qq9dimtFHe5Kn+
	YPgVQmw==
X-Gm-Gg: AZuq6aJohNiYJRrUtiEH2sSYCXGLq506WkCe4w8ZhSaGdivGnmiD2WsuRCXxxXZT3Lh
	RLbzbydWIfTF9cqkWubAyrSADktXi4oTRO/hJwl5MezEUgD/MBVshMkanbCTCIJFAcg1Nz8sDgN
	i9gbYYqsHWrbbjjuj+yx40d4kZvWpS70AJSv4hGcmxEqWLh7nQ8REq6+RTIhEWvUKUQBhedAl5V
	XTfdt/c3nchCFLfRuDQ6vFET9zw+lp6ptS29HBKtSp4B2tUQdNg5W6qTvSmRQapMv9LVH60Eopa
	z1pvQvkHES6XwOdGaGj97F46IKQV2xZrDk9ZVfOqlUNJtnW5h2esn8fpbfa4bEQMAjI5ZwcfbAK
	fFuo4DVO9N0bELOXG6n7fQbyUwGxlix8bPvtyuwQ/CenZc9WQ4h7aZfQ25wpGd5iB6K2uwXvDKx
	ELGAKKTjgJ0G8mRB5A0NC9tjAPa0R2vj2tjkASisnKJt2nw/1/45zwGXgQ
X-Received: by 2002:a05:620a:1a8c:b0:8b2:dcde:b670 with SMTP id af79cd13be357-8c9eb329006mr1561201685a.70.1770053823814;
        Mon, 02 Feb 2026 09:37:03 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d3740e62sm118773246d6.26.2026.02.02.09.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 09:37:03 -0800 (PST)
Date: Mon, 02 Feb 2026 12:37:02 -0500
Message-ID: <1840fe300392f962e0bd444941c24969@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20260202
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Hi Linus,

A small LSM patch to address a regression found in the v6.19-rcX releases
where the /proc/sys/vm/mmap_min_addr tunable disappeared when
CONFIG_SECURITY was not selected.  Long term we plan to work with the MM
folks to get the core parts of this moved over to the MM subsystem, but
in the meantime we need to fix this regression prior to the v6.19
release.

Paul

--
The following changes since commit 63804fed149a6750ffd28610c5c1c98cce6bd377:

  Linux 6.19-rc7 (2026-01-25 14:11:24 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20260202

for you to fetch changes up to bdde21d3e77da55121885fd2ef42bc6a15ac2f0c:

  lsm: preserve /proc/sys/vm/mmap_min_addr when !CONFIG_SECURITY
    (2026-01-29 13:56:53 -0500)

----------------------------------------------------------------
lsm/stable-6.19 PR 20260202
----------------------------------------------------------------

Paul Moore (1):
      lsm: preserve /proc/sys/vm/mmap_min_addr when !CONFIG_SECURITY

 security/lsm.h      |    9 ---------
 security/lsm_init.c |    7 +------
 security/min_addr.c |    5 ++---
 3 files changed, 3 insertions(+), 18 deletions(-)

--
paul-moore.com
