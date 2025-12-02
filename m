Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8B62EC542
	for <linux-security-module@vger.kernel.org>; Tue,  2 Dec 2025 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764704288; cv=none; b=KjfS8avICfhjhIvDRDeFaRLHrd4iNqUi6BxO44I3+u00JR2HmAr6LSJEvwxSjQroLXv3qgPVHTUCpzQZihKPAm1Uv7X3gzZsqie+3z39fvWBOAE6nbrAr7cWOJoeVS9BgmcqE1ztRC7yI8dlTmBZTixlT696QvjCwyDc1tzlH9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764704288; c=relaxed/simple;
	bh=iagzukUnDA80z6IbyS3VNcLRgqeZOme4pi+pUnCTVcg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T2HZvOp7RKXpi68JhzM/u1pm+/J8LS642spYNDu8fTux0QP0Fr9+11m6UahnW7p5UPHPrqo2+RaHJhgrN5yDC0T1C/H7NxEC+DIqx4tm5W3WyJQfoT0VEdK0jt4NY/9bY2xJWxemMp2TaQrw+Y8C36VEWTBU3frDlhvVlEEW1gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PZ4p6KQL; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZ4p6KQL"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4779d8fd4ecso689285e9.1
        for <linux-security-module@vger.kernel.org>; Tue, 02 Dec 2025 11:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764704285; x=1765309085; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gEt9qTAed3TDa/k2bHDc1mZBoMnzLbB/7WUiQnq55ss=;
        b=PZ4p6KQLVrpZc9Q7dtpn/Z1K/ZJ1huOt1cqQm27TtIZGwiaExfwuieSUaMw5FH+1Gz
         uMvnUHod5brmXOjI6ibgcVlS/ZXKaW+KTnJ0UmEWPXEJqiHm7DnqoVdg3fvqCorRt2Ez
         zLM0SFxBZyWayb/tkp1+ngp5OWho282hxzHn4Vmd3lRkOy3u/yJd+sTGg/TuChox42HP
         1hoFv0IvtcHCRKtJ+8MhEir2HnXUXMTBV+cGY3iYS8g3SzgqO6mPZekWxHIZMFeP9gbz
         me1Tt7G6HAkqGJGKeyRBuNnerTnNM2BPQmlTbJsFTBVTpcOlS+l6EKu//dGEQAojt0jH
         dEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764704285; x=1765309085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gEt9qTAed3TDa/k2bHDc1mZBoMnzLbB/7WUiQnq55ss=;
        b=FvT1dAW/Q1+yiuoUzFl1vboO3rihnMEt60pH6uLrqNmV5yqEbgnre8fzVzoKO11Hd3
         dG7gceCJlg6SKLp+zUGqLr1StrbTMgyUSCasfq8YRFCF16+E/a2kG9bgFASuUhO3z0oL
         vB4ucnFbh7mcZqKi/j51oIekFncp2NLS6AXL/oCo7UkjW0xR30S2GJKUkUytExfju8cQ
         T5TM9HWoqD10YQ4WqzNdlqICTtsBstmSJxq73/PVcjjNZK5zyrm0d/IjlRfsLTXJlwCg
         7L6HAsRkLY9aWyynvEqsXZt4TT+cW5CGkaC5vt1cnSaxJ8zuMT4u8xX9HWKM9ecNfnDo
         +LuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCQzFxMcpFy8AIRyy/JAtZHI7NZVcDnvz0IZN1ONeIOauMWqaCcizvNW9I5J+7XFugKfyyxSikaJz8jTNm5friPxfkzEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRBB/YaUwkvdlaHlvWBuNEv0kitEnIBM++B/DUrgPEgU9f1CYf
	lcYzzdtuqmVkDygOSHjmp+pfgdK7/2ecjL1X1Ubx6SyLuNJva19foOr2J2znRJLCriCczS1efkH
	VQSUS2DrGlWFZEOSM3g==
X-Google-Smtp-Source: AGHT+IFTGXZdDwu3G/FYzKsSjoitBd4kosCndgymctVZs7SCMI80OF1jOg2y6FFY3lnd14Jki4pIxhg01wisrl8=
X-Received: from wmxb14-n1.prod.google.com ([2002:a05:600d:844e:10b0:477:98de:d8aa])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c8f:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-47926fa069cmr44892965e9.13.1764704284837;
 Tue, 02 Dec 2025 11:38:04 -0800 (PST)
Date: Tue, 02 Dec 2025 19:37:37 +0000
In-Reply-To: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=iagzukUnDA80z6IbyS3VNcLRgqeZOme4pi+pUnCTVcg=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpL0AIOAFMvsxtRspJFDSQ1QA/MeXCtacEMkSW8
 Jy3aMyERtOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaS9ACAAKCRAEWL7uWMY5
 RnXwD/96L30+UxevVFRGYDp4D1g5weISgc49MbZoQnqoU8aUeMRIXy0Yy+SuWLQxEfdhVHfNAVZ
 +gpu70EzFzT1HZIXeYY1KR6mQKBpRM+CDQHsbUvaHbNMqJTh3RuwIzWtCQuOANcqskEm/NDklZe
 KBlbtFyBbJClP7wZKR4QML+Q90ncY3RrLjYUGVtB3mR7g82sZqPW0IhKW9iwLbWYsW8dXL+L4AD
 Npm6ENjgAb4xsfxAAo6Ojo0ALHj1qHh7cJ1xCWYftWng1mTYfs10v2+rGiOO/UYRf6taV0yVqUU
 PQt0VzwjRzEKSjC4KjuRc4Kw6EaJh2OQkTcOUYI1IHqm6XplzyywMQUvfjVBWLIvUYG+y9upFe7
 u4IyM9oq/o5n0K1juDgRFtBxl6uodax6rpaoHxzLWXx0fbUfLmw4gq/FEjeHhENjarW84/p3Amv
 bJphs2/t8US006vH2WTqzhGRPnEWI+FhzE8jSWhpfhtGTGDBbbipR0rVvyvMzyQPpBci8wi0N9G
 dih2yiu1tiFjmxmvog0sP0m05Xdovxg0ibApsHQI/fqQco0ALOnyr3XCPfcibA4Ov1wDJZz7XUF
 r7MUALzWuNDYUqmdBpL3NAwlPVSJC2tYeNveDiA6Oezp/ecteK+Ef0Cs+SCHVNOkMDJl48Xezus 7l/CZCZ6x+wgr8A==
X-Mailer: b4 0.14.2
Message-ID: <20251202-define-rust-helper-v1-13-a2e13cbc17a6@google.com>
Subject: [PATCH 13/46] rust: cred: add __rust_helper to helpers
From: Alice Ryhl <aliceryhl@google.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

This is needed to inline these helpers into Rust code.

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
2.52.0.158.g65b55ccf14-goog

