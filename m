Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF7E1E7C10
	for <linux-security-module@vger.kernel.org>; Wed, 23 Oct 2024 21:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729718491; cv=none; b=bpoNALR2OGyAG0kUiuwftcCMjQB1/X6vIzIXVtYtFLXN6xkGuWs5a0kPc+2CfwwZt6j6DWeGnJBARnSS3aHKp40Pfyv9kwSfJqDJyWpOrKsIvH+hD7eI7xRtwcv+PEaAaiGOjE1yjlk6GYOW/DywTeBQMcedquZf3eR5c0xCfPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729718491; c=relaxed/simple;
	bh=JRcAZKD+I8w8/3Fv7UE0rYpbqBIZNz+DntRIdFr9Uug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGzd/a0YK2ub/tjMWsTX7AGasH4gJelBzp8YLZuIyi7UhSTTC64EeGmx6CfdSKFLPtHglTrdgbQxqp3W6ED7myaSrLrWfXyGhM0zH7vHqksmHoSfQwrKDC9MTxM8oRG9Xfx1rYPxEbv5PnKWULqBqfCDh3HedbjBykx5D4IBWIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Az9ZJHMD; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Az9ZJHMD"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e290d48d3f7so274030276.3
        for <linux-security-module@vger.kernel.org>; Wed, 23 Oct 2024 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729718488; x=1730323288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72UVV+2r/h+iMp+5rXpOpE6KXuW+xAaVxADIUv6H0bw=;
        b=Az9ZJHMDjx52BwG8wFgOp/yyL4lASo8V9rnNDxIJVq15kJqQPTkJljszNn6C/iv4C0
         PGIyNmESB7ck99dQ9UC5/BTHCJIMO1MwqFZ+YaNPGFXdjROSp079kSEp95r9N6bNrHzL
         dQjgVFPXSJLzuU+EasB57DwkccOkvhDCPCUrLq1iw3RNK1IDC5cp2rnHlJkPYAIMvQ/B
         YpVjhNinRok7OiHTszM+6KTjRlYm5UsYNVR0w8CxkYkaGqgCXHtZuTaB+CIf7U4EhIzc
         yjiau7UMt65P+Lor8w00HGraorygK9m63TgbvruT/h3h/GRi/d4LfU8B1TKmpM5uDTxB
         0lqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729718488; x=1730323288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72UVV+2r/h+iMp+5rXpOpE6KXuW+xAaVxADIUv6H0bw=;
        b=tAj3JQziLavukMuQBho4vz8vsKPJu64CB4qmjD4JPpsnEfYgZGwJIrvvYqKGrYcyvk
         uBZR4K+Hax1p+iEF0e0+BBzLwmOli3xV5DLFtpCcAWbkBMlVvnL4lDNc3R0hwLNhff6P
         gDD392WS97u1+YalXT8e/ptDxBl0oaf0vspD+OQmBqHpOjLOB0FoVGmtJlqqnLOGw7uW
         iJlqLimFhSSvDkUOSEiQdk9wb4rAOLF6ol6FfudUhIaTYpqjv8y8N/DMlvxapNoFs/jY
         PvsZglBMfhk2CplnZ14idX/BL+VjvuQ2FNLBSNlh2Nq2XyqgUb8C2UoZNvT4amKbDXxE
         q/+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkGh6flRhDZy1Hxm5qmBCANeX2LMLd75Ds9nZWyPipf4rDj9GNBWhd++uiH1LgnUkY+kUr/BCvWxAIoCwZM9i9wHiNbEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxafEuc/eaGArWg7EfkJrpUaaGfDBHAqMSo7KbgWkpe+EXQkLby
	hjz+At8mPOaDedw3+7jp/M71itXzUY0Kit9vFRRQntzCOv4y0cUfOPpxt0lU2fgqd8ilsqh6Wme
	cZ/Gr+bwOmtuwNqqDO/iXbNviMHlkZbHWf0Y9
X-Google-Smtp-Source: AGHT+IFBbjED2EqikbdKhShjtfVb5PRKFRyT8EjmGDbN4ros8SSqreVtmvDbJs34rwQZ69DrleLNnaVEWKWJEe87q7c=
X-Received: by 2002:a05:6902:98f:b0:e20:2245:6f9c with SMTP id
 3f1490d57ef6-e2e3a65ebc3mr4443602276.26.1729718488086; Wed, 23 Oct 2024
 14:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022161009.982584-1-mic@digikod.net> <20241022161009.982584-2-mic@digikod.net>
 <7751320f-cad0-477a-bed0-923dadfcf1cd@roeck-us.net>
In-Reply-To: <7751320f-cad0-477a-bed0-923dadfcf1cd@roeck-us.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 23 Oct 2024 17:21:16 -0400
Message-ID: <CAHC9VhTH5FNnkZwOSZzRfE5jJTo=tHqvrcb11MwmJzQvquV8JQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/14] lsm: Only build lsm_audit.c if CONFIG_AUDIT
 is set
To: Guenter Roeck <linux@roeck-us.net>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Eric Paris <eparis@redhat.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 2:51=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Tue, Oct 22, 2024 at 06:09:56PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > When CONFIG_AUDIT is set, its CONFIG_NET dependency is also set, and th=
e
> > dev_get_by_index and init_net symbols (used by dump_common_audit_data)
> > are found by the linker.  dump_common_audit_data() should then failed t=
o
> > build when CONFIG_NET is not set. However, because the compiler is
> > smart, it knows that audit_log_start() always return NULL when
> > !CONFIG_AUDIT, and it doesn't build the body of common_lsm_audit().  As
> > a side effect, dump_common_audit_data() is not built and the linker
> > doesn't error out because of missing symbols.
> >
> > Let's only build lsm_audit.o when CONFIG_AUDIT is set.
>
> CONFIG_AUDIT and CONFIG_SECURITY are independent of each other.
> With CONFIG_SECURITY=3Dn and CONFIG_AUDIT=3Dy, we now get:

Yes, unfortunately the error was seen during linux-next testing too.
I'm removing patch 1/14 from lsm/dev now.

> Error log:
> arm-linux-gnueabi-ld: security/lsm_audit.o: in function `audit_log_lsm_da=
ta':
> security/lsm_audit.c:417:(.text+0x5e4): undefined reference to `lockdown_=
reasons'
> arm-linux-gnueabi-ld: security/lsm_audit.c:417:(.text+0x5e8): undefined r=
eference to `lockdown_reasons'
> make[3]: *** [scripts/Makefile.vmlinux:78: vmlinux] Error 1
> make[2]: *** [Makefile:1178: vmlinux] Error 2
> make[1]: *** [Makefile:224: __sub-make] Error 2
> make: *** [Makefile:224: __sub-make] Error 2

--=20
paul-moore.com
