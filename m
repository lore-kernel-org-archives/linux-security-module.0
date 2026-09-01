Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2008D47FAE1;
	Tue,  1 Sep 2026 23:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788303999; cv=none; b=Iq3E0ExoURoCvoxZkXfMrZ7DaM77Kuvh54KPNyyzEH2Cp/RDogdwJ2WG1BZGPN70vTn/fUVJNRyDXpio1ChL5rsaBTt+e/OIVqRLvIzfdSsAdxvbdMTkgxK5JOZQFyMvBTdV4ImYMv9ScYRrmdGGe1Tb2plF/6l8FpITDe2iIWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788303999; c=relaxed/simple;
	bh=TyzcjStKbc9ACvi5JKfidyEQXbD6XbX0nzc8avWGLHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qyz9cKLTFNPwnywaZ6wQy6SB7NrMmB/EdgguNyILONCJxEuXtooRnHR5Yf4LX2oJoKxHq4xB8oWOEaDuII1kJO9B2gfblBQ/gawiHTdFBWF/TjDzz83KEDaWpjVgfk2D5/sUOrYuShuDUlnik337Xz8LVLxBAY6KpWcsyDk8GI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eP+z6wnR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eP+z6wnR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CC71F000E9;
	Tue,  1 Sep 2026 23:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788303998;
	bh=7X3iDDd39BNMvDlwlAry4pqgYtb8qqQvZag8u9fNkVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eP+z6wnRCpWsK0ulnl7I58zOXDLyn1F5uuzFetFxqUSRHZeZa/v+m5QLvecBCvFlT
	 Ak7tSi3+moFE7GpOvXwbWDFQBzIziVKkPAM/nPdXRpEA+XgRdaWnWOb9lDq4alcadv
	 b794H0FmQWovsWR6Q4FbO70lxp81sgUdt4FSRiYe6OjaxKLQJSvrWePF30fFNW/AE6
	 yNVqQv85XPYtsfKC+vYvxKBVWrzzaeaUBhv3gi7jmuGzf9gxX8g86hLZQCTJ3EPNz3
	 gjS9evHan2KsiMTtKJUGfiqZiAfyqWYlZKaxg2Cq3bq0Ug1zayvwS56PcYpepnaX74
	 fNmJWUqYHWkIw==
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
Subject: Re: [PATCH v4] hardening: Default randstruct off with rust for better allmodconfig support
Date: Tue,  1 Sep 2026 16:06:32 -0700
Message-Id: <178830398996.1189233.9472554390731309504.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901-rust-reverse-randstruct-dep-v4-1-3bfa19efe1fa@kernel.org>
References: <20260901-rust-reverse-randstruct-dep-v4-1-3bfa19efe1fa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 01 Sep 2026 23:50:02 +0100, Mark Brown wrote:
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

Applied to for-linus/hardening, thanks!

[1/1] hardening: Default randstruct off with rust for better allmodconfig support
      https://git.kernel.org/kees/c/2625480a1bf7

Take care,

-- 
Kees Cook

