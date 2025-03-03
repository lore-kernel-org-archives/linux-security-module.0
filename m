Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60FE2222AA
	for <linux-security-module@vger.kernel.org>; Mon,  3 Mar 2025 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015805; cv=none; b=R2n8tfVg0pdUlKn6XWXF1ImtrLnJ8XMcKSmiiFCk14teYokJUTa1x7tt70NFzL4UCfnSdH6vRHCFtXjfoH7bjhoEx9Yc9hUXNB1h7wk3AMq+Laji770T1akeLAANLKRL0uQxjSFY6bY3cSkmri6ONfnxg/6aD4d9BM1/YXnz/xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015805; c=relaxed/simple;
	bh=M2BzAH/H8oyYfF05WRy1NP/V+lCHnDVMr1BBQkvQmeA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cAiCfVII3bTMJMGhm8p57bwCGAUVb7LBunLgFvm1yVaV7ocpV3viIB6PLjncFW8AhoDqg+A6Dtp2ghscxZS5hbXyy3Z2yLcXpywYYqQDF6VuzNLsLycH1N3smuFxfgkcQidL4Fmwwh529Al+m/1o2fh8g6UFmZaZwf2RjM60Lro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gHuZqElN; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gHuZqElN"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4399a5afc72so20404605e9.3
        for <linux-security-module@vger.kernel.org>; Mon, 03 Mar 2025 07:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741015802; x=1741620602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=caZM8ulAJLpPxwqARELSVOBypouHfuE96bXivT9t7vI=;
        b=gHuZqElNk7+B+xzkXR6J4FSFUJ454Kscp/eyGI296JQvgklBd1YQWrFAanAwmGAxtt
         m/MfWtIyp4kJBue7pbglwnu1zCiKIaihhHVqu+CyPRrn2heBU3gv9vjvHo+gukODO8yZ
         ue2UrdCUgUahdjP2kDipAH8qaQx4Qzw5ZkezQ7YIU5OssdJ5pcHGCTH+UaiwCfgr5Psl
         4UXij8+XlQgc51l4gkUoNu43BeAc0I4SV8BtbLivwZdDfPSf6orsg9obS4THxHaFOCY2
         dNIJcRnikGmNZZFMCbky8kK7BCfbcLQKuwHczUruuihZsstKbbsQp9PfXRXeTM7AxFLU
         zjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015802; x=1741620602;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=caZM8ulAJLpPxwqARELSVOBypouHfuE96bXivT9t7vI=;
        b=D8otGA4vTy0FJ66yYrkcLmzAgha6gyWLUEJIsAp6iIH/y0ahgf+2X/nR3Rhgd/pamI
         BpCDl0gWyMn9yZvGixZNYK2/o0w3LmAS2ZV6X5HGwLE17CEESJlzvnEnQykasWveI4PI
         QVZsuJ6Ewq1XI9FGGCxthufpuW0ak2eq3EwgUYuHxLLZWBbPW+bEo+cbL2s9nhtjxE3/
         xt6U4oYTSF4m6tparY/ntTQjUoxlxdnSsIUUEguhxDJ48BEh1c/XpKU3WbHz14AHGOZm
         6lyTE+M1ozZopTKaoKXYj8HkxjTtzS8MarRGg8qy16mVVMTQ1gJk/+pV9Z+LdZcm50ux
         rgNA==
X-Forwarded-Encrypted: i=1; AJvYcCXBd5znFqJvcysJe+Rve2kzPEku5B8KiqY1pcpeX9vAZnDZ4DY0yPBbO2hDJe/z8hEo5y5yM1vJ/kIEYbpIZbUraS0nExo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6NSkNavc20wCM9gHlEaai0Be1+bOZy3W8flM4vf7mDbcdE1FI
	VjaIFwASe8X8z7goc1u1Jms6y1uOWU07DUEi13Hb6DC9wo1SnJlrssLG+7n2gav+OkGMkle13ZW
	HrMCUSwZznt1EQg==
X-Google-Smtp-Source: AGHT+IEvrEmSDERvS2qqB+5i1YhcRepLJer3BcvKxJmllJrG/31CCHIMlY5mLja1zC7sgO1IiESOcYeMbOIdmuM=
X-Received: from wmsp7.prod.google.com ([2002:a05:600c:1d87:b0:439:88bc:d27d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3ca8:b0:439:94ef:3766 with SMTP id 5b1f17b1804b1-43ba67606b8mr104598245e9.19.1741015802220;
 Mon, 03 Mar 2025 07:30:02 -0800 (PST)
Date: Mon, 03 Mar 2025 15:29:58 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPXKxWcC/x3MQQqAIBBA0avIrBPUSKirRAuZxhoIC7UowrsnL
 d/i/xcSRaYEg3gh0sWJ91ChGwG4urCQ5LkajDKdalUrOWwcSCbCM3J+MN/SetTorO11Z6GGRyT P9z8dp1I+BbTQC2QAAAA=
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1936; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=M2BzAH/H8oyYfF05WRy1NP/V+lCHnDVMr1BBQkvQmeA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnxcr3q4/f1Eh+mVvx+bWb74mJwFEmQclGeaR4H
 6BrWuXePv2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ8XK9wAKCRAEWL7uWMY5
 Rg7XEACJZp3zV7TOxcbAhMiyi+QxSwxsKIWm0z5mCiE9+IeVIiRM0mr9KJybwGBBZV6fceHTyNp
 vSNQwqRR1/WawtpXx71vDBrxQP5MbUxLt+b2H4Kk9EwzWacbU6Eevm+w+K5DgoGBaVVWRo+b2Zg
 5zhx9HCj9GMTYfxU+hBZ/d1atafW/55SrtBEHmU11BdoB1z8U6tcroTNR8IiXBMplyqiffpWE06
 7c0Yu71HHNE1XF3ZfKLj2rL4TPefriva5oA53IaiAwogzGrDbO3IPiaeovkQz5EUiwh4k0WW3zk
 NXK6vTpRf8uaqm0wnLjLmh400aXX0VhG2Pix6l0pVoz7Ja2ADm334nMpsSVrkXxx1DivW4y41m2
 ic8xg1/6zolmSGUYpkbY1W+ui/MAo/joydXYf5cYMTelD6XSZLQYjQ9DQKwORm5c2BY7KDjAKwH
 fmmP31pv8w4TXNWayRWhNNhOyeRLJkKcjnBUs6wnxzNrIa8RbqHMis0YBz6sGsbVtN+XGc7y/T+
 dqQ5Eh4+cfwj7j4PGGMQjl9/s9IadvAzhZZmiteRiJWXn4duTt57dZ/uR2vCgxwxRgMTzUa/ccj
 uxv3TrbUxPckHCNtGKCB7OP+Q36tKJQhPrIP1/YEa2tsogs3ZIOJ7eq6ZplZZyqR+t50Mvb29AX TAjVN494qVFamCQ==
X-Mailer: b4 0.14.1
Message-ID: <20250303-inline-securityctx-v1-1-fb7b9b641fdf@google.com>
Subject: [PATCH] lsm: rust: mark SecurityCtx methods inline
From: Alice Ryhl <aliceryhl@google.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

I'm seeing Binder generating calls to methods on SecurityCtx such as
from_secid and drop without inlining. Since these methods are really
simple wrappers around C functions, mark the methods to inline to avoid
generating these useless small functions.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/security.rs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
index 25d2b1ac3833..243211050526 100644
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

