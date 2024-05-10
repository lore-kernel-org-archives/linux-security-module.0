Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B45B13D2AA
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299898; cv=none; b=mTXRekkNWU+dBkQ0hI2v0yisGDafSWknz5lss9oSXHq610KHfXLDVzMFrdqCf3vDXZqFrjCBg7K6vJjc1jpXiKlAGhRpY9rs9ip+gWNU4vRK41EiR4ZsmbLWQb5wNn/6ZRQU/XG4tNEk5BJVH4cAxQsVVDRuYFFUSAAznPQvh6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299898; c=relaxed/simple;
	bh=6p8G22YTy6ZtsOf462zez70QpBb44q4tILI9m4e2cqY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BK6CTAzGE/w10n7twxToM3hcqJfdjkq5FONE5Ph5/iw65iXTJGQcDcLgehj6C2d9QqdWGYFCYBHTiFd5OjQYEUm3vAV5jdvZ6ZAcQ88gkix640k77+ZEWlyN7kXWwyaj0S6ExUASjlU3+syGR4CfG+M/PDp4tEFyw/XgrZRCYMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VXWsVMiQ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VXWsVMiQ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ed8876c40eso13967235ad.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299896; x=1715904696; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BLIfPVA39L5GI7BSivGjVMs24Ei0WVbUZT0FyKIU17I=;
        b=VXWsVMiQa9wO5DfJFjejH1tWvIekYjyfjIJDkDVb4jjgptmSYXwhYFd5z/4eTuj5t6
         NwkL3PlLQpU+PFmnuTgW7FjPwkIr/RNUS3AibsEW7OV0WdrFOfoCDNmtnI8H7IwEQdJs
         haVCORWVjy1vojqfjYgE1ldORtLPAPDgOOpdZ4EEJxDixz6lByGAKLuuJYbt79EQVxUj
         p/VFbYk1jFZug7N5WKOM3dtwCjfsFtxZMU4/7Nq/a4UK4nJb5gI17U7Mw8PleFgmUV4Q
         YkyJsAKnBrKfCXEW/Ym7yhD25yB8HiNVDNwRu4RhJ4nU/7xXWZzBVAvgTsaUYcIM9Ire
         10+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299896; x=1715904696;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BLIfPVA39L5GI7BSivGjVMs24Ei0WVbUZT0FyKIU17I=;
        b=cFjHjzHZmbnA3KwZ9L5s0gJbBN7y0x3R5TxlQEhXks+PtBFmactIfBMvy0QbDqsa9C
         JHB+gLedjCx7gqrXP2b+JbzQATgLE6GDn/Y9MKvvZZboVN3yXaFa4Tcr4zg0CcsetaNN
         W9kGzgMajMiMLcax0Ze7pcxDxJiN3lc+7EfWcPPYCJ9BhXKSi++TsZYSiEPvCwXkanI3
         H/wVQSL3Vti8GuhjMTS/7fe+CfR/8yHC655y4AjMU6kPrDmsXSV9sz33lcFtcYeRNImf
         DF4jb0FDJS6KnqTZq4HerbXFsZMWS7wSkzS7Nu0zWTvxho/lN3LOADW/NKxXr3kaLMAA
         dBJg==
X-Forwarded-Encrypted: i=1; AJvYcCX0GscwENEO3fVfnq6tvCohzO7HYfxNzJiWijG4ACzIe1+dr37JCfLt/LeCgn5qk3jvia2zGZnmf/Yuep8xhjatcWeEPxQGZxZRHdmWLyetawYp6Saw
X-Gm-Message-State: AOJu0YxLduBynycxQiWm6suq2B3fmopwe9Kt1phn6aPlqTtsLttKRxG3
	uRrXsSKGdaYCW5sGjNNRU9neZu7YrvL+9L4lMg0CiDJcMfpjAU8fzDKevL8AStph0clx6d9fjgn
	8XA==
X-Google-Smtp-Source: AGHT+IFtfbvY/gKNd590DPbi3Q8xYAZ3vcX3cNU4cCMn2Exsx2DTyqLE5W9LADivebCpRTu48XwgWckzf5M=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:903:1d1:b0:1e4:55d8:e210 with SMTP id
 d9443c01a7336-1ef43f4cf18mr628075ad.10.1715299895951; Thu, 09 May 2024
 17:11:35 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:09 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-53-edliaw@google.com>
Subject: [PATCH v4 52/66] selftests/rseq: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/rseq/basic_percpu_ops_test.c | 1 -
 tools/testing/selftests/rseq/basic_test.c            | 2 --
 tools/testing/selftests/rseq/param_test.c            | 1 -
 tools/testing/selftests/rseq/rseq.c                  | 2 --
 4 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
index 2348d2c20d0a..5961c24ee1ae 100644
--- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
+++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: LGPL-2.1
-#define _GNU_SOURCE
 #include <assert.h>
 #include <pthread.h>
 #include <sched.h>
diff --git a/tools/testing/selftests/rseq/basic_test.c b/tools/testing/selftests/rseq/basic_test.c
index 295eea16466f..1fed749b4bd7 100644
--- a/tools/testing/selftests/rseq/basic_test.c
+++ b/tools/testing/selftests/rseq/basic_test.c
@@ -2,8 +2,6 @@
 /*
  * Basic test coverage for critical regions and rseq_current_cpu().
  */
-
-#define _GNU_SOURCE
 #include <assert.h>
 #include <sched.h>
 #include <signal.h>
diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index 2f37961240ca..48a55d94eb72 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: LGPL-2.1
-#define _GNU_SOURCE
 #include <assert.h>
 #include <linux/membarrier.h>
 #include <pthread.h>
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 96e812bdf8a4..88602889414c 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -14,8 +14,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * Lesser General Public License for more details.
  */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <sched.h>
 #include <stdio.h>
-- 
2.45.0.118.g7fe29c98d7-goog

