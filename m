Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1D31F9A8B
	for <linux-security-module@vger.kernel.org>; Thu, 15 May 2025 20:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747342382; cv=none; b=n3lPfGxMC8OcVS047QimFzAZJNssPqtMB4WkFNpfW7Z1KnayHy5waMY+uWcGOiMQA+8IzuL3/zkEk09Rnbag0NDWEFhbDt7iUZ+xSBUlnwfsukmUiwzG+Sgo/FZ7im3cR87EPU3UwgxJ7ncBR641RHCu3JwHm+3b6OoPUSo3jT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747342382; c=relaxed/simple;
	bh=czi5+u2kEjArBpOgbOhFbSFaZ/a1SpCa/lwq2gvfT8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIuq9w6DTypLixASGpGWcGCnKepnP5Rhe7YU2glXM33SgzywArU+mifWeKax/5o/Pw6k+/gz7PUPnc0RoEoss58D4KgRUaeluqLu1Q7zDWb3lamB7xuJ1/Jt9MMi6XD8O1wZzUpxQ3rc0QFRwmyIUnWCHaKvLmasIOs8sUDQE8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e8zerxL+; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e8zerxL+"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5fab85c582fso3712a12.0
        for <linux-security-module@vger.kernel.org>; Thu, 15 May 2025 13:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747342379; x=1747947179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czi5+u2kEjArBpOgbOhFbSFaZ/a1SpCa/lwq2gvfT8c=;
        b=e8zerxL+wnR+j4tazWO2tN19dxkVVHq0ygT4AY4rUUiU7kSO3wLtgzkg3q3cmv2YTa
         vZfFierl81popnMsW80aNLb7U2Afe2GxeX7M+fSQdXk47M0NSRNru8MuznHwxifNxZQX
         0XEbNYFlWryCsSd+Lv6PC8V6RmJnt51yU35olEby9SMXawcuutLVxdSL3DAC9Dert6/2
         uiXZ83Ifso2wolN93HuEMnIOSzfr9Trv+66flzNib18fyYn8POs6Ffv+67f3wprwvxMs
         gvOSiIQyNZ2li7jqt/fH8nG+n+gmupBubWTyGD6m+IcHWxvk2pnspjdvNQ2eu3Btf4qA
         U4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747342379; x=1747947179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czi5+u2kEjArBpOgbOhFbSFaZ/a1SpCa/lwq2gvfT8c=;
        b=YSpNW///AlK4MC2I1Zj1OIt6mGnvnuN/l95/0BWp0hJ9DxpgWcPF+pkNqxszUHO0zF
         QbYJ+R6fjOYsatrp5SCxcoOlb2GI9BTyWcQ3nOCUmLPMyg3LGBFUTnjYAJ8UwAsoVlXf
         Oo4m8griXxfRSEpDwH1amFl1EtUZSsy8Pas/wOX6NimplEahrt8KFRwvcAZhdOFPpSCf
         MLa0Qfjqf2I3g/IFy1Q6FhHsTWEEkawUGS5Pxoy6fesuoyTnr4dTaEahCaYJgbsrxAIz
         t7CT6wM0NU2iBJp7wF8VMnKhW3T/brcXBNM1dio9F8mF2oR6Ut3DJDxErPMi67oCjYJ4
         1wew==
X-Forwarded-Encrypted: i=1; AJvYcCV9zcinw7KlwOaJxhzDhy0n2kRX3zY7pj+/ET8siTs6m4URno3rf5pJdh7L72BXHXyEcizKgMin6nNwz8cPwdnDx3Yax2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrO3mPwqEgqJ9Dk3T2qkCP2W8rAUjonZkW/F4ItrILAa1sJg79
	Ovr2hWHjRTZ1eyNfffzKafhR1tg9JpO7h9ON6J3Oa7+33klcalidhWywThczUJBvR9Ch1WK04D5
	qTwzCt0AoIIiYykpNxfNLGhxDWH26yTtNspFtnDKX
X-Gm-Gg: ASbGncv/k8nL1G4tGAxlAyLP/Isrm46vdkb/iYMV1YSjZJdAIfIAqYsGKSEr1VfOlSM
	naXZeCGzyxh11kPOUHkkD5oVHxpi3P5Tsp2UNdEF57Pegu9rCUfsoNNTz+ono3+UG8SldS+RYtw
	pm97ti3SW9GVl+Fm2hDDJLm8YbKE2gUPiIMVetvQBjceqiPld1UMTt3p57WUQr
X-Google-Smtp-Source: AGHT+IF2M8wfat+ypXS8t4pkU9r+Ie60fdxet+x1ExwrsKQgeSVE6SwmGNdqBwNHbwOcKqnaWIIoX1c/2Jgm5HmN7XI=
X-Received: by 2002:a05:6402:22b0:b0:5ff:f051:60f0 with SMTP id
 4fb4d7f45d1cf-5fff0516857mr119534a12.3.1747342378383; Thu, 15 May 2025
 13:52:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-4-0a1329496c31@kernel.org> <20250515170057.50816-1-kuniyu@amazon.com>
In-Reply-To: <20250515170057.50816-1-kuniyu@amazon.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 15 May 2025 22:52:22 +0200
X-Gm-Features: AX0GCFukZXeV2YnpYpWYUXI1kiBBOFCdeQQogQc1TbzHuyl2utiuGujZlMvm38g
Message-ID: <CAG48ez3fC902JU244d=0zzr39f+iXxQH0GZgJp0rs8pbu8ka4w@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] coredump: add coredump socket
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: brauner@kernel.org, alexander@mihalicyn.com, bluca@debian.org, 
	daan.j.demeyer@gmail.com, daniel@iogearbox.net, davem@davemloft.net, 
	david@readahead.eu, edumazet@google.com, horms@kernel.org, jack@suse.cz, 
	kuba@kernel.org, lennart@poettering.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	me@yhndnzj.com, netdev@vger.kernel.org, oleg@redhat.com, pabeni@redhat.com, 
	viro@zeniv.linux.org.uk, zbyszek@in.waw.pl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 7:01=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
> nit: please keep these in the reverse xmas tree order.
> https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ord=
ering-reverse-xmas-tree-rcs

Isn't that rule specific to things that go through the net tree?
