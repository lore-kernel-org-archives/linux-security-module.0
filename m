Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7600218D;
	Tue,  4 Mar 2025 00:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741046650; cv=none; b=t+GzSeRtYL1IcTJoXr504AELztPKzXq0Fl0Rhgkdzw+eIvEc4HV0DocPhrU7xr9/+b/hTVtZDbSqcw+8NKu09PRXa2TkNThGGYm32tQFZPx5Y9hMCFHgsvcdmLw5TU+MxARTflobsgJeYdOisx3cljaGsrW2K17gXOhBop2Zev4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741046650; c=relaxed/simple;
	bh=HXAKX2N9TbcSqNkQkYRPQn7lcR9MtlSeezsuxXMMk7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sD+KPvwkcZKckmeMzARsaVEhEzW1lDaK9rmPecugvlZGdLmuGXvIf5fAOZTQqEjm3G4qlsb/pV9k1zZ6CGY1TcHEjUZkgr/WWQYHb1vH930bsUfncYPKUZk40LYC+NuYnWveVe7WBbdobaSak/kp+AvwkxcprIhFUjLpPM2Amp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccMDZCAt; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccMDZCAt"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fd02536660so1129855a91.2;
        Mon, 03 Mar 2025 16:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741046648; x=1741651448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysR28s3u8CnmgoTuBfCN0R8kYhifvtml7/f8t3uhNZU=;
        b=ccMDZCAtVOaZf2Hig1n5VKge7TMlx4dtkdZJOLTwmiV5JqtGcA7QZtmfdOgeb6pAf2
         0i/yLHmNc64Kvm0E7v8w6snKq++tE6GFFhlmkjQpIwcgE+6n2N14ebE9gn8HyXw2ABhw
         63YSUyigPGIE6oSviCLcb2PphyP/gNtulB6xDJJQQK5lRaHrUNB+l7y4gTlVxuiRYbmI
         Pe7euiGNfyc7PVSZz26Fy63Bio0Y6nINb67OFlU/vrf6f0iGW5VWgWzj/18a5EqSDF4H
         wiNHRqrGtI8EoyCz86s8Dyy/z90kGvSdAejCmcjnLb0v6Q/NBf7BOnmk3G8zXTlW7Add
         tLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741046648; x=1741651448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysR28s3u8CnmgoTuBfCN0R8kYhifvtml7/f8t3uhNZU=;
        b=htbHOyg7TJxwsdhMchT5+N3XS+Oeoam89XzszEV3o+au7Nzp5sfiJgFnxZZh/QbXAg
         d/kDyuClYpIdGmcv4eUlFCVN1OEoEGr8fj1nLS1ONIUaUNCaNQXOwc9eyRoRh7OW6Ehp
         cs5v1UkQDWOgxixne723QPZNxIdM1KAf5PdWRO6BMrHf21TEzwrn36bZQm8tWHtZbOH9
         IBxAXB7n9KI4KUicj7MioP+vJEfpC0uwIeMr+/a6gwqMPXxV0jedC0OkRq4Ys4f5Rv9Z
         E5BAZpYdLtvTnx3x9WbDz+4m3glQgSvrzSceqQZIv7vuM7n4kfwi2lrajuail2fe9Xnz
         dhZA==
X-Forwarded-Encrypted: i=1; AJvYcCUWrtb2PmCrTMlgIx5ta6yUcC2gwErB90/5jfzSWrlx0D47gnXrZoAKnsP0K/YnYmLA7Jg10wMvWy6DuzDQPC6rQSrIR1OT@vger.kernel.org, AJvYcCUntojxTX5FhwH8x46h7mIjlpPoHlRkcUyoFa9ghtpMjdlvOrMh+kS0E60fOkvM4STHgQIYvRAbqCqTjt/6kZg=@vger.kernel.org, AJvYcCVQavgiTszOJuBD++sZ7LeTUejM8BV0KRuUkXesk1zeUZ4haXPrM1LQ1mY903uRpXG4uCfPvDbVe+rwyo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ztj1WeNLMPjq4w/tLLlsnAfLPDQSZp3Pc9LKT18RNp5pMSil
	omsIQpchGAqaHdKudYUHJRvPCbxu98xiBlGmHfAPWb4qTfyFH52fu94KNU72PJ7x2EgH0MOOKc6
	TB4NQSQzmyDsbERW7EstQKruimXo=
