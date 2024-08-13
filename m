Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AD743155
	for <linux-security-module@vger.kernel.org>; Tue, 13 Aug 2024 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573298; cv=none; b=m4VlvN3zWrjnoz2ipjwR8N2HxwQcX88blYb+U3bwmUaIeJnqSVdSyBMSLmMmoHh7rTMu5kvzusNGRnoLlSukiBS8zRhsp2KUKcxxdTlXVDY9oPbX4pD5NlA7XEZ7Lzx8gPpvX65nmlhsva4j8BXuQyJYuus6RoghI0OfnDWvIrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573298; c=relaxed/simple;
	bh=edqtHeHV33yy55IQpb6RjSwy85ICUO5/ICExTZhuF94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlcVQnfEm4gd100OPyhYD90ZuG8dnJHy+PLjnwV7a+4IEUeFDJNK3neyhCBIxIgjmRLHTiP70eI3iPVtLOrkrN2WtGAq6tzrTCkfkUgJNZWUET1mxUd3nznou7bNyL5PafAYFUqIgduITvtPRIrvGCef9m2vEwzbj4wLgTLZHLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JVLnhzHV; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JVLnhzHV"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e1142cae21eso1166826276.2
        for <linux-security-module@vger.kernel.org>; Tue, 13 Aug 2024 11:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723573295; x=1724178095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vIS6qvkd549QuQAxkwdOfwsQhqVYcwCUbZikjqjGEU=;
        b=JVLnhzHVRVqwjVFOpwAcNYtKVywMqHg0abkP8ufNr70tS+ivzIXDWfys+1J7EVRWsh
         EZSySHEEFTPJPBtqodOCWpdMCm0lkfYpEeyUIzPai9YhQBDQSbDRgZj70JxPhMxLtrkK
         rUmyNh/uDkayBsY5aTixaFdZTn+XmMgbeefmwiZdxDafjuJK7AmGJ8YFGvd2HKx8NDW0
         c0l+JHp8GBUHyhv6eefw9KQqTHWjXhH8LcB+4jjiMiWsos8wm6gDkDh2Xogb+9H81vXf
         /w9UvyW7ERcrchWvDMCLYHvQaJDNcIP9hoYFcGo4hdj0FLqunywagtzB4+2ju2M+kdGv
         ISNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723573295; x=1724178095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vIS6qvkd549QuQAxkwdOfwsQhqVYcwCUbZikjqjGEU=;
        b=o5cqvQDj/Gv7YQ/AZZJwSrTVBWmzz4YBQHii1CYF894Y9ca2n4r1Y99UVIWQfrFqym
         runGccoy/hkZ56fneR1Y0r5VDpigXkX0R457rDI6gdgW4FHORD0SIwFVyLk0BhL2UpEE
         rCpOhWtKqXTT7TlR9b4jtAQmCBpX3OfNd8wm7vtnv4/htTFU5MoWnJvx+iK9dQ5UHje+
         7Rct7hLPtW3Mnj542xvHNFfdYkaTQUlzfhZErgd2tI2BZSEyhdT9Rr++IjPEWD8CPmHn
         kivmA3Iohf2KczdeUBA6J6RwTM/mi2Xu6isD2QN2TdVXYP639E5rozopwOLAV7ljV7xg
         ayvA==
X-Forwarded-Encrypted: i=1; AJvYcCVkDcpxmdkFS2AscBiQoyn4azRc/Hf0auGBni5TmqMambKPIMwNeJ8NPL+w1PX//okWXJv8uR3Zmp5Ab19Cn7T2CN9o4ltiheNG/b0N29QxByND7aow
X-Gm-Message-State: AOJu0YyJdhH9Tm6FcCZYCI9MM+7DHzz1J6puw5R9b55yfPf4dEVoWn0T
	wJPka0y3DHLgYvbhYD0maimA9HdQBLdI0z3j4zusFKj/nADBAiMinwmbUHYpBJskkitp8LXhkFi
	TjxYqpglG22FFzrWVqd10UekD94j3pr/Se9QA
