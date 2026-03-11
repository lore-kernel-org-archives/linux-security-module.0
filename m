Received: from a3-24.smtp-out.eu-west-1.amazonses.com (a3-24.smtp-out.eu-west-1.amazonses.com [54.240.3.24])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3637B2BEFF5;
	Wed, 11 Mar 2026 04:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.3.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773204975; cv=none; b=F9dix8nm+Ao0tKmN2dTxREi7luJm+SyIYcVGUXcJCDSsQgcQ3tVU4sVm18bswe6KKO9tA+BN3vsH9Ab9CRA/vI+jAr5h4vjLGHEDfCuXQkP6UadjwI+fMPxv2IL268cLjfzgoj2QLrdW1MX12ueVqD9dsgsO1aa39zVilSRZ8u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773204975; c=relaxed/simple;
	bh=VaqweD3LtfEsK7QneXTpi/awIl0W4xo3MVnNRstgKyg=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=sUI5pkWG8liZ8k1NKFtEswSyS78906ytGrMPPbD6Kz/4qFnGnCVmBllbRx0WCeHVWmDxhQBm5cE0YEZsDBFs3HYvLhU22u86Uxv9/6zXZ5jRx5OGyc9KdE/5j1NvHR9/wrkNvvvfVT+kIU2yz72NxT/Xoi7RBVDMJSoEflMLFds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matrixforgelabs.com; spf=pass smtp.mailfrom=send.matrixforgelabs.com; dkim=pass (1024-bit key) header.d=matrixforgelabs.com header.i=@matrixforgelabs.com header.b=qlC/IHYU; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=IoInumb+; arc=none smtp.client-ip=54.240.3.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matrixforgelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.matrixforgelabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=matrixforgelabs.com header.i=@matrixforgelabs.com header.b="qlC/IHYU";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="IoInumb+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=matrixforgelabs.com; t=1773204972;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=VaqweD3LtfEsK7QneXTpi/awIl0W4xo3MVnNRstgKyg=;
	b=qlC/IHYUgcEIPcJEuhMIMAz0uR3fOVI+PEAussJXk7JYey3G+UOLTRtMh9yitQT6
	9Lm2L/NxmxMdlE770KdRivWgnY9AUws7hT5uDy/YXAQYImsUZFaHRVHsn916PNacLjp
	gv955985iRcYyOHSg/6xD8Y4td12tokhNioyPlzw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1773204972;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=VaqweD3LtfEsK7QneXTpi/awIl0W4xo3MVnNRstgKyg=;
	b=IoInumb+tMkx8pC0clOsbvurbLfGD29mR5zHnaSLyZC569VwKQYJ9PObUOXrWApv
	o5bx+1P+553E8rm8mc5CpwSwHE/959FWKq1keri+qKuWTjQXb3qXGDtOQB5RvCF3ncr
	4mWW2GkshTZVPbYjNcmWEuTqQjDkEv3Ajxpav6zg=
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311045601.649904-1-jamie@matrixforgelabs.com>
References: <20260311045601.649904-1-jamie@matrixforgelabs.com>
From: Jamie Lindsey <jamie@matrixforgelabs.com>
To: rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: ojeda@kernel.org, paul@paul-moore.com, aliceryhl@google.com, 
	jmorris@namei.org, serge@hallyn.com, jamie@matrixforgelabs.com
Subject: [PATCH 4/5] security: add Rust LSM sample
 (CONFIG_SECURITY_RUST_LSM)
Message-ID: <0102019cdb40a230-be475611-1a6d-4157-bf6d-ae97aa190e40-000000@eu-west-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Mar 2026 04:56:12 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.eu-west-1.dUvNRtpqGVRXeo8wh60CXsl7GQehaaQ6nnrtD0cVQa3Ql6wtvHFwU/L0ElxknTtyiIJqbukn1OjAm5wWeKC4/L/mSl4kXjXWbCD+H4nPl2leK4flNX+koNzOtq4VJ309U1FPreISQBpCbnqANIVuwUyneL8ocSNAtI9Qxd/4vCM=:1.eu-west-1.xc5b6Z4+0WlftYwtQHAHsTtsfYdZQImSOXWypZD9BdY=:AmazonSES
X-SES-Outgoing: 2026.03.11-54.240.3.24

Add a minimal reference LSM written in Rust using the kernel::lsm
abstraction layer introduced in the preceding patch.  The module:

- Implements all three v1 hooks (file_open, task_alloc, task_free).
- Logs each invocation via pr_info() and returns 0 (allow) for every
  operation.  It enforces no policy.

Purposes:
1. Compile-test vehicle for=
 kernel::lsm.
2. API demonstration: shows exactly what an LSM author writes=
.
3. Boot-test reference: if /sys/kernel/security/lsm lists
   "rust_lsm_sample" after boot, hook registration works end-to-end.

LSM_ID_UNDEF is used as the identity constant; a permanent LSM_ID_*
value from include/uapi/linux/lsm.h will be requested as part of the
upstream patch series.

Activated via lsm=3D kernel command-line parameter =
or CONFIG_LSM Kconfig
string.  Requires CONFIG_SECURITYFS=3Dy for =
/sys/kernel/security/lsm to
be visible.

Compiled and boot-tested on Linux =
7.0-rc2 (commit 4ae12d8b).

Assisted-by: Claude:claude-sonnet-4-6
---
 security/Kconfig              |  2 ++
 security/Makefile             |  1 =
+
 security/rust_lsm/Kconfig     | 14 ++++++++
 security/rust_lsm/Makefile =
   |  2 ++
 security/rust_lsm/rust_lsm.rs | 66 ++++++++++++++++++++++++++++=
