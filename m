Received: from dd44826.kasserver.com (dd44826.kasserver.com [85.13.151.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8A91ACEBE;
	Wed, 16 Apr 2025 21:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.151.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744839791; cv=none; b=HBrfgRrPgYSpESK75wfrQCPgc+FCpa/KVdRIdFmPEjCrZYG7ldya7qiJ8v9/BpBlZEZPLUyMGaHnL2aiQdU5maToZOgalGsdU+qkn0lRCUuM+ROvGHGupEPLoRDE4lx5XedSf44Eg/b8pZ0dLUm7Fp2N8YPu4RmFr1LdYEzbq9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744839791; c=relaxed/simple;
	bh=PBqiWEdLgsZlfNsIAcuOiw5QGPBpPjG2W/1wwqS2BKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zfw5AjtLokUXRlo1RQMhUAMoDj4OIWqigk1kIhdbhMVUsOpmMCL9ouKl5XX0D+pOBJj7KgrU2TG2XL1Qwnic+MGdnYR0W0f8dL9N5boqmLXhjAHW2TWBnnERNhtSPXTtWKPw7OJ99kN5KA8WkBbHQTaEZ2rdOkxpZGdpoLLQWtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=o1oo11oo.de; spf=pass smtp.mailfrom=o1oo11oo.de; dkim=pass (2048-bit key) header.d=o1oo11oo.de header.i=@o1oo11oo.de header.b=cDUtIEXM; arc=none smtp.client-ip=85.13.151.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=o1oo11oo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=o1oo11oo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=o1oo11oo.de header.i=@o1oo11oo.de header.b="cDUtIEXM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o1oo11oo.de;
	s=kas202503061048; t=1744839401;
	bh=7pIJZupzbBZ9CRQk9SjNQxa6dL77BWVKSe4GGYrR6HU=;
	h=From:To:Cc:Subject:Date:From;
	b=cDUtIEXMjyylEOV7bYGQORB8KRuV9EPuwieHX4EX6TtbkGnULOSLAQT98rHp17QDz
	 NtHRl6TxwInrw7w2aDUoLLyJ8ff7+en+ngYmWI27LF0k9f7HrGJ0hABRtRlhtWRKm/
	 TTWVHUQhRm0yshAF7V1ocFUpeb1XtwWeu+8Np+EWrPcLpgDpwoLA35wSxY1nOKZEHq
	 qy44x5CdKhg0M9/1jMri+VxEJOArt2lGH/L/6g0voh8hWPc8BPrWcpgnvdi84Ih8LQ
	 NXqGAFUmxbDzOATLbFBqgp+KFzWTixGnrWfLWG5oTJ4SVKfHoNOdrxXi3aDwrbn6aW
	 5KogAcgzmnN8A==
Received: from MBP-von-Lukas.fritz.box (p5dd100e0.dip0.t-ipconnect.de [93.209.0.224])
	by dd44826.kasserver.com (Postfix) with ESMTPSA id 485DDB6E01B7;
	Wed, 16 Apr 2025 23:36:41 +0200 (CEST)
From: Lukas Fischer <kernel@o1oo11oo.de>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Lukas Fischer <kernel@o1oo11oo.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [RFC PATCH] lsm: Add Rust bindings with example LSM
Date: Wed, 16 Apr 2025 23:32:04 +0200
Message-ID: <20250416213206.26060-2-kernel@o1oo11oo.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++

These are the bare necessities to implement an LSM in Rust. They are in
an early WIP state intended to gather feedback, mainly for the use of
unsafe.

The LSM is implemented in security/rust_lsm/lsm.rs and uses the bindings
to the C side directly to set itself up. This is of course not
production ready, but enough to set up a minimal example of an LSM.

The `lsm_info` struct technically needs to be aligned to
`size_of::<kernel::ffi::c_ulong>()`, but Rust does not allow this in
combination with `repr(transparent)`. So far this works, but it seems
brittle.

To limit the scope of the implementation, the example and bindings only
cover the `file_permission` hook.

Signed-off-by: Lukas Fischer <kernel@o1oo11oo.de>
---
As part of my master's thesis, I am developing a Rust-based LSM. These
are the bindings I have created for that, so that I can register and
implement an LSM in Rust.

At the moment, the bindings are a pretty direct C to Rust translation
and only allow registering a single LSM. Because of this, they are part
of the example LSM code and not the `kernel` crate. During my thesis I
will unfortunately not have the time to polish them enough to be
upstreamable, and since there is likely no user for them, upstreaming
seems unlikely in the first place.

To me it seems like Rust bindings usually involve a trait or struct
defined for the abstraction, so that the lifetime of the struct can be
tied to the data/object/hardware it represents (please correct me on
this). For LSMs, which are loaded once duing boot and cannot be
unloaded, this seems not as relevent to me, but for consistency the
final bindings should probably look similar to other existing ones.

The intent of sending the bindings is to gather feedback on the current
implementation, mainly whether my use of unsafe is correct. Kind of as a
review, but more as a sanity check.

I have previously asked about Rust-based LSMs and about this RFC in the
Rust for Linux Zulip [1][2].

Thanks,
Lukas

[1]: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/Rust-based.20LSMs
[2]: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/.22Review.22.20of.20LSM.20bindings
---
 include/linux/lsm_count.h         |   9 +-
 include/uapi/linux/lsm.h          |   1 +
 rust/bindings/bindings_helper.h   |   1 +
 scripts/generate_rust_analyzer.py |   2 +-
 security/Kconfig                  |   1 +
 security/Makefile                 |   1 +
 security/rust_lsm/Kconfig         |  10 ++
 security/rust_lsm/Makefile        |   4 +
 security/rust_lsm/bindings.rs     | 161 ++++++++++++++++++++++++++++++
 security/rust_lsm/lsm.rs          |  33 ++++++
 10 files changed, 221 insertions(+), 2 deletions(-)
 create mode 100644 security/rust_lsm/Kconfig
 create mode 100644 security/rust_lsm/Makefile
 create mode 100644 security/rust_lsm/bindings.rs
 create mode 100644 security/rust_lsm/lsm.rs

diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
index 16eb49761b25..e6cc2f6d6f0c 100644
--- a/include/linux/lsm_count.h
+++ b/include/linux/lsm_count.h
@@ -102,6 +102,12 @@
 #define IPE_ENABLED
 #endif
 
+#if IS_ENABLED(CONFIG_SECURITY_RUST_LSM)
+#define RUST_LSM_ENABLED 1,
+#else
+#define RUST_LSM_ENABLED
+#endif
+
 /*
  *  There is a trailing comma that we need to be accounted for. This is done by
  *  using a skipped argument in __COUNT_LSMS
@@ -124,7 +130,8 @@
 		LANDLOCK_ENABLED	\
 		IMA_ENABLED		\
 		EVM_ENABLED		\
-		IPE_ENABLED)
+		IPE_ENABLED		\
+		RUST_LSM_ENABLED)
 
 #else
 
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index 938593dfd5da..938f7694e6ed 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -65,6 +65,7 @@ struct lsm_ctx {
 #define LSM_ID_IMA		111
 #define LSM_ID_EVM		112
 #define LSM_ID_IPE		113
+#define LSM_ID_RUST_LSM		114
 
 /*
  * LSM_ATTR_XXX definitions identify different LSM attributes
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ab37e1d35c70..f941a1caf141 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -21,6 +21,7 @@
 #include <linux/fs.h>
 #include <linux/jiffies.h>
 #include <linux/jump_label.h>
+#include <linux/lsm_hooks.h>
 #include <linux/mdio.h>
 #include <linux/miscdevice.h>
 #include <linux/of_device.h>
diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index cd41bc906fbd..204bc144a0ab 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -144,7 +144,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     # Then, the rest outside of `rust/`.
     #
     # We explicitly mention the top-level folders we want to cover.
-    extra_dirs = map(lambda dir: srctree / dir, ("samples", "drivers"))
+    extra_dirs = map(lambda dir: srctree / dir, ("samples", "drivers", "security"))
     if external_src is not None:
         extra_dirs = [external_src]
     for folder in extra_dirs:
diff --git a/security/Kconfig b/security/Kconfig
index 4816fc74f81e..7f8707e7f80b 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -230,6 +230,7 @@ source "security/safesetid/Kconfig"
 source "security/lockdown/Kconfig"
 source "security/landlock/Kconfig"
 source "security/ipe/Kconfig"
+source "security/rust_lsm/Kconfig"
 
 source "security/integrity/Kconfig"
 
diff --git a/security/Makefile b/security/Makefile
index 22ff4c8bd8ce..ba482f051511 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
 obj-$(CONFIG_BPF_LSM)			+= bpf/
 obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
 obj-$(CONFIG_SECURITY_IPE)		+= ipe/
+obj-$(CONFIG_SECURITY_RUST_LSM)		+= rust_lsm/
 
 # Object integrity file lists
 obj-$(CONFIG_INTEGRITY)			+= integrity/
diff --git a/security/rust_lsm/Kconfig b/security/rust_lsm/Kconfig
new file mode 100644
index 000000000000..d3e8bc2907f2
--- /dev/null
+++ b/security/rust_lsm/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config SECURITY_RUST_LSM
+	bool "Rust example LSM Support"
+	depends on RUST && SECURITY
+	default n
+	help
+	  Enable the Rust example LSM.
+
+	  If you are unsure how to answer this question, answer N.
diff --git a/security/rust_lsm/Makefile b/security/rust_lsm/Makefile
new file mode 100644
index 000000000000..14b651a82ca6
--- /dev/null
+++ b/security/rust_lsm/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+ccflags-y += -I$(src)			# needed for trace events
+
+obj-$(CONFIG_SECURITY_RUST_LSM)		+= lsm.o
diff --git a/security/rust_lsm/bindings.rs b/security/rust_lsm/bindings.rs
new file mode 100644
index 000000000000..d69ccc4187ed
--- /dev/null
+++ b/security/rust_lsm/bindings.rs
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Bindings for Rust example LSM.
+//!
+//! Implements the bare necessities to implement an LSM in Rust and register it, using the bindings
+//! to C. Long term this should move to the kernel crate, but since these bindings are currently
+//! specific to a single LSM, instead of allowing arbitrary LSMs to get registered, they live here
+//! for now.
+
+use kernel::{bindings, c_str, ffi::*, fs::LocalFile, prelude::*, types::Opaque};
+
+/// The name the LSM gets registered under.
+const NAME: &CStr = c_str!("rust_lsm");
+
+/// The amount of hooks that get registered by this LSM.
+///
+/// This could be automatically calculated from the length of the array, but would then still need
+/// to manually be adjusted there. Having it as a separate constant simplifies access for calling
+/// [`security_add_hooks`] though.
+///
+/// This value is `usize` so that it can be used in the array directly, but [`security_add_hooks`]
+/// requires `i32`, which is why [`SECURITY_HOOK_LIST_COUNT`] exists.
+///
+/// [`security_add_hooks`]: bindings::security_add_hooks
+const SECURITY_HOOK_LIST_LEN: usize = 1;
+
+/// The amount of hooks that get registered by this LSM.
+///
+/// This time as `i32`, because that's what [`security_add_hooks`] requires. Const-converting this
+/// makes sure an overflow results in a compiler error, although having that many hooks is unlikely.
+///
+/// [`security_add_hooks`]: bindings::security_add_hooks
+const SECURITY_HOOK_LIST_COUNT: i32 = {
+    // Manually implement i32::try_from(...).unwrap() here because it is not const
+    if SECURITY_HOOK_LIST_LEN > (i32::MAX as usize) {
+        panic!("Cannot register more than i32::MAX LSM hooks!")
+    } else {
+        SECURITY_HOOK_LIST_LEN as i32
+    }
+};
+
+/// Wrapper to be able to use `lsm_id` in a static context.
+#[repr(transparent)]
+struct LsmId(Opaque<bindings::lsm_id>);
+
+// SAFETY: There is only a static instance and in that one the pointer field points to an immutable
+// C string.
+unsafe impl Sync for LsmId {}
+
+/// Wrapper to be able to use `lsm_info` in a static context.
+// Needs to be aligned to `size_of::<kernel::ffi::c_ulong>()`, but Rust attributes cannot express
+// this and even statically setting it to 8 cannot be combined with `repr(transparent)`.
+#[repr(transparent)]
+struct LsmInfo(Opaque<bindings::lsm_info>);
+
+// SAFETY: There is only a static instance and in that one the pointer fields point to an immutable
+// C string and the init function defined here.
+unsafe impl Sync for LsmInfo {}
+
+/// Wrapper to be able to use `security_hook_list` in a static context.
+///
+/// This is `Opaque<[...]>` instead of `[Opaque<...>]` because it simplifies the call to
+/// [`bindings::security_add_hooks`] a lot.
+#[repr(transparent)]
+struct SecurityHookList(Opaque<[bindings::security_hook_list; SECURITY_HOOK_LIST_LEN]>);
+
+// SAFETY: There is only a static instance, which is only modified from C during LSM initialization
+// using the interior mutability of `Opaque`.
+unsafe impl Sync for SecurityHookList {}
+
+/// Static information about the LSM.
+static LSM_ID: LsmId = LsmId(Opaque::new(bindings::lsm_id {
+    name: NAME.as_char_ptr(),
+    id: bindings::LSM_ID_RUST_LSM as _,
+}));
+
+/// Register the LSM in the kernel.
+///
+/// This is achieved by placing it in the `.lsm_info.init` linker section.
+///
+/// Everything but `name` and `init` is optional, but [`Default::default()`] cannot be used in a
+/// const context.
+#[used]
+#[link_section = ".lsm_info.init"]
+static LSM_INFO: LsmInfo = LsmInfo(Opaque::new(bindings::lsm_info {
+    name: NAME.as_char_ptr(),
+    init: Some(init),
+    order: bindings::lsm_order_LSM_ORDER_MUTABLE,
+    flags: 0,
+    enabled: core::ptr::null_mut(),
+    blobs: core::ptr::null_mut(),
+}));
+
+/// List of hooks to register callbacks for.
+///
+/// The data stored here is updated by the LSM code during LSM initialization using the interior
+/// mutability of [`Opaque`].
+#[used]
+#[link_section = ".data..ro_after_init"]
+static HOOKS: SecurityHookList = SecurityHookList(Opaque::new([bindings::security_hook_list {
+    // SAFETY: Creates an unaligned pointer to the mutable static since the
+    // `static_calls_table` is `repr(packed)`. The pointers are only used
+    // from C code.
+    scalls: unsafe { &raw mut bindings::static_calls_table.file_permission }.cast(),
+    hook: bindings::security_list_options {
+        file_permission: Some(file_permission),
+    },
+    lsmid: LSM_ID.0.get(),
+}]));
+
+/// Init function for the LSM
+///
+/// Gets called from the C side through the pointer stored in [`LSM_INFO`].
+///
+/// # Safety
+///
+/// This function must only be called once from the C LSM initialization code.
+#[link_section = ".init.text"]
+unsafe extern "C" fn init() -> c_int {
+    pr_info!("Rust example LSM is starting...\n");
+
+    // Register the hooks
+    // SAFETY: FFI call to register the hooks for the LSM. All pointers point to statics which are
+    // only accessed from this init and are therefore valid for the call. The hook list is modified
+    // using the interior mutability of `Opaque`.
+    unsafe {
+        bindings::security_add_hooks(
+            HOOKS.0.get().cast(),
+            SECURITY_HOOK_LIST_COUNT,
+            LSM_ID.0.get(),
+        );
+    }
+
+    // Call the Rust side init function for further initialization
+    if let Err(e) = super::init() {
+        return e.to_errno();
+    }
+
+    pr_info!("Rust example LSM is initialized!\n");
+
+    0
+}
+
+/// Callback for the `file_permission` hook.
+///
+/// This gets called every time an already opened file is read or written.
+///
+/// # Safety
+///
+/// May only be called by the LSM framework as `file_permission` hook with a file pointer valid for
+/// the duration of the call.
+unsafe extern "C" fn file_permission(file: *mut bindings::file, mask: c_int) -> c_int {
+    // SAFETY: `file` is valid for the duration of this call
+    let file = unsafe { LocalFile::from_raw_file(file) };
+
+    match super::file_permission(file, mask) {
+        Ok(true) => 0,
+        Ok(false) => EPERM.to_errno(),
+        Err(e) => e.to_errno(),
+    }
+}
diff --git a/security/rust_lsm/lsm.rs b/security/rust_lsm/lsm.rs
new file mode 100644
index 000000000000..9ac777d5a168
--- /dev/null
+++ b/security/rust_lsm/lsm.rs
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust example LSM.
+//!
+//! Rust-based example LSM to demonstrate an initial version of bindings to C.
+
+mod bindings;
+
+use kernel::{fs::LocalFile, prelude::*};
+
+/// Prefix to appear before log messages printed from within this crate.
+const __LOG_PREFIX: &[u8] = b"rust_lsm\0";
+
+/// LSM init function.
+///
+/// Called exactly once from `init()` in [`bindings`] when the LSM is registered.
+fn init() -> Result {
+    // Custom init logic could go here
+    Ok(())
+}
+
+/// `file_permission` hook implementation.
+///
+/// Gets called for every file access that needs to be checked.
+fn file_permission(_file: &LocalFile, _mask: i32) -> Result<bool> {
+    // Arbitrary policy logic could go here
+    let resolution = true;
+
+    // Uncomment this for lots of spam in dmesg
+    // pr_info!("file_permission hook called");
+
+    Ok(resolution)
+}

base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
-- 
2.49.0

