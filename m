Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ABF3D96A
	for <linux-security-module@vger.kernel.org>; Sun, 15 Sep 2024 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726433730; cv=none; b=XKnQb8jlLIWN1tj5E+hbnbjWUeSdXFmAkCyO9uS0sublvOp5at4+j/ruE2MJG9HUTzG27CmCyA4Ws5Re+FSNvlAIFNfWD5+pYYE/CWHWxpHg+g5HPhcA5CNeHpMz7JUm51GVLC/CPxAeJM6WoQ1NGo+VWw9+d2cPVGn4S9LXVZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726433730; c=relaxed/simple;
	bh=kbZNky2ukXvY0Uc/WKbVfKtB+125N5NWRZV5J8lxpnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LaRe7+Q2HWRuPrrJJMtuYSAAvQylwAF9mHSJu0cvZQYY2RAlsPBcAc9RCtYSZ+scHEnP/5JTDsFDSuhDL8Ac/mBdko8cv4EdwVHvuKenPY5OrJK5YzCT6Vb74hsWKY06IEUFhqz+Khx7cDTycWkTbwVT0XGx5U2eWHmbSccUajE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gk/i8tBs; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gk/i8tBs"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374c1e5fe79so2861433f8f.1
        for <linux-security-module@vger.kernel.org>; Sun, 15 Sep 2024 13:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726433727; x=1727038527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfyOcCKII5XM0b+CTX5LMl9eYoo09Pc3xQQkicZRlpw=;
        b=gk/i8tBsy71cOeQm258Fa49MCimEZtr28Vsw/bGbcx+0Uoc7w+aUgY5yK+PZj6MvhS
         jw34RVlPRwWkkkEFALmWcwfVq5KAr5uKSLz2lZOOw2KhRAzCF0AWCfyE4QB4g+wSFYgA
         HwtM9tAMAIgJeFlfPGESlhaePm01m729c6zT3GyK0LiEkIr5L71kSpKM24d2ZuDrTHCs
         A3977eyMPLWwrUQpSTpLh/kmxKOqC/VMJAw6KqTozEULV8b1QgP9F79yZIvueHUr4rUZ
         ibllM9wwHtJVM1tfsP5u25IqwVbZGEK+/MuO/MN0ZqMJAMr30JtbpO2CMHPJ7vxoulc/
         uVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726433727; x=1727038527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfyOcCKII5XM0b+CTX5LMl9eYoo09Pc3xQQkicZRlpw=;
        b=XB8OAgC2FL6MMgJ8/HQf4AsNihT3W8oMQp0WPeSyW54Bqm91lKrZctCqxYPxKWb8JD
         8EqQUg599RnWpkB87uxq7KKO4+TbMMyI9R2lr9ofzUweRPDIH2CMUSWvqlhqTxfgYpzU
         cHjcXVH+V+nvFwWZY5zL9g1JODVn/xV9QRSGMqMzS/8ZzsEdeBwcm1DGDI5kM6Ig+inE
         G6PrBBxJrsSbj/ySklk7jj0TKyZP5R6hmooxzeTqCDyarvpENzRr63mJMLfdQ2omb34g
         6KedIfIKujlKnovcbEa+rMVbjPUt+2gG72rYYw9nQAng8ifoYoS2Bg2Ou5m+DGeyZUfT
         p+TA==
X-Forwarded-Encrypted: i=1; AJvYcCUvgXDiw/OikMFjfSKM2xPbmlvkLS+kLoV4D4JwNz+zI/GItoMERZhjd89vKq4OZGYpd5VRMB5hpBBtXGaAC17mUlSny74=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYNr9wuZOyB5WVH5eQN5JDg/bmbelzwO44tL99Yivth40JtLz1
	/hpiuQ1jPN2VZpp5x/lAwoiyQ2PX1k6qCbVvbiXyh+RXp9wzk1BvWXXkNw//IGeaGGG7iAYxta4
	SxmJdQhaf1FIsimXQcC8Jtua3xnqjHlpIEU4z
X-Google-Smtp-Source: AGHT+IGWQFeQZDzyxBRRhaH5iScrdOKBeEJq6VtM+ljzHFnbYqYR/PmkuUpSMTFjiniQmsfNYWGWBK53pTW4OLn7fX0=
X-Received: by 2002:a05:6000:c86:b0:378:8aaa:9cd6 with SMTP id
 ffacd0b85a97d-378c2d62046mr7188675f8f.49.1726433726342; Sun, 15 Sep 2024
 13:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
 <20240915-alice-file-v10-4-88484f7a3dcf@google.com> <202409151318.7985B253@keescook>
In-Reply-To: <202409151318.7985B253@keescook>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sun, 15 Sep 2024 22:55:14 +0200
Message-ID: <CAH5fLgjRpY9vYWw0T0g3R_zndvj6AGKHeHw=H2yM+C5-SHt6BQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/8] rust: cred: add Rust abstraction for `struct cred`
To: Kees Cook <kees@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 10:24=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Sun, Sep 15, 2024 at 02:31:30PM +0000, Alice Ryhl wrote:
> > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> >
> > Add a wrapper around `struct cred` called `Credential`, and provide
> > functionality to get the `Credential` associated with a `File`.
> >
> > Rust Binder must check the credentials of processes when they attempt t=
o
> > perform various operations, and these checks usually take a
> > `&Credential` as parameter. The security_binder_set_context_mgr functio=
n
> > would be one example. This patch is necessary to access these security_=
*
> > methods from Rust.
> >
> > This Rust abstraction makes the following assumptions about the C side:
> > * `struct cred` is refcounted with `get_cred`/`put_cred`.
>
> Yes
>
> > * It's okay to transfer a `struct cred` across threads, that is, you do
> >   not need to call `put_cred` on the same thread as where you called
> >   `get_cred`.
>
> Yes
>
> > * The `euid` field of a `struct cred` never changes after
> >   initialization.
>
> "after initialization", yes. The bprm cred during exec is special in
> that it gets updated (bprm_fill_uid) before it is installed into current
> via commit_creds() in begin_new_exec() (the point of no return for
> exec).

I think it will be pretty normal to need different Rust types for pre-
and post-initialization of a C value. When a value is not yet fully
initialized, you usually get some extra powers (modify otherwise
immutable fields), but probably also lose some powers (you can't share
it with other threads yet). I can document that this type should not
be used with the bprm cred during exec.

> > * The `f_cred` field of a `struct file` never changes after
> >   initialization.
>
> Yes.
>
> >
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> > Reviewed-by: Trevor Gross <tmgross@umich.edu>
> > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> > Reviewed-by: Gary Guo <gary@garyguo.net>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> Reviewed-by: Kees Cook <kees@kernel.org>

Thanks for the review!

Alice
