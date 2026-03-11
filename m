Received: from a3-23.smtp-out.eu-west-1.amazonses.com (a3-23.smtp-out.eu-west-1.amazonses.com [54.240.3.23])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F58282F24;
	Wed, 11 Mar 2026 04:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.3.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773204970; cv=none; b=VP+FJJxN2k4gqKp18IAHI8WSpn6FfxfDz6TZzfraF+siv3CI0VUdZ8+EFhi/NdWKYYndl4XIxA5xtkxgaAdPldQ965nG2W86l7qe5bGvNHl+H6ZL+PJiBTSPkrDG0GSU+0b/uEuSpww0SZNNhR4SM4t51HNjG+qjc3OcgkxoqbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773204970; c=relaxed/simple;
	bh=CXMZKjj5/CRBnpXm7aarygwf9vcXoLqW1/qk3HMI4kk=;
	h=From:To:Cc:Subject:Message-ID:Date:MIME-Version:Content-Type; b=rxAu5/vb7g01DHCCFmOgX3+f9oljuhmmWtDvv0EH0wCtSkaupq+5E641jV9S/TtYO+wfJhyQAxCGihgKoLoSSzu/gIg7k7+npGo0xLWPTeXwY3cX6Y1c4WC3tACXNXAnwheitgWV9AS0EEK8K+2K2R7QrubhP4XgeVI6DnVnR8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matrixforgelabs.com; spf=pass smtp.mailfrom=send.matrixforgelabs.com; dkim=pass (1024-bit key) header.d=matrixforgelabs.com header.i=@matrixforgelabs.com header.b=CRvxNL72; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=mTVDlcVz; arc=none smtp.client-ip=54.240.3.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matrixforgelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.matrixforgelabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=matrixforgelabs.com header.i=@matrixforgelabs.com header.b="CRvxNL72";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="mTVDlcVz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=matrixforgelabs.com; t=1773204966;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=CXMZKjj5/CRBnpXm7aarygwf9vcXoLqW1/qk3HMI4kk=;
	b=CRvxNL72Wyv2xfnxFRcSgXxI2lRFn5fmV7EJPlcuHNb+f9HjitDAjQgd5WtUXzop
	DGkeM2P6EQNNyikszFMgRYHnZy2W7YtRRi5pkLpHzw3a5+Q7tNAE96cIi7+BAgRVZYV
	tj3gRk40UkSu7TjYN4sU1HTWUosY0vkamePI4pDY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1773204966;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=CXMZKjj5/CRBnpXm7aarygwf9vcXoLqW1/qk3HMI4kk=;
	b=mTVDlcVz1344e4pWBFbw7A9LZ/QlkctTYKiOayxMtBwYolWvBgnojUZ7bPzIi2q7
	dYdB0yclaoZzKW6yEThhHt2RsHlvVUFB5aMD3sP+Ix6C9dJLq0+K2G7yrte8ydgnuFG
	bRnr+X2o4EWqy9nstovRs7ssmqnmRUNnU0zwcn58=
X-Mailer: git-send-email 2.53.0
From: Jamie Lindsey <jamie@matrixforgelabs.com>
To: rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: ojeda@kernel.org, paul@paul-moore.com, aliceryhl@google.com, 
	jmorris@namei.org, serge@hallyn.com, jamie@matrixforgelabs.com
Subject: [PATCH 0/5] rust: lsm: introduce safe Rust abstractions for the
 LSM framework
Message-ID: <0102019cdb408ccc-1fa64b38-2e79-4a9c-b3a0-1ae5453230e8-000000@eu-west-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Mar 2026 04:56:06 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.eu-west-1.dUvNRtpqGVRXeo8wh60CXsl7GQehaaQ6nnrtD0cVQa3Ql6wtvHFwU/L0ElxknTtyiIJqbukn1OjAm5wWeKC4/L/mSl4kXjXWbCD+H4nPl2leK4flNX+koNzOtq4VJ309U1FPreISQBpCbnqANIVuwUyneL8ocSNAtI9Qxd/4vCM=:1.eu-west-1.xc5b6Z4+0WlftYwtQHAHsTtsfYdZQImSOXWypZD9BdY=:AmazonSES
X-SES-Outgoing: 2026.03.11-54.240.3.23

This series introduces the first safe Rust abstractions for the Linux
Security Module (LSM) framework.  It allows a complete, policy-enforcing
LSM to be written entirely in Rust with no C boilerplate required from
the LSM author.

--- Motivation ---

The LSM framework is a natural target =
for Rust: hook registration is
unsafe by nature (raw function pointers, C =
ABI, __randomize_layout on
the hook list struct), and the trait system can =
enforce correct
implementation at compile time.

--- Design ---

The abstraction is trait-based:

  impl kernel::lsm::Hooks for MyLsm {
      fn file_open(file: &File) -> Result { ... }
  }
  kernel::define_lsm!(MyLsm, "my_lsm\0", bindings::LSM_ID_UNDEF as u64);

