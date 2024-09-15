Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A011C9DD8
	for <linux-security-module@vger.kernel.org>; Sun, 15 Sep 2024 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726431226; cv=none; b=s/o420ieQhSpdLoQEn1rIhgcwmkILLwV4756OMvYURmwx4IjQ6h9Qu0HTR5VYA7FoLnTIHYM9xtgm3e0otapXFo5+WtZcOz7oGeUdJih4vUGYUisUD0OjO2QthT5yoTdRFXb2tMxx4EN6JqNt1jrKs9erD+qHZr87+Ez8SFD1ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726431226; c=relaxed/simple;
	bh=MA2dEU4Cj9Vvp8O7NJJBHTQ/BcK+V18Q1kl4ZrbjPCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJZNHpHOcKLtazg/VOArucjW3myWlgBuaIopkUomm9nBqkyOiFtKS2UPCs/M2qH7MB+PI/rjqiJn1Go9zWqF+KpF7LxnUWXy9B3p6DxnqlIjaniIdV5K8nVg88GAO7/H1636SMZT8ptkmUv6N3S7EdPPGUcW/5RXrmo9yiLf/S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RP1opSmr; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RP1opSmr"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-374c180d123so1423862f8f.3
        for <linux-security-module@vger.kernel.org>; Sun, 15 Sep 2024 13:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726431223; x=1727036023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaL7Gkk+gPCYuM4t7ZlEAAxfNQFXnQdZB2OVDXiBrdc=;
        b=RP1opSmrE/BGe8HRL+Aq2ojFO+bMUOYSLzXHwcaR5B8dczc9D4Ll5v6HnYSdF9udXq
         Ea3lkOqP/PY4GZplK4IcsQUqjjAU4puSH3d55kPA6OYHtUwwhDz1mXau7Q7SsH+xVrL/
         KjiS31LUusb3DQnMxcpKQZy2rBlSRvJ4ur1F6Fj+u30Pcw4XcqqikOsZtJop2QF1Nfj2
         ubP1/uqXeziCPLlr3fcC0eurRS1pwqO0VEYN7G+e8Qf2hHPPsHIABQlUlkGdbwZV0B17
         Tr+vfsxFllqJq1yMvnW3IetubwgOcytsqgz5QM3GdzswcjwHmS3blgyOsK3gPOKucQF5
         JjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726431223; x=1727036023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaL7Gkk+gPCYuM4t7ZlEAAxfNQFXnQdZB2OVDXiBrdc=;
        b=q1OgYU0oqUNNGsMdfTbx0yRyVZSKxQETyPIznCWCONRn7K7cb/i8XFyykhMpuIFo6p
         YiDd0Sl8KJSWPUcavK4HNGZ7CCB9nRmwk6K9JdgIte82DtwNY3yNg3gx/bkW/MDDlkyO
         c1OEbksFpf9lGz2t1bmA4Om5JdTQYNmQZE0s0MQ9va+NQzbtkcJPJj2maH7W6xlgT9Jf
         6wgG687CqeCXT3ypphxRIEDOqwJMQvAn6FpPVTPvEiodx9IrW9ne+f06HhTbdY8LlOSI
         plCNGnC0GbcLeS2pJKsb5/2CKh7uAfS//ZlrwksaEuQWwRP0Ure9o7tApTmUxzaI2fHY
         aDcg==
X-Forwarded-Encrypted: i=1; AJvYcCWBG4ZXw3eY97jNRzU9p5Y3+NFcc7K9tMYSuSFX1XjcpRrkcXm4l1RgwyVF2+7jFEtYT703WTilxtzkBqJrRwGxuRQZkpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzabxRJO0v3E3Cx8jzY4NlYTeTEFKIpwkSUxktFRm2PdMuYze9t
	3JfDQWCrXgNYRiHWqXoBvAomAMImqTh0HuMk+HtmyfFXQuiFbeDazOoepVJVjoUmOc9wVg5ZJJc
	P1Mcv7TlKQVDYc2agfO2J7/WEQYxvFq2vqm83
X-Google-Smtp-Source: AGHT+IHF5Nd4+g2TK9TPMccb6znX75Y4JOkziF6RFqJS/iI4O7pXri2hqXvJwr98kARtSwvHBogI6HK6y14XcnsCThw=
X-Received: by 2002:adf:f64c:0:b0:378:89d8:8220 with SMTP id
 ffacd0b85a97d-378d623b7dfmr5432456f8f.43.1726431222741; Sun, 15 Sep 2024
 13:13:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
 <20240915-alice-file-v10-6-88484f7a3dcf@google.com> <20240915183905.GI2825852@ZenIV>
