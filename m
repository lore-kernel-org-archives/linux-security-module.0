Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2363DDDD4
	for <linux-security-module@vger.kernel.org>; Wed,  3 Jun 2026 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506343; cv=pass; b=cwqWDMPZbcLiCIOP8Q8Mttd5V03OVGB0aRo6viCAy6igLTrqdFOXXO2OP0aTFX/wtVcVCpqe9yvqlyi8seyWcsjNny2S9ATT18sXIi77TKOLDxhlJuadyhcZHRhtgBttNCQjp5sjOZ0yPlOln0BJrMPojCefoTC1Q5biQP6RpS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506343; c=relaxed/simple;
	bh=OIFhnEobWG3e0FwGwtUj3ntnAyj3+THBltmf4yuxkmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xf71wH6SWIGYoWxpT1lopzrAzbsZwxk9AR73U85e3AXwJIvuUDh0tTibiPbd4OUg7bhcgk4Dy9THbx50CtPbjqfbBvyDzyxxFCFVZKZzizvYeUfOp0rkOWXo+KtK5vI89SaBpDiMn1FoBjT4AwsyXoXsfTr0gXCZZPM1pqSBAi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kVC8Ys4p; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kVC8Ys4p"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45eec22fab7so3685586f8f.3
        for <linux-security-module@vger.kernel.org>; Wed, 03 Jun 2026 10:05:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780506340; cv=none;
        d=google.com; s=arc-20240605;
        b=JWSdZHECMKYs6h1n6mXtL/r7kGaB2SQvezqUB7+qtEhgbWX7PNAOaNcuQhp+TIbtnt
         hN+Z4gykrM28g0F0YvBozpYfhEsAjHujerpwz3vemWcay2QKDCTmbFSNnJ48dxrPf+rp
         rXwqH1SIANielDrYsQJVWcILnvPYJBKe4V6SXFcfAF1d9oAE3TjBg1K0VPME/DRGZ4rR
         nAYl/ZraOuSaqQahgZQvc1ZSGbCAYo5slEk/OKqT9CTQbyrx6KvmTTn/BdnNmLtkEEle
         FxS8siioNf+uxdN4guRrqOEq3HgyW/YgJPRdEr8KugVRFc4YrX5M2pQfj899BDlL2vv9
         Kg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=99P4LWdJbcDOrL41XNBsTy6LKaWjY+F5jM0t0IHW7Zo=;
        fh=7m2rMVz1RiayesdCCm3g0/D3fgzOWcMYoJO2aIMFatE=;
        b=dLpc7K4nvR0ieA1nvUgXKHBwgxBttHuhfOXHLOert/QquDuA6BZsVyY0+7or/LZhBm
         duGsm9idb6uGnJbtxRS4XnYoyEsDmL0ha45LanIdWcobCbzNbEYeAWP9GQt6M1fD7Nv+
         c9H3s8sKlHalbYcVDzSCngsMceG8FZcP6cYJyOGwjuXQaC7Znauc//A+A/nanfW4/PSF
         HKtqlTnJ70f1OYR4j3sUNWF4f/C6CDMfP3PXWRxKHyr/JtMcMBWzuIOtAQYu/j01hv+h
         lNDRUBwgGZo8TVel7oueeK2SEiCI3PC8Duc/u5enj248/4TbLym2rq+Uu1l5lq5jMK1N
         /cNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780506340; x=1781111140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99P4LWdJbcDOrL41XNBsTy6LKaWjY+F5jM0t0IHW7Zo=;
        b=kVC8Ys4pAwxEGhxkNwtJR/HxDxgr1AR/tcyYd0m9iE38HEDmFv8C8Mm0b6OZHSLHUN
         M80h517YCEmDFGMOriZi472k0vQos9vDTxcwHPUcFIpiThl8koty9ppMht1Qi0EQzMje
         0weykO51ZpMJ5HkaYDdefsQtIBee43c2tBnn4nyA0RN9+A2iN1yPjKjbt74mvzxDGvXw
         a7x0VhXfm+0/0WOWiDRRGzPzEQON905hp/g9F/4Cqn2DtrizPk5urL/GF2vIxXNPbh80
         QYlvROesl0toC0QSIxR4784bcLKRPrS2h0I2GGkpqqVXRMGrzOkaXD+Fwz92Rmm6pFQE
         nblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780506340; x=1781111140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=99P4LWdJbcDOrL41XNBsTy6LKaWjY+F5jM0t0IHW7Zo=;
        b=Q8B/goXtyFumXzblOZDan6v1ca/wirKjEA9CHGY11gX3wEUHtUb10PjfIYR9o4G1fk
         43OwlYUS4WtG0fxEwCMoh4kE+0U2nSDF1ilun4CrBzfYMFTWy7mZreGn7rpbMUeHQfLX
         owSnaFsvt72UeMnMis8ZQs1mUZiSqTCXEp+M7ihia/sWbF3lKg2A7B4KDEXkCvzLdRFz
         of75wtxlsP2LyIk/SpoMl/ePJYSeVQfJc/pHUIY8nHkB7wSvmbJKM7pXk2Wzw3NzCtoH
         6IeO5n6fmdrL2WK5NoxT/bm4kHzRc97U+/Wnn6kX2VE1mKUyE58gscnRxPypK/4dzBNS
         B6Bg==
X-Forwarded-Encrypted: i=1; AFNElJ99mTl4qRTdLwKIYxypWDToKZOQuCa3dnmtQ9HOSXOqnVKGXd2H+JliVZZI3A+JC7N7zN5sKK1E6kuW8pIGVQhIebJmbbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnXOt5Gjs4qaeTjWEZjRB4lAOueGMcbP2BSbEkkn1wMvsjpe2s
	iQsGWECcinRAVzVXeq3zG60yuUN1/q68o/cfQhMLOVilVQQ8ZU7+Eq2WZxREFRdUanK5P6KwScs
	3hClN6TFPkVPNLiEP3G5V5g1ZQy7xCujETnVn9T3W
X-Gm-Gg: Acq92OHjATdW8V/A2KKPDVjKmfRteefFGRi9DNp6KwVXK89ei1FcygTaqL8nMbcWErY
	xbtJ6eq0FUMz3bPM+fG0X1ciiL+0nPJ5ndJPoK1nikPwAM+Qy5xDWvIY4VmkL16ELH2Zp1vHrYA
	9SqLrgc39Ma/W3b0kpffPc3WMwSi2PnDe27YYtqLsBvEfta+X+t2SV42D69kxasYzNcwPAp97Sb
	opQm78YMrLjPmB2R9CBkfgFLN+BZB21eZ6zrEYo5LBMbZPydrfaZ5fT40Kl0kXr4Tci7vTGee2L
	d4LV1k29h3UcTLBdlo8lzGqnRSLCCMyK7Ct0b3B70b3tHw60W7LwiKAVs24=
X-Received: by 2002:a5d:5d0c:0:b0:45e:b99d:dad with SMTP id
 ffacd0b85a97d-46021872abamr6655166f8f.38.1780506340089; Wed, 03 Jun 2026
 10:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529-remove-task-euid-v4-0-07cbdf3af980@google.com>
 <CAHC9VhR5Ca+WyP2OiNGtL1SqHn0SwLe=M9SB8D2bxtdS52quhg@mail.gmail.com>
 <ah51DY5yfaNZejBd@google.com> <CAHC9VhQyNzxJgdMkmEsOeAQ7Wt2L+eW6aNLjeoYmnCQLmcYRnw@mail.gmail.com>
In-Reply-To: <CAHC9VhQyNzxJgdMkmEsOeAQ7Wt2L+eW6aNLjeoYmnCQLmcYRnw@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 3 Jun 2026 19:05:27 +0200
X-Gm-Features: AVHnY4IAFJzjseBdCskbFEe5vMc_zEyWRD54e3gHX3Gz-NxzZYa3Jh-vbKd5Q9c
Message-ID: <CAH5fLghJaFXheAZqKyM9Cdo6iqTw1W=haA79POhmZWEfuKujRA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Delete task_euid()
To: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jann Horn <jannh@google.com>, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 6:05=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Tue, Jun 2, 2026 at 2:15=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
> > On Mon, Jun 01, 2026 at 07:13:37PM -0400, Paul Moore wrote:
> > > On Fri, May 29, 2026 at 5:33=E2=80=AFAM Alice Ryhl <aliceryhl@google.=
com> wrote:
> > > >
> > > > The task_euid() method is a very weird method, and Binder was the o=
nly
> > > > user. As of commit 65b672152289 ("binder: use current_euid() for
> > > > transaction sender identity") Binder doesn't use task_euid() anymor=
e,
> > > > so we can delete this method.
> > >
> > > Given the problems from last time, it seems like it might be prudent
> > > to let the commit have some time to "breathe" in a proper release, I'=
d
> > > suggest merging this not for the upcoming v7.2 merge window but
> > > instead waiting for v7.3.
> >
> > Sure, that makes sense. I'll resend after the merge window.
>
> No need to resend if there are no changes (see below), it's in
> patchwork and I'm tracking it so you're all set.  I'll send another
> notice when I merge it.
>
> > > > My suggestion would be to merge this through the LSM tree.
> > >
> > > That's fine with me.  I'd also suggest updating the commit descriptio=
n
> > > in patch 1/2 to indicate that binder is no longer using task_euid();
> > > it currently reads like it is still being used.
> >
> > I guess this occurred because when patch 1 was written, it really *was*
> > still being used.
>
> Yeah, I understand the world has changed since patch 1/2 was written,
> which is okay, we just need to update the commit description ... which
> should be a trivial task.
>
> > Perhaps we could pick up only patch 1 now since even
> > if we run into problems and Binder has to go back to using task_euid(),
> > clarifying the docs is still useful.
>
> I assumed that was one of the reasons for splitting the changes across
> two patches (reverting patch 2/2 leaves patch 1/2 intact).
> Regardless, we're at -rc6 and with patch 1/2 being purely a comment
> update I don't see an urgent rush on this, especially considering that
> if I did pick it up now, it would be for the v7.2 merge window and the
> binder/current_euid() change will ship in v7.1.
>
> Let's update the commit description - you've got a couple of weeks to
> do that - and then we'll merge everything once the v7.2 merge window
> closes.

Sounds good, thanks!

Alice
