Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629A1302163
	for <linux-security-module@vger.kernel.org>; Wed,  7 Jan 2026 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767822857; cv=none; b=fHR1uYm2HUi3eY5fAOn8lOTxf3wCdE1Qi7AB9cIgbh65i7u0aIB6wW2W8DEQ34QQJ8sCethTHCX25B7/KSMKjjMVAwN1eZbiUSuXUQ/i7kRu2K+tIBPMM+9mVvJiqwI/+HIRr0tzTRm/iVT8CG9cllZwCZgxSpjGDSXbHsMF3os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767822857; c=relaxed/simple;
	bh=/MejwX65hDKfR53cfS2/woBJf8a6swBHRdIPDU/11ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8787sL1NTbf9d2QkPIyZz1oJBxGa8gdlmxCeR3Jo5RkY4bFzzShnl2ZN6HZAnynrEGpa8kyLDLB2JP1JaqbZM7Do1Yf7qICX+r7jr9InugEt8CNlO6kqQggUhXnoAAd7DrvS5H6tim4lBZ9bwpK8dJpNM6YzpwlxSgnDDAJ3xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZTcugHZU; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZTcugHZU"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34e90f7b49cso1645968a91.3
        for <linux-security-module@vger.kernel.org>; Wed, 07 Jan 2026 13:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1767822855; x=1768427655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glsfhtDUmyowawtGUoJCa771AHF+/UGGwRgXKhqc+y8=;
        b=ZTcugHZUC9ieAvB/Va+V/ITTY/Xwf6Lz0B1lrUMRZQ+KCemYKW4dX1K0896uVuW+W4
         e5i4ws1vBBt2uB3x4ymUPA3We4Q5yv8d9K/I8oD3FBg0EFuwCbmDwhq9yUmpyski7J1G
         /poj3Un56Ozsy0VCv7nuGcjU7q6AZ07jhWRPwM3SFCsyrzpaBLJmmGvNlzR8g2ErqhU4
         J9f9rSIpEkW8pICt1nch4RDsN3cGauucZ3/LFroj1BGMS0lNiBa+vaE67aaBLAyr6dud
         JYF2GHlJgclRhJmCwagfY9OJcliIbn3WK+RMzjm4kKncfQOf8GvxwImwolAtrFsk8cbv
         DkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767822855; x=1768427655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=glsfhtDUmyowawtGUoJCa771AHF+/UGGwRgXKhqc+y8=;
        b=e+Toh0RYP7gMJQ5A5HOj72qtYd1h/LnCmnPAehISEEGVesTL6BNbXRg7MH/EpT7DVI
         m2ML0rMUjnqH1mUOmgGHP/B/7MrR7yYSj8C08GDMHc/burRx6gYeWC+8qNaCFM2uWPgK
         KlKuhPcqDo5Xj9X4ok3hCW4/Hx3yP8QUcXnnZwpeARc/O8pE5M9u5LFYw4/BswqruKAM
         hMJjNZyZugfdHoFvktXD4tsGcTgeGXixwpJj7MBIjkL82CDEP9dAvQ9Kjep4wzVf57+3
         wOKCf24ZJSiCjjtMjMt4Pr+FA8RsFpTMhIP3efGQ5gUuvrnoJgoBY3m5vTK6Rcp029kg
         dVMw==
X-Forwarded-Encrypted: i=1; AJvYcCWlGeaMa0gzOwZhbrczcFjQviGJTKHqriwEiw59CCciykPQvfdu3AHS54JP2El8hAiCrBcAOJvLj0eMV+UrdXWzixiSIR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrR/HGfGaGy+lD+7vXbY3GB3axasxZWWcbJK/rfLUHOQsu/qEZ
	JUoethJJ5+IUmHqSqSNKCRfVBTUyr7IWctn1dBUz79eQBFZ9d+hASU08F8QvuZlEjYMmOqgZEtV
	LTvBRGlAlGOh5gg1nk7P5L6oQuEHuzM8dHmIXLVmc
