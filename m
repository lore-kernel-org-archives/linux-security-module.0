Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A8C1BE871
	for <linux-security-module@vger.kernel.org>; Mon, 18 Aug 2025 22:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755554768; cv=none; b=ohndDXyuHl3+KxhkzDye0w3TVWvAnMFEAvehpUbISC7pdvTZlU52A3a4+c6om3CoTOnmpsMVQCcxYqiwGqwbLu9kFYpTqp9+WN5KiLkSri8KC8ZDqKnCnDUKHFl96MiOc2209zTP6iDXqpG4XILWnRfXnRu+TlXtYgLzrB5gjOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755554768; c=relaxed/simple;
	bh=N3tSa4eZY9kU9rIayo2ksXQAHAw93ivpiznq9dIOADU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfPgah2Kg7zIG+ooK2Z6CiyoaOvjl1Og0AoMdCe8sRyo852eBhWnzrVqOwd2/iOLtt6GN/HvFYNqSEbc7qXJXbIbMwPAq9s2jYhcAEMIbefRBLPoCQh7glYpsMsgz9vNovV3NTHnCDUT896BlYr2LZFJyOU+r/yURUhS1cZBaY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eUyIgmSg; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eUyIgmSg"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9a342e8ffso3294363f8f.0
        for <linux-security-module@vger.kernel.org>; Mon, 18 Aug 2025 15:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755554765; x=1756159565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3tSa4eZY9kU9rIayo2ksXQAHAw93ivpiznq9dIOADU=;
        b=eUyIgmSgwMGpxG3HtV2ALZmX11xFjEi2wLVICOcCfZfpwYmswf8Qevd5opmgNFMq7S
         dheQlOqCEMGkJGBZXtgrmgqstBdlKfn0bliEFCutds6KF0E0iMB26JBNUmPifDudoLxb
         ESjqoSm88S2CN6dgg+ZI2jV+Y8XpNeb/8ciZxzGEZUIGhb9z7pHEVSeC8R7RxS8DL/3q
         ZlPJxqnLpQIORfxSmGSP17YbJB4zycLEpqSx7EynpU+P5V2URqezTe1nk1rNAyvxompk
         8YXPaJmI1RxHDj4HEJezrVUHT3unTJdSlJjRCtZQ2Xud9wh2EjYGxp9tui9S4FLX/CHV
         ovcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755554765; x=1756159565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3tSa4eZY9kU9rIayo2ksXQAHAw93ivpiznq9dIOADU=;
        b=UtK0JLy7dwCYIPcbafJqe4YUiu4bj0E2FZ2uvOQX3kyOcJP1ldA8dJ9JU9+bjWxBHZ
         Nt7THG1+z0JfjQZi2WWetMyJApIUX0uDl0sTOOIWKRJpN6WW5AjW+sfuWk98TdgpbfuW
         wCGDC0nKRXA2gEQNixEGWOFFICHKH0L5U2VrD/PIBZdgsUwDoi6KI+s0qqXwOsioxFiL
         ho70VVB0JVtC0BCQun160mVE486MeQKpUYBtBpr1eAw0U1wgZpLiPIUK+FxOgRJAQcj2
         Zb2cn/lbKd/QA1uoPsw6FRBuEZ7z0WzY+nKqa47cy07yqVJFXy6hkbrhlaRehgf7p8FO
         U7Dw==
X-Forwarded-Encrypted: i=1; AJvYcCV1w7fICr9sugYewnSt/fhrATrchCTr+D/wR9M1N2KM0q4C0HLV36W1R4ADHOTqXfmET864IXTvqs8HoIadSvlTJqJMTRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLwMh3Z6SYOIvdPHpxEQLSWWNa/J69DvLRnKkGSkWyEwSKaoTl
	agsGO4K5ev70IV77wxs0lPPE05lvkOy0nm/O2jHmMTy48LTr2dtCT8SuErlBpmBe7BvQvzNETlx
	3qUC28hhFoklPHsfAf/lB+yYzrgk2y2QDUuiRRz2P
X-Gm-Gg: ASbGncvy/XkPX9I/gjOOTGMewhSGFvebI4VR2qm4MLoqW4BaDClK8uRNTFwZceu9ua0
	cqSYS49cPFwGVGfCgVRZw5Fd9l9y5HVfILZR8BywaQ0Ilk1wssjQqdcOOwyXw6ZoPoCDxuoS9Q/
	Gcde8KnV6grAAfck0PUkzo8p9PgndrUQwgG/IP5+tf9kGbQXAyW24S52gQVKOZvG1gO4CXm+HZZ
	DqUUfKeXjGChqyQV6tVSRxepw==
X-Google-Smtp-Source: AGHT+IFCQt6uTdxNJOL8MDlH+UvsjGsdlpD1gJo+LDPFtuqTKkPLiGhf2m1VSyVS6vfpJ8pjthhmwUtwki2fM1T2D9w=
X-Received: by 2002:a5d:5d0a:0:b0:3b7:8acf:1887 with SMTP id
 ffacd0b85a97d-3c1333b5d05mr49367f8f.13.1755554765184; Mon, 18 Aug 2025
 15:06:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816114409.10107-1-shankari.ak0208@gmail.com>
 <aKKdULYbLFRMS9qe@mail.hallyn.com> <CAHC9VhRwpYx0jVybcAnGdm4AGDno-GwyCzZCS7U+56Fwu2tuCg@mail.gmail.com>
In-Reply-To: <CAHC9VhRwpYx0jVybcAnGdm4AGDno-GwyCzZCS7U+56Fwu2tuCg@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 19 Aug 2025 00:05:52 +0200
X-Gm-Features: Ac12FXxHVkHHjsjzroxYO2hLV5awVzQ5ch9P37B2T1QViWU5EDCtAQkTwIhqx1E
Message-ID: <CAH5fLgin9OhTmf52i2hQKztYLcHTxE+n1gMPXDFN83atE+u_oA@mail.gmail.com>
Subject: Re: [PATCH] rust: cred: update AlwaysRefCounted import to sync::aref
To: Paul Moore <paul@paul-moore.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Shankari Anand <shankari.ak0208@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 11:22=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Sun, Aug 17, 2025 at 11:26=E2=80=AFPM Serge E. Hallyn <serge@hallyn.co=
m> wrote:
> > On Sat, Aug 16, 2025 at 05:14:09PM +0530, Shankari Anand wrote:
> > > Update the import of `AlwaysRefCounted` in `cred.rs` to use `sync::ar=
ef`
> > > instead of `types`.
> >
> > Thank you for forwarding, Miguel.
> >
> > As far as I can see from the included links, this looks good.
> >
> > > This is part of the ongoing effort to move `ARef` and
> > > `AlwaysRefCounted` to the `sync` module for better modularity.
> > >
> > > Suggested-by: Benno Lossin <lossin@kernel.org>
> > > Link: https://github.com/Rust-for-Linux/linux/issues/1173
> > > Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> > Acked-by: Serge Hallyn <serge@hallyn.com>
>
> As mentioned previously, I'm still not well versed in Rust so as long
> as Serge is happy with it, I'm good with it too :)
>
> I'm guessing it probably makes sense to include rust/kernel/cred.rs in
> the creds MAINTAINERS section just as we did (or will do) with the LSM
> Rust shim?

That would make sense to me.

My understanding is that this patch, unlike the pin-init one, is
intended to go through the LSM / CRED tree rather than taking
everything through a shared tree with Acked-bys.

Alice
