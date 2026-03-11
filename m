Received: from a3-28.smtp-out.eu-west-1.amazonses.com (a3-28.smtp-out.eu-west-1.amazonses.com [54.240.3.28])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC581F2B88;
	Wed, 11 Mar 2026 05:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.3.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773205751; cv=none; b=ZDsuxfaGVT7cn66sgMgBmMcqwowsYF2m82OZ4W68es6IirBTcO21zMevcxy9jhotihm2M/hi55kr3InIyq0M8Wy0vcLYcqeLVeffLFhdw9acstCLXly58fGvNC4XTM2nILWlTp/iyr4Oyj4iR8+VfT5mdvTbzsYBcQCkUrztTbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773205751; c=relaxed/simple;
	bh=nVS/fcfCpFvJwlauSngury6CQxF6yc7+y7jxjnfPaZM=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=onU2iBUAuJyXhJ3rzxPrZGG4Y+rnKuLbLhIGHjA8Jgqgl1sVzE05aJpYx6tpoDzjKbqJNhYmJdc3FLtvfmT5DAirmFxfg8/009W5DCs9BkF9Q52hv8h17JyANIpzn7/ZUFtyGzRzya4nxkjGx/pUEL4Kzk4s9JYEvwcrMbuANwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matrixforgelabs.com; spf=pass smtp.mailfrom=send.matrixforgelabs.com; dkim=pass (1024-bit key) header.d=matrixforgelabs.com header.i=@matrixforgelabs.com header.b=oJFsyI6p; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=WnS68wON; arc=none smtp.client-ip=54.240.3.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matrixforgelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.matrixforgelabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=matrixforgelabs.com header.i=@matrixforgelabs.com header.b="oJFsyI6p";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="WnS68wON"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=matrixforgelabs.com; t=1773205748;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=nVS/fcfCpFvJwlauSngury6CQxF6yc7+y7jxjnfPaZM=;
	b=oJFsyI6pHlDPk1dYEQEteXW5wEAzrxCjjrwoJtLrrR9ik7OpsI0XRzFc/blR9BnL
	f3ADFyc1Pthh32KzIAczTb5W2whcchzoXlHl4o/DzHhdc88Yw9W9vzXZfk8uL4dXaXZ
	rQAP4OGzE+U0w/LpRiykrSDG50ejqXDe5LBKz9gA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1773205748;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=nVS/fcfCpFvJwlauSngury6CQxF6yc7+y7jxjnfPaZM=;
	b=WnS68wONzw7dOIQ6Ip/aTuO94VnWpbChA2Lxrc6MvTCrw/FJ7tv+q/NWWqrEejT/
	0R8F55k52CZD2fSOIWZDW/f+y00mdy2M7G8MNFXZz1Sb+wKWQsIFwVAPFr4J9cV6+Q5
	6rjCqtT0sAThIpvZxWxp+i0RdoBtyLYNch95DIfo=
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311050854.657422-1-jamie@matrixforgelabs.com>
References: <20260311050854.657422-1-jamie@matrixforgelabs.com>
From: Jamie Lindsey <jamie@matrixforgelabs.com>
To: rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: ojeda@kernel.org, paul@paul-moore.com, aliceryhl@google.com, 
	jmorris@namei.org, serge@hallyn.com, jamie@matrixforgelabs.com
Subject: [PATCH v2 5/5] Documentation: rust: add LSM abstraction guide;
 update MAINTAINERS
Message-ID: <0102019cdb4c7bbc-579d77fe-47b3-4bd0-ac5d-f677a6e0054c-000000@eu-west-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Mar 2026 05:09:08 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.eu-west-1.dUvNRtpqGVRXeo8wh60CXsl7GQehaaQ6nnrtD0cVQa3Ql6wtvHFwU/L0ElxknTtyiIJqbukn1OjAm5wWeKC4/L/mSl4kXjXWbCD+H4nPl2leK4flNX+koNzOtq4VJ309U1FPreISQBpCbnqANIVuwUyneL8ocSNAtI9Qxd/4vCM=:1.eu-west-1.xc5b6Z4+0WlftYwtQHAHsTtsfYdZQImSOXWypZD9BdY=:AmazonSES
X-SES-Outgoing: 2026.03.11-54.240.3.28

