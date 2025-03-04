Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ED21F8720
	for <linux-security-module@vger.kernel.org>; Tue,  4 Mar 2025 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084019; cv=none; b=FkkWwHwWEcBUnks4HEGzQkZa6GiBmiZkwzqWJA54GzDWzMD5xrRYgUZ72zuFOCbek8M/34HgxwOB04lWRpFJt6SC7sZMz2iofcHr9rtdyjWl6c7WvXLwMiyooxn546tqM1sKQqX35/stzEhnZllN5IX96Fx+FeMM8zZEm47rWkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084019; c=relaxed/simple;
	bh=PcNgFKpvoqsI2d+GTVFiDpd0z0+TWHIXV0Sov3jinU4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JVJTQHC7bi2mBO7sHlFZpS0vvHhK3G9uRY8l7uYWR3eCT8dDIUDXNYT3uE37eUM0/WRIV9z3pCG4SD418qZ088g6Vam1s+9/RLsaMn8R80Eyb5gZMgeC6QPCmsVvmMSyd0zgbjkvf0Nuk4lkA3y4203DjbMRx+YyO4awFl7kt/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vkD8ifLu; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vkD8ifLu"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43947a0919aso49285775e9.0
        for <linux-security-module@vger.kernel.org>; Tue, 04 Mar 2025 02:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741084016; x=1741688816; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P91a/ScZPMObCTQZiDV75XYWZDr4e4/JP6vqUsEn9yY=;
        b=vkD8ifLuM5XxW74NOEw9S/ZGt7107JIc5ZFb1GYAEXQ1ZgL6iS5NTemi7X1jEY51s3
         qNwYB8a/55eUDUP2JCyM3by7aPrtCiPSRniQ6oc+NmwlSjisXC3CK3B9Src+gJcxEcVY
         ACyZmiedCly4PyM/pnxAyFZwNS/iZmiWXovEzBfELvxS405RYXiLSe1TBs0J6p9+Kya7
         TSuyPiY+WHxQeZtb0WLmoXIf1lxgLQ0sBJhEiZRZ+c3n9xFqyxjO1GtgXqhelwKd6G6U
         2vtJ633+6RVNsVDdf/JZTfxQQ4fTTiY0UWPyOmpxWjP129vvUI/0FM2edEX3UDRQ2byy
         SUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741084016; x=1741688816;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P91a/ScZPMObCTQZiDV75XYWZDr4e4/JP6vqUsEn9yY=;
        b=DKRgXrcLy52F+G6oxn21mCTn6ZH03iKuTI3XTPG6YcYqrBM8m0aMXJx3AD5Yyj8q44
         XxpXG5ndKWa/YjFVVOL/rtqRApQK5VZU+NOxMLo2KgqDE0T4Dt9TSGNyjh70JBzj1LIe
         ebSdszugUCRZYFPjz+/4ptkF+GZf26AVV9URtahUBydDM3wJasA+QezskWyjdguIyVtq
         ZAQ83fQ64fG0tXw6Hq1HudzoGMCfP3MyKFHQyfw0/ofwCsCjbFx6P3wh0tlzly/icfOG
         Hxl06AGMUwXZHs1OCkprcvSS3dIED9zexgePl6eTlIoHDAVwiyuMkAqoUTbo9BZWPcra
         zr5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUO/PXip69GUjF+qWYl6W0MH5rLMSj478O96KIKcBMoIthTEywwCMJ2rtM7wDHYcoaPvGbJG45FmCWh44g8d72BVDLjoZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkf3vYtAr0H0AV89E2Ovl+BstBZZkxd/XFY8ANYf492GWVNh03
	oZKPZaQRGXtKLi9wHH3aCUSlbOi9wc79tMbJc6YGc4DwtJxdrR+fzivtFrt/QOtewSzA3D/4+Po
	Yz1e9clbmxctAeQ==
