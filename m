Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A7A2231A
	for <linux-security-module@vger.kernel.org>; Sat, 30 Mar 2024 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711834783; cv=none; b=nwOgGl7r3yIMuISFv3aqTzdtSUdXkBIc74XqSRTVfCii10Edq5W5rgk2QeCmbBSlmXFZ7ep6zVl+JA/YqPH0Mvym0PdRJvzH1TduNHD6DiRyVB1yJfwZsjNfl2s0YhqJXoX8TZB1O9y4HfPOMbQNUi+XQ80XbUS745O74vYHlbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711834783; c=relaxed/simple;
	bh=DF/L0+Q5E9+KTQeS14VYcTiSfXzgyZHE5qV4GXYVLVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/bwcNN8GzOR1rmzEOr2oYinsqS3OLDVPY51qt04Mm01B4PhCnuxL8UrCDGjWEjoiTPfCdvWXlxrpyUh2o9ct1MLwJoN9QfSiW2AoB6o+J4JhAgv6K+0ygmtftvTJdHhO3RaLZ/q2tegIODAR5mMLvaPsW4FikCetcQe+7HsUQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KATUYlPX; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KATUYlPX"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61452c774e9so12606417b3.0
        for <linux-security-module@vger.kernel.org>; Sat, 30 Mar 2024 14:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711834780; x=1712439580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGWA0gwym6PRWQPU3SPN95r2Cy2WmqnySATlGVqX0IQ=;
        b=KATUYlPXmsAlLoU34HLNsLK1fAvQCGHDI9FuVQpNSXqLf+Qwo2akp57rJQ1IxIqZy8
         +LtG6cV750HgC2kYtwNcWMibLRsYo8Dyf1nb5JPtATqqYBvMeK3N+j2uTnbwUnzUOAOx
         196Yzpm97OqTdH4nGmVMRhCpw/qs09FFvd7Abpg93sTUBlsTjHRvs2dwZ9DxTb0xXC+o
         OZuGJ3rRiLewAuDYRs65vAWhuttu8LL9fboHAIJMQIUOyCaJu7DDRJQLjoSF50XnqcaJ
         pI+gk3eWGl2EkipTPZU52kkxpFW8kJ3y+KfnQ4brEgPc4VJnhGCPJF+VE6iCvTn0Jfm6
         9mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711834780; x=1712439580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGWA0gwym6PRWQPU3SPN95r2Cy2WmqnySATlGVqX0IQ=;
        b=dQ/lWSZfBupJrZsV7oFydfo+91w6dlrcvh+gEFc2TpJQBBkngrk8xUOWh8rrjbc7HE
         ZZongwkH+Rs9T78aDrhmCjhZ7WKvYFTaURQVJuyg7+PKAUZ3orQi/si51kd161IOSDj0
         bqYD4a609WzHgEQT0/XV8fpPKaA7gp67LnPWOkKkJPqYp2NyoGbhdvu1zFL1IeCbxsTO
         3x7YQN66YJE0d2mH+lF8UFDdyzZzBUKLC0umEbVCfMUDCJ+bwG304kKL6JO7IccQRIYI
         cq67qofEupdP3okvADPnp2Zz9xsKL4OGBx2tewBAOCReB3UVG4Zybu8JGzEUz/Kri0lr
         fprA==
X-Gm-Message-State: AOJu0YwZsLbkhjb3WyZ3/Tw1jJVNAYWl1tkIX627x7vtyd8dNL+0c6dl
	bAHnUrcH/XkY0APsHkb2tfbeUg82GS5MRH0nu+DL7De3NbUh4XAhQD/dAEsP2uxi2cbNXMix/Ec
	/KtpXX+H1AHHjDAFtluSZT3n9Wv2Lpn2JasuU
X-Google-Smtp-Source: AGHT+IGDR7sSsXYtGe+LeHaAVsSnqHcKvB5dfKxCnr8LKd3YMoaQWtkNixesi6Xsn/zjb3RSYA9G89IhSlmvu1V9vy8=
X-Received: by 2002:a81:4c86:0:b0:614:4f9e:5671 with SMTP id
 z128-20020a814c86000000b006144f9e5671mr4433014ywa.17.1711834779854; Sat, 30
 Mar 2024 14:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324223231.6249-1-greg@enjellic.com> <CAHC9VhQ22ef_o_OYue93RZfff70LPuOaCuN7Czv7HiEy346Svw@mail.gmail.com>
 <20240326103047.GA19964@wind.enjellic.com> <CAHC9VhQvN43LL-ynV-ZZgR2L8wFfUeq2-SZb5QHh9ZMWtz4C1A@mail.gmail.com>
 <20240327091644.GA32347@wind.enjellic.com> <CAHC9VhSjjeBH2CE5i+PK9Zyg661k-ryDbYkoPLtEe-g52DW0Fw@mail.gmail.com>
 <20240328153800.GA17524@wind.enjellic.com> <CAHC9VhTwZD7OU9v36HOd28a6jULLJeoQTdNSBYZWSrsY+jf7ZA@mail.gmail.com>
 <20240330144604.GA4625@wind.enjellic.com>
In-Reply-To: <20240330144604.GA4625@wind.enjellic.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 30 Mar 2024 17:39:28 -0400
Message-ID: <CAHC9VhRruSLET+aOhCt7WKucWNBE_qLCYV3won+p10XOjLLiHQ@mail.gmail.com>
Subject: Re: [PATCH] Do not require attributes for security_inode_init_security.
To: "Dr. Greg" <greg@enjellic.com>
Cc: linux-security-module@vger.kernel.org, roberto.sassu@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 10:46=E2=80=AFAM Dr. Greg <greg@enjellic.com> wrote=
:
> On Thu, Mar 28, 2024 at 08:26:11PM -0400, Paul Moore wrote:
> > On Thu, Mar 28, 2024 at 11:38???AM Dr. Greg <greg@enjellic.com> wrote:
> > >
> > > BPF provides an implementation and would be affected ...
>
> > Casey pretty much summed up my thoughts fairly well, including the
> > "Bear poking trimmed" comment, which was worth a good laugh :)
>
> Very good, we will take Casey's e-mail as the official position of the
> Linux security maintainers on the functionality under discussion and
> similar issues moving forward.

You're welcome to take whatever lessons you want from this thread,
that is your choice, but please understand that your interpretation of
this thread may not accurately reflect the opinions or policies,
either now or in the future, of the subsystem maintainers.  I
understand that developers/engineers like hard rules, it's reassuring
and comforting; I'm right there with you.  Unfortunately, the Linux
kernel is a bizarrely complex beast with changes happening on a
regular basis and in an often unpredictable way.  While I do attempt
to provide guidelines on certain things, e.g. new LSMs, new LSM hooks,
etc., ultimately decisions still boil down to the
wonderfully/frustratingly vague "maintainer's discretion".

In this thread, especially the last few messages, the only "position"
I would suggest one take as a lesson, is that the LSM developers don't
need to be told about the BPF LSM, or BPF in general, because we have
all be struggling (?) with the challenges it brings for many, many
years already.  That isn't to say the BPF LSM, or eBPF in general, is
a bad technology - you can definitely do some cool things with it -
but integrating it into the kernel, and determining the appropriate
boundaries between BPF code and the kernel internals, has been (and
continues to be) a struggle.  Simply dig through the archives and
you'll see more than a few threads on this subject.

--=20
paul-moore.com
