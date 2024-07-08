Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090C98172D
	for <linux-security-module@vger.kernel.org>; Mon,  8 Jul 2024 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720443137; cv=none; b=FlnfhKcCVp5gz8Dwb1f7x0lEDXUcbyp2asxymk7S0W2vlCoH0a3AI29Hfgv2IqGnhZns3UFB1NHi2EdE+aT4el74nM4fszuGLACmKc4TUTI8W+lvrlLhksLtdQlELJHAQPM4Z84ENZcxC+6/HckKFMhJqfzLYzfC16sr6NaaZiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720443137; c=relaxed/simple;
	bh=GKaxPMeQCGwz0xGt/xe9JtjyKYlBVSwbj5uPlZY2E+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppXQJJyksEhajNb8vJRFnFte81VYPAzgj1xjxPeIJ0nmF3Fe+bJwEka/NFNVNvcQkmadisIzfaH1Of8q7cSDAaPD0KTCUHboQf3hPCKqcOgb+EXL7Uz2IgbjxnDKkc1xkbudqCI2kupIClh7yTWHbGwv1XjeyEVZV66J4ORyvyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cngZK1Xm; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cngZK1Xm"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-64b417e1511so36012207b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 08 Jul 2024 05:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720443135; x=1721047935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWQFkOE0z0Ym6Txw+ydgQQZdK+TeJwfjOMSz/3B528I=;
        b=cngZK1XmagyQSQcXPsE+zOY7o9ipn8xqhyih/A+56BXmdM72slgqGoXc7kuWosiS9V
         gx1QWLaXc8KnjPtBvOOKVXu4FY6ZO6nuGwvI/0rAt6Sj6d6TQpynTC1uH1Wb3G1po/Pb
         kW26pum9b5dodtbo63ELzAkQ78ih+WslGMAyTizJFN9vKG4LCyYm0lsaMMs5Os6owNUv
         YoCUCl0txqXsP1GD7IRY2fFK5IfJ6lOYVhD04l1Ood2x1CoLqOai3+HguSvpt7FLiKdc
         c0mXT3XjqQrzLGlkcNPN9tWQ+0YUzdqsrpPP3Yp866B3cw2OFllT0SPs8rwkS9sPLZe5
         aK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720443135; x=1721047935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWQFkOE0z0Ym6Txw+ydgQQZdK+TeJwfjOMSz/3B528I=;
        b=DwUjPCippGC8PHWp/3QmwFRVCuOuU3XzD65IfpL116alCcm9I+FKg/SA8zgYwyFkO1
         vvr3YTMCBMnKj9HARtzDF6aTgJY5mYA38GXRsPnC21uC8CE7JCWPfLci6T9/4XcC0lho
         RBU+7X67Juw+/Lf6iR1W1nNrkgr/0v8K7U/bpPCl40G0R8Z+oAQ20XmNIOYIpDEKHNDi
         5l2DG5Ld7MW4zq/BNfpf8WgMGif+8B7akHY+yN7/cjADPRre63nB7WwGDJWX2RgFp7cB
         G74wdq8woW+lKULs7glOMGMoYIGZJQ0tk1ZRtxRTvYvdde9pRsG/qfB0Tgv+FTExVmrT
         fu9A==
X-Gm-Message-State: AOJu0Yx4WHpfLq40fzyOs0eCHD/YJa5RmH4G7PNh+v5BX6CVccauF7tl
	R3kThRBqg/KJGqefRBRIx1sVBkOf7JJgnPpJKMIbCn3tRXoHINOm2iJsD6NNYr0BsfPiafhdrtD
	5EkRxf5HJR23OCf1LuzwCAp+UgsLwdlevyNyM
