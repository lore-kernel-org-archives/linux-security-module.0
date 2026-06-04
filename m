Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4240A334C39
	for <linux-security-module@vger.kernel.org>; Thu,  4 Jun 2026 23:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780615148; cv=none; b=JuqTH//fsD21LX6oq6MTLBM2AW4L85zhNxr3d8a6Gtcp/W8rOE5/q2gCZJnFeZB2OJMLgDN1BfcZK+zTIsvCHElAHOuztlN/T0YRcpXUDRmEEzjyMQvRIp91C6ySXxyM6y9WiSvnpkfB1zrga2swbN01Aq+yVZT1/kiwvd7OKFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780615148; c=relaxed/simple;
	bh=e+wiQFodefn4hcPnRr+g1nn8jYvYfVdxnZZL8PqQPNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PsEtY0sY14odgVuIgNIZAeV70+os59jFfaw1QaaTJq/0hW1ww67y8kk2FT0JiKewlzSyg8P7WkjTWh1zKVI+o+QwDDPChC/Wf3MdvwelarlztmDcIkxbGGHkpEcv5a+CcVjMOhuF0BKIQYfQ63FOhcB/nCFJ2CyFWCXJUSLmMl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ATUITxFo; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ATUITxFo"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-beb7f26ed62so140730666b.0
        for <linux-security-module@vger.kernel.org>; Thu, 04 Jun 2026 16:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780615145; x=1781219945; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1t03YMole+ly6+fJzmqkdJokSNqVZigB4RGvlZCSlLc=;
        b=ATUITxFogD8HCV2O7l4LS+CCO4NC4YeesW/jNwP3qANKIrNJO1Es50W0a+jEuncpNY
         gVkhQ0oevCrsP+lvVYB75iVEqb5J5Raugr9WHWoQNaRRxgR7bcCNNflWsmapzR6+d05h
         uvaSAyHq+/80VHG25Kiu4MjEDm+Mbr10hPPT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780615145; x=1781219945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1t03YMole+ly6+fJzmqkdJokSNqVZigB4RGvlZCSlLc=;
        b=b8lHvJ2Bn+nUnWzk1Jo5qMIPFBr2JtUPpOYafM7BGrs1RH/wLPlWOZ0BZFp7joG1ou
         M5xY3C3FOFToPIM+Ay+vOmltKqZtYfJsoqF1204QZ57WNuu8r1EuRJcTuFp4Krd0l9+1
         tweq+C+Ofdkp1DYwOqmDHvugmvYgURIFs/3Lx9SduBgD4lhyOfrD+D1GfRJ3VlF46/3+
         eLQv40hluqN/1uVKQPlK2lnwPlVcRsp+zq/5xSSqS92J/XkpK/lXvTepLpu7ecdbMOBz
         AlziaMhcQAgdoM91dlDh6wMLTWiO6dfuZk4iaygDkdnQno06pAxcvKrvbvv5zWGP2O0s
         enAw==
X-Gm-Message-State: AOJu0YzHOL0eXkQTR+2AAP5nlEZ7VpQYJ/3HOkj9ZtwdA9QM8M7+/ShF
	qbBkHnwxD7+ouqNTHz2QDSUC7/8XJ0TYfB0QoeWkSEWKntB6ADQLe8Dzp9B6RrrW05MCXoylscz
	LY27gpzRDcg==
X-Gm-Gg: Acq92OFfUzGY9Zlf8kTKF+2fBHLuay4vVZec7fx3C5m3BZ7qRxgqZJhS5kpggdnwV6f
	hUbYnYOF3smLSDR4xrgTTFXcDePLGbP1vjT0pAsfrs/SelvGvsGzQdRY6RuDw5tCJWWvPjUTuD/
	cJ3p1zj9dUBhXlYStph+YF+KqnnAtanqnyHA9vSTzjZQdTiOWabJ9QrXyFtTLDTVuwlRaRYDBue
	Bk3ncz6tzIR4aFXncMStEhEBmuN2Yjwp89hifi3sqvFCj95H1IN6CtPb0LNpCiTM1REAVldNa5x
	rLzM0RmS35uMYcmj/BSck5v3rnXCHDfqtNBRzCyGJN1Mp7YwvlLkjZRuIcH+TSmUCmFM1w4Dfil
	kCF5AX3zU/o5mEhkolZ7M/nKG673jxkK26fgjz74Psu3on/v9AM8cu0CiMGi9BHDuz3OAqbucaj
	VCBjxorBi0Si9U5j62H4zQBpdVIm3/HaEKYU2Rnftr1jbsbV6Dlq24hDQrtJFPqhHVYUr+LbSWp
	WNLc2SL5OoIMmZAn0SMkw==
