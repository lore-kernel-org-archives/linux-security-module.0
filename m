Received: from a3-23.smtp-out.eu-west-1.amazonses.com (a3-23.smtp-out.eu-west-1.amazonses.com [54.240.3.23])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB0B32B9A1;
	Wed, 11 Mar 2026 05:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.3.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773205752; cv=none; b=XOPw8hkcmsDDcvlP6ZKtu1kI4sdcENMcGOu3Tj6PeO5OW0Uu+mgdYdzMV4gnt2cZG186Dkh53CJ7CnipeBGhbVuROPEgxynNZT0I86zN+woejA4DGJWfv4w+ZtvZnXaqmPlkW0tSPl589ZrKSOykeOkbgQgugxacUPPr8S+8COY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773205752; c=relaxed/simple;
	bh=azuJOiTFDarHvvsmG8dvNnvY3fvU5gr0QMnlhRqa8yo=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=h09LDNJdPF9DhwbgFsCo9UyILzDBmv/uG7rmZ4hosHCMp4sAoqCC8hMt47lEJZfHH6VpMr4T7Srq5x5veX/hJuSybHZtNn2un1TWX5gxEVqNVRYfsWg01hBe/7F8c2dQPz8xB1C9v2VHRjkWe9U6V3+NIzI65icecAFBVXQ75aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matrixforgelabs.com; spf=pass smtp.mailfrom=send.matrixforgelabs.com; dkim=pass (1024-bit key) header.d=matrixforgelabs.com header.i=@matrixforgelabs.com header.b=ABct2kkL; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=j61UuB+2; arc=none smtp.client-ip=54.240.3.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matrixforgelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.matrixforgelabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=matrixforgelabs.com header.i=@matrixforgelabs.com header.b="ABct2kkL";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="j61UuB+2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=matrixforgelabs.com; t=1773205746;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=azuJOiTFDarHvvsmG8dvNnvY3fvU5gr0QMnlhRqa8yo=;
	b=ABct2kkLRl32n1mesibHkEpKGE46o3vLbAZtQJ8PAxGzVcGpJEwGxYdt9SV4AmMK
	SiqrdLMBY4/CgKPdNIQsJPo/ZaSGMilTRvI1/dLMb0Skj247eEEfQqPGevV014ZXnxJ
	Y/lKUofq8ZZ8wEuNUxEFjmonCOQZwgB71InXPUBY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1773205746;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=azuJOiTFDarHvvsmG8dvNnvY3fvU5gr0QMnlhRqa8yo=;
	b=j61UuB+28bma5hQwFcYoAvb1KKi11yIRT2hcAnan2e+KgodlzlhwvxSngKDE9GLS
	Tcs1Yd0064kgNvsAM/S1k8GS/WvqHLtKBmHyDnC1QwD5rofSeewQ3Cf29RRN3TU3q4R
	DFg3k3N107tmzuSJbc9Tes/aIvPcPgmnFODoQXSE=
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311050854.657422-1-jamie@matrixforgelabs.com>
References: <20260311050854.657422-1-jamie@matrixforgelabs.com>
From: Jamie Lindsey <jamie@matrixforgelabs.com>
To: rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: ojeda@kernel.org, paul@paul-moore.com, aliceryhl@google.com, 
	jmorris@namei.org, serge@hallyn.com, jamie@matrixforgelabs.com
Subject: [PATCH v2 3/5] rust: kernel: add LSM abstraction layer
Message-ID: <0102019cdb4c705e-7d46b4f3-5cbb-4a6a-b315-e10f182fa987-000000@eu-west-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Mar 2026 05:09:05 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.eu-west-1.dUvNRtpqGVRXeo8wh60CXsl7GQehaaQ6nnrtD0cVQa3Ql6wtvHFwU/L0ElxknTtyiIJqbukn1OjAm5wWeKC4/L/mSl4kXjXWbCD+H4nPl2leK4flNX+koNzOtq4VJ309U1FPreISQBpCbnqANIVuwUyneL8ocSNAtI9Qxd/4vCM=:1.eu-west-1.xc5b6Z4+0WlftYwtQHAHsTtsfYdZQImSOXWypZD9BdY=:AmazonSES
X-SES-Outgoing: 2026.03.11-54.240.3.23

