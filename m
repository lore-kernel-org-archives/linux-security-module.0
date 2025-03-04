Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B4F1F8BC6
	for <linux-security-module@vger.kernel.org>; Tue,  4 Mar 2025 22:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741125893; cv=none; b=Y7fLDZ4oarPOIbn8dmIlASENu4yamu9oQHWHnN4aZje9ckJsqStT7sArgEhGLBfUiiBHy/oyjjECzaWxIGrumtlZ1mwLbiBqalh5FQETIAcq+B9hU8cIRlcZz1xDOUW2VcbkVatBc4f5ydqDSR2zlWQpe70lmYG8Sb1vLFLKKaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741125893; c=relaxed/simple;
	bh=TC4cgMsPXlqLN0bRWCQ3mDHh/XYPnoGk/mZglndqOTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcN+0dzaVH8OjVk8WhiOuRaWRvJtW1tVyn6ANrIavMotnrUA8G5lFmNOPlcvXyvYDRGyjVEJICf6Cc4DzrUUfq1ZlVgVEWi5UUaNNf4k4dvDr06/K5FXpj8zvuVjMHE3gK8Y7erVuBwhIoR1+2xOu/cECX/JpFLBjIBS6ZyAUNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FIz0gpB1; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FIz0gpB1"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e5dcc411189so5296968276.0
        for <linux-security-module@vger.kernel.org>; Tue, 04 Mar 2025 14:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741125891; x=1741730691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGYM825COeY4cDgaQz2uYAo42uyksoN4eaWbp06R+Lo=;
        b=FIz0gpB1VZEdS8WwBOjNdMMyr0ra1gVjdJLaGGLOJOqK1P54HykCPrGPnazZTfv+I6
         jY98UEd6KcBBuyHQZ/V7fvyAiUz6HNla7zGGt3rKRv5I9zlHTRklHJatYL0XNQbgF6D1
         2zOqB+c6QfOOa4gkKfxy2hjAign/DIZxKBrlG0qNWodth8N8M17xzaRYjsQZ7YqaqJPU
         IuVPT2JMaZqIY1+egY38z1vgv1rK2u5MXM7og7YaveiSODMZp87JksFk+eWVVLvH+MBP
         i4cTmhM6bjqmh7yHQBfafWu3p/dkanoAhn9r5u4T1RzZLMiyRrILdCGtMZ6FLsjjuAhT
         sVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741125891; x=1741730691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGYM825COeY4cDgaQz2uYAo42uyksoN4eaWbp06R+Lo=;
        b=Ri8LTnEirmtfixAZUPI5jIhwx0F/SKBg7I1bFW5LBKBE1ppooksLFB98W/JmzDMSU8
         2SlcYYKSpws6g7oJ848o6VgXcQQhAuwNiLdjVrowHd2ODOiKHzvMSybkONHgM+fEBKCm
         iaK73Poujco8NMarf9hUJprRjGm6BsItKuJiBFjD+tsLEnz/mY+Wgz6YZMemTKhqnVfQ
         GNWsppT/jjMnr4mShteZ6+fvaC8qqpZKzZIyGG9N9+2NVfjSOswOyhFCc19QGOZjQoEL
         sOyYaFF7RL6/p+vmiUDvyUGnZkDAS8t77N4jCGpxJni0ukegfQt2Vne4Q9pfsj+4dc4a
         1wvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDE47yyHGyWNbP5NBgKhMks7ePCgLJcixCRhtVOUylsSD6jEDubciDQtGFC0vV9+FiJuDvwTlIy8IqVIVn1hnz5rNpY3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo5BfVoFa8FK6IKJYs+kCUNxM51/c3buNf5+b6jLaEdYCkdbS6
	7C29WuVO38+pacHOtwqINdx9hBdjVNWVb5kiBtP+ZJSUT0V+2ZVSR4T3XssMH/sjRSC377RO/Hl
	bbA0SDzuhsYgwlF6JTMgpljIhh1wQZfoOurU9
X-Gm-Gg: ASbGncs+LvCexoUPV+vMLdjRpWtMjF7/dLIm/HJiJ36zX4KBrEW8atGKg5OQEkE/y11
	7FOAUsgTVF5R56YNCrhqSNieMg1dJsRG0OHC2IaDYjWpARL4f2tgSjApq7KFZ/m5S4v9dVhchLE
	tqn2byOAokAywDMATXXSH64I5DSw==
X-Google-Smtp-Source: AGHT+IFulQ7LgzvyFb3/gdh8eB9ie1deJisxgjmyOD1UvKi+UT64a2qzLysIF+yMVnVpF5MLVUeEs4rDh0zS9aY9ju4=
X-Received: by 2002:a05:6902:2407:b0:e60:87a0:6216 with SMTP id
 3f1490d57ef6-e611e1cf5fcmr1341862276.5.1741125891325; Tue, 04 Mar 2025
 14:04:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-inline-securityctx-v1-1-fb7b9b641fdf@google.com>
 <CAHC9VhSo3aGsJVd=a3MTeakgU66oTN86oh5sZE8P4ghSk8Rx2g@mail.gmail.com> <CAH5fLgi6ZFBqtyUuGPbdST-tEzHJ=Wp1khDxQhO_h+bZiFVj8g@mail.gmail.com>
In-Reply-To: <CAH5fLgi6ZFBqtyUuGPbdST-tEzHJ=Wp1khDxQhO_h+bZiFVj8g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Mar 2025 17:04:40 -0500
X-Gm-Features: AQ5f1JqWP2T9LLdIaTLM2jPEYtQYSDndqPtWBU1S0MWmqJHMHH9IUg70OKKJ0Vo
Message-ID: <CAHC9VhTOug3WGh3MdMQs4VxDW=-q6aP7DF5raDXv40S3iP6euQ@mail.gmail.com>
Subject: Re: [PATCH] lsm: rust: mark SecurityCtx methods inline
To: Alice Ryhl <aliceryhl@google.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 5:37=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> Regarding the other patch for "Credential", is your tree also the
> correct place for that? It's a bit unclear to me which tree maintains
> credentials.

Unfortunately, the cred code seems to be a bit of an orphan with no
clear mailing list or maintainer listed in the MAINTAINERS file.  I've
merged cred related patches in the past that have been rotting on the
mailing lists, and Linus has accepted them; I can do the same here.

I'll probably also toss out a RFC patch to volunteer for the cred
maintainer job, if nothing else having an explicit cred mainainter
entry should help clarify things for people who want to submit code
and don't know where.

--=20
paul-moore.com
