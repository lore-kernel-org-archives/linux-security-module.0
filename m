Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C93A3C1F29
	for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780047196; cv=none; b=ZnyALbJ3k0UgfQfPP5keVpfQYplGGRD4Ndb2iycviAjNU25CCqbcQaZGdcSWVdGRr6pzffz0PpT/uIqBtxJNxgQoCxMNpiSoAkv3gLLuZbJsQ91CKmWxhv99DaOmh7Pfz03pg9Y0LJ1hKFolf+/nhwoga03K0hKChwp47f55hUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780047196; c=relaxed/simple;
	bh=m2M1hqLeBWvqPQs5ztdeH6LdezGSXUVSFlb8F3nedpI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bPV8C//2ipajNdYHoYEejZI/PhLWnM232BY+Xvy++quUOkfaQM/tg+PqWLXK2RzbqLeki0NoFHlWxPfSoFNGhgHs3fFK3oy4s60M2074HkcEoNxi+/XTFD1quOYekOBgR+rd9oQQ8Hk+ap64ZY9qJpOHAdzW/uQHcKoyrHba38Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=olRzD6fO; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="olRzD6fO"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-45e80183514so9626538f8f.3
        for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 02:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780047194; x=1780651994; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pgBUNf+zONY3y3bIHQzKq/7IR7Q4CQOsSs3bYWLSYZ8=;
        b=olRzD6fOMf+OEJeRU3XYfOkQy3JsNjFLpkd7vuXx7TyszH2ddkCAd8xJZiPDfTbmkf
         CpSNNADCccBIRI6A1IFSFNIj/w9p7t3L7+M5Aun3BbruK8uUweFdu9Lfz+f0zVKF72b/
         ZQnzBAJd7GU50KRLwO1E9QkW8UleKsMxhOcSZu2k8LXHdyodAXZ1mxwFFnehZpKPjp37
         ly5aZ5Cb56VEy+Mb6az1n0Ls2BIPdcgmDQsZgYU1zHTOJMvCkEe3N2FxAMd4orEnIyzI
         801jn/cvhwAJTlwJUqFI781PETlX1Hr2F08qhA88lEg8TBpBPgYIxi9baW+nRcprBYIW
         +ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780047194; x=1780651994;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pgBUNf+zONY3y3bIHQzKq/7IR7Q4CQOsSs3bYWLSYZ8=;
        b=PUQv7QjT/7Fbm4t2GJz0jURcOwFwS5LSJWyLWLyzbIUCBbJdJhWuutumpTb0jmGrf0
         AqPMTVxXD+VzeLvT/q4jAOwQauYmTa/Qm6sDO35nhwyyf0gATp0HUWh9fQ6Z3rAGSMTJ
         yvqkaOGQV2a/KW4lZokLs+iHq9V4EgdN9PsCiigDt+cM6ZLkLIvJoxsbIJvmDAP3onPp
         6z24nB4JHIwrzlbLNRgKYFXFz8oiLw0L2CNZfMg4bb3JRWQMAuwBQVl2b4M1owxmXseI
         NEjPQSnnLV1M9Ym4eqFgKPPoTh1TWGi8TJeO7b3eW2vzOcZ/h3X1SvB7reE+yWgrJ/IV
         pUjg==
X-Forwarded-Encrypted: i=1; AFNElJ+924NC7GtXuNjXoVz2i/m4JXEVTnwG5D0GUsb40/Fy9Q16Mrfau6AUqskVo0osth4SCeOS7QVJRqNxw26gNYsZn4Nd7JY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2eHtNaZXGiFr/1YNnC48vafkCSPo4ES+q4jgju7wgrzuQ2x4y
	gQWYPeC7ZJI16ko7Zq4XkOwxD72crK1mk91/6UmVMZ2i4c/heX6RXqQs6l5qb1d1yFyXBtCY6Ey
	wbGBGYVEFjxZYa4kq2A==
