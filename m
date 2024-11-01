Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC1A1CDA15
	for <linux-security-module@vger.kernel.org>; Fri,  1 Nov 2024 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483346; cv=none; b=ltqL33Fh/7Qzjg1xkWph4BWVAI95UQ51ODIBx/gCOmMfcjnN/q62Ks2EZmyZa2nT3tijdJPzlKvIU/NtNotkzODKRWsNVU9hQCv2+Ryh0gwtO7jpiYzDAFS+7onVjKbDuohbf0R56ySnraNo4/GzElA1O5/dNxyU9i5CAGLQm3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483346; c=relaxed/simple;
	bh=MNq1vw75irUPKm3uNfACSw7+CS/AqwPLJNAX26gOUdA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Io1/+sbs0XKN7V4pDEYIyJPryAKkZwRvWxrSPeyo+IsddUdMm+/VXD3msvtRD/iS5s8vCjUcQUAXhzeuw0pFBbBxXnQge5DeUMP00FcPTDX/1nB1XdproCT2TJcwsdyYv18QuwPKXCmt+0YeD889LJ25TeN70+PQYgjsWmFDTcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wquSA1m3; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wquSA1m3"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e7fb84f99cso47186147b3.1
        for <linux-security-module@vger.kernel.org>; Fri, 01 Nov 2024 10:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730483342; x=1731088142; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gHgmf8yOjF5FUpV4FRVUFTRzyvX9RwDhNCCPw1xBMs4=;
        b=wquSA1m3FQnMwe2tm0Leg2NlVIC0xcrhrGH7Vx9wyAwrXHFLLWNGUOoDwZpTgXBWd4
         ZQCey0VEayb540aESpB42atpWQM7Q0/4LGSer2GwZM5OJPLXHr4sO+0ICQ++T9YSt69K
         u14vCc9ctNW8BhNG5taOpBmZUFfMVz2YgeA2GVPoTGM6A7swPmWkJl1Nywd4RLUpVy4Z
         6TU28JWkMsu/LNuEnoTJ/D++FRGbSLX8TZ8hkLiN4h716sCJm70le2kbypmw5Md/weL2
         kXmIDbYfC5DtoLl6nMIoUPwySiBjcoZx+P1QCcGy1FbzBuAYGIjeQgCqBtukKD6oEq8M
         iHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730483342; x=1731088142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHgmf8yOjF5FUpV4FRVUFTRzyvX9RwDhNCCPw1xBMs4=;
        b=Gkn3W758XEIhx68woK4+wb1NviASOzWoe41kE4RYpgYJ1NdjyDstvSuuUphRni9v4d
         bZzs5imaq4txVjCsyXzJN2hhbSwSiyXQL9rZkZ6oHMLH0XOn136ekXO2523mChyASccT
         h3mJFfXxZRKdqj6DSSvv/R34ZhD/UKQNjYLHtncYN1EFxso/8taEBcMkB3GACjPs6C2S
         XZA91MK07gcNjM0GNiK8EezZNZzLBTxK9ytAfHEWmkCdNG6J6o/OwOVHSetocjsk16T1
         bRPna2waIDnOvvb5rSDNUulJaqrO+XcdBLg9rmzXp0brditRGCSIE1hWVrKNBtjewjEn
         1kYA==
X-Forwarded-Encrypted: i=1; AJvYcCUmYblIEUQFc8b6CVBJIlfChZWfYCxXaVZH7hV82Zi503ZFZLyJMaqdHR2LJctjVcaaf0p1f+OKOHnbe5vSKwprI/WNHaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb0Njfj0kNEkqf+dxA8TV+DSFRL/HIzM3EPgMgQG6+xAKq5WNM
	YrQjVE/yNPwzN4crJB97PxAb5sVDeZcuZZuJixjmYps6RgksuG3g5ss++me4fmVYokk5bLRtTu3
	amive/AeRYnrpRQ==
X-Google-Smtp-Source: AGHT+IFWPK+8jTuj/8ARDH3sf8FN30h0/V8rLUflMtASKVnWhKOAN7Kh3zxgZ8xlx5S/14HS0km2yhZx9K25O6M=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:11:b0:6ea:6872:2fe6 with SMTP
 id 00721157ae682-6ea68723031mr394537b3.4.1730483342526; Fri, 01 Nov 2024
 10:49:02 -0700 (PDT)
