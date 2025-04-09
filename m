Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFEA27602F
	for <linux-security-module@vger.kernel.org>; Wed,  9 Apr 2025 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744220563; cv=none; b=XrI2ppaOdVLo9E5YJXDphourbd7PgnlUJe5HG2kw3tDxiFI2b+aBs3Sp8263+03xsW2BKr6I7NIIjKBmzghBeDwMiEPh/DM/E/8Jsbv2VlUjY1C3sCNSYHTR5632TilioeRhOxJII/tqNbFxbWLoV5Su5NkGQYubr/AWytv/fX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744220563; c=relaxed/simple;
	bh=6nNQatqaorKzv92tvaje0/GNGx2i/9tcg23Gb8LTF+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4AvfIskVXlIs0XXZNm3Ia1cXvB+Jx3lsCTXhJdTo7Ffrgm/9yeXeIpqmwMz+SbqggHTqaXpCHzdLJEedrEYI/Yqrs3Tl+y2KUjUEkXu28Lptbsp2RyZD5RwomGcH0D/0T0akGpc063WJEegnZHnJj/3QiFAMX6zerRFOLjdpfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YKtQ5QIO; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YKtQ5QIO"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac34257295dso1412033066b.2
        for <linux-security-module@vger.kernel.org>; Wed, 09 Apr 2025 10:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1744220558; x=1744825358; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qoBR+vDT5PVn2pWN/hnunYWhxqisiDADqelTleC033g=;
        b=YKtQ5QIOl/K+7u2vBZ/t9McpkRu5hoZZaDJYMwzssuVjUx5nUj5Vf6NzOV3ggNp6iV
         XVdidn5tjIlrd8b1vdQK7MCgFnI92fA4l8M+/ZxLMj/SU79H8OHgRT8BBGVh/jeBadAv
         VXQfaTWm+bRKd/KEWIlyohQSPpbBNWWRwW+m0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744220558; x=1744825358;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qoBR+vDT5PVn2pWN/hnunYWhxqisiDADqelTleC033g=;
        b=lkgNKkW+zZ/aoNwYgAPTHl+w57i6GpSDgH/4cssc0ALPBp8t7+GDehjZ9D487k8eTW
         fywWO0NhsXUndUkrGmWhYA7Hql8u+PYPHb5bf03PeCMBYMl9iJZOd7BugkiovgUnMJZB
         F5jFSEv9p9M1NXJwSnqrGBiVbqqaRQ+ohleWrAPs9aPrLANbE8gSgXdMQGzsTEb9YSoK
         YgBOSdV1GWHpxoyt4jm01foity0ggIGP2PDrDWj7N4NDIeo6ZJz8PB5Z5uM8VtHx6S8m
         MFpO9grgdjknh7EO+r+mVyD7RcCcC1Ad4C6k9WCb0SvGj3kf77YsHPeXM0tcvcYHlTP+
         MBDw==
X-Forwarded-Encrypted: i=1; AJvYcCWBkNBkzEwrnFn1hYDILJ82zvlSS+8PDr9NG9ExM4lvQt43yTfQifSE1T8MFV1KE79tfQECyOlm7uJF2uv1leAoYEE9Wvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPcNZt37cu+Nf7YW8hVq3zmtycZSMpEjnQCQ3mtodFUXyMbjQ3
	4P85saZHlFG6aIulYgHmxTQbEyPi82KnDADAxmHojc6K3h/QV9WhDtJe8NLv6rzU13b5Z7+dasB
	iQw0=
X-Gm-Gg: ASbGncvKWlbELZor7Z10j3A5ey1ikTsn2oNlS3wChLU3aat+e5MYDKIYVp9MbBPuiS7
	4oVOho1myygSGxVJz5L4Wc1W0FVo4wjEpc90glU5b9qCc1g1ftxZbEOZSDElucb5v91G0Yy0g60
	KpGcxJTNA2YZ7Qr8ry7Gd7dYR0ETF3slGt66RexBHgOhci4tnWUmJSaRVG+8nwjggR01HBZHoFX
	I16feDVt6u7hZua7Gn/y+GhFkMlYy6mNY2/C+8N+pN3zywxla1V+dffiCHmGIepFdFwtm223YGP
	cpXrhmi0NvF0Wjd4RgwIYkCU5f+BARgXzu/hLXUULYztAGiD83IUejOn6Z/L0OVPPTAMqsaItXz
	pqEwXXZJV3TyvZJDCclaIj+LcLQ==
X-Google-Smtp-Source: AGHT+IFO/TXULrWalQI7MZG55syaEnb5Q3ASOalATAri9WQOGx7Rs0jc5mCObWrL9p78VmDxq4202A==
X-Received: by 2002:a17:907:1b1a:b0:ac3:b12c:b1f2 with SMTP id a640c23a62f3a-aca9b69839fmr388791066b.35.1744220558198;
        Wed, 09 Apr 2025 10:42:38 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb2e7bsm129103466b.32.2025.04.09.10.42.37
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 10:42:37 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac34257295dso1412028166b.2
        for <linux-security-module@vger.kernel.org>; Wed, 09 Apr 2025 10:42:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUilLD2IHoxXB8IhMVGX81sisSxwveSrydeXw7ZRh9FgTmRA/tkzyTU6IdXfCJn67C7VSyBDMtuRDn10tNu/aC7X+EhGc=@vger.kernel.org
X-Received: by 2002:a17:906:6a1d:b0:ac6:e20f:fa48 with SMTP id
 a640c23a62f3a-aca9b697344mr478182666b.33.1744220557177; Wed, 09 Apr 2025
 10:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org>
 <202504081630.4CE88E855@keescook> <db50faff-7290-4193-b861-f60e36f1d1e3@sirena.org.uk>
 <CAHk-=wjc+piYyUw36s4ttEkY32jVkxhRtyrt431wew7XcDS2Qg@mail.gmail.com> <a9a459c2-674d-43dc-9e27-41de0471f602@sirena.org.uk>
In-Reply-To: <a9a459c2-674d-43dc-9e27-41de0471f602@sirena.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 9 Apr 2025 10:42:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKEuQQh2JymabBQLrLs=pEfx0qYVmUnYZRq_tOFj90sA@mail.gmail.com>
X-Gm-Features: ATxdqUG-Bs73VX2eSGz8XZIzzueOW3xC6j3KpNJoIRi6w4YuDwZR8xbIvrtKvKY
Message-ID: <CAHk-=whKEuQQh2JymabBQLrLs=pEfx0qYVmUnYZRq_tOFj90sA@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: Disable GCC plugins for compile test builds
To: Mark Brown <broonie@kernel.org>
Cc: Kees Cook <kees@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Apr 2025 at 10:29, Mark Brown <broonie@kernel.org> wrote:
>
> Sadly it seems like the build bots didn't find it, or at least if they
> found it they didn't identify it well enough to end up with reporting
> the issue to someone who'd fix it.

I wouldn't be entirely surpised if a lot of the build bots end up
running old distros (because "enterprise").

So this is presumably only happening with certain compiler versions,
and I expect the build bots have a fairly small set of compilers they
end up testing.

            Linus
