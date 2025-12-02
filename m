Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2002FFF9D
	for <linux-security-module@vger.kernel.org>; Tue,  2 Dec 2025 19:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764704318; cv=none; b=GETdofzjCHY9zQFpu2+621GxpJSO2ghFH0X/G5iuRpktQWh6tlfJUI/KJSh8ApDEmLYjVeiz/Iv8U4PqirQhd7w1k0KkqJeWVxeREQmcUJy9VFOkjR0GIpofQZInWZkeeesC1RGxfM1dGqoOMNuFtPCwmtm0XB12RMZg+ie0PxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764704318; c=relaxed/simple;
	bh=NEo81OnYLoeIBTiu58i1f5sfqGYGea/teY/C42KXlDU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cO0owTN0YdpB3fxAw7D5GdK7WfC4V9dagY0/zkZZQbZUKMxC6CC1dvSSguHakmMUFR9+cmoJcudS95gZrFeKjganp1Ub1Vqm7jLcnZuGz0R4kLUBYgwzAbYM0dCxcmdwnTaNTKyQQ0K/qxS3V/lYJ5Syu/C1JFV9gOKAyszaRfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XNrA+Xpt; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XNrA+Xpt"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47775585257so41064195e9.1
        for <linux-security-module@vger.kernel.org>; Tue, 02 Dec 2025 11:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764704315; x=1765309115; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FWykuHZToj66G/MxeF8fmUld14jo6i6LfCUhY6lHEoc=;
        b=XNrA+Xptfps6TlCRv8FrMm04ITOa95toGVRzsrRVu9UCFzLlbx/+bKdE2pSKEiEoln
         qA4SEWOvrZBILK0urCdm81KzjiF94K+co9gmg/+bgMEjMWAmkVRli06biyCIX5XTDnXz
         pA4VeplSzUX6Tj09vOAxYAcPoFcM6KyhUPxh51pPHXQr/VifJnlNLZ0USvmUZ9tSJbya
         QQ+sHkSE/Yp3r0EH0eOJNIZIGyZCOZJz9rUZ0kk1uFEYbpOUqP0BdQTMWpskajWy48QH
         du1UrGWOgUkvZvRhtd79rKulWraxFYb78R1/hJ2cCqNr6qfOsCpWxqw+HvhHEOrWnuk8
         pfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764704315; x=1765309115;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWykuHZToj66G/MxeF8fmUld14jo6i6LfCUhY6lHEoc=;
        b=IHJwByddMzhgVSUuOEgCn7RVggkWxQgx1GdMx2z0A52vshPX0pwzb2gPT1dHv+Tzd5
         XpMDqTeAw/Su3u1rJjIJXtxYiYt4hlhF6GNawHdHnKJOO9CdbBj246jP0VVErr64fCjP
         kHUEUsPvLdQWNzPcEtAt0fzR0Ewmdnv1dOrDLTPY4+Hf11q+6sJutdQrd3enuYp8fhFO
         yCsUwJHidABgGjobf2TnYB9qgLRa6lJMO5Bh33sS3Csg1+Dq//5T41cwNd4DxJzDcUNg
         vyXf7L4bNDZb8TgMb5Q1Wlfg85ocD0EZrRajOYBkO6xrXFWaRHPhZ/GS6B7YUAsiv4jT
         q3DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx12p/xFKWF+W+PDchu3XLIexcyIaxm0ZXxiTGxlvEqkWa+JvUXZfFoHFwZB40qEmL/4+jltMIAdzBYZP8aNbcjp0gmFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3EWMW/wfrcPQWcX/l+KPCJUYSlNWtQY3ULvQsFd+CWQlhy2oq
	cADqasgnsxp2r4H7EWX0E9VQoBytSmjkXS/Q+pH8dOSn5KhxNNfDAo2MwQjUMql5njSej+udeuI
	0YHJNMNnjXdreZy66cg==
X-Google-Smtp-Source: AGHT+IEd2aHrb5NkrrBlEoHDtMpEDioA8uFicuIXJpZO5WFmKYX6kDMfylQzv42mf+aiELHL/3qdX29f5o5sJxg=
X-Received: from wmlm9.prod.google.com ([2002:a7b:ca49:0:b0:477:9e14:84dc])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f54:b0:477:54cd:202e with SMTP id 5b1f17b1804b1-4792a5ddbc1mr7612815e9.2.1764704315304;
 Tue, 02 Dec 2025 11:38:35 -0800 (PST)
Date: Tue, 02 Dec 2025 19:38:01 +0000
In-Reply-To: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2514; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=NEo81OnYLoeIBTiu58i1f5sfqGYGea/teY/C42KXlDU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpL0AK8URMtIpbheqidlvMIeVO0gK24Qbdyvh75
 GwClIA6TteJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaS9ACgAKCRAEWL7uWMY5
 RuU2D/0WnwWgQZA9mqsxQSZ5+ysBzw7YAjhiHjpCxm8QP036iQNj420B/8MZXlJA6w8icApJGVa
 Tk4+jq10oOHx2tmzhJf2BYaCOpjNDKFCkDvaDujzXujA2Y4/5XutVnlYUxX+0deQltSVTXJCcWP
 YaurQT3hcT2i2cK7QsFwRyhlIYajhFvxACU0w6XRqiKIjN6Jywi/UfMSTbuL9g0BhM+EQ/e88MG
 hk2aKgwU5elQaKIACdToYOpcowYoddLeW0id0B3b7W4CN2Hpdk/NqKenEodFB0QDolVxqu+Qd5V
 osbEWmOBFlJLsPl9HnxJvtLdvm+GxNlKQSSMzBQDxgp8k9Czr7XwzXIkjGwNuxNPW+eppKqY2n0
 kNbFCUiDidFtPcB1cOPIKYzRVemnxBzs3I3g62c9Pfcxe7nynm1chbACnJBLQ9EpvDxbZSY54YY
 v+La0mP+sTZK/WucAvfJII6tPT7fOUwpyOJFsKu2jPXPP416SCBTZHrgNRRvoRyDWLn4PsyLQYW
 x6f1ZVnPx6PQ8dZB473oGIke078H88l9YeZmhDfE0fTRJCwksdXEWZW+kFl7aRr+mvmtTgp5xjv
 Zcj5wUx/mj4VEJcgORBSI8FDqjcwLHvdNw0xD0aECCJbhs6jaouQlYmYZ5k9Vxh24zI2sG+JPnw fFmxFiCY7Xc/FCQ==
X-Mailer: b4 0.14.2
Message-ID: <20251202-define-rust-helper-v1-37-a2e13cbc17a6@google.com>
Subject: [PATCH 37/46] rust: security: add __rust_helper to helpers
From: Alice Ryhl <aliceryhl@google.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Paul Moore <paul@paul-moore.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

This is needed to inline these helpers into Rust code.

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
2.52.0.158.g65b55ccf14-goog

