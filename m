Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E848B1FCF58
	for <linux-security-module@vger.kernel.org>; Mon,  4 Nov 2024 21:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754449; cv=none; b=ste3aU7xhjKTmSQ/d4MaRKqjIbWHeLr/I+88cGXy9DGgb5YUcZrVU2w5ovtXEb/r8CKabfQx6rZA6QosTOd7GQMgg1b84G3/VzPOGGilVWUmP3YIOtoTlwjpDKU69zuHuCk8jGBOh0w1J7KiL0PUbwBjesi4uBuWDA/JzlBFdQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754449; c=relaxed/simple;
	bh=KeKtFvY7SKL2pD81p/skRGxyJKh4FWPknkDrKqvLM5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X3nTiGp/mTYfRh9PvYWkRSxg5cpRTxQqxqWYVGnhd8UJu7m4n3B9rgBpZ2CcJvRwvIQq+V0lb9YHFzbo89zGVg4R9GvnE0LSpZKlFVtFNnmt5AbSD/ca2nN6JBeUCfTpsMEmGDOtO59q/nCGhcvYKJle1ufLr0q1uWfnM0CfwsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=e6952aj+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="e6952aj+"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cf6eea3c0so36960635ad.0
        for <linux-security-module@vger.kernel.org>; Mon, 04 Nov 2024 13:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730754446; x=1731359246; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oh0zgB7sLyVYV0helH3ndPFTnKM4MrkIfS9kOuYemTI=;
        b=e6952aj+Wp+FQxNfPVnfFyDgnf/JH1OoWjXoLkzzuAJK7Z9cPthsPwmv8j5vTuf1eX
         EG+XrQmZa05/iCaRMFRCtMrIRSgIAcAikRD68M0sriDdTZicuC0gnfRMqZeTDw+7J0r7
         L1q12WnPQBtJdX2/pJ21X4kmaV5XdDf314GiMegIJ7IuQAMmZOaJvZIxWLhGpERN03je
         WskNQNKZmrDCG7eex4rjFI6FOG/u9Vef/J+Kfx3NbvEVQnqO3d77LxeMLvdHmsaNl7bB
         zjk9je3f7Bmfr5JFORxkxTU3GeCMNRg3VVPAdioJPf3bKvC8lrWx1fSLnp5y1RTCDdXp
         FkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730754446; x=1731359246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oh0zgB7sLyVYV0helH3ndPFTnKM4MrkIfS9kOuYemTI=;
        b=Wci/GO7/mDBInCXmz7amygSh18FR2Okl3iWauTEnvACbYSEignpQH5CsJpcZZaGxnB
         Q2CpILzxRfziWCOzenX+iHRNA3gGOrqZ7w77jVxKQ2GXV0ifkzXWpCXAYQXgZXnDjo/q
         zTHCNyZeT34FisX72tiVuyoD122J+0u3MtZsbE5qRJ0DRTFBee8uuab1wA3J2ICFh4/6
         ig9Bwii/90HmTwd35VqYk9JXTombaTzD4b8PL5okyC0NADtH3mqoapOBcm1H0mPN/s5v
         4T067WlvQnsjGxPBqQmcZjd2gL+R8enoEorJpAi3q4VE9IH9iPnoZiN/nUvOMxTgnfNB
         UFGw==
X-Forwarded-Encrypted: i=1; AJvYcCUjqVUBhp2UG/DrLjxiymKCCzI6Ei+8g3W0bLadjHx1o0tuIFPDbe04gpPhJAbXaZDqq6w1OnHBmn6gqE8eCyBzif1yRA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfbf6ND4zg06/+Oo4d8AaBpcuImKVcScxcMMaoO3JYLgtfSLk1
	MB6KiPXJxWljqcy+NhE9cZ9y1cFR1Uk4SMDszWSKwA313LXyaG5LkhRuFQT03NI=
X-Google-Smtp-Source: AGHT+IHaBRmk3UxLy3c5UicvluKFbnEkpJfA4ngNOpqBKAciatcY4LjQasBBZP7W0E26B0O8UkiDSA==
X-Received: by 2002:a17:903:228b:b0:20b:fd73:32bb with SMTP id d9443c01a7336-210c6872da0mr454535575ad.2.1730754446060;
        Mon, 04 Nov 2024 13:07:26 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee490e08f4sm7248293a12.40.2024.11.04.13.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:07:24 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 04 Nov 2024 13:06:16 -0800
Subject: [PATCH RFT 14/16] perf tools: powerpc: Use generic syscall table
 scripts
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-perf_syscalltbl-v1-14-9adae5c761ef@rivosinc.com>
References: <20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com>
In-Reply-To: <20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
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
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6676; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=KeKtFvY7SKL2pD81p/skRGxyJKh4FWPknkDrKqvLM5M=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7qmeZz2rPuurp2hPgXxdcotzTm3tM22c29+sz776D/nV
 bOOH9vdUcrCIMbBICumyMJzrYG59Y5+2VHRsgkwc1iZQIYwcHEKwETWr2Bk6JV8Xb7skcWGDz84
 p716arbsqNvxPJcbGUa7lwc5V57RmMfIcLryXNRfh+nxskfWRahvDzxpOKlzg/Hn99/tOzKflL2
 dyQUA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Use the generic scripts to generate headers from the syscall table
