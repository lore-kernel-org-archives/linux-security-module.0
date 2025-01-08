Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2ED1ACEDD
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jan 2025 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302128; cv=none; b=Ko50lHKdIr+p/9AkM6xmgHixNraIp8qvuMcXbFoHV0l3bRXAMf66O+TQrerrnjwqR/N9uWhCDZbeOzRLMpb7qmBgNYMqDbFfXcR/i/Pl/GBcyRmfhWdzlyfiPl016a/pS1+puVCR4zjxz4vQn+ohUF93UYavXIDHQ86/adppi+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302128; c=relaxed/simple;
	bh=WUFZcwWRoAiXUoWOaiOcPbkuOTuGd1/b8k7miYOj5aI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l6GKS/fAXsHq99WgeF0RJ11Ay8lvhyBBM9uLo2D61tCr2Tl+0rWkwuxbqEvuBVVTdNJoohqpGzNBQI0sGROkBhih9/jyjGjiS37Ol9bl5VmDvKW7EcHifuV9isvZTFR9FZKqkdPIiJCq86QJnJ/9DgFTS4hxTBUiSgs1yR+FRDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=G7Ovahb6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="G7Ovahb6"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2163dc5155fso237077575ad.0
        for <linux-security-module@vger.kernel.org>; Tue, 07 Jan 2025 18:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736302125; x=1736906925; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vr1AmSpAXQaPMTqNcGDOgGl9O+bLngonO0DcMs8xKEA=;
        b=G7Ovahb6A9pQ3phEBXzKWIolJJ9bKEzxsXngIgiKFtP5PIDZ1PoReykbGHL5b7iyy2
         wYlD+szOKm+gWSeKfYuMYbyySLMwMZ6I5pa3lDFnCG4Va1HjVW+pKtsGl25UHVx4Aqse
         sAuXUPB7oxLEXF2GZmqo214oc+ciF1Lw90HkXHpVEAasIS1/WyXcReSsnZbIPiTXE5Dz
         20i7mlEfHiLX8ZiYABxYQ5VVpko0PWRfN/b+LspmodFiLXBF1xnIaVFZQMcES6QmW4OA
         jIDq1F2E18I39hgER+/bNCTGj7dOETEqSeqnm/LLZx+H84t6ejIiVIvq/HZOYqxVnQaZ
         FJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736302125; x=1736906925;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vr1AmSpAXQaPMTqNcGDOgGl9O+bLngonO0DcMs8xKEA=;
        b=FP4WeKUuEIIPORGog+mHrVPrWcOSBbRheEqKbdfyWHSmFZEpUaUHbQ54rrH8mAU5//
         RSZsHTTR4HgCd6qQ7HcY15N5ok0TqgTBj0G8BzifTlH/S6EPg0YcsUaEG6PXcuG1wAZ2
         cj0leVg9S/gI/qLJ1VoUdbURbnCmUWVo+lwYrDCVLkfb5AiAkZItOh7B6GuPKa+xdDin
         le/as0K5vghRbVJzbaBojCLx5z+Tq+9z8BH3WVMIF7YHJ1WYYQ4uuL2NOBiQ9nxYzhJY
         uRU1vF08GdCU4Qv/4K/Kpy1j0Jg9iyg4QdjxEyj5lrs+lCRTJf1YyT4xz2wh925/gJze
         bkpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyZ4n+B+/vXof02J92keDhiYc7zcUGBNRICzQx1fZkrHa+B/9I3k8UuQuYvxU2XV6Bvg8WnLrCgKt/UzLFmF2+pyFdqyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0jr7mQzvQW9ucepXrryJpRbP2dn/288a8LXo91JlIjZRmkA+n
	ZDLDwsytciOivSThM74ja8gKkbbN0FvnfSWHiG1ZCiYejWY6qyeS0AJNvsWZkmvEF19g/Mo+jvq
	E