Add Documentation/rust/lsm.rst, a developer guide for writing Linux
Security Modules in Rust using the kernel::lsm abstraction layer.

Covers:
- The Hooks trait: per-hook semantics, return values, sleeping rules.
- The define_lsm! macro: arguments and what it generates.
- Kconfig and Makefile wiring patterns.
- lsm_count.h: how to update =
MAX_LSM_COUNT for new built-in LSMs.
- A complete minimal example.
- Boot activation via lsm=3D and CONFIG_LSM.
- v1 limitations (three hooks,=
 one Rust LSM per build, no blob support).
- C headers of interest for LSM =
authors.

Link the new document from Documentation/rust/index.rst.

Add a MAINTAINERS entry (RUST LSM ABSTRACTIONS) covering:
  rust/helpers/lsm.c, rust/kernel/lsm.rs, security/rust_lsm/
Listed on both rust-for-linux@vger.kernel.org and
linux-security-module@vge=
r.kernel.org.

Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Jamie Lindsey <jamie@matrixforgelabs.com>
---
 Documentation/rust/index.rst |   1 +
 Documentation/rust/lsm.rst   | 246 =
+++++++++++++++++++++++++++++++++++
 MAINTAINERS                  |   9 ++
 3 files changed, 256 insertions(+)
 create mode 100644 =
Documentation/rust/lsm.rst

diff --git a/Documentation/rust/index.rst =
b/Documentation/rust/index.rst
index b78ed0efa784..a4cb4bf8faf2 100644
--- a/Documentation/rust/index.rst
+++ b/Documentation/rust/index.rst
@@ -37,6 +37,7 @@ more details.
     coding-guidelines
     arch-support
     testing
+    lsm
=20
 You can also find learning materials for Rust in=
 its section in
 :doc:`../process/kernel-docs`.
diff --git =
a/Documentation/rust/lsm.rst b/Documentation/rust/lsm.rst
new file mode 100644
index 000000000000..c4e16e7d2be5
--- /dev/null
+++ b/Documentation/rust/lsm.rst
@@ -0,0 +1,246 @@
+.. =
SPDX-License-Identifier: GPL-2.0
+
+Linux Security Modules in Rust
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
+
+This document describes how to write a Linux =
Security Module (LSM) using
+the Rust abstractions provided in =
``rust/kernel/lsm.rs``.
+
+
+Overview
+--------
+
+The LSM framework allows=
 security policies to be implemented as kernel
+modules that register hooks=
 into security-sensitive operations.  Traditionally
+these are written in C; the Rust abstraction layer provides a safe,
+trait-based interface that enforces correct hook registration at compile =
time.
+
+A Rust LSM:
+
+1. Implements the :ref:`Hooks trait =
<rust_lsm_hooks_trait>` for the subset
+   of hooks it cares about.
+2. Registers itself at boot time using the :ref:`define_lsm! macro
+   <rust_lsm_define_macro>`.
+
+No C code is required by the LSM author.  =
The abstraction layer generates
+the necessary C-callable adapter functions=
 and places the ``lsm_info``
+descriptor in the ``.lsm_info.init`` ELF =
section, where
+``security_init()`` discovers it during boot.
+
+
+.. _rust_lsm_hooks_trait:
+
+The ``Hooks`` trait
+-------------------
+
+``kernel::lsm::Hooks`` is the central trait.  Each method corresponds to =
one
+LSM hook.  All methods have a default no-op implementation, so an =
implementor
+only needs to override the hooks it cares about::
+
+    pub trait Hooks: Sync + Send + 'static {
+        fn file_open(_file: =
&File) -> Result { Ok(()) }
+        fn task_alloc(_task: &Task, =
_clone_flags: u64) -> Result { Ok(()) }
+        fn task_free(_task: &Task)=
 {}
+    }
+
+The ``Sync + Send + 'static`` bounds are required because =
hook functions may
+be called concurrently from any CPU.
+
+Return values
+~~~~~~~~~~~~~
+
+Hooks that can deny an operation return =
``kernel::error::Result``:
+
+- ``Ok(())`` =E2=80=94 allow the operation.
+- ``Err(e)`` =E2=80=94 deny the operation; ``e.to_errno()`` is returned to=
 the caller.
