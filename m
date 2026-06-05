Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194D23B42FC;
	Fri,  5 Jun 2026 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780678295; cv=none; b=ZCC/zWMFDSvlsE+6bZ3fJdxqQuXsZP6NXFWb4NclDcjZaBP4H2rYczBwNVlf0X1dcjMaUr5w46IFXiTzJm0wafRY8uYNScsICHFq32MtL4b9ZqnEbqGBvgo5ItXArtkl0bRY29cN/AC0RJjOZuFZaV4trfHrnxypaiumy1lxRbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780678295; c=relaxed/simple;
	bh=cEFtr8AJVQkFY0Wmeq9R9uWufFD1HDHWT0PNYLE4W+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KPhnCdNZbjnWsEf07WsSKyVsFpLvtCBbLbcyv3nH1bZLRKUB8Nvyt6jgco+5yCJa0M0DZBHosTf/6PwDthT/QKSiyRbJ3k+dB/creNmtn0hTT22V3hNvH/4OEDdq97/htWyaNUyj3j0qCsU4dxQ3dg0ijAgt4IU9I66f79/MX4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LszpehQp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LszpehQp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EAFC1F00893;
	Fri,  5 Jun 2026 16:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780678292;
	bh=kaueAH1A28I4mzPHTO+5deaEulFLg4/sn6wuA9JZiDg=;
	h=From:Date:Subject:To:Cc;
	b=LszpehQpSUZ58UA4ZLLpQNsf421FFVITyvks0m3oR5+I2Y7/M+fcsDu59NrEiWZCC
	 O46uqu6w4uUoKWEmPWAyApuuy3i/MZkq+5r+/Qxag/5+q6sXTNB4UU5GWUK7uEeHxw
	 VP1LYm5gbfBrlUsdjGVBOjvBrn7o9ZGoJK8KzBC0GAGccK+OLJDopptO6zS3Sft6dO
	 1YjGudBF6NS7pJIiJS4YkffySrgAZMctd2HxfaJph0OlDC/4sydfuzLFCP0beBzzQ3
	 0Fk7vElnkWPa6rcbpsC0jcA0a8jRbMbY3T2kWlJ1WT0hxRc0ErLbvYcCyQ68TU9+He
	 EtDI0MKNr0oEw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 05 Jun 2026 17:50:58 +0100
Subject: [PATCH v2] hardening: Default randstruct off with rust for better
 allmodconfig support
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-rust-reverse-randstruct-dep-v2-1-93d38023b6f9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHH+ImoC/42NQQ6CMBAAv0L27Jq2oQQ9+Q/DAdsVqqaQ3UI0h
 L9b8AMeJ5nMLCDEgQTOxQJMc5AwxAzmUIDr29gRBp8ZjDKVqpRFniRhNomFkNvoJfHkEnoa0bZ
 Wla6utDY15MLIdA/vvX5tfizT7UEubcnN6IOkgT/7ftab999p1qixtI5ORLVXXl+exJFex4E7a
 NZ1/QKQwurn2QAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cEFtr8AJVQkFY0Wmeq9R9uWufFD1HDHWT0PNYLE4W+o=;
 b=kA0DAAoBJNaLcl1Uh9AByyZiAGoi/pCipoFr56drgbeCJWZbNTxfMocnV34HVchyDxMS/Dxab
 okBMwQAAQoAHRYhBK3maKpnVxi1n+Kf6iTWi3JdVIfQBQJqIv6QAAoJECTWi3JdVIfQrxEH/2yb
 bxt8J5e5p5v5U7rkQbhF/i84hLlkAjYytJesidSziHfchHL+1Y3X3nyvHiuZt0lJzu27sbLJPVk
 wBRrFi1pxs5nEyceeomEyG0cbSlUwyVqgfSW3LSwMlHLyP7jbRJVyAiyRRaAj5a1hjeiBhNXjVl
 ihSEF1bmrRMK3D6jmFXhAgD3KZOAuozo+/OQ5AoT4GWGPGFPRtHeDYPlLZ8Br43+ZzO6J8anUyp
 mO+MdOBelrE1u/H+q0SpEsptswJuG00XJnT+QQo10lYrX8qVhVLZ2DXCNPmRb2ftqrJccYMTN1x
 ZjHNkD28rR18z/OE6UAnl3vl0bOVB5tuUwPMh1s=
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
Changes in v2:
- Add a HAVE_RUST in there too.
- Link to v1: https://patch.msgid.link/20260605-rust-reverse-randstruct-dep-v1-1-45ce9ee8d0d1@kernel.org
---
 security/Kconfig.hardening | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 86f8768c63d4..923e7710f005 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -285,7 +285,7 @@ config CC_HAS_RANDSTRUCT
 
 choice
 	prompt "Randomize layout of sensitive kernel structures"
-	default RANDSTRUCT_FULL if COMPILE_TEST && (GCC_PLUGINS || CC_HAS_RANDSTRUCT)
+	default RANDSTRUCT_FULL if !(RUST_IS_AVAILABLE && HAVE_RUST) && COMPILE_TEST && (GCC_PLUGINS || CC_HAS_RANDSTRUCT)
 	default RANDSTRUCT_NONE
 	help
 	  If you enable this, the layouts of structures that are entirely

---
base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
change-id: 20260605-rust-reverse-randstruct-dep-5a504c861128

Best regards,
--  
Mark Brown <broonie@kernel.org>