X-Gm-Gg: ASbGnctttP5yLSq1b1it34nZXULIjHCBGaYEwlYegpKnjrBgMSrzv3fm8ubQ6eGymbF
	wEqfCQ1ESVEdHd8ZSrWLkaYof8ZxplXig1a+0PCmUylO1U5ZVPUroeIq/Bn6VSz68N89nwUUzPp
	Tg5TLT1Re1S7uLwysrlPgk4inVGDxKwe/Hmb8aPWHfFiWo7b6yi4qvHtZZT0t7e7n09P+9QWOLa
	cYJP4mcNCAZIw5VXYXdhUwj3wMExfgZ2wV/0rAdDgRBsckHyzAo76DW27fcRB1fe1GltGAL
X-Google-Smtp-Source: AGHT+IHFCV6DoMxpthinrRcTWbfIS/h/v2ZDYtOGvPB+QgXmKxtEYUP/pj8/+spK4fFqnVlk80B97A==
X-Received: by 2002:a17:902:d4c4:b0:215:9ea1:e95e with SMTP id d9443c01a7336-21a83f591c3mr17725325ad.13.1736302125552;
        Tue, 07 Jan 2025 18:08:45 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca0282fsm316662405ad.259.2025.01.07.18.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 18:08:44 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 07 Jan 2025 18:08:03 -0800
Subject: [PATCH v5 15/16] perf tools: s390: Use generic syscall table
 scripts
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-perf_syscalltbl-v5-15-935de46d3175@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6102; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=WUFZcwWRoAiXUoWOaiOcPbkuOTuGd1/b8k7miYOj5aI=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rtPZbS41VKn73rYrle5x5Qnbf3HLfECb7Cn0dz7Zo9z
 uwryUnrKGVhEONgkBVTZOG51sDceke/7Kho2QSYOaxMIEMYuDgFYCKcdxj+Z81/I6K6zlLBN/FZ
 /P1dhi+a0u5K3s840s71V9RzpXNREcP/iG6lw01fsvTtxPRd+J/aHLDdf0vy2BJlTfUdUeoGbq5
 MAA==
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Use the generic scripts to generate headers from the syscall table
instead of the custom ones for s390.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.config                         |  6 +---
 tools/perf/Makefile.perf                           |  2 +-
 tools/perf/arch/s390/Makefile                      | 21 --------------
 tools/perf/arch/s390/entry/syscalls/Kbuild         |  2 ++
 .../arch/s390/entry/syscalls/Makefile.syscalls     |  5 ++++
 tools/perf/arch/s390/entry/syscalls/mksyscalltbl   | 32 ----------------------
 tools/perf/arch/s390/include/syscall_table.h       |  2 ++
 tools/perf/util/syscalltbl.c                       |  6 +---
 8 files changed, 12 insertions(+), 64 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 7213f6d806e5497309524cacb16bd8313e9bc5cb..feb61be7c4f93d7ebe0530839aebcd03ab8ec425 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -31,10 +31,6 @@ $(call detected_var,SRCARCH)
 ifneq ($(NO_SYSCALL_TABLE),1)
   NO_SYSCALL_TABLE := 1
 
-  ifeq ($(SRCARCH),s390)
-    NO_SYSCALL_TABLE := 0
-  endif
-
   # architectures that use the generic syscall table scripts
   ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
     NO_SYSCALL_TABLE := 0
@@ -90,7 +86,7 @@ ifeq ($(SRCARCH),loongarch)
 endif
 
 ifeq ($(ARCH),s390)
-  CFLAGS += -fPIC -I$(OUTPUT)arch/s390/include/generated
+  CFLAGS += -fPIC
 endif
 
 ifeq ($(ARCH),mips)
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 0e30da3b781b5a51ea179ab15993391ff7055635..8081adf0e02354b9662a4e3c8493d6b1cec9fe25 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-generic_syscall_table_archs := riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips powerpc
+generic_syscall_table_archs := riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips powerpc s390
 ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
