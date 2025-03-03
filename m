Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BDB1D89E3;
	Mon,  3 Mar 2025 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027038; cv=none; b=h/r6kysnv2AoR4apY2GzCYLcQK84uUhqNk97vvArw4XEc6mvRndCyx5B0S7Po5OifSlrtW+5xhaCKjzZkJYnss0c4y5gGsPf2W+cslAx+a2f0ATpLCEMo6zwD7ty5pZwLCm6pWEcR7nY91KjvGRBsS7k4V4FHsCP3azhIhYtXsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027038; c=relaxed/simple;
	bh=YAI9k+LZSnaw9MddJ9RW8umbJD1MUu3WbUbK9Ki3/30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ic0mdGNqWd0d7GhPO3D31MKH108KHceJsrSNBtcHlb5/h3Wp4vL+2zCgdgpwkBUq5aP1CgAFv/c1TKWpNIiomJPg8PRflyvygVkV78PZwwWLmviaJz7XRPzylXhsb1lvMNXAzjxNVWZsQSzvkAPTlF3Zt9EW7StmeLa0doEvFCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhNnEQYJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhNnEQYJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1993C4CED6;
	Mon,  3 Mar 2025 18:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741027038;
	bh=YAI9k+LZSnaw9MddJ9RW8umbJD1MUu3WbUbK9Ki3/30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=uhNnEQYJS9dA4vjjWzlN7P/wSMY9YaHl2xR//CjpHuG3y4FCnExJITxmgTgu8kuW0
	 bDfiVtuz7LgE4J9UzEOx/I0HvZYD6Z60NWwQlcOLaO6DsITl6MBuUhqlFEh9H3sdxo
	 vFp6/Wo/pPD9WxY3px7SxpH2V8cOCl3Mz4SieO2gNggC5B55v1F3w1qT5xg0f/6Soc
	 vxwVKEDQbsYsjXTDowFmzfDfmFWCl1ZKsRQ3PSnYkKHOpoTYCvnYxH3hcE4idzXhLZ
	 IirlLMTxG0c6XVzP+aoOBMqgSCGWz7BXp/4PY6PLRzQecccv31oiHewEU6bOPhuq7D
	 iBju3KwxIl0CQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Paul Moore" <paul@paul-moore.com>,  "James Morris" <jmorris@namei.org>,
  "Serge E. Hallyn" <serge@hallyn.com>,  "Christian Brauner"
 <brauner@kernel.org>,  "Jens Axboe" <axboe@kernel.dk>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Trevor Gross" <tmgross@umich.edu>,
  <rust-for-linux@vger.kernel.org>,
  <linux-security-module@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cred: rust: mark Credential methods inline
In-Reply-To: <20250303-inline-cred-v1-1-b2527beace76@google.com> (Alice Ryhl's
	message of "Mon, 03 Mar 2025 15:28:50 +0000")
References: <oBwtAqSRdc6GeLa0_12zYhVpYIQWZs7yGoDr17ZXC6X3aoPYIqkkMdWUbkgpU7sPS-FTUDaWEd4pYAuRawMJJQ==@protonmail.internalid>
	<20250303-inline-cred-v1-1-b2527beace76@google.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 03 Mar 2025 19:37:09 +0100
Message-ID: <871pvej6zu.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> I'm seeing Binder generating calls to methods on Credential such as
> get_secid, inc_ref, and dec_ref without inlining. Since these methods
> are really simple wrappers around C functions, mark the methods to
> inline to avoid generating these useless small functions.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg


