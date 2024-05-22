Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E586E46BF
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716400040; cv=none; b=T4HcNcd8CLlaBETdEba7LZXnnas6i2F3acrjKPoS/QP6fEBGKcpENPlT66CSL24HKjGw/YWyLqrNIGvwelS7Aj4ZYLgVtXQr1rFhbwGlkHseyFIV30ESXOD26yp/otu7y7KPB6zSzfLHhmNX8MNXTswpXnmc43udXoHX/wq7FPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716400040; c=relaxed/simple;
	bh=l/aqMP/pAxxQNkv1cpn6DL6g6yJONydNx3Emd5onJIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsR+psKr8n2CrFArQ24SL18AKBd5Wpja2Y/ITHXhNSmchA7Q9O/8yQv6VZYhqIQnFiPjIsrMUnS8RMrOaYXR2m/Niy0QGLnL7EUfkSOXK6lQR72sqJTcQkifyUHioh1l7qO/W/5FmrneqnYrnMgM08CN44jg45jp/OBrOC559DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=akvgZ3UT; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="akvgZ3UT"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso695a12.1
        for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 10:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716400037; x=1717004837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxpzkj4h24ckPZbqXAVMFddkCZE0Xyra0TpA42yUw6Y=;
        b=akvgZ3UTlTl9+ivduLm+K+kDJXBgX7m9rh6LWIoJ5H2KbLUZiAEB+xALqgtsTGcreC
         /iGvWquaYv1hZkIID9rsWH+bYGPL6cSEsuu9vwcfp8yYhRq43Gc0JxhJxl5pavZeNLgf
         V5pUTOKdLZycj5x8roYhHYzdODB4RXw2uQ5wRgrNK2r5wdpnM1rukZEcDTa7gomOZaIe
         8gv/LNbpNsqpwDslxTRQeWL5ogIzMRe4J1F6OlwOJyEZK87fsy8x8cx251k/J+4mmtgv
         CgJxGH85eI1EexL14QfqlkKsmNLAOqijklgJtii18KpWAe9UOs0ibb0ysTJhD2wrnZDm
         6cPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716400037; x=1717004837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxpzkj4h24ckPZbqXAVMFddkCZE0Xyra0TpA42yUw6Y=;
        b=NNkHB/DeEtq43hgEhPKTb9jf6cHWf3eo5OnCuJArj4StL1sY2TQOVoyiqoM86XP0iT
         563WApdKeLve+FQigugIOEyWFIcW05GsB5dFX8WkrAR5MThwFxoqGzqa0Il6HXRF2iB1
         QHX/BwYFkHjSfz3NhcZ+RWDs8PizPAvY7BeENjOexxrBUfojipu2xNJpHfwa8CK/MDrZ
         D2sKxvJk8POU6CE0mRyYhSddJYuSJiPCcEu9q5d+E/OoyLDy2Ji5t4i6m0fnjXiLUIbM
         +O7A4fUYB9oq25TopFyPGm2eLHPJXbMESBOfY68yLX9w3/zagrtBQZNyDCVEuBnOqeZ2
         lfaw==
X-Forwarded-Encrypted: i=1; AJvYcCWol84rWrHr8bFEar8TR9+wQiYKbCHYS8DgJcjHxpJqorntiyWfYG7Hi8sdRIiP/BHenx+T9Zr3Wd0pYWhJYeJNbEW0MlnaCtdY3TsjizrUhem4tYoP
X-Gm-Message-State: AOJu0YyJxZ7q0q6wKU71Oc4saeY2o5JEsQujHY7O2PPDls1+huINv/Ev
	EuOiSesezMu4YZwF6fanb9CW5tq/y+tDH6EhkU1pNdSS5Brmz9U9Wr46oqnOMC5n4OAgJB9Qb7H
	S1UB5hiCNdyvuiZfepdWtn9WRJY9t2c5f//EL
X-Google-Smtp-Source: AGHT+IEhvV3LATx35FZqHosI0UhkBDI1Niq/eTXGrnklxwDEu8dQhBOKQ05jw+yjdKEjHZAcrzgbp92SS4Zf1xFsuR0=
X-Received: by 2002:a05:6402:50cf:b0:572:57d8:4516 with SMTP id
 4fb4d7f45d1cf-5782f9f7e7bmr285506a12.2.1716400037143; Wed, 22 May 2024
 10:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com> <20240522005913.3540131-3-edliaw@google.com>
 <94b73291-5b8a-480d-942d-cfc72971c2f5@sirena.org.uk>
In-Reply-To: <94b73291-5b8a-480d-942d-cfc72971c2f5@sirena.org.uk>
From: Edward Liaw <edliaw@google.com>
Date: Wed, 22 May 2024 10:46:50 -0700
Message-ID: <CAG4es9WAASaSG+Xgp31-kLT3G8wpeT5vAqbCA4r=Z8G_zAF73w@mail.gmail.com>
Subject: Re: [PATCH v5 02/68] kselftest: Desecalate reporting of missing _GNU_SOURCE
To: Mark Brown <broonie@kernel.org>
Cc: shuah@kernel.org, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kees Cook <keescook@chromium.org>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 4:21=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, May 22, 2024 at 12:56:48AM +0000, Edward Liaw wrote:
>
> > to make stopping builds early replace the static_assert() with a
> > missing without making the error more severe than it already was.  This
> > will be moot once the issue is fixed properly but reduces the disruptio=
n
> > while that happens.
> >
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > ---
> >  tools/testing/selftests/kselftest_harness.h | 2 +-
>
> You've not provided a Signed-off-by for this so people can't do anything
> with it, please see Documentation/process/submitting-patches.rst for
> details on what this is and why it's important.

Sorry, my mistake, I forgot to add it after cherry-picking.  If added
in a reply like so would it suffice, or would I need to send another
patch?

Signed-off-by: Edward Liaw <edliaw@google.com>
