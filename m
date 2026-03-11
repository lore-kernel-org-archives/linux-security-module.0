Received: from a3-28.smtp-out.eu-west-1.amazonses.com (a3-28.smtp-out.eu-west-1.amazonses.com [54.240.3.28])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BB32C158D;
	Wed, 11 Mar 2026 04:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.3.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773204976; cv=none; b=dpmPhEXsQ6K/6NIgKTUnaZ1jrBDj7iQxtyQ1JeztJUpXqydBSX7XLOrkWOWvAybRPYFSefye4My8gxvhXUDv5l0MiYDncD3w1pyxCXPQv3gPb1ZAkqy8Q9BiEEak63DublWnVb3Ija3mDcm2CG2mFcYFCyx9cajV4XUo2blV9H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773204976; c=relaxed/simple;
	bh=Gqg5Qhj8JS/T7wfrlt3GyeRgs7DBS7gGr1w378O78zQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Duh6XzgYpvPF5XNxBLj1wcrpDRg0C72Ux0wyQX4L/mgefR48dJLl1kRxjIVokJFdkSYinfSq5YRJozrkybAbsytuAv3G5p15HyofySZYU2JggRdTdmX4fy72fHc9MsZKBLVWFKXom0Q6QaMsS9lyjhsEXis9fRte9nza8a2hhVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matrixforgelabs.com; spf=pass smtp.mailfrom=send.matrixforgelabs.com; dkim=pass (1024-bit key) header.d=matrixforgelabs.com header.i=@matrixforgelabs.com header.b=R2Bsom6K; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=qUB5SGRq; arc=none smtp.client-ip=54.240.3.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matrixforgelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.matrixforgelabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=matrixforgelabs.com header.i=@matrixforgelabs.com header.b="R2Bsom6K";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="qUB5SGRq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=matrixforgelabs.com; t=1773204973;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=Gqg5Qhj8JS/T7wfrlt3GyeRgs7DBS7gGr1w378O78zQ=;
	b=R2Bsom6KT68eSG8OJz46Hmf8O/a1iGxj+Cjlv8L4cR+q0Cq1x9QHvpZ+aUfaJVkF
	Rnvm34atAIUQ5Fg3PO+6quGJLFFGK0c+hEmM8O/UUHPF7CMsgoP18e0pojYrj0xRft8
	22fw6VrO/nfhxy2NtH3QCvi66R/WXCf2APuXyFgk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1773204973;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=Gqg5Qhj8JS/T7wfrlt3GyeRgs7DBS7gGr1w378O78zQ=;
	b=qUB5SGRqFnfVYb4uVMbPdEBQ30ugC3J9pIIQXmLxtcDUO781BO6PVoeUdtYbd1Ma
	byeWlEarYY9xq/NXqvslSxuKZ89DuLPb2G6RjqLfXBWHJiopwLrDl2449X3QKCqVMWc
	llbvea38zh85M8XT1gKiAZtolFZ1lTmCV9rFnKJw=
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311045601.649904-1-jamie@matrixforgelabs.com>
References: <20260311045601.649904-1-jamie@matrixforgelabs.com>
From: Jamie Lindsey <jamie@matrixforgelabs.com>
To: rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: ojeda@kernel.org, paul@paul-moore.com, aliceryhl@google.com, 
	jmorris@namei.org, serge@hallyn.com, jamie@matrixforgelabs.com
Subject: [PATCH 5/5] Documentation: rust: add LSM abstraction guide; update
 MAINTAINERS
Message-ID: <0102019cdb40a774-6ac6a066-4b38-4254-8a30-eadcbd3866dc-000000@eu-west-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Mar 2026 04:56:13 +0000
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