Date: Fri,  1 Nov 2024 17:48:55 +0000
In-Reply-To: <CAH5fLgi+JJHCA_XTPC0-kaacZC6=aGSa-+DiNt06GSJNFhKc3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAH5fLgi+JJHCA_XTPC0-kaacZC6=aGSa-+DiNt06GSJNFhKc3w@mail.gmail.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6173; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=MNq1vw75irUPKm3uNfACSw7+CS/AqwPLJNAX26gOUdA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnJRPMV3tqElTC1f/7fwxC0jgj8Zy8AsmPI1zej
 DVXmJgV0CGJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZyUTzAAKCRAEWL7uWMY5
 Rpo8EACsKxwatzXsgHlXD2b0a7MaqQ6ns6T6StjlDf6f63OfgZZnw4tUY4YNg6ElS2XrbNKeAJ1
 sioGi2vpjVjqCo//I15Z8xocXpodOWyVM9bYCEpDpBpwPJdLJ1JOSdNhb828HNveMyaqw+Mf423
 ldmO1IZukag99HulYyHtHubkrPhg0hXRjNayCmjc2VYQEC/4IgnoA9RCA/hYz7upEZIZ1ABxOhu
 9cLFZdcp9rn1xi4P3OZGIiuu/KZQCSujQgFjt8JQKdHecRgadg4pQJM2BzzEQLtiP9jPdxYCxgn
 9/a3pbVATU/60V+ydh+KfywrADoidyA6oYG0+kyEvNmhd8QSMe9NBMy6H5cExAhdjP9Vzqf4r0H
 9b8hY20KG1Ip2+Ijgm6af/aEdFeHe5fqpJjNzJWrkdsfh5vv2d/yAF49I9n8YDasP6SM4X+YaOq
 lveI93/OeXCmqdWVybDnU5eiaYkD/MY19lWZI7Ny+8p1lkxnO/0TxDKEhsrqnFukQ7Hw36B4iQN
 sr0nXxARPd9XY9YXrD5a2lOvhoJ5FPcyQz4k+Gz3BxKvsveqXi78s9H2JlVhJ86M8JwH7yPE9g4
 OhuW6ZRUmFOWv6aP91wtE1BsUrrizIulcINpeQmN+mjRw0UNxCJcQWHgVCuP985UuKCKfvfJiIb zBBSv8zpG3oqvEg==
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101-lsm-secctx-v1@google.com>
Subject: [PATCH] rust: security: add abstraction for secctx
From: Alice Ryhl <aliceryhl@google.com>
To: paul@paul-moore.com, ojeda@kernel.org, brauner@kernel.org
Cc: anders.roxell@linaro.org, arnd@arndb.de, dan.carpenter@linaro.org, 
	kees@kernel.org, naresh.kamboju@linaro.org, casey@schaufler-ca.com, 
	linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org, 
	regressions@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, lkft@linaro.org, 
	benno.lossin@proton.me, yakoyoku@gmail.com, tmgross@umich.edu, 
	gary@garyguo.net, aliceryhl@google.com
Content-Type: text/plain; charset="UTF-8"

Add an abstraction for viewing the string representation of a security
context.

This is needed by Rust Binder because it has a feature where a process
can view the string representation of the security context for incoming
transactions. The process can use that to authenticate incoming
transactions, and since the feature is provided by the kernel, the
process can trust that the security context is legitimate.

This abstraction makes the following assumptions about the C side:
* When a call to `security_secid_to_secctx` is successful, it returns an
  lsm context containing a pointer and length. The pointer references a
  byte string and is valid for reading for that many bytes.
* The string may be referenced until `security_release_secctx` is
  called.