X-Received: from wrux14.prod.google.com ([2002:a5d:650e:0:b0:45e:e154:705f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:e405:0:b0:451:3b12:9bca with SMTP id ffacd0b85a97d-45ef14659f6mr2944656f8f.25.1780047193368;
 Fri, 29 May 2026 02:33:13 -0700 (PDT)
Date: Fri, 29 May 2026 09:33:01 +0000
In-Reply-To: <20260529-remove-task-euid-v4-0-07cbdf3af980@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529-remove-task-euid-v4-0-07cbdf3af980@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2697; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=y1KXlGVYnm1pX/oKAuz20EvxJFYU3EACcVg7zUuAQwU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqGV1WXEt0VAFuXMCffSAPXG9HpCtsPqdouwXhX
 XnBDBRN3c+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCahldVgAKCRAEWL7uWMY5
 RrYkEACDEvg+5bfmrGM9ko1sQki3qLPW2T4znB2zmDUHgZNcCoAeUS+1E/N3khEN53mzLCRkyru
 uVflfG8A/cGB264unm9GM8Xnlr8dQX0Hy9feDf39WXQNJhj+tybCqP7/7GTETTVqkoiFBhbNH9j
 /iD9+ynhtE410KedhBGDSUMzBQgMTnX0qqPmNe1uLGMBObaC/xWHTCbZGBZGCaQg+nWs2xlQp1S
 VJt26fhOLhYNsuV9kqfKCRFVmL1butWHBLpALID8TbfPMvkhkXVx10T9B3r3B8oYx1XddfTqZUw
 Fl8fdSFF5LcAIt/dxXFmROZ3r1BGo8gFn8SWbmlhpvGJBBX79vjXVXWVmCVHcRUKtsRoAaa2xRE
 xYoZ8p3ioNz+Rr8OFPHym/qcLkUpLiHhOC2e/BVgDvDWa3WO2at56aUVQypcn4q9mLNoP7Gj/eK
 LjE1tEBlHBOV/EaVRtE8K85jLHiM9mCuFRIihTcQIBbQjHIjAnXlBJ1wxomAqjaYYGyRxsbAEX1
 Y1s8rHibSIqjdtF7G6/QaXLxPyLDzba8+Ylxct00FVQReZm2kkv+DXCzQe7VSP9G2yMLIDpJqpy
 DDGoAyiesecIpl35K3nUUA/qHnX7eL//wAJANF3k/ycHy6y4PMcOwOT/e96E9cc3OsQSt8aiEMN gTR8pOiW3e11plw==
X-Mailer: b4 0.14.3
Message-ID: <20260529-remove-task-euid-v4-1-07cbdf3af980@google.com>
Subject: [PATCH v4 1/2] rust: task: clarify comments on task UID accessors
From: Alice Ryhl <aliceryhl@google.com>
To: Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jann Horn <jannh@google.com>, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

From: Jann Horn <jannh@google.com>

Linux has separate subjective and objective task credentials, see the
comment above `struct cred`. Clarify which accessor functions operate on
which set of credentials.

Also document that Task::euid() is a very weird operation. You can see how
weird it is by grepping for task_euid() - binder is its only user.
Task::euid() obtains the objective effective UID - it looks at the
credentials of the task for purposes of acting on it as an object, but then
accesses the effective UID (which the credentials.7 man page describes as
"[...] used by the kernel to determine the permissions that the process
will have when accessing shared resources [...]").

For context:
Arguably, binder's use of task_euid() is a theoretical security problem,
which only has no impact on Android because Android has no setuid binaries
executable by apps.
commit 29bc22ac5e5b ("binder: use euid from cred instead of using task")
fixed that by removing that only user of task_euid(), but the fix got
reverted in commit c21a80ca0684 ("binder: fix test regression due to
sender_euid change") because some Android test started failing.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Originally sent as:
https://lore.kernel.org/r/20260212-rust-uid-v1-1-deff4214c766@google.com
---
 rust/kernel/task.rs | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 38273f4eedb5..eabd65bfde12 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -210,14 +210,17 @@ pub fn pid(&self) -> Pid {
         unsafe { *ptr::addr_of!((*self.as_ptr()).pid) }
     }
 
-    /// Returns the UID of the given task.
+    /// Returns the objective real UID of the given task.
     #[inline]
     pub fn uid(&self) -> Kuid {
         // SAFETY: It's always safe to call `task_uid` on a valid task.
         Kuid::from_raw(unsafe { bindings::task_uid(self.as_ptr()) })
     }
 
-    /// Returns the effective UID of the given task.
+    /// Returns the objective effective UID of the given task.
+    ///
+    /// You should probably not be using this; the effective UID is normally
+    /// only relevant in subjective credentials.
     #[inline]
     pub fn euid(&self) -> Kuid {
         // SAFETY: It's always safe to call `task_euid` on a valid task.
@@ -371,7 +374,7 @@ fn eq(&self, other: &Self) -> bool {
 impl Eq for Task {}
 
 impl Kuid {
-    /// Get the current euid.
+    /// Get the current subjective effective UID.
     #[inline]
     pub fn current_euid() -> Kuid {
         // SAFETY: Just an FFI call.

-- 
2.54.0.823.g6e5bcc1fc9-goog

