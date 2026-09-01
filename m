Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AB52F49F6;
	Tue,  1 Sep 2026 22:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788303179; cv=none; b=TOf4slaGIc61gOQR5G4OxIYZY8FD7hbiSPkQVN9d86S72nB76Ktn+684S5UjHIMzWOsDenm7DgxDdYn9xKVSVUn8msIfIQlzPEyMkrSDeP3abFluVWy62oJvzRPh+E4Xrod6shQe0fXklzVph6iaeAS8VG+zhhm9v0n3wK0aYgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788303179; c=relaxed/simple;
	bh=cNKvgu/lmPJM4ixOs3dCfcoZ+BDVYU8oSxgE0VQtWtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eIEm/kPAI9bwF0uS99vs1y6DGRSHKK1PdwVjrWMCcXQfsnPd7Ow0FULuVJYvGdahhhCr8zDjyHbnecbjTbUF3nI1koMtwMvCUmAMr6by3Ozor3hXpxfERlIQtN9vaWGjPZn2Bht5QAS2HN4EkF/hObFdLq0y8miJ8qrsdIel8f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBNxHBty; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBNxHBty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F01A1F000E9;
	Tue,  1 Sep 2026 22:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788303178;
	bh=n1f4BxpHK9hO8LsGzvklPkEOi5mpKEL+L5A62czqZC8=;
	h=From:Date:Subject:To:Cc;
	b=dBNxHBtyC8FXbk5bdS4scnWqIqvU3rH1brbEggvfXVQjguplRGErGGmtbia1ijSH1
	 CC2yDdI4U31xJk3RnlYB/zKxNZh2N/SJg1HhMlyBoBe6K1n2bnzZTrED1B7E1kh7m/
	 rziZq9WwL4u6tFrDcNuvfFfNHVFspuLV6VdKgG2OovgpI+UHd+DCwguOajUAglogrK
	 33+xKwLgOadzPe5auAwmHPxPP7VxP1HKy1adsv1aca083ZLObHwz5UlZDYRwVxmZ/w
	 R/Uh2/HyCa8POncYmwxXpbR4+VLXbfmrbgceKDZLtSWbr/hySDKL97ANqrT4FiNasI
	 64Ap9hLbXEyWA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Sep 2026 23:50:02 +0100
Subject: [PATCH v4] hardening: Default randstruct off with rust for better
 allmodconfig support
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-rust-reverse-randstruct-dep-v4-1-3bfa19efe1fa@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJlWl2oC/5XNzYrCMBiF4VuRrI18+autK+9jmEVNjpoZaeVLW
 maQ3rupLmQYEF0eeHnORSRwRBKbxUUwxphi35Vhlwvhj213gIyhbKFJV1SRkzykLEsJTpDcdiF
 lHnyWAWfpWkfW15VSuhZFODP28eemf3zedxp2X/B5JufiGFPu+fd2P6q5e+1pVFJJ6zwaoA4U1
 PYb3OG06vkg5qtRv4HpgjUmmJq02VX75h9mHtia9HPMFAwW1HhHpCz+YNM0XQHZlDl+cwEAAA=
 =
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
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2049; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cNKvgu/lmPJM4ixOs3dCfcoZ+BDVYU8oSxgE0VQtWtI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBql1dEHtkcOC51RXS3uYuMlpw2VR3oIF7e1EDUo
 kUgO/ITRt+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCapdXRAAKCRAk1otyXVSH
 0GqhB/wNn5D/C/CUmPqq9FSJB8FholgaXbDnJs5MCTln44kXBBE8NqRYEORVFZg3P/M6g3rzgaO
 LpNJqWidG3PavKfP5DUi2idhbPak2JpYhYtEcpaZ4UJl/eOdo6k0qMYJkhPKQA6ndLNQLaVKExA
 eyoVIrNYF8D4PT/nu+SU0H6Ox6S0PIQ5ckQcYrrgqAEKxMa4fy67wGoYtV/Mj9mM0QfbBm60rou
 tNGG2cNCJRG3JEDsQXv/gMB8HFKGKIbr5NkC/z/aX2vtG1qmSMw8pbgIBpJEwMP8fH8muJRv1cH
 q6tStLFg3K6E/Ho4cIVLMb42/lhpCwfEQvNVRRIrdxX5CbUq
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently randstruct does not support rust so we have Kconfig dependencies
which prevent rust being enabled when randstruct is. Unfortunately this
prevents rust being enabled in allmodconfig, our standard coverage build.
randstruct gets turned on by default, then the dependency on !RANDSTRUCT
causes rust to get disabled.

Work around this by disabling randstruct by default if we have a usable
rust toolchain and rust support for the architecture, circular
dependencies prevent us directly depending on !RUST. This means we might
end up with a configuration that disables both rust and randstruct but
hopefully it's more likely go give the expected result.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v4:
- Rebase onto v7.3-rc1.
- Link to v3: https://patch.msgid.link/20260702-rust-reverse-randstruct-dep-v3-1-e4e09c50014e@kernel.org

Changes in v3:
- Rebase onto v7.2-rc1.
- Link to v2: https://patch.msgid.link/20260605-rust-reverse-randstruct-dep-v2-1-93d38023b6f9@kernel.org

Changes in v2:
- Add a HAVE_RUST in there too.
- Link to v1: https://patch.msgid.link/20260605-rust-reverse-randstruct-dep-v1-1-45ce9ee8d0d1@kernel.org
---
 security/Kconfig.hardening | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 6923036e1a2f..81c81ad983ad 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -278,7 +278,7 @@ config CC_HAS_RANDSTRUCT
 
 choice
 	prompt "Randomize layout of sensitive kernel structures"
-	default RANDSTRUCT_FULL if COMPILE_TEST && (GCC_PLUGINS || CC_HAS_RANDSTRUCT)
+	default RANDSTRUCT_FULL if !(RUST_IS_AVAILABLE && HAVE_RUST) && COMPILE_TEST && (GCC_PLUGINS || CC_HAS_RANDSTRUCT)
 	default RANDSTRUCT_NONE
 	help
 	  If you enable this, the layouts of structures that are entirely

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260605-rust-reverse-randstruct-dep-5a504c861128

Best regards,
--  
Mark Brown <broonie@kernel.org>