The define_lsm! macro generates all the plumbing: the lsm_id, the hook
array, the __init function that calls security_add_hooks(), and the
lsm_info descriptor placed in .lsm_info.init so that security_init()
discovers it at boot.

Hook implementations receive safe Rust wrappers =
(&File, &Task) and
return kernel::error::Result.  The C-callable adapter =
functions are
monomorphised per LSM type -- no vtable, no runtime dispatch.

--- Implementation notes for reviewers ---

static mut __LSM_HOOKS:
  The hook array is static mut because it is written exactly once by
  __lsm_init() in the single-threaded boot context, before
  security_add_hooks() copies the entries into the static-call table.
  No access occurs after that point.  UnsafeCell or a lock would add
  overhead with no safety benefit in this strictly init-only path.

unsafe impl Sync on LsmId / LsmInfo:
  Both types are #[repr(transparent)] =
wrappers around lsm_id / lsm_info,
  which contain *const c_char pointers =
to 'static NUL-terminated string
  literals that are never mutated.  The =
Sync impl is sound for the same
  reason that &'static str is Sync.

MaybeUninit hook array:
  security_hook_list carries __randomize_layout.  =
Rust code cannot safely
  initialise it by field name (the field order =
after randomisation differs
  from what bindgen sees).  The array is left =
MaybeUninit and filled at
  runtime by C shims that call LSM_HOOK_INIT() --=
 the macro the kernel
  already uses for this purpose in C LSMs.

Function pointer types:
  All three hook signatures were verified against =
union security_list_options
  generated from lsm_hook_defs.h in this exact =
tree.  file_open:
  int(*)(struct file *); task_alloc: int(*)(struct =
task_struct *, u64)
  (u64, not unsigned long -- tree-specific); task_free:
  void(*)(struct task_struct *).  All match the C shim parameters exactly.

checkpatch note:
  checkpatch reports "Non-standard signature: Assisted-by"=
 and
  "Unrecognized email address: Claude:claude-sonnet-4-6".  The
  Assisted-by tag and its format are defined in
  Documentation/process/cod=
ing-assistants.rst; checkpatch has not yet
  been updated to recognise it. =
 This is a false positive.

--- Limitations (v1) ---

- Three hooks: file_open, task_alloc, task_free.  Additional hooks will
  be added in follow-up patches as safe Rust wrappers for their argument
  types are contributed upstream.
- At most one Rust LSM per kernel build =
(unique static symbol names
  require a proc-macro; planned for v2).
- No security blob support (SecurityBlob<T> planned for v2).

--- Testing ---

Compiled and boot-tested on Linux 7.0-rc2
(commit 4ae12d8bd9a8 "Merge tag 'kbuild-fixes-7.0-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux").

Boot verified: with lsm=3Drust_lsm_sample on the kernel command line,
/sys/kernel/security/lsm reports "capability,rust_lsm_sample" and
task_alloc hook invocations appear in dmesg.

--- Patch overview ---

  [1/5] rust: bindings: include lsm_hooks.h -- expose LSM types to bindgen
  [2/5] rust: helpers: C shims for LSM_HOOK_INIT and security_add_hooks
  [3/5] rust: kernel: lsm -- Hooks trait, Adapter<T>, define_lsm! macro
  [4/5] security: rust_lsm_sample -- reference implementation and boot test
  [5/5] Documentation: rust: lsm abstraction developer guide; MAINTAINERS

Jamie Lindsey (5):
  rust: bindings: include lsm_hooks.h to expose LSM =
types to bindgen
  rust: helpers: add C shims for LSM hook initialisation
  rust: kernel: add LSM abstraction layer
  security: add Rust LSM sample =
(CONFIG_SECURITY_RUST_LSM)
  Documentation: rust: add LSM abstraction =
guide; update MAINTAINERS

 Documentation/rust/index.rst    |   1 +
 Documentation/rust/lsm.rst      | 246 ++++++++++++++++++++++++++
 MAINTAINERS                     |   9 +
 rust/bindings/bindings_helper.h |=
   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/lsm.c        =
      |  49 ++++++
 rust/kernel/lib.rs              |   2 +
 rust/kernel/lsm.rs              | 295 ++++++++++++++++++++++++++++++++
 security/Kconfig                |   2 +
 security/Makefile               |=
   1 +
 security/rust_lsm/Kconfig       |  14 ++
 security/rust_lsm/Makefil=
e      |   2 +
 security/rust_lsm/rust_lsm.rs   |  66 +++++++
 13 files changed, 689 insertions(+)
 create mode 100644 =
Documentation/rust/lsm.rst
 create mode 100644 rust/helpers/lsm.c
 create mode 100644 rust/kernel/lsm.rs
 create mode 100644 =
security/rust_lsm/Kconfig
 create mode 100644 security/rust_lsm/Makefile
 create mode 100644 security/rust_lsm/rust_lsm.rs

--=20
2.53.0

