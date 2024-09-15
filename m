Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F3617C69
	for <linux-security-module@vger.kernel.org>; Sun, 15 Sep 2024 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726434454; cv=none; b=eH+o0mpv7Bfc/KaBAfHviBpf74xdOjnjH7R7EMHOzUnMGbLt5YGE5+iNZGzsNgwrRLareHZGA9+457m1inrL7S1HadnKwNlSHmEFxUf2FvWOsbxM4JhurHy68Ha/qSmYblkFyd5R0YTRzir7WXym7DhVhBrmXXVB9tFWQl0r/UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726434454; c=relaxed/simple;
	bh=u0mauue4pFbpJvPlGNnG8KmtJCv5osrYKUh15cf2xQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ea1qTjYxrulf96sNyhlkc/q4o31b+oMQOLyUiVuSl9CRH1wyvA88N/QgKtyiFQpfX49xDWDE5PV6zuXUVmd6/TFATLBohcXErAXXsdOxSWPdPFyfwGZbgm0vrICVXFAIzRFliNemmaXZMBCeDig9Zubd/h6vg5b0K0UPX81+z2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MHY4Pwzq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MHY4Pwzq"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so31272615e9.0
        for <linux-security-module@vger.kernel.org>; Sun, 15 Sep 2024 14:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726434451; x=1727039251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMSCaCClJjZ0q/vopdrKwBeXnkKAsPzQyB/3kJTnFhk=;
        b=MHY4Pwzqh5CGlH4wC/IS77bKhiHWywWFmRUFNuzLfK2rzG7Kqgi7VQMs5Gew/tQ9PZ
         RGfaDvvMg9OmGHo5mkpIZU3YfFTcOrrZbVH/XsseHfMpUTyO8vYXBzGSYyU3Hm/BYEJs
         KYT5dqzf3twXemIzQWuG3YzWmMEvknhYadBkUYmj9FV6RU5E/EvUNuDDwHeYXRzrLLzl
         washlT17OTkQnEkEl8+8lZmob7wU+TPq0bhhnpKzFGsUxYNgP0SCN8OxFfiP7C8ifuDk
         zGSVV4x8rS80PF0Xa18SO69HK6vCOYyaX8hFhZUgIxsAHDjUzsvYsaKZFptHtvpa/Mtg
         EATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726434451; x=1727039251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMSCaCClJjZ0q/vopdrKwBeXnkKAsPzQyB/3kJTnFhk=;
        b=xMvNj8lHHe+6CBEf3pHDNci33QxM2HYuKXl8nyVNUs1FeNrlhHwKVAIn4zfiNtQgT1
         eUFBsLqQJLLCt1v1FIj8uNkCu0D0qOd7Y7ETa7/LTgQ9bGK5VPm5m5NifQFx7h3NQzcB
         4BYw4a8dcwN1pK6cK6ujYakWUukH9En2Wb3319qLJjBXHjBGzygARjvAHj2zL1GOJD0W
         efw071H9OHPNZ+N9D8l87sjywJj+BhWFmZCdjuvGfEk4CHZxuFPAqaCgjJl1CIJ39G17
         ccC5EbXLkoAZR/1UUG8HHmjxOZyzJIh/lcMJGxvM4ILp7HAkNBA3RHSTIrL1HLNpYYYI
         tRbA==
X-Forwarded-Encrypted: i=1; AJvYcCV4t2BlW4ZulwawTlAybH0B2bfpVVxewEuK/jKPYlNP8np8PardbfXygid+PA5Tx4hdLUo/oeYKOsuGWY6dNNh3praaMkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaOIA8+94G/VOU7Y9gbHESrt1BltTieUz/VniewCNehtuKQelA
	HfdOcEswX5s+pYI2KWXz+ZaTnNdLPMlICegdVtVhNYtEGNlk3+jvfKoF9Bh3A4o9JMqJy2fmhaT
	Ru0iZd19+QDI624yn77GQAzLrVupQJCoCazRv
X-Google-Smtp-Source: AGHT+IHHL9ci38l3QyRKB9ijCz+Na//ffly7AGZW2nAho4rRP9TW1RbmkTpcC/P3ssAUOSVor4hTQsXWMTlb9HHx0V4=
X-Received: by 2002:a5d:4983:0:b0:374:c1f9:ea79 with SMTP id
 ffacd0b85a97d-378c2cd5e5fmr7840237f8f.5.1726434451067; Sun, 15 Sep 2024
 14:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
 <20240915-alice-file-v10-5-88484f7a3dcf@google.com> <202409151325.09E4F3C2F@keescook>
In-Reply-To: <202409151325.09E4F3C2F@keescook>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sun, 15 Sep 2024 23:07:19 +0200
Message-ID: <CAH5fLghA0tLTwCDBRrm+GAEWhhY7Y8qLtpj0wwcvTK_ZRZVgBw@mail.gmail.com>
Subject: Re: [PATCH v10 5/8] rust: security: add abstraction for secctx
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

On Sun, Sep 15, 2024 at 10:58=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Sun, Sep 15, 2024 at 02:31:31PM +0000, Alice Ryhl wrote:
> > Add an abstraction for viewing the string representation of a security
> > context.
>
> Hm, this may collide with "LSM: Move away from secids" is going to happen=
.
> https://lore.kernel.org/all/20240830003411.16818-1-casey@schaufler-ca.com=
/
>
> This series is not yet landed, but in the future, the API changes should
> be something like this, though the "lsmblob" name is likely to change to
> "lsmprop"?
> security_cred_getsecid()   -> security_cred_getlsmblob()
> security_secid_to_secctx() -> security_lsmblob_to_secctx()

Thanks for the heads up. I'll make sure to look into how this
interacts with those changes.

> > This is needed by Rust Binder because it has a feature where a process
> > can view the string representation of the security context for incoming
> > transactions. The process can use that to authenticate incoming
> > transactions, and since the feature is provided by the kernel, the
> > process can trust that the security context is legitimate.
> >
> > This abstraction makes the following assumptions about the C side:
> > * When a call to `security_secid_to_secctx` is successful, it returns a
> >   pointer and length. The pointer references a byte string and is valid
> >   for reading for that many bytes.
>
> Yes. (len includes trailing C-String NUL character.)

I suppose the NUL character implies that this API always returns a
non-zero length? I could simplify the patch a little bit by not
handling empty strings.

It looks like the CONFIG_SECURITY=3Dn case returns -EOPNOTSUPP, so we
don't get an empty string from that case, at least.

> > * The string may be referenced until `security_release_secctx` is
> >   called.
>
> Yes.
>
> > * If CONFIG_SECURITY is set, then the three methods mentioned in
> >   rust/helpers are available without a helper. (That is, they are not a
> >   #define or `static inline`.)
>
> Yes.
>
> >
> > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> > Reviewed-by: Trevor Gross <tmgross@umich.edu>
> > Reviewed-by: Gary Guo <gary@garyguo.net>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> Reviewed-by: Kees Cook <kees@kernel.org>

Thanks for the review!

Alice