* If CONFIG_SECURITY is set, then the three methods mentioned in
  rust/helpers are available without a helper. (That is, they are not a
  #define or `static inline`.)

This patch had to be modified after its first landing due to some
conflicts with other changes. Please see [1] for details.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/r/20241101095620.2526421-1-aliceryhl@google.com [1]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/helpers.c          |  1 +
 rust/helpers/security.c         | 15 +++++++
 rust/kernel/lib.rs              |  1 +
 rust/kernel/security.rs         | 70 +++++++++++++++++++++++++++++++++
 5 files changed, 88 insertions(+)
 create mode 100644 rust/helpers/security.c
 create mode 100644 rust/kernel/security.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ae82e9c941af..3f3c39f9a83b 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -18,6 +18,7 @@
 #include <linux/phy.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
+#include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 30f40149f3a9..36a0c833e7b4 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -17,6 +17,7 @@
 #include "page.c"
 #include "rbtree.c"
 #include "refcount.c"
+#include "security.c"
 #include "signal.c"
 #include "slab.c"
 #include "spinlock.c"
diff --git a/rust/helpers/security.c b/rust/helpers/security.c
new file mode 100644
index 000000000000..f6deb0b28b48
--- /dev/null
+++ b/rust/helpers/security.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/security.h>
+
+#ifndef CONFIG_SECURITY
+int rust_helper_security_secid_to_secctx(u32 secid, struct lsm_context *cp)
+{
+	return security_secid_to_secctx(secid, cp);
+}
+
+void rust_helper_security_release_secctx(struct lsm_context *cp)
+{
+	security_release_secctx(cp);
+}
+#endif
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 22a3bfa5a9e9..a71dc73a0d9d 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -46,6 +46,7 @@
 pub mod print;
 pub mod sizes;
 pub mod rbtree;
+pub mod security;
 mod static_assert;
 #[doc(hidden)]
 pub mod std_vendor;
diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
new file mode 100644
index 000000000000..25d2b1ac3833
--- /dev/null
+++ b/rust/kernel/security.rs
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Linux Security Modules (LSM).
+//!
+//! C header: [`include/linux/security.h`](srctree/include/linux/security.h).
+
+use crate::{
+    bindings,
+    error::{to_result, Result},
+};
+
+/// A security context string.
+///
+/// # Invariants
+///
+/// The `ctx` field corresponds to a valid security context as returned by a successful call to
+/// `security_secid_to_secctx`, that has not yet been destroyed by `security_release_secctx`.
+pub struct SecurityCtx {
+    ctx: bindings::lsm_context,
+}
+
+impl SecurityCtx {
+    /// Get the security context given its id.
+    pub fn from_secid(secid: u32) -> Result<Self> {
+        // SAFETY: `struct lsm_context` can be initialized to all zeros.
+        let mut ctx: bindings::lsm_context = unsafe { core::mem::zeroed() };
+
+        // SAFETY: Just a C FFI call. The pointer is valid for writes.
+        to_result(unsafe { bindings::security_secid_to_secctx(secid, &mut ctx) })?;
+
+        // INVARIANT: If the above call did not fail, then we have a valid security context.
+        Ok(Self { ctx })
+    }
+
+    /// Returns whether the security context is empty.
+    pub fn is_empty(&self) -> bool {
+        self.ctx.len == 0
+    }
+
+    /// Returns the length of this security context.
+    pub fn len(&self) -> usize {
+        self.ctx.len as usize
+    }
+
+    /// Returns the bytes for this security context.
+    pub fn as_bytes(&self) -> &[u8] {
+        let ptr = self.ctx.context;
+        if ptr.is_null() {
+            debug_assert_eq!(self.len(), 0);
+            // We can't pass a null pointer to `slice::from_raw_parts` even if the length is zero.
+            return &[];
+        }
+
+        // SAFETY: The call to `security_secid_to_secctx` guarantees that the pointer is valid for
+        // `self.len()` bytes. Furthermore, if the length is zero, then we have ensured that the
+        // pointer is not null.
+        unsafe { core::slice::from_raw_parts(ptr.cast(), self.len()) }
+    }
+}
+
+impl Drop for SecurityCtx {
+    fn drop(&mut self) {
+        // SAFETY: By the invariant of `Self`, this frees a context that came from a successful
+        // call to `security_secid_to_secctx` and has not yet been destroyed by
+        // `security_release_secctx`.
+        unsafe { bindings::security_release_secctx(&mut self.ctx) };
+    }
+}

base-commit: 1008010aafe7b1e06974b8b1bf29b052fcf87f92
-- 
2.47.0.199.ga7371fff76-goog