X-Gm-Gg: AY/fxX4cTdldfBaMUntZuJJl+ltCsizT9n0xIDBGMV9p19IC9Swe+szTw4CbMFuCSUp
	euBt5gWQkCfmgfmqQHV1XCaVZB/pbZq2RPcOEeMY30LDQhe7juMIP5ao8QaejOEt1pOMD83gbYG
	gg6K6O/5xhguatLx/oU9uGhTU+TOPuKDG3jRvs8zNKV5u1dN7HLYPovyvuR/iuEq4Wo0brHUClZ
	D7k+Xp5fbrUw34AmBDmb9K3fObX8MJYpekNaXWfqcJ8e0o9fglPLyJBhN2HmsmcEBmBiNc=
X-Google-Smtp-Source: AGHT+IGmDa04TwAFrUVZIKE0bCmyIfgat7wJWWL+XRgau6V3p4p1z6v7uRzUa5yn29Rvvq5RrrPOJUM02YqDMGwe8b8=
X-Received: by 2002:a17:90b:1650:b0:340:d1b5:bfda with SMTP id
 98e67ed59e1d1-34f68c33781mr3244535a91.3.1767822854607; Wed, 07 Jan 2026
 13:54:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231213314.2979118-1-utilityemal77@gmail.com>
In-Reply-To: <20251231213314.2979118-1-utilityemal77@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Jan 2026 16:54:02 -0500
X-Gm-Features: AQt7F2qw6OaC4MXbk1CPG_jNqQef9CEQ0d5ZkvwF0tURdpz-_nm5g4KzXb8fLmg
Message-ID: <CAHC9VhQF26sVYoKxZ_7x2nL1HxuK0zeH013e8ugigz9B+Kpkjg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
To: Justin Suess <utilityemal77@gmail.com>
Cc: James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 4:33=E2=80=AFPM Justin Suess <utilityemal77@gmail.c=
om> wrote:
>
> Hi,
>
> This patch introduces a new LSM hook unix_path_connect.
>
> The idea for this patch and the hook came from G=C3=BCnther Noack, who
> is cc'd. Much credit to him for the idea and discussion.
>
> This patch is based on the lsm next branch.
>
> Motivation
> ---
>
> For AF_UNIX sockets bound to a filesystem path (aka named sockets), one
> identifying object from a policy perspective is the path passed to
> connect(2). However, this operation currently restricts LSMs that rely
> on VFS-based mediation, because the pathname resolved during connect()
> is not preserved in a form visible to existing hooks before connection
> establishment. As a result, LSMs such as Landlock cannot currently
> restrict connections to named UNIX domain sockets by their VFS path.
>
> This gap has been discussed previously (e.g. in the context of Landlock's
> path-based access controls). [1] [2]
>
> I've cc'd the netdev folks as well on this, as the placement of this hook=
 is
> important and in a core unix socket function.
>
> Design Choices
> ---
>
> The hook is called in net/unix/af_unix.c in the function unix_find_bsd().
>
> The hook takes a single parameter, a const struct path* to the named unix
> socket to which the connection is being established.
>
> The hook takes place after normal permissions checks, and after the
> inode is determined to be a socket. It however, takes place before
> the socket is actually connected to.
>
> If the hook returns non-zero it will do a put on the path, and return.
>
> References
> ---
>
> [1]: https://github.com/landlock-lsm/linux/issues/36#issue-2354007438
> [2]: https://lore.kernel.org/linux-security-module/cover.1767115163.git.m=
@maowtm.org/
>
> Kind Regards,
> Justin Suess
>
> Justin Suess (1):
>   lsm: Add hook unix_path_connect
>
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 ++++++
>  net/unix/af_unix.c            |  8 ++++++++
>  security/security.c           | 16 ++++++++++++++++
>  4 files changed, 31 insertions(+)

A couple of things related to the documentation aspects of this patch.
First, since this is just a single patch, and will need to be part of
a larger patchset to gain acceptance[1], please skip the cover letter
and ensure that the patch's description contains all the important
information.  Similarly, while it is fine to include references to
other sources of discussion in the patch's description, the links
should not replace a proper explanation of the patch.  Whenever you
are writing a patch description, imagine yourself ten years in the
future, on a plane with no/terrible network access, trying to debug an
issue and all you have for historical information is the git log.  I
promise you, it's not as outlandish as it might seem ;)

[1] See my other reply regarding new LSM hook guidance; this patch
will need to be part of a larger patchset that actually makes use of
this hook.

--=20
paul-moore.com
