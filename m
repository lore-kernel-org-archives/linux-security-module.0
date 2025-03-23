Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E58F507
	for <linux-security-module@vger.kernel.org>; Sun, 23 Mar 2025 19:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742758787; cv=none; b=JRt1hkOX/dXCPXtzDaFkYCWld++7Kx/NTgh7cOm8aJamjlU6lu2RvynnsLGYrd1WL2uE6vKOPjGG9onuoirplE3V1dH2y0fs5Rhy+hFIXrxL7epskcPIEbWSTMACRNU4TRjMOPXgC7BN+scvgHHHRoTXyezabCyaZvS16ogE0cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742758787; c=relaxed/simple;
	bh=C5M9FZxGke4NbdCrsCnEAwe8igTxj8Rkhg3YFuac+xY=;
	h=Date:Message-ID:From:To:Cc:Subject; b=pnxSdKEnYFQc9MH1EZuWL49w19AsGPY8HI2HlooJqdVMD64GPpIwuqwykORnS/nLTkNPJGq+fY4SAkLhE3jP/W8ATvdWfxy/gKyiNpk77XRVIw3RM622XNum8zapZO8NE9KSGinJ4W2AkWvmRzNBesPNUTCwCrzuqF99B4SQ8Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QR84Nsil; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QR84Nsil"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-477282401b3so19482851cf.1
        for <linux-security-module@vger.kernel.org>; Sun, 23 Mar 2025 12:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742758783; x=1743363583; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/9M2NmeSWUFErM1HWVWZj3fEsB3g8mWCeObHDD8N58=;
        b=QR84NsilarWnf2npCDsjB8L774soPwubXBJOsMHjVOStPDs24nsKXzkayc8xhgTKTd
         owE4HK57GdOjX+pUR0bkWHcypiT3Vbtc+Lbtna9kj6QYuWaf3qWbNO1ZvzFOMfoZZ3Uc
         fQpRcCgMakJBtMB44UC/C0zbvrNyKRJcsO3+oRWOG3+BeioMcJVhMWWMAU25CtVRY2af
         DUHutTGKPSucvaaaUrxoa0+EAorrxAXSoQXRE8H/GvckkWqP6Fyr/MUBEfF+sjig648W
         GOr2zSE6fM1JvjyVmvxGK1Gp71n712WXfxpuRlCEFXak5RvTBDgMVCZLwW8IW2zy+4sM
         eGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742758783; x=1743363583;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/9M2NmeSWUFErM1HWVWZj3fEsB3g8mWCeObHDD8N58=;
        b=eSGCAw3ZnSGQiE+1GDwt1bxKxE92KXwyI9dJeBclb3355IwCZrTZoMhjISTtj2n3AR
         B1mLR/3Awy4pQ0XwVDutFiOzs+1OCWDKYgmeDufL54jR99PMAAZ4IylTOZ/srVwe/PyK
         +rJqvQHYypKN1yuOP69UNkSNxPzjT0TV7+NNGioQA1sBTMt4C76RvS7OwBJUE5FCd3Ib
         QOAFz+mAdWszvL8PVn0tDaPeRzXuGzQEOtiCb7HTd0HNb69tb4lgXLkgDALS5A/dq480
         4YJBiveya7VlVCqaH253djsltADuJoVQc4qGKf0frPTAwuL17pPUev5E5h9hfUEQ5m7v
         F03Q==
X-Gm-Message-State: AOJu0YxjsszFu+QhKvfP2iZKtspSK5xyJLS/womfaoBUixzDIQUp3wyq
	c8znsSFFFi+cE8LwUTN58N01gkU1bGJ3IiERVRjObUBQX2xurhwMWkKMy27bdg==
X-Gm-Gg: ASbGncuiMSgAskXp5rVkrwVVeseXRZnlYfRwTXKBjB+k/Yr1uBclt/3PFuU4tTE3N3n
	U5AkkgmCGvXfn29Joa1Cv9+lud4ijJo/qqeeD/4axfy9/gGldb0w/5UJzo6+iaIxB0VLLj7F0rQ
	FhiIDEPvUbuq7rgLJiiOX9FsrVTuFSCZYh6EF4WJEtQ/bECcTtvcvSgfdbJqvXEj9DrZKzBv4hT
	LKMBW21qZc0hK0bU+lDztgvoxE9OhamN6Hmvpas+ywUTbgb61SGlFGjERa2cJvTgHn0hfS+PEIr
	bzMiICC9boOyxTpDg5Og9j7D+QdUl69rjrb014T4nJZ/r6YFU+D9rhAaBWNorgLTX+XwbzGJSF3
	uJOBQGk5xvDLL+Q==
