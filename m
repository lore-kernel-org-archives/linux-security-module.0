Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDD82192FA
	for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 02:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787885092; cv=none; b=TmV25+tNtP40KHzUB2W8IRgjfxB3qSd9bS4T0wYfOT6FfQnRE2r7uC3X+vxLyusqPpiittl/aUbt5PJrbZ7I+/RBPeVk+ml4uyc4o51Rty7ng4CHefbOZaxgc9cVcrLnQf6g9HPgW1Wcc8sSE9fe7HdavxGHlPq1DarX54tRe/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787885092; c=relaxed/simple;
	bh=Wa6+2lHvpXA5kOwx/K/W5g8loVWc1BnA7I82cueJWPo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=aNZEBJi3x/9VM6xEN14stTlUDu/B57C/fNevcgayRWRVEQNMnhiQgYzgZQzafRxPjwtyhKeDgGHH0/uW6KQ4Zx+KayW10OH46Z2cTPoor0JbEf7aMAk+paSivbFB/oHAKz/y3Ag1QAhCZk3UNWQR5k2q95mjspDMVkYNNQQFVOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Xo/Br8p4; arc=none smtp.client-ip=79.135.106.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Xo/Br8p4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1787885078; x=1788144278;
	bh=d2vbG8I8C2vZ3aknTtpETgBaDvg9qhoe2w1vweQf45k=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Xo/Br8p4XrN1wazdEsBYcFzLyj3wX+AKcHTyrKeIy65LBAlvmEqUoowoA47FzJxPE
	 OM1pdHC1D9fmJjpS93T1P4sWk+pbH+wD4TOda5ezCBHnQFflVbAHayBafHU/495Ge/
	 MT2L+c2YXpYuzQJlTZig4yqYxiBm2AaDTJaEioI+qBOceBpvlmQVFspfkKtUHE1kT8
	 kSqb1fHVSP0u3YGRpfBtWo//cwSgWa26lfBgCkAD7A2zxFv1ZgPcdbnx7Ldb1NvTiK
	 ZONc+uKuYGedKcqWZkdfNXlegvCVUS3+sqp5luRW9xUszrAdFhqgxuxDWuQ4OEfo8O
	 4qYu+glpKRS+g==
Date: Fri, 28 Aug 2026 02:44:30 +0000
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>
From: Nils Lehnen <nils.lehnen@proton.me>
Cc: Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>, Boqun Feng <boqun@kernel.org>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Onur Ozkan <work@onurozkan.dev>, Atharv Dubey <atharvd440@gmail.com>, Ke Sun <sunke@kylinos.cn>, linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Nils Lehnen <nils.lehnen@proton.me>
Subject: [PATCH] rust: security: replace `core::mem::zeroed` with `pin_init::zeroed`
Message-ID: <20260828024335.946-1-nils.lehnen@proton.me>
Feedback-ID: 188354734:user:proton
X-Pm-Message-ID: 03d30c8e9b9b95cd199dd517e73934594f333461
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Benno Lossin <lossin@kernel.org>

All types in `bindings` implement `Zeroable` if they can, so use
`pin_init::zeroed` instead of relying on `unsafe` code.

If this ends up not compiling in the future, something in bindgen or on
the C side changed and is most likely incorrect.

Link: https://lore.kernel.org/r/20250814093046.2071971-8-lossin@kernel.org
Link: https://github.com/Rust-for-Linux/linux/issues/1189
Signed-off-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Nils Lehnen <nils.lehnen@proton.me>
---
Resend of Benno's patch from the Zeroable series [1]: only patches 1, 2
and 11 of that series were applied, and the issue [2] asks for the rest
to be re-sent. Rebased onto rust-next; it applied cleanly, and a
defconfig build with CONFIG_RUST=3Dy and CONFIG_SECURITY=3Dy passes.

Two equivalent one-off patches were posted earlier [3][4]; Miguel asked
in [5] for a resend that keeps Benno's authorship, which this is.
Cc'ing the LSM list per Paul's request on the original thread.

[1] https://lore.kernel.org/r/20250814093046.2071971-1-lossin@kernel.org
[2] https://github.com/Rust-for-Linux/linux/issues/1189
[3] https://lore.kernel.org/r/20251129135657.36144-1-atharvd440@gmail.com
[4] https://lore.kernel.org/r/20260120083824.477339-8-sunke@kylinos.cn
[5] https://lore.kernel.org/r/CANiq72nJqFOR9vhPBfZUNrxU+M1HMV6wN9bN6i8e9rf_=
oOD2qw@mail.gmail.com

 rust/kernel/security.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
index 9d271695265f..4dc3eba6ce84 100644
--- a/rust/kernel/security.rs
+++ b/rust/kernel/security.rs
@@ -62,8 +62,7 @@ impl SecurityCtx {
     /// Get the security context given its id.
     #[inline]
     pub fn from_secid(secid: u32) -> Result<Self> {
-        // SAFETY: `struct lsm_context` can be initialized to all zeros.
-        let mut ctx: bindings::lsm_context =3D unsafe { core::mem::zeroed(=
) };
+        let mut ctx: bindings::lsm_context =3D pin_init::zeroed();
=20
         // SAFETY: Just a C FFI call. The pointer is valid for writes.
         to_result(unsafe { bindings::security_secid_to_secctx(secid, &mut =
ctx) })?;

base-commit: 73e3f0710014fe6d4ed98cfc02292f6121db7558
--=20
2.43.0