In-Reply-To: <20240915183905.GI2825852@ZenIV>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sun, 15 Sep 2024 22:13:30 +0200
Message-ID: <CAH5fLghu1NAoj1hSUOD2ULz2XEed329OtHY+w2eAnFd5GrXOKQ@mail.gmail.com>
Subject: Re: [PATCH v10 6/8] rust: file: add `FileDescriptorReservation`
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 8:39=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Sun, Sep 15, 2024 at 02:31:32PM +0000, Alice Ryhl wrote:
>
> > +impl Drop for FileDescriptorReservation {
> > +    fn drop(&mut self) {
> > +        // SAFETY: By the type invariants of this type, `self.fd` was =
previously returned by
> > +        // `get_unused_fd_flags`. We have not yet used the fd, so it i=
s still valid, and `current`
> > +        // still refers to the same task, as this type cannot be moved=
 across task boundaries.
> > +        unsafe { bindings::put_unused_fd(self.fd) };
> > +    }
> > +}
>
> FWIW, it's a bit more delicate.  The real rules for API users are
>
>         1) anything you get from get_unused_fd_flags() (well, alloc_fd(),
> internally) must be passed either to put_unused_fd() or fd_install() befo=
re
> you return from syscall.  That should be done by the same thread and
> all calls of put_unused_fd() or fd_install() should be paired with
> some get_unused_fd_flags() in that manner (i.e. by the same thread,
> within the same syscall, etc.)

Ok, we have to use it before returning from the syscall. That's fine.

What happens if I call `get_unused_fd_flags`, and then never call
`put_unused_fd`? Assume that I don't try to use the fd in the future,
and that I just forgot to clean up after myself.

>         2) calling thread MUST NOT unshare descriptor table while it has
> any reserved descriptors.  I.e.
>         fd =3D get_unused_fd();
>         unshare_files();
>         fd_install(fd, file);
> is a bug.  Reservations are discarded by that.  Getting rid of that
> constraint would require tracking the sets of reserved descriptors
> separately for each thread that happens to share the descriptor table.
> Conceptually they *are* per-thread - the same thread that has done
> reservation must either discard it or use it.  However, it's easier to
> keep the "it's reserved by some thread" represented in descriptor table
> itself (bit set in ->open_fds bitmap, file reference in ->fd[] array is
> NULL) than try and keep track of who's reserved what.  The constraint is
> basically "all reservations can stay with the old copy", i.e. "caller has
> no reservations of its own to transfer into the new private copy it gets"=
.
>         It's not particularly onerous[*] and it simplifies things
> quite a bit.  However, if we are documenting thing, it needs to be
> put explicitly.  With respect to Rust, if you do e.g. binfmt-in-rust
> support it will immediately become an issue - begin_new_exec() is calling
> unshare_files(), so the example above can become an issue.
>
>         Internally (in fs/file.c, that is) we have additional safety
> rule - anything that might be given an arbitrary descriptor (e.g.
> do_dup2() destination can come directly from dup2(2) argument,
> file_close_fd_locked() victim can come directly from close(2) one,
> etc.) must leave reserved descriptors alone.  Not an issue API users
> need to watch out for, though.
>
> [*] unsharing the descriptor table is done by
>         + close_range(2), which has no reason to allocate any descriptors
> and is only called by userland.
>         + unshare(2), which has no reason to allocate any descriptors
> and is only called by userland.
>         + a place in early init that call ksys_unshare() while arranging
> the environment for /linuxrc from initrd image to be run.  Again, no
> reserved descriptors there.
>         + coredumping thread in the beginning of do_coredump().
> The caller is at the point of signal delivery, which means that it had
> already left whatever syscall it might have been in.  Which means
> that all reservations must have been undone by that point.
>         + execve() at the point of no return (in begin_new_exec()).
> That's the only place where violation of that constraint on some later
> changes is plausible.  That one needs to be watched out for.

Thanks for going through that. From a Rust perspective, it sounds
easiest to just declare that execve() is an unsafe operation, and that
one of the conditions for using it is that you don't hold any fd
reservations. Trying to encode this in the fd reservation logic seems
too onerous, and I'm guessing execve is not used particularly often
anyway.

Alice
