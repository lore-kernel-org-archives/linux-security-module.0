Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880F12F29
	for <linux-security-module@vger.kernel.org>; Mon,  1 Jul 2024 23:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877272; cv=none; b=Niaps3RSkgxqTNNNyi+LzTi1CFLt/Rbzx2XN6u2/RCsXLHeD9TxVJEAJpZPQ1G5QnTIKa8BcxP7xwamfcfC0WFi28SbgpqOCTkoXuy1chxJG0KCWuDl8qW9RWy8p7WcaPUY2FDQhj3v/oryiqF303GcJrFXIi26snysRfTX7xmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877272; c=relaxed/simple;
	bh=CgoTJpfM3Eaqb9b9tstTTdsvLHWdvVZJPceoVZ/lIxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QaIi8guKHIEHouWinBRB1zXxck8f1yusDXyUHa8PZCYDQSvox6pLmbmmEGJmG/8MNNuvm0cjciy4Deva5zNyU2LQVLgH3SWDcjLoyRDiBe64veLPt3qjZNDEaFo8rpuRVtpeaius7EhcEowmNsoVYM2t6fprViq4vLUBfq/exAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=giqerGV4; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="giqerGV4"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e0360f890a1so2602934276.0
        for <linux-security-module@vger.kernel.org>; Mon, 01 Jul 2024 16:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719877269; x=1720482069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ql1LylJQbz5AqF02VyghAmPHhBmm+I/CxB5gAOiOtG0=;
        b=giqerGV4DRRuwFPvN6Xrg9BgUdFji2MMj5Dij9liQWHDD+UdN7NnE7+ZR3jOf+7iCr
         gfZLcQktp+Oj2ikTU6ahGw3g2BNjlt3anXc20tn2oC39tNn1TymcXZOUW4cb6HyOp+oo
         XaT4yOn35rOvJwm4PgVWQVX/3Dty9N/F2XDpX/WFSxhxPy915splFSHsv/pjNf8RgGeO
         aczV0HE4Ky/cnz8lbyOkkizwsym1Hd/GiUzKhyipkiYyAUQy22Y4xKoSZYmCRDSYcnY/
         cDH2dYgPZfqtFUwcTZWIlP8G+4qr+/F3cugHhx35a4zCFLd5XngisbDEN6+ooNx3rMRi
         YaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719877269; x=1720482069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ql1LylJQbz5AqF02VyghAmPHhBmm+I/CxB5gAOiOtG0=;
        b=Ogx78/i86eIenp0AHCXcYOKcWNOizwLeBwzzKAOTRi+6haubC8Nn9lsosskBlBQv5r
         5t4POuFwlRZPXER/3njY7W+cb9JNr/Uubo98qnv/WcBJaT6ZmnrLA3UZqysz5DvlZCdF
         dDOzBbbJAvOsOmcST761mVCO4oK0Mq5jBnFnGANFZatPyKfdN0ZZr0i2gkGxKjwG0V7B
         pPwgW5WBlQ4OzwEG8hyYLV4BxrTZCyb4UYc5LO/yO3aqKpf3biZTZrys4LUOvEcHOzI8
         Q/CFRF8aB9KqxuRnda8pIWDQld6+UfyYYcUhoIrIsL1YB1kz8qG0Lh4Zhk8NL7xY/dL2
         gIag==
X-Gm-Message-State: AOJu0YxfihA3D1iaxkggS2B4ZsEX0Roz/NI+TCqkG6vcXgMYEDwLpnWQ
	OfJkuBA3fYGIgyeSDGCXKm/FCPeNGUOr6xEcTCUJDm06MQUmBbf9maP1LkTAFf8ue/ZQHgELGz3
	lZWw6CXqAENiGTlrP38NRJkdLKhTBu7tN2WOi
X-Google-Smtp-Source: AGHT+IHtDYzMOZDam+ECIMAw43vgsX26d3AvzRHQKMU8Wr/2vGxwFWto9PP9Wduno94h2/m8Ochn48+TWWWjPOg+GJ4=
X-Received: by 2002:a81:83d0:0:b0:64b:1eb2:3dd4 with SMTP id
 00721157ae682-64c6cabc43fmr49699387b3.8.1719877269534; Mon, 01 Jul 2024
 16:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516003524.143243-6-kpsingh@kernel.org> <03c6f35485d622d8121fa0d7a7e3d0b2@paul-moore.com>
 <CACYkzJ6hBdk0MEW+4-U3zprEY4a_JcOLYj0wFEz1KW2gBDDE_Q@mail.gmail.com>
In-Reply-To: <CACYkzJ6hBdk0MEW+4-U3zprEY4a_JcOLYj0wFEz1KW2gBDDE_Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 1 Jul 2024 19:40:58 -0400
Message-ID: <CAHC9VhS_5d-CsTVTQCSZ3W151hGhNC+AZf=jRqfheKtZ+J4xOg@mail.gmail.com>
Subject: Re: [PATCH v12 5/5] bpf: Only enable BPF LSM hooks when an LSM
 program is attached
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 4:13=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote=
:
> On Tue, Jun 11, 2024 at 6:35=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > On May 15, 2024 KP Singh <kpsingh@kernel.org> wrote:
> > >
>
> [...]
>
> > > +/**
> > > + * security_toggle_hook - Toggle the state of the LSM hook.
> > > + * @hook_addr: The address of the hook to be toggled.
> > > + * @state: Whether to enable for disable the hook.
> > > + *
> > > + * Returns 0 on success, -EINVAL if the address is not found.
> > > + */
> > > +int security_toggle_hook(void *hook_addr, bool state)
> > > +{
> > > +     struct lsm_static_call *scalls =3D ((void *)&static_calls_table=
);
> >
> > GCC (v14.1.1 if that matters) is complaining about casting randomized
> > structs.  Looking quickly at the two structs, lsm_static_call and
> > lsm_static_calls_table, I suspect the cast is harmless even if the
> > randstruct case, but I would like to see some sort of fix for this so
> > I don't get spammed by GCC every time I do a build.  On the other hand,
> > if this cast really is a problem in the randstruct case we obviously
> > need to fix that.
> >
>
> The cast is not a problem with rand struct, we are iterating through a
> 2 dimensional array and it does not matter in which order we iterate
> the first dimension.

That was my suspicion when I looked at it quickly after the gcc
complained, but if nothing else the compiler splat needed to be
resolved.  Based on your comment it looks like you've fixed that in
v13, that's good.  Please make sure to test with both gcc and clang in
the future.

In an effort to avoid the "merge this now!" shouts and any other
attempted maintainer manipulations using Linus' email as
justification, I want to make it clear that the earliest the v13 would
possibly be merged is after the upcoming merge window.  See the
"Kernel Source Branches and Development Process" in the LSM guidance
document below:

https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/tree/README=
.md

--=20
paul-moore.com
