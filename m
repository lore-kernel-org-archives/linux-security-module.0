Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6D13624C5;
	Thu,  2 Jul 2026 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783014288; cv=none; b=JwCFeqfwIBt9LrNniTEKxkrZFl5/xt7lVwXkQtpHt6PU4zUXGApjDCJWn6tkk5ZODF4yuhojkdbF5m/d/wFMs7SC3L2C9oKsSKOqglAg2ZKgH8Oa11gTBV1eEqijsLunBNH2gqeBmJa3UWLg/G3oPMDtliKj3GEUMxxTfqqGM/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783014288; c=relaxed/simple;
	bh=qN1BEqviBdra3blN4I5mvv2dJxn54XoSZdBXfNPMcPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Akb7e9Xar5V/Mg4yG5O7OyslrsQPvejfrgn6GrLYfYEDmxaLF72Scq1IH9kE/GtbPblHdaxlo7lrMItkWvTdMyFfIgMOpkXB7epxRsAFPWKHpcaGZtd5D+pXWW+1frlduyvfF76T7M+8X+7bF7PEsT0wyi4ZU1H13ZQZru/4RcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=is1Nw4CV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="is1Nw4CV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788841F000E9;
	Thu,  2 Jul 2026 17:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783014287;
	bh=hABVF4sGpyE3jVKHYv5QCrfL7jA6qp4NE9op0JVv1lU=;
	h=From:Date:Subject:To:Cc;
	b=is1Nw4CV7xigjs/lVsqTt/gdZ/Nu/U0Ca+ImhFPR7CD/WXDWKkCTWLxyfUek7kvv/
	 GoyNdWcNqhUV1fFnWL+TyfTGdtGIMd7FZcYNDSdbMYbYooj1TjNXG3o1oQketvuYQU
	 nfYO5OWrscjLLH8ulBMlJtaLjQBenpvq8fEJKvOnxIzxSsFpFvlt0M2z+oICSC5YYV
	 en4+/xB8yp1epLiM2yojpyWaJpJOrdhJZCH9eD4BE5oGyYqb1nJwTFTEH+xGwOicaE
	 pbXYzQ2TEQC6fMiHBMGzIRBObiSf9jok1mGHt5N2Ni3hmIUfXFjob3vEVp3hYSNqhh
	 u2AnLpkhsrHYQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 02 Jul 2026 18:37:08 +0100
Subject: [PATCH v3] hardening: Default randstruct off with rust for better
 allmodconfig support
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-rust-reverse-randstruct-dep-v3-1-e4e09c50014e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMOhRmoC/5WNSw6CMBQAr0K6tqYf2hRX3sO4gPYBVQPktRAN4
 e62uHKny0kmMysJgB4CORUrQVh88OOQQB4KYvt66IB6l5gIJjTTTFGcQ6TJBAxAsR5ciDjbSB1
 MVNWKldZozoUhqTAhtP651y/XD4e5uYGNOZmN3oc44mvfLzx7v50WTjktlYUKwDjm+PkOOMDjO
 GJH8moRf8REilXSScOEbHRbfcW2bXsDEHid6SYBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1900; i=broonie@kernel.org;
 h=from:subject:message-id; bh=qN1BEqviBdra3blN4I5mvv2dJxn54XoSZdBXfNPMcPg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqRqOKsW4w1g8+CfBlAPqGGVzKCw6/cheOZPJc8
 ojA0RHNoG+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCakajigAKCRAk1otyXVSH
 0EwYB/4hreA5GB5rTEBNmtVZYGByevSJyKCca4iFFdT/Vg8kFPrHPR4fPlPCcoAQiZlb4ye4Kgd
 oTrdPlejNRejott+60/gxw6Vr5vMaZvlCwSn8DU8/bblryTU1fD+bQeW+ISML/uq/gwizsOyhIq
 3wuf3z3wvLAEz6UXD1wkMO1GYQIe08m+Fe0kAU53/T7B83xPlkm+NA0Gzou/jI9M+D+3nKZFMXD
 uwgaattplCljwYXvpRo8533JRtKE8P0jcjM03RCbmrB7f/s2FpS5yzwS8O7HvrhLzeDpX6Rpqde
 TrniePFkj2THMUHWSqeScskAEK9shickrDZXgD0LetnVMbAD
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
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260605-rust-reverse-randstruct-dep-5a504c861128

Best regards,
--  
Mark Brown <broonie@kernel.org>

