Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EEF1C9EAF
	for <linux-security-module@vger.kernel.org>; Sun, 15 Sep 2024 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726410716; cv=none; b=Y4byt5WxFF1DIj00wYzka8+xHvomv/oOF5AaPiI22StDEmITN9L+tkmItvzZZkh0HT+n8EOcpIbBzQuYLJxke79YzitHFpAFuvVhyZFpX6pOpMHXQcvezdn74ZxY5hpuJuyJecr+ONwdm3Jxo2NB7Z9Z3AC9pRr080Ot8zOm/qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726410716; c=relaxed/simple;
	bh=XIbkrjlkZwB9EP6Wqa6JTDOm/egSkUncn5mejxybfIo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oMBsQth+yDMAn6KRO88mDwRsU8Mt5AEZY9XUuPxCqG6xICqDeTdBdWcrnxh9H5USrXBzgto4nTRD5ABs2YqAYS144scipIU3hHfQj99Rj7NPyj0BzuGQF5DHIBOy7VJAZYQR6t9q1I8bOvvL6z5LxawDEZjT0gJ2VXf0gHJpUjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xNyBKMnL; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xNyBKMnL"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-374b9a8512dso2035440f8f.2
        for <linux-security-module@vger.kernel.org>; Sun, 15 Sep 2024 07:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726410713; x=1727015513; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x3SAZaQh7JMcKUvYE72Oqp+2UamZ4Jcb61cfVgkJJck=;
        b=xNyBKMnLhaD0xgCjU+jRq3XVRqkAxufvYq2+fllF/ODPHQE4UNUvbZgoU7/6LAE4uq
         Dqj4C1ZT/uW5dBlHbM+MKt51vsBbWRvTbylLXTBlpMc/MDkrv9IdjaWuADiqtNNAVAB0
         kGzMLSY42jl9SjWl/c6duNcZW74gGv3BZj/CivvL/vs1tPh97oGse5aZtjU+SDya65SA
         jsD5GLE0/QAOK1bOAB1P7Z067MefUvegs+YuaQHxeEJfSY5ODeSiyRm00ps194dyeBcL
         PKBZ8V4He7Supmct2sMPV/o2PthJCu8CMIKQ4g1uAmaFWBNu+H5NmabukabPSy0aoMQq
         vaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726410713; x=1727015513;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3SAZaQh7JMcKUvYE72Oqp+2UamZ4Jcb61cfVgkJJck=;
        b=t49ZT46WD7gn5A0KfV/2IRESk0QagZfk3fc+5orJWas2g+TDLiylVH14EIEqgBIcac
         HC0zNMfyk5X/QWHsqP6d6EGWqzZ+5R5HJ78oNP1KOvIwgm78BEUJGgs3V0ZJ11YOWfGY
         gekDzKBAJmgz+kdpz/7KgFJ2VERkL+t/3LrltKj4QOPscrV0HuEX0lG0hwyxIXweb0WY
         EDTHNLGfaafnglvZ3PF9IMQF0swZ/DJ2vSofjpQrT+FfkdIl+K9JHXs65EpXF/l45ERe
         49UWsh6mKeg/0DTLyaTJaGbm2HNZlVVxorzLCNGO79VwN0Iv6Mys2apErDVftdb1QnFT
         OyOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiKJxVW60UYgdZDNgB24UkdFr5g4Ui6P5jkA98lM3MbfMWrRQGOVvovqmC+0/51ZJvAmKUCQV4th5hKd45UEnLuCEcf8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMjQa0GSabZ/T+Hyph6tPQXd0sNAzaWZ1NfKT5xuZTm2wBUwjz
	WkCNNX/KncDy0yKV7JnRVnzg3lnfPsy2GVpf/XOFVtxQM5RCDDdkmf4+E2xKobfwdfHQZ7AJC0S
	VFldrTbclVy7XZA==
X-Google-Smtp-Source: AGHT+IGh2qvqT9yXKclHWWOXEWRXTNi/Ki/Hd1UaIOcNMCJ8X7DHDKNewGBgY5S0zaQfKvWokouq8hf51NPhJ9w=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:adf:e891:0:b0:374:bd06:7ea3 with SMTP id
 ffacd0b85a97d-378c2cd0301mr14084f8f.2.1726410712932; Sun, 15 Sep 2024
 07:31:52 -0700 (PDT)
