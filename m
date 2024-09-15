Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1F11C9EDB
	for <linux-security-module@vger.kernel.org>; Sun, 15 Sep 2024 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726410718; cv=none; b=fHtbbAsbBwXC5OH+gWWY4o3w/VxbmVaiKzKAqELr6Bso6DJRGj1/FF88/hG5eSsqPBSkGGiYzx3U4cf0sw32Tw3QBFLgIi+RxuDV+5olCdfLIBLZg4gy65R8w2Uyo4lKioTgzuMRH1aL0Gm8hYewWCEn19zMdEW9ta3zOiR5CjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726410718; c=relaxed/simple;
	bh=/bhxtkSWHddRRHFAN7ilQCw+DOk04+8fISK58//Qtwg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uJRPzigkNcpPMlhr7bg7LDBjU0ve2DpX9j0xOYm0S3o0zInvxqs9Y6eorZBdhXZbQRCBe6AOvF0u3wnkebk6WqP2Lmfyq6JZcma4S2USrHDWfaa2/7Kc/LksNq6enOFhSsl/RMJLBfdnWuWQiZAnklaiI99UcHOw+MCRpA4UWIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vs1dnjdS; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vs1dnjdS"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-69a0536b23aso110069017b3.3
        for <linux-security-module@vger.kernel.org>; Sun, 15 Sep 2024 07:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726410716; x=1727015516; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=di//Gho9LFvKMRY5a1n6309m9s0BrxpbnPkhPUuDJj8=;
        b=vs1dnjdSmq0U9sQ6kb4YzuTFcxbSec9IhoGTeHkroo3OSZfQPZ8Ln7ODiciz+o4ItP
         wWmnhXwifZdu5LOnQmuCVqQI5V2HIoNv5SLivWCcEfbBp7Gvul3VBTxK7qwSRs1wZzBk
         CBowbB/NLp+yjwBaKkJXZM2xBmrOiMMxDcVDcWtSdngnPs1+VPGkN19ReGSbOsdiDO+c
         vc9FfhoI8YQZBWN8Rcb4ekYRY0LiLIFVduz8wVMCglqPk52hxi0HHS391/g2vtkrujJh
         zeAZFpl6pEk8RJf/xatGEcGhGdpra35lalpkzIG2Qe2lRVtmQqLA1MdYHoNiwGDuQCRK
         jLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726410716; x=1727015516;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=di//Gho9LFvKMRY5a1n6309m9s0BrxpbnPkhPUuDJj8=;
        b=O/nn1LJ2ToxYn+B3czu3X06CfsQV3VWP0LQJcTUxJ4Dc56qrPNB0dlIsGJ52/lLRZX
         PKPc0b08EtGIAzuFUeSpUf2YJ1HDa1QQhuZLSJpolJ8DBYNSYLgak0rvnSEEHZymZQL8
         vZ5VHb4qSmk8QogmYmtWPoXiwOzbNyYfTEFi4sM1CWoW9O3sPf6Eta4ZD2pkx0Odjxid
         j3GUNUOdqBP3NkBY0Pu6gBmkh2bfh5beE9OGP4o18VkMEZTFLSBbgaLmKEYJPdDQlWmI
         F1bTMtLlIn/WO2etqqUAXr04vpc85++MGfBsRa+uZBhUgZwkN8joId0eHz9xvUf0xzh2
         yGvg==
X-Forwarded-Encrypted: i=1; AJvYcCUn5EyAhP/u56k5BAHZN60DArSJOLQqLwVftihExbi5mlfHxxVyN/pZj9ftcsCfrFhi+7CJOlVhdqPz163ayP1yE/KmNxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRPo3DJzx2lXDXzsMDqOaN5+UvGj/MDZYU9ZHLn/VrxCEf4AWj
	0TzpNS+gYqazUaQazu3glHG1nB3b1NNnqDfuXIYPPNnzIGRcsb/mkTy42R7y9/mYBbMs+0/3dtN
	fJhKD73kYeZDMkg==
X-Google-Smtp-Source: AGHT+IEqlJxhhgtl0WBF7hObPiWjQTUHQogWXSYtK0XmWW8HuhrSb0S1tCc/N2MSYjTsOMRd6dJrCxOBAsMkGxQ=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:201b:b0:650:a16c:91ac with SMTP
 id 00721157ae682-6dbb6bb973amr6339087b3.8.1726410715744; Sun, 15 Sep 2024
 07:31:55 -0700 (PDT)