X-Gm-Gg: ASbGnctGrDAPRSWduKAgVclvUbdFVlKGcp6HILJxV9HwmklIKcE82uEOH6klj06DMzp
	Rzn+V4MXB/clvzkW/u4ZKRrU2BJyrAVXaYQyvgsyQhkdYvPzWRI+nD5377klIhAx+5p6NNDWmJk
	3Ztk6D8fbnB974lbv2dOGr9OOw1Q==
X-Google-Smtp-Source: AGHT+IFN+xbOu5QfcgaBgtNPAK4UHIFhRFNtYHlPW6b79kAWFeZjWU+GDc72m/R3caqAAOD/IZViYriJF/YR/9zZ/iQ=
X-Received: by 2002:a17:90b:3845:b0:2fe:8e19:bcd7 with SMTP id
 98e67ed59e1d1-2ff3534a3c9mr422621a91.5.1741046647649; Mon, 03 Mar 2025
 16:04:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-inline-securityctx-v1-1-fb7b9b641fdf@google.com> <CAHC9VhSo3aGsJVd=a3MTeakgU66oTN86oh5sZE8P4ghSk8Rx2g@mail.gmail.com>
In-Reply-To: <CAHC9VhSo3aGsJVd=a3MTeakgU66oTN86oh5sZE8P4ghSk8Rx2g@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 4 Mar 2025 01:03:54 +0100
X-Gm-Features: AQ5f1JoZtQM3Oja3NDT-Obx7yZMvaxx2kZbpcAlTwOsQb2zyvabJdICtBU9x160
Message-ID: <CANiq72=n_cGmrb6+6CH1AbGePy5dRMMFyzAFv6O1VEp8EgKR8w@mail.gmail.com>
Subject: Re: [PATCH] lsm: rust: mark SecurityCtx methods inline
To: Paul Moore <paul@paul-moore.com>
Cc: Alice Ryhl <aliceryhl@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Mon, Mar 3, 2025 at 11:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Beyond those nitpicks, this looks okay to me based on my *extremely*
> limited Rust knowledge.  With the minor requested changes in place,
> would you prefer me to take this via the LSM tree, or would you prefer
> it to go up to Linus via a more Rust-y tree?

In general, if a subsystem is willing to take Rust-related patches
through their tree, that is the ideal scenario! So please definitely
feel free to pick it up on your side (and thanks!); otherwise, I can
pick it up with your Acked-by.

Some days ago I wrote a summary of the usual discussion we have around
this (copy-pasting here for convenience):

    So far, what we have been doing is ask maintainers, first, if they
    would be willing take the patches themselves -- they are the experts
    of the subsystem, know what changes are incoming, etc. Some subsystems
    have done this (e.g. KUnit). That is ideal, because the goal is to
    scale and allows maintainers to be in full control.

    Of course, sometimes maintainers are not fully comfortable doing that,
    since they may not have the bandwidth, or the setup, or the Rust
    knowledge. In those cases, we typically ask if they would be willing
    to have a co-maintainer (i.e. in their entry, e.g. like locking did),
    or a sub-maintainer (i.e. in a new entry, e.g. like block did), that
    would take care of the bulk of the work from them.

    I think that is a nice middle-ground -- the advantage of doing it like
    that is that you get the benefits of knowing best what is going on
    without too much work (hopefully), and it may allow you to get more
    and more involved over time and confident on what is going on with the
    Rust callers, typical issues that appear, etc. Plus the sub-maintainer
    gets to learn more about the subsystem, its timelines, procedures,
    etc., which you may welcome (if you are looking for new people to get
    involved).

    I think that would be a nice middle-ground. As far as I understand,
    Andreas would be happy to commit to maintain the Rust side as a
    sub-maintainer (for instance). He would also need to make sure the
    tree builds properly with Rust enabled and so on. He already does
    something similar for Jens. Would that work for you?

    You could take the patches directly with his RoBs or Acked-bys, for
    instance. Or perhaps it makes more sense to take PRs from him (on the
    Rust code only, of course), to save you more work. Andreas does not
    send PRs to anyone yet, but I think it would be a good time for him to
    start learning how to apply patches himself etc.

    If not, then the last fallback would be putting it in the Rust tree as
    a sub-entry or similar.

    I hope that clarifies (and thanks whatever you decide!).

    https://lore.kernel.org/rust-for-linux/CANiq72mpYoig2Ro76K0E-sUtP31fW+0=
403zYWd6MumCgFKfTDQ@mail.gmail.com/

Cheers,
Miguel
