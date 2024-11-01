Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B162115A84E
	for <linux-security-module@vger.kernel.org>; Fri,  1 Nov 2024 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730454988; cv=none; b=XRdH1TOfs4LV0Df/s1efkcOjkCnAgem412B4xWTLMLRFGcbMBEk3jiND9fAmQYXcFxrq/r0mH9I69jl217Qf/REWzJQhfz+FpGIqr3LNVmD8/8mm9T/Di1SstaTrAJOEm/HaJ0+nDTSkcf4YVLO6a45QFH23TSQgW5suPMlPQqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730454988; c=relaxed/simple;
	bh=GOQxGFD0ZytTWG4OwqVfXTYJinyLhPSthymBTy2Eb8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=faEyHDC2KCjBuloaU342zmJzfTu+y4PeZEFUx1t2A46btbHXeMMpw8a3VxlrV85+uBJjXNRyfpxBUu9ukkKLzwaQODwAHFExFb/tDHMUDuwPGVHBvw4qgcbQ1ncYJfpywt6MZdOPifwQddA6UfUxPMRDiBeZS+k4h+jF5pJyHIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IZRDdOzw; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IZRDdOzw"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e376aa4586so37553397b3.1
        for <linux-security-module@vger.kernel.org>; Fri, 01 Nov 2024 02:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730454985; x=1731059785; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hmoflKYnQ7aKNSDRrJZTeq26rnTAdjCp4mlK4HuQWvs=;
        b=IZRDdOzwZ2vze/urn98eWXPxFeAqbfrLI4RncPkZgRzPigYL70Bkc2PY5SuKeE0RU0
         Y7AM1f3iE/HOaUlyUU5QGof7r4RRRDS08KXf7F+aAKccgJbAXcvWwqidzFBDUvqeaDmA
         G24WZJkAMtst6MxyiVN16FuJnoPichvuhd7J99hsoVOlCpqU+JS7H7dtxTDft/xIdGPp
         hC54LPXTctGhOUdVKvJFWUZsvjWid2Ua3BYN6SmkTHl4F/+C3puCwGRmkpVggL9x/A/0
         +Or9vudgZTkgyNcAhy1WUk8qooSZq5lQBeOzRc+ucraAaz4U4Xvdpgip8VubksdGDFEz
         GfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730454985; x=1731059785;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hmoflKYnQ7aKNSDRrJZTeq26rnTAdjCp4mlK4HuQWvs=;
        b=PQo0ghHELxWDQjQ0ypziFOCynwkzZvBnf+Guwsa+Ir329snA5CNcHOB7ptOYdv5n7C
         Hgp/K4cPJ23cRBtkqhhyWA9KBeqeS/XUO+oS2CLF4Jg6g40oZKLsUmEALf40nUvsjefr
         fTotmDHdF+vpGj6f+rWaJqfPCsT2qo+xRYcWNx8O2+eM4E2Zv+r1zcZU09yz/PHbDP6B
         PV6Y9ERTnLrwMg+JcDbHLdw8CUuVbKRrjsLHrlR8hkCpIohn9l9USlME7CjxC/PVBmk5
         zyM0tA9XCVAvKs1b0JYQJPmA0cV7a/JIpZAyuhyIcDd8TkhBGzHjiSR366U0pyhWRu1a
         3TfA==
X-Forwarded-Encrypted: i=1; AJvYcCU2DGJCSa/T4Kezt0oUVOI7hl1LxrdDym5EGPPbBC3aqnujetkpYmUCmUVONpIGxGuwfG6xVj+g3a9ZZz4gyE4daA9TVqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ujQbYVjAzYkrIffxVBWRwb7PLx/YEFC+7WPK43ZM7ea3jw0S
	diUaqtqOMivQ8qBX3WYdG483bgqjHV5ZgKE8noTxrV6jbR3Mk1rLHJzaQHQt7vhhWohKnzsKnbd
	KzKiwEanQC+tH1w==
X-Google-Smtp-Source: AGHT+IG2fVavzKlnr4QzZpcUQDvvH6D6+f+Mk98GHmIS792VM/YBglqgRG49x2iPQiQQgs27XavEgVyKXXEFay4=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:4c09:b0:6e7:e493:2db6 with SMTP
 id 00721157ae682-6ea3b951361mr2169417b3.3.1730454984742; Fri, 01 Nov 2024
 02:56:24 -0700 (PDT)