Date: Sun, 15 Sep 2024 14:31:34 +0000
In-Reply-To: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7280; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=/bhxtkSWHddRRHFAN7ilQCw+DOk04+8fISK58//Qtwg=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm5u/FBSvbkR7slpTehWQOty+m7zbQ9LMW+MoUh
 7o6gHEbB/mJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZubvxQAKCRAEWL7uWMY5
 RkhLD/4i1Eo+PbWN3iXaWA3DOMC6LIYxC6mgd+Jv+qT/dG6AWMh684o0Slyi5rY0yygGtUuBjsK
 d62bBrWsXMZdAOZp1Qp0YodOcc1VbfqkgBWVLQemhfTvklq3TsA0mzEWtwqWzLt5o70FhnNCV15
 NYEX0yKcNBw9Bj46xfWt/5ps7WdoTSKolRFu3c4pN1hUOMetj9DmK+B/pvwDXsrGJrsSPz+2uD2
 /qe21/Ai3W05KpKThpgE1psdOk5bvRZLn4ITWOoE88P0Wo8i3wsHd6WH5nnzPOyJemlAl5K3uVT
 nUkPvHYsz9SgHJZ9+7JhUxfku7FXA3vta7UT0PcFeIjmH/vCDokvvGDZifY9teEvMru5ZGXMTHo
 ZTuNvovSSlJ4PdsGgK0Z+aa2p84X8cwr/RcN/WrmOZ18So1fUA7wGUS9Wyxsaeslwy8o2MsF5Dr
 1cn6I3DKTHPB6ZO/Fe+3MWANfhl0xMxVzLBzih1ZQ+e49vhEW5AFfZYGAm8VnMSX1HdzbIweSEz
 h6h+MpbxuZYJJ7fKX85Kvi0qxoOfM4ilSGy1/zUaIiyMGe61vbv/JVvvtXydvDa566YcJcQv/7l
 SsVgKgS8gXR3KXExFknkGpsW+yfeG7m/W0q31Sif8fachxL4ryPBqIBoYVQnJ/zcLp7z+Pt/bxn wq/HzPM9DwjYDGQ==
X-Mailer: b4 0.13.0
Message-ID: <20240915-alice-file-v10-8-88484f7a3dcf@google.com>
Subject: [PATCH v10 8/8] rust: file: add abstraction for `poll_table`
From: Alice Ryhl <aliceryhl@google.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="utf-8"

The existing `CondVar` abstraction is a wrapper around
`wait_queue_head`, but it does not support all use-cases of the C
`wait_queue_head` type. To be specific, a `CondVar` cannot be registered
with a `struct poll_table`. This limitation has the advantage that you
do not need to call `synchronize_rcu` when destroying a `CondVar`.

However, we need the ability to register a `poll_table` with a
`wait_queue_head` in Rust Binder. To enable this, introduce a type
called `PollCondVar`, which is like `CondVar` except that you can
register a `poll_table`. We also introduce `PollTable`, which is a safe
wrapper around `poll_table` that is intended to be used with
`PollCondVar`.

The destructor of `PollCondVar` unconditionally calls `synchronize_rcu`
to ensure that the removal of epoll waiters has fully completed before
the `wait_queue_head` is destroyed.

That said, `synchronize_rcu` is rather expensive and is not needed in
all cases: If we have never registered a `poll_table` with the
`wait_queue_head`, then we don't need to call `synchronize_rcu`. (And
this is a common case in Binder - not all processes use Binder with
epoll.) The current implementation does not account for this, but if we
find that it is necessary to improve this, a future patch could store a
boolean next to the `wait_queue_head` to keep track of whether a
`poll_table` has ever been registered.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/sync.rs             |   1 +
 rust/kernel/sync/poll.rs        | 121 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index e854ccddecee..ca13659ded4c 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -20,6 +20,7 @@
 #include <linux/mdio.h>
 #include <linux/phy.h>
 #include <linux/pid_namespace.h>
+#include <linux/poll.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/security.h>
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 0ab20975a3b5..bae4a5179c72 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -11,6 +11,7 @@
 mod condvar;
 pub mod lock;
 mod locked_by;