X-Received: by 2002:a17:907:a315:b0:bec:ab0c:2442 with SMTP id a640c23a62f3a-bf36fd9c7e8mr36405066b.2.1780615144586;
        Thu, 04 Jun 2026 16:19:04 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051b8c7efsm363072766b.14.2026.06.04.16.19.03
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 16:19:03 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68d23396ed3so2302730a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 04 Jun 2026 16:19:03 -0700 (PDT)
X-Received: by 2002:a05:6402:40d2:b0:68b:5e48:750f with SMTP id
 4fb4d7f45d1cf-68fa525ad77mr439899a12.25.1780615143537; Thu, 04 Jun 2026
 16:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <83f77b2b-8c00-424d-b6f9-b044e7ea1ee7@sirena.org.uk>
 <CAHk-=wj6CtZS9hbwFjQcoNkPwQLoyKmk8czaBF6=bBOCYuXEUQ@mail.gmail.com>
 <CAHC9VhRX1=tx4+arzuH76kirYFFJozexa5L=41Bb2QbgWZXOkQ@mail.gmail.com>
 <CAHk-=wj_rtiufEEVudMCSbh86HYrnmEa9NhYfKeWHs1SOzJVnA@mail.gmail.com> <CAHC9VhRXW_kyWXgYBqW3K-jSr5yN9wp1EPos1c=BFmiebxLiUQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRXW_kyWXgYBqW3K-jSr5yN9wp1EPos1c=BFmiebxLiUQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jun 2026 16:18:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wij4nkMRcshzEGsxvjwP2RBQyaiQ4-vQrYTOqvQusxu9g@mail.gmail.com>
X-Gm-Features: AVVi8CcZbp6oblGDP2dwW15N5QHkOyIDDcZIe3k_o9LsAC_bkAWxdIwmjPOUXmo
Message-ID: <CAHk-=wij4nkMRcshzEGsxvjwP2RBQyaiQ4-vQrYTOqvQusxu9g@mail.gmail.com>
Subject: Re: -next status as at v7.1-rc6
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, linux-next@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jun 2026 at 15:23, Paul Moore <paul@paul-moore.com> wrote:
>
> While you didn't reply to any of my comments explaining how Hornet
> works, specifically how it ties into the kernel, I'm assuming you've
> read the overview.  Can you help those of us in the LSM space
> understand why a BPF dev's NACK on code that lives strictly under
> security/ is sufficient grounds to reject an LSM patch?

Honestly, I'm not competent to make a judgment call between two
different models for hash chain verification, so I basically *have* to
go by maintainer opinions.

And the discussions I have been cc'd on have not been what I'd call
enlightening.

But people have pointed out that the LSM code mucks around with bpf
internals, and those NAK's have had reasons for them.

And honestly, I don't understand *why* Hornet does what it does - and
does it in ways that obviously annoy the bpf people. There is no
*reason* to look at the bpf maps that I can see, and from my
understanding of Alexei's arguments (which may be lacking), the fact
that Hornet does that is the main reason for the NAK.

But instead of working with the bpf people on coming up with some
model that does *not* do that, it all seems to have become a "we'll do
it anyway, despite maintainer complaints".

And I *did* see the bpf people pointing to "this would be an
acceptable alternative" with KP Singh outlining something that *had*
been discussed.

But I never actually saw anybody say "ok, we'll try that instead".

Maybe I missed it.

But from what I saw, it really looked like "I see NAK's from three
different bpf maintainers, with suggested alternate approaches". None
of which resulted in anything that looked like "ok, we'll try to
follow your guidance", only more of the same.

Why would *my* input then make any difference?

The bpf people's arguments resonated more with me. For example, the
whole "we need to know if it passed the bpf signature" seems to be
complate pointless silliness, and the bpf peoples responses to that
resonated with me. There's *no* point in any LSM check whether the
signature passed or not, since if it didn't pass, it's not getting
loaded.

So that's basically where I stand - I've seen disagreement, and I've
seen what looks to me like reasonable push-back, and I've not really
seen the LSM response as taking it into account.

           Linus
