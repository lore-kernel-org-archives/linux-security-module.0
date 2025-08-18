Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1568828E00;
	Mon, 18 Aug 2025 03:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755487930; cv=none; b=ElLb6To6gcRXlAd+PD/cVJwQc3kRcKGq/5sqH5yDvnW5ExTUnUVjKL7+K5YzXwh4/Fv3qtkUqqxTpaHVMAx+8MLZ3JlYQqYc7nLQfoAifXMMp4LJcL2h5iewef47lFNlOEkUJ+XEaPd5mQfaEGSZUdgPxthQExnzrffg/VnsMyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755487930; c=relaxed/simple;
	bh=mzBwfg4WkelFbb+jD82bG2H3S3afJF2D7+6S4AMHaUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWuiF2bMxeOIlUz3Bz7bwoRBZSCFncDY6EgTXSTeTc6S3ribepvIfqgGJhYB5jgtSxVfP7X/y8qELeeax8mhAMqnY8eQm2Vxv/kO9FU5thCcW6GQiiq83PiycuzJCRicCfoeRNywUqZeELgkwXEqLnPS2mJdmkvdquaOPS9/2EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 1C372115; Sun, 17 Aug 2025 22:26:08 -0500 (CDT)
Date: Sun, 17 Aug 2025 22:26:08 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Shankari Anand <shankari.ak0208@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] rust: cred: update AlwaysRefCounted import to sync::aref
Message-ID: <aKKdULYbLFRMS9qe@mail.hallyn.com>
References: <20250816114409.10107-1-shankari.ak0208@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816114409.10107-1-shankari.ak0208@gmail.com>

On Sat, Aug 16, 2025 at 05:14:09PM +0530, Shankari Anand wrote:
> Update the import of `AlwaysRefCounted` in `cred.rs` to use `sync::aref`
> instead of `types`.

Thank you for forwarding, Miguel.

As far as I can see from the included links, this looks good.

> This is part of the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to the `sync` module for better modularity.
> 
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

> ---
> It part of a subsystem-wise split series, as suggested in:
> https://lore.kernel.org/rust-for-linux/CANiq72=NSRMV_6UxXVgkebmWmbgN4i=sfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
> This split series is intended to ease review and subsystem-level maintenance.
> 
> The original moving patch is here: (commit 07dad44aa9a93)
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07dad44aa9a93b16af19e8609a10b241c352b440
> 
> Gradually the re-export from types.rs will be eliminated in the
> future cycle.
> ---
>  rust/kernel/cred.rs | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
> index 2599f01e8b28..4a2229542fb7 100644
> --- a/rust/kernel/cred.rs
> +++ b/rust/kernel/cred.rs
> @@ -8,11 +8,7 @@
>  //!
>  //! Reference: <https://www.kernel.org/doc/html/latest/security/credentials.html>
>  
> -use crate::{
> -    bindings,
> -    task::Kuid,
> -    types::{AlwaysRefCounted, Opaque},
> -};
> +use crate::{bindings, sync::aref::AlwaysRefCounted, task::Kuid, types::Opaque};
>  
>  /// Wraps the kernel's `struct cred`.
>  ///
> 
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> -- 
> 2.34.1
> 