+pub mod poll;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
new file mode 100644
index 000000000000..d5f17153b424
--- /dev/null
+++ b/rust/kernel/sync/poll.rs
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Utilities for working with `struct poll_table`.
+
+use crate::{
+    bindings,
+    fs::File,
+    prelude::*,
+    sync::{CondVar, LockClassKey},
+    types::Opaque,
+};
+use core::ops::Deref;
+
+/// Creates a [`PollCondVar`] initialiser with the given name and a newly-created lock class.
+#[macro_export]
+macro_rules! new_poll_condvar {
+    ($($name:literal)?) => {
+        $crate::sync::poll::PollCondVar::new(
+            $crate::optional_name!($($name)?), $crate::static_lock_class!()
+        )
+    };
+}
+
+/// Wraps the kernel's `struct poll_table`.
+///
+/// # Invariants
+///
+/// This struct contains a valid `struct poll_table`.
+///
+/// For a `struct poll_table` to be valid, its `_qproc` function must follow the safety
+/// requirements of `_qproc` functions:
+///
+/// * The `_qproc` function is given permission to enqueue a waiter to the provided `poll_table`
+///   during the call. Once the waiter is removed and an rcu grace period has passed, it must no
+///   longer access the `wait_queue_head`.
+#[repr(transparent)]
+pub struct PollTable(Opaque<bindings::poll_table>);
+
+impl PollTable {
+    /// Creates a reference to a [`PollTable`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that for the duration of 'a, the pointer will point at a valid poll
+    /// table (as defined in the type invariants).
+    ///
+    /// The caller must also ensure that the `poll_table` is only accessed via the returned
+    /// reference for the duration of 'a.
+    pub unsafe fn from_ptr<'a>(ptr: *mut bindings::poll_table) -> &'a mut PollTable {
+        // SAFETY: The safety requirements guarantee the validity of the dereference, while the
+        // `PollTable` type being transparent makes the cast ok.
+        unsafe { &mut *ptr.cast() }
+    }
+
+    fn get_qproc(&self) -> bindings::poll_queue_proc {
+        let ptr = self.0.get();
+        // SAFETY: The `ptr` is valid because it originates from a reference, and the `_qproc`
+        // field is not modified concurrently with this call since we have an immutable reference.
+        unsafe { (*ptr)._qproc }
+    }
+
+    /// Register this [`PollTable`] with the provided [`PollCondVar`], so that it can be notified
+    /// using the condition variable.
+    pub fn register_wait(&mut self, file: &File, cv: &PollCondVar) {
+        if let Some(qproc) = self.get_qproc() {
+            // SAFETY: The pointers to `file` and `self` need to be valid for the duration of this
+            // call to `qproc`, which they are because they are references.
+            //
+            // The `cv.wait_queue_head` pointer must be valid until an rcu grace period after the
+            // waiter is removed. The `PollCondVar` is pinned, so before `cv.wait_queue_head` can
+            // be destroyed, the destructor must run. That destructor first removes all waiters,
+            // and then waits for an rcu grace period. Therefore, `cv.wait_queue_head` is valid for
+            // long enough.
+            unsafe { qproc(file.as_ptr() as _, cv.wait_queue_head.get(), self.0.get()) };
+        }
+    }
+}
+
+/// A wrapper around [`CondVar`] that makes it usable with [`PollTable`].
+///
+/// [`CondVar`]: crate::sync::CondVar
+#[pin_data(PinnedDrop)]
+pub struct PollCondVar {
+    #[pin]
+    inner: CondVar,
+}
+
+impl PollCondVar {
+    /// Constructs a new condvar initialiser.
+    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
+        pin_init!(Self {
+            inner <- CondVar::new(name, key),
+        })
+    }
+}
+
+// Make the `CondVar` methods callable on `PollCondVar`.
+impl Deref for PollCondVar {
+    type Target = CondVar;
+
+    fn deref(&self) -> &CondVar {
+        &self.inner
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for PollCondVar {
+    fn drop(self: Pin<&mut Self>) {
+        // Clear anything registered using `register_wait`.
+        //
+        // SAFETY: The pointer points at a valid `wait_queue_head`.
+        unsafe { bindings::__wake_up_pollfree(self.inner.wait_queue_head.get()) };
+
+        // Wait for epoll items to be properly removed.
+        //
+        // SAFETY: Just an FFI call.
+        unsafe { bindings::synchronize_rcu() };
+    }
+}

-- 
2.46.0.662.g92d0881bb0-goog

