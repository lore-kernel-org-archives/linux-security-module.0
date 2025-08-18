Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4308D2236EB
	for <linux-security-module@vger.kernel.org>; Mon, 18 Aug 2025 21:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755552167; cv=none; b=DjT96ZL+hh3ErlMVsjgfdNlEaU8EExxpBgEvbeZ4XxntVhYqDLFv1LiNa26HHFRv0HFstUviA92GJP5IUNa9W26Adb54ZUvy/bBDpI8LTvL+g+ODcTRyn77Ti0VO5DXuIl5j5M4+z4MmcCuakLayfcHLpllvbq78rv/WkznwS/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755552167; c=relaxed/simple;
	bh=SV0SovoncvtQUIWdiz5ZimeTSUpDBwkq5eqoPwW+Sy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSv2QFQWxu3JRINJbnPN7jQ9HJ1ya8IJnPTo7vxOCdEm8qVMdfr33NmPQs6YE3dh1UM6UjO5wINrJD49YRu/ivrdxMwZBhgZlQHU9SHoTO/tBG/8wsS4mKR7UrepW0mFYfCCza13oL5AorhC2DI4b98IDcz9ka6HZagAFW0ahBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TYafCGnY; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TYafCGnY"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2e613e90so3333210b3a.0
        for <linux-security-module@vger.kernel.org>; Mon, 18 Aug 2025 14:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755552165; x=1756156965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SV0SovoncvtQUIWdiz5ZimeTSUpDBwkq5eqoPwW+Sy4=;
        b=TYafCGnYL/KXogHJLkvcXm3NOyc4KE4KkR2QZ513U1WcBGTJsFVPVFqNXzU4iWNMEc
         lCTXxMJs869490o/wIGJbf9EaEGTBPAlSLzVELa+ipCNCswRw0WdOTNeRAKYq+iyfOb6
         t3X0oqwGoxFYhGMHzngc8AERibyBQ1G8V3seOWdZ28MlPuMDY+xZWzLpPqSPLVOyKAsh
         W2rnZyPDyANwOkC6E16dN+KRCAYh3IiaRJFVdVwgmGsmLL99mBMuq1Gc0thfhFnwvZpQ
         rX/BaoZkYALKSugMMOhmAi3qxMxItSZlubNWQ+ayiMum/1jBT+twJ5kFb9tPJuKgVGP0
         kdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755552165; x=1756156965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SV0SovoncvtQUIWdiz5ZimeTSUpDBwkq5eqoPwW+Sy4=;
        b=A5gMlTsJBvqt7PhQwxEHaegLm5pHbqgK16eKyxiXx1QJ+KzcFFAo4nvQFqXLzCMrut
         ouAY9zNP+dR+10zHM0wMu+x2I/a5giQUtWtjXVOjtK14geozAsFbg1VHCu6cnkUZWaBA
         4mtjxB4lmz96t/edosWd4AKUSdA5jWU6RkZsr8ukzTstHRFLQ2xjqBGbR+TSFSLVMNuZ
         +1wTOO0i/gQ5xA8OLivhWVqaXt5ITT5znRdhLjyJfyicqG8kmhYcPloEUnT3VCGs6RG8
         0LTpgSktwtkM1JAc9GoofSyHzDw9kccl0uq4k/4PMAOIqiNysG+Jx8g4dV1JPwTiTh4/
         7nOw==
X-Forwarded-Encrypted: i=1; AJvYcCWpKYuwhIki2UDiR+IIL2TDcJEe/Zry8aJW3YtR6kUn63c+4/4L9iswdLfi+bNcJIc7gS3PdJi3yBfEMSyhI/QIAZxWJo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoMSqGhupddPm/ycN+7C+BhGA0Zjf54E2DK7lY1vUjXCqA8H75
	pp6FhSv47biASa2yW0n6Trui4b+/25kZ2LF8LoM/xyTaoqActnR7n/O6OInzjUbRvYJK/F0V3nL
	egFIwE+DCHJxq7wgJErjHyVOpSluJeIBh1sNct216Kj8+p7Zh7OhKnQ==
X-Gm-Gg: ASbGncuv/wyfUSMBjKGDnRpqFdc6omv9FLANKoiFEwvUta4nWZEuCnGROFnZ94b1L3P
	KflQZMl5FuGoqXmZtzaTrn1+FjuU1Re8ch7vUuZqEgtIddQxbyYWCPP+2uW3IX6QCEBWxZVNhZD
	bJbPtSuGwPJhMj5VnhG+l+yojt6dn6Wkyz4s+grkmn4hPZh21hXcLzv+hCnKev1613ZDMljwiH7
	cb6VOQ=
X-Google-Smtp-Source: AGHT+IFrpf2SwebDg+GiltDgtPrrGLf0iUO2py4Zq3qOIraT9VCfP5Xv4Pr/eE1gzrWGIUk8h6MeQPTZ/yeBUsgJzAo=
X-Received: by 2002:a05:6a21:3282:b0:22b:3da9:fb33 with SMTP id
 adf61e73a8af0-2430d2fa39bmr98481637.12.1755552165437; Mon, 18 Aug 2025
 14:22:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816114409.10107-1-shankari.ak0208@gmail.com> <aKKdULYbLFRMS9qe@mail.hallyn.com>
In-Reply-To: <aKKdULYbLFRMS9qe@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 18 Aug 2025 17:22:33 -0400
X-Gm-Features: Ac12FXwqH4hs8Wu1pRkY76N_A0MiHuz9hahX6-bMGzQ9hZA7cdN0mZsOzdI8Fsc
Message-ID: <CAHC9VhRwpYx0jVybcAnGdm4AGDno-GwyCzZCS7U+56Fwu2tuCg@mail.gmail.com>
Subject: Re: [PATCH] rust: cred: update AlwaysRefCounted import to sync::aref
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Shankari Anand <shankari.ak0208@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2025 at 11:26=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com>=
 wrote:
> On Sat, Aug 16, 2025 at 05:14:09PM +0530, Shankari Anand wrote:
> > Update the import of `AlwaysRefCounted` in `cred.rs` to use `sync::aref=
`
> > instead of `types`.
>
> Thank you for forwarding, Miguel.
>
> As far as I can see from the included links, this looks good.
>
> > This is part of the ongoing effort to move `ARef` and
> > `AlwaysRefCounted` to the `sync` module for better modularity.
> >
> > Suggested-by: Benno Lossin <lossin@kernel.org>
> > Link: https://github.com/Rust-for-Linux/linux/issues/1173
> > Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
>
> Acked-by: Serge Hallyn <serge@hallyn.com>

As mentioned previously, I'm still not well versed in Rust so as long
as Serge is happy with it, I'm good with it too :)

I'm guessing it probably makes sense to include rust/kernel/cred.rs in
the creds MAINTAINERS section just as we did (or will do) with the LSM
Rust shim?

--=20
paul-moore.com
