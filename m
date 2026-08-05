Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC1A48167E;
	Wed,  5 Aug 2026 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785949373; cv=none; b=ri6Ec4JobzigbkW9p4c1CaTfzj9D3J5kGDiaZ/+Oo+M6v0nbRgPcq3TYKSHjWYcnFvoEWml80OO3RvrMh3w86Ztr0p0EcWr8Prqgci5uy4bV1+R3SA1JlVqC1TLChul6DuhB24q/iaKX+4H6v/buUjCJieGksI5Orp0gCEBQGqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785949373; c=relaxed/simple;
	bh=ZyN0SiqSs8DLHSC42IF4M3TnG8c6Jy/DH7clsf2OuSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=erbvTGnUau9pDZk+gwjG8a+DB7g0lg+JMzXI9Mjmodb3reupwuPuTl5I0Gxu5LCopODJ3L2AG481dTkos/9qOD6VTZEFVDklbLSyEVh8Qb4VLc33mVX7mnbTK4S9p7wvro/0DqQEmi4WStcLNODrVzZQBhggvNZtoIUWc0lGEls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PidoY1uV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PidoY1uV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AD81F000E9;
	Wed,  5 Aug 2026 17:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785949372;
	bh=g1QSzSWGcu7ZvnW4RMOj2yIP9UMLovFDvTuaHVCj4Rs=;
	h=From:Date:Subject:To:Cc;
	b=PidoY1uVotmNcxB6CfWqaldOr68RGcNVE5p4LB69J6BzBqDM2cvz6stuvtIR/tYpl
	 vpqYfbvAt3tSUpld8Lk8x6EsF8tmHBMiRByznCaTcSGewAvxwGwWtCT4HfmEe830n9
	 TV/12uV12r7OhK9nU11lP/6AWHSrR88lNx0cAFaLXV3lc0NB/Nx2fXSCTxceA2FjVd
	 hIowmpR2tnDwtP5WR3r5H74LncqUhlj3fe8/+19KKIBIS4MPmDlfhopPcJceUUmoLI
	 2ACeSDBktLBj2MZH511oqNCQqGKAMj9CzAcZc683nZBpvwG5YSdGngBtP+fp6NlB7j
	 5PEIRbWbX1I+g==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 05 Aug 2026 18:02:43 +0100
Subject: [PATCH RESEND v3] hardening: Default randstruct off with rust for
 better allmodconfig support
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-rust-reverse-randstruct-dep-v3-1-7b8b2c761d6e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1936; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZyN0SiqSs8DLHSC42IF4M3TnG8c6Jy/DH7clsf2OuSo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqc2y4WbcGZTuvWm0XxHfmx3U/wlLSJYoUqxRmV
 AEMmi8cxSqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCanNsuAAKCRAk1otyXVSH
 0FkOB/wMYX1Sc3z+6+5HeiuPmYukBy8Btxf3NKjunUZSWVNk9tausZEeAkBuwAxMKL9PTdiUpgZ
 oJjWZ1djUSoat9jL3r4Pu8KonsBGBS/3YQ4Q1W2AZ08TlHctZoyBLgNmVGrzrzQcsqUkqEtdYdI
 cWqDjs9/v1maM3y9+wWga0E8tFqUHRod1iqNDzQ50j50+q7yF+51/qJLjboSKrIKEZyWybRFOIS
 j+PF3ylW73uAfEpWA/ueT97NpOXULa+i4u3fGF/oDzFpn2ekMqjGR+s2ybfd4j8/hIMOGehvUCC
 lmwYT9leKK2XYZRCQgcY19vIP9F2WdJh2+S5BhF2DHQjliO5
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
-- 
Mark Brown <broonie@kernel.org>

