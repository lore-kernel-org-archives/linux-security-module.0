Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B79033ADAA
	for <linux-security-module@vger.kernel.org>; Mon,  5 Jan 2026 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767616986; cv=none; b=mKzc9N4tC0Ii6XMJ2TXk+smdmzAIHtfTn7gpVp+qBOm+CWqXCCemL/obmU9G2wpE/2ihto+ZieBnJ3yvZaxlluAXeTqTIDcx7M6UiYmz8ZAaujCO6tSCn8zqC8uVNihqsbL+6rS0HovAa01QlpsCC1y6kUJRSCp1JUOvhpQBsR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767616986; c=relaxed/simple;
	bh=XJDth+sPXzvDab8A/vMoxX7pf/G+eV6NUOZcGtDeoCo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R8qPd6eBaSfSfeBXuZDGXGarqIs5Na/Z1Y8zK6FkEETgu5wRb3F3yFBgzxX09QBauagAXM8JcEdu0dMTSmv2IuPQkW3ks/0FABjSEXMlSJJSRM6FJupN80HIP8IFrr29zwQg9cwsyYwuYke64XV1gctfHCXMyRoiVTBFO9OKP1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TxHiEG3t; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TxHiEG3t"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47777158a85so155092425e9.3
        for <linux-security-module@vger.kernel.org>; Mon, 05 Jan 2026 04:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767616983; x=1768221783; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Frdd68Pz1CT1ixXQcGAA+0dj7YFabKIGS7lflaVt9eo=;
        b=TxHiEG3tCuicGM5l4fc4yh7ulKIjWjKMR28ey+AfaY7g5FEcg+AewCsTVBdxveTTEU
         VARfJjBjr765o1SHjLe73FMLi/sqZv5ZCGRFH8oJpXma5tu8frYo3UqazaoniD4j1NyZ
         zthACvE/0Dc+OkDzq/Vn87CgxeFjQAcRAzsCpUA4n/IgeFzHXpVY5mTQERvbhf3IjpDh
         GNiVK4185Iwq60pjJuSe+ExxJ2cY8iFonQMPwClbKo5dCVettobPIAXwJ9SIRNkq3Z/t
         SrFqvEpsGmdLLYjEj/5b0KA96XjZHoTZQV8tXo7IZOWi7zY/eCyEOmjYKRO/n1Xee7mc
         0Kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767616983; x=1768221783;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Frdd68Pz1CT1ixXQcGAA+0dj7YFabKIGS7lflaVt9eo=;
        b=PNFwPFjdcU7hRGxPb3Byj6UM/gGCUegcepK7mYLdJyMtK/ZDmwTVG0OW8z+Q8GC5x4
         +lFiwfC0xrk4880R/JqzTXXEQO1gL29A/4YyLKNp5wWoqx/g3sNPIGSR2DD1t+HV75zV
         +w8qVQhYOBUBjvg70nl0IY6/lQ2ndce3dVs3so4jePd3TObH1D/hzzT5cD4wvjswlzB6
         6V/rQjSU98t+KIZ7rfTKjgk3zfPBwJwGtYWhGQuQcT1apWF6yODbOCL+dcr46smpL+jt
         0MxtRrdF9gbjvt8BhhRoTMHFXNDid3aBU9MOad2D0QEr8BN3TPzIiqjHpODQw/UAjIk0
         z8cg==
X-Forwarded-Encrypted: i=1; AJvYcCU+NxnZSRU3NfI/1ieFmDm9nrIEZ/o2t1wPtz+sL4BmwHRn3H2iiKVbASUz1lv38tnWdzxpsRW1QNXyy8qXAHZTFagM9Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyprHmZOB7CW2gbktPl7TfZyOYL0SOP5opy3hFvSO2O7in8ajx+
	ywwVgakgBi1nnjO4cZtXq6f0JLzZOxbVwKZO4Stv1IGtmsN/oCK4E/kK0ZTjpMqSwTg8DuDS/Kl
	NO+zRH5GGMLRX5/Be/g==
X-Google-Smtp-Source: AGHT+IElABs2fu4mBasa4gNBDtT7xHmiBhL9gcdCCxp3ToshdVXpOHPns0gIRzLgWj3whcaar++xDr69z43i+qs=
X-Received: from wmdd17.prod.google.com ([2002:a05:600c:a211:b0:477:a0e9:dc85])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8718:b0:479:1a0a:ebbe with SMTP id 5b1f17b1804b1-47d25082cc8mr555397845e9.14.1767616982737;
 Mon, 05 Jan 2026 04:43:02 -0800 (PST)
