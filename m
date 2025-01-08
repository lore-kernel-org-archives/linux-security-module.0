Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD8C195980
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jan 2025 02:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302097; cv=none; b=H5X1e/MVi7gW07xcDsNZ2wxPk6Ph45F+ux4l6dMkVvhJ4wD945oCTHY7kYjUI6+mydlnLWB1DjTTe5r75BVl45/OKRMTausgkuYq2OQicPkTSzZQgvdN7iTSNk1lIs6BPJirF4N3ZXikaNtXETA7nFC0SJE5/ehw8I323xCpOyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302097; c=relaxed/simple;
	bh=ChjCi+WDWxIeAEQr9uB+RlwWvFzZ2k5NiZ20md8SwKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AUfGLkT3ObqAw5yb9LRxXu+UBfL+izi0rUpAOY9qGU95hTSMPgNviVgyBMeG/Udb3hFawMxyc7H+ug7fWN/feRb4klMSMX1ubYca7XzY/6lfKmMriokAyZYV8T0IaT9NARhpjxG1EkLqHPQCemEv4SteLXpX6GQdAVT8fhxYaMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OTZHjyHA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OTZHjyHA"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21661be2c2dso219493605ad.1
        for <linux-security-module@vger.kernel.org>; Tue, 07 Jan 2025 18:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736302095; x=1736906895; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05wirhUQV9Km8dQngc0z5Y797cbCbqNKIhJCCOZ4z1g=;
        b=OTZHjyHAqOQ5vnA6sweEHgQGMyVzHRVXV4UKdUqK8bGL6pRHrxeqxc0E0OpPa51sd/
         pzkKdmX5TgHArzBulCWqpI15TLFm3oQLm+58sx0VqiRrCDIIBD2Yt/1+jkRYc8s+4iFh
         V+2fFgoZehZJl0rGSrSz5zmUMhlshI9adlJn9OO7HzzLMFkhG8wciQrkCxgboeQ8A6p2
         ep9h187kyRwp9/zrKFhai2QvIh0Nu9SY/EXApq7XUUZw4InlGBb+aMcbf2xih2PVMhjc
         5P6D44FMnBmMEUIyTgqUuwj3rFjoqkim4yMp6ipRGKfQ4lLy40QLEDpVav4B5STy0F2f
         p/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736302095; x=1736906895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05wirhUQV9Km8dQngc0z5Y797cbCbqNKIhJCCOZ4z1g=;
        b=BNPAPujhbjaiOoIDQotqOzIZFjp/H85GfRomfuCQECtdV/jfupW0j/+u3r+cAA1Xvb
         8rFknbP0mk5QmT9hrjZIUi3GaYbwqy9aTa0vpG3hRa+ANaovBm8tcmlPHRRET/1HbNey
         +qepBlwV0kvVBqSAWbW2FDlX/B43uo0aNrRKS+qq/yE8nxjEJSWNqslqfmtBdoO1idmI
         T2oP/gqafUkHz575MLcfYckPFEQQuUjQ7AjuPgoQAVGTx1S6z5E2t/i1dyEcuCPqrQ/+
         OYqGlCuAmhpyJOn1UvnSHBR39jRoJTOKGO97HZKtX+2JiTz+yXjGGqUm2zc3z/bTe87X
         zfQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbowCUVcGrpHWOpAmUQENbRNZf9gzT2S6mwJU+0s3SPd7IPk4RJe+ENbFQDc6H9rUyMm4Z1mFL0qQYgIROAXqPx97sBr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBXTvAzaH41e0NWaXmcA94SfswBG/kTLzJSvonIuZcXejkiqva
	y6mhepUYuoAAirfR6yX5/jxlGKFbUpLBLYgYAQEu/ty2/lEfQMwG2WmBrwBoGKY=