Date: Fri,  1 Nov 2024 09:56:20 +0000
In-Reply-To: <CA+G9fYv_Y2tzs+uYhMGtfUK9dSYV2mFr6WyKEzJazDsdk9o5zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CA+G9fYv_Y2tzs+uYhMGtfUK9dSYV2mFr6WyKEzJazDsdk9o5zw@mail.gmail.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5092; i=aliceryhl@google.com;
 h=from:subject; bh=GOQxGFD0ZytTWG4OwqVfXTYJinyLhPSthymBTy2Eb8E=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnJKKPl6aPrGB8YTXJhfCzaL9Oh695k3ASS1Fqb
 y3dRMfFgamJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZySijwAKCRAEWL7uWMY5
 Rn1pD/0TgLwq1yTZG8MK2EimNMvaP+KRF5HOpUY+kINtMwhlA+cfPHB3cZUHdMnckrRzKixRoop
 ONTExWRb5Mm2vGHke0i/y8kJwwnb4aiQxj+uG0qKdveVgldDwmA/0NgCkHuoUEyWQoJhpNvYHE1
 n+2GHxop9oTk8Nn904nRVvbTiDfVo8zXdiJi1M9nOnWeN6WdxdhZkZEbb8P7PmMFTweOItGI3HP
 AYkH2Si70HDANTT6r36zWbvAp+lVeWaQ8Zj6P0aiJkBCPvLn6NKooSYiOzov/CTUQBmwmBEJWT2
 mB47CVWjNG9SiBZhLgZdN7KeQaGDJQq2FG5SmyamwIwaGCXJgXdKj/qV60n/6cuxouPzEqwXDgM
 BA0GE/fOcKieVMJHZdmokhL7fLFu6wMOeirSXVK/Pbkd9Mtvjyp8MhsJAgTZqB14KYKEwneiPPn
 sF6gnFmJNFkYgzAIOVmjG9RaSI5FPj/f+Yl5+oa8aN+YgHmwaH+ZJ6efAvvXEEcTkNp3x7nr96S
 +Cy6VIqBcsN3y3cTHvqYDXBlMolGUUh4Ef4XLv3sx4P8b1Damfp3OQ9evnZRNn1tMs4jMkqtbZ8
 kz/QFbkyBb4Aym2/tyQhp9QZwM6OEZyH4xVlQgz5UGcOGSG0mbS83pAkwKV9soL1jGZtYPG7yL3 7OJLPCoeETzQkYg==
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101095620.2526421-1-aliceryhl@google.com>
Subject: [PATCH] rust: lsm: replace context+len with lsm_context
From: Alice Ryhl <aliceryhl@google.com>
To: naresh.kamboju@linaro.org, casey@schaufler-ca.com, paul@paul-moore.com
Cc: anders.roxell@linaro.org, arnd@arndb.de, brauner@kernel.org, 
	dan.carpenter@linaro.org, kees@kernel.org, linux-kernel@vger.kernel.org, 
	lkft-triage@lists.linaro.org, ojeda@kernel.org, regressions@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	lkft@linaro.org, aliceryhl@google.com
Content-Type: text/plain; charset="UTF-8"

This brings the Rust SecurityCtx abstraction [1] up to date with the new
API where context+len is replaced with an lsm_context [2] struct.

Link: https://lore.kernel.org/r/20240915-alice-file-v10-5-88484f7a3dcf@google.com [1]
Link: https://lore.kernel.org/r/20241023212158.18718-3-casey@schaufler-ca.com [2]
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/r/CA+G9fYv_Y2tzs+uYhMGtfUK9dSYV2mFr6WyKEzJazDsdk9o5zw@mail.gmail.com
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/helpers/security.c |  8 ++++----
 rust/kernel/security.rs | 38 +++++++++++++++++---------------------
 2 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/rust/helpers/security.c b/rust/helpers/security.c
index 239e5b4745fe..0c4c2065df28 100644
--- a/rust/helpers/security.c
+++ b/rust/helpers/security.c
@@ -8,13 +8,13 @@ void rust_helper_security_cred_getsecid(const struct cred *c, u32 *secid)
 	security_cred_getsecid(c, secid);
 }
 