+
+Common denial error codes:
+
+- ``EACCES`` =E2=80=94 =
permission denied (policy decision).
+- ``EPERM`` =E2=80=94 operation not =
permitted (capability check).
+
+The ``task_free`` hook cannot deny =
anything and has no return value.
+
+Sleeping
+~~~~~~~~
+
+``task_free`` is called in a non-sleeping context.  Implementations **must
+not** sleep or allocate memory with ``GFP_KERNEL`` inside ``task_free``.
+All other hooks may sleep unless the call site is documented otherwise.
+
+
+Available hooks (v1)
+~~~~~~~~~~~~~~~~~~~~~
+
+.. list-table::
+   :widths: 25 75
+   :header-rows: 1
+
+   * - Hook
+     - When called
+   * - ``file_open``
+     - A file is being opened.  Return ``Err`` to =
deny the open.
+   * - ``task_alloc``
+     - A new task (thread or =
process) is being created via ``clone(2)``
+       or ``fork(2)``.  =
``clone_flags`` contains the ``CLONE_*`` flags.
+       Return ``Err`` to =
deny creation.
+   * - ``task_free``
+     - A task is being freed.  Must =
not sleep.  Use this to clean up any
+       per-task state associated with=
 the LSM.
+
+
+.. _rust_lsm_define_macro:
+
+The ``define_lsm!`` macro
+--------------------------
+
+``kernel::define_lsm!`` registers a type =
implementing ``Hooks`` with the
+kernel LSM framework::
+
+    kernel::define_lsm!(MyLsmType, "my_lsm\0", bindings::LSM_ID_UNDEF as =
u64);
+
+Arguments:
+
+.. list-table::
+   :widths: 20 80
+   :header-rows: 1
+
+   * - Argument
+     - Description
+   * - ``$T``
+     - The type implementing ``Hooks``.  Must be ``Sync + Send + 'static``=
.
+   * - ``$name``
+     - A ``&str`` literal with a NUL terminator =
(``\0``).  This name is used
+       in ``/sys/kernel/security/lsm`` and in=
 the ``lsm=3D`` kernel command-line
+       parameter.
+   * - ``$id``
+     - The LSM identity constant from ``include/uapi/linux/lsm.h``.  Use
+       ``bindings::LSM_ID_UNDEF as u64`` during development; request a
+       permanent value as part of the upstream patch series.
+
+The macro generates:
+
+- A ``static __LSM_ID: LsmId`` holding the LSM =
identity.
+- A ``static mut __LSM_HOOKS`` array of ``MaybeUninit<security_h=
ook_list>``
+  entries, one per registered hook.
+- An ``unsafe extern "C" =
fn __lsm_init()`` that fills each hook slot using
+  the C =
``LSM_HOOK_INIT`` shim (necessary because ``security_hook_list`` has
+  ``__randomize_layout``) and calls ``security_add_hooks()``.
+- A ``static __LSM_INFO: LsmInfo`` in the ``.lsm_info.init`` ELF section,
+  which ``security_init()`` iterates at boot to discover and call the init
+  function.
+
+
+Enabling in Kconfig
+-------------------
+
+To include a Rust LSM in the build, add a ``Kconfig`` entry that selects
+``RUST`` and depends on ``SECURITY``::
+
+    config SECURITY_MY_LSM
+        bool "My Rust LSM"
+        depends on SECURITY
+        select RUST
+        help
+          A minimal Rust LSM that ...
+
+Wire the object into the build in ``security/Makefile``::
+
+    obj-$(CONFIG_SECURITY_MY_LSM) +=3D my_lsm/
+
+And in =
``security/my_lsm/Makefile``::
+
+    obj-$(CONFIG_SECURITY_MY_LSM) +=3D =
my_lsm.o
+
+The source file must **not** declare ``#![no_std]`` =E2=80=94 =
the build system injects
+it automatically for all kernel Rust objects.
+
+Define ``__LOG_PREFIX`` at the top of the source file so that ``pr_info!``=
 and