diff --git a/tools/perf/arch/s390/Makefile b/tools/perf/arch/s390/Makefile
index c431c21b11ef824535c1b9fb6ca4246d666fc97b..0033698a65ce5d5d7ebcc280399957561dd9d2c6 100644
--- a/tools/perf/arch/s390/Makefile
+++ b/tools/perf/arch/s390/Makefile
@@ -1,24 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_JITDUMP := 1
-
-#
-# Syscall table generation for perf
-#
-
-out    := $(OUTPUT)arch/s390/include/generated/asm
-header := $(out)/syscalls_64.c
-sysprf := $(srctree)/tools/perf/arch/s390/entry/syscalls
-sysdef := $(sysprf)/syscall.tbl
-systbl := $(sysprf)/mksyscalltbl
-
-# Create output directory if not already present
-$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
-
-$(header): $(sysdef) $(systbl)
-	$(Q)$(SHELL) '$(systbl)' $(sysdef) > $@
-
-clean::
-	$(call QUIET_CLEAN, s390) $(RM) $(header)
-
-archheaders: $(header)
diff --git a/tools/perf/arch/s390/entry/syscalls/Kbuild b/tools/perf/arch/s390/entry/syscalls/Kbuild
new file mode 100644
index 0000000000000000000000000000000000000000..9a41e3572c3afd4f202321fd9e492714540e8fd3
--- /dev/null
+++ b/tools/perf/arch/s390/entry/syscalls/Kbuild
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/s390/entry/syscalls/Makefile.syscalls b/tools/perf/arch/s390/entry/syscalls/Makefile.syscalls
new file mode 100644
index 0000000000000000000000000000000000000000..9762d7abf17c3f79a6213e7306a5f7b56e833a78
--- /dev/null
+++ b/tools/perf/arch/s390/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_64 += renameat rlimit memfd_secret
+
+syscalltbl = $(srctree)/tools/perf/arch/s390/entry/syscalls/syscall.tbl
diff --git a/tools/perf/arch/s390/entry/syscalls/mksyscalltbl b/tools/perf/arch/s390/entry/syscalls/mksyscalltbl
deleted file mode 100755
index 52eb88a77c94727aeb8c15427cdd43dfe5f9f2bd..0000000000000000000000000000000000000000
--- a/tools/perf/arch/s390/entry/syscalls/mksyscalltbl
+++ /dev/null
@@ -1,32 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-#
-# Generate system call table for perf
-#
-# Copyright IBM Corp. 2017, 2018
-# Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
-#
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
-	echo 'static const char *const syscalltbl_s390_64[] = {'
-	while read nr abi sc discard; do
-		printf '\t[%d] = "%s",\n' $nr $sc
-		max_nr=$nr
-	done
-	echo '};'
-	echo "#define SYSCALLTBL_S390_64_MAX_ID $max_nr"
-}
-
-grep -E "^[[:digit:]]+[[:space:]]+(common|64)" $SYSCALL_TBL	\
-	|sort -k1 -n					\
-	|create_table
diff --git a/tools/perf/arch/s390/include/syscall_table.h b/tools/perf/arch/s390/include/syscall_table.h
new file mode 100644
index 0000000000000000000000000000000000000000..b53e31c15805319a01719c22d489c4037378b02b
--- /dev/null
+++ b/tools/perf/arch/s390/include/syscall_table.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/syscalls_64.h>
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 8869fed1a58946c590484816354d8c74aff52ee3..210f61b0a7a264a427ebb602185d3a9da2f426f4 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -14,11 +14,7 @@
 #include <string.h>
 #include "string2.h"
 
-#if defined(__s390x__)
-#include <asm/syscalls_64.c>
-const int syscalltbl_native_max_id = SYSCALLTBL_S390_64_MAX_ID;
-static const char *const *syscalltbl_native = syscalltbl_s390_64;
-#elif defined(GENERIC_SYSCALL_TABLE)
+#if defined(GENERIC_SYSCALL_TABLE)
 #include <syscall_table.h>
 const int syscalltbl_native_max_id = SYSCALLTBL_MAX_ID;
 static const char *const *syscalltbl_native = syscalltbl;

-- 
2.34.1

