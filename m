Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D65E31CA4E;
	Thu,  7 May 2026 06:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778133909; cv=none; b=TR4ySzAPkwk5dJX2P2yOcPlilD9AJppJFmE+amwrm9DXmxGnwE0D2PppyjEGZKcATGxVgNSQLDVlF3vKPlrDihAS25XU9zwhZNCQwzXHObzB/UGyKIlllPZbV1OgBmT77esWf5ABn7VGT8mhMfA9oAG0OAcZqazM+4pk3/FKwEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778133909; c=relaxed/simple;
	bh=3ljGVHw/6i3qOv9qTqFWVXgKYNrfoGFKt67UH+keQbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZWOvIHEXnsD71XdxLYjYHjmlB0YQF1fmb+YR7jZtCswAnhdyW5SKny2x5nCF89sBJY4hajtBCwPp7yL9BDmTGCMlmnKR6YJgDkt7vCJ/dIOmh54/b+IegbBVzUXbf/Cc+rPJRQXEt17ftoFXxQL+l9Imh/p9v9yzTLLENbjL54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Byl86ARb; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Byl86ARb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1778133897; x=1778393097;
	bh=q7siNWBmdh77w3gZcDSL2FMwsQUmh6rQ8BtPvRuFbWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Byl86ARb6vY+Ag7C6vyA3t6zAw+0Jb+P2bu4LSsSvXtSXHbEt6BGT6A5yEYjEenqx
	 6q/LMbz6gcQ4yj4XMtFu0EHxJLU1060wB8TfPaOBE48g4A7A1GCBqmjVYVl4bB/xeY
	 kuoJBEpjCRHfGWCqbssDE9+q0pRiDXccLIxmfOA2EiS/BwkO4rk8YdENLxWL6F1csM
	 JWQXUzqhQdZz6by8A3BZpgJMMM8wvmpXsOfC1AardIbSkueYWYH4PNdskeIX5sxx8w
	 oBqPpuoVzC0iwRHiuqj6/D/8awcxMF4Ygso7yP7oQhKj3tIGPt29rMblKXgu5tbFRw
	 BIHa9CmqpataQ==
X-Pm-Submission-Id: 4gB1tZ5g7Cz2Scm6
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Arnav Sharma <arnav4324@gmail.com>
Cc: ojeda@kernel.org,
	paul@paul-moore.com,
	Serge Hallyn <sergeh@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-security-module@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: cred: add safe abstractions for capable() and ns_capable()
Date: Thu,  7 May 2026 09:04:49 +0300
Message-ID: <20260507060452.5270-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260506204913.26022-1-arnav4324@gmail.com>
References: <20260506204913.26022-1-arnav4324@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 07 May 2026 02:19:13 +0530=0D
Arnav Sharma <arnav4324@gmail.com> wrote:=0D
=0D
> The capable() function is the primary privilege gate in the Linux kernel,=
=0D
> used to check if the current task possesses a specific POSIX capability.=
=0D
> While bindings for capable() and ns_capable() exist, there are currently=
=0D
> no safe Rust abstractions for them.=0D
> =0D
> Introduce safe Rust wrappers for capable() and ns_capable() in the=0D
> kernel::cred module. These functions validate that the requested=0D
> capability is within the valid [0, CAP_LAST_CAP] bounds before calling=0D
> into the C side, ensuring that safe Rust code cannot inadvertently=0D
> trigger a kernel BUG() on invalid inputs.=0D
> =0D
> The abstractions take a `u32` parameter to ergonomically match the=0D
> generated `bindings::CAP_*` constants without requiring explicit caller=0D
> casts.=0D
=0D
Do we have any users who need this? What's the use case and where will this=
 be=0D
used?=0D
=0D
-Onur=0D
=0D
> =0D
> Signed-off-by: Arnav Sharma <arnav4324@gmail.com>=0D
> ---=0D
>  rust/kernel/cred.rs | 79 +++++++++++++++++++++++++++++++++++++++++++++=0D
>  1 file changed, 79 insertions(+)=0D
> =0D
> diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs=0D
> index ffa156b9df37..6525b52b81ae 100644=0D
> --- a/rust/kernel/cred.rs=0D
> +++ b/rust/kernel/cred.rs=0D
> @@ -90,3 +90,82 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Credential>)=
 {=0D
>          unsafe { bindings::put_cred(obj.cast().as_ptr()) };=0D
>      }=0D
>  }=0D
> +=0D
> +/// Checks whether the current task has the given capability in the init=
 user namespace.=0D
