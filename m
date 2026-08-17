Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E433E1CE5
	for <linux-security-module@vger.kernel.org>; Mon, 17 Aug 2026 23:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787008605; cv=none; b=UB88OUNxFewhNot4l2x3ROlHMlKSdtU7wefP7TdCgVHoEIeD/kZqpDAfThvaLEq+dJD8lllmOEM3WM8Dbg711XcoMDKcogEbhMiKD8ipu2NrYKzFvpprJiR0+tWvn5jEVpLIKxfxpeIVIKGqcBQn5HgtaXitdKkD/SP9QRnTrUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787008605; c=relaxed/simple;
	bh=J5fKyFXqD3lMTkketcC+clmJE2jwORurbJHj/5xkaxQ=;
	h=Date:Message-ID:From:To:Cc:Subject; b=AH3jpemZxek8SSdpKo/4vzYr1Wb0B9fFmI4ejjoHyCnz6VRkk6ltSwQPyZPdrUMsehIelreQ7qtv6vmnQ7JGmwHf2KeHmBuoS87dIfRTO5OqnhrAuDFedOmVxD8EvTWpqMDEumLMxiXUjDdTEPjjb5gxpMnz1PmkDsOKHvMly6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=D5w4jOYw; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="D5w4jOYw"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-936c02e58dfso255654285a.3
        for <linux-security-module@vger.kernel.org>; Mon, 17 Aug 2026 16:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787008602; x=1787613402; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M/nOlUNxPfi564pUlmRuvXg6V5o+MLGmFAiAfMNJZ1g=;
        b=D5w4jOYwaDejLzh6XzYixAMasTVPtvKNAOqP/5ealC/6hFB7J/JGc5RzGNHHsAtGks
         4ryd/C/kCgtqilDAnmhOTEEK0lLXG4ct4kIpdih9Eu04qHpQD62KxSxOn//DOX2i8Aup
         NA1rmoOzTwIP68fH7dZNmjMpm5JeQ+HPYI7/9fES1qfGRSbuMHvMmQ03GGzIlw6Dk5Tu
         hWf7CBJ1i3W6cDfYpi6SIRd/LgP/oL3lyn5chXKMI9XgJ1/O1ZWcQxvjINKo4m6Lio0F
         Jmpdxb09jAgKtWnFGT3gsCMEIPTlEbhr48n7AMZ1iOydc0meHbFdATvBKw7teSzYsjsw
         o8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787008602; x=1787613402;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M/nOlUNxPfi564pUlmRuvXg6V5o+MLGmFAiAfMNJZ1g=;
        b=lQMIAVC9qc7YNKdCGuZA5+uv6X+/ivvU+B/f5vid22IHGRvg6hN43aTTpaZALzC9Lw
         IijTtLCSKf0AqzqpX8XeIS9ZWw7dk1X2QkujAVrc3uIAIZ2T74+b8BX6Kd9GX7IncIS3
         Q4LJPk5xucihYK2EYMWYpoodrYjeJi+NbuZWlQ+95Bbo+n3b0NEIzhhBdyOYQaVHGaUM
         d1B3gImXKdY1IQQ6H3zDYo4+Aig3uvF5Z5xrSs4sxjex8sh9TxLp4B6ir6/+YS6l5K1I
         2PVAN/6GuWIrkBqiHg5XnYKEL2RLrRQHaFz0kIij0FKkV4hyosXli4hxbpmouyGfHikh
         P0NA==
X-Gm-Message-State: AOJu0Yxq3Apo4G7LMvfLv6cnDh4RXq2KpSR5KOTQYpc5TR2GBk0SHlE5
	TEpku1gIHI1lbxWQpWQmNhIItKaZBov/bMo6AEI042P26hLjAuBA5X+74Qga3zzlzg==
X-Gm-Gg: AR+sD11+G3ciCiXyzR8lKt+sOd/NLaLKuOclJ0uLfi6OQGzN6t3fUSSuOKF5h756g4c
	8Yl/u28ccqnP8zuoxNrq6vLrlRYPXNJqS2CBa1kZBWetV41u5hkZMBGZmA9KslNAqdXMqPbzxR1
	JUVKzRoGKuBYDGsQyNewrLqijGbUVPz/xTD/rgxErOwdQIRcDB6l/4TED8K7Q7ogZ4eraWbjqnh
	eVDH+vARYLGgDexbzRilVUBQbapoL9PNVWAimI3ezNuNPZS8RWWoFEPHNXBa/zSm8K3QRbM5YDS
	v27KHO0ShpKcnLG9H1TLWvzatG1QauMSBA+uW8nH/hkpGQpJF2AoBWSmL29rdCENrcE61gaDVPz
	35n8OwR1y5nLRAdZXI6dhw10AL8gmZYCn9yqixXP2n26CTcohjbKqNsrs4UJX3KYfHaOiONYbLO
	QhG0lfeDIln5f8X5e0eQsfOVZjgBGDMZzLWGhC2gPLbylKDDsX+ILV2jsq6JcvpKGUEpIghuuyX
	j8Fh6CZdYmGzWv19pupvklNviNG/tpShEnGi7IQrBq0
X-Received: by 2002:a05:620a:2710:b0:92e:5fe2:fd35 with SMTP id af79cd13be357-936d2373319mr3124323885a.32.1787008601662;
        Mon, 17 Aug 2026 16:16:41 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937010d62besm197271785a.14.2026.08.17.16.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 16:16:41 -0700 (PDT)
Date: Mon, 17 Aug 2026 19:16:40 -0400
Message-ID: <4f24201cc573e07319bbc8b3e96e6abf@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20260814
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

Four LSM framework patches for the Linux v7.3 merge window, the highlights
are below:

- Remove task_euid()

The task_euid(), and Rust counterpart, was never widely used, for good
reason, and now that the only user is gone we're removing it to rid
ourselves of both dead and funky code.

- Documentation improvements

Correct some of the kdoc comments for security_task_prctl() and clarify
the rust comments on task UID accessors.

- Fix a memory leak in the LSM syscall selftests

Paul

--
The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20260814

for you to fetch changes up to 0cee720cfd51402cfcb14d96cb326a36c13b823a:

  selftests/lsm: Fix memory leak in attr_lsm_count
    (2026-07-07 15:14:00 -0400)

----------------------------------------------------------------
lsm/stable-7.3 PR 20260814
----------------------------------------------------------------

Alice Ryhl (1):
      cred: delete task_euid()

Bill Roberts (1):
      lsm: clarify security_task_prctl() hook documentation

Jann Horn (1):
      rust: task: clarify comments on task UID accessors

Wang Yan (1):
      selftests/lsm: Fix memory leak in attr_lsm_count

 Documentation/security/credentials.rst                    |    6 +----
 Documentation/translations/zh_CN/security/credentials.rst |    4 ---
 include/linux/cred.h                                      |    1 
 rust/helpers/task.c                                       |    5 ----
 rust/kernel/task.rs                                       |   11 +---------
 security/security.c                                       |    5 +---
 tools/testing/selftests/lsm/common.c                      |    4 ++-
 7 files changed, 10 insertions(+), 26 deletions(-)

--
paul-moore.com
