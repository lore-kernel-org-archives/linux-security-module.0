Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9AF26CE32
	for <linux-security-module@vger.kernel.org>; Tue, 19 May 2026 05:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779168564; cv=none; b=mk5k5ocljFO1CXvoTewUgGNNVTaBX4nEkpxPndmSqYBN4FK7w3iRk6995cRjn3Dj4pwprWl8UPCJR6lExluLrbTO7eseQarFpdPdIV53cNngYo/6oZs3ykFIjPxrfj7nSvJEjF0uzBrVU4YIyRqyJUprlKbJshfe6yG1bTPBJNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779168564; c=relaxed/simple;
	bh=lkuBTO3YZPdx1wJngOh0Wh056PFEMNOF88jASYdooG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7fYrTh1f+noC620TK+oNlyScaygY5KHHRKYriIrtgEYD/CP1FbzyUEyDexRmevrcySyYNZOxWSU8K+Xbn+P1ASkq4iiuQSQwqx9v0DuLR6wZyN1mBERNddfr8F3aVfbDC/CTO3SM05kN4U1lQrYicTY5/qb9Vkl9UbxRgMT23c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ij0vOqod; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ij0vOqod"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEBDC2BCC9
	for <linux-security-module@vger.kernel.org>; Tue, 19 May 2026 05:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779168564;
	bh=lkuBTO3YZPdx1wJngOh0Wh056PFEMNOF88jASYdooG4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ij0vOqodupvYNgrvgcZib5DNmG6Vn/OSEfy6Pe666b6VFfWAuN9vNMl3OcITCtFjA
	 +mjifYrwiPbPw8MrGsI/bemUGlpVpDwIaAUl0AqokGwh6s+wHexIafHGVXUiv4ysMa
	 Vk+8tooJSC1yI4vZx5TFtPwaxEv57+uz9jVseQA7aCSHbTWxb04Mw9+ZaunSBTR2xK
	 nKrucYO8nwIvaHJFRPlbTupRiNhF38QVDRFZhdjdIRH1npN/KpJ8wnfDzi124n0juE
	 Zftm8Y65FygCOgOaQgKDlpT9oYOQxWB6tNuHxZzy8NlHkP/HvrNB5rLUFNXdFryaJq
	 BSJdvBSnDzAZQ==
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8c9166b26b4so40682466d6.0
        for <linux-security-module@vger.kernel.org>; Mon, 18 May 2026 22:29:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/0CACBrEvTR0pMGeTnyRr4QBrKZf6tfMzpylK8ChKaPc5Hyh7J90kfRLYICWduATSoGV0fSvMqxZ28pUDhTL4B8CicxNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlF0uRFWdNpIPqYHmPpCbC3gvVp7AEjkx0hxXS9G1Rnn5oPii0
	2TKwxoR3bjflawqeXcDlGaiDX2VySCly23Tr4wBPPnyS1EBkcvbgdGBk7bF/tgPbxAwr/jybkA5
	liYFGcubqU9SZQWzJZZUpJXFaLqSzdh8=
X-Received: by 2002:a05:6214:2e46:b0:8ba:ad10:97b with SMTP id
 6a1803df08f44-8ca0fc06e26mr306508916d6.41.1779168563238; Mon, 18 May 2026
 22:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507070547.2268452-1-sashal@kernel.org> <CAHC9VhTwDt2Bx8n0io9Qge_fUEnrHsxrFAQY+KaemKWqJqBQxw@mail.gmail.com>
 <CAPhsuW4TJRqQKXgcBYog8YgFLU2h2Zq9ReahxTYp_zpDyvO8AA@mail.gmail.com>
 <CAHC9VhS1DJNs9gDB6gD9WKhL08giSVajBskZ+=mY0AWRCAsw7Q@mail.gmail.com> <aguvV8QCxK28ZHct@laps>
In-Reply-To: <aguvV8QCxK28ZHct@laps>
From: Song Liu <song@kernel.org>
Date: Mon, 18 May 2026 22:29:11 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7Rhdh62AoceQpsfm0+kVsvz8zq97fupm4mtBEyVTkkcg@mail.gmail.com>
X-Gm-Features: AVHnY4Ik8E3QIuzgnAJ_6FBbQ2O6x7lnNpGu0VbQC3UuP_GggCDqJwpkFYs-zH8
Message-ID: <CAPhsuW7Rhdh62AoceQpsfm0+kVsvz8zq97fupm4mtBEyVTkkcg@mail.gmail.com>
Subject: Re: [PATCH] killswitch: add per-function short-circuit mitigation primitive
To: Sasha Levin <sashal@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, corbet@lwn.net, akpm@linux-foundation.org, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 5:31=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> On Mon, May 18, 2026 at 05:29:32PM -0400, Paul Moore wrote:
> >From my perspective there are two different issues here: should
> >killswitch be a LSM, and should killswitch leverage kprobes to be able
> >to "kill" security related symbols.  After all, are we okay with
> >killswitch killing capable() and friends?
>
> killswitch doesn't do it on it's own. It may be instructed by root to do =
that,
> at which point that is root's problem.
>
> >In my opinion, making killswitch an LSM is more of a procedural item
> >that deals with how we view a capability like killswitch.  I
> >personally view killswitch as somewhat similar to Lockdown, which is
> >why I made the suggestion.
>
> Maybe I'm not all that familiar with LSMs, but we would need to be able t=
o stop
> "random" code paths from executing, and I don't think we can create LSM h=
ooks
> at that granularity, no?

There are much fewer LSM hooks than ftrace-able (killswitch-able)
functions. In this sense, killswitch is more granular. However, LSM
hooks allow LSM policies to make different decisions for different
arguments. In this sense, LSM hooks are more granular than
killswitch, as killswitch can only set a fixed return value for each
engaged function.

With current LSM solutions, we can mitigate issues like Copy Fail
without breaking other features of the system. In [1], Cloudflare
shared how they mitigate Copy Fail with BPF LSM.

Thanks,
Song

[1] https://blog.cloudflare.com/copy-fail-linux-vulnerability-mitigation/
