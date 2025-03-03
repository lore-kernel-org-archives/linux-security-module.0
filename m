Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4750D23814F
	for <linux-security-module@vger.kernel.org>; Mon,  3 Mar 2025 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741042512; cv=none; b=SPWi7HoejMFiiQVDRV3jB/83OaIR7+Vp9onzvyztGrH5AImWwTyz9Qvva9s8exF4xJ41U80ixb68HZ40gEWALf8/3++TTAH29pIvSIF3Vh2bDS1CSSx+7oKUgzZr2mh0siyY+qfvqO+vNovqgstny3z/pvpvLuQ2HFENIcrFNvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741042512; c=relaxed/simple;
	bh=FV0AMXP2plgQ+6X5x5sS4h/E9JkH8Jx7ZwLybj2GHcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6KsUr3/9xYo/7jcNZgLQWNgIpoUdG2c5ccCWBokIgJOS24rnQOsvIZ9IrwHiffxhjntXqMPZ1Hh3aqqP/FBllJC5sVH6SlXGMQYtBV/chEC5m3kXnrpLqWoahDHSJOBeydv0vSP8Huq3JHqA1DeKJp6UqAz00RVJmMyrgAceZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=atuko3OM; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="atuko3OM"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6fd6f7a8c84so16864627b3.2
        for <linux-security-module@vger.kernel.org>; Mon, 03 Mar 2025 14:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741042508; x=1741647308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsORS7Y/VoLn8iE6xrSTP5GOFu3anHKEztygS4ARAzc=;
        b=atuko3OMuoBz3M8LQtPH5T/blMmnfG/pMclyA6oWZsL/vtwG+Q0vl3DoLc+AhhtddT
         ZgQTKtkenmfV9rf0t5H+Nja4KOJfROLi+nZvlIjd+K3VX47myciX4rJcrLqCoTWzb+nC
         G3s0fXm75FEizTCevZPrKSK/N6kQ/+g/sEHSEuFUbTwiFCDsLCKV3POnZI1X/8ZZPhc9
         hLCBxkKTwePc0zGerA9BhVEFCAwD91CZLUAd8iiuwSTNOEsMD8RMxFZ/9Tpj0bMJaKMW
         93Y0origjL0yPlr9s5ijGsI6eZ6frktvV3kPrp4xiFoz3lmn+MFHQ/QRo+T4eUVsIzBW
         Wz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741042508; x=1741647308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsORS7Y/VoLn8iE6xrSTP5GOFu3anHKEztygS4ARAzc=;
        b=VO7iDIxW8kZc3v3Aq6hvvaT8tYhVA68w5OoM0n1y4CtX59jKOCVaSwHWWnqrK+niMK
         nxQX6tRZ7EPGQxThUxgJ0wr9u8Po7+xrwhzUHcF/nY9CVvCnZeP4ChS1Z6YMqyXzll7H
         mJPhRs/GP0pzuLjFdgVv+BP1jTAsf5w9J0zm8fzSlSuE2/U9PhsCK9kLNrdLDDy9QPXW
         0TI8jPMa/PRsDF5FWeGzaF/hnG9SInIGNL4xrlmSJNNw+r46J3yzIKjk4xqGLqiDyJHx
         P8U3lHdXwb2fVkFsfmkLu0yDwKIrgjUe+OBpznQoM+HW8lrbsyhyGf48BZmeTFdX++9B
         sbWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8HMagJ2/tP/KI/ae5tqg7bhQrtirrp6DZnvOeNLRZj/nSL+EBq6NEnLHmGKItCVnZrGoZh6MML4VUJ+f7adLDu7vVm5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ZbS8yUqbSR+Jd6wUlOByrwKT4QsLJYmYxuawf8ZshTzY555F
	8xFkrmsygUEbHsRvgl1LUPLEiXEEBU5+ygJiN6+ugYcNTGqWokBM0UuA2I5KPJDfje4bNKtKFzu
	C4439XyT72M6STiozAeYbNeVYTHZTHdRtZ0YV