X-Google-Smtp-Source: AGHT+IHahVX7B5lRciT5ZQupqUnDxS9OGp3103z9xfJu3fR8xW0gMUGFEgUXjuKJoEJI/iSxu93o+A==
X-Received: by 2002:a05:6214:2a4f:b0:6e4:7307:51c6 with SMTP id 6a1803df08f44-6eb3f35b4fcmr155940236d6.34.1742758783513;
        Sun, 23 Mar 2025 12:39:43 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eb3ef1f5d8sm34480356d6.45.2025.03.23.12.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 12:39:42 -0700 (PDT)
Date: Sun, 23 Mar 2025 15:39:42 -0400
Message-ID: <795b758412f3cb7dc64777a6fde9c16c@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20250323
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

Here is the LSM framework pull request for the Linux v6.15 merge window,
the highlights are below:

- Various minor updates to the LSM Rust bindings

  Changes include marking trivial Rust bindings as inlines and comment
  tweaks to better reflect the LSM hooks.

- Add LSM/SELinux access controls to io_uring_allowed()

  Similar to the io_uring_disabled sysctl, add a LSM hook to
  io_uring_allowed() to enable LSMs a simple way to enforce security
  policy on the use of io_uring.  This pull request includes SELinux
  support for this new control using the io_uring/allowed permission.

- Remove an unused parameter from the security_perf_event_open() hook

  The perf_event_attr struct parameter was not used by any currently
  supported LSMs, remove it from the hook.

- Add an explicit MAINTAINERS entry for the credentials code

  We've seen problems in the past where patches to the credentials
  code sent by non-maintainers would often languish on the lists for
  multiple months as there was no one explicitly tasked with the
  responsibility of reviewing and/or merging credentials related code.

  Considering that most of the code under security/ has a vested
  interest in ensuring that the credentials code is well maintained,
  I'm volunteering to look after the credentials code and Serge Hallyn
  has also volunteered to step up as an official reviewer.  I posted
  the MAINTAINERS update as a RFC to LKML in hopes that someone else
  would jump up with an "I'll do it!", but beyond Serge it was all
  crickets.

- Update Stephen Smalley's old email address to prevent confusion

  This includes a corresponding update to the mailmap file.

Please merge,
-Paul

--
The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20250323

for you to fetch changes up to 65b796acea1e5efc13eb29fdb4638fd26deabc17:

  mailmap: map Stephen Smalley's old email addresses
    (2025-03-10 16:06:24 -0400)

----------------------------------------------------------------
lsm/stable-6.15 PR 20250323
----------------------------------------------------------------

Alice Ryhl (3):
      lsm,rust: mark SecurityCtx methods inline
      lsm,rust: reword "destroy" -> "release" in SecurityCtx
      cred,rust: mark Credential methods inline

Hamza Mahfooz (2):
      io_uring: refactor io_uring_allowed()
      io_uring,lsm,selinux: add LSM hooks for io_uring_setup()

Luo Gengkun (1):
      perf: Remove unnecessary parameter of security check

Paul Moore (2):
      lsm: fix a missing security_uring_allowed() prototype
      MAINTAINERS: add an explicit credentials entry

Stephen Smalley (2):
      lsm: remove old email address for Stephen Smalley
      mailmap: map Stephen Smalley's old email addresses

sergeh@kernel.org (1):
      MAINTAINERS: add Serge Hallyn as a credentials reviewer

 .mailmap                            |    2 ++
 MAINTAINERS                         |   10 ++++++++++
 arch/x86/events/intel/bts.c         |    2 +-
 arch/x86/events/intel/core.c        |    2 +-
 arch/x86/events/intel/p4.c          |    2 +-
 drivers/perf/arm_spe_pmu.c          |    4 ++--
 include/linux/lsm_audit.h           |    2 +-
 include/linux/lsm_hook_defs.h       |    3 ++-
 include/linux/perf_event.h          |   10 +++++-----
 include/linux/security.h            |   10 +++++++---
 io_uring/io_uring.c                 |   21 ++++++++++++++-------
 kernel/events/core.c                |   14 +++++++-------
 kernel/trace/trace_event_perf.c     |    4 ++--
 rust/kernel/cred.rs                 |    5 +++++
 rust/kernel/security.rs             |   12 ++++++++----
 security/lsm_audit.c                |    2 +-
 security/security.c                 |   17 ++++++++++++++---
 security/selinux/hooks.c            |   16 +++++++++++++++-
 security/selinux/include/classmap.h |    2 +-
 19 files changed, 99 insertions(+), 41 deletions(-)

--
paul-moore.com
