Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E41C3AEF54
	for <linux-security-module@vger.kernel.org>; Wed,  6 May 2026 20:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100573; cv=none; b=u09Qi1SXCzu++bQcdzrF0VidqpvlK6ZlLTgVskWxqcjwYXeS8Fc1Qcsz+pJ/KCc3B5nBUDXJNw+1L4Mf02EJ4pwONAC563yFSwJ9OxmtUOmSerxdiKVEyrz3Eqp6L6b1Pybrqhdn1X3uPWN43SLEwuV632nw87SH9hC74VW16rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100573; c=relaxed/simple;
	bh=99V9//V/GQNqh/x63qJ9youBs3GJq8wBzyRhottcyC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2yyMW3XV7oVtWUmDJnYOoORLY8x8+LnReKLUZmaJRQZpT0Tq8uH0wYq91lewklbSObUOOQO/gq7/jFMIquKSDkx97UxO9Z7g4kQYMXtz2E6kZE4P919MfCm5bO/l9Eb6KXzgQfB7H/4Pt5/6w+SfNvN5e9/Tyry3ebls9+0h0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oX831dYL; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oX831dYL"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36525730172so110449a91.1
        for <linux-security-module@vger.kernel.org>; Wed, 06 May 2026 13:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778100572; x=1778705372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TZjYOQ1IR/s8XAAiI8t2bP/5mFaUmDBU9B5ZjAyEcWw=;
        b=oX831dYLvDoHMVeIf7qku7TeuEIKYcKqBKNCJ4e4eEZ9F+S6+lFUZccdb/1Jk7Cy/k
         y17jqgqoChpKop1ROEKh5DRaO6xSHSFkWKN6IGTqI+b0QRoSdaQ84tf6gW6sVhkElCG1
         4YCR04RjAHTSCIkmmUEdQX190xy6nP6p+czQZzZRgdwv0FKwHo+bEIStFfFTUsNr2awQ
         S0MmIJxajd2GnoLT9kz/V1tpZ0JaeEt6ZHMPxgb9h0fCZo7y8MEw5zaerKfO6qp6QNf/
         /CRiyTt1u2eHpfshD9yDQz4vedHJ/dIC9of0acQwlcV+ThDJxGTFBglaMjKaUqbHr+TM
         bgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778100572; x=1778705372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZjYOQ1IR/s8XAAiI8t2bP/5mFaUmDBU9B5ZjAyEcWw=;
        b=etgtR3hgHQQvcnrnMSwTmhECfPMHoj2PuLv2LQSt1Lz4+7RjnRvqoiqgLyCtMrELbG
         iPRpd/VYDcF4kmFbRt41YOF/t71yZOX2OVITK0UX5qLItn5RfSdnJonpcYz3l6Xd6QYJ
         6JRDiTL0q+b8ZMvwdSLkUb6NNevOZxetX1p0FrdvGWiRVpa5o99zfwzX7Gvzxb2ZrMi6
         T6dSXvR5+qWt7hbKx17/fmsbsOQF6UarXAfs6ix+QLEwB/jJCfSfdvJR/CG8x+lKuOCb
         rEK6J/J4PwzSROBOlAr+yesemNbGHyVn4jfjuxWDLBfTZKXMezfHevCl9mBtvf/xkbxN
         O7Pw==
X-Forwarded-Encrypted: i=1; AFNElJ+PhntIRq4KcF3RobGn73bs+zE0iMF2NqaS12zCprhVFeqoGv2S2JcZyiNwca7sGyWv0P/BPhrTfzqH0UFbWZBYTIgs3kY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBVupKs5I1YHnPO7rWC3xlQ/uLEcQoZGxQm4+eXDfeFuhJ2GAe
	KZImWDQmQDEEvVzy5XhV6C3OhVY3DYXrnMyvocM9Y8jkh4xX8RofWVv+
X-Gm-Gg: AeBDieugb3SxFtQ1Xh8ChU6lIK2NebzLVMWld+/oLXa7RWTS4qzoFeKODI+NUruFJEf
	0hzhaKYuoUXrVPqtxiAmb2QjOQxLqImVUAH/BmhZEztX4eeydSBefiShIslZjCnZ8Sb+cBvA9mw
	PkneAgS/mQeMciof91cYJfKQu98RgOTmsL7m8eGUIVKhgWykTuiJRcndvktvFTMiz/HBM+1utB1
	qwjkj6q+bgcZM+MDTIKgmD3fre4B+6PUByVk2j16v7SP2eEpqm8SoVFg1kuYj7ozta4uZNKOUk3
	lffev1N4Kuu6Ycb/XO+Xx++29DCqrPI3hNrx8DqWMpUlPGLlseVv5z+XR+B3FxYfXB0AWyzmjxq
	aIZyaK9mod4wggsM41+yiL6NKo7A8BLPhRfk5ia8vgdapW819b8ApBWg45UyZLeJasRPTi+VNgD
	YeJ+692nIbWNKGYnXX18fSYEsTbfC0RHeByeO8AIXVQvqtukBx0gI=
X-Received: by 2002:a17:90a:d886:b0:35b:8d89:719b with SMTP id 98e67ed59e1d1-365ab3e592amr5283506a91.1.1778100571511;
        Wed, 06 May 2026 13:49:31 -0700 (PDT)
