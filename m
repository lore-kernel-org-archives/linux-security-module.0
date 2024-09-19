Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6580198A24
	for <linux-security-module@vger.kernel.org>; Thu, 19 Sep 2024 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732608; cv=none; b=CrAyBUVS/enaq6DrAgPC/gRt9IfDWLlJfj18aLlL8NphUtT/GAc+VZ+VVP5vTL/sPHKXzU1ziVjdqt84D8EQ84Rm3LDmCdtwHlJsBapS+69mtTMEp2pezL2Le+NSwb0/QEkNsVC0DLDGGyGVrB00xGwrsNDNT6lpC/3dkEv2ikk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732608; c=relaxed/simple;
	bh=licP1aKu2lO31lzxZuFaxdBKh2M+wK8LBAdaKCY5Plg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhVUtNqR4GanoY5OBOVAyXnxjePd7NjwGkih1+mP09Z/d4YNUwWH/lS6MIHiNeiqNJRStdInbQ33HesdI86du3XiDgQRKQvAm2JoXtwe+crEScYGS2I1buAQccCT7+f+khACqqeuX+WSE3TufjOpXWFQHLmz97QtKIa0LmO6N18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N+xPWqwO; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N+xPWqwO"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e0b7efa1c1bso588368276.3
        for <linux-security-module@vger.kernel.org>; Thu, 19 Sep 2024 00:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726732606; x=1727337406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2a4eRU49xX2INaiUTp0IA2e1oYGO5r7N/3DbhAJv4c=;
        b=N+xPWqwODKHsUmthiIGyTezlBk3rD1u9YnFtaR30d87kI+jLGAtYp80doTOuzxvnyn
         7viwLUbqihUKYmgpVWr5r3OUSQQYjBBWuEwXoPrON9Xbkl2/m0qCPXzEHVJJry2zbLJP
         MeN98aRA1VSusTVYQV8/DJgw0cloQ8z4QvRFIjrklFB3CNoGMPA90WPyon1/bo11Q+oJ
         1F3Lkf4togrvqtLXIoaCG2GMl5PyeNHWm4TbPuOkuezsdrl2YgMHDVkhqi4kyntET/ky
         5r3XZXCwsav9+C3e+0EM1nTFFnj7Ia2XtTPDDaed1uikGj6y6yuedasWvNYDA4DTDYMt
         wyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726732606; x=1727337406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2a4eRU49xX2INaiUTp0IA2e1oYGO5r7N/3DbhAJv4c=;
        b=IXa7wdvF9QibfrJY8C3SFskxR/X3IFDa0Yqz2j2dV4PENGm37rWFw0c+DjzumnoaAD
         bSGr8FPJ5pGfzN2qIFOKEfAEI42Cr2voUAhx+iYOF2cmZoV+7EbTd3bArRS/hyRNrcOn
         objbdsRfw4bmPwDqaYwoUBk3bVkYcW9rnbi7ycLPjXfCTUPooJY4wns5HdQ1jQyZlcvO
         sJSQg8I1+dVQn5boDf26d/RIAeaN1X2KbWQlF0bnYFNNcbwStyL4BZ5rlMYZzESA+Q8B
         xpXtqR48BxHbHmh2+W8DbS/hDw8fhTQZSrzYDa9/8VvVE87vuPrsgk5MKXDTlGxLRQYG
         UZWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxaQKSzTv7Qxgnm49KgilB+3k88Ui1aUyIFJZ/KGBLuZEef6xzzUkZPG14wGS1lq39egenp3ugq6RntwAFBM617y9WRaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVoR8LVcrisum+I2CRH5QLm4A7Vk33yooj/IQ7iGbS68l5J6Tn
	W4lBlV05xkurxgvG90NlApl4pvzjLu5A3SCh6oVGdHGCZ3B9eyvs35WW94BQw3YpBRtXwHd7RNO
	SDC4PeKLt7tVOJMNtyfemdZWyoukyNRPmqaYj
X-Google-Smtp-Source: AGHT+IGGUSzdO2I0anZLf3+uZThLjZFuPCtbBPnYMnHwjyRvn0j/ljOlNxpzQq6H2AStCXdo/UzmJxPrBrb4KTlZPh4=
X-Received: by 2002:a05:6902:1612:b0:e0b:efa8:18b6 with SMTP id
 3f1490d57ef6-e1d9dc412cfmr21057746276.45.1726732605952; Thu, 19 Sep 2024
 00:56:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com> <20240915-alice-file-v10-5-88484f7a3dcf@google.com>
In-Reply-To: <20240915-alice-file-v10-5-88484f7a3dcf@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Sep 2024 03:56:34 -0400
Message-ID: <CAHC9VhQmgQP=WPGdg_2fGUAuKLQ0V2DF8FWXhfVrou=RdLE4bg@mail.gmail.com>
Subject: Re: [PATCH v10 5/8] rust: security: add abstraction for secctx
To: Alice Ryhl <aliceryhl@google.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
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
	linux-fsdevel@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 10:31=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> Add an abstraction for viewing the string representation of a security
> context.
>
> This is needed by Rust Binder because it has a feature where a process
> can view the string representation of the security context for incoming
> transactions. The process can use that to authenticate incoming
> transactions, and since the feature is provided by the kernel, the
> process can trust that the security context is legitimate.
>
> This abstraction makes the following assumptions about the C side:
> * When a call to `security_secid_to_secctx` is successful, it returns a
>   pointer and length. The pointer references a byte string and is valid
>   for reading for that many bytes.
> * The string may be referenced until `security_release_secctx` is
>   called.
> * If CONFIG_SECURITY is set, then the three methods mentioned in
>   rust/helpers are available without a helper. (That is, they are not a
>   #define or `static inline`.)
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/bindings/bindings_helper.h |  1 +
>  rust/helpers/helpers.c          |  1 +
>  rust/helpers/security.c         | 20 +++++++++++
>  rust/kernel/cred.rs             |  8 +++++
>  rust/kernel/lib.rs              |  1 +
>  rust/kernel/security.rs         | 74 +++++++++++++++++++++++++++++++++++=
++++++
>  6 files changed, 105 insertions(+)

I doubt my ACK is strictly necessary here since the Rust bindings
aren't actually modifying anything in the LSM, but just in case ...

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
