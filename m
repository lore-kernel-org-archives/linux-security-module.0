Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E57D221294
	for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 21:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749676900; cv=none; b=OG7w05BAqCF+t0jjamQ5LlZkAyU5pRjZIsYrs06MMUKL4Jvs+Ef+7bIW8415ng8h/B+p4N1f7loz6cTdMP2nYi1XAgUEe+kXtfX6PHWwRvlbXd7W5F2l+KIAs2KfBkHobga21fmfS+rhQqpq9dQ5VDL8Ig37RliSmhtfVyKSdiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749676900; c=relaxed/simple;
	bh=M6HxvA49p+fK8bp/m2l/SRceWAjSLs3kZZfYsnrgxUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAwW+Ekwj/tmRthL9RhImBc7FLfP8mHsyB3wR+K7t2mKRkq8riXmyPKrMkOGaymvY/CSi3eFx86pXWdsv/iEs79/tVEz91wxEgaoiC3RpCWqz1Q8xKxNoJPa09hbFxGgR+R2Ydp8OGSoOO34I3Onl4GkZ2x8m3d2uV0Esq04R20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZEw3xTYh; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZEw3xTYh"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ade326e366dso44675966b.3
        for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 14:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1749676896; x=1750281696; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OgzdZm4+49mKePkx+kNZ7H8LSMYhd60zWxBKo/56OGU=;
        b=ZEw3xTYhQtfK1GfVgl2KU6awL5GPzlwb6Ba6X1ue3Xuqs5H3MhGtQu7PW+ldn4ej3g
         LJ+s32gQ6FVR9/MKdSFbjqCbu8Rvt+p+rxp90X9SORXwkZKKEwNdNiZST5oF8rBgOOim
         xoMDwEUsiznoSYFtBKQBQYMAiIQ4lWfAsZiqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749676896; x=1750281696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OgzdZm4+49mKePkx+kNZ7H8LSMYhd60zWxBKo/56OGU=;
        b=nBZ7YaMxkB+vOB3VhBctkPvtRik+zLh5sIQqsKzPVkpRgOBL3rYVRCLavPXrheAtrt
         eYF4h6EMDgX0+FL+NCVpfkhBiEMVtPclVmLw0IR30drQcpVt5LzTpTfr8nCm7xGDXtOz
         WZjF+mmbTZcvjCK7gC0DqvRgimwQt6ZH68Z/pvGhjnyOavidDvUl3g50ndsriB2s+Nzq
         TPLnO79OsZTkCPvfLGaeMPC8LoJCuEvYSsV55tty+tjVgL5Tgv5lFtweM0OzhIj5XANo
         Y1FLFh23QHVqrReKjU2dBgCEY9EaP5cwd8613HDCfTAa8HeA0lTZCHThwBK0hqZTeKtZ
         n6FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaIomh7i0tFwDIpt92pST1Ln6jWUGLxqIEXENC69Twk/CMhuRbAVS8PIP4yHSb5QW0TEw3T/pxEeEDCfiQTNsPvxbv7eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmJCn/ReOwF3T73M0I7fQd5sOu+ZiXa16UCeTfggCX84ahScq1
	e6ZhDOm5BFOYxIfLT06QWf0Pn9mJCWqkgK/D5NxOm+81PEf9MZOFyqI9n4LIlktXiqsWcSKZaDe
	h5CsazWA=
X-Gm-Gg: ASbGncv5J7Z8vuHoOQaTBNQNaIybB0drCGSOAdxB16Hgeno9lNrXu39mlI3O+EZVWSx
	Qv6TKVg9oHR1sO/1lg9SpTvkGV9s9tqHpsZub8cnJuts32hus+RpDTI/Au8TQF35AXSJCFDaEvd
	V3suhhxCnhDkrPKr/xQZysDkSni8aWdLLoUDLJQVbnnZ8WZzKx+gnvq4clz0z779R+MGeBjag/t
	5WApxBd7J1VGQooFWC+LX5fYfIOhMOUTl34VH0beixvJ1j91ryXdjX4TeeEyvay/H9qX4zPIf3K
	B8EMd7K/x0CACkfPIrAcXWUGb0xb/LhmZUkTnZPSxpMbxB9lllc7LQB4BuKNekb+UGfg8w9CC9t
	+HtQWo1zZKipMGJtMWPMr06aNEGtQsanjOl0W3W67KAzwLtA=
X-Google-Smtp-Source: AGHT+IFBVVvP8qi//UKtd0md/cAwOpu+NBk1W7kreYWEs2npp+I49SF6oYNpXXHAcDOauZIg+1/PrQ==
X-Received: by 2002:a17:907:a089:b0:ade:40cb:2515 with SMTP id a640c23a62f3a-adea945fd39mr61649066b.59.1749676896315;
        Wed, 11 Jun 2025 14:21:36 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adead4ce1c0sm13567066b.32.2025.06.11.14.21.34
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 14:21:34 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so575025a12.3
        for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 14:21:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKmoH9Fy8c6oGBkYveKuC6mKhUuelFDmP/RPJ+6ykMg+kmtzJ7HS6zTwn0yRSD5DSu/sd5Nqay5qOPloTLbMJAWseO4ss=@vger.kernel.org
X-Received: by 2002:a05:6402:34c8:b0:601:6c34:5ed2 with SMTP id
 4fb4d7f45d1cf-6086a8d8175mr280985a12.4.1749676894398; Wed, 11 Jun 2025
 14:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <301015.1748434697@warthog.procyon.org.uk> <CAHC9VhRn=EGu4+0fYup1bGdgkzWvZYpMPXKoARJf2N+4sy9g2w@mail.gmail.com>
 <CAHk-=wjY7b0gDcXiecsimfmOgs0q+aUp_ZxPHvMfdmAG_Ex_1Q@mail.gmail.com>
 <382106.1749667515@warthog.procyon.org.uk> <CAHk-=wgBt2=pnDVvH9qnKjxBgm87Q_th4SLzkv9YkcRAp7Bj2A@mail.gmail.com>
 <20250611203834.GR299672@ZenIV>
In-Reply-To: <20250611203834.GR299672@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Jun 2025 14:21:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgGMd31KshGecZJCupkGJQteupgk1SqswBsbHadMfpVhg@mail.gmail.com>
X-Gm-Features: AX0GCFtJBJ0_GDTJQXbaSb0DbKUaXWaGBcUByl4A2_DrwE75v36idPEAZwBhho8
Message-ID: <CAHk-=wgGMd31KshGecZJCupkGJQteupgk1SqswBsbHadMfpVhg@mail.gmail.com>
Subject: Re: [PATCH] KEYS: Invert FINAL_PUT bit
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jarkko Sakkinen <jarkko@kernel.org>, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Jun 2025 at 13:38, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Speaking of the stuff fallen through the cracks - could you take another
> look at https://lore.kernel.org/all/20250602041118.GA2675383@ZenIV/?

Also done.

Well, the script part is, it's still doing the test-build and I'll
have to make a commit message etc.

              Linus