Received: from crewmobile-Dell-G15-5520.. ([2409:40d7:e:c40c:b89c:2d1:e053:9c37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b10d3e04sm1585128a91.9.2026.05.06.13.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 13:49:31 -0700 (PDT)
From: Arnav Sharma <arnav4324@gmail.com>
To: ojeda@kernel.org,
	paul@paul-moore.com
Cc: Arnav Sharma <arnav4324@gmail.com>,
	Serge Hallyn <sergeh@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-security-module@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: cred: add safe abstractions for capable() and ns_capable()
Date: Thu,  7 May 2026 02:19:13 +0530
Message-ID: <20260506204913.26022-1-arnav4324@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The capable() function is the primary privilege gate in the Linux kernel,
used to check if the current task possesses a specific POSIX capability.
While bindings for capable() and ns_capable() exist, there are currently
no safe Rust abstractions for them.

Introduce safe Rust wrappers for capable() and ns_capable() in the
kernel::cred module. These functions validate that the requested
capability is within the valid [0, CAP_LAST_CAP] bounds before calling
into the C side, ensuring that safe Rust code cannot inadvertently
trigger a kernel BUG() on invalid inputs.

The abstractions take a `u32` parameter to ergonomically match the
generated `bindings::CAP_*` constants without requiring explicit caller
casts.

Signed-off-by: Arnav Sharma <arnav4324@gmail.com>
---
 rust/kernel/cred.rs | 79 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
index ffa156b9df37..6525b52b81ae 100644
--- a/rust/kernel/cred.rs
+++ b/rust/kernel/cred.rs
@@ -90,3 +90,82 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Credential>) {
         unsafe { bindings::put_cred(obj.cast().as_ptr()) };
     }
 }
+
+/// Checks whether the current task has the given capability in the init user namespace.
+///
+/// This function tests whether the current task has the specified POSIX capability available for
+/// use. The check is performed against the initial user namespace (`init_user_ns`).
+///
+/// When the check succeeds, the kernel sets the `PF_SUPERPRIV` flag on the current task. This
+/// marks the task as having used superuser privileges, which is visible in process accounting
+/// and auditing.
+///
+/// The capability constants are available as `bindings::CAP_*` values (for example,
+/// [`bindings::CAP_NET_ADMIN`], [`bindings::CAP_SYS_ADMIN`]). These constants are defined in
+/// `include/uapi/linux/capability.h`.
+///
+/// This function must be called from task (process) context only. Calling it from a context where
+/// there is no valid `current` task (such as hard interrupt context) is not permitted.
+///
+/// # Preconditions
+///
+/// `cap` must be a valid capability constant in the range `[0, CAP_LAST_CAP]`.
+/// Passing a value outside this range is a programming error and will trigger
+/// a kernel `BUG()`.
+///
+/// C header: [`include/linux/capability.h`](srctree/include/linux/capability.h)
+///
+/// # Examples
+///
+/// ```
+/// use kernel::bindings;
+/// use kernel::cred::capable;
+///
+/// if !capable(bindings::CAP_SYS_ADMIN) {
+///     return Err(EPERM);
+/// }
+/// # Ok::<(), Error>(())
+/// ```
+#[inline]
+pub fn capable(cap: u32) -> bool {
+    // SAFETY: `capable()` is safe to call from task context. It checks `current_cred()` against
+    // the init user namespace and returns whether the specified capability is granted.
+    unsafe { bindings::capable(cap as i32) }
+}
+
+/// Checks whether the current task has the given capability in the specified user namespace.
+///
+/// This is the namespace-aware variant of [`capable`]. It tests whether the current task has the
+/// specified capability in the given user namespace, rather than in the init user namespace.
+///
+/// This function is relevant for code that must respect user namespace boundaries (for example,
+/// operations inside unprivileged containers). For most driver code that is not namespace-aware,
+/// [`capable`] is the correct function to use instead.
+///
+/// Like [`capable`], this function sets `PF_SUPERPRIV` on the current task when the check
+/// succeeds, and it must be called from task context only.
+///
+/// # Preconditions
+///
+/// `cap` must be a valid capability constant in the range `[0, CAP_LAST_CAP]`.
+/// Passing a value outside this range is a programming error and will trigger
+/// a kernel `BUG()`.
+///
+/// C header: [`include/linux/capability.h`](srctree/include/linux/capability.h)
+///
+/// # Safety
+///
+/// The caller must ensure that:
+///
+/// - `ns` is a non-null pointer to a fully initialized `struct user_namespace`.
+/// - The `user_namespace` pointed to by `ns` remains valid and is not freed for
+///   the duration of this call.
+#[inline]
+pub unsafe fn ns_capable(ns: *mut bindings::user_namespace, cap: u32) -> bool {
+    // SAFETY: The caller guarantees that `ns` is a non-null, valid pointer to a fully initialized
+    // `struct user_namespace` that remains valid for the duration of this call.
+    // `ns_capable()` checks `current_cred()` against the provided namespace and returns whether
+    // the specified capability is granted.
+    unsafe { bindings::ns_capable(ns, cap as i32) }
+}
+
-- 
2.43.0

