Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624161FCFEF
	for <linux-security-module@vger.kernel.org>; Wed,  7 Jan 2026 01:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767749360; cv=none; b=TbkYhb3Eu2Xoia7qQyQJuhNrhvcSziA1RB4ZtdOyOGQCzNOC43bgariQfNO45100twHgtEB+19UtSZmO24vJQZCsTnDSfpMvoHYmLJzh9tXi90QEjfZoy/FajQkPNdrproDHhAGVLvrFK2fVz+iQ2XALf/3rx9EPf56hPXH4fTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767749360; c=relaxed/simple;
	bh=efb27ahwvcu5eTNF+w+LFsouxAjk9B/+emfJ1v5c0AU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iyyv5vK3wYiv51/Rwe64m3yEWDgBlv0QnIWg8mwaCgo6pVHhqRjVYgCLAYeRZJEFO7F1pDO08q3mtzLn0tWlkuxiioOfvVucUMZ2UEy8hItAttoZVgtI3EFjihEHY+mGmYSwqnqDYV5eOWwHSh2GY2aGL3MZNDqjacIJf+NFj4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SXhIbT1c; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SXhIbT1c"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a2ea96930cso14436595ad.2
        for <linux-security-module@vger.kernel.org>; Tue, 06 Jan 2026 17:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1767749359; x=1768354159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YvJIHA9RzduIFHb88DZ0CDJBYfIAdU49Q0u6Vqr9PM=;
        b=SXhIbT1ciKBl8nryg/bmmUZ6WfMooKCGMrl3WsoBlLQOVDqoD3UOTV3/YOcpOqm1Da
         XOSxh1pzq/0DL0hs6k2KwVBwE+z9OTFAHQvLk9omy16VBv97+QihqR4c9T90Zr7Xxiqb
         E07FIzSB39xlTCUTlpva3s5F/y+ZLKfZBaiFKHT6mzgZDOO1/nuoOJyr63TX9HGZQtBA
         XV0eIi+iJolKFH+k9y7CMEwGYYRj1hrxkJgky++XbYk3MrYAXU3ZwqA2lXahTlf5c4ME
         rT4cY1XP4wHxp0ABJfYNBKcuhW+BLA1zXDIyxcGFGtnwbh73zeMY0+tjX1fm6QXWZFxM
         GKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767749359; x=1768354159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9YvJIHA9RzduIFHb88DZ0CDJBYfIAdU49Q0u6Vqr9PM=;
        b=e3yEugGk56Zm81Z6Or8KzB6iG/7j3n1I+r8TvSXP3+0VYwp9pdA3Nkj+Hv1wi+0Uou
         umz2ZMV4FoQgRmuBRiVeHRO3IsGhbxjRqa9/cH/3rxQvSCNeIABFT5Nbiac0oEANpJX5
         G7cjTjeYidas3+4F9Udx21pDt13sSQiSMWo8i7pP8oRyw2z53U1Am1/N/ugAvww/FwNU
         SIvgtPS7lU+CHXRc5qG41rcRHcw/dKAEKM1dMeY4pO6BqIQWAVdbNlF008dg12Z7/ueJ
         lSV+/ylVqdLUZPFKQzphGp7+VcfCOZj7ZBiFa5KKr/P/rRRl0XqBxDn2I+I5W1Jo59f+
         AapA==
X-Forwarded-Encrypted: i=1; AJvYcCW67edjUn3j4YmhIXDV+ecNPZVurXvc97kwCl/WQX11mn6J5bfaffikbMvPRxX2SBxw0CRcZl5u9SRn3UyirmKYyp9fDA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyrXk7a0yTak/mzZH6kpdXIGFZaM1xm1Km275l9rb5+eUgt86T
	3z4cvD8IiHG3lNqG5h2dB3reoNqCh7A+9IRareBRn2Pbmxlkf6rLaP51pSEkjfb9N2Q8wdwcLux
	X+opuSABUn2J765eOjRKju5Kg0v65y9xiwcAv6545
X-Gm-Gg: AY/fxX7dr+tvyo+Rjy/S33kE9xugcyt2xL0Yt7kKddcYSoy3EsgwK1YZnQNnzPwO2Sb
	keCZ7ww7iRbvU2D8PPYIIU322w/2P2nBML7olub3Ccxrlc5Pcyb+nRYDmkGegUoOEJ68qE/uTyr
	c5KxYqAAONaCyZuz0Vr918C/aF9gQbBSoO53UHD3FzrryTk7wDdIqWBJcrSCeD9iR2lrhzWuML0
	idJe2alLCjVL4zanqgW6Klxn6V5c2M7DzNlFfLXr4COCyxX2KfhuolmW0v9J9MY4bAR1GU=
X-Google-Smtp-Source: AGHT+IH2qcAN8OBUbyKzuJRAbCv+pTBGfSkM350hfi0kcONMXoDpnK6dT9Y4p43qtu5P9jg1KrwD8PcO8dXJO1WPrX8=
X-Received: by 2002:a17:90b:3852:b0:343:b610:901c with SMTP id
 98e67ed59e1d1-34f68cb9036mr974242a91.26.1767749358660; Tue, 06 Jan 2026
 17:29:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
 <20260105-define-rust-helper-v2-7-51da5f454a67@google.com> <CAHC9VhQthnDRi3yXxnD8W_vAsxKOJPh8Zd1YxpF_fU5YGkj3SQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQthnDRi3yXxnD8W_vAsxKOJPh8Zd1YxpF_fU5YGkj3SQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 6 Jan 2026 20:29:05 -0500
X-Gm-Features: AQt7F2ra-K7-TYj3DOZSbPgkYsFTnaQ8WA13cLD4MgjqQb7IOQ94PJxGOL_DCIM
Message-ID: <CAHC9VhTqptD8_QWsUehss27AEhQq8oi6=rtA+dQTCAO1VoEYbQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/27] rust: cred: add __rust_helper to helpers
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 8:25=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Mon, Jan 5, 2026 at 7:42=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
> >
> > This is needed to inline these helpers into Rust code.
> >
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > Reviewed-by: Gary Guo <gary@garyguo.net>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Serge Hallyn <sergeh@kernel.org>
> > Cc: linux-security-module@vger.kernel.org
> > ---
> >  rust/helpers/cred.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Acked-by: Paul Moore <paul@paul-moore.com>

Ooops, sorry, I just saw that these were okay to merge into the
various subsystem trees.  Merged into lsm/dev, thanks.

--=20
paul-moore.com
