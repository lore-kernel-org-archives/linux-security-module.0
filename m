Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B1F209F5D
	for <linux-security-module@vger.kernel.org>; Tue,  4 Mar 2025 21:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741125457; cv=none; b=ry3akMNun8rokTEm8as6qJ5zV4mMzDCh53GAhd+nkBgTZ2zaBDTOm3qPULPVOaTfXfnc2N+W1tx743/idU78JoXLRfJab/c5AdDBZcTzi86U3kgmOAl5+Z0ryaXAoos5z3OEECcdIi7zDpgL2Lv8C1ye5fgLjxi3xzpOKusAB2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741125457; c=relaxed/simple;
	bh=KzrIAcArmLOe3V1Ys+bs9y+LLe/XSWtbLOyhy2D+VqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VyjI2U8azK8rpxcnPCsMi3YypoWAfHnt3nbjItni04Eb/8XFwWgR+6bKnajx/h4AfxIrIRYzwxNkMWhp80UMJYWWW/bkxMDner+CRLtpRMaT7ZvAgKeFtXZS6VNzu8DbM0oFuObF2mnomN4zJC3a0txseX9pF7my6jwXoHjWJMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bkaC8UBe; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bkaC8UBe"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e549be93d5eso6648875276.1
        for <linux-security-module@vger.kernel.org>; Tue, 04 Mar 2025 13:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741125455; x=1741730255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsnikvCe3hOdMVeN/xhtWmCodnyXPzUwaCFk12jXD3E=;
        b=bkaC8UBeyV+6iTNhL7uDElTcS3201kHiMWEc1FMXzAdwMNkWYZLkHnogppVerOK81m
         KLnoNDjYnE4rxQcyVsT/eXRXn/D9K9f2lviEodsQONjWgzj5v2JuxLYVVynRE4yEOEva
         oiuRX7Wjl/dQ1+2v3UY7aNVL7emIikrFe161NQ5pDaD+LQ3geLqH1pJEQPmmk3nLa9i3
         n3gS2N4e0zZr/hU1Z+dbHVEGxsPBoWusQCj0wHXIdcLVjtmmx4kDTdCQKYvUbhCYn9Gr
         vi7ron7PpGnarKkLs+AQxaMLnckOV+Fey+ahHq0LqKistGoO46PMeaI8rT3IRG1tqE/G
         lIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741125455; x=1741730255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsnikvCe3hOdMVeN/xhtWmCodnyXPzUwaCFk12jXD3E=;
        b=M9Otu2C4ZA3Fp9nTcPXFuzInqAex09/5kOy9G6K+yCs/VKECAGY8pFAfc6c6UvoaXy
         6Ob1YbzNQ9p+l9RuYqyadZQ0+qFyhT1Io0jJTneyKyZKLp44rNNBZ/n6e/72j1DFgxM4
         W6Ifeo7gnL3Tjr8Q0L4GeOQqV5G1KwONom5CJjcOfE0ZDLFhV7tawUs7N7XiS+BlwYGe
         G22Z2oR1rH4eXX0mCwxYoSVjVD2oPiMH6sRRCn7JuuxopdEfc8ZorsX+BeJJTL0xVJlF
         QdeqvJ86alsJm2sSVrGxGWhuPHndjDZNwCfv1bYZOzAdYtwJxOFV05W2awyPme1yydGH
         Fvug==
X-Forwarded-Encrypted: i=1; AJvYcCV7a6I0/EKRX9m4AQ79kp9QQU/CbEJyaygOgD0zHjTqOrNayTEHbiFYAK9ShXAmpc0Kms2yXGa/77KDgdPTM6cnh5HuaeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1T7sn8zn8Y9Ibu9WX3zlByqaN2ax1pLYpGRmWI7Hgak9qD+6Q
	S3EsAeHiIZpW3h/FajaWi6HpRfmBbkNOxQy+9lb5fxkQ7zym19cCDjN/CfDHdu2Lr2JurUawp1a
	+3OFu4Lz8Qs1QEBQ068ZjrnKJfZnPNq+UmvD2
X-Gm-Gg: ASbGncvhqu383vURuQInlwOxBltBZXdq4lVYA7oXd+K2A6Dx7EUE/NjyLTcjvBidqN8
	fej8ZARVko/89J4QgmYSTzrpqXRuvJoV5DEXe/9lAj5ad1AJVlCUPgmwlbPixUpCoLY8ECZ22Iz
	HxOWx7KedOLHgOkmr1LLAR/F/V1Q==
X-Google-Smtp-Source: AGHT+IHTuaql6CxX9+oW0vQt7zfON8FgK8oPO4Dgi10jT0f1C5KKKb1wciqXNbcYDDrBoPtRQrQnfcYSdkhYI8GxvnU=
X-Received: by 2002:a05:6902:100f:b0:e5d:ae04:1e33 with SMTP id
 3f1490d57ef6-e611e18dd27mr1373344276.5.1741125454946; Tue, 04 Mar 2025
 13:57:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-inline-securityctx-v1-1-fb7b9b641fdf@google.com>
 <CAHC9VhSo3aGsJVd=a3MTeakgU66oTN86oh5sZE8P4ghSk8Rx2g@mail.gmail.com> <CANiq72=n_cGmrb6+6CH1AbGePy5dRMMFyzAFv6O1VEp8EgKR8w@mail.gmail.com>
In-Reply-To: <CANiq72=n_cGmrb6+6CH1AbGePy5dRMMFyzAFv6O1VEp8EgKR8w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Mar 2025 16:57:24 -0500
X-Gm-Features: AQ5f1JonifUOcpqfOyjEvG2iJEgbZmlcgciRANX9bY2EJ9_XOLCe5zh-YKF7hu8
Message-ID: <CAHC9VhT3DqOeYbC+GCQRgH3NNUiOk6Sh=6fzsFaiHk2LEFbi2g@mail.gmail.com>
Subject: Re: [PATCH] lsm: rust: mark SecurityCtx methods inline
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 7:04=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Mon, Mar 3, 2025 at 11:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > Beyond those nitpicks, this looks okay to me based on my *extremely*
> > limited Rust knowledge.  With the minor requested changes in place,
> > would you prefer me to take this via the LSM tree, or would you prefer
> > it to go up to Linus via a more Rust-y tree?
>
> In general, if a subsystem is willing to take Rust-related patches
> through their tree, that is the ideal scenario! So please definitely
> feel free to pick it up on your side (and thanks!); otherwise, I can
> pick it up with your Acked-by.
>
> Some days ago I wrote a summary of the usual discussion we have around
> this (copy-pasting here for convenience) ...

Hi Miguel,

Thanks.  Yes, I've seen the summary and the recent threads around Rust
in the Linux kernel.  I don't want to drag all of that up here, but I
will simply say that from the perspective of the LSM framework we're
happy to work with the Rust devs to ensure that the LSM framework is
well supported with Rust bindings.  However, I will add that my own
Rust related efforts are going to be very limited as my understanding
of Rust is still frustratingly low; until that improves I'll be
reliant on others like Alice and you to submit patches for
discussion/acceptance when there are issues.  Thankfully that has
proven to work fairly well over the past few months and I would like
to see that continue.

As far as the mechanics of which tree to merge code, I'll probably
continue to ask in most cases simply so we are all clear on where the
patches will land and how they get up to Linus.  From my perspective
there is no harm in asking, and I *really* want to encourage
cross-subsystem communication as much as I can; I've been seeing an
increasing trend towards compartmentalization across subsystems and I
believe the best way to push back against that is to talk a bit more,
even if it is just a mundane "my tree or yours?".

--=20
paul-moore.com