+friends work correctly::
+
+    const __LOG_PREFIX: &[u8] =3D =
b"my_lsm\0";
+
+
+Minimal example
+---------------
+
+The following is a complete, minimal Rust LSM that logs every file open =
and
+allows all operations::
+
+    // SPDX-License-Identifier: GPL-2.0
+
+    //! Minimal Rust LSM example.
+
+    const __LOG_PREFIX: &[u8] =3D =
b"my_lsm\0";
+
+    use kernel::bindings;
+    use kernel::lsm;
+    use kernel::prelude::*;
+
+    struct MyLsm;
+
+    impl lsm::Hooks for MyLsm {
+        fn file_open(file: =
&kernel::fs::File) -> Result {
+            pr_info!("file_open: =
flags=3D{:#x}\n", file.flags());
+            Ok(())
+        }
+    }
+
+    kernel::define_lsm!(MyLsm, "my_lsm\0", bindings::LSM_ID_UNDEF as u64);
+
+The reference implementation is at ``security/rust_lsm/rust_lsm.rs``
+(``CONFIG_SECURITY_RUST_LSM``).
+
+
+Activating at boot
+------------------
+
+A Rust LSM compiled into the kernel is activated by =
listing its name in the
+``lsm=3D`` kernel command-line parameter or by =
adding it to the ``CONFIG_LSM``
+Kconfig string.
+
+The LSM name must also =
be counted in ``include/linux/lsm_count.h`` so that
+``MAX_LSM_COUNT`` is large enough to accommodate it alongside other =
compiled-in
+LSMs.  Add a ``CONFIG_SECURITY_MY_LSM``-guarded macro =
alongside the existing
+entries::
+
+    #ifdef CONFIG_SECURITY_MY_LSM
+    #define MY_LSM_ENABLED 1,
+    #else
+    #define MY_LSM_ENABLED
+    #endif
+
+    #define MAX_LSM_COUNT \
+        COUNT_LSMS( \
+            ...existing entries... \
+            MY_LSM_ENABLED)
+
+To verify the LSM is active after boot::
+
+    cat =
/sys/kernel/security/lsm
+
+
+Limitations (v1)
+-----------------
+
+- Only three hooks are available: ``file_open``, ``task_alloc``, and
+  ``task_free``.  Additional hooks will be added in follow-up patches as =
safe
+  Rust wrappers for their argument types are contributed upstream.
+
+- At most one Rust LSM can be registered per kernel build with the current
+  macro design.  Supporting multiple Rust LSMs requires unique static =
symbol
+  generation, planned for v2 using a proc-macro.
+
+- No security blob support.  Per-task or per-inode data associated with a
+  Rust LSM requires the ``SecurityBlob<T>`` abstraction planned for v2.
+
+
+C headers of interest
+---------------------
+
+- =
``include/linux/lsm_hooks.h`` =E2=80=94 ``lsm_info``, =
``security_hook_list``,
+  ``LSM_HOOK_INIT``, ``LSM_ORDER_*``.
+- ``include/linux/lsm_hook_defs.h`` =E2=80=94 canonical hook signatures.
+- ``include/uapi/linux/lsm.h`` =E2=80=94 ``LSM_ID_*`` constants.
+- ``include/linux/lsm_count.h`` =E2=80=94 ``MAX_LSM_COUNT`` computation.
+- ``security/security.c`` =E2=80=94 ``security_init()``, =
``security_add_hooks()``.
diff --git a/MAINTAINERS b/MAINTAINERS
index 89007f9ed35e..a23f5a15e038 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23196,6 +23196,15 @@ S:	Maintained
 T:	git https://github.=
com/Rust-for-Linux/linux.git rust-analyzer-next
 F:	=
scripts/generate_rust_analyzer.py
=20
+RUST LSM ABSTRACTIONS
+M:	Jamie Lindsey <jamie@matrixforgelabs.com>
+L:	rust-for-linux@vger.=
kernel.org
+L:	linux-security-module@vger.kernel.org
+S:	Maintained
+F:	rust/helpers/lsm.c
+F:	rust/kernel/lsm.rs
+F:	security/rust_lsm/
+
 RXRPC SOCKETS (AF_RXRPC)
 M:	David Howells <dhowells@redhat.com>
 M:	Marc Dionne <marc.dionne@auristor.com>
--=20
2.53.0

