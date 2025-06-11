Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28EC246BB3
	for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678299; cv=none; b=eV0ENeKA5eKBfXg7ceIxP1wJAKoXh3raJJYSdPf593JrWsBkOO+zPC/7vlaSo52OCg3t3UGzn3Bc7e4fX6dnVgxSKo2NoYAAF2NAzQ477F+/kygneFmXqFNWOhgHMnWylB9mfqkTOrANNLephoQVfhBAuGG511zkh9kZYW1gcso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678299; c=relaxed/simple;
	bh=n8krQhktZ2+O8eYKDmiKPqrtCH3jMnXwJbh6O61FSdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7XuYQXPsv1aOMjp0Qel7mfFAJ9FwDNFI41vkL2aSa2lJ215ZrObOG9y2PzA3gBRRwra3TIu+XW9mDwz+lk4nGehL0XDMrg21BatLbrntdp5z8qkOyf+PAiinLJe2mmYuWL+M5QEUhXG4x0XSwlytVRjoQ7agtMVhqfA1vOTLpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhhUVeIg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhhUVeIg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838DBC4CEEA
	for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 21:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749678298;
	bh=n8krQhktZ2+O8eYKDmiKPqrtCH3jMnXwJbh6O61FSdg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FhhUVeIgAeBNH25fxz9oF0odfWBB9PCaUfnZ4Q0YUP1YP30jI0aSCxpKEN3pXZ/EL
	 umQQMj9Sz4pmfPR+Ybo9RF3zIJZUew1g3geO7Ww+HifXG+TmVZIJQGLzuwB3L4oeJv
	 DSQ8d/Mwuwj6r9yvffQlKz4+tyPP7FydgSzV5y20ZO6ZuwUwwX3P7zFdU8OOMhjfbz
	 aolAgQ+VphU2suMW+Cq1r84uDzCt5O04fpZcL+hGMwPXoPQf/3aFQoYlTA9bEF4F7J
	 CcvwLl+jMfas+iyElop0ijOWC77R4rliQaht5RcPb7zlHmVs8dPCD4YwMcPyx4AELX
	 SRWEswMpxhSCw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-606c5c9438fso741785a12.2
        for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 14:44:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsEqv+9qoBDP1w9MYLDUQhTTXBC8J68P61EcxLOovN+ZJJZB870SveAsTOQrpcL9uR3rDBVGTdz2EOCsSCh0/l3EwafCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3NwdH6F7f6zvKjrVQyZ9p2VY1BjHA1B9pni9UHL+hkLlkwrsJ
	tMltvDkKVMQCvDFM9CQG0t9AcLZcBgTgt3RoRgIStg0PPyUocgaJoosbQSVKwwTVKZVGITYm2jp
	ZkVnIYiFMqu7PsO0xDmLO9q+fu7hMO5mnDsqoCefL
X-Google-Smtp-Source: AGHT+IHA+AUKel2ZtXicLgKbiI8vDiZy0J6C+3o8M8qgMlN0xZxNBSvqc+itN5oBMIgV5dEJMHIRBCLMglhHx1QFq+w=
X-Received: by 2002:a05:6402:2805:b0:607:425c:3c23 with SMTP id
 4fb4d7f45d1cf-6086a671559mr350762a12.5.1749678297111; Wed, 11 Jun 2025
 14:44:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-4-kpsingh@kernel.org>
 <CAADnVQLMff33qY+xY3Ztybbo38Wr9-bp_GPcoFna4EbtgTrWrg@mail.gmail.com>
In-Reply-To: <CAADnVQLMff33qY+xY3Ztybbo38Wr9-bp_GPcoFna4EbtgTrWrg@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Wed, 11 Jun 2025 23:44:46 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4v+n_6-dVSt9mgkhJPEa3r1q7YW5Zrh0c-j+gos_UOxw@mail.gmail.com>
X-Gm-Features: AX0GCFseZ-SQwR2SX_6Yxnqn9BtMZKCr0JRmpp5HerQz1Mp0lNk5-yqzWXsCimk
Message-ID: <CACYkzJ4v+n_6-dVSt9mgkhJPEa3r1q7YW5Zrh0c-j+gos_UOxw@mail.gmail.com>
Subject: Re: [PATCH 03/12] bpf: Implement exclusive map creation
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 10:58=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jun 6, 2025 at 4:29=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:
> >
> > Exclusive maps allow maps to only be accessed by a trusted loader
> > program with a matching hash. This allows the trusted loader program
> > to load the map and verify the integrity.
> >
> > Both maps of maps (array, hash) cannot be exclusive and exclusive maps
> > cannot be added as inner maps. This is because one would need to
> > guarantee the exclusivity of the inner maps and would require
> > significant changes in the verifier.
>
> I was back and forth on it early, but after sleeping on it
> I think we should think of exclusive maps as a generic concept and
> not tied to trusted loader and prog signatures.
> So any map type should be allowed to be exclusive and this patch
> can handle it fine without adding more complexity.
> In map-in-map case the outer map can be created exclusive
> to a particular program, but inner maps don't have to be exclusive,
> and it's fine. The lskel loader won't be using map-in-map anyway,
> so no issues there.

So the idea here is that if an outer map has exclusive access, only it
can add inner maps. I think this is a valid combination as it would
still retain exclusivity over the outer maps elements.

- KP

>
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---

[...]

> >