-int rust_helper_security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+int rust_helper_security_secid_to_secctx(u32 secid, struct lsm_context *cp)
 {
-	return security_secid_to_secctx(secid, secdata, seclen);
+	return security_secid_to_secctx(secid, cp);
 }
 
-void rust_helper_security_release_secctx(char *secdata, u32 seclen)
+void rust_helper_security_release_secctx(struct lsm_context *cp)
 {
-	security_release_secctx(secdata, seclen);
+	security_release_secctx(cp);
 }
 #endif
diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
index 2522868862a1..25d2b1ac3833 100644
--- a/rust/kernel/security.rs
+++ b/rust/kernel/security.rs
@@ -15,60 +15,56 @@
 ///
 /// # Invariants
 ///
-/// The `secdata` and `seclen` fields correspond to a valid security context as returned by a
-/// successful call to `security_secid_to_secctx`, that has not yet been destroyed by calling
-/// `security_release_secctx`.
+/// The `ctx` field corresponds to a valid security context as returned by a successful call to
+/// `security_secid_to_secctx`, that has not yet been destroyed by `security_release_secctx`.
 pub struct SecurityCtx {
-    secdata: *mut core::ffi::c_char,
-    seclen: usize,
+    ctx: bindings::lsm_context,
 }
 
 impl SecurityCtx {
     /// Get the security context given its id.
     pub fn from_secid(secid: u32) -> Result<Self> {
-        let mut secdata = core::ptr::null_mut();
-        let mut seclen = 0u32;
-        // SAFETY: Just a C FFI call. The pointers are valid for writes.
-        to_result(unsafe { bindings::security_secid_to_secctx(secid, &mut secdata, &mut seclen) })?;
+        // SAFETY: `struct lsm_context` can be initialized to all zeros.
+        let mut ctx: bindings::lsm_context = unsafe { core::mem::zeroed() };
+
+        // SAFETY: Just a C FFI call. The pointer is valid for writes.
+        to_result(unsafe { bindings::security_secid_to_secctx(secid, &mut ctx) })?;
 
         // INVARIANT: If the above call did not fail, then we have a valid security context.
-        Ok(Self {
-            secdata,
-            seclen: seclen as usize,
-        })
+        Ok(Self { ctx })
     }
 
     /// Returns whether the security context is empty.
     pub fn is_empty(&self) -> bool {
-        self.seclen == 0
+        self.ctx.len == 0
     }
 
     /// Returns the length of this security context.
     pub fn len(&self) -> usize {
-        self.seclen
+        self.ctx.len as usize
     }
 
     /// Returns the bytes for this security context.
     pub fn as_bytes(&self) -> &[u8] {
-        let ptr = self.secdata;
+        let ptr = self.ctx.context;
         if ptr.is_null() {
-            debug_assert_eq!(self.seclen, 0);
+            debug_assert_eq!(self.len(), 0);
             // We can't pass a null pointer to `slice::from_raw_parts` even if the length is zero.
             return &[];
         }
 
         // SAFETY: The call to `security_secid_to_secctx` guarantees that the pointer is valid for
-        // `seclen` bytes. Furthermore, if the length is zero, then we have ensured that the
+        // `self.len()` bytes. Furthermore, if the length is zero, then we have ensured that the
         // pointer is not null.
-        unsafe { core::slice::from_raw_parts(ptr.cast(), self.seclen) }
+        unsafe { core::slice::from_raw_parts(ptr.cast(), self.len()) }
     }
 }
 
 impl Drop for SecurityCtx {
     fn drop(&mut self) {
-        // SAFETY: By the invariant of `Self`, this frees a pointer that came from a successful
+        // SAFETY: By the invariant of `Self`, this frees a context that came from a successful
         // call to `security_secid_to_secctx` and has not yet been destroyed by
         // `security_release_secctx`.
-        unsafe { bindings::security_release_secctx(self.secdata, self.seclen as u32) };
+        unsafe { bindings::security_release_secctx(&mut self.ctx) };
     }
 }

base-commit: c88416ba074a8913cf6d61b789dd834bbca6681c
-- 
2.47.0.199.ga7371fff76-goog