Introduce kernel::lsm, a safe Rust interface for writing Linux Security
Modules:

- Hooks trait: one method per LSM hook, all defaulting to no-op =
allow.
  Sync + Send + 'static bounds are required because hooks may be =
called
  concurrently from any CPU.

- Adapter<T>: zero-cost monomorphised =
bridge converting unsafe extern "C"
  callbacks (required by the hook ABI) =
to safe Rust.  No vtable; each
  hook is a standalone function pointer.

- LsmId / LsmInfo: #[repr(transparent)] wrappers with unsafe impl Sync
  around lsm_id and lsm_info.  Both types contain *const c_char pointers
  to 'static string literals which are never mutated, making the Sync
  impl sound.

- define_lsm! macro: generates the static __LSM_ID, the =
MaybeUninit hook
  array __LSM_HOOKS, the __lsm_init() init function that =
fills hook slots
  via the C shims and calls security_add_hooks(), and the =
__LSM_INFO
  descriptor placed in .lsm_info.init so that security_init() =
discovers
  and calls the init function at boot.

The static mut =
__LSM_HOOKS array is intentionally mutable: it is written
exactly once by __lsm_init() in the single-threaded boot context before
security_add_hooks() copies the entries into the static-call table.  No
access occurs after that point.  UnsafeCell or a lock would add overhead
with no safety benefit in this init-only path.

Gated on CONFIG_SECURITY =
via #[cfg(CONFIG_SECURITY)] in lib.rs.

This is v1.  Planned follow-ups: =
SecurityBlob<T> for per-inode/per-task
state, proc-macro support for =
multiple concurrent Rust LSMs, and
additional hook wrappers as safe Rust =
types for their arguments land
upstream.

Assisted-by: =
Claude:claude-sonnet-4-6
Signed-off-by: Jamie Lindsey =
<jamie@matrixforgelabs.com>
---
 rust/kernel/lib.rs |   2 +
 rust/kernel/lsm.rs | 295 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 297 insertions(+)
 create mode 100644 rust/kernel/lsm.rs

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 3da92f18f4ee..af3e2416a581 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -112,6 +112,8 @@
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
 pub mod list;
+#[cfg(CONFIG_SECURITY)]
+pub mod lsm;
 pub mod maple_tree;
 pub mod miscdevice;
 pub mod mm;
