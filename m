Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425BC3E2740
	for <linux-security-module@vger.kernel.org>; Mon, 17 Aug 2026 23:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787008599; cv=none; b=JSPfMv+25Sqa6UZUipi1XeHYQeVKihjJthj+vGGKx7M2vDTE8QzIVKWgmfyyIhY0g44An01Q4j7qH2+A44gA9CJARcOJaX8HnjN6M1fI0plPxtQjLiUxbviJAsjqD9T42CSdR1ahlTP4LxUz18SErgnprsTkTk4Fxi3noEtm6a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787008599; c=relaxed/simple;
	bh=o/2gKu8MtdvjoyhaeLVJAaxv+a83YB2/7qPJ3QHcTTc=;
	h=Date:Message-ID:From:To:Cc:Subject; b=peo6w0dkNx5vc2cNH4Wr8Fva7+AiQV9c2GFGWsLp9yYWwLkSOu4pTK7TXzBt7g7y8ishGk9gigP4Wk3R/t2SuCvqkeXF5qHj48KUAtCsNKolHl22hNqcrkr7pyH+Kqy/hsLpfKD+hPqFW83fHtdH7QFvGzPjvxb9ZFSY7YkE4fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TCX7UM4o; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TCX7UM4o"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e57a753f9so330092985a.2
        for <linux-security-module@vger.kernel.org>; Mon, 17 Aug 2026 16:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787008596; x=1787613396; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vPaFvQ8Y9PTk8dyhUZHFKOh7qLt62XRYEihfD8ZYjc8=;
        b=TCX7UM4o+FKhS1kJ3j74DzVv1X5J8KCSp9XcDWVIE58H6Lt10vZ7FbRzROR5R7mt/Q
         g+ArtuAgJ6pklckHKNxlVrpUXo8hYwtve8CzKIIoyUkA6tKfA+PO+2hEuTSe0+sTNSTA
         WDRYqxp58m9bP1Pfz2LktwvLScqWYzz3E1ol7wCJO+7ZShsPGXgst5d6cQk5oDfPFall
         IK6HyJZTwxMlglF+rSe1oLuKiVWGs9azjqU78K5uW9HKasDgbjwa9GnEl5ZUEw6nxy28
         57zAA9j972TnhATnfgSJ7S+Ez8iHgUyssiXEbwg/XeP/VjMgBO7Lb6jiRcZtoPsfmRD/
         7qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787008596; x=1787613396;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vPaFvQ8Y9PTk8dyhUZHFKOh7qLt62XRYEihfD8ZYjc8=;
        b=LNuuMeYLZ9N4U0iJunV1yGKCQHXwk1W7pOtdR9qFyGWEOA2lyIaUT/yPEUKsI7hEWn
         hmVsRjPxfG9PPxjQNTPhtqjKQMAqkQGeIYPgWIYCUUYl/8ZFWgnWW4kwsQvFq4n9KyGR
         gtxwZHzsRCVSUExuzIllJyqLeE4tqLMAgfQBPUcxtv5Dt7x7n3YklW1CDOU0QXkRNDN8
         +noWn7NRGW70E5QhrEVz8z2gl3hyjoCmOXjGhUqR05Q83yyxkgDNGZjrh2rpmKDvgaNx
         zDY8KtfA3k/dJ5jNLZ8zKt7S1rEEg22vPArJJRNH1kF8paAcx87HeHewgRFBzR4v08ZE
         SYmA==
X-Forwarded-Encrypted: i=1; AHgh+Roau/frTGvJeMXy37ponC6Ue1SkEA81NFR+lG3L9YKDuTKPSn7oDZRHtDyBavOmOqWM/WsX1uH17M2FnGA7cWjasteeWag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBdG/oB/g/2yfkVYZZfjNoxQjoYekTW9lQmGQbkjBYdgj/1yFc
	fcvNp6TNASa41U62B9oDjVzpWa9CEiEWIIgVjSvplT5UFJKNPbCTuQmoCoMJ/o33hAgkEGRVkHJ
	b76Vydg==
