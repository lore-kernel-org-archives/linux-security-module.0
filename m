Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0528A51C45
	for <linux-security-module@vger.kernel.org>; Thu,  7 Mar 2024 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709844672; cv=none; b=L6J7a+9F0vNqO+et0bHtvPdo0heNemJOZGJGnq1YpBt/MDS9VYysRKGPsjFMeYYwjXLzQ87KQ5k2YMgKwGTK8esJwVmPIQIQgYPBBZ77EHtrCnBqH59+KChbski1ElCHy3gvdQbccIVj5lJS8Ve5arxJnKWp1MP3XitOrj5jfRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709844672; c=relaxed/simple;
	bh=u7Y/NG8SjJXNGSItnstrI6/rukzMJzy+yekXdowwXGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUlekXzb4d6e40WKQQc6oyYPxuQm7pnpxvDJj/D1Ro1DwksGjUZNShHiKS2n6SHTIn2SiOzhInhKq4fhZFiBvL5+zzVwjvfQduUOFJb8TNES1bVNcWfz2S5KD3C9C2bVRWI/hqmEayvfutWrH40DXDEJgiHYHgLMUtFpKVFB+sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KlgQVsJp; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KlgQVsJp"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so244055276.3
        for <linux-security-module@vger.kernel.org>; Thu, 07 Mar 2024 12:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1709844669; x=1710449469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiLNl3PvVRA0+tZJXmH2lrS7jOMXZFu6IHJfjoR5u/8=;
        b=KlgQVsJpaoU/RRAD4ntJDOpRZq4I0H9yZRKehk5EIFzsJi7435yKBsEo6ehoqjYcgL
         LBvSEc8St5whA7pQfQ+y0cf7HQHM/Hfye3R5KUaIcafBKCgN3UuG2L6rxsaPhwgI30Dp
         DIDboKoZUORak3smo2f6raN15lSipugFP88Kid9cWOnPuGnyGH6U61tCk4XPIjqShWoG
         MpigDuUfVf4GY1AZuDyea38jd24aP7oOM4AZoYCPXJzGXogcA8QXRHU7eha46QwbY9g/
         MyD8g8WpzVkHlvdvCPI3dHG1K+IuVy81Ie/itxyaQLyD8+oHhXPIGG/A5+SPsDEA0KX7
         HbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709844669; x=1710449469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiLNl3PvVRA0+tZJXmH2lrS7jOMXZFu6IHJfjoR5u/8=;
        b=ZXP5wpKS9C22T8Ltg029nIiqJ+rpIeCgtPSEngQ/iuQ6QXusFkY1VJNSNP9r/lPIua
         RQXxeIkR57RPaTabuLBqbgUPr0DXsyI9EW2RIqzWnMrP+4y7LaM51bD1JJI+kM1UzBMN
         cpdwePizrGweX5CyZIq7D8la8CWX+vGoyqwjJMmAyzilAvxQXJMYjqm0XLh0EoJJh9C0
         p0QZBPcRkD6mcV5Hh6LdOeLKK8QZ+gIbDszeT4sFuEF7eVy7aI1X6g28B2N+dLESdKEh
         BwMKOU7zygSvW4TzH/kUcGNyGKvOs9CIQj5z6qhyAmobGYUPKpypvjPAtmtUCtGdxILB
         TpnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/wg3mlLhX22XyMYhugiF59sMwD90ei4VLFTajKC6cNZ/aaTAWkx6KCNuxUcf+nGvfKzLJ/3OcZJzT5L52jn74EEdiv0IhNjwYATEzIj5xKsAs5e3B
X-Gm-Message-State: AOJu0YyxM0NFiiPWWSDiqigfVqthwJQWiy/l+Ceod++PDXaI31J/azyD
	6nL+JWiFgHrnhOqnF2MNpKb938PG/LyGssUugx6MfwgI0048mXBChiNVD3uRAI7IQqW0+KK48zy
	7qqN74lOVaa6e8u2S38cXMOSmWEbOwOO7+ttc
X-Google-Smtp-Source: AGHT+IFdOq4811A1JsfV2pUrWH4aPW+V27XPXrThh32udqoQTvdjjnprX4glDvrh+sZ0krraTC9bWk2pOpSk01W6NV8=
X-Received: by 2002:a5b:70a:0:b0:dcf:f525:2b81 with SMTP id
 g10-20020a5b070a000000b00dcff5252b81mr16864727ybq.46.1709844668892; Thu, 07
 Mar 2024 12:51:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709675979.git.mattbobrowski@google.com>
 <20240306-flach-tragbar-b2b3c531bf0d@brauner> <20240306-sandgrube-flora-a61409c2f10c@brauner>
 <CAADnVQ+RBV_rJx5LCtCiW-TWZ5DCOPz1V3ga_fc__RmL_6xgOg@mail.gmail.com> <20240307-phosphor-entnahmen-8ef28b782abf@brauner>
In-Reply-To: <20240307-phosphor-entnahmen-8ef28b782abf@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 7 Mar 2024 15:50:58 -0500
Message-ID: <CAHC9VhTbjzS88uU=7Pau7tzsYD+UW5=3TGw2qkqrA5a-GVunrQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/9] add new acquire/release BPF kfuncs
To: Christian Brauner <brauner@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@google.com>, Jann Horn <jannh@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm <linux-mm@kvack.org>, LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 4:55=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> There's one fundamental question here that we'll need an official answer =
to:
>
> Is it ok for an out-of-tree BPF LSM program, that nobody has ever seen
> to request access to various helpers in the kernel?

Phrased in a slightly different way, and a bit more generalized: do we
treat out-of-tree BPF programs the same as we do with out-of-tree
kernel modules?  I believe that's the real question, and if we answer
that, we should also have our answer for the internal helper function
question.

> Because fundamentally this is what this patchset is asking to be done.
>
> If the ZFS out-of-tree kernel module were to send us a similar patch
> series asking us for a list of 9 functions that they'd like us to export
> what would the answer to that be? It would be "no" - on principle alone.
>
> So what is different between an out-of-tree BPF LSM program that no one
> even has ever seen and an out-of-tree kernel module that one can at
> least look at in Github? Why should we reject requests from the latter
> but are supposed to accept requests from the former?
>
> If we say yes to the BPF LSM program requests we would have to say yes
> to ZFS as well.

--=20
paul-moore.com
