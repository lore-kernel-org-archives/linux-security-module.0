Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38CB1FECDC
	for <linux-security-module@vger.kernel.org>; Tue,  4 Mar 2025 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083926; cv=none; b=VKQR2HDXIkaiZBJol+aiEx2Y3kw6Z3TVmSO3y6lZY1O0Dy/DBECA5nK62fHhbtMxpzybVFjUd0RniFkG6c2zjA50WA1bQGl4iGuR8huCqlwFbqKJNxG71rRmX3OmsQek0HjLMLGwh/uHD79GaKFQTzGR2t2rMVEJ69vy3drzBaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083926; c=relaxed/simple;
	bh=i6S0L2JiZfziLX3LjJg2a++syB3iBS5cHAjVUvZ1vXg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=A0YycDCy4gSMWPdCVe6EWkfyCCWfRuXgfH0mgxvoXs7Mryd/aaPCc3H+F+JAjnM4KjoMY1pSKSEufUFXyj2xEA3t6HbdjhPwxzI7Tns05P2jS5ocwgD1tJGQ8g077GJbV36UT2y8uLUgMUmUQISXnJE4C9tYvrfm00PmLOvj4ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dDq3Ioi0; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dDq3Ioi0"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43947a0919aso49270865e9.0
        for <linux-security-module@vger.kernel.org>; Tue, 04 Mar 2025 02:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741083923; x=1741688723; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pksM2vN2/PItdZunWojcAj/INip0cwdwB2OzqPSE1xc=;
        b=dDq3Ioi0mNAcAZuruQtTGDo/BCjKaqY/C4oi08itKPT6uYPgII4wHWSUBFi5DOAJbR
         69mhbWk0XggbH7xTfw9oU39eugW84NsDrvWCd8yc0m9knOaC9FCKZth0+1FbYJ0oH+uU
         B/dbUTRAc14jfFEtlkzZNgpQzdtdl46tBBY7onnhgsS9wvLga6fKZNkHFykuHy1ius06
         gmqrD5A0wqA5ZEG05aGJ+gS1EX1c9S8hRINFAPTkoiJxwO0hUL1oNotwyQfV5EGNKbPj
         c8wMLeVC4uV4Dqh+u894+x1wFIZtBrn322y+6cS3sLzL1lL1O8HrdiTxBV6HU6VBScIK
         Neow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741083923; x=1741688723;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pksM2vN2/PItdZunWojcAj/INip0cwdwB2OzqPSE1xc=;
        b=jY9YVDYnn57JsYYSH2j1dT/DDlef0YG47lidKGrpKxEgbYTaA2LXdnCTFn0A+O97wU
         TR6Ad0YG+eeF0Okmm9Ha9JCpjeEk5mIVg4/fW4t6InyeaMi2decbAjX6RBUA19rHzkVi
         GBmU8bItE5F2ELAGoCuZ0+Zrw4+jMSq8RFNjgkOV5XK35XSG/AFHg0qaSj47P92rnh0Y
         N5Gdjq/XTfaM3JK94NECh67n3Cmn/5cirjejk6mYaQaji46mz81CNmBsWqlS0hK57kiz
         0yEprIJLl4Md9FvDqe+H0Ft8KWmRiV77bVq/JeJCu/kZfkNa5oPVlx8dL7jBThFzX3W/
         MyzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW32iGVmh4wWRSwdoZRW/kUulvwoovGwk/pOmHd868PoLiNGR8ojTBH23alpaMXFFpoEBAN1xxlY0mGzWYxHyViRKcydVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBRPxj6ou9gIt5dc+6O8boSPy0wHeikds9vWgyIrLQyxc8a3QJ
	WWd33rsKj01hsfe1ttKNC4yGkjbc9Dl1IPXyBWBGLsfD7hpP0wtkh3e1LgD7AnH47OdoXCQ2hU/
	4DyC2lvOgTfIzDg==
X-Google-Smtp-Source: AGHT+IEZgPZYq2Zew/y+z3cMKYdmhzJO68zot4w0u1Ph8Z3yGgHflr/VsRjy0jl5tuwbt7ekPsDeudZbUWMwpg8=
X-Received: from wmbbd14.prod.google.com ([2002:a05:600c:1f0e:b0:43b:bec3:e552])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4b17:b0:43b:bfb7:e099 with SMTP id 5b1f17b1804b1-43bbfb7e424mr81024455e9.29.1741083923109;
 Tue, 04 Mar 2025 02:25:23 -0800 (PST)
Date: Tue, 04 Mar 2025 10:25:13 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAnVxmcC/23MQQ7CIBCF4as0s3YM0CDGlfcwXbQw0kkqGDBE0
 3D30q5d/i953wqZElOGW7dCosKZY2ihTh3YeQyekF1rUEJp0YseOSwcCG0ih9JJoYW5atIW2uO d6MnfQ3sMrWfOn5h+B17kvv53ikSJk9LKTDRaMpe7j9EvdLbxBUOtdQP4bmf5pwAAAA==
