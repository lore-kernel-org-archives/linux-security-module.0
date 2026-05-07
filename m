Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4F92F1FC9
	for <linux-security-module@vger.kernel.org>; Thu,  7 May 2026 22:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192222; cv=none; b=BkmX6V6kcKplWaXrbLFiZXYfSZ2PB4UVM1fLpu0LOacGC+MKEUDSI8W7xjWOBRufWUnIsgulnmim0zayN13IkmZxsPTCXZ1SYNryrTKGIKWPBDvx03yDpLUkzI3owDvVgESv4syMYhUjHko5AUbW0f+CGZrgQCI9y5iTUKhAmgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192222; c=relaxed/simple;
	bh=s3GYLtaL3wW2ahUfHQCq1R811uHQ9zma4Rmk5a3gMGs=;
	h=Date:Message-ID:From:To:Cc:Subject; b=JdNFyVZoeiD762/D1Of3QCEjaVEJDqenrpS1OOI6VE7vodluU63UaF7HsInXfDQEP2SgY3mc4EufpXJ4jKbTCDKSYQF00Qgwe7LsLriJ55NbtuxwRJxBBcd/sHJcVhmmBo9YIciYJJdcW3f24vlPtG4Pgy5Jtw1ngErZH7snTqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SN4SRn1d; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SN4SRn1d"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8ef45a6d9dfso150296085a.0
        for <linux-security-module@vger.kernel.org>; Thu, 07 May 2026 15:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778192219; x=1778797019; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Xnap0l24OBizsFJZW5Mlqj6akTtgTGGifGrOCJjVmg=;
        b=SN4SRn1dteHHHxBwAB31UeVoGwpDX+IflPxzs7zo2OQ3QOjLQ7pjU9LJdmxOsD8Ft8
         qybkHYtXpUqBbBxC7S69p8Pw9cwhHgWTS6XbZkjYNVp2BIX/6yCOSi96QW6uNm08iPEP
         CucfRe+a6eK9D3sfMoG7E/TwQWd+ecty37c43CinwDKC4m+yRLO6LnHEbtT4uZ86aR7b
         kKzff896iLzuXIbwdrgfJjZToGcstTWNrGd729iQEcJEqANGRwrrpRYD9lanOasCBHp2
         jGBMZXZHfd1ogN4ODwOHJiEYn+Y7cCLFItSkPamK1KT7DbtsnnU9cQjNoR5v4Y52F0ja
         r9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778192219; x=1778797019;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Xnap0l24OBizsFJZW5Mlqj6akTtgTGGifGrOCJjVmg=;
        b=XPBIlJe01E0gDd2NhDdl/0GRejsSe4p3XlQ1GYuIDV/6hLC6tLFjKuNWHJ9U38NMkY
         vUFMlP8veQ7ivdFBeVTg26hCf+7q/uN0rarz7P4q1X2ABpss2/UlZqd1plklRtYZ/lcm
         sKlV1D7ymYiR1vGLaPueHUEUNnuUcrurVwwJXn3++ztrFozQpwCdGwG3OekA3QDXIW9R
         NX9/Fry0MGTee8OCwzxRj5K2H0cSwKQTvXwrkv/QXj9Si1nuPcMHl49mboiklVGsxH51
         8F/ik7xMN/rGHd3mP9KggI6gE6JIRsAyf+rP/OvpZs1M1MSXPKvlknior8lHn0wWg/nR
         TSkA==
X-Forwarded-Encrypted: i=1; AFNElJ/OKXZh+bZSAGui9VI+9ePeuwLADky/yWOY2/nj0XgrhhhtVwPa3hWa/3jmRSh+3M67AOw4kt/3k4tcY6pBfRoRjn4DBiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygLVCsXUiUz/ZYcfT/Kg7KPzJ0fNca14oUYmsWXiBbcSd/hnBa
	Sm7clb/zbViKSSh9gmwYf9fKbqRPcgLEg/f6Z0gTkt70/JfM+RwiQj9eyhDRcfF5hg==
