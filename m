Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6691918E0E
	for <linux-security-module@vger.kernel.org>; Wed, 27 Nov 2024 04:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732681052; cv=none; b=uxa3W8XtUY42mujrpE+SuxSk4svyX0fEh84jjyvTAFH/4B8uNh7h4mZczkAsa8H17ycirJVIm0nr1em8UTZjiwvRYEoduMrlTHBYqpo9tPF3uHQUJvzwLTbV1fWINifysCmM8nbD9bqjcq6Ha2bIN+oQk9RR7joCIr+dRAq2ooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732681052; c=relaxed/simple;
	bh=3XeU/4V/Sr4YWgBMd+JGTL2NUBHoyZBYkokHxbYNh0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eevpM1lkZNLilosEoSEu9D1Iw2sPQ6O//C6OQo6gGNEnUR4OsgP7Q2Y4ZSn1rqvtXsVQY/6442ot412XCAeWXnmeH5y5KePdmokZhYDuBqczq3mc6WIm+tpCvfFApiuQ3tTNxp5hFagd5YxK9HFvOL3V69q5YHSyMMWyxcu8cmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=G9fXHMvQ; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G9fXHMvQ"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e38c1ac8e3cso389891276.0
        for <linux-security-module@vger.kernel.org>; Tue, 26 Nov 2024 20:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1732681049; x=1733285849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hm7ENvoP6HhdoXpahiQX6CDXmuqD55Pzj7gK8dROaY0=;
        b=G9fXHMvQBnwDF8bAXx9CjgAeymt6tsUyLAj7a9yJuRWxTbOSF5SX2zLR2TbQf5Cvw1
         5SWEkvge7ppLKW6YXIbHBGRw+UXUywtiLn4meVjOtK14s77KUTUD6SIhAMGzZ3ncsGVy
         H832mrPtzv6YkHurVyaBghwUeC9cFhFj68RNKj3+fhXZebkdqH0stRTeli95t3KCGhtd
         9hmlEigwPRshcCzHDyHv56vtQdIa54ZJrXreFYREzbLro1cExU/U55gihpZ6cIpRn/HZ
         BO3DgamYCRTeA1IyKqk37GE1VXxImPZzrSX207IVjIzQudPMoRmRWxp1QozKFgAQ4e6L
         1PDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732681049; x=1733285849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hm7ENvoP6HhdoXpahiQX6CDXmuqD55Pzj7gK8dROaY0=;
        b=XiA63zt98M0+Py1TjEnY0Z9Rn9JBSPw7XbN0LbUqMHgChyu8AlB9QEpwhE+pBAPqC3
         ThHkp02wCZR9Gt+Kd0ymUvvXsgSWDU/DeJXMkKy8wvYihBM2lDJu4BY5iEQGN3daw40g
         3K5QByqGCVPsrMJAWH4KwOSlWfnVUXlD+FHz04tGRfOV/vS+WRxZItULqWslIHB5thM2
         TFsqaXFIfg5Tyf/Pro+g2EvzHt5l7lnAGf6l1UPM2ibIFPYoY5DTu8isglIck50Qg8gj
         5Liki3/scfxql01P2hyXW0rSe/DsL9t1WEg8DkdPaVDH3xfaIRTCBht6+ESp/3HmRVlK
         7nWw==
X-Forwarded-Encrypted: i=1; AJvYcCUw6mwWIYZ+51GJxP/RO8xkkAK7GyuVj4HtatutClcF7M/U+rtytDYPhgWIIqUQaj+mi4V24k3g4bqLEA1vLK5gDEGRaMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnJMUCEWVDdgQJFoDZ+h8HAftKhRXvO6/naCrB1USNbbmWZOgQ
	236zQWEvRPGw02HEVpEkLEivL6lDDY7iXnlmq7bYhRBsJt6rAd9amclgNbmR74ezzwgVjOfB8zc
	PjWdEtjsdsZ47RgYFO0zpI1Kt6rYGP2M6/hfT
