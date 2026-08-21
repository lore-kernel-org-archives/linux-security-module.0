Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14229386C20;
	Fri, 21 Aug 2026 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787333792; cv=none; b=SU4dcohCzmn9tyoVz+/LC7fHp0e2LoUnhT2C4x9hjgUioxGVZ4U1E6QFJyQgcS6Adk2F7O312rvc2zU2CuM+1ZP35XAn6lMrDYI6DZ9LrCobFDdm9Fx47/66ZzSm2FdroIFLfoTQkp0E03ZSrIpd0scltf7ewBhAmCjVeuypQFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787333792; c=relaxed/simple;
	bh=1s5Jvd2vpIrg2KCIOxp4Zkk2A5/e5F1FEm3QZkl+uyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pMS2V6IMTmTe7qLuyf0fkeu8xskptFE8WWCWhSn5SKOwiqpQmvQef9bhyYpG/xEnBlLzmBTt7lFoFrApUytKeHu3+73HvpTcV7ZDAfddMw4shDNxCGC5JPT7k5BvjvrYJLjoint/IgRKGkX9D3t4yKw7IsOEv7t0cR1qLz2SzlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnyOxKbf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnyOxKbf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675511F000E9;
	Fri, 21 Aug 2026 17:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787333788;
	bh=kihQpqI0hRDJZ04eWiK3cUfr22dglVdWa3/uAWQZsSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EnyOxKbfPv8c21WYuD/L8mDA2ImzrTeZ4Z2iJ6zh1b3JObeVnTMUFnL9Yo6ppgGk9
	 yxLIOLW0BH3rsarSbqhMJWogxChu6+++TlfRnjHyGbolj8BK1vSquIJad52r/xo37c
	 A2tzSflfZtFuugJh409B8PoD0WNKrlDMOl3QKtsFi4mXFcdLfONi9Q0wOEWenzlnlh
	 uT3H5e3oGunmCBfXwO4q2EZS+sygfczIJpGDIcAVyTD+tFnEZrBEzZP3DMVjkmSUav
	 sTOD6/66inhbPaq2cN/AYzshwWFnNovs2Ig77WSEc5dBKyVWMncKaQsK+WSfbXiOJG
	 C7nRGlkgSJGQQ==
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH RESEND v3] hardening: Default randstruct off with rust for better allmodconfig support
Date: Fri, 21 Aug 2026 10:36:25 -0700
Message-Id: <178733378275.2181196.3186172911325132761.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260805-rust-reverse-randstruct-dep-v3-1-7b8b2c761d6e@kernel.org>
References: <20260805-rust-reverse-randstruct-dep-v3-1-7b8b2c761d6e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 05 Aug 2026 18:02:43 +0100, Mark Brown wrote:
> Currently randstruct does not support rust so we have Kconfig dependencies
> which prevent rust being enabled when randstruct is. Unfortunately this
> prevents rust being enabled in allmodconfig, our standard coverage build.
> randstruct gets turned on by default, then the dependency on !RANDSTRUCT
> causes rust to get disabled.
> 
> Work around this by disabling randstruct by default if we have a usable
> rust toolchain and rust support for the architecture, circular
> dependencies prevent us directly depending on !RUST. This means we might
> end up with a configuration that disables both rust and randstruct but
> hopefully it's more likely go give the expected result.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] hardening: Default randstruct off with rust for better allmodconfig support
      https://git.kernel.org/kees/c/3844a38c9c4a

Take care,

-- 
Kees Cook

