Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EC933769A
	for <linux-security-module@vger.kernel.org>; Mon,  5 Jan 2026 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767616971; cv=none; b=QAVqZAEHDkwWGVWpdY9Z89UtnQMFWEF2ixW8CmlifGqPMxxdQ0V/3hBDhUqpHzXI9vIY7w2IdqaNv1qoaTvU6Y8YPLeYBXlahtHcW7QjjDpbLOLd5yVSEiKYQnJT8lNpAw2+TjFKM6u816FS3YUAfyPF7lHvyykgOI7Xygd8slw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767616971; c=relaxed/simple;
	bh=VbQO8D2iAr6md4hBhmn/NGgmQ1GRwF0Hgf8inuSVV2s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QbkZFxjI8vtRNHoLuRlEaPF6zGwePkhQWwZxFtrTEOsuEqcENUkvMyOwPXb6GlLaS5qBg719hvtfmTBX1DPW1v26woCDMh+EKS8FWjSmi5zU8jL10+Bpld44FPVrPWxs7FxgK+OfwYCBJYJXVWvCdeVqXF148GI1NoT2Phr8+iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xb6xyMR5; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xb6xyMR5"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4779edba8f3so113015045e9.3
        for <linux-security-module@vger.kernel.org>; Mon, 05 Jan 2026 04:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767616967; x=1768221767; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mk5Ycm28hIYHxTsDaCVqW9TzFl8aqhJTKbC0p4I2uF0=;
        b=Xb6xyMR523gUlzsh09VKVnIQO2JEQAMtPgk9HgRJrr7G2HM8EQ/5PiTi46u6ViJsbR
         p9Baddf00OOyfbteeBGW9JBQaU2E2umZIFCWlW0AjOO6SrrOXWj464KaLAX0XdvI8a4F
         hRqjanvfuaE2m1nnNE2lHy2a5257Bpyu4OM2AamRViYHlRGt1l4oiJsWXQtoLszlVwhp
         tBeyBsphFykDHDyKQ+aAnNjgtdV4HtJ94E8XKf4ctMwICI0PIVvmanHr+w1PSgFDR8FV
         kcpOnCYmFBlI97nPeALujK2fxTyWukGbgvWjDBHX7Vqft0HxlUOIjYgjThIaxjv/MLjE
         aNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767616967; x=1768221767;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mk5Ycm28hIYHxTsDaCVqW9TzFl8aqhJTKbC0p4I2uF0=;
        b=JGszUAph3TGHwTyyE9oz3GfyjV3Eh5Ymt9/c+RX2e7eEmHt26BKreV58GeJU1G5Zi8
         nW+VxMD1pPqPHkHB3wuvDW1RUu5PnnX2wyEK/aRT5Cvvxl6FlBL5FAYBLGZv+qb3GYZG
         5QMxyUMBKeilZw07eMyo/OEdxRakCuyeZS3UOIWKC9doK07zFID+o6Es6cDzstjHHTss
         30VweVA2Y1mdJLqyNKX/gUi5qOFNijXAQlfkjoNOO3Cc++jTrmxsSZg80GgbwpZVaF8n
         uSEd3hT6nxI7uR1Ke7gKPPhBFYmzH8xhNkHx3DjBD3bo2z4Co5qEloKNdh145iWVVT1I
         pSRA==
X-Forwarded-Encrypted: i=1; AJvYcCUjEn2PAH+xofMLSQENsc9eHZfwX/ewqV8FHPI+sYedlc16jfXQsuCairXX3ZqBJUXYIVhu7myjl1CpRAnch1ME3mrKNcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaEHTI+/q1espuFGPHpl/tUqdI+aCSXAx82djinKqnMJZkSnSg
	Sb5Y3pk1HsD6Vls07EE4VsA9OF2RB4x5zz6FlYimDHpMDIxoojPTn7LG6dJ4HyCzIKyHPyJA1nq
	4dR46LSEKriaZ/TBWKg==