instead of the custom ones for powerpc.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.config                         |  4 +--
 tools/perf/Makefile.perf                           |  2 +-
 tools/perf/arch/powerpc/Makefile                   | 25 --------------
 tools/perf/arch/powerpc/entry/syscalls/Kbuild      |  3 ++
 .../arch/powerpc/entry/syscalls/Makefile.syscalls  |  6 ++++
 .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  | 39 ----------------------
 tools/perf/arch/powerpc/include/syscall_table.h    |  8 +++++
 tools/perf/util/syscalltbl.c                       |  8 -----
 8 files changed, 20 insertions(+), 75 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index ce7e9ae276e8..76dbd368aa9f 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -31,12 +31,12 @@ $(call detected_var,SRCARCH)
 ifneq ($(NO_SYSCALL_TABLE),1)
   NO_SYSCALL_TABLE := 1
 
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc s390))
+  ifeq ($(SRCARCH),s390)
     NO_SYSCALL_TABLE := 0
   endif
 
   # architectures that use the generic syscall table scripts
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips))
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips powerpc))
     NO_SYSCALL_TABLE := 0
     CFLAGS += -DGENERIC_SYSCALL_TABLE
     CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index c9b78518c9a5..c42cc4901005 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips))
+ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips powerpc))
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
 include Makefile.config
diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index bf6d323574f6..42dab7c8f508 100644
--- a/tools/perf/arch/powerpc/Makefile
+++ b/tools/perf/arch/powerpc/Makefile
@@ -6,28 +6,3 @@ endif
 HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
 PERF_HAVE_JITDUMP := 1
-
-#
-# Syscall table generation for perf
-#
-
-out    := $(OUTPUT)arch/powerpc/include/generated/asm
-header32 := $(out)/syscalls_32.c
-header64 := $(out)/syscalls_64.c
-sysprf := $(srctree)/tools/perf/arch/powerpc/entry/syscalls
-sysdef := $(sysprf)/syscall.tbl
-systbl := $(sysprf)/mksyscalltbl
-
-# Create output directory if not already present
-$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
-
-$(header64): $(sysdef) $(systbl)
-	$(Q)$(SHELL) '$(systbl)' '64' $(sysdef) > $@
-
-$(header32): $(sysdef) $(systbl)
-	$(Q)$(SHELL) '$(systbl)' '32' $(sysdef) > $@
-
-clean::
-	$(call QUIET_CLEAN, powerpc) $(RM) $(header32) $(header64)
-
-archheaders: $(header32) $(header64)
diff --git a/tools/perf/arch/powerpc/entry/syscalls/Kbuild b/tools/perf/arch/powerpc/entry/syscalls/Kbuild
new file mode 100644
index 000000000000..84c6599b4ea6
--- /dev/null
+++ b/tools/perf/arch/powerpc/entry/syscalls/Kbuild
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_32.h
+syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls b/tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls
new file mode 100644
index 000000000000..f7e87a61401c
--- /dev/null
+++ b/tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_32 += spu nospu
+syscall_abis_64 += spu nospu
+
+syscalltbl = $(srctree)/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
diff --git a/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl b/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl
deleted file mode 100755
index 0eb316fe6dd1..000000000000
--- a/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl
+++ /dev/null
@@ -1,39 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-#
-# Generate system call table for perf. Derived from
-# s390 script.
-#
-# Copyright IBM Corp. 2017
-# Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
-# Changed by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
-
-wordsize=$1
-SYSCALL_TBL=$2
-
-if ! test -r $SYSCALL_TBL; then
-	echo "Could not read input file" >&2
-	exit 1
-fi
-
-create_table()
-{
-	local wordsize=$1
-	local max_nr nr abi sc discard
-	max_nr=-1
-	nr=0
-
-	echo "static const char *const syscalltbl_powerpc_${wordsize}[] = {"
-	while read nr abi sc discard; do
-		if [ "$max_nr" -lt "$nr" ]; then
-			printf '\t[%d] = "%s",\n' $nr $sc
-			max_nr=$nr
-		fi
-	done
-	echo '};'
-	echo "#define SYSCALLTBL_POWERPC_${wordsize}_MAX_ID $max_nr"
-}
-
-grep -E "^[[:digit:]]+[[:space:]]+(common|spu|nospu|${wordsize})" $SYSCALL_TBL \
-	|sort -k1 -n                                                           \
-	|create_table ${wordsize}
diff --git a/tools/perf/arch/powerpc/include/syscall_table.h b/tools/perf/arch/powerpc/include/syscall_table.h
new file mode 100644
index 000000000000..7ff51b783000
--- /dev/null
+++ b/tools/perf/arch/powerpc/include/syscall_table.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/bitsperlong.h>
+
+#if __BITS_PER_LONG == 64
+#include <asm/syscalls_64.h>
+#else
+#include <asm/syscalls_32.h>
+#endif
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 724e1391893f..4320876242ae 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -17,14 +17,6 @@
 #include <asm/syscalls_64.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_S390_64_MAX_ID;
 static const char *const *syscalltbl_native = syscalltbl_s390_64;
-#elif defined(__powerpc64__)
-#include <asm/syscalls_64.c>
-const int syscalltbl_native_max_id = SYSCALLTBL_POWERPC_64_MAX_ID;
-static const char *const *syscalltbl_native = syscalltbl_powerpc_64;
-#elif defined(__powerpc__)
-#include <asm/syscalls_32.c>
-const int syscalltbl_native_max_id = SYSCALLTBL_POWERPC_32_MAX_ID;
-static const char *const *syscalltbl_native = syscalltbl_powerpc_32;
 #elif defined(GENERIC_SYSCALL_TABLE)
 #include <syscall_table.h>
 const int syscalltbl_native_max_id = SYSCALLTBL_MAX_ID;

-- 
2.34.1