X-Change-Id: 20250303-inline-cred-1d1050785e5c
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3427; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=i6S0L2JiZfziLX3LjJg2a++syB3iBS5cHAjVUvZ1vXg=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnxtUQ3qKxCQDChwSuI4NqC7eLuQefIzTaHT627
 UiPixWJBk2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ8bVEAAKCRAEWL7uWMY5
 RhqhEACzbBDgODoXt6rYeZ7UMfAZx6R72BcHs0Cv5mGJXwp4uCuv9gt8ee7+0e0nh7i+ppQuZSl
 56e495j11wzGZ3Ssbk+OP1C2JIWvyaYfKIxU3dF/RDRNa0zgdxiXJCrrJtzNJ0tDuCymF3FHX0z
 OejN/DBkgIDB9BOzfZR1QMMH7LpVqkaSt9e2onrY+BjBcSaAaBGg5zo+ahEhgvtfHSYGIy62/WO
 9rrKaOBaPRx1d1IOyO/ciYRLzu8oI5QTUTyx/Cl2vb4MBN3EAyaKxREfiOHIw/5Xi7+AYubUpNd
 Dw/CGpBcuMBJaNyIT83tf63Dx5WrLBS6n4ZwZcFjTy5q9Dpc3Vrx7iQBCdTekRywIDDfbbxnfoc
 h5T45btjQjfwEBwM8gXkzSrb2m8V868Tu1Xc2WnSYd2bN2MKYK20fL50zY2TIWFq5p9gLCPeIAN
 evA+I9sDIzj88vu89HWpDXcwwQX8vNkaAA23x1nb0UkWljZDb8Cp8a4J1g9BjsyPG2VKQYg2SLz
 4pSPOw7pv3qkDkbGQcvUtgU4WrpAmDpdDf2xAyPpQ1A+RtUJjgbdaYHUAMTUZ/tcEp3rWlGmcaM
 WYlDywgEL/vi7a/ao4z40/AFcQW8cKla7D6+e/ttEIo5dMkvcp6zBM/W5rRcsZdEdFa/l3r12Ra IzMx5OD8VFTGitw==
X-Mailer: b4 0.14.2
Message-ID: <20250304-inline-cred-v2-1-7aa54011bcab@google.com>
Subject: [PATCH v2] cred: rust: mark Credential methods inline
From: Alice Ryhl <aliceryhl@google.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

When you build the kernel using the llvm-19.1.4-rust-1.83.0-x86_64
toolchain provided by kernel.org with ARCH=arm64, the following symbols
are generated:

$ nm out-linux/vmlinux | grep ' _R'.*Credential | rustfilt
ffffffc0808fc540 T <kernel::cred::Credential>::get_secid
ffffffc0808fc588 T <kernel::cred::Credential as kernel::types::AlwaysRefCounted>::dec_ref
ffffffc0808fc570 T <kernel::cred::Credential as kernel::types::AlwaysRefCounted>::inc_ref

However, these Rust symbols are trivial wrappers around the functions
security_cred_getsecid, get_cred, and put_cred respectively. It doesn't
make sense to go through a trivial wrapper for these functions, so mark
them inline. Also mark other trivial methods inline to prevent similar
cases in the future.

After applying this patch, the above command will produce no output.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Reword commit message.
- Link to v1: https://lore.kernel.org/r/20250303-inline-cred-v1-1-b2527beace76@google.com
---
 rust/kernel/cred.rs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
index 81d67789b16f243e7832ff3b2e5e479a1ab2bf9e..2599f01e8b285f2106aefd27c315ae2aff25293c 100644
--- a/rust/kernel/cred.rs
+++ b/rust/kernel/cred.rs
@@ -47,6 +47,7 @@ impl Credential {
     ///
     /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
     /// returned [`Credential`] reference.
+    #[inline]
     pub unsafe fn from_ptr<'a>(ptr: *const bindings::cred) -> &'a Credential {
         // SAFETY: The safety requirements guarantee the validity of the dereference, while the
         // `Credential` type being transparent makes the cast ok.
@@ -54,6 +55,7 @@ pub unsafe fn from_ptr<'a>(ptr: *const bindings::cred) -> &'a Credential {
     }
 
     /// Get the id for this security context.
+    #[inline]
     pub fn get_secid(&self) -> u32 {
         let mut secid = 0;
         // SAFETY: The invariants of this type ensures that the pointer is valid.
@@ -62,6 +64,7 @@ pub fn get_secid(&self) -> u32 {
     }
 
     /// Returns the effective UID of the given credential.
+    #[inline]
     pub fn euid(&self) -> Kuid {
         // SAFETY: By the type invariant, we know that `self.0` is valid. Furthermore, the `euid`
         // field of a credential is never changed after initialization, so there is no potential
@@ -72,11 +75,13 @@ pub fn euid(&self) -> Kuid {
 
 // SAFETY: The type invariants guarantee that `Credential` is always ref-counted.
 unsafe impl AlwaysRefCounted for Credential {
+    #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
         unsafe { bindings::get_cred(self.0.get()) };
     }
 
+    #[inline]
     unsafe fn dec_ref(obj: core::ptr::NonNull<Credential>) {
         // SAFETY: The safety requirements guarantee that the refcount is nonzero. The cast is okay
         // because `Credential` has the same representation as `struct cred`.

---
base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
change-id: 20250303-inline-cred-1d1050785e5c

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

