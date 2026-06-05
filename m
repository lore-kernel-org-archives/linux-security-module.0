Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373F83290D9;
	Fri,  5 Jun 2026 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675482; cv=none; b=tmbkyqEcpxAb5t42dpIJju2+YG2rVZeIWZhhYgLdMsVUhy6wPHK5RcGx00dEIgwX97D22gy0gCHZ9ypc3x6U0HlUPo4K3UbAfVPkg3dys3qRwKQF692GK+x0iMU7o3BrJO0JyY+50V8MFuBlcIUuKM0GUlcYZSSjvIy+XPnpddM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675482; c=relaxed/simple;
	bh=vsWbROpEGJwiAO9+bBrEo9kJ1z4oHpqhUD/sImXNRZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Nod1lvtnf91xnT5oBL7ULu6n7njzKOBKwEiYPJ7FRstqTmC9ecAzq2OsXXY549DhvxX/FiVN07LYSMzpvIvUJk4OfzbIO/uoDuKvBn7GRQHIaidx5bwzKgtK9Rnm73n88/vaJSFbUa5mToQ5ZcfHIOdF4tmOFdVFaTh/aWvyrFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBEKf9d6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBEKf9d6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7240F1F00898;
	Fri,  5 Jun 2026 16:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780675481;
	bh=ZvME5Cm5EErC2myByVcBHi0I0/kiVKGqTYnETmbRSoA=;
	h=From:Date:Subject:To:Cc;
	b=iBEKf9d60dSA4dypE6a+c8hXSnazzq/WNUxVZyZQ4xCWnJxNKOIcse2nz3yY5lkd8
	 2HaDGDhoHOkYhmdzzNrLxJrwaHvmanZzrFK1ea24OE08d/fHyhqiWs/qMmNI2lqhF2
	 kpofPfsnbJdRpJq1kOlNWQW4yCruGHscz/ULVC5O5KEbQUm6ODzZRfS3kVUZpVtflL
	 14XFZRravr+JZyk/SmdnaQFnP0P0Pwl+VRrkjY4CtRIbiDBmDi0xD5SoWFsHJQgmgT
	 dQ9xQdSR3X1F8rbb1nbLa2kFWFpybWRy+mRLyPzS4TH/yCdAngDnzV/HwcT7pG3qMC
	 lEn/fwrBZ7A1g==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 05 Jun 2026 17:01:46 +0100
Subject: [PATCH] hardening: Default randstruct off with rust for better
 allmodconfig support
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-rust-reverse-randstruct-dep-v1-1-45ce9ee8d0d1@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOnyImoC/yXMQQrDIBBA0auEWXdApUroVUoXRqfJdGHDjIZAy
 N1r2+WDzz9ASZgUbsMBQhsrv0uHvQyQllhmQs7d4IwLJhiP0rRiL0mUUGLJWqWliplW9NGbaxq
 DtW6EfliFnrz/7vfH39qmF6X6XcJ5fgBYH1/vfwAAAA==
X-Change-ID: 20260605-rust-reverse-randstruct-dep-5a504c861128
To: Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538; i=broonie@kernel.org;
 h=from:subject:message-id; bh=vsWbROpEGJwiAO9+bBrEo9kJ1z4oHpqhUD/sImXNRZs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqIvOU7rsREQBrBgaLVObPVoOmwh6ZV2gPw6wyE
 GM//x8lSh6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaiLzlAAKCRAk1otyXVSH
 0NiVB/4pkPcGI1PaYfctTQLODF2WwN4ST9lqeJpqNKWRD/kk9+PtsDnCn2drbxEDKIaMrnXN/ya
 221utBsZ1sRTlMapPtKL2jJo6YxPFeSEZP8EKeTz6g7fN0XDKE/0QDdfDPCN8AKK1S5Ld/Nh/LE
 HYIAuvGyM9AHS4DEmtQUu4qAQuZIFjUqMHIyZ3/cQ8wmaC9XrRlHLGUg9LKK9N22b/ozFwstf1V
 KV6BUfDZt49dnICSNpnLHL1yZlcio0pW7VME3zT5cYB1iNxcaN4/bOx9kPI5od7Gy+5gzDINucM
 b+7fYEeMDdrWswaxAPrlF+UFWD2clAP0Aya2G2KzVmIWfcGW
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently randstruct does not support rust so we have Kconfig dependencies
which prevent rust being enabled when randstruct is. Unfortunately this
prevents rust being enabled in allmodconfig, our standard coverage build.
randstruct gets turned on by default, then the dependency on !RANDSTRUCT
causes rust to get disabled.

Work around this by disabling randstruct by default if we have a usable
rust toolchain, circular dependencies prevent us directly depending on
!RUST. This means we might end up with a configuration that disables both
rust and randstruct but hopefully it's more likely go give the expected
result.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 security/Kconfig.hardening | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 86f8768c63d4..1677c4f9637b 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -285,7 +285,7 @@ config CC_HAS_RANDSTRUCT
 
 choice
 	prompt "Randomize layout of sensitive kernel structures"
-	default RANDSTRUCT_FULL if COMPILE_TEST && (GCC_PLUGINS || CC_HAS_RANDSTRUCT)
+	default RANDSTRUCT_FULL if !RUST_IS_AVAILABLE && COMPILE_TEST && (GCC_PLUGINS || CC_HAS_RANDSTRUCT)
 	default RANDSTRUCT_NONE
 	help
 	  If you enable this, the layouts of structures that are entirely

---
base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
change-id: 20260605-rust-reverse-randstruct-dep-5a504c861128

Best regards,
--  
Mark Brown <broonie@kernel.org>

