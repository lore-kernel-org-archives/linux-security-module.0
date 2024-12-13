Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFD418A6AF
	for <linux-security-module@vger.kernel.org>; Fri, 13 Dec 2024 00:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734050024; cv=none; b=bv2UcLvCE2mqR+NR7Xmc4ErmGfwq1PSbZJviWRsAvprQPse7PB/JLSZIjPHt9afOibl6k5SBgtIgqY51KkRhZnPOKe7dNZzeuJRHTOjVAFaKLoCRMrwIbz9GCwHa3Cfu7r/EszVwdPUE2aOGDrHlFszEZ7prw6xgJ92w3w3oMBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734050024; c=relaxed/simple;
	bh=8jL6WlIkbrQRkhOaXlyZOazSVy7Wwmif0Dswgn5tqQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jOe6rnHLxfRDip8T3KMv2sDRKf3RUeMM/zsiIoe46BmhRFxrTSqq9gJedOFAhNa7HIV77DTUW7FyOPp3+sWf7astWicGtRW61hmrKAxCl2mCGVFRhlkNg9FmzbpVaqWc8sRq37vcfRHmcpC2X3fnRJlJkbOa/ZJO3qByeenVakw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qOIToa65; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qOIToa65"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so950699a91.0
        for <linux-security-module@vger.kernel.org>; Thu, 12 Dec 2024 16:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734050022; x=1734654822; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S2idtNdPI7nInDelrf+RzTQSMc2p9eCa1XxS9I9D/38=;
        b=qOIToa65OiKS1eUNIUqSYqHt1G3L0cdUS6DPdNv+jr7k1Xce/3d9u/Kql9dCSjwO2D
         87ei149CAPBWoRczJguRvGx36hFGBgQ/DuuaQoNHCrE1RigN0mtO491D+DCI3klExzFH
         fM4yFdYBn/AbhQkUqOhNDnlZopnqbrW0Vn1L8gajGH4Lq25fz8cX4vJ/M6Oebgbq3wvb
         NB+M9W2dLdCrkGLXG8QU7oH7hZrbVIuBsGA3OiYK4nrywPgK8WNAUsxLB4sS3gQX+iRV
         V+Fc2imKgVYNgZ62ezhmMr33HwtqH+TP4jm1ouuGtoRc1tggkcfAWbxyrM+DUf8TCyK2
         7d5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734050022; x=1734654822;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2idtNdPI7nInDelrf+RzTQSMc2p9eCa1XxS9I9D/38=;
        b=NtBkw+63+JzmH9bmaFwgk2EOpqt1gf8nelKNmCvLwVpNnyqWDWrPUYKAMTzYcB87vV
         ex9mOMDTlsK4XBj2Kkf2XhJ76K+TWe1AEPsn6gmDnhLgDKcLOphhgququ0XgwX2yyAGP
         uWk4U0enw5hmyXMibyIuRw45eD4lICpkQ+DOKHmAp4DBhZ0wI+6wz/oqAst6gruHMMav
         vvC57h+veGt6OUVP3cfH99ETlfKyf4q+llGFBsgLlDWFASL7pcA4PCO5v0gecWJW2w6b
         yxr4Sg0cXB6joi5MRmOTdeSr1I+ug+hniW464J7FeEvQp1H/wFNdrVywPU/rlSmUgIq1
         f71A==
X-Forwarded-Encrypted: i=1; AJvYcCULu5bZW2nAc3JpkFojTSXxfAvpxMBjnICfBf2h7w/2x2OY5QBlRN0RK+WJYMq3tpnD04VQmQ0B92VON8g/BR0DpwGhdMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTM80PGwG0ftgE4LccxjbUSe9wDpr4h2KBDfkzNJ6D2UOjBSq/
	nPbVsWXA8QxcXGSqigCvpxK9ShMEBzPJy2GPYH8rHtFLrrhheNuefEW1Z3ullPY=
X-Gm-Gg: ASbGncv1OaxobmxlTA9G6izkphJDRZHxim68vsYx2yDzF8lSyF/XTMVZ9eiwNC4S/Xq
	cQce/lBE0l1r+4Nf0s/TJVAoWGp4X0PM2myPr/xcye5EJ1WDhH/uEJbyYB3UKXBmBoR6brV+Hoc
	nNpbUh/185LR/QJouv519Zgzl7/chKZOLY/IxoHvZWmeYlco0qQ9wo3dDVV2LWp4Py7hHRvURmy
	iHJ3zo+BPloYRMVCFaRT+gmPweyX7V/DhzY5OmL31azJQzfj0OPdpKy99ca5LhOMf5hWFMA
X-Google-Smtp-Source: AGHT+IF6BURL1n4KGxBBXYaFHFvEAEgkwIEbZP9XzYad/neAWQoyVE5vKYzrvukdADh1RKZudrbbcA==
X-Received: by 2002:a17:90b:2f8d:b0:2ee:cd83:8fe7 with SMTP id 98e67ed59e1d1-2f2901b268bmr1191557a91.35.1734050021702;
        Thu, 12 Dec 2024 16:33:41 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142e0ce50sm1934462a91.39.2024.12.12.16.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 16:33:40 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 12 Dec 2024 16:33:03 -0800