X-Gm-Gg: AeBDieuB7ulhep/NtRu1KKPV2mkte96iDE9n1o4/mkJDVvLJwIJ4Uvc/XTR85Hyr8OM
	KK4O9n2xmZHc+ydoJuj9gmPvQ/z5ipkzd0s7ip0LEau4sJhU49JgCCWRyEXVyE2wAT9/yV1u6RZ
	z0txLPonnWANpJP/jrjS2hc5avBL89V5AY4qTcV/a/XzsQ+j5spMD7OGaPrKbnsD7WVjLK53NCX
	R+hfU4wVDShevQitzzia5gwCNPbbsdVR5qCRYKERgOTWhHY/yYqrpcMeZkCGFkUUhiWuRWxIDTI
	pAqRXVMVqwQw7hKd7JUzc53e9wcqQnTGONhDHt5pfaPGmRHQGwIlENtyYwRtHvd2YwnLtZQKUjt
	8sYs9JUkXvVdlmZaV3PVDtXyCBQyxQBySoCviGWnnN7AVztWLsoC+nWnjyeNSu6ZJxMq274mvaE
	1/+fn0hZh3zgdGPzthO6H+ZGpYYRnVFY7HAwqlAwH9PzWmmef+LCjFImwd5/vrsgco+wnM
X-Received: by 2002:a05:620a:4152:b0:8f6:4b59:9662 with SMTP id af79cd13be357-904d69da35emr1433067485a.45.1778192219098;
        Thu, 07 May 2026 15:16:59 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b87c037esm10546985a.30.2026.05.07.15.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 15:16:58 -0700 (PDT)
Date: Thu, 07 May 2026 18:16:57 -0400
Message-ID: <71f5ecc18e71e40093ddaf1b0dd1df2b@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20260507
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

We've got five more SELinux patches to fix a few problems, quick summary
below:

- Allow for multiple opens of /sys/fs/selinux/policy

Prevents a single process from blocking others from reading the
SELinux policy loaded in the kernel.  This does have the side effect
of potentially allowing userspace to trigger additional kernel memory
allocations as part of the open/read operation, but this is mitigated
by requiring the SELinux security/read_policy permission.

- Reduce the critical sections where the SELinux policy mutex is held

This includes the patch to the policy loader code where we move the
permission checks and an allocation outside the mutex as well as the
the patch to checkreqprot which drops the code/lock entirely.  While
the checkreqprot code had effectively been dropped in an earlier release,
portions of the code still remained that would have triggered the mutex
to perform an IMA measurement.  This pull request finally drops all of
that while preserving the user visible behavior.

- Eliminate potential sources of log spamming

There were a few areas where processes could flood the system logs and
hide other, more critical events.  The previously disabled checkreqprot
and runtime disable knobs in selinuxfs were two such areas that have now
been greatly simplified and a pr_err() replaced with a pr_err_once().  The
third such place is the /sys/fs/selinux/user file, which hasn't been
used by a userspace release since 2020 and was scheduled for removal
after 2025; this pull request effectively disables this functionality,
but similar to checkreqprot, it is done in a way that should not break
old userspace.

Paul

--
The following changes since commit 7fd2df204f342fc17d1a0bfcd474b24232fb0f32:

  Linux 7.1-rc2 (2026-05-03 14:21:25 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20260507

for you to fetch changes up to 868f31e4061eca8c3cd607d79d954d5e54f204aa:

  selinux: shrink critical section in sel_write_load()
    (2026-05-05 16:02:28 -0400)

----------------------------------------------------------------
selinux/stable-7.1 PR 20260507
----------------------------------------------------------------

Stephen Smalley (5):
      selinux: prune /sys/fs/selinux/checkreqprot
      selinux: prune /sys/fs/selinux/disable
      selinux: prune /sys/fs/selinux/user
      selinux: allow multiple opens of /sys/fs/selinux/policy
      selinux: shrink critical section in sel_write_load()

 security/selinux/include/security.h |    2 
 security/selinux/selinuxfs.c        |  196 ++++------------------------
 security/selinux/ss/services.c      |  125 -----------------
 3 files changed, 31 insertions(+), 292 deletions(-)

--
paul-moore.com