X-Google-Smtp-Source: AGHT+IG8zzbRg4bwkTys4DhYJPBGGaNK8oeWdV1kR+CQ9qZu8soabHqXFh7VGeTZX0rBfmAwmZ4oYhgYUUAPDTy/hQA=
X-Received: by 2002:a05:690c:a9e:b0:651:79ee:d14b with SMTP id
 00721157ae682-652d62e4aafmr145100107b3.29.1720443134920; Mon, 08 Jul 2024
 05:52:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629084331.3807368-4-kpsingh@kernel.org> <ce279e1f9a4e4226e7a87a7e2440fbe4@paul-moore.com>
 <CACYkzJ60tmZEe3=T-yU3dF2x757_BYUxb_MQRm6tTp8Nj2A9KA@mail.gmail.com>
 <CAHC9VhQ4qH-rtTpvCTpO5aNbFV4epJr5Xaj=TJ86_Y_Z3v-uyw@mail.gmail.com>
 <CACYkzJ4kwrsDwD2k5ywn78j7CcvufgJJuZQ4Wpz8upL9pAsuZw@mail.gmail.com>
 <CAHC9VhRoMpmHEVi5K+BmKLLEkcAd6Qvf+CdSdBdLOx4LUSsgKQ@mail.gmail.com>
 <CACYkzJ6mWFRsdtRXSnaEZbnYR9w85MfmMJ3i76WEz+af=_QnLg@mail.gmail.com>
 <CAHC9VhRA0hX-Nx20CK+yV276d7nooMmR+Q5OBNOy5fces4q9Bw@mail.gmail.com>
 <CACYkzJ6jADoGNuPP3-1wkk-kV7NOQh+eFkU5KEDEZgq9qNNEfg@mail.gmail.com>
 <CAHC9VhQQkWxMT3KguOOK7W8cbY-cdeYTJSuh=tSDV4jsqp6s6g@mail.gmail.com> <CACYkzJ5gAnbXX_aWy6952s2O5L2p3Mw14OUfo9Z-Od6_Dp2HLQ@mail.gmail.com>
In-Reply-To: <CACYkzJ5gAnbXX_aWy6952s2O5L2p3Mw14OUfo9Z-Od6_Dp2HLQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 8 Jul 2024 08:52:03 -0400
Message-ID: <CAHC9VhQ+KkqTZdvo0cT6-F1fJaG3QgBEnMQqHkiN-GToH37BuA@mail.gmail.com>
Subject: Re: [PATCH v13 3/5] security: Replace indirect LSM hook calls with
 static calls
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 6:04=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote:
> On Sat, Jul 6, 2024 at 6:40=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Fri, Jul 5, 2024 at 3:34=E2=80=AFPM KP Singh <kpsingh@kernel.org> wr=
ote:
> > > On Fri, Jul 5, 2024 at 8:07=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > > On Wed, Jul 3, 2024 at 7:08=E2=80=AFPM KP Singh <kpsingh@kernel.org=
> wrote:
>
> [...]
>
> > >
> > > Paul, I am talking about eliminating a class of bugs, but you don't
> > > seem to get the point and you are fixated on the very instance of thi=
s
> > > bug class.
> >
> > I do understand that you are trying to eliminate a class of bugs, the
> > point I'm trying to make is that I believe we have addressed that
> > already with the patches I've previously cited.
>
> The class I am referring to is useless hooks returning a default value
> and imposing a denial / enforcement when they are not supposed to.

If a LSM hook's default value were to result in an undesirable
behavior within the kernel that would be an issue regardless of what
LSMs were involved and we would either need to modify the hook and/or
the default value.  I am not convinced that we can adequately solve
this entire class of problems simply by allowing one LSM, or even
arbitrary combinations of LSMs, to disable or otherwise disconnect
themselves from the framework.

> > As the BPF maintainer you are always free to do whatever you like
> > within the scope of the LSM you maintain so long as it does not touch
> > or otherwise impact any of the other LSMs or the LSM framework.  If
> > you do affect the other LSMs, or the LSM framework, you need to get an
> > ACK from the associated maintainer.  That's pretty much how Linux
> > kernel development works.
>
> Okay, then let's not make an LSM API, I will handle it within the BPF LSM=
.
>
> The patch I proposed should not affect any other LSMs and is self
> contained within BPF LSM:
>
> https://lore.kernel.org/bpf/CACYkzJ6jADoGNuPP3-1wkk-kV7NOQh+eFkU5KEDEZgq9=
qNNEfg@mail.gmail.com/

The code changes may be self-contained within the BPF LSM, but it does
appear that the bpf_lsm_toggle_hook() function directly manipulates
the LSM framework hook state which is not something we want to allow -
none of the individual LSMs should be directly manipulating the LSM
hook state/configuration.  Although perhaps I'm missing or not
factoring in some context around the patch linked above and that isn't
the case?

While I had issues with Kees' comments, at a high level his suggestion
of dropping the last patch and moving forward is something you should
consider as I don't see this a good path forward with all of the
approaches that have been discussed thus far.

--=20
paul-moore.com