Date: Sun, 15 Sep 2024 14:31:33 +0000
In-Reply-To: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7372; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=XIbkrjlkZwB9EP6Wqa6JTDOm/egSkUncn5mejxybfIo=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm5u/ELyHzU5PzBtNaIT472HnRdM+VdLVcDjxZI
 BuOFdbjtFCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZubvxAAKCRAEWL7uWMY5
 RhidD/0cdx3m5xZ/MXSpSebPSRSUseL7+ieVKT5MrkTThOpAeHW0pXj1HjzaF7gUY4oSjwXnSM1
 CchwUx1AuBs90fPfU7dfStAt33OXkJgdQurxMy1zXo7+nCLqc3FNaZVvf/9GwxabggrZe8iNkrx
 EkGIKiofFO3/yAu8r+cDd4llboFf509NJoTHV6L9d8ZvPpEa6ak5TvVASPrduKAKksPuSgrDuee
 qkSECfi/vKPySJ7R6PYTzdcwnMfJjR9HAU5brqTHe7zML/hBUbVyAYo5T92pZd3I15gHcX3saYR
 8Dw8v8NgZzGVZtz/hR4S4oRBgo04i7M4rjnjkYjGOQtS0Qo6UQdxGyEeKiI20Xb5h5N8OhnYo/D
 sfOlpVVlX7sQIjHkXHdNA+UPTFKAvpyFKUUgqJplOijU9D9GNMEdqpSucrhVoO9hTt2DWKXnaaX
 /bi4WxCxUAgfsB6ZXgh7N6x0qZXuj+6r2ujcbMgUW+88D/luhD5I2ILsG/wH3lmuwPUF4JqCmOK
 shKGtLSStu/G3SAJ+NHYaR+7sO/0P/nS84PQ9t0C7p+q+ubf9atzV9IX6P1mxbGDxF1lZV5zlgZ
 o2XR2oZeHgePzu/ZyYxFYSfY7iZyi6Y0ASYdnaDrCgW63f8EM6wxP+qYupbRblpJ+MSdFhupOky tXPqUpZz18tpVxA==
X-Mailer: b4 0.13.0
Message-ID: <20240915-alice-file-v10-7-88484f7a3dcf@google.com>
Subject: [PATCH v10 7/8] rust: file: add `Kuid` wrapper
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

Adds a wrapper around `kuid_t` called `Kuid`. This allows us to define
various operations on kuids such as equality and current_euid. It also
lets us provide conversions from kuid into userspace values.

Rust Binder needs these operations because it needs to compare kuids for
equality, and it needs to tell userspace about the pid and uid of
incoming transactions.

To read kuids from a `struct task_struct`, you must currently use
various #defines that perform the appropriate field access under an RCU
read lock. Currently, we do not have a Rust wrapper for rcu_read_lock,
which means that for this patch, there are two ways forward:

 1. Inline the methods into Rust code, and use __rcu_read_lock directly
    rather than the rcu_read_lock wrapper. This gives up lockdep for
    these usages of RCU.

 2. Wrap the various #defines in helpers and call the helpers from Rust.

This patch uses the second option. One possible disadvantage of the
second option is the possible introduction of speculation gadgets, but
as discussed in [1], the risk appears to be acceptable.

Of course, once a wrapper for rcu_read_lock is available, it is
preferable to use that over either of the two above approaches.

Link: https://lore.kernel.org/all/202312080947.674CD2DC7@keescook/ [1]
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/task.c             | 38 ++++++++++++++++++++++++
 rust/kernel/cred.rs             |  5 ++--
 rust/kernel/task.rs             | 66 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 51ec78c355c0..e854ccddecee 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -19,6 +19,7 @@
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
+#include <linux/pid_namespace.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/security.h>
diff --git a/rust/helpers/task.c b/rust/helpers/task.c
index 7ac789232d11..7d66487db831 100644
--- a/rust/helpers/task.c
+++ b/rust/helpers/task.c
@@ -17,3 +17,41 @@ void rust_helper_put_task_struct(struct task_struct *t)
 {
 	put_task_struct(t);
 }
+
+kuid_t rust_helper_task_uid(struct task_struct *task)
+{
+	return task_uid(task);
+}
+
+kuid_t rust_helper_task_euid(struct task_struct *task)
+{
+	return task_euid(task);
+}
+
+#ifndef CONFIG_USER_NS
+uid_t rust_helper_from_kuid(struct user_namespace *to, kuid_t uid)
+{
+	return from_kuid(to, uid);
+}
+#endif /* CONFIG_USER_NS */
+
+bool rust_helper_uid_eq(kuid_t left, kuid_t right)
+{
+	return uid_eq(left, right);
+}
+
+kuid_t rust_helper_current_euid(void)
+{
+	return current_euid();
+}
+
+struct user_namespace *rust_helper_current_user_ns(void)
+{
+	return current_user_ns();
+}
+
+pid_t rust_helper_task_tgid_nr_ns(struct task_struct *tsk,
+				  struct pid_namespace *ns)
+{
+	return task_tgid_nr_ns(tsk, ns);
+}
diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
index 92659649e932..81d67789b16f 100644
--- a/rust/kernel/cred.rs
+++ b/rust/kernel/cred.rs
@@ -10,6 +10,7 @@
 
 use crate::{
     bindings,
+    task::Kuid,
     types::{AlwaysRefCounted, Opaque},
 };
 
