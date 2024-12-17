Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87861DDC3C
	for <linux-security-module@vger.kernel.org>; Tue, 17 Dec 2024 06:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417564; cv=none; b=NDclYNHYX6300XsB6tIaDwLrD9pRzRrUdc7INPzmICmUZgfxEpWI2bEBj/R5/7+5LupFqa9SnTXh96w74VMrO2zp+VU6yQwJhqfOS7F3Ozshiac30jdQ+VtJs3E5ubC56NaIlIUH6TLbEYU7Wgm4OzXsCXhCpHLa8bHlJ5b+tsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417564; c=relaxed/simple;
	bh=G5z4ZauX9QfJoBAuCbuGuwLJbsOqwLsh16GJRVCk8oE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T5oMMhg7b3g/MWByc6fcHYRFYLwMa4PkmnhWwmrJBsH4dPduFqMBirF9s//EOOijvGKj6z+o5solekTPtjtfjdVM9rIbv6zbpyB7n46n0IHVyyxPeETfk74XBavPoiR29Wa7fkXb/UZ+QeZZZg6SI18QgdkIDhwjcm6vr03Cgxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NcbyOVJs; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NcbyOVJs"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-801c7e6518eso1885861a12.2
        for <linux-security-module@vger.kernel.org>; Mon, 16 Dec 2024 22:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734417562; x=1735022362; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=euJl9W34MyY1TVJyYJNiwzcX7XKHzg3BpRu6zirxvZk=;
        b=NcbyOVJsPu8tYgKbFq/qoe1na/Jh8+JuJE1wBNL5Qi3sYArgktacCSGZL3Hl2My3VW
         TY4LX6UluL89XOdBEOYPGX1MA/UimZM8wN0L9BuCP/93s4YlUeDluHXtdtQq/7FCZw5Q
         e6qNxkRRbwZIyGoizSePDl6cASBn32ZSDqR0FXFT+W2sUlDRLcy8k4TWMO5XqzaS+fog
         Bxsdsyre81vHMR/G1dF7TuBMmZLiuwF7kcYo3Yg6xbr3BNHqQfXmg2kRhM56NwHzMRCQ
         XVDSJiB68/n0tTWP1OTcrsK2vlG4lSRwRxU0ZuwuGMuD+4Z+yFmAgAjOHdL5P25gBic7
         d54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734417562; x=1735022362;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euJl9W34MyY1TVJyYJNiwzcX7XKHzg3BpRu6zirxvZk=;
        b=E3RE9U0v+cMg3y2T854qvQ63EiyMdAm44ofosUPBs0ngzk63+1nyBi8pQoaISIL6uB
         W0V3u03A0yrbAw7EVGpJJy2VX8BPnclG/paM3sUxHZCj3UdnzL1O48qnJJi/LPKhsge1
         8I3lSRGvb0djOfgxxCt0ruts6AIV2sCiuLurj9o+VtCULmswU4u2DPF4CTS20hsTdi5r
         iaaMWnXDlmGmmo67MwWyno5ZwGBVWS5zcqtyUBdVPJwyIDJosvQZ1onTnB4l899lVgMV
         dPkz/asqDychz7IclPMFncWE0L67tBYBUBvQTXUNtt/dJicdb0wnFce+w2VatsnsaQ15
         6BLw==
X-Forwarded-Encrypted: i=1; AJvYcCXRq8vY0oizBm1TzQtBCQGfhwnlwcQ7HBmxHFbhok/vQgJrN3tHaVrGmfO7Yh7UEoz/ZVsKvcw88L1qKKxMszuf7mm7YBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTfDPGW0g0FARxpXXiyrXkvjBpZoShsexBggORQhXvSNYTTaOh
	2Wm8WD5UdQkO0q3q//1JisZEjdIHD+xQa8a85d7Nx8cHk6YP9wXGES17kdvyN3U=
X-Gm-Gg: ASbGnctkO6krfcZCY8zUu84SMxVUGN5nsm4+x6+SuAeWvwcf4M8LlrYau0TprCKV38w
	8v1tisaDYqercERLkIupx+3R1vCtiqSoYZjbEmRanlqX+A0nw2p0ix4taH7z/36hQeQA3A5gYbP
	9kvjKNAolYDEr5Ym0iS+/28rW4MIOx6ih1LM6BGnM/CAXXSjsvgL/VHBvuu2jFRKL6BqvgckfIj
	sBnx4zwH75rth0fhYXQI+YO2PY/Uaua0DUGTp1YakAKyR7OJ86Dvk2avfxEADYlJw2Nz81A