+++++++
 5 files changed, 85 insertions(+)
 create mode 100644 =
security/rust_lsm/Kconfig
 create mode 100644 security/rust_lsm/Makefile
 create mode 100644 security/rust_lsm/rust_lsm.rs

diff --git =
a/security/Kconfig b/security/Kconfig
index 6a4393fce9a1..fbd1ad4d36e8 =
100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -301,6 +301,8 @@ config SECURITY_COMMONCAP_KUNIT_TEST
=20
 	  If unsure, say N.
=20
+source "security/rust_lsm/Kconfig"
+
 source "security/Kconfig.hardening"
=20
 endmenu
diff --git =
a/security/Makefile b/security/Makefile
index 4601230ba442..f04f10a1592f =
100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_CGROUPS)			+=3D device_cgroup.o
 obj-$(CONFIG_BPF_LSM)			+=3D bpf/
 obj-$(CONFIG_SECURITY_LANDLOCK)		+=3D =
landlock/
 obj-$(CONFIG_SECURITY_IPE)		+=3D ipe/
+obj-$(CONFIG_SECURITY_RUS=
T_LSM)		+=3D rust_lsm/
=20
 # Object integrity file lists
 obj-$(CONFIG_INTEGRITY)			+=3D integrity/
diff --git =
a/security/rust_lsm/Kconfig b/security/rust_lsm/Kconfig
new file mode 100644
index 000000000000..e2c3c45b9f7f
--- /dev/null
+++ b/security/rust_lsm/Kconfig
@@ -0,0 +1,14 @@
+# =
SPDX-License-Identifier: GPL-2.0
+config SECURITY_RUST_LSM
+	bool "Rust LSM sample"
+	depends on SECURITY && RUST
+	help
+	  A minimal Linux Security Module written in Rust that demonstrates
+	  the kernel::lsm abstractions.  It logs file_open, task_alloc, and
+	  task_free events via pr_info().
+
+	  This module serves as a reference=
 implementation and compile-test
+	  vehicle for the Rust LSM abstraction =
layer.  It imposes no policy
+	  =E2=80=94 all hook implementations return =
0 (allow) after logging.
+
+	  If unsure, say N.
diff --git =
a/security/rust_lsm/Makefile b/security/rust_lsm/Makefile
new file mode 100644
index 000000000000..26a2319da08e
--- /dev/null
+++ b/security/rust_lsm/Makefile
@@ -0,0 +1,2 @@
+# =
SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_SECURITY_RUST_LSM) +=3D =
rust_lsm.o
diff --git a/security/rust_lsm/rust_lsm.rs =
b/security/rust_lsm/rust_lsm.rs
new file mode 100644
index 000000000000..3afba383ef65
--- /dev/null
+++ b/security/rust_lsm/rust=
_lsm.rs
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust LSM sample =E2=80=94 reference implementation of the kernel::lsm =
abstractions.
+//!
+//! This module demonstrates how a Linux Security =
Module is written in Rust.
+//! It registers three hooks (file_open, =
task_alloc, task_free), logs each
+//! invocation via pr_info!(), and =
allows every operation.
+//!
+//! It is not a policy module =E2=80=94 it =
enforces nothing.  Its purpose is to:
+//!
+//! 1. Serve as a compile-test =
vehicle for the kernel::lsm abstraction layer.
+//! 2. Demonstrate the API =
surface that upstream-bound LSMs should target.
+//! 3. Provide a boot-test=
 reference: if the kernel boots with this LSM
+//!    enabled and =
/sys/kernel/security/lsm lists "rust_lsm_sample", the
+//!    hook registration machinery is working end-to-end.
+//!
+//! Assisted-by: Claude:claude-sonnet-4-6
+
+// The build system injects #=
![no_std] for all kernel Rust objects; do not repeat it.
+
+// Required by pr_info! and other kernel logging macros.
+const __LOG_PREFIX: &[u8] =3D b"rust_lsm_sample\0";
+
+use kernel::bindings;
+use kernel::lsm;
+use kernel::prelude::*;
+
+/// The Rust LSM sample implementation.
+struct RustLsmSample;
+
+impl lsm::Hooks for RustLsmSample {
+    fn file_open(file: =
&kernel::fs::File) -> Result {
+        pr_info!("rust_lsm: file_open =
flags=3D{:#x}\n", file.flags());
+        Ok(())
+    }
+
+    fn task_alloc(task: &kernel::task::Task, clone_flags: u64) -> Result {
+        pr_info!(
+            "rust_lsm: task_alloc pid=3D{} =
clone_flags=3D{:#x}\n",
+            task.pid(),
+            clone_flags
+        );
+        Ok(())
+    }
+
+    fn task_free(task: =
&kernel::task::Task) {
+        pr_info!("rust_lsm: task_free pid=3D{}\n", =
task.pid());
+    }
+}
+
+// Register RustLsmSample with the kernel LSM =
framework.
+//
+// This macro generates:
+//   - A static `lsm_id` =
identifying this module as "rust_lsm_sample".
+//   - A static =
`security_hook_list[3]` array (filled by C shims via LSM_HOOK_INIT).
+//   - An `unsafe extern "C"` init function that calls =
security_add_hooks().
+//   - A static `lsm_info` in the `.lsm_info.init` =
ELF section so that
+//     security_init() discovers and calls the init =
function at boot.
+//
+// LSM_ID_UNDEF is used during development.  A =
permanent LSM_ID_* value from
+// include/uapi/linux/lsm.h will be =
requested as part of the upstream patch series.
+kernel::define_lsm!(
+    RustLsmSample,
+    "rust_lsm_sample\0",
+    bindings::LSM_ID_UNDEF =
as u64
+);
--=20
2.53.0

