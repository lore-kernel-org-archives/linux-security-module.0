Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074F2136643
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284901; cv=none; b=GxY1U00buEA/QQwI9PqbnESwJuLzzwIIrgeY7MwU/l5GgbjCab2/ONRUFDWzmXwUeFu3dBJY/PPDBn4nmmqVI9uFmCJrXs38ir+PL4hTOG7E23PMKWW2XOoJipCy8CP/l93xWmIMz93lHRCdx1YPnYm09wqbwGmAjehD/x9DdiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284901; c=relaxed/simple;
	bh=G9Z+f4UDECo2/fpdnwdZ9cMImfO6//j8dNyiTc61DQI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WeRjC0yNERU0/tssoZaNsyfPVuXtO6CGFJ4JEO9nUUul6epfgbcTRZZ227lSxUUYU0AMuvLIbOpt+LEjE2KqItJ37msQtllYTdUGVIAPMGdBiUPb0VNHtewlPjQPtka9bY0ue/FR+N9j7YNQkyoRacsrDEBvqe/HylWDe1dWLyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rMhucFxN; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rMhucFxN"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ee2f06e652so12180445ad.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284899; x=1715889699; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zBrDCBH8PQ+j84p/ApNmXAH0RYsTbgcnuIFTZ6uYviY=;
        b=rMhucFxNV+woUTKWMy2CTzQQXmja81x73GceWLWtEuHxjU0wsmiblm9rDAW6xuE2D2
         0Np3vvGkrRrq2jlIO4KSGkbe/1Pxy8t/TfwL5hju/GOlxwkbp1kM/dfIQ6p5TqOX8yZz
         xsxfvNa80AX66zOB1oTFT2pkrzht1VpC3ysJRgmQu68iZ9aBVYxXQwgaHwUO5wNvyDjm
         xJ0cpO5pjhpi1xByZwqgVmdFfwAIE0dqv6yIN8j2RwaVKOHB/3Dx/jtO3qU5Qny/y5w2
         ISEyp88tOP/AHCqiLyovvfCk3Wq6Rh/LBExzT03y8Mb8utyH23enDdQCS1YStuS5bj4x
         73Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284899; x=1715889699;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBrDCBH8PQ+j84p/ApNmXAH0RYsTbgcnuIFTZ6uYviY=;
        b=ctmjO0+KrGTNAlMCoaApgqoX6TyArOS7nc6qjAo0xY9WKpzfIu6Dq9Dw9UtoELZCCt
         0hfY6sLHHF4fIOeUHucvze0YHAJNQZsEmSQYvd4xV4A0umaK7mIN5+gjZL26cGvv13Gs
         su7u3RYTRJtLj/mZ1xXZTaInln95VHeva8KoppVUEYQ/vAcf0mWIUa+b/s1OJInrMSCt
         6GjMTVUZTDrBe2Lx1CLJixkubz5rgD+fNnO4MHFcQxtwwOymikYOaSAHtnkGbXSrDKja
         ck6kLmov/CwEnFzQEkrlZ74Kw7yfgLXUn1xIaQ0O78BU7r80v2d5QF0dwOV+TH8h4lNA
         9MJw==
X-Forwarded-Encrypted: i=1; AJvYcCXfswWsv/+AXbLKfrkqtDEuw3nxVn67pa2EO0L4KPeaDxmGpMNv5ZcX1YQ37b9XpBeIkmhSnsDzO1+tq9/fX5VF8ej0LRJelG3u7or7hdlwU4L3grnm
X-Gm-Message-State: AOJu0YytsS8XiwxRLbTq+PuIxE8cHe301su7Bw2VlxpPv9nX+GJj/4U9
	WleovPg6IGDXUhgK+gH5wwJ9T8O9WbaxkptAN3t+Dz8D1Ei+G78bzpy1Lp3kV5T2QxP4wPeKxWk
	7Dw==
X-Google-Smtp-Source: AGHT+IF0prgfdnVSEn6zGC0PrH+BKC7EN4aJNNV2BfSgrSTNE+YQWu0zObVIOFIr0+/doUl1wYVArQ6Pptc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:903:234f:b0:1e4:16a9:f231 with SMTP id
 d9443c01a7336-1ef4404a3e2mr18425ad.12.1715284899143; Thu, 09 May 2024
 13:01:39 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:10 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-19-edliaw@google.com>
Subject: [PATCH v3 18/68] selftests/filesystems: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/filesystems/binderfs/binderfs_test.c   | 2 --
 tools/testing/selftests/filesystems/devpts_pts.c               | 1 -
 tools/testing/selftests/filesystems/dnotify_test.c             | 1 -
 tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c  | 2 --
 tools/testing/selftests/filesystems/eventfd/eventfd_test.c     | 2 --
 tools/testing/selftests/filesystems/fat/rename_exchange.c      | 2 --
 tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c    | 2 --
 tools/testing/selftests/filesystems/statmount/statmount_test.c | 3 ---
 8 files changed, 15 deletions(-)

diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 5f362c0fd890..fca693db1b09 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <pthread.h>
diff --git a/tools/testing/selftests/filesystems/devpts_pts.c b/tools/testing/selftests/filesystems/devpts_pts.c
index b1fc9b916ace..73766447eeb0 100644
--- a/tools/testing/selftests/filesystems/devpts_pts.c
+++ b/tools/testing/selftests/filesystems/devpts_pts.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
diff --git a/tools/testing/selftests/filesystems/dnotify_test.c b/tools/testing/selftests/filesystems/dnotify_test.c
index c0a9b2d3302d..05367a70b963 100644
--- a/tools/testing/selftests/filesystems/dnotify_test.c
+++ b/tools/testing/selftests/filesystems/dnotify_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE	/* needed to get the defines */
 #include <fcntl.h>	/* in glibc 2.2 this has the needed
 				   values defined */
 #include <signal.h>
diff --git a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
index 65ede506305c..9bc2ddad7e92 100644
--- a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
+++ b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <asm/unistd.h>
 #include <linux/time_types.h>
 #include <poll.h>
diff --git a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
index f142a137526c..17935f42fbc9 100644
--- a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
+++ b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <asm/unistd.h>
diff --git a/tools/testing/selftests/filesystems/fat/rename_exchange.c b/tools/testing/selftests/filesystems/fat/rename_exchange.c
index e488ad354fce..56cf3ad8640d 100644
--- a/tools/testing/selftests/filesystems/fat/rename_exchange.c
+++ b/tools/testing/selftests/filesystems/fat/rename_exchange.c
@@ -6,8 +6,6 @@
  * Copyright 2022 Red Hat Inc.
  * Author: Javier Martinez Canillas <javierm@redhat.com>
  */
-
-#define _GNU_SOURCE
 #include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
index 759f86e7d263..b58a80bde95a 100644
--- a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
+++ b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <inttypes.h>
 #include <unistd.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
index 3eafd7da58e2..d1cefd1b7d16 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
@@ -1,7 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-
-#define _GNU_SOURCE
-
 #include <assert.h>
 #include <stdint.h>
 #include <sched.h>
-- 
2.45.0.118.g7fe29c98d7-goog

