Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1331C212FAA
	for <linux-security-module@vger.kernel.org>; Thu, 15 May 2025 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747342420; cv=none; b=HH5gVvvjqtwQTGcwvWvkfmNqkYDwB7beZlmTyGqH/CtP5fb2LGtzOQuyxHyHRn19lETiXXbJeiYJf9AcpujPGa9fN5NsC38Zrd6lT6GvRRvcuEJsTFgq9U3JEOEqdh0rBkndLCCvRv4EHTZSTg/zoEP5ViqsTx8kxKHcO1BjWCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747342420; c=relaxed/simple;
	bh=tRv9EmETRWPXZVHYTT7h73M1bxh8y8TuRvMu5qA/7F0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abLDhHADtXp6HREI6kKgYBeBUyeZVxq3GyW+6O1/rXoJyBo0JmMy+n6En/RZaZv747iZ1GOsn/owazRLkKgaQCIJ2qMjeIbiL/hn/BFC7Vm/w58T3u3ky0wUI/Q8ENNzlk8chilX2QZBiZQ5gnlQXCAKi0SWdTWUZ45O+C8YIzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2nKKaXMq; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2nKKaXMq"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5fce6c7598bso3545a12.0
        for <linux-security-module@vger.kernel.org>; Thu, 15 May 2025 13:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747342417; x=1747947217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRv9EmETRWPXZVHYTT7h73M1bxh8y8TuRvMu5qA/7F0=;
        b=2nKKaXMqiU+Y6HP+xLOkg9rKEusnHOmOeXkq5h/Lhxw2Q5GjKRUQzRj0ZWR+ijlJZi
         puAiKjv1EPimoohXSmZNbBrrwhMe8MUBiZB8yMz7p1tbx7cu0H6lSylVQldX2FmrKOeL
         R+9adWGLo8XvTiMS2VuZevsKr+JFhFDC5bWMsCu2tiL8l+ITcqOWfvoMyDO3VmhE57lg
         9Fb9xr/GIKkVsBl3ivleppN8dMfE+18jhgv9Obr+yCyjBTHUB2QTmso1wprAeKhn+0TW
         YpcMF5PSUrq+OkYDsycdVPNbhSu8VacQOHAEG0Axm7VsikxPJ/q9GYm5cc1n3Mo741a/
         nmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747342417; x=1747947217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRv9EmETRWPXZVHYTT7h73M1bxh8y8TuRvMu5qA/7F0=;
        b=Qvxfy0e/YAXZUh2Sm0qZjwVzz9uAkt4VAeLGKtuR5J0MF5lO6brj5sMFt6QEG2qXTI
         IPISOldqAH2KiCXvILiaDz/XewXMfl2NsyfA6OjQeu9uuLHcEl+WU7ceJRMHHHcPS1R8
         rucO8BVDk2ImVgY/CnM3n92q7r+i9zS6zgLhFeJQnnxwIHYDQPsmrYPpVn9a5yY9j5HE
         acAA53OQ3oB2JE5K6M1YpBqQd8nCaMaio/huHjwExeX4Cjh6co7uS2+XrPB6HE5shQ3q
         d3G3Wp5mdy06XmSZRI0vkcuQTf/58gjLa0rbSrzYipJciggXK8eCscTXknV2gvYKHy05
         PVuw==
X-Forwarded-Encrypted: i=1; AJvYcCUJjs8tDckRN8gNrOON38JyxRKhRqHPHirrkYpMwOlUrBO6+nGB6fSR37UqwhSjVYMaWaMVBn+CZvxKEt5Oo+XwRNZJ2lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyujoHC6adX6ian7229wMVid0/Yyj8fCZKeMw8Wdi9e4AkmsrnZ
	Yh4AUDSpjH3d62W7MTvpJkvWPqC5IjevkfYae3EzsMBtmCXVce116uyqXnZcsn02atdQuPJtPhR
	N8vuv1/K/jS3Ko4udvc7M4GPTiNElEuLQE4m9e7ca
X-Gm-Gg: ASbGncvqqK7+RWWEO2NHM92B9bMkeKBoI7U+AHZL2dcJPGAwBzCI2egp5U+xRh+FAAi
	NWZ8nJBjCuM8UUZtAyFpLGiPMW6p0/1Rw+jQovjE1zQztXE7UXp4/PZr0pDD1dDryN/nr3A1OtW
	Bkp8zNLMNiPLP1+/R9WCajDBGo7vAgUKsnnUO2hZo3zgtqbDgkIoKnwhWS3xS6
X-Google-Smtp-Source: AGHT+IHZ9jFIvkL3s/WhGIrI4IThR5QXdM3cICdVMwLZGSJ4WKA5W38ar/Q+P8ZFLrgmTwdP5BUbeE+U40I1JEI8RSQ=
X-Received: by 2002:aa7:c392:0:b0:601:233a:4f4d with SMTP id
 4fb4d7f45d1cf-601233a4fc5mr3186a12.2.1747342415935; Thu, 15 May 2025 13:53:35
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-3-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-3-0a1329496c31@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 15 May 2025 22:53:00 +0200
X-Gm-Features: AX0GCFv4nrwtDZxOQKAFnOch8tVFv6sz1vCJIdy3HEL5SN0W7L19J7ev9XtxuAM
Message-ID: <CAG48ez00GnBZZDjpYBmccgztaW+0206_X8__UiFxtBQhm7rvhg@mail.gmail.com>
Subject: Re: [PATCH v7 3/9] coredump: reflow dump helpers a little
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 12:04=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> They look rather messy right now.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>