X-Google-Smtp-Source: AGHT+IFXejFNTaaTMK6NB9LtQQMCPav08dwDcr+UaE1CM7qp3nZ+shXwfmslVq4IDm/pw/KKVEDRem3vj7iQ6AY=
X-Received: from wmbf6.prod.google.com ([2002:a05:600c:5946:b0:46e:3422:1fcc])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c494:b0:47b:d914:98a7 with SMTP id 5b1f17b1804b1-47d19582a05mr562157035e9.29.1767616967436;
 Mon, 05 Jan 2026 04:42:47 -0800 (PST)
Date: Mon, 05 Jan 2026 12:42:20 +0000
In-Reply-To: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=VbQO8D2iAr6md4hBhmn/NGgmQ1GRwF0Hgf8inuSVV2s=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpW7G7xiG52Kq7HkvE/zsYwVfDQYUWBBy8h7V7N
 WNZ+OcmviuJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaVuxuwAKCRAEWL7uWMY5
 RnxiD/0WpbhztWk/Y7Ztogunp/taSq0RfvCk2REjL0ilSu/M4Uguhg787+fVv1uySd2CIlEXQDp
 uiwortuxv6Dc+3lXQpPyMFYWUU6TF1tM9WlgmC5opTi8kTfF1oS78EVkcj0CdVU4oRiPr6YFiHz
 UIzdTtJlr/SNSplU3uxYSPpxU+vAJte4jwBVuGGPtTrxZRVuKDhkpqE0at9FnNDxqHDvFKQNKQn
 G8uSVUqQJPT1pN3RlxcwDZG1nkIK9MkYtY06Tmjc72389snwjyabK8NL9Ua+xhk6/3Wdscctl1C
 szVVYbT0Eo07Aeze6S25CViEA7ZHpCWOEskTQ3NhzE04EyCMH8wH4mcaf86qjxzZF5KksGMrsqN
 c/5c9C1otKr22zjR01xpGdFtokwxFmBdrSf1lQa4rwGDi3x+MgoWww2dhAnObw9v+/NgxIPhLTP
 B87gsXdaoyDSr8CFHJWwxSFnyb30wnUKNeVr+mPtqkvyGO9cn1IAw+pOh2kpon7wtfGSSKf9hg8
 eqrWeW1XDXK7vX11AWtaiQeAZJW4qXdurxG7i8n49YPeF5xrf4uSg2xqMwsrRwp602TYhhdnk6W
 cEktWbCFC8Tlu5LxcjtTpOlmDt0dyTVx7n06CocEHazp9xxlehpOletIlzMG4Su/4mxBy9ERypA yJzBiC1VpZzcgig==
X-Mailer: b4 0.14.2
Message-ID: <20260105-define-rust-helper-v2-7-51da5f454a67@google.com>
Subject: [PATCH v2 07/27] rust: cred: add __rust_helper to helpers
From: Alice Ryhl <aliceryhl@google.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

This is needed to inline these helpers into Rust code.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>
Cc: linux-security-module@vger.kernel.org
---
 rust/helpers/cred.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/helpers/cred.c b/rust/helpers/cred.c
index fde7ae20cdd19f04ac5f28808586c65de6b72f09..a56a7b7536232733dcdc640f09f8f2537e69d75e 100644
--- a/rust/helpers/cred.c
+++ b/rust/helpers/cred.c
@@ -2,12 +2,12 @@
 
 #include <linux/cred.h>
 
-const struct cred *rust_helper_get_cred(const struct cred *cred)
+__rust_helper const struct cred *rust_helper_get_cred(const struct cred *cred)
 {
 	return get_cred(cred);
 }
 
-void rust_helper_put_cred(const struct cred *cred)
+__rust_helper void rust_helper_put_cred(const struct cred *cred)
 {
 	put_cred(cred);
 }

-- 
2.52.0.351.gbe84eed79e-goog