X-Gm-Gg: AR+sD103CSwpq68rfyoqdalcbbCKDc5XlnaiQGDI0G3JmBppKVLWfgbxol2LM80L0DB
	h66FYatSISGheQj9lP5laDNmFfe27OpbC6rgtWmqSv5CtY4c4P4XMcZ+pMWEG69kyaaYjZrZMw1
	9UcYt/BpPtwKPUrW7zvd0/riccl1UarsB6A4YsvAbSv42+v+fbj0pwSAcDVmBy9yhvHA9JZpmgl
	AIcTFc36gxHeEyUxC1jzwDC6qVL8TN8axGOk4CaOI4/TLkWIIQbhJ+zKUQPG4JyXu+p46oyCzVX
	QqMFrBRHiAnsUHlTUVRtOZsasernr6l23T4JNIwLXRtRrZJIV3TpjHyNHhQU7Fama/AQSEYNNIm
	Jt44jBqtd/q1xjs/wJvd2xMCQNOK+LXmghEiTAl2W3PvCi1P/FHgcEcQxPZ4cD+jTWb15L97fLX
	zAHGTO8/U8miCwp0mtiP5G5Mvevo/vGC+IC4T3TvtRW98Mg5K/exT9PdTGDx9KbJN206p6Eu+t9
	EjE2FEnX2qoV/DKnwJQiiAxbF1gckLIJMM=
X-Received: by 2002:a05:620a:2b85:b0:936:e80c:e0ba with SMTP id af79cd13be357-936e80ce8dcmr2119680285a.0.1787008596135;
        Mon, 17 Aug 2026 16:16:36 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937010e7fc0sm200396885a.20.2026.08.17.16.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 16:16:35 -0700 (PDT)
Date: Mon, 17 Aug 2026 19:16:34 -0400
Message-ID: <e3c1c27333646164f71bce44e20cfc49@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20260814
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

Nine SELinux patches for the Linux v7.3 merge window, the highlights are
below:

- Convert a __get_free_page() call into a kmalloc() call

We had some very old code that called out to __get_free_page() for
allocating a pathname.  There is no reason this couldn't be done with
a call to kmalloc() so we've done the conversion and now there is one
less __get_free_page() caller in the kernel.

- Limit the number of retired/unknown DCCP netlink messages

While DCCP is gone from the kernel, there are still userspace tools which
try to talk to the kernel about DCCP sockets which were generating SELinux
related log noise (unrecognized netlink message).  This pull request both
limits the log messages to just the first instance and also explains to
the user that DCCP support has been removed.

- Convert the SELinux strlcat() calls to seq_buf_XXX() calls

As part of the effort to drop the strlcat() API from the kernel, the
SELinux/IMA code was converted over to using seq_buf_XXX() calls.

- Only calculate the SELinux IMA configuration string length once

Previously each call to generate a SELinux configuration string for IMA
would have to calculate the length of the string.  While the contents of
the string will likely change over the lifetime of the system, the length
of the string will not.  Calculate the string length once at boot and
reuse the length value throughout the lifetime of the system.

- Further validation of the SELinux policy at policy load time

Perform additional sanity checks on the policy constraints and types.

- Proper cleanup and error handling for selinuxfs init failures

We were not properly cleaning up some state in the case where selinuxfs
fails to initialize properly.  It's somewhat of an academic exercise as
a failure to initialize selinuxfs will cause the system to fail on boot,
but it's arguably better to make sure we do things the proper way.

- Various code cleanups

Convert integer flags to boolean types and drop an uncessary goto from
the SELinux code.

Paul

--
The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20260814

for you to fetch changes up to fd6e2388a3ea55e58cbbbef840c1d8aa2067dbb3:

  selinux: validate constraint expression attr and op at load time
    (2026-07-27 17:17:33 -0400)

----------------------------------------------------------------
selinux/stable-7.3 PR 20260814
----------------------------------------------------------------

Haoxiang Li (1):
      selinux: clean up selinuxfs resources on init failure

Ian Bridges (2):
      selinux: replace strlcat() with seq_buf in
         selinux_ima_collect_state()
      selinux: compute the IMA configuration settings string length once
         at boot

Kalevi Kolttonen (2):
      selinux: convert int flags to bool flags in ss/services.c
      selinux: drop unnecessary goto and label from avc_alloc_node()

Mike Rapoport (Microsoft) (1):
      selinux: hooks: use kmalloc() to allocate path buffer

Stephen Smalley (2):
      selinux: tighten type validation during policy load
      selinux: validate constraint expression attr and op at load time

Yafang Shao (1):
      selinux: suppress warning flood for retired DCCP netlink messages

 security/selinux/avc.c         |    3 -
 security/selinux/hooks.c       |   27 +++++++++----
 security/selinux/ima.c         |   65 ++++++++++++++++-----------------
 security/selinux/include/ima.h |    4 ++
 security/selinux/selinuxfs.c   |   19 ++++++---
 security/selinux/ss/policydb.c |   46 +++++++++++++++++++++--
 security/selinux/ss/services.c |   18 ++++-----
 7 files changed, 121 insertions(+), 61 deletions(-)

--
paul-moore.com
