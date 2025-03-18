Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E506720E70F
	for <linux-security-module@vger.kernel.org>; Tue, 18 Mar 2025 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314815; cv=none; b=t/s5wiRBv0/pSZdNeZ7eKRewBnisdv3GQJEWqSneilzGSiXGp0lt9GAxPEcw8gpXEjzLoQ1YW5jJPlWsZiYalRKofYnSxYHk4GHLW0Cqz/qP5Od50lUiwuZyF1fNpm2N9qip9vY6lr3YBYzygH30Ky2TeUpvzpoEJegDC0MV2Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314815; c=relaxed/simple;
	bh=DfDkyMj1tIYaHz4hoTjAqKyZHEMNoutDmpyXNLXROUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZtSj/I+LtWqnAaV71vWlK/ICqLkLozl3/pHSprg60vPC165tHndOu3+5du4o8FbnI8UtFqlyeUljWHvhhGUpr246QL0+2gBZtqmKBMyCmPaIbDCM6rW6f3qnT7Il5MdObIsmMhUCeUyX0shmwKA3kkkwAsoqLG7wLZYTXcDVvBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=N9ntLxtZ; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="N9ntLxtZ"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZHH3t4ZHmz7Fd;
	Tue, 18 Mar 2025 17:14:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742314490;
	bh=0G26ifulcpI8LBwhoOBo2yOOyJoQqElv9YQpuMH2qyc=;
	h=From:To:Cc:Subject:Date:From;
	b=N9ntLxtZAdvNsJPTP2kOX1x6wbUcMa5XFY3zOTzXGKIkerMunzvyczKb7g776I35L
	 28DEEmmGYOP8g5D2Wwra6VIATV5NrHEaRGxywKHd44kIdQSj44sF21Ai7P/zlj2/Qu
	 HlZroM0z/EPEeCrTFy0qiRgt8yRjh0NaciO8FUU8=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZHH3s6gRmzH2Q;
	Tue, 18 Mar 2025 17:14:49 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 0/8] Landlock signal scope fix and errata interface
Date: Tue, 18 Mar 2025 17:14:35 +0100
Message-ID: <20250318161443.279194-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

The initial motivation for this series is a fix for the signal scoping
restriction (see patch 5/8).

Because some user space code cannot use the signal scoping feature
without this fix, we need to have a way to identify if this fix is
applied to the running kernel.  This led me to implement a new "errata"
interface to let user space know if it can use some fixed features.
This should be especially useful in the Landlock Go library to be able
to use the signal scoping control.

Testing this series with Sparse, I had to add a check for __has_include
support to avoid Sparse errors.  I guess this could be fixed in Sparse
but for now let's just ignore this error.

This second patch series also brings new tests for this fix.

Previous version:
v1: https://lore.kernel.org/r/20250313145904.3238184-1-mic@digikod.net

Regards,

Mickaël Salaün (8):
  landlock: Move code to ease future backports
  landlock: Add the errata interface
  landlock: Add erratum for TCP fix
  landlock: Prepare to add second errata
  landlock: Always allow signals between threads of the same process
  selftests/landlock: Split signal_scoping_threads tests
  selftests/landlock: Add a new test for setuid()
  landlock: Document errata

 Documentation/userspace-api/landlock.rst      |  24 +++-
 include/uapi/linux/landlock.h                 |   2 +
 security/landlock/errata.h                    |  99 ++++++++++++++++
 security/landlock/errata/abi-4.h              |  15 +++
 security/landlock/errata/abi-6.h              |  19 +++
 security/landlock/fs.c                        |  22 +++-
 security/landlock/setup.c                     |  38 +++++-
 security/landlock/setup.h                     |   3 +
 security/landlock/syscalls.c                  |  22 +++-
 security/landlock/task.c                      |  12 ++
 tools/testing/selftests/landlock/base_test.c  |  38 +++++-
 tools/testing/selftests/landlock/common.h     |   1 +
 .../selftests/landlock/scoped_signal_test.c   | 108 +++++++++++++++---
 13 files changed, 374 insertions(+), 29 deletions(-)
 create mode 100644 security/landlock/errata.h
 create mode 100644 security/landlock/errata/abi-4.h
 create mode 100644 security/landlock/errata/abi-6.h


base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
-- 
2.48.1