@@ -61,11 +62,11 @@ pub fn get_secid(&self) -> u32 {
     }
 
     /// Returns the effective UID of the given credential.
-    pub fn euid(&self) -> bindings::kuid_t {
+    pub fn euid(&self) -> Kuid {
         // SAFETY: By the type invariant, we know that `self.0` is valid. Furthermore, the `euid`
         // field of a credential is never changed after initialization, so there is no potential
         // for data races.
-        unsafe { (*self.0.get()).euid }
+        Kuid::from_raw(unsafe { (*self.0.get()).euid })
     }
 }
 
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 367b4bbddd9f..1a36a9f19368 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -9,6 +9,7 @@
     types::{NotThreadSafe, Opaque},
 };
 use core::{
+    cmp::{Eq, PartialEq},
     ffi::{c_int, c_long, c_uint},
     ops::Deref,
     ptr,
@@ -96,6 +97,12 @@ unsafe impl Sync for Task {}
 /// The type of process identifiers (PIDs).
 type Pid = bindings::pid_t;
 
+/// The type of user identifiers (UIDs).
+#[derive(Copy, Clone)]
+pub struct Kuid {
+    kuid: bindings::kuid_t,
+}
+
 impl Task {
     /// Returns a raw pointer to the current task.
     ///
@@ -157,12 +164,31 @@ pub fn pid(&self) -> Pid {
         unsafe { *ptr::addr_of!((*self.0.get()).pid) }
     }
 
+    /// Returns the UID of the given task.
+    pub fn uid(&self) -> Kuid {
+        // SAFETY: By the type invariant, we know that `self.0` is valid.
+        Kuid::from_raw(unsafe { bindings::task_uid(self.0.get()) })
+    }
+
+    /// Returns the effective UID of the given task.
+    pub fn euid(&self) -> Kuid {
+        // SAFETY: By the type invariant, we know that `self.0` is valid.
+        Kuid::from_raw(unsafe { bindings::task_euid(self.0.get()) })
+    }
+
     /// Determines whether the given task has pending signals.
     pub fn signal_pending(&self) -> bool {
         // SAFETY: By the type invariant, we know that `self.0` is valid.
         unsafe { bindings::signal_pending(self.0.get()) != 0 }
     }
 
+    /// Returns the given task's pid in the current pid namespace.
+    pub fn pid_in_current_ns(&self) -> Pid {
+        // SAFETY: We know that `self.0.get()` is valid by the type invariant, and passing a null
+        // pointer as the namespace is correct for using the current namespace.
+        unsafe { bindings::task_tgid_nr_ns(self.0.get(), ptr::null_mut()) }
+    }
+
     /// Wakes up the task.
     pub fn wake_up(&self) {
         // SAFETY: By the type invariant, we know that `self.0.get()` is non-null and valid.
@@ -184,3 +210,43 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
         unsafe { bindings::put_task_struct(obj.cast().as_ptr()) }
     }
 }
+
+impl Kuid {
+    /// Get the current euid.
+    #[inline]
+    pub fn current_euid() -> Kuid {
+        // SAFETY: Just an FFI call.
+        Self::from_raw(unsafe { bindings::current_euid() })
+    }
+
+    /// Create a `Kuid` given the raw C type.
+    #[inline]
+    pub fn from_raw(kuid: bindings::kuid_t) -> Self {
+        Self { kuid }
+    }
+
+    /// Turn this kuid into the raw C type.
+    #[inline]
+    pub fn into_raw(self) -> bindings::kuid_t {
+        self.kuid
+    }
+
+    /// Converts this kernel UID into a userspace UID.
+    ///
+    /// Uses the namespace of the current task.
+    #[inline]
+    pub fn into_uid_in_current_ns(self) -> bindings::uid_t {
+        // SAFETY: Just an FFI call.
+        unsafe { bindings::from_kuid(bindings::current_user_ns(), self.kuid) }
+    }
+}
+
+impl PartialEq for Kuid {
+    #[inline]
+    fn eq(&self, other: &Kuid) -> bool {
+        // SAFETY: Just an FFI call.
+        unsafe { bindings::uid_eq(self.kuid, other.kuid) }
+    }
+}
+
+impl Eq for Kuid {}

-- 
2.46.0.662.g92d0881bb0-goog

