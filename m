Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892863C8728
	for <linux-security-module@vger.kernel.org>; Thu,  7 May 2026 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778147318; cv=none; b=aal7lDE95D9asH/konWfMQnDJAOCF1GB7y/0uF+Impb0/hG78MTiUXfUG/ZpIHzAF4FD8/k1db2YJeSqwkZM4YTc07khcknY7BdJ+flhp0f67DQPcVZso+uIIjJYtHZRSWocIveMpOECS5l/5y018JhFMV0vuGDkz48WL+ebbmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778147318; c=relaxed/simple;
	bh=nInq29r8bUtLoKBScvu7yRNT+cWpy1yik2CGMKD1dMM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SEkdA/oSAYlFLaB5mxZTfm0AF3zvi28W7i8gZjiyV14v18F5pdCbwRc7Tz/Cs3riU1mwxWInsI/dxHccrkbr31Pv2IMnWxBEyGGmH1H4mnHaQ9Y/tnIs0UljIBd0qR3PuTdb+lKg974eU0GdSljLBnp8d04EvX9z6DbKqspS+sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TEyr/+uS; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TEyr/+uS"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-44d83e45febso1468963f8f.0
        for <linux-security-module@vger.kernel.org>; Thu, 07 May 2026 02:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778147313; x=1778752113; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=av1HgqumsBlD6lKE8090pKC8z8MWkNfP+q0J9NTkiSY=;
        b=TEyr/+uSEsZ+JHP/8qLshCBfph8aYCEMMMU51wDa0bddTUimb4HqDyaQKmVPUCWG4m
         gO4d49YjEmFGZMj0Lkuu4oZaWgpVIupmu3DKh2YGd2BT+UbHwHhxJG6Z3jjt4U9G5ndn
         rf7LpqQhb1JZ8uGLUKFQbivTiMIIJ9GNP6O4d7gMgAdgheMIkwy21xmRdND+zec+fsBN
         X1bBCLNv8U4nZOJKYL1dW1dRtOQCJKDjug8B4q8XKfdo/NACkStHb9uMssZcmmeU5DwV
         yJykIg3Bn/5/5UajzuDlZ+oB0G3hLtQl4I3LS0P+evFx6+iXdhuOnwrkS2KNTNq0aRRO
         ixeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778147313; x=1778752113;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=av1HgqumsBlD6lKE8090pKC8z8MWkNfP+q0J9NTkiSY=;
        b=Tu8ThW8KxdL2YLwDyt1qnxh6VNjCDLhSZF0jqDdKfkU2YI3zamdaML+3bwFB98fome
         LeKvZWA/vQI5l6YzSjO9EG2SIxl9MkCGVZ9U2oBveSY3fmIx5a9Kj1D4U+IDvsAqSFpX
         sJ6PapfMZEAbrKgQtIOgQJwtv8408pyid3jjKttbm7xejgoGcY61kAYgOWZ+t5QiVgoc
         cimCv7xaBAoA+eSPIh4CuokvKczlGZH11dOXva754+xqTQYAsHdVqPxdi/yBp78Rfanv
         bevaG/JpZ4LzSkImxB8HP8fGVhgjB8NE+R3XY+9PbFft6xRJgtLVVqrsAVlmjeNDYOZy
         S14w==
X-Forwarded-Encrypted: i=1; AFNElJ+eUjbjaQ4cx14ckSNlMENDBWLppcAwuCcEqNXlRacy/WJG4ShesOZJwqH/+K75smciMuV6IXMVeg1ioejwiMpQPH1SvnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUY4YXnplBHFnuzqQ0S0FGFmlBYkpptsgkgx0yQTsUGgd//xnP
	kTSP7pvSsZJm6aLkzzrzlR3ItK4zrfBJEsq2ikmHeSQg7JlaF6sxYzPNRqj/leJkbbOMzojODLO
	RZismdoV6Groh4hPltw==
X-Received: from wmbjx1.prod.google.com ([2002:a05:600c:5781:b0:488:e1ca:5f9d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c0d8:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-48e5e000c1cmr24214325e9.12.1778147312899;
 Thu, 07 May 2026 02:48:32 -0700 (PDT)
Date: Thu, 07 May 2026 09:48:22 +0000
In-Reply-To: <20260507-remove-task-euid-v3-0-27f22f335c2c@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507-remove-task-euid-v3-0-27f22f335c2c@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2688; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=/BVeQx0VRU68fi67DUlXes7Ap/2BrrNmwJJY4wTxciM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp/F/t0FS/aIWnaW4qA4qNzPZ9FKlRIMwX6fkNb
 MmYcdxGeEyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCafxf7QAKCRAEWL7uWMY5
 Rs6AD/49LNhD2B25Gjx+eBAst+pbhEX8Fk/JygBS3qYtx0QhYsW8IRI1g+TivLeex4seQCqk96n
 8/n5pp6BdwCb0KEYHSAEh5EqLoZa/osxiAHlgzSThG2kzMP1mbHdFQVMmRKQezN81dZmSPp7odD
 HiWQhKSkpkXoAI0DthtXWT/IQBuUn6vo59O5xWVNOuP7u2Ymi7em0BnDCHoapCyWT9hEsQTR4NP
 W+xUJOP/36VgiRGPm7GpFZ5piXcxhDkTGi3CBP8WW2X0pmvFt2RE3lGjR7Yq/BKKO00G9L+pcuy
 k7o1Ub2/ADestQtswXwU7IbzNiJhudDcmbrH6J6Y+vHd58n4stVXR3O1kNKZM06GeRi64Jss11F
 EFfdNqTLLXNeLX8YwW7hlYtKigmawqVClcc5s1wfTCw3b/+U6/12G5jxTfEtI1SUcIa9VICIIXC
 l5oWdkc8MQV30MhN68nkSYChdqGAmF7U45K0EcP4I8bZyrgn8X/vZicraT0kB3+qk+T5NgFrUg5
 GwVT3qBxVnPnHMvkMsmxJuV/2QUA+yM87Si369COisat/MtlLcUKmrMJNB4g7ZyTPFcwBSeEK1R
 iK+ILqHvQjZCzcazTumOtD1siJhQbOzi2TzjZQhafxfAG/JyrHL6bGLyBnA9izXpjbqz07ozHaj LJdR3bhXixSXebg==
X-Mailer: b4 0.14.3
Message-ID: <20260507-remove-task-euid-v3-1-27f22f335c2c@google.com>
Subject: [PATCH v3 1/2] rust: task: clarify comments on task UID accessors
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
index 38273f4eedb5..7950c3a3950d 100644
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
+    /// Get the current subjective euid.
     #[inline]
     pub fn current_euid() -> Kuid {
         // SAFETY: Just an FFI call.

-- 
2.54.0.563.g4f69b47b94-goog

