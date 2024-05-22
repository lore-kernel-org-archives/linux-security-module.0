Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418E015AACD
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339750; cv=none; b=iea/swtHBhSKEtyC8wgXWPkf6d+ndPmnl75Fyp6A64fbW4xEtB4Jqz/ApJlnCpjUUp9rDKnhUnG0zLZ6BbcyA5Jl1EJwN9eE3/BOs9NyjDh23vVw3r/gXS7zhgfaS/eNemD0gJC6PajyMvolb1Gk7LrH8uj8/Ya1gMrbrSdAq4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339750; c=relaxed/simple;
	bh=lCyVuupDWxVZz2sQcXJKSxKEuAFc66qg8/4YnRBy/7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cLCdOCe7xJJfXMp1935+0UxPoaGycUlzLYdmpxHXI8hJ4KVO/PMZuYGBO0XrGirJyIrR3PEKi1K7w5Qi65qIhD8KqEruqqP2rb9sQTT1SNgedzQLn3YXFJZgNeNXP3RO5FpXPnyHE/76CBbJ+Np1FwjTc5tK7MGSafxsZGVWGy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tEWYn0cD; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tEWYn0cD"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-65789db0259so6462877a12.0
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339748; x=1716944548; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dbqh1zsxn8gUvUDhxAFBA4KqPqi5wbFi57fCLR1fcnQ=;
        b=tEWYn0cD7JUJq5QtzSm9rwmKMucfa1559+ROTR7bB+wFwo8vxl0HMNAGavKVkWYkjg
         yRWi/SS6zlstQ2pcl42d31/VdNYoLwnJxfWWnnemKCfGTSbcYaHWB7R91k1+qoomHZ0L
         pDwTLHVRqob4SK4+nllR5mpBNTP8+Wtr6xfQBjABKMMSXJ/oME/i+t8OH1aMsCIJXod5
         cr1+8Ap9LlT3jpO7nf2zz8CU2OEbK3EL/uhU2xKKVrPyMl6UouiK2FFkWVeSsooZVGIB
         legpc95/RTvuHfU8HakyAr38nQWuJv+iX5vyDXwpRttaodT63N0pfe7WcQab9YwJHcoA
         Maew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339748; x=1716944548;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dbqh1zsxn8gUvUDhxAFBA4KqPqi5wbFi57fCLR1fcnQ=;
        b=sK9HrFhNDk8vnu/q7BdsGnq2wVhvAlaxDKJLFh+gWb9IFJMZMBJcWp1Jy+4omRhTIk
         3awiQBlareAnkYpIeE1z/AcKb6fLaUWyig1HcjO6oErQtUlF8CPXwKjLWIfckBd0e6zA
         hFps6hRQVGKfxghX7fTbj5ZxCk9cTpicD9IfTTglGtINWCs6ksvS6beQ7UsOel/2tsQ2
         2Pdd0GwEExOQVVH0gIk25zPzeWN20xITccvKS+Gbx3yNE3aMkalQNN30RSmCyDybsiOS
         9jtLJQHHxTy5QaN1EcPfH6t1uMFCgq5nTQCoaIaLFLERoAB0p6Lih0xus82te6K7OtjV
         yuHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIVIDp84zEJroSXu3iiIVrC0xNrHX4IEcXmsm3VAgp1CkJMTTePlQOLI0e7BXAYK1n/82J1aEt/irDNXvOIl9BFrDqRTR2ooea4xN1F1bJHfuRG2WK
X-Gm-Message-State: AOJu0Yw8F3AevgdRBFX8xeOWqZBFAN01gE1q3SF9jSQsiMbbl535bWpL
	nWaOFU2Z0gZTeuHjDoU77LoOEgnLRujs1uhDt7qtdx5G+ofHZbvpmLijdJUF2FKOB+N8NxBPFJH
	HeA==
X-Google-Smtp-Source: AGHT+IFeB1oZ2QDPlQwbKGu6/7hRJIp6ShmXfXRHnd65hPo3vaqEqmZiHbt+kHZ6MjMBCzZNuDqiB1MC7/g=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:2e43:0:b0:673:9f86:3f2f with SMTP id
 41be03b00d2f7-6764dd980f6mr1274a12.9.1716339748428; Tue, 21 May 2024 18:02:28
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:47 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-62-edliaw@google.com>
Subject: [PATCH v5 61/68] selftests/timens: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/timens/clock_nanosleep.c | 1 -
 tools/testing/selftests/timens/exec.c            | 1 -
 tools/testing/selftests/timens/futex.c           | 1 -
 tools/testing/selftests/timens/gettime_perf.c    | 1 -
 tools/testing/selftests/timens/procfs.c          | 1 -
 tools/testing/selftests/timens/timens.c          | 1 -
 tools/testing/selftests/timens/timer.c           | 1 -
 tools/testing/selftests/timens/timerfd.c         | 1 -
 tools/testing/selftests/timens/vfork_exec.c      | 1 -
 9 files changed, 9 deletions(-)

diff --git a/tools/testing/selftests/timens/clock_nanosleep.c b/tools/testing/selftests/timens/clock_nanosleep.c
index 72d41b955fb2..5608f2b519e1 100644
--- a/tools/testing/selftests/timens/clock_nanosleep.c
+++ b/tools/testing/selftests/timens/clock_nanosleep.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <sys/timerfd.h>
diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
index e40dc5be2f66..7f718a3bb043 100644
--- a/tools/testing/selftests/timens/exec.c
+++ b/tools/testing/selftests/timens/exec.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
diff --git a/tools/testing/selftests/timens/futex.c b/tools/testing/selftests/timens/futex.c
index 6b2b9264e851..0a5a81939220 100644
--- a/tools/testing/selftests/timens/futex.c
+++ b/tools/testing/selftests/timens/futex.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <linux/unistd.h>
diff --git a/tools/testing/selftests/timens/gettime_perf.c b/tools/testing/selftests/timens/gettime_perf.c
index 6b13dc277724..9fe6690edd2a 100644
--- a/tools/testing/selftests/timens/gettime_perf.c
+++ b/tools/testing/selftests/timens/gettime_perf.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <errno.h>
diff --git a/tools/testing/selftests/timens/procfs.c b/tools/testing/selftests/timens/procfs.c
index 1833ca97eb24..7bc389b05799 100644
--- a/tools/testing/selftests/timens/procfs.c
+++ b/tools/testing/selftests/timens/procfs.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <math.h>
diff --git a/tools/testing/selftests/timens/timens.c b/tools/testing/selftests/timens/timens.c
index 387220791a05..7941a43155a8 100644
--- a/tools/testing/selftests/timens/timens.c
+++ b/tools/testing/selftests/timens/timens.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
index 5e7f0051bd7b..378e058359c1 100644
--- a/tools/testing/selftests/timens/timer.c
+++ b/tools/testing/selftests/timens/timer.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <sys/syscall.h>
diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
index 9edd43d6b2c1..807edb9d83c9 100644
--- a/tools/testing/selftests/timens/timerfd.c
+++ b/tools/testing/selftests/timens/timerfd.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <sys/timerfd.h>
diff --git a/tools/testing/selftests/timens/vfork_exec.c b/tools/testing/selftests/timens/vfork_exec.c
index beb7614941fb..675c6a8b2eed 100644
--- a/tools/testing/selftests/timens/vfork_exec.c
+++ b/tools/testing/selftests/timens/vfork_exec.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
-- 
2.45.1.288.g0e0cd299f1-goog

