Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CF62A1AA
	for <linux-security-module@vger.kernel.org>; Mon, 13 Oct 2025 02:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760321565; cv=none; b=KzTT8YzeELXS3JPLjwm6x7s8/g/QOjB13PscWVLfFiSfFzp0rHCTzA50OF6H8Cc8tNQ7z1lA8s4rOXxjV3QHmtEw8KmQpAUvfth5LE8Due2iMfjibKXB3Z2gILMo9QQ3MzN4uSA0qk8MFWpMGBmdpdHff4byNJFeUI3gsoO4PD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760321565; c=relaxed/simple;
	bh=VZfdTOdgedZBuYAsHGuqCG7dPreRUBgR7A1n29pFkkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxC14T8pxasqcdzMjd+MclaYMyy1vOlwGERgSGHd7FRor++Xp3nH7LySaZp5qswnIs5Z6kugwtfdam5jpyzvQgzfd7+yjRL1BNHQmdHyC40hfJWCkGr2cBDuJGjSlipYoDeF3ktPjGpvk+hTQUQoZKcXe54W3qV9dMG/iswafn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Lx1K1A9F; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Lx1K1A9F"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32ed19ce5a3so3223910a91.0
        for <linux-security-module@vger.kernel.org>; Sun, 12 Oct 2025 19:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760321563; x=1760926363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QVtgmRPffVrveMWw/xhEvB4D2pv6J+vbUKN7i5/8qI=;
        b=Lx1K1A9F/YQgE97dWV+RvBa/6Y5KNiX72ZxchbYVLGiy0WIErDQYj2KsUeei1hhdBz
         ydfQ1KZOlZz4/cBaoI7vgB6Qa5wmbsyguO+8y/4hkmUIVYY6Pumso/oXf4ncpqbDd89d
         W70PEZUYApUJcHKbVnpO986LZpWGWDIopIZRyBflfmsIdbe/vNujsp3lOU+htY1fPoIO
         fXSlv2o9xIVSzZ5XqXZClGCC+WZV12R/QF+05/H7GK4T+AjjelTAA6lR2Ijghy15NWrp
         IuqWfskPXlIwCejS2afcxR3jBx+F0PdnzZ+9s/EPEFM2HCSlu9y1+Qc+L6MLd3vRcrzz
         UUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760321563; x=1760926363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QVtgmRPffVrveMWw/xhEvB4D2pv6J+vbUKN7i5/8qI=;
        b=sjCYjntpKN3S8oCzvrtzVS3R3mRbzn0y26WgOrLeMFVo8O65h0fmEwAimAhrZSKz3s
         e0Wv+yGQrDUlMEfBnHT3RCkpgCAkQ3ZlWWF8DdbzdW4uZkufTQEimQNQoJCteyGNw5X2
         dqfrQb6mMrIUVMAoZbh2rxWXrxcKmMY5ihLsXkuZLIDzgswY7aX8tDWs0HYel1VNpjPD
         6Fxhl5ZicAJWko9rx6ycpmzdnYb2FPl4JD3aQwb7U9wAasVHZStY8SLShdWcHk2jkBTR
         Saic6hiZGh2w+43V3SFHJ7QVmsoSZ+e2n1rSzS5yoIiJyVp90OwMKyM6sr65KNdaVfvt
         uTaA==
X-Forwarded-Encrypted: i=1; AJvYcCUqKx/mGUrNjtJ/3LE7gPpJzfaWAaU+35vawpNgUwXJGx/cVtljtkPy7eqlEVRSBSEbXLnI8+Bjz956Ea2CJnWAxsQgCOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzErws0zinf8V5Tlxh4Qz6uOBOYZb+/u9IvvFLkLNC6Erf3Yb/4
	rXTTx8j1qaaNFKtLHp3Y2N36uzyi41HQDD2NxMDEaC/Ud9+5BT0S6ffoVgyCSELg11xHPEUAruZ
	F9xu7AKLM/rV8EjutnWHdGIyTaIdtdyoBME8FNHiP