Subject: [PATCH v2 13/16] perf tools: mips: Use generic syscall scripts
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-perf_syscalltbl-v2-13-f8ca984ffe40@rivosinc.com>
References: <20241212-perf_syscalltbl-v2-0-f8ca984ffe40@rivosinc.com>
In-Reply-To: <20241212-perf_syscalltbl-v2-0-f8ca984ffe40@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5531; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=8jL6WlIkbrQRkhOaXlyZOazSVy7Wwmif0Dswgn5tqQU=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3p0wwFOt/4g6/kMAhbTf/8p13DiuffjIdMmf8fMKR5qZ
 SlxdVkdpSwMYhwMsmKKLDzXGphb7+iXHRUtmwAzh5UJZAgDF6cATGSvFiPD212lr27ftpdsPifR
 Ef5Q+pvhdVM5l8BJ7wXVKuY0xcw9zPC/sO3c7qj53Gbyb47WB7C1z36z1awvRqT10478lo3GiT8
 ZAA==
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Use the generic scripts to generate headers from the syscall table for
mips.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.config                         |  5 ++--
 tools/perf/Makefile.perf                           |  2 +-
 tools/perf/arch/mips/entry/syscalls/Kbuild         |  2 ++
 .../arch/mips/entry/syscalls/Makefile.syscalls     |  5 ++++
 tools/perf/arch/mips/entry/syscalls/mksyscalltbl   | 32 ----------------------
 tools/perf/arch/mips/include/syscall_table.h       |  2 ++
 tools/perf/util/syscalltbl.c                       |  4 ---
 7 files changed, 12 insertions(+), 40 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 84ed266ce54f5291af5c59c02ccb06bfe17d840f..09c4bb713648a9ca3c5223910bd7634fe8234e52 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -31,12 +31,12 @@ $(call detected_var,SRCARCH)
 ifneq ($(NO_SYSCALL_TABLE),1)
   NO_SYSCALL_TABLE := 1
 
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc s390 mips))
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc s390))
     NO_SYSCALL_TABLE := 0
   endif
 
   # architectures that use the generic syscall table scripts
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch))
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips))
     NO_SYSCALL_TABLE := 0
     CFLAGS += -DGENERIC_SYSCALL_TABLE
     CFLAGS += -I$(OUTPUT)/tools/perf/arch/$(SRCARCH)/include/generated
@@ -83,7 +83,6 @@ ifeq ($(ARCH),s390)
 endif
 
 ifeq ($(ARCH),mips)
-  CFLAGS += -I$(OUTPUT)arch/mips/include/generated
   LIBUNWIND_LIBS = -lunwind -lunwind-mips
 endif
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 7fefeea1799231af61e77c9372318e025bed078a..b5a5f04a373e174269fe5ae8a7e8707e0b7e5835 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch))
+ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips))
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
 include Makefile.config
diff --git a/tools/perf/arch/mips/entry/syscalls/Kbuild b/tools/perf/arch/mips/entry/syscalls/Kbuild
new file mode 100644
index 0000000000000000000000000000000000000000..9a41e3572c3afd4f202321fd9e492714540e8fd3
--- /dev/null
+++ b/tools/perf/arch/mips/entry/syscalls/Kbuild
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/mips/entry/syscalls/Makefile.syscalls b/tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
new file mode 100644
index 0000000000000000000000000000000000000000..9ee914bdfb05860fdd37a49f1ced03fcf2c9ed78
--- /dev/null
+++ b/tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_64 += n64
+
+syscalltbl = $(srctree)/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
diff --git a/tools/perf/arch/mips/entry/syscalls/mksyscalltbl b/tools/perf/arch/mips/entry/syscalls/mksyscalltbl
deleted file mode 100644
index c0d93f959c4e1b8c12edcb5624bbc131231df7e3..0000000000000000000000000000000000000000
--- a/tools/perf/arch/mips/entry/syscalls/mksyscalltbl
+++ /dev/null
@@ -1,32 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-#
-# Generate system call table for perf. Derived from
-# s390 script.
-#
-# Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
-# Changed by: Tiezhu Yang <yangtiezhu@loongson.cn>
-
-SYSCALL_TBL=$1
-
-if ! test -r $SYSCALL_TBL; then
-	echo "Could not read input file" >&2
-	exit 1
-fi
-
-create_table()
-{
-	local max_nr nr abi sc discard
-
-	echo 'static const char *const syscalltbl_mips_n64[] = {'
-	while read nr abi sc discard; do
-		printf '\t[%d] = "%s",\n' $nr $sc
-		max_nr=$nr
-	done
-	echo '};'
-	echo "#define SYSCALLTBL_MIPS_N64_MAX_ID $max_nr"
-}
-
-grep -E "^[[:digit:]]+[[:space:]]+(n64)" $SYSCALL_TBL	\
-	|sort -k1 -n					\
-	|create_table
diff --git a/tools/perf/arch/mips/include/syscall_table.h b/tools/perf/arch/mips/include/syscall_table.h
new file mode 100644
index 0000000000000000000000000000000000000000..b53e31c15805319a01719c22d489c4037378b02b
--- /dev/null
+++ b/tools/perf/arch/mips/include/syscall_table.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/syscalls_64.h>
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 3001386e13a502be5279aa6e4742af0b96202b35..675702d686d0d1b53dd3ee2017cc9695686b9c63 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -26,10 +26,6 @@ static const char *const *syscalltbl_native = syscalltbl_powerpc_64;
 #include <asm/syscalls_32.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_POWERPC_32_MAX_ID;
 static const char *const *syscalltbl_native = syscalltbl_powerpc_32;
-#elif defined(__mips__)
-#include <asm/syscalls_n64.c>
-const int syscalltbl_native_max_id = SYSCALLTBL_MIPS_N64_MAX_ID;
-static const char *const *syscalltbl_native = syscalltbl_mips_n64;
 #elif defined(GENERIC_SYSCALL_TABLE)
 #include <syscall_table.h>
 const int syscalltbl_native_max_id = SYSCALLTBL_MAX_ID;

-- 
2.34.1