> +///=0D
> +/// This function tests whether the current task has the specified POSIX=
 capability available for=0D
> +/// use. The check is performed against the initial user namespace (`ini=
t_user_ns`).=0D
> +///=0D
> +/// When the check succeeds, the kernel sets the `PF_SUPERPRIV` flag on =
the current task. This=0D
> +/// marks the task as having used superuser privileges, which is visible=
 in process accounting=0D
> +/// and auditing.=0D
> +///=0D
> +/// The capability constants are available as `bindings::CAP_*` values (=
for example,=0D
> +/// [`bindings::CAP_NET_ADMIN`], [`bindings::CAP_SYS_ADMIN`]). These con=
stants are defined in=0D
> +/// `include/uapi/linux/capability.h`.=0D
> +///=0D
> +/// This function must be called from task (process) context only. Calli=
ng it from a context where=0D
> +/// there is no valid `current` task (such as hard interrupt context) is=
 not permitted.=0D
> +///=0D
> +/// # Preconditions=0D
> +///=0D
> +/// `cap` must be a valid capability constant in the range `[0, CAP_LAST=
_CAP]`.=0D
> +/// Passing a value outside this range is a programming error and will t=
rigger=0D
> +/// a kernel `BUG()`.=0D
> +///=0D
> +/// C header: [`include/linux/capability.h`](srctree/include/linux/capab=
ility.h)=0D
> +///=0D
> +/// # Examples=0D
> +///=0D
> +/// ```=0D
> +/// use kernel::bindings;=0D
> +/// use kernel::cred::capable;=0D
> +///=0D
> +/// if !capable(bindings::CAP_SYS_ADMIN) {=0D
> +///     return Err(EPERM);=0D
> +/// }=0D
> +/// # Ok::<(), Error>(())=0D
> +/// ```=0D
> +#[inline]=0D
> +pub fn capable(cap: u32) -> bool {=0D
> +    // SAFETY: `capable()` is safe to call from task context. It checks =
`current_cred()` against=0D
> +    // the init user namespace and returns whether the specified capabil=
ity is granted.=0D
> +    unsafe { bindings::capable(cap as i32) }=0D
> +}=0D
> +=0D
> +/// Checks whether the current task has the given capability in the spec=
ified user namespace.=0D
> +///=0D
> +/// This is the namespace-aware variant of [`capable`]. It tests whether=
 the current task has the=0D
> +/// specified capability in the given user namespace, rather than in the=
 init user namespace.=0D
> +///=0D
> +/// This function is relevant for code that must respect user namespace =
boundaries (for example,=0D
> +/// operations inside unprivileged containers). For most driver code tha=
t is not namespace-aware,=0D
> +/// [`capable`] is the correct function to use instead.=0D
> +///=0D
> +/// Like [`capable`], this function sets `PF_SUPERPRIV` on the current t=
ask when the check=0D
> +/// succeeds, and it must be called from task context only.=0D
> +///=0D
> +/// # Preconditions=0D
> +///=0D
> +/// `cap` must be a valid capability constant in the range `[0, CAP_LAST=
_CAP]`.=0D
> +/// Passing a value outside this range is a programming error and will t=
rigger=0D
> +/// a kernel `BUG()`.=0D
> +///=0D
> +/// C header: [`include/linux/capability.h`](srctree/include/linux/capab=
ility.h)=0D
> +///=0D
> +/// # Safety=0D
> +///=0D
> +/// The caller must ensure that:=0D
> +///=0D
> +/// - `ns` is a non-null pointer to a fully initialized `struct user_nam=
espace`.=0D
> +/// - The `user_namespace` pointed to by `ns` remains valid and is not f=
reed for=0D
> +///   the duration of this call.=0D
> +#[inline]=0D
> +pub unsafe fn ns_capable(ns: *mut bindings::user_namespace, cap: u32) ->=
 bool {=0D
> +    // SAFETY: The caller guarantees that `ns` is a non-null, valid poin=
ter to a fully initialized=0D
> +    // `struct user_namespace` that remains valid for the duration of th=
is call.=0D
> +    // `ns_capable()` checks `current_cred()` against the provided names=
pace and returns whether=0D
> +    // the specified capability is granted.=0D
> +    unsafe { bindings::ns_capable(ns, cap as i32) }=0D
> +}=0D
> +=0D
> -- =0D
> 2.43.0=0D
> =0D
