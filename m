Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468EF370D63
	for <linux-security-module@vger.kernel.org>; Tue, 19 May 2026 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779221130; cv=none; b=UqrjtHdvGqhV+XYPa7RfXwSxU9wOSqVAwUnveuNyodbd/6o5vwdYfT1qpH9Sm0/lcY4yUZ0SYiiwIEWBDT9k9KrWY3Gtivodhi6oF+pJ4K2DxefOwNvXolc13ZKGrNeQW7AX5HtLb1jaZI76Yezo+sYzBj5/q6sJonrz8VxcSgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779221130; c=relaxed/simple;
	bh=vejacKD8n3yJC5F7KD79+O9oqxXMt1kBlfepb6E8V4w=;
	h=Date:Message-ID:From:To:Cc:Subject; b=YIKKCH3i6fW+Izasw3DrSrV3EEmFfCxTnjcGTvFGPTjJx/7ect/HgIFlhsrYyELX3upr8hJSr1433RwHT+g/BTXdDGl470KX0oAfCoXgv1z/8uQNp0lzeHSdK/tbXZefc+j/05t97rKRMfzD5S8JN7y6BPzap0vAfZsRwIiy4Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=T/zmF5Nv; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="T/zmF5Nv"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9103019f8c4so488471485a.3
        for <linux-security-module@vger.kernel.org>; Tue, 19 May 2026 13:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779221128; x=1779825928; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDLZrMu8IYT82OrMnnhPTtLniovaZ5dVEcDwN9cdtDY=;
        b=T/zmF5Nvms7PXJFsN34Qw9ONg3yLsnZ2OK/8VL+G+qRkwzXwsyUBPbF+LqTHN/BmCC
         5z+5/IgFnd1c9rsZj7USr8rq19V0/xPnrcLlPrLBD76FSD73sZUT4DufTRCPfEO0ETC7
         GR+kGHONliSf5lPwlLplvl1ox/CWLx20KpM0+dwc50DJ8mMC8+ZXe98XE3g5XJlSTJkX
         azLaKd5XMshusZrXqohVA58Ph6Kt97zZ96Ev6Tw3IhoPGTbFRoy/ERsvqrBInsOeovXe
         XDWc7hWMVELr7+7dWb5I632Iki64nw58AGLZpRnZBlpugWPZ4Q+uyge1vGbinDAhp0/V
         xC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779221128; x=1779825928;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hDLZrMu8IYT82OrMnnhPTtLniovaZ5dVEcDwN9cdtDY=;
        b=kBZonDIOLiJGsRVnWpN99mUC++LXdsatg9NV340/49aeB4Y25uDxdhIeWdr19BoIzT
         gxqw3M17SrAi5El+AqfTgdjjvDUo+5npWFOjXL9eDbs/ZgP3rN4s6j8lTTqDPwU9TfCQ
         jZhMSgNuN4m6D1/dVxzQFkh+wLgzEzGyjM/8AnKj4gyY3S8fix6SJ/ZncNqF1aZjABa5
         lTzSz4oS2gtVWJO4Lt33Os3aOHgqwRQvYTUHQsvzsT+hSQHGAbY53X6R9NLSF4dbF4jL
         hO1Waxr3WQLNBoW0UY7MFJv/Gfxh7D4N2SxWI9el8x9QzNF9bJJIm+jjTV5QwavjDd/P
         ++UA==
X-Gm-Message-State: AOJu0YzP9J14+5e5ZFpmkjDrL6mORT8ebQHJkkz4BNA+VakNSHw//AjX
	/J1iac3/Vd5PE/jmWBsQeRIlaMp1RvPRKaOZWpkNALSMjK8+vPXYVXqJ5RA2fjIQjg==
X-Gm-Gg: Acq92OFgEvcctJzvcKwS6JrLg5+Y/EzOV1nAV7p6oGftZBF2BZkGlaIZlYf4yAI4vPI
	ykcFRCPah0qeRmvISMBWGoyVaJGTQxBru6zuGZS1cUfrH2ciC7+FZnNj102V/uRmL7NRi+6GrN0
	CjGyyu8lcLLGXzJInYksMxi8QuDq95Cj9g/FXp0YbQPMJ1kJe7URwW6R6bgFF17Cb9gHTvw6HEV
	G6aGDsgRgaTtSYX9LM8de5DBdfE+JilJlfh4Eg8OVnkZyk6voDvlwe76cyBA8FXSYI1Llw+Ti+r
	Kt+nLG+iG9pIeJQrkosWtQD9w66FPMQNOxdEnmnh5LZEdQLX1tBot6leySS6SpdZ6e8UFqkWSFq
	MnYsMu0uX23NH0+Vt/+yQX2A4hheoZUkjb0rDIlrYsUR0QFggHMykerZAmTSoXA6ZZ536sGGpop
	dDEQihcYqF4sj3qWkWBcN2ZP2r0JGiSAti3cs28pjywKLJ/9gesXG/BL2CloOmw6kk6at8
X-Received: by 2002:a05:620a:4403:b0:8cf:d717:c22e with SMTP id af79cd13be357-911cea097bdmr3031990885a.28.1779221128028;
        Tue, 19 May 2026 13:05:28 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83b85asm1935904485a.25.2026.05.19.13.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 13:05:26 -0700 (PDT)
Date: Tue, 19 May 2026 16:05:25 -0400
Message-ID: <96f3b6072567c23ebabe1804a0622af5@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20260519
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

A single LSM patch to add a missing credential mutex lock to the
lsm_set_self_attr(2) syscall so it behaves similar to the associated
procfs API and avoids issues with ptrace.

Paul

--
The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20260519

for you to fetch changes up to 4a9b16541ad3faf8bccb398532bf3f8b6bbf1188:

  lsm: hold cred_guard_mutex for lsm_set_self_attr()
    (2026-05-14 16:47:59 -0400)

----------------------------------------------------------------
lsm-pr-20260519
----------------------------------------------------------------

Stephen Smalley (1):
      lsm: hold cred_guard_mutex for lsm_set_self_attr()

 security/lsm_syscalls.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--
paul-moore.com