X-Gm-Gg: ASbGncsZ36rBggTENzxYGJr+1elZzR3Te24IiE5ix8upRvu34rjpjwb9j8aAc7HD+5O
	/PxT071E4sxHYYB04hmz+eUSNLwTXeg==
X-Google-Smtp-Source: AGHT+IGXltr9ckprSIGJ0zk8EcAJ0ecH4ajUfDHmT84fEIG+PhA0s/gKfL7agqnI0QojZ8X6EzqtwtUPYNqjUQ4yOIw=
X-Received: by 2002:a05:6902:1505:b0:e2b:b9bf:f248 with SMTP id
 3f1490d57ef6-e395af39d32mr1792887276.24.1732681049420; Tue, 26 Nov 2024
 20:17:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYv_Y2tzs+uYhMGtfUK9dSYV2mFr6WyKEzJazDsdk9o5zw@mail.gmail.com>
 <20241101095620.2526421-1-aliceryhl@google.com> <CAHC9VhS5wLQeF4LX67UgUYVG3oViA7CmSZS_kugH+M5J0XS2Vg@mail.gmail.com>
 <CAHC9VhTKzXPja5mLHmqOoTiDm1K8k=vtK+x9Hfa6t-7hpMmwag@mail.gmail.com>
In-Reply-To: <CAHC9VhTKzXPja5mLHmqOoTiDm1K8k=vtK+x9Hfa6t-7hpMmwag@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 26 Nov 2024 23:17:18 -0500
Message-ID: <CAHC9VhS=gqq6JuXsvzhsX2qEbDyxsvU_5cmx5dZF17kfb_bpsQ@mail.gmail.com>
Subject: Re: [PATCH] rust: lsm: replace context+len with lsm_context
To: Alice Ryhl <aliceryhl@google.com>
Cc: naresh.kamboju@linaro.org, casey@schaufler-ca.com, 
	anders.roxell@linaro.org, arnd@arndb.de, brauner@kernel.org, 
	dan.carpenter@linaro.org, kees@kernel.org, linux-kernel@vger.kernel.org, 
	lkft-triage@lists.linaro.org, ojeda@kernel.org, regressions@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	lkft@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 1:02=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Fri, Nov 1, 2024 at 12:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Fri, Nov 1, 2024 at 5:56=E2=80=AFAM Alice Ryhl <aliceryhl@google.com=
> wrote:
> > >
> > > This brings the Rust SecurityCtx abstraction [1] up to date with the =
new
> > > API where context+len is replaced with an lsm_context [2] struct.
> > >
> > > Link: https://lore.kernel.org/r/20240915-alice-file-v10-5-88484f7a3dc=
f@google.com [1]
> > > Link: https://lore.kernel.org/r/20241023212158.18718-3-casey@schaufle=
r-ca.com [2]
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > Closes: https://lore.kernel.org/r/CA+G9fYv_Y2tzs+uYhMGtfUK9dSYV2mFr6W=
yKEzJazDsdk9o5zw@mail.gmail.com
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > ---
> > >  rust/helpers/security.c |  8 ++++----
> > >  rust/kernel/security.rs | 38 +++++++++++++++++---------------------
> > >  2 files changed, 21 insertions(+), 25 deletions(-)
> >
> > Thanks Alice.  Would you like me to pull this in via the LSM tree with
> > the associated LSM changes, or would you prefer to do this some other
> > way?
> >
> > I'm going to merge this into lsm/dev for now so that we fix the issue
> > in linux-next, but I'm happy to drop it or do something else, let me
> > know.
>
> Nevermind, no I'm not, as I don't have the LSM/security rust helpers
> in the LSM tree as it looks like those aren't in Linus' tree yet.

With all of the dependencies now in Linus' tree, I'm going to merge
this into lsm/dev-staging so we can get some crude testing done.
Thanks again :)

--=20
paul-moore.com
