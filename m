Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D325D84A3E;
	Mon,  3 Mar 2025 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741026890; cv=none; b=bYpHmxQVLyVEAOigl9wQiwyyJGFH+I73OhYETGeTA8MWqaJSNl2ueT4pgx5/Y7sEhH27KaWKG7LVf78A2as50C4ycyfPn74BI88f82WIdvqpjkMeKwFI9A0U3N6T4zkW/rWGRDMBBejZa7MzXRa8wvbSl3pRGb9JJbDxM9b0ViI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741026890; c=relaxed/simple;
	bh=7s7jVM9qOpuwQGaeWhEQnHDrxdpsE+GXeGxIibk8KiU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lle2U5dgBm3BUtAd1a8Wd44GPLE2RxSuCuZ7CD7701JgcW8WVzg2sC4jyuq1m2P/aC4sllXJfmlz9ycUPLr07xsxkMLpgTuyPmiqL+pWI3JZ9zK5L84hrPSqoQjUw/rIobjT1Vbs7f/jXA6CqONIHILgzs3MfjC9VmIEaW7rzU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwdN+h3j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwdN+h3j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C9CC4CED6;
	Mon,  3 Mar 2025 18:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741026890;
	bh=7s7jVM9qOpuwQGaeWhEQnHDrxdpsE+GXeGxIibk8KiU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mwdN+h3jVOXsxtJjW8561lCVMOgRyeZqpIlj2yqO1y2vhqovHSEaKkeXTaP3uWOJn
	 QwDrHk/mLwQxv2x9snbBRzQ3JWGI+gB86yCiXwn502TT0GjtuXPTzJ6j41UAgVLRmj
	 qvKdHawfa72ppAKQYwVwmhE1C6YeSYBN995KXrIJ4fX6yRLq7D4K+bmZAOO429bhMc
	 oKoUZiPi1sTX6b0ZUQQ7+7HjAegoLyiOu41+GLd5eReNp7ROpJzpcBjS9hJAu5h7IF
	 4qn6aX1xaX7GQ6zJqJnyuRW8osva6Bil69mglb7cJpN6dNDMrdNVT7IqMVmO3tt42H
	 uI+LTwojd2ZlA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Paul Moore" <paul@paul-moore.com>,  "James Morris" <jmorris@namei.org>,
  "Serge E. Hallyn" <serge@hallyn.com>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,  "Benno
 Lossin"
 <benno.lossin@proton.me>,  "Trevor Gross" <tmgross@umich.edu>,
  <rust-for-linux@vger.kernel.org>,
  <linux-security-module@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lsm: rust: mark SecurityCtx methods inline
In-Reply-To: <20250303-inline-securityctx-v1-1-fb7b9b641fdf@google.com> (Alice
	Ryhl's message of "Mon, 03 Mar 2025 15:29:58 +0000")
References: <E5LkGmfU4ReOvkhvA6uG2XmGCOCIzZCskzEqz-4wFULw5YMx_ZNvvqbufIS0Qh__mGfczk1LAuGgSePNUSUJXQ==@protonmail.internalid>
	<20250303-inline-securityctx-v1-1-fb7b9b641fdf@google.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 03 Mar 2025 19:34:40 +0100
Message-ID: <877c56j73z.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> I'm seeing Binder generating calls to methods on SecurityCtx such as
> from_secid and drop without inlining. Since these methods are really
> simple wrappers around C functions, mark the methods to inline to avoid
> generating these useless small functions.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg


