Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4608738F647
	for <linux-security-module@vger.kernel.org>; Tue, 31 Mar 2026 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774994712; cv=pass; b=DGgzFOp1M07ivvhKlSq3tS1MQXB9EsjINvttRvlGPJsUdnZSIIgI0cgPpeIXhntCMoFHKtmiOC6Y7dlv0E8fa7S7gkX7zRmVoX15XWtF8Y9uJSCq+JDmOm+OY+2Sdvgb98v6YBYwsDdd0OFgxxrfl8nTCo4oJDydJAqiNTuvFBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774994712; c=relaxed/simple;
	bh=aVIpPJDxtVjGTfUw8kQm/EJ+Xr7PeRLNbyuFyTTwN3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJU7HWdOovKc3dE8e8OgXu4h821ANR+BPSH8FxTGx2acjb+fnL2xYH53Ayp/v18wg9u0Z3HEhzRhESWnkivMyz1nN0ljEw5FEDccx3rLJAFRNOdXCk89/Cm45epajessOWOkpBQCxihCu5UQSKuRXnWrlRllIvDw3TnLFDNNZV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cK700kJE; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cK700kJE"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso3053883a91.3
        for <linux-security-module@vger.kernel.org>; Tue, 31 Mar 2026 15:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774994710; cv=none;
        d=google.com; s=arc-20240605;
        b=kzgX/+pKEvrcBt2UXRqEDOAIpK80AZN26TsxfPNCcA2BVS7Lm/uZU/e6WvgaA+d2nI
         T46kTdPJPoQg20b/aAioplB62wK0Uc3v5LS4FoAGA6y78otmOLZgJMlKI9RsWWzbuJug
         7k3kVCJPDRH/YKveEWXCJvtr6ng7uGJVVXqZvPew6Dov/0vj6DC7yExZmDzCfflPDTgD
         Jg/jhYAc2RlJdvKWeAIQrZvvonlt2/tVQB2PXwB0yhTgQVQxUyOCVZ7HW69hqYhsP2d/
         RWHYswXt0gJW/oA+vdWZ5aKAGwVresg8nFK/NDvA2dPWVIHSOeen9Z/nFflQN7kKr/or
         mmXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ep4GCTgxX8JIYhXvMhkjfxUN+0Y0dj6DzLbtLvfj93U=;
        fh=cEe7K2t0Q03/VCqdlwTmhEzp+sRQxTIO1LR6UMkG1Ic=;
        b=hWT6EPVJux1APeMuox8AnOmEG6Mf+zR4oe/9IfBcN3ie316ZcIdqQAB6heRNesR9+j
         JBTqPc8CBtdDa9+YgUZCbLuFfnM34lPuhSw9cJ8NA9YHMfpqEtKC1znaFdN8bnFLqyIL
         HWCYmXgGrQTKShkTRa/sgMuUUc/6yfDOHFKhHSNHqLExKHeSrE44edTxttyYqxldNupw
         jAPetGRng99w9v7ArwoZMFA6rNjP6uX6TK2xPgyvKY66fUbpd/r4mpCONUNBWCf8whhN
         +/KbEQCiL4iyWADWm113f03RHjKO9w596C58L21gD8GJ/kp5C8AY/NUndrbBLmERFYWA
         wvHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774994710; x=1775599510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ep4GCTgxX8JIYhXvMhkjfxUN+0Y0dj6DzLbtLvfj93U=;
        b=cK700kJErZ3XTR83YmrvrOIJGcQRkoNv5CKJH03tF81ANmsX/hERPsaUZd/aKmgsDL
         pXZhznvHmYvHhAVhXorUiZMVGhSlfyWwn1eKv0qm3GNal9RN5hdxQaRNL4JUp3QK3/In
         drPXv3+7h46+XLrbBuy9lMF1nivoEDVg2fKoOD3fjeIHVeNkC6eWlsSJDyotKhU8fh81
         YubMJa0ZRLHhSe87QBGXDQcJO0CMIAp5THH7AYNeAoAD8Yd4hvh+d1BGUdD+hVkZOW6D
         Zhd9DR3VXp3FClSrgOLhDXovflqcNSQyCLZ1/uao7PC1B/EdMq4WMC7hShMWZ9bBG4+s
         yvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774994710; x=1775599510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ep4GCTgxX8JIYhXvMhkjfxUN+0Y0dj6DzLbtLvfj93U=;
        b=RGtpLoayH9ICseqSSjp9AbSGm+5Zahe/T/3Ovje5Wm426QqYkImkxnNfvlQVKAN7Ai
         5/B999qPJej9Mp5oH5WmbD3P39f8D9iaBGc2aoSEhciFfDo9M9HpEPlszRtnGHwQsVaD
         K4fxm5EnxI7WUnBOcgIR0Ka5x8EtbgdocNg3WPbJT26c1wF9woubEKqhSVEJBZ78lWq+
         1+0M3crE1I4Hp/UnF8CoY6qQJfLLWWG/4pbIB9AOR0gZFFl4fUyBrYvQzen2/0QVyzf7
         5rpzw8SLVDUQuWHgWAF4m8rNDh5jAd9szKlUg2vGxu3c/5iiorBbCAodZT6kEf/LFzgo
         OqpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgktO3qaR3rb0Uvkd6sl/OxWrcecUrD9HtZ7uUDLLSFEE0wxij7TEgUDb9t/WUWlIC5OBxr5D+jhz+Kx3BqPYTh44capI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY9r58sO2v2KFIEXnwm6/aY2ITotu7uufc6rFPKUeRSSep4Wgi
	9e0OMzA8Jlhu5CJhuteGHyGBQL1Mnjq1B1M76gAYWaJFLcsOdLdRIQX68xn4gp6pMhXRPOg1JZx
	UmBKWclMXenBkl25SkXoQT9A2wTIw41k8RnrVbIbL
