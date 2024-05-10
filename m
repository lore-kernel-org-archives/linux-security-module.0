Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE2D1386D8
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299862; cv=none; b=k2HwvzVnQ2Jj3xypNSHTt85JAJpjviyPH7ljWDtkXPWhonxjxjaHJkbGgmTYwA5XLpF19tpUkWepDuXHhLvKCvntpp+YNgJRz6auD8zx7XWRGffXWq7Cs1xd8xD5CskaBKMzFrOcktJzohNsEbNPOJ3sidTuQQjPeaXridmMr1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299862; c=relaxed/simple;
	bh=L2xiJs0pvkHTyYEWb/dHuPHUb0aoyNpUC9tm+GW7Yvw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OrTNh8bj+SUVW84yClV8XUPsRHQ08KF/RHi2Wdxf4iBhfONwd0zKSaLEgzC6eLrH0T6Tn1imLG6Ggc91a2qqYIKFlJqTZE3A5ztyJ7nJM3Yh0RDMNqZJjMy5LBjClbkq4v9y8DHB4qKkOh7cxpZ9fUu0OIElG3X2xrFXj9VynHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZI/Fccnw; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZI/Fccnw"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62079696c58so25830717b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299860; x=1715904660; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1D5J95pTto7bxbDE1cccaXNIpSHnuQdMjPAvgEtW+8E=;
        b=ZI/FccnwydftpCTsWBICZzni4XlznE8txSZti84AyoJxhIecc0z0YGcPKdGW9T/Bpl
         v3ZUGwVxpqACjDO/HeIIaO9bjIJfHT5bhLLnwh+aZZNiHWcm9nIsa5MRQUXzhzC6Jo1A
         PbNHYTHe7Zopr2w/USQX4txe2oB/XUTly36WbGaWZL3NKB4rahhd1t927SRfT05Lq2Ae
         uFTYJE7f6PAO2Bpt672AO8L7rbqqUjoQtKAde7FGHGS51593cnG7/SnNVOOI+5UCu0dG
         JVTf0orCWc8z8ajGbafb24kk38e5wSkqzGlbDmD/sq8oXyhbC0mECAI3Zxzc/gh1DDBe
         fHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299860; x=1715904660;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1D5J95pTto7bxbDE1cccaXNIpSHnuQdMjPAvgEtW+8E=;
        b=Hpi23KAicco7BoCeg1X/P55nbQtnheqWe92NkQgDGIhzUO7bh7NGErwjMNuo/dGcV+
         KIhp0LTBCh8rXHsLZpb/5eKP0IAKLX/PPUzctMN+KYjckbYLjRh+hjmSZQIzqkKsFIoO
         VCAsRWVLBxvMLQxgY0kfQcfyZn9w5ULctg2nWD+e9WRLiITa622mXPOD5i3WnkrHiFp0
         LoGQlWeOZBsmX38gzOoYWQfkRxnEC4XV8dbS/o0pRd3YRg2YonY/JvzbZ2CSx8W6cOsv
         W/yPAkZNq2DobUv3jBbB7IM6PmAnOQHBQKupfILUWA5ciyfdOKjQSQaQoSLiiBt2sMfQ
         s4wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSOCZtquyorUkTrhvJflNPVo8OHziacL6BCWvfniH/cnvlslHX0LAzmLjmeZApVgI8b4unBVDZ+mgCd3PfocJpJdwj+OfmIBg8wtVRx+ev9EGrR7Rh
X-Gm-Message-State: AOJu0YznndyNisyIvTguc7O/wKEiu6mKGtdrrQ5J80eaak//x/yzQKoh
	RLv1TYwvLHi+YjRR293iR1K2Mvj/tKf9DM1AbyY42OP78wlmkEXYlBf6hVPdqOnUP7/idUoOpmk
	eLw==
X-Google-Smtp-Source: AGHT+IGhcJ7GjAM6Vy/ApGmusiwwih9+KKpTPcTPYhDNCwh5wA+pqL1DV0C5FY2sheVBHvhFaDSoPDUPtOg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:284:b0:61b:e8ce:18a1 with SMTP id
 00721157ae682-622b016af8cmr2822137b3.10.1715299860502; Thu, 09 May 2024
 17:11:00 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:57 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-41-edliaw@google.com>
Subject: [PATCH v4 40/66] selftests/perf_events: Drop define _GNU_SOURCE
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
 tools/testing/selftests/perf_events/remove_on_exec.c   | 2 --
 tools/testing/selftests/perf_events/sigtrap_threads.c  | 2 --
 tools/testing/selftests/perf_events/watermark_signal.c | 2 --
 3 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/perf_events/remove_on_exec.c b/tools/testing/selftests/perf_events/remove_on_exec.c
index 5814611a1dc7..ef4d923f4759 100644
--- a/tools/testing/selftests/perf_events/remove_on_exec.c
+++ b/tools/testing/selftests/perf_events/remove_on_exec.c
@@ -5,8 +5,6 @@
  * Copyright (C) 2021, Google LLC.
  */
 
-#define _GNU_SOURCE
-
 /* We need the latest siginfo from the kernel repo. */
 #include <sys/types.h>
 #include <asm/siginfo.h>
diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c b/tools/testing/selftests/perf_events/sigtrap_threads.c
index d1d8483ac628..14d1a3c8cb5c 100644
--- a/tools/testing/selftests/perf_events/sigtrap_threads.c
+++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
@@ -5,8 +5,6 @@
  * Copyright (C) 2021, Google LLC.
  */
 
-#define _GNU_SOURCE
-
 /* We need the latest siginfo from the kernel repo. */
 #include <sys/types.h>
 #include <asm/siginfo.h>
diff --git a/tools/testing/selftests/perf_events/watermark_signal.c b/tools/testing/selftests/perf_events/watermark_signal.c
index 49dc1e831174..19557bd16e9e 100644
--- a/tools/testing/selftests/perf_events/watermark_signal.c
+++ b/tools/testing/selftests/perf_events/watermark_signal.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/perf_event.h>
-- 
2.45.0.118.g7fe29c98d7-goog