X-Google-Smtp-Source: AGHT+IFFVh9YGBEeKwHEfD3REmiUjn/lvIsvTfra5ng1tQZa2T4ufXv3eepyTv4FpUyqHLUi36PUxRZC6NyNbSXHyfA=
X-Received: by 2002:a05:6902:27c7:b0:e0b:28ce:6156 with SMTP id
 3f1490d57ef6-e1155bcfa6cmr351533276.55.1723573294857; Tue, 13 Aug 2024
 11:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com>
 <873b04da-7a1e-47b9-9cfd-81db5d76644d@roeck-us.net> <CAHC9VhTd0MKVXsZ7J_b_Mmr2vP+RMJtxzfsgpH1rZ_hoHY1D3A@mail.gmail.com>
 <779dfb7f-d690-432e-8461-b26935974ac6@roeck-us.net> <0673d2b2-ad78-46f4-93b2-73ea3acd70f7@roeck-us.net>
 <CACYkzJ63DRLtDy6DAsGhz8_mM1pUSaC-DjbCtTBtEMP0c-=yRg@mail.gmail.com>
 <d9fc949a-6945-4c41-83de-c3717d536c15@roeck-us.net> <CAHC9VhRGt-b8PmtR-hZwOWB1zfmuhfftoppjacqrjq60tm0mag@mail.gmail.com>
 <8061553f-6bfc-4ee6-a8f1-e3741cf5ae6c@roeck-us.net> <CAHC9VhSKzxknTgKQu6ODoyxhc3skcjh_h11wSQrEvWb_vP5Ziw@mail.gmail.com>
 <CACYkzJ6NuGQchRaj-QD_XzQWNT8c3zb0ZEBXWjzjAckQdNDCWw@mail.gmail.com>
 <CAHC9VhQjCHBii=CwMMnbs0hiiN-Dy49S+3gpDvaXp-YQyEHTGw@mail.gmail.com>
 <CACYkzJ7vC7OJWdgm6LbOL82eO=27cn7Gh8i6-HOp_A94-SU-gA@mail.gmail.com>
 <CAHC9VhQPHsqnNd2S_jDbWC3LcmXDG1EoaU_Cat8RoxJv3U=_Tg@mail.gmail.com>
 <CACYkzJ5J8K2D8xqT+CCrbvp57P=GbCB+XYXkAaKXojsFhuaWEw@mail.gmail.com>
 <b3c04f8a-b7e9-4dc7-849e-aeaed508b8cf@roeck-us.net> <CACYkzJ4eZWh2R_ZoeiNLLKFARWJOWo7Hkdp015fHEnmYLJaHGQ@mail.gmail.com>
In-Reply-To: <CACYkzJ4eZWh2R_ZoeiNLLKFARWJOWo7Hkdp015fHEnmYLJaHGQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 Aug 2024 14:21:23 -0400
Message-ID: <CAHC9VhT+6PV+2YMfJnYn8oEzvEFDRbF-KdQTg1++N5+PD=T6-w@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: KP Singh <kpsingh@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au, 
	peterz@infradead.org, ink@jurassic.park.msu.ru, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 11:56=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrot=
e:
> On Tue, Aug 13, 2024 at 6:08=E2=80=AFAM Guenter Roeck <linux@roeck-us.net=
> wrote:

...

> > A somewhat primitive alternate fix is:
> >
> > diff --git a/security/security.c b/security/security.c
> > index aa059d0cfc29..dea9736b2014 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -156,7 +156,7 @@ static __initdata struct lsm_info *exclusive;
> >    * and a trampoline (STATIC_CALL_TRAMP) which are used to call
> >    * __static_call_update when updating the static call.
> >    */
> > -struct lsm_static_calls_table static_calls_table __ro_after_init =3D {
> > +struct lsm_static_calls_table static_calls_table __ro_after_init __att=
ribute__((aligned(8))) =3D {
> >   #define INIT_LSM_STATIC_CALL(NUM, NAME)                              =
          \
>
> I think it's worth making it aligned at 8 byte, a much simpler fix
> than the arch change.

Agreed, although please make sure it is well commented about why the
alignment is important.  It sounds like that's already your plan, but
I just want to make sure we're clear on this :)

I'd also suggest using the __aligned() macro from
compiler_attributes.h instead of the long form
__attribute__((aligned(x))).

Further, while an alignment value of "8" is generally easy enough to
guess at, especially when Alpha is concerned, it might help to further
hint at the reason by using sizeof(u64), e.g.
`__aligned(sizeof(u64))`.

> Paul, I will rebase my series with these
> patches, better descriptions and post them later today.

Great, thanks.

--=20
paul-moore.com