X-Gm-Gg: ASbGncvJJYooAfQMG9lXka4OLwaxEBw/pOcogzc3yXelDXG1LQhFvcUtmna+F5o8eC2
	4PwsvWDMD+K37CeoiZkwBYWx5TBvzi4R9FNdf39ssjlnr+eeXtjyJjbd1IyIgbWmXw7JPfAIYaB
	tTVFASirBKV5wi8YO9VnYIWf0E4YZ9bYPsDl0vnv7r7k9MXxOEGbqTPM6olKVeW+y0eFvL4omhl
	E72Bl0ulR/7puf4BIb06p2fB98g6FLWL0IEjKbGpUL+tY48ZUNpSQfYpf97TnPD+MPC2btD
X-Google-Smtp-Source: AGHT+IFi2PqHlIH+52R3oy0dD5sKhEOY4OR/hJLyrqZkUQEHEQ6USqVAO5de5/oV21XIKeSPaGh+ig==
X-Received: by 2002:a17:902:e544:b0:216:414e:aa53 with SMTP id d9443c01a7336-21a83fffc58mr17459665ad.52.1736302095071;
        Tue, 07 Jan 2025 18:08:15 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca0282fsm316662405ad.259.2025.01.07.18.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 18:08:14 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 07 Jan 2025 18:07:51 -0800
Subject: [PATCH v5 03/16] perf tools: csky: Support generic syscall headers
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-perf_syscalltbl-v5-3-935de46d3175@rivosinc.com>
References: <20250107-perf_syscalltbl-v5-0-935de46d3175@rivosinc.com>
In-Reply-To: <20250107-perf_syscalltbl-v5-0-935de46d3175@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
 Leo Yan <leo.yan@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2180; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=ChjCi+WDWxIeAEQr9uB+RlwWvFzZ2k5NiZ20md8SwKA=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rtPYaYTbPWX7C8HZuyJozv7X4R1uVCB48EzF6yUXjjl
 D1XvJ5qd5SyMIhxMMiKKbLwXGtgbr2jX3ZUtGwCzBxWJpAhDFycAjCRGGtGhvmPtZbqs372ft3t
 f3r+x3QFvTiZJQeTJ2WLT61ljLxlYMnI0LT179QtLo0678tvatco14VN2jjx7SvJk5ekOM6lrVi
 VyAEA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

csky uses the generic syscall table, use that in perf instead of
requiring libaudit.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.perf                              | 2 +-
 tools/perf/arch/csky/entry/syscalls/Kbuild            | 2 ++
 tools/perf/arch/csky/entry/syscalls/Makefile.syscalls | 3 +++
 tools/perf/arch/csky/include/syscall_table.h          | 2 ++
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 44b9e33b9568f638ba12ad688833fdb661c16c16..3fe47bd21c0ea39473c584c82383ca5d4daf580f 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-generic_syscall_table_archs := riscv arc
+generic_syscall_table_archs := riscv arc csky
 ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
diff --git a/tools/perf/arch/csky/entry/syscalls/Kbuild b/tools/perf/arch/csky/entry/syscalls/Kbuild
new file mode 100644
index 0000000000000000000000000000000000000000..11707c481a24ecf4e220e51eb1aca890fe929a13
--- /dev/null
+++ b/tools/perf/arch/csky/entry/syscalls/Kbuild
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_32.h
diff --git a/tools/perf/arch/csky/entry/syscalls/Makefile.syscalls b/tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
new file mode 100644
index 0000000000000000000000000000000000000000..ea2dd10d0571df464574a9c0232ada0ac1f79a3f
--- /dev/null
+++ b/tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_32 += csky time32 stat64 rlimit
diff --git a/tools/perf/arch/csky/include/syscall_table.h b/tools/perf/arch/csky/include/syscall_table.h
new file mode 100644
index 0000000000000000000000000000000000000000..4c942821662d95216765b176a84d5fc7974e1064
--- /dev/null
+++ b/tools/perf/arch/csky/include/syscall_table.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/syscalls_32.h>

-- 
2.34.1

