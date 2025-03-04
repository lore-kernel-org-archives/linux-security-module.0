Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DD91EA7CE;
	Tue,  4 Mar 2025 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092528; cv=none; b=O1plhcutwNZ4eE15ALgnx8VebMHLhT6Wu51USaa3hqkFI4oO5fZXzo+KQhBc20W4FuY+U87x/fQfNrIlMy0kzGFOLTuzP3vQuuehKHtj8HXJrdqRkC2lhR/MC3J9OuQjKLaJwjQ/CURZMzB7znW6iSoWOVpI+FlsEMAc1VJ5qdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092528; c=relaxed/simple;
	bh=ZiVfQxb+nhSNOjRdNK64TLrRUq/REnEgScMI9O0d3kI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V1LVF3aB2d0JqgMz0d2EACUKclQe+8eiynllY2afHvTvC3ZRmRzwAIHyMobnKLg2BsjwJMvnsMgF0ORjnv2sc5cG7SmBq3UCfxjHVnF7Zx/8tCxiz5Yg7VjiqqygjiPT203BaApIlmbWITXfkN+7SKV4CK04aG7X6R6ZqGy9AE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=o3PmGT/j; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="o3PmGT/j"
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741092520; bh=F+g7zVwVOBh8ruof6NeLPIIzEutCEQefGlpLKbd4t+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=o3PmGT/jqJCQdV9eCtDOEmJjArZHNdb2aghv900a7ocLltJ8FMSg/hpFh0IewnUwq
	 UDVYvnrcbPDF4yH8OvVEYZGPNxrCF8pBOBfmI5Z98jIrh9KvIaUy45chy8/Nm37pJB
	 d8yr1IEymtZgv9wBXHTroPg4qIYN8OeOSxMhW+Nk=
To: Alice Ryhl <aliceryhl@google.com>
Cc: Paul Moore <paul@paul-moore.com>,  Casey Schaufler
 <casey@schaufler-ca.com>,  James Morris <jmorris@namei.org>,  "Serge E.
 Hallyn" <serge@hallyn.com>,  Miguel Ojeda <ojeda@kernel.org>,  Boqun Feng
 <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6?=
 =?utf-8?Q?rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>,  Benno Lossin <benno.lossin@proton.me>,
  Andreas Hindborg <a.hindborg@kernel.org>,  Trevor Gross
 <tmgross@umich.edu>,  rust-for-linux@vger.kernel.org,
  linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lsm: rust: reword "destroy" -> "release" in SecurityCtx
In-Reply-To: <20250304-secctx-reword-release-v1-1-e8e9a7ff85ba@google.com>
	(Alice Ryhl's message of "Tue, 04 Mar 2025 10:31:55 +0000")
References: <20250304-secctx-reword-release-v1-1-e8e9a7ff85ba@google.com>
Date: Tue, 04 Mar 2025 13:48:38 +0100
Message-ID: <m27c55j715.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alice Ryhl <aliceryhl@google.com> writes:

> What happens inside the individual LSMs for a given LSM hook can vary
> quite a bit, so it is best to use the terminology "release" instead of
> "destroy" or "free".
>
> Suggested-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

> ---
> This patch is based on top of:
> https://lore.kernel.org/all/20250304-inline-securityctx-v2-1-f110f2c6e7ff@google.com/
> ---
>  rust/kernel/security.rs | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
> index 24321105052648e150f2875bcfa5ef29f4249516..0c63e9e7e564b7d9d85865e5415dd0464e9a9098 100644
> --- a/rust/kernel/security.rs
> +++ b/rust/kernel/security.rs
> @@ -16,7 +16,7 @@
>  /// # Invariants
>  ///
>  /// The `ctx` field corresponds to a valid security context as returned by a successful call to
> -/// `security_secid_to_secctx`, that has not yet been destroyed by `security_release_secctx`.
> +/// `security_secid_to_secctx`, that has not yet been released by `security_release_secctx`.
>  pub struct SecurityCtx {
>      ctx: bindings::lsm_context,
>  }
> @@ -67,9 +67,8 @@ pub fn as_bytes(&self) -> &[u8] {
>  impl Drop for SecurityCtx {
>      #[inline]
>      fn drop(&mut self) {
> -        // SAFETY: By the invariant of `Self`, this frees a context that came from a successful
> -        // call to `security_secid_to_secctx` and has not yet been destroyed by
> -        // `security_release_secctx`.
> +        // SAFETY: By the invariant of `Self`, this releases an lsm context that came from a
> +        // successful call to `security_secid_to_secctx` and has not yet been released.
>          unsafe { bindings::security_release_secctx(&mut self.ctx) };
>      }
>  }
>
> ---
> base-commit: 93f60f16db02f7b52985338f37679095231b6383
> change-id: 20250304-secctx-reword-release-e26ac4ee7e0b
>
> Best regards,