X-Gm-Gg: ASbGnctm56ONpUK3KnYXhXhRJLD6EPmhYPY154shofDZtCywI55G0ijF3+bVSd6siSs
	n/QD6B4+BDg8Wr/ioqAnZiEva1UwKhsQQ8s/HaGKBtj4GqUAoOIBwtU7Kf9CVAIAJgaHla7ei11
	Ak4o73lnXyhnpAwWVKRdF0kaHWmg==
X-Google-Smtp-Source: AGHT+IE6rf8uW5Ake0yIOw7LcxxwfLNQ7aN2DZQJSmlz7GVUFfcRLmQdGJcdT3Qfu+CP0SMft2VWYj9dKOHeWHzxgUA=
X-Received: by 2002:a05:690c:3686:b0:6fb:b4e7:1471 with SMTP id
 00721157ae682-6fd49f9f825mr204154037b3.7.1741042508271; Mon, 03 Mar 2025
 14:55:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-inline-securityctx-v1-1-fb7b9b641fdf@google.com>
In-Reply-To: <20250303-inline-securityctx-v1-1-fb7b9b641fdf@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 3 Mar 2025 17:54:57 -0500
X-Gm-Features: AQ5f1Jr5IfzltzAXVNhmGo-A7qd4NzIh3iaT1pjM1-RaMmUpgWxt70koGP_h_PA
Message-ID: <CAHC9VhSo3aGsJVd=a3MTeakgU66oTN86oh5sZE8P4ghSk8Rx2g@mail.gmail.com>
Subject: Re: [PATCH] lsm: rust: mark SecurityCtx methods inline
To: Alice Ryhl <aliceryhl@google.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 10:30=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> I'm seeing Binder generating calls to methods on SecurityCtx such as
> from_secid and drop without inlining. Since these methods are really
> simple wrappers around C functions, mark the methods to inline to avoid
> generating these useless small functions.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/security.rs | 5 +++++
>  1 file changed, 5 insertions(+)

While this isn't specific to your patch, Casey's comment about "free"
vs "release" is something to keep in mind when working on the LSM
bindings; what happens inside the individual LSMs for a given LSM hook
can vary quite a bit.

I also saw a similar Rust patch where a commenter suggested using
"impersonal facts" in the commit description and I believe that is a
good idea here as well.

Beyond those nitpicks, this looks okay to me based on my *extremely*
limited Rust knowledge.  With the minor requested changes in place,
would you prefer me to take this via the LSM tree, or would you prefer
it to go up to Linus via a more Rust-y tree?

> diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
> index 25d2b1ac3833..243211050526 100644
> --- a/rust/kernel/security.rs
> +++ b/rust/kernel/security.rs
> @@ -23,6 +23,7 @@ pub struct SecurityCtx {
>
>  impl SecurityCtx {
>      /// Get the security context given its id.
> +    #[inline]
>      pub fn from_secid(secid: u32) -> Result<Self> {
>          // SAFETY: `struct lsm_context` can be initialized to all zeros.
>          let mut ctx: bindings::lsm_context =3D unsafe { core::mem::zeroe=
d() };
> @@ -35,16 +36,19 @@ pub fn from_secid(secid: u32) -> Result<Self> {
>      }
>
>      /// Returns whether the security context is empty.
> +    #[inline]
>      pub fn is_empty(&self) -> bool {
>          self.ctx.len =3D=3D 0
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
>          let ptr =3D self.ctx.context;
>          if ptr.is_null() {
> @@ -61,6 +65,7 @@ pub fn as_bytes(&self) -> &[u8] {
>  }
>
>  impl Drop for SecurityCtx {
> +    #[inline]
>      fn drop(&mut self) {
>          // SAFETY: By the invariant of `Self`, this frees a context that=
 came from a successful
>          // call to `security_secid_to_secctx` and has not yet been destr=
oyed by
>
> ---
> base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
> change-id: 20250303-inline-securityctx-6fc1ca669156
>
> Best regards,
> --
> Alice Ryhl <aliceryhl@google.com>

--=20
paul-moore.com