X-Google-Smtp-Source: AGHT+IGqlnl/b+gh5FmvpZNT+WBF1msYf06NK1q7eNepM4VuIgvGGzEtp129msaKSOCVAB+ecLoVyw==
X-Received: by 2002:a17:90b:2744:b0:2ef:33a4:ae6e with SMTP id 98e67ed59e1d1-2f2d7d9fd46mr4370548a91.12.1734417562182;
        Mon, 16 Dec 2024 22:39:22 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d90d6bsm9179551a91.2.2024.12.16.22.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 22:39:21 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 16 Dec 2024 22:32:47 -0800
Subject: [PATCH v3 02/16] perf tools: arc: Support generic syscall headers
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-perf_syscalltbl-v3-2-239f032481d5@rivosinc.com>
References: <20241216-perf_syscalltbl-v3-0-239f032481d5@rivosinc.com>
In-Reply-To: <20241216-perf_syscalltbl-v3-0-239f032481d5@rivosinc.com>
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
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2837; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=G5z4ZauX9QfJoBAuCbuGuwLJbsOqwLsh16GJRVCk8oE=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3qiTO+vlgO3Hd8++fViiVLG/IlH+7/5Pp7K4MmiKel2X
 aiKIWFbRykLgxgHg6yYIgvPtQbm1jv6ZUdFyybAzGFlAhnCwMUpABOJbmX4n6Qqum7v/HWGU0TK
 lj0Q0FOekfquOuv3QimdqgXvDh96e4Xhn8WStvWdm9++S/nnaXA8SPuaC1uTSdu/mMqt82V2nD+
 swQIA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Arc uses the generic syscall table, use that in perf instead of
requiring libaudit.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.config                           | 2 +-
 tools/perf/Makefile.perf                             | 3 ++-
 tools/perf/arch/arc/entry/syscalls/Kbuild            | 2 ++
 tools/perf/arch/arc/entry/syscalls/Makefile.syscalls | 3 +++
 tools/perf/arch/arc/include/syscall_table.h          | 2 ++
 5 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6e4d0ef58ccb40da793f3ab8cca77d620d258bb4..d3c12c6ba6764e9a8b12acee603a0509154f2c74 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -36,7 +36,7 @@ ifneq ($(NO_SYSCALL_TABLE),1)
   endif
 
   # architectures that use the generic syscall table scripts
-  ifeq ($(SRCARCH),riscv)
+  ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
     NO_SYSCALL_TABLE := 0
     CFLAGS += -DGENERIC_SYSCALL_TABLE
     CFLAGS += -I$(OUTPUT)tools/perf/arch/$(SRCARCH)/include/generated
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f5278ed9f778f928436693a14e016c5c3c5171c1..f717e4628d9e4632f53fed16524a659a3e4feea5 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,8 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-ifeq ($(SRCARCH),riscv)
+generic_syscall_table_archs := riscv arc
+ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
 include Makefile.config
diff --git a/tools/perf/arch/arc/entry/syscalls/Kbuild b/tools/perf/arch/arc/entry/syscalls/Kbuild
new file mode 100644
index 0000000000000000000000000000000000000000..11707c481a24ecf4e220e51eb1aca890fe929a13
--- /dev/null
+++ b/tools/perf/arch/arc/entry/syscalls/Kbuild
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_32.h
diff --git a/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls b/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
new file mode 100644
index 0000000000000000000000000000000000000000..391d30ab7a831b72d2ed3f2e7966fdbf558a9ed7
--- /dev/null
+++ b/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_32 += arc time32 renameat stat64 rlimit
diff --git a/tools/perf/arch/arc/include/syscall_table.h b/tools/perf/arch/arc/include/syscall_table.h
new file mode 100644
index 0000000000000000000000000000000000000000..4c942821662d95216765b176a84d5fc7974e1064
--- /dev/null
+++ b/tools/perf/arch/arc/include/syscall_table.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/syscalls_32.h>

-- 
2.34.1