diff --git a/rust/kernel/lsm.rs b/rust/kernel/lsm.rs
new file mode 100644
index 000000000000..bdd3ba4f72ba
--- /dev/null
+++ b/rust/kernel/lsm.rs
@@ -0,0 +1,295 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Linux Security Module (LSM) abstractions.
+//!
+//! This module provides safe Rust abstractions for implementing Linux =
Security
+//! Modules.  An LSM written in Rust implements the [`Hooks`] =
trait, then
+//! registers itself at boot time with the [`define_lsm!`] =
macro.
+//!
+//! # Minimal example
+//!
+//! ```no_run
+//! use kernel::lsm;
+//! use kernel::prelude::*;
+//!
+//! struct MyLsm;
+//!
+//! impl lsm::Hooks for MyLsm {
+//!     fn file_open(file: =
&kernel::fs::File) -> Result {
+//!         pr_info!("file_open: =
flags=3D{:#x}\n", file.flags());
+//!         Ok(())
+//!     }
+//! }
+//!
+//! kernel::define_lsm!(MyLsm, "my_lsm\0", bindings::LSM_ID_UNDEF as u64);
+//! ```
+//!
+//! C headers: [`include/linux/lsm_hooks.=
h`](srctree/include/linux/lsm_hooks.h),
+//!            =
[`include/linux/security.h`](srctree/include/linux/security.h)
+
+use crate::{bindings, fs::File, task::Task};
+use core::marker::PhantomDat=
a;
+use core::mem::MaybeUninit;
+
+/// Wrapper around [`bindings::lsm_id`] =
that implements [`Sync`].
+///
+/// `lsm_id` contains a `*const c_char` =
name pointer (not `Sync` by default).
+/// The pointer always points to a =
string literal in static storage and is
+/// never mutated after =
construction, so sharing across threads is safe.
+#[repr(transparent)]
+pub struct LsmId(pub bindings::lsm_id);
+
+// SAFETY: `lsm_id` holds only =
a static string pointer and a numeric ID.
+// Both are immutable after =
construction.
+unsafe impl Sync for LsmId {}
+
+/// Wrapper around =
[`bindings::lsm_info`] that implements [`Sync`].
+///
+/// `lsm_info` contains several raw pointer fields.  All are set to static
+/// addresses during `define_lsm!` macro expansion and are never mutated
+/// after that, so sharing across threads is safe.
+#[repr(transparent)]
+pub struct LsmInfo(pub bindings::lsm_info);
+
+// SAFETY: `lsm_info` is =
initialised once (at compile time via const fn)
+// with pointers to static=
 data, then placed in `.lsm_info.init` as a
+// read-only descriptor.
+unsafe impl Sync for LsmInfo {}
+
+/// The trait that a Rust LSM must =
implement.
+///
+/// Each method corresponds to a kernel LSM hook.  Methods=
 have default
+/// no-op implementations so you only need to override the =
hooks you care
+/// about.
+///
+/// # Safety contract for implementors
+///
+/// All methods are called from kernel context and may be called =
concurrently.
+/// Implementors must ensure their implementations are:
+///
+/// - **Thread-safe** =E2=80=94 multiple CPUs may call the same hook =
simultaneously.
+/// - **Non-sleeping where required** =E2=80=94 =
[`Hooks::task_free`] runs in a context
+///   that must not sleep; see its =
documentation.
+///
+/// The `Sync + Send + 'static` bounds enforce these =
requirements at the
+/// type level.
+pub trait Hooks: Sync + Send + =
'static {
+    /// Called when a file is being opened.
+    ///
+    /// Return `Ok(())` to allow the open, or an `Err` to deny it.
+    /// Common denial codes: [`EACCES`](crate::error::code::EACCES),
+    /// [`EPERM`](crate::error::code::EPERM).
+    fn file_open(_file: =
&File) -> crate::error::Result {
+        Ok(())
+    }
+
+    /// Called when a new task (thread or process) is being created.
+    ///
+    /// `clone_flags` contains the `CLONE_*` flags passed to =
`clone(2)`.
+    ///
+    /// Return `Ok(())` to allow creation, or an =
`Err` to deny it.
+    fn task_alloc(_task: &Task, _clone_flags: u64) -> =
crate::error::Result {
+        Ok(())
+    }
+
+    /// Called when a task=
 is being freed.
+    ///
+    /// This hook runs during task teardown.  =
**Must not sleep.**  Any
+    /// per-task state stored in a security blob =
should be cleaned up here.
+    fn task_free(_task: &Task) {}
+}
+
+/// C-callable adapter functions that bridge the LSM framework to =
[`Hooks`].
+///
+/// This type is never instantiated.  Its associated =
functions serve as the
+/// `unsafe extern "C" fn` pointers registered with=
 the kernel's LSM
+/// static-call infrastructure.
+///
+/// # Invariants
+///
+/// Each adapter function is called only from the LSM framework in =
the
+/// appropriate hook context, with valid, non-null pointer arguments.
+#[doc(hidden)]
+pub struct Adapter<T: Hooks>(PhantomData<T>);
+
+impl<T: Hooks> Adapter<T> {
+    /// Adapter for the `file_open` LSM hook.
+    ///
+    /// # Safety
+    ///
+    /// `file` must be a valid, =
non-null pointer to a `struct file` that
+    /// remains valid for the =
duration of this call.  Called only by the
+    /// LSM framework.
+    pub unsafe extern "C" fn file_open(
+        file: *mut bindings::file=
,
+    ) -> core::ffi::c_int {
+        // SAFETY: The LSM framework =
guarantees `file` is valid and non-null
+        // for the duration of =
this call.
+        let file_ref =3D unsafe { File::from_raw_file(file.=
cast_const()) };
+        match T::file_open(file_ref) {
+            Ok(()) =3D> 0,
+            Err(e) =3D> e.to_errno(),
+        }
+    }
+
+    /// Adapter for the `task_alloc` LSM hook.
+    ///
+    /// # Safety
+    ///
+    /// `task` must be a valid, =
non-null pointer to a newly-allocated
+    /// `task_struct`.  =
`clone_flags` are the flags passed to `clone(2)`.
+    /// Called only by =
the LSM framework.
+    pub unsafe extern "C" fn task_alloc(
+        task: *mut bindings::task_struct,
+        clone_flags: u64,
+    ) -> core::ffi::c_int {
+        // SAFETY: The LSM framework =
guarantees `task` is valid, non-null,
+        // and exclusively owned by =
the framework for the duration of this
+        // call.  `Task` is =
`#[repr(transparent)]` over
+        // `Opaque<task_struct>`, which is =
`#[repr(transparent)]` over
+        // `UnsafeCell<MaybeUninit<task_struct=
>>`, giving the same layout.
+        let task_ref =3D unsafe { &*(task as =
*const Task) };
+        match T::task_alloc(task_ref, clone_flags) {
+            Ok(()) =3D> 0,
+            Err(e) =3D> e.to_errno(),
+        }
+    }
+
+    /// Adapter for the `task_free` LSM hook.
+    ///
+    /// # Safety
+    ///
+    /// `task` must be a valid, non-null =
pointer to a `task_struct` that
+    /// is being freed.  Must not sleep.  =
Called only by the LSM framework.
+    pub unsafe extern "C" fn =
task_free(task: *mut bindings::task_struct) {
+        // SAFETY: Same =
layout argument as `task_alloc`.
+        let task_ref =3D unsafe { &*(task=
 as *const Task) };
+        T::task_free(task_ref);
+    }
+}
+
+/// Constructs a [`bindings::lsm_info`] value for use by [`define_lsm!`].
+///
+/// All fields not explicitly set are zero-initialised, which the =
kernel
+/// interprets as:
+/// - `order`: `LSM_ORDER_MUTABLE` (0)
+/// - `flags`: none
+/// - `blobs`: no security blobs requested
+/// - `enabled`: use the default (always enabled)
+/// - `initcall_*`: no =
additional initcalls
+///
+/// # Safety
+///
+/// - `id` must point to a =
`lsm_id` with `'static` lifetime.
+/// - `init` must be a valid init =
function called once during `security_init()`.
+#[doc(hidden)]
+pub const unsafe fn new_lsm_info(
+    id: *const bindings::lsm_id,
+    init: Option<unsafe extern "C" fn() -> core::ffi::c_int>,
+) -> LsmInfo {
+    // SAFETY: `bindings::lsm_info` is a C struct.  =
Zero-initialisation
+    // gives valid zero/null values for every optional=
 field.  The caller
+    // is responsible for providing a valid `id` and =
`init`.
+    let mut info: bindings::lsm_info =3D
+        unsafe { =
MaybeUninit::zeroed().assume_init() };
+    info.id =3D id;
+    info.init =3D init;
+    LsmInfo(info)
+}
+
+/// Registers a Rust LSM =
implementation with the kernel at boot time.
+///
+/// # Usage
+///
+/// ```no_run
+/// kernel::define_lsm!(MyLsmType, "my_lsm\0", =
bindings::LSM_ID_UNDEF as u64);
+/// ```
+///
+/// The macro generates:
+/// - A `static lsm_id` identifying this LSM to the kernel.
+/// - A static array of `security_hook_list` entries (initialised via C =
shims
+///   to avoid `__randomize_layout` pitfalls).
+/// - An `unsafe extern "C"` init function that populates the hook list =
and
+///   calls `security_add_hooks()`.
+/// - A `static lsm_info` placed =
in the `.lsm_info.init` linker section so
+///   the kernel discovers and =
calls the init function during `security_init()`.
+///
+/// # Limitations (v1)
+///
+/// - Only the `file_open`, `task_alloc`, and=
 `task_free` hooks are registered.
+///   Additional hooks will be added in=
 follow-up patches as safe Rust wrappers
+///   for the argument types are =
contributed upstream.
+/// - At most one Rust LSM can be registered per =
kernel build.  Unique name
+///   generation for multiple LSMs requires a =
proc-macro (planned for v2).
+#[macro_export]
+macro_rules! define_lsm {
+    ($T:ty, $name:expr, $id:expr) =3D> {
+        mod =
__rust_lsm_registration {
+            use super::*;
+
+            // The LSM identity =E2=80=94 must be 'static because the =
static-call
+            // table holds a back-pointer to it via =
security_hook_list.lsmid.
+            // LsmId wraps lsm_id with `unsafe =
impl Sync` so it can be `static`.
+            static __LSM_ID: =
$crate::lsm::LsmId =3D
+                $crate::lsm::LsmId($crate::bindings=
::lsm_id {
+                    name: $name.as_ptr().cast(),
+                    id: $id,
+                });
+
+            // The hook list array.  MaybeUninit avoids needing =
security_hook_list
+            // to implement a const-initialiser; the C =
shims fill each slot in
+            // __lsm_init() below before any hook =
can fire.
+            //
+            // SAFETY: This array must be =
'static =E2=80=94 the static-call table holds
+            // back-pointers=
 (scall->hl) into it after registration.
+            static mut =
__LSM_HOOKS: [
+                ::core::mem::MaybeUninit<$crate::bindings::=
security_hook_list>;
+                3
+            ] =3D =
[::core::mem::MaybeUninit::zeroed(); 3];
+
+            // The init =
function stored in lsm_info.init.  Called once by
+            // =
security_init() in single-threaded boot context.
+            unsafe extern=
 "C" fn __lsm_init() -> ::core::ffi::c_int {
+                // SAFETY: =
Called once, single-threaded, during security_init().
+                // __LSM_HOOKS is exclusively owned here.
+                unsafe {
+                    // bindgen strips the =
rust_helper_ prefix from helper names.
+                    =
$crate::bindings::lsm_hook_init_file_open(
+                        =
__LSM_HOOKS[0].as_mut_ptr(),
+                        =
Some($crate::lsm::Adapter::<$T>::file_open),
+                    );
+                    $crate::bindings::lsm_hook_init_task_alloc(
+                        __LSM_HOOKS[1].as_mut_ptr(),
+                        Some($crate::lsm::Adapter::<$T>::task_alloc),
+                    );
+                    $crate::bindings::lsm_hook_ini=
t_task_free(
+                        __LSM_HOOKS[2].as_mut_ptr(),
+                        Some($crate::lsm::Adapter::<$T>::task_free),
+                    );
+                    $crate::bindings::security_add=
_hooks(
+                        __LSM_HOOKS[0].as_mut_ptr(),
+                        __LSM_HOOKS.len() as ::core::ffi::c_int,
+                        &raw const __LSM_ID.0,
+                    );
+                }
+                0
+            }
+
+            // The lsm_info descriptor placed in the .lsm_info.init ELF =
section.
+            // The kernel's security_init() iterates this section=
 to discover and
+            // call the init function of every =
compiled-in LSM.
+            // LsmInfo wraps lsm_info with `unsafe impl =
Sync` so it can be `static`.
+            #[used]
+            =
#[link_section =3D ".lsm_info.init"]
+            static __LSM_INFO: =
$crate::lsm::LsmInfo =3D {
+                // SAFETY: __LSM_ID and =
__lsm_init have 'static lifetime.
+                unsafe {
+                    $crate::lsm::new_lsm_info(
+                        =
&raw const __LSM_ID.0,
+                        Some(__lsm_init),
+                    )
+                }
+            };
+        }
+    };
+}
--=20
2.53.0

