Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969403AEF58;
	Thu, 26 Mar 2026 06:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774505249; cv=none; b=eoCHcm8rtreIl8WkpCPgvq1g0JIL/Fu8JIz+X1B33EDwWEnRlKO5NsLuMRCosuUOE00ee4tdLCta7GGnAagMYVq900nDOc3vJN4W/FpugtY6RtDQUo/vTiioRBcyoM3lVXHlF+GltGhtJerzhM/25nyGc7vOsyJCwJ34Je2R48w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774505249; c=relaxed/simple;
	bh=xfSY7ZJOL4ppkbRuoc3Yoq50jp40FMnuIuXExj8hNAw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILPWRgHxnRF1OK0OcRniQF94SQ0juNka425FvfES/vfgtT6eLc190J8YMfmB1+MXqOdF88Hk7mekcRF35CIUlkpiqJzu06tzUUF0snNskQ6AhfOCIOQaoi+Z/KGZjtG8JRTo9d0nGP2wXuVUhG07RtDkxwZKnCI4gZJOszYDoSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pVmAL/Sy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pVmAL/Sy"
Received: from narnia.corp.microsoft.com (unknown [40.78.13.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id C731B20B7007;
	Wed, 25 Mar 2026 23:07:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C731B20B7007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774505248;
	bh=jSPuY6O45hyz8xhN9OOPqEMSwKWk3+rFpaYAznBd3x0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pVmAL/Syc/v7ff3v+huBrON6WZfFMe6FvdZ1jUFJLEmeolzGXh5Y+hWDeAuWVIipS
	 WhOkZR4vKtArVia5SsbudPYCeb3BtSJ51bl6unQwwSJL9Ac+BJTF+uQZoQkQme1aP7
	 UqFKzT8EaL2qN6cCgi36JvJ7TVes9DpPwLpwbOGw=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James.Bottomley@HansenPartnership.com,
	dhowells@redhat.com,
	Fan Wu <wufan@kernel.org>,
	Ryan Foster <foster.ryan.r@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 9/9] selftests/hornet: Add a selftest for the Hornet LSM
Date: Wed, 25 Mar 2026 23:06:38 -0700
Message-ID: <20260326060655.2550595-10-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326060655.2550595-1-bboscaccy@linux.microsoft.com>
References: <20260326060655.2550595-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This selftest contains a testcase that utilizes light skeleton eBPF
loaders and exercises hornet's map validation.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 tools/testing/selftests/Makefile             |  1 +
 tools/testing/selftests/hornet/Makefile      | 63 ++++++++++++++++++++
 tools/testing/selftests/hornet/loader.c      | 21 +++++++
 tools/testing/selftests/hornet/trivial.bpf.c | 33 ++++++++++
 4 files changed, 118 insertions(+)
 create mode 100644 tools/testing/selftests/hornet/Makefile
 create mode 100644 tools/testing/selftests/hornet/loader.c
 create mode 100644 tools/testing/selftests/hornet/trivial.bpf.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 450f13ba4cca9..4e2d1cd88c825 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -44,6 +44,7 @@ TARGETS += ftrace
 TARGETS += futex
 TARGETS += gpio
 TARGETS += hid
+TARGETS += hornet
 TARGETS += intel_pstate
 TARGETS += iommu
 TARGETS += ipc
diff --git a/tools/testing/selftests/hornet/Makefile b/tools/testing/selftests/hornet/Makefile
new file mode 100644
index 0000000000000..432bce59f54e7
--- /dev/null
+++ b/tools/testing/selftests/hornet/Makefile
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0
+include ../../../build/Build.include
+include ../../../scripts/Makefile.arch
+include ../../../scripts/Makefile.include
+
+CLANG ?= clang
+CFLAGS := -g -O2 -Wall
+BPFTOOL ?= $(TOOLSDIR)/bpf/bpftool/bpftool
+SCRIPTSDIR := $(abspath ../../../../scripts/hornet)
+TOOLSDIR := $(abspath ../../..)
+LIBDIR := $(TOOLSDIR)/lib
+BPFDIR := $(LIBDIR)/bpf
+TOOLSINCDIR := $(TOOLSDIR)/include
+APIDIR := $(TOOLSINCDIR)/uapi
+CERTDIR := $(abspath ../../../../certs)
+PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
+
+TEST_GEN_PROGS := loader
+TEST_GEN_FILES := vmlinux.h loader.h trivial.bpf.o map.bin sig.bin insn.bin signed_loader.h
+$(TEST_GEN_PROGS): LDLIBS += -lbpf
+$(TEST_GEN_PROGS): $(TEST_GEN_FILES)
+
+include ../lib.mk
+
+BPF_CFLAGS := -target bpf \
+	-D__TARGET_ARCH_$(ARCH) \
+	-I/usr/include/$(shell uname -m)-linux-gnu \
+	$(KHDR_INCLUDES)
+
+vmlinux.h:
+	$(BPFTOOL) btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h
+
+trivial.bpf.o: trivial.bpf.c vmlinux.h
+	$(CLANG) $(CFLAGS) $(BPF_CFLAGS) -c $< -o $@
+
+loader.h: trivial.bpf.o
+	$(BPFTOOL) gen skeleton -S -k $(CERTDIR)/signing_key.pem -i $(CERTDIR)/signing_key.x509 \
+		-L $< name trivial > $@
+
+insn.bin: loader.h
+	$(SCRIPTSDIR)/extract-insn.sh $< > $@
+
+map.bin: loader.h
+	$(SCRIPTSDIR)/extract-map.sh $< > $@
+
+$(OUTPUT)/gen_sig: ../../../../scripts/hornet/gen_sig.c
+	$(call msg,GEN_SIG,,$@)
+	$(Q)$(CC) $(shell $(PKG_CONFIG) --cflags libcrypto 2> /dev/null) \
+		  $< -o $@ \
+		  $(shell $(PKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
+
+sig.bin: insn.bin map.bin $(OUTPUT)/gen_sig
+	$(OUTPUT)/gen_sig --key $(CERTDIR)/signing_key.pem --cert $(CERTDIR)/signing_key.x509 \
+		--data insn.bin --add map.bin:0 --out sig.bin
+
+signed_loader.h: sig.bin
+	$(SCRIPTSDIR)/write-sig.sh loader.h sig.bin > $@
+
+loader: loader.c signed_loader.h
+	$(CC) $(CFLAGS) -I$(LIBDIR) -I$(APIDIR) $< -o $@ -lbpf
+
+
+EXTRA_CLEAN = $(OUTPUT)/gen_sig
diff --git a/tools/testing/selftests/hornet/loader.c b/tools/testing/selftests/hornet/loader.c
new file mode 100644
index 0000000000000..f27580c7262b3
--- /dev/null
+++ b/tools/testing/selftests/hornet/loader.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stddef.h>
+#include <sys/resource.h>
+#include <bpf/libbpf.h>
+#include <errno.h>
+#include  "signed_loader.h"
+
+int main(int argc, char **argv)
+{
+	struct trivial *skel;
+
+	skel = trivial__open_and_load();
+	if (!skel)
+		return -1;
+
+	trivial__destroy(skel);
+	return 0;
+}
diff --git a/tools/testing/selftests/hornet/trivial.bpf.c b/tools/testing/selftests/hornet/trivial.bpf.c
new file mode 100644
index 0000000000000..d38c5b53ff932
--- /dev/null
+++ b/tools/testing/selftests/hornet/trivial.bpf.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+char LICENSE[] SEC("license") = "Dual BSD/GPL";
+
+int monitored_pid = 0;
+
+SEC("tracepoint/syscalls/sys_enter_unlinkat")
+int handle_enter_unlink(struct trace_event_raw_sys_enter *ctx)
+{
+	char filename[128] = { 0 };
+	struct task_struct *task;
+	unsigned long start_time = 0;
+	int pid = bpf_get_current_pid_tgid() >> 32;
+	char *pathname_ptr = (char *) BPF_CORE_READ(ctx, args[1]);
+
+	bpf_probe_read_str(filename, sizeof(filename), pathname_ptr);
+	task = (struct task_struct *)bpf_get_current_task();
+	start_time = BPF_CORE_READ(task, start_time);
+
+	bpf_printk("BPF triggered unlinkat by PID: %d, start_time %ld. pathname = %s",
+		   pid, start_time, filename);
+
+	if (monitored_pid == pid)
+		bpf_printk("target pid found");
+
+	return 0;
+}
-- 
2.53.0