X-Gm-Gg: ATEYQzwwPvuUad4tmq6CGEOqaUuD0xOLMJkCkNFtdMJbwKnH4P9sW6qIKQkmkcyWDnz
	c0HawDgOipy79WUNIH9/QODh6CjptX3yDwheMncPLXel/syRngkyO8ur7hCtasMVEVrfF48gMvp
	mBwrs3Fb6fIVfrz6+cDLjxNd/aK1kyEqxcsEnAg3QIeYpnwQZ3NeUkqBMt/XcltoFaAUboiop5r
	m311Aj5TSa+a7g+u42HceuoFGbriBF2CjuFQ77mlh8pcGdp+RRvXDhwdPuDvzXSjRjUzfKPavp+
	QR9s5T4=
X-Received: by 2002:a17:90b:3e4e:b0:35b:a170:f266 with SMTP id
 98e67ed59e1d1-35dc6e6d5d9mr852192a91.13.1774994710597; Tue, 31 Mar 2026
 15:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326060655.2550595-1-bboscaccy@linux.microsoft.com>
 <20260326060655.2550595-5-bboscaccy@linux.microsoft.com> <CAPhsuW6P-K=nTPxBk0_Wd0E1wDCBqb=uUQzmzpEg2NJub=L+dg@mail.gmail.com>
 <871ph5f99z.fsf@microsoft.com> <CAPhsuW6fWG8674+LOAACqb1LDAz17w-CxvwBaTf7JXQL6ip5Pg@mail.gmail.com>
In-Reply-To: <CAPhsuW6fWG8674+LOAACqb1LDAz17w-CxvwBaTf7JXQL6ip5Pg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 31 Mar 2026 18:04:59 -0400
X-Gm-Features: AQROBzCUIiXEj4VIIcZZGbFprLIdepai1hqVM7-_X8-rSxluuSgqIzTNSpqHed0
Message-ID: <CAHC9VhSeRuQ0t+bU29o2z1xeC+g+6h9e+RWnfEKqpzT7rv2Vcg@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] lsm: framework for BPF integrity verification
To: Song Liu <song@kernel.org>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andrew Morton <akpm@linux-foundation.org>, 
	James.Bottomley@hansenpartnership.com, dhowells@redhat.com, 
	Fan Wu <wufan@kernel.org>, Ryan Foster <foster.ryan.r@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-security-module@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 2:25=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Fri, Mar 27, 2026 at 10:54=E2=80=AFAM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
> >
> > Song Liu <song@kernel.org> writes:
> >
> > > On Wed, Mar 25, 2026 at 11:07=E2=80=AFPM Blaise Boscaccy
> > > <bboscaccy@linux.microsoft.com> wrote:
> > > [...]
> > >> The first new callback, bpf_prog_load_integrity(), located within th=
e
> > >> security_bpf_prog_load() hook, is necessary to ensure that the integ=
rity
> > >> verification callbacks are executed before any of the existing LSMs
> > >> are executed via the bpf_prog_load() callback.  Reusing the existing
> > >> bpf_prog_load() callback for integrity verification could result in =
LSMs
> > >> not having access to the integrity verification results when asked t=
o
> > >> authorize the BPF program load in the bpf_prog_load() callback.
> > >>
> > >> The new LSM hook, security_bpf_prog_load_post_integrity(), is intend=
ed
> > >> to be called from within LSMs performing BPF program integrity
> > >> verification.  It is used to report the verdict of the integrity
> > >> verification to other LSMs enforcing access control policy on BPF
> > >> program loads.  LSMs enforcing such access controls should register =
a
> > >> bpf_prog_load_post_integrity() callback to receive integrity verdict=
s.
> > >
> > > bpf_prog_load_post_integrity() is weird. Some questions about it:
> > >
> > > 1. Is it possible to call it from other LSMs (not hornet)? Specifical=
ly, is it
> > >    possible to call it from BPF LSM?
> >
> > There is nothing hornet exclusive about that security hook. If the BPF
> > LSM folks wanted to use it they would probably need to implement a
> > kfunc to invoke it.
>
> Please also include the kfunc in v4.

Blaise is welcome to provide a kfunc for
bpf_prog_load_post_integrity(), but I don't see that as a requirement
for Hornet's acceptance.  If a developer wanted to write a service
LSM, like Hornet, in BPF to verify a BPF program's integrity, that
developer would be responsible for implementing the kfunc.  If you are
interested in doing that, I suggest you talk with KP as he is the BPF
LSM maintainer and I suspect he may have some concerns around
supporting that (see prior discussions around BPF signature
verification and his own implementation of BPF signature
verification).

As a reminder, if you want to apply security policy to a BPF program
load operation without considering the program's integrity or
provenance, you can do that today with the
security_bpf_prog_load()/bpf_prog_load hook/callback combination.

However, as you pointed out, we ultimately need to see at least one
LSM providing a callback for the bpf_prog_load_post_integrity
callback.  I wrote a toy SELinux implementation when I was playing
with Hornet a couple of revisions ago, which could serve as the basis
for a proper patch if needed, but my understanding is that Blaise has
been working with Fan on an IPE implementation.

--=20
paul-moore.com