Date: Mon, 05 Jan 2026 12:42:31 +0000
In-Reply-To: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2604; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=XJDth+sPXzvDab8A/vMoxX7pf/G+eV6NUOZcGtDeoCo=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpW7G8insy9uiAoqQQgCfqVrdjL3I1134oJ0Qis
 /W8qmTNGNqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaVuxvAAKCRAEWL7uWMY5
 Rh35EACbQV0euux11CERYl55eWlBL+CofVnpPsFMaPyQ/VQoZhzbyGz0/AuS24aBUrIXZsfSBhr
 tQP2ejSIFrqw4RgFPLR/+HH6HPtkIYR6yvAH7LXpM4GrX7lYj/1zF5+yioEf0KQpQqmlW/syYUN
 aIdG2cvGS8UpDtuZHA+2yvSOz02Y13oZ+rSr4BXTP7+/o3bKjaxLaB5zilnyA95XGAmpFpaLWU/
 1TT7xwMAByqOF/0Mi7OEV4iO7LU7vNVtc/8cRwqFAW1Uoffv+c/1+R908FcCAzkqneRenz/F87E
 prT0thQNyB0YdXGQHzdS059VU44IfffzC8Hkw8kucllk6KxY06UJSDpBu9390WtRXU0D3yxl3tt
 06m/lB5ucLuiuMT1TqlzH56pOnG1+Ur7qx6LKGlhMkrTV/Iq2emsrK2AudHkxExKIpZuClqVJXZ
 k/fHM4xve+f764qlO0fs2FyRdx59aBkiuweL8JZR0oMUeEjd8ZfHbTLx93SJcXvcthW7Ew5MJiS
 eyKDEsar5NpTxQiG7Rx/vzhj85UytVhoG0X/jV22JOtVVLDxivua9gSD2xVVM87Ub14WWjME/lL
 G1XOJ9VLnPq0Ddn3oyROUmVPicKY9AryASX7lRYXg2C+i+2flLaS9bgIOmoU5EKR5dGL3C8NfiJ KkDHiCAfYfErKag==
X-Mailer: b4 0.14.2
Message-ID: <20260105-define-rust-helper-v2-18-51da5f454a67@google.com>
Subject: [PATCH v2 18/27] rust: security: add __rust_helper to helpers
From: Alice Ryhl <aliceryhl@google.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Paul Moore <paul@paul-moore.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

This is needed to inline these helpers into Rust code.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Cc: Paul Moore <paul@paul-moore.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-security-module@vger.kernel.org
---
 rust/helpers/security.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/rust/helpers/security.c b/rust/helpers/security.c
index ca22da09548dfed95a83168ed09263e75cf08fd2..8d0a25fcf931ac6540a986aa10187c345614fc9e 100644
--- a/rust/helpers/security.c
+++ b/rust/helpers/security.c
@@ -3,41 +3,45 @@
 #include <linux/security.h>
 
 #ifndef CONFIG_SECURITY
-void rust_helper_security_cred_getsecid(const struct cred *c, u32 *secid)
+__rust_helper void rust_helper_security_cred_getsecid(const struct cred *c,
+						      u32 *secid)
 {
 	security_cred_getsecid(c, secid);
 }
 
-int rust_helper_security_secid_to_secctx(u32 secid, struct lsm_context *cp)
+__rust_helper int rust_helper_security_secid_to_secctx(u32 secid,
+						       struct lsm_context *cp)
 {
 	return security_secid_to_secctx(secid, cp);
 }
 
-void rust_helper_security_release_secctx(struct lsm_context *cp)
+__rust_helper void rust_helper_security_release_secctx(struct lsm_context *cp)
 {
 	security_release_secctx(cp);
 }
 
-int rust_helper_security_binder_set_context_mgr(const struct cred *mgr)
+__rust_helper int
+rust_helper_security_binder_set_context_mgr(const struct cred *mgr)
 {
 	return security_binder_set_context_mgr(mgr);
 }
 
-int rust_helper_security_binder_transaction(const struct cred *from,
-					    const struct cred *to)
+__rust_helper int
+rust_helper_security_binder_transaction(const struct cred *from,
+					const struct cred *to)
 {
 	return security_binder_transaction(from, to);
 }
 
-int rust_helper_security_binder_transfer_binder(const struct cred *from,
-						const struct cred *to)
+__rust_helper int
+rust_helper_security_binder_transfer_binder(const struct cred *from,
+					    const struct cred *to)
 {
 	return security_binder_transfer_binder(from, to);
 }
 
-int rust_helper_security_binder_transfer_file(const struct cred *from,
-					      const struct cred *to,
-					      const struct file *file)
+__rust_helper int rust_helper_security_binder_transfer_file(
+	const struct cred *from, const struct cred *to, const struct file *file)
 {
 	return security_binder_transfer_file(from, to, file);
 }

-- 
2.52.0.351.gbe84eed79e-goog

