Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DE8201262;
	Tue,  4 Mar 2025 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092569; cv=none; b=bugP52yNcyXv1o0xYevpf2EkznXaTFKIFC0eMFFwNrVt63qqDLvY0tSQpqoupQDXpAvzbFdBvHbM2rJHxkmzinF2zYppKreyzAcmgesGE2c7nRVBSXESS+tv3ZdT379+/vvsue5nrRWCPmXqv163/WhP1I7Vt6fcuzeoRypYZk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092569; c=relaxed/simple;
	bh=ZtIYHYrNLkZ3dkg5lJ3oqNNs3u0xA3w054DlMqQrAVU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QvECDNxvtXytAsg/ndwYDUxrIgUuz1euURhZN+8S77wcKZMjHPUv3hukWeC3RJyK9Ux0ZWc2e87xj8kaRQndcgPMkRgQww98CP4KqUEU6HS34S5AhYq1iI52VJZXOjbhAGSZWeMeJDOXBozMJhKYMsnszeYtbyazAOLeuHgqtfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=URYV4SFc; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="URYV4SFc"
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741092565; bh=+/Fq+0q0A4qbF6xEGac5S1RyjCNiPt+uYpRhIlROXfU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=URYV4SFcZ1BFj+M8SGKVdFqKn3cjfISVfIvY0+CH8LAGCN/98WmxG11hQ4MJczdNT
	 a/NejwEQtwjKWVCsL7cPJdiqHn2FqPNt+Ol4jmpplfoqlrcMF9hMnpW9TFZ9SRkqMs
	 rVDIZZmWm025+IX4qCUZOoljRjFxHczXn1/P1KB4=
To: Alice Ryhl <aliceryhl@google.com>
Cc: Paul Moore <paul@paul-moore.com>,  James Morris <jmorris@namei.org>,
  "Serge E. Hallyn" <serge@hallyn.com>,  Miguel Ojeda <ojeda@kernel.org>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,  Benno Lossin
 <benno.lossin@proton.me>,  Andreas Hindborg <a.hindborg@kernel.org>,
  Trevor Gross <tmgross@umich.edu>,  rust-for-linux@vger.kernel.org,
  linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lsm: rust: mark SecurityCtx methods inline
In-Reply-To: <20250304-inline-securityctx-v2-1-f110f2c6e7ff@google.com> (Alice
	Ryhl's message of "Tue, 04 Mar 2025 10:26:52 +0000")
References: <20250304-inline-securityctx-v2-1-f110f2c6e7ff@google.com>
Date: Tue, 04 Mar 2025 13:49:24 +0100
Message-ID: <m21pvdj6zv.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alice Ryhl <aliceryhl@google.com> writes:

> When you build the kernel using the llvm-19.1.4-rust-1.83.0-x86_64
> toolchain provided by kernel.org with ARCH=arm64, the following symbols
> are generated:
>
> $ nm vmlinux | grep ' _R'.*SecurityCtx | rustfilt
> ffffffc0808fe8a0 T <kernel::security::SecurityCtx>::from_secid
> ffffffc0808fe9a4 T <kernel::security::SecurityCtx as core::ops::drop::Drop>::drop
>
> However, these Rust symbols are trivial wrappers around the functions
> security_secid_to_secctx and security_release_secctx respectively. It
> doesn't make sense to go through a trivial wrapper for these functions,
> so mark them inline. Also mark other trivial methods inline to prevent
> similar cases in the future.
>
> After applying this patch, the above command will produce no output.
>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

> ---
> Changes in v2:
> - Reword commit message.
> - Link to v1: https://lore.kernel.org/r/20250303-inline-securityctx-v1-1-fb7b9b641fdf@google.com
> ---
> I will also reword "destroy"/"free" to "release" as suggested by Casey,
> but I'll send a separate patch for that change.
> ---
>  rust/kernel/security.rs | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
> index 25d2b1ac383355941ecbe86bd3c505eb6517c180..24321105052648e150f2875bcfa5ef29f4249516 100644
> --- a/rust/kernel/security.rs
> +++ b/rust/kernel/security.rs
> @@ -23,6 +23,7 @@ pub struct SecurityCtx {
>  
>  impl SecurityCtx {
>      /// Get the security context given its id.
> +    #[inline]
>      pub fn from_secid(secid: u32) -> Result<Self> {
>          // SAFETY: `struct lsm_context` can be initialized to all zeros.
>          let mut ctx: bindings::lsm_context = unsafe { core::mem::zeroed() };
> @@ -35,16 +36,19 @@ pub fn from_secid(secid: u32) -> Result<Self> {
>      }
>  
>      /// Returns whether the security context is empty.
> +    #[inline]
>      pub fn is_empty(&self) -> bool {
>          self.ctx.len == 0
>      }
>  
>      /// Returns the length of this security context.
> +    #[inline]
>      pub fn len(&self) -> usize {
>          self.ctx.len as usize
>      }
>  
>      /// Returns the bytes for this security context.
> +    #[inline]
>      pub fn as_bytes(&self) -> &[u8] {
>          let ptr = self.ctx.context;
>          if ptr.is_null() {
> @@ -61,6 +65,7 @@ pub fn as_bytes(&self) -> &[u8] {
>  }
>  
>  impl Drop for SecurityCtx {
> +    #[inline]
>      fn drop(&mut self) {
>          // SAFETY: By the invariant of `Self`, this frees a context that came from a successful
>          // call to `security_secid_to_secctx` and has not yet been destroyed by
>
> ---
> base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
> change-id: 20250303-inline-securityctx-6fc1ca669156
>
> Best regards,