X-Gm-Gg: ASbGncs8Vk+su0j/Ep2PWF7jnQiXwauN0jpwG5JBp0BiaJaZbUcKRzgna0DNVmbjEMw
	voa6zLlXfjClMTqIf+NLVvj3Yjmm74NbwtZP9sCDPR9hvPG/gzGEudUsZ6+0A3AKwtrDmIL88Pf
	pNyTOxZx08yi/Jpn7Ax2ukya3xVwVeX7X4i5uIOYI9KCHCn9xSYq2Mct3V0bpN4ICh9noaRpJNu
	b4DdR3+Dqn7hfFzlA6nEanM5g==
X-Google-Smtp-Source: AGHT+IF/7dVxx+fWF4F3e0kqhOjgNsZbz0VE6Auc0DsC74H9CA31kPdNtr2DRAliP1k65VbG0X/QtMinwgZfnqQjA/E=
X-Received: by 2002:a17:90b:1b12:b0:32d:dffc:7ad6 with SMTP id
 98e67ed59e1d1-33b513a1f6cmr28160281a91.33.1760321563256; Sun, 12 Oct 2025
 19:12:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
 <CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com>
 <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com>
 <CAHC9VhR2Ab8Rw8RBm9je9-Ss++wufstxh4fB3zrZXnBoZpSi_Q@mail.gmail.com>
 <CACYkzJ7u_wRyknFjhkzRxgpt29znoTWzz+ZMwmYEE-msc2GSUw@mail.gmail.com>
 <CAHC9VhSDkwGgPfrBUh7EgBKEJj_JjnY68c0YAmuuLT_i--GskQ@mail.gmail.com>
 <CACYkzJ4mJ6eJBzTLgbPG9A6i_dN2e0B=1WNp6XkAr-WmaEyzkA@mail.gmail.com>
 <CAHC9VhRyG9ooMz6wVA17WKA9xkDy=UEPVkD4zOJf5mqrANMR9g@mail.gmail.com>
 <CAADnVQLfyh=qby02AFe+MfJYr2sPExEU0YGCLV9jJk=cLoZoaA@mail.gmail.com>
 <88703f00d5b7a779728451008626efa45e42db3d.camel@HansenPartnership.com>
 <CAADnVQKdsF5_9Vb_J+z27y5Of3P6J3gPNZ=hXKFi=APm6AHX3w@mail.gmail.com>
 <42bc677e031ed3df4f379cd3d6c9b3e1e8fadd87.camel@HansenPartnership.com>
 <CAADnVQ+M+_zLaqmd6As0z95A5BwGR8n8oFto-X-i4BgMvuhrXQ@mail.gmail.com> <fe538d3d723b161ee5354bb2de8e3a2ac7cf8255.camel@HansenPartnership.com>
In-Reply-To: <fe538d3d723b161ee5354bb2de8e3a2ac7cf8255.camel@HansenPartnership.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 12 Oct 2025 22:12:31 -0400
X-Gm-Features: AS18NWD9zfIn5tcHQ6Y_nLKIN3zk-5cLTWyK-kph3M8Yz9ldmfZRQl8D6QQtW4c
Message-ID: <CAHC9VhSU0UCHW9ApHsVQLX9ar6jTEfAW4b4bBi5-fbbsOaashg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, wufan@linux.microsoft.com, 
	Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 1:09=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Sat, 2025-10-11 at 09:31 -0700, Alexei Starovoitov wrote:
> > On Sat, Oct 11, 2025 at 7:52=E2=80=AFAM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > It doesn't need to, once we check both the loader and the map, the
> > > integrity is verified and the loader can be trusted to run and
> > > relocate the map into the bpf program
> >
> > You should read KP's cover letter again and then research trusted
> > hash chains. Here is a quote from the first googled link:
> >
> > "A trusted hash chain is a cryptographic process used to verify the
> > integrity and authenticity of data by creating a sequence of hash
> > values, where each hash is linked to the next".
> >
> > In addition KP's algorithm was vetted by various security teams.
> > There is nothing novel here. It's a classic algorithm used
> > to verify integrity and that's what was implemented.
>
> Both KP and Blaise's patch sets are implementations of trusted hash
> chains.  The security argument isn't about whether the hash chain
> algorithm works, it's about where, in relation to the LSM hook, the
> hash chain verification completes.

Alexei, considering the discussion from the past few days, and the
responses to all of your objections, I'm not seeing a clear reason why
you are opposed to sending Blaise's patchset up to Linus.  What is
preventing you from sending Blaise's patch up to Linus?

--=20
paul-moore.com
