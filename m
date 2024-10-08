Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689C6F9EC
	for <linux-security-module@vger.kernel.org>; Tue,  8 Oct 2024 00:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728348880; cv=none; b=jez1WdXytoPb0tX4P8ff1ZogoO0A2jH9HoB5Kae2TxNxNOx0XHo+hLlG5bgR5nnQOhBDsjOwFbpGo2Wj04RXXD4qb1KzW04UNDag9PFOS3hl1PkkPKb77IuTZqYbPveTIQiATAAiq4WD7IThscARTvYUsgVsifFg9yhYj3E08Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728348880; c=relaxed/simple;
	bh=NqYO63ftG4Vh81Um6zsjfmC5SEgFzFYHUlSf+opM8ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gbf6Rv6QheG0F4ixbu7TcORJeU/dCLsRkQhgtlJCWwEAggb0UXO6qW6on3btVQc1tTnLx6ihWov97O89BXQmHh/EftV9Utffm3PCP9p45+89/CZ8nszoDC+XkoORkwl/H2q23bg9AjxToavDKhvpWYEYTLIJSBMwmuGi4VJVGNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F/snIffA; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F/snIffA"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5399041167cso7866146e87.0
        for <linux-security-module@vger.kernel.org>; Mon, 07 Oct 2024 17:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728348876; x=1728953676; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tnmN82gruhjoauaDPVFxp6c7gOVhPQGFyw+79HJzqU8=;
        b=F/snIffAnVCsDmGGEitWdaEzc3HdFLoomcyh7rivNJqdUlhwvHh3Q+6+zjeloqpH31
         8lRmZPi4zcf9+sFp1NVqBK+1tXFpNhP8R2xqLdpznab5heNJNq49KfEc9PXIEiK1xWCM
         X5jmu7t8z6X/IAhvXIAsdz/5SnOI+Wv4sNZj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728348876; x=1728953676;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tnmN82gruhjoauaDPVFxp6c7gOVhPQGFyw+79HJzqU8=;
        b=oeQIdoAlTPlKU3Jo1046wwZrymDI4fTPJBEEpWvux/PdynhDXA2KSpbZQJ/Ij3bhNq
         5pjVZOG0T0BANGVNZmTRZgNrfsJP6mZqTLkypY8JQ5CDByxCY9XbxtIrh2+AE6aGwuhR
         UPk2FxmPqLI30C+ufxl3PmDwUuA8BD/0SaEdM3M8IaNRsA20yyeZ6Rn8vOxrMlOarky+
         cTFTfvMvDbU/7kx6rVKwwyz6EGUewDSWoxXLDQmaCL6QShsfz+pmmBg3CaYnDFZh2bLO
         3GbznfKRBJlNE/hmAcrKPpnojynnqx1D6k51iIB+3l/TfJ3SdbxMaJrbSXU5QXJSYxyx
         Qb5A==
X-Forwarded-Encrypted: i=1; AJvYcCU2XLn4LJ7uMMPKILupNJeKx4o6ZjfSS5Z7Jh0Drc+PSMI8wB20T9niyZ5DAos3B995BbTE5EZOrlX8Hyq13VhWbi6xC44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9jPtahsv85CCK0SMNiA+241F/BFDYtZJYpbwmgjNLvQD3eKCH
	keN3HF10x3Zd2LSmP8KDEhf6Fp3KSMYngsyGzRWi5GYJ6CN1GR4XO61bi9WvcR8QCieEbtDxoNP
	EmLJRkg==
X-Google-Smtp-Source: AGHT+IEJB4JkyAzGqSE/oKs8vS08lOqhhSozuqDfpHS13N4OUOqUMKKvkfqV1iLH3LQb3NAX+Dssxw==
X-Received: by 2002:a05:6512:3e1a:b0:536:54ff:51c8 with SMTP id 2adb3069b0e04-539ab8664d7mr8293621e87.17.1728348876195;
        Mon, 07 Oct 2024 17:54:36 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539afec8247sm1020300e87.67.2024.10.07.17.54.32
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 17:54:33 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5398b589032so7584426e87.1
        for <linux-security-module@vger.kernel.org>; Mon, 07 Oct 2024 17:54:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8FMGqi/XdFNVv+VFK/lR7oH9g7lDAPxY8bDQ5RC9VkdSXtuyX90YKXzUo56NLowgEPg4A6xb6KZ/e9TFq//3j8j3Uh2w=@vger.kernel.org
X-Received: by 2002:a05:6512:3d07:b0:52e:fa5f:b6a7 with SMTP id
 2adb3069b0e04-539ab8659c5mr8118408e87.13.1728348872429; Mon, 07 Oct 2024
 17:54:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002014017.3801899-1-david@fromorbit.com> <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org> <Zv5J3VTGqdjUAu1J@infradead.org>
 <20241003115721.kg2caqgj2xxinnth@quack3> <CAHk-=whg7HXYPV4wNO90j22VLKz4RJ2miCe=s0C8ZRc0RKv9Og@mail.gmail.com>
 <ZwRvshM65rxXTwxd@dread.disaster.area> <CAHk-=wi5ZpW73nLn5h46Jxcng6wn_bCUxj6JjxyyEMAGzF5KZg@mail.gmail.com>
In-Reply-To: <CAHk-=wi5ZpW73nLn5h46Jxcng6wn_bCUxj6JjxyyEMAGzF5KZg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 7 Oct 2024 17:54:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgW0RspdggU630JYUe5CyzNi5MHT4UEfx2+yZKoeezawg@mail.gmail.com>
Message-ID: <CAHk-=wgW0RspdggU630JYUe5CyzNi5MHT4UEfx2+yZKoeezawg@mail.gmail.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert sb->s_inodes
 iteration to super_iter_inodes()
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	kent.overstreet@linux.dev, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>, 
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>, Kees Cook <keescook@chromium.org>, 
	linux-security-module@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 17:28, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And yes, this changes the timing on when fsnotify events happen, but
> what I'm actually hoping for is that Jan will agree that it doesn't
> actually matter semantically.

.. and yes, I realize it might actually matter. fsnotify does do
'ihold()' to hold an inode ref, and with this that would actually be
more or less pointless, because the mark would be removed _despite_
such a ref.

So maybe it's not an option to do what I suggested. I don't know the
users well enough.

         Linus
