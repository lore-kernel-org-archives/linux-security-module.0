Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C09126BFE
	for <linux-security-module@vger.kernel.org>; Wed, 25 Sep 2024 11:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727262385; cv=none; b=KzFJPcdDTmQkecudwbr4C5D/eu8m76qZTI53bPybYihfJCbMfm2nMKmse+dae7nKDogQqVA2X5hYxSriVD/AQSq3UvjpoI/OE0EGWDijKtSkDaPaz0UNYoiyTqrzmyGvUtnzU0bPx9qsOWPQ3OT9y0eG1i1EbqkqXipw99y73+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727262385; c=relaxed/simple;
	bh=v9SOENpp+GEqMEfpbzjHUOzd9Uxz8a8eI7GUtlWQs+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkRvbvxAapCFnQJsKaELwHPrhgbDyqvY6DH4ouYwH2SPJ6Y8y/aYSlgOG/TafVlz0/rMHL/5DKuHoM/Fxvf4PMQDEBb/mGVRUcA+VSFjUjdmL69igOQW5p0mNMfe1f2yK0zHxyh6druOEIigkwQ3oIrnDhEyY2EiSCH2jP58aBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y0qoZkaG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y0qoZkaG"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so84336255e9.0
        for <linux-security-module@vger.kernel.org>; Wed, 25 Sep 2024 04:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727262382; x=1727867182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhQ4TPCHuI58LZ38MBixhcUn27fdFhOzEs54JQFmEu4=;
        b=Y0qoZkaGAi7LcUT3oJb4NisLSJU/jQJH27zodADr2z0dvPpCGPDg5u7nQ4RIsCYMak
         le/mIhlmqZ8X6+GmN3PP2QMCKp6vbmxzotaBm1Yuw0RXmtw32VA+G7yMyWtf4xmzAhKM
         UcGaIYxfzd8JowKxx+i3zJ6nNRBJXXxEklTgZMxjg+YgF1Z3ofeLDp/41kfNnENqDcCI
         luE4FdlQEo4BAdOUU66phuSQdN3pka/+v/NSGPGVtV4o41NqrBDjLgAdZqbjZXl89pIh
         tYk0Dth2KHO+fllaG9Qs7ETkDZAIAD0pLvwMM632vU9VIipk2b6BElfMGUO2065bcTEx
         X8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727262382; x=1727867182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhQ4TPCHuI58LZ38MBixhcUn27fdFhOzEs54JQFmEu4=;
        b=gRAYsWZD7qL4rYGfJWE6pGRFkkM46LNckJc85xKX9CfSa0W83Xf0646nx2OKHQ4aGg
         tIR50J62ZzNIZg5lQoF5r6LQ6j5Yx8ieeuHhr/I2TFHD993kx+AIaolwIo2d+4uRzr43
         bn5+W59BSHoLpxfvTonN06/5AmPBQ0/GByrIyoa0KAUsAHZpqyiqiKRMTmfmH7y2bOzx
         1X/JHQI2Vh+LcCRkEUGnOFgDSWwaGvcJMnw5qB0JckaugBG3vR92BEfZQpybsEvf2/hJ
         M2Uj2qxboipSwpzc1TTqO8DnPRsJ6YHl3ogqkLGH604fE7TzvvmfIPcjpBuACwkzf9iv
         YkBg==
X-Forwarded-Encrypted: i=1; AJvYcCWTTsQ2XB+BEIacNdb2UBGNGuo7geLk7O2lhYa0l9Ex0xPq715XosmdedBinu2lqYQUE1BxmvQWDWma+S1LqwIUaoPHE4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDw0Ew17k+yMIKEgw0xSh1wt62I75XJUlPmUN6UJXN8R+gX9pU
	qL5lxRLQEWwZ8QS+NigHo5QscgF7IUYJV2EteOaCSiCuStT/yrqSX10nBL0aRtZmaP/0UZG5XJr
	sC/mSZLEm6f3zDKsoWsYIzvNKQXWlFoE9ewbO
X-Google-Smtp-Source: AGHT+IGFAj+j04oaHOFqsP7FAM4DEPPjCdbCbDCCKy/XEfJz3JFRtsBnFMPeIPy5+2A+yRs/huLSjBw7dGu97fMWSko=
X-Received: by 2002:a5d:5d86:0:b0:37c:c51b:8d9c with SMTP id
 ffacd0b85a97d-37cc51b8ee6mr1224327f8f.38.1727262382323; Wed, 25 Sep 2024
 04:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
 <20240915-alice-file-v10-1-88484f7a3dcf@google.com> <20240924194540.GA636453@mail.hallyn.com>
In-Reply-To: <20240924194540.GA636453@mail.hallyn.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 25 Sep 2024 13:06:10 +0200
Message-ID: <CAH5fLgggtjNAAotBzwRQ4RYQ9+WDom0MRyYFMnQ+E5UXgOc3RQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/8] rust: types: add `NotThreadSafe`
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
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

On Tue, Sep 24, 2024 at 9:45=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
>
> On Sun, Sep 15, 2024 at 02:31:27PM +0000, Alice Ryhl wrote:
> > This introduces a new marker type for types that shouldn't be thread
> > safe. By adding a field of this type to a struct, it becomes non-Send
> > and non-Sync, which means that it cannot be accessed in any way from
> > threads other than the one it was created on.
> >
> > This is useful for APIs that require globals such as `current` to remai=
n
> > constant while the value exists.
> >
> > We update two existing users in the Kernel to use this helper:
> >
> >  * `Task::current()` - moving the return type of this value to a
> >    different thread would not be safe as you can no longer be guarantee=
d
> >    that the `current` pointer remains valid.
> >  * Lock guards. Mutexes and spinlocks should be unlocked on the same
> >    thread as where they were locked, so we enforce this using the Send
> >    trait.
>
> Hi,
>
> this sounds useful, however from kernel side when I think thread-safe,
> I think must not be used across a sleep.  Would something like ThreadLock=
ed
> or LockedToThread make sense?

Hmm, those names seem pretty similar to the current name to me?

Alice