X-Google-Smtp-Source: AGHT+IHHpx7TMZfBfYayuTaMrwBT4iKvqxmdwIi/f4Q36aLhBfvN/DU32Z4yAQaGBrgEJsvzsvjRPnOEEXl09JA=
X-Received: from wmbbi6.prod.google.com ([2002:a05:600c:3d86:b0:439:8688:5f9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4588:b0:439:9d75:9e92 with SMTP id 5b1f17b1804b1-43ba675c6dbmr143871395e9.28.1741084016018;
 Tue, 04 Mar 2025 02:26:56 -0800 (PST)
Date: Tue, 04 Mar 2025 10:26:52 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGvVxmcC/32NQQ6CMBBFr0JmbU1bpAZX3sOwoMMUJsGWtEggh
 LtbOYDL95L//g6JIlOCR7FDpIUTB59BXwrAofU9Ce4yg5a6kqUsBfuRPYlE+Ik8bzivwjhU2Bp
 Tq8pAHk6RHK9n9NVkHjjNIW7nx6J+9m9uUUIJZ++2tuamXOeefQj9SFcMb2iO4/gCrbmUC7UAA AA=
X-Change-Id: 20250303-inline-securityctx-6fc1ca669156
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2811; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=PcNgFKpvoqsI2d+GTVFiDpd0z0+TWHIXV0Sov3jinU4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnxtVtyfSswXF+elq/PY/YZLey2gZk8TxU2PQHe
 YomYEvZqWyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ8bVbQAKCRAEWL7uWMY5
 Rm8rEAC2faDraMM23kvkE7JyQFR57zHEShAfVjha788OSeCJ27XF7+H7nGC4jNPcNPBowQIwnBm
 88fJo42e3my74JAPjFWRpOdu33Oc3jgX+kfV0dEZu/fS+PIUIuOUeFgD52swaPzIqrybuW5HvQg
 cFswrLCysnpb8QmD8m0ynuzD3RcsBW3Xv9kM9nN4LxV2lyqPSTa2Wx0B5jO33dhbEaBNHe3d8Rw
 ZomDvL3XHh/dHAbQWn4hL+Firigxtd29GvVZTVs5CUmW4TrSIJewkQu9kLjFWZwn14A4/fe6u9X
 JKGJ9Wn6sKlcpS0/li95X2Hz5WiLlOoAYb8ZzuvfbXnze5FwGB8q/cQM+8YpkzBHO9WSWtqqz5Y
 Gg0exDhMCZqZ+OIeD+gXDOXNhMjPM1blEiuXLk+eWkSxnLeoyxTP9dAdMFgj599mqdI29EyNCGA
 C82fPg79Q32UI40Z14Ixm0hj7/RRFwVbOwnfksuRBHInBrqZP3iNidCqBtWsY/MunpRYnGLYU+h
 AfEHRHsJrJi0ktD1W75aJK7a9cwkLfrvzv5OjePInyjvzirGAanykDf3wAkDj8NSlcaq3TtBCoS
 H9t0Doz1Py0LvzdDyzUqd3FQ/nExY4Vt3XLKGvc0F+NUc9a/I99GKnpU6XFCypPGIgaRGWzdeK0 eA61rh3c0t7BhIg==
X-Mailer: b4 0.14.2
Message-ID: <20250304-inline-securityctx-v2-1-f110f2c6e7ff@google.com>
Subject: [PATCH v2] lsm: rust: mark SecurityCtx methods inline
From: Alice Ryhl <aliceryhl@google.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

When you build the kernel using the llvm-19.1.4-rust-1.83.0-x86_64
toolchain provided by kernel.org with ARCH=arm64, the following symbols
are generated:

$ nm vmlinux | grep ' _R'.*SecurityCtx | rustfilt
ffffffc0808fe8a0 T <kernel::security::SecurityCtx>::from_secid
ffffffc0808fe9a4 T <kernel::security::SecurityCtx as core::ops::drop::Drop>::drop

However, these Rust symbols are trivial wrappers around the functions
security_secid_to_secctx and security_release_secctx respectively. It
doesn't make sense to go through a trivial wrapper for these functions,
so mark them inline. Also mark other trivial methods inline to prevent
similar cases in the future.

After applying this patch, the above command will produce no output.

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Reword commit message.
- Link to v1: https://lore.kernel.org/r/20250303-inline-securityctx-v1-1-fb7b9b641fdf@google.com
---
I will also reword "destroy"/"free" to "release" as suggested by Casey,
but I'll send a separate patch for that change.
---
 rust/kernel/security.rs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
index 25d2b1ac383355941ecbe86bd3c505eb6517c180..24321105052648e150f2875bcfa5ef29f4249516 100644
--- a/rust/kernel/security.rs
+++ b/rust/kernel/security.rs
@@ -23,6 +23,7 @@ pub struct SecurityCtx {
 
 impl SecurityCtx {
     /// Get the security context given its id.
+    #[inline]
     pub fn from_secid(secid: u32) -> Result<Self> {
         // SAFETY: `struct lsm_context` can be initialized to all zeros.
         let mut ctx: bindings::lsm_context = unsafe { core::mem::zeroed() };
@@ -35,16 +36,19 @@ pub fn from_secid(secid: u32) -> Result<Self> {
     }
 
     /// Returns whether the security context is empty.
+    #[inline]
     pub fn is_empty(&self) -> bool {
         self.ctx.len == 0
     }
 
     /// Returns the length of this security context.
+    #[inline]
     pub fn len(&self) -> usize {
         self.ctx.len as usize
     }
 
     /// Returns the bytes for this security context.
+    #[inline]
     pub fn as_bytes(&self) -> &[u8] {
         let ptr = self.ctx.context;
         if ptr.is_null() {
@@ -61,6 +65,7 @@ pub fn as_bytes(&self) -> &[u8] {
 }
 
 impl Drop for SecurityCtx {
+    #[inline]
     fn drop(&mut self) {
         // SAFETY: By the invariant of `Self`, this frees a context that came from a successful
         // call to `security_secid_to_secctx` and has not yet been destroyed by

---
base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
change-id: 20250303-inline-securityctx-6fc1ca669156

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

