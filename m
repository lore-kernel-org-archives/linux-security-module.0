Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B82213D26B
	for <linux-security-module@vger.kernel.org>; Wed, 17 Apr 2024 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713358183; cv=none; b=ZJvkAVSXDx9LhyJc7KYRLufydvP2IrSSFRJcFShV8O+AnQESd4Y++5cuKobY0UCKHQReVioi5iJ1vUVBeBQncvutk9IQpRjmqPYBw1hqR4Nbge7HVEa3II410H+qE6mIj0/o+fal/O+7Xi7ErfWKP1MkFcTyrbCQC5uow4X7FE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713358183; c=relaxed/simple;
	bh=nwBA9fPliEPsQs0H2xz5z6DNDnB+qdcQvcVKcxEpzE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2G09F0wSukaMxTDGEy4Knew4PlGbMeyVv/x6wepRoSDS+Cyvq3RmFZlb8d86E6qHe9TA0c3ZN1m1IaEn1ud8qYATfW7/o9roGWQQEeB8pPngDtcfSL09xx5b/RaLNwYiMxDaoFGJ02r0MeBs+xcTuDWZVMTTh4w6AP29t6sNko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JGCVCDwh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGCVCDwh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713358179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hODxA4owyQ+2NnCnCYYFM8Gpsichk4CYGfORzlIsbLA=;
	b=JGCVCDwhjZ+LA7ZqMu8ux1TL4FNQWftk6bxEWnD6rncRv4dAqkvsYSAIV74bOD94T1sS0Z
	qJaL1eBWyvZahitzgxRM9o8yYcjmILIcvg7gwRVk33qGfTPhWhKcAOZfYzy39o1IpLQuH5
	X0NcpxBLVMgF7BFMn98+Pr1DBb4JYJw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-bi76k_5zNWWmhCw0nJA6cA-1; Wed, 17 Apr 2024 08:49:36 -0400
X-MC-Unique: bi76k_5zNWWmhCw0nJA6cA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a537ab9d7eso5299263a91.1
        for <linux-security-module@vger.kernel.org>; Wed, 17 Apr 2024 05:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713358174; x=1713962974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hODxA4owyQ+2NnCnCYYFM8Gpsichk4CYGfORzlIsbLA=;
        b=dztHYerrEsZeNg0Liujcq8xE5QStYi2gFR6D73tCS/JtStgec3Pb2LtDDrv9wMR5Kx
         R0uaiJ+29739PezeTzwMAzk9GEThkZBqe3JYlS1NoJ7FKI6mcLWx3LHxgc9upte7RXWX
         VOi84J0RePhD6Dd+XnSY+8D9qp/cT9LrmdTvJlZGXXTlXp2XUU8E33K+fGLbthkdCWR1
         WA2u9/gb5RM1gJ8PR8P4RNPwk6DTvCv31LUE97DBvsYCiA7M2PMH3oS3G6t4PoV0PWvK
         ftr6RnYQOvbKE+BUgIADZLoPeJmTP8YJoJIPPbV4iNi7wrZTyfOZj3QXmMdIMlt6ACm+
         Q2dA==
X-Forwarded-Encrypted: i=1; AJvYcCXtR2w1Qu2NTnjIO77GgFuJMPCfWuq6Flio6B7E5mBHECmUzvwHOBB2/UHIP+MTQuOkSF5Q7SthSWUOFprtZllpwAKd7E9Fok0ncSp4L+jHhao24vsd
X-Gm-Message-State: AOJu0YyH3bRQ2Ai2CeADSygdV7meFedvfYhbULFWr0SsnvfoGPpizfEp
	kk0pf5AquzjZYdywg4pb1921wLPspJNdd+d2AFyFV1f9cEfi+FabE3oZ9pJCgjlCkUNKzwnnYm8
	lTwHb6binxNIABtZ2XNMxxHXdCsWS16bFkHFXvyKE1KPf57QG0MhMld4f5Z3ep7XeI0EdOhc50v
	DNEuBKNU0FAHzh+Fjl74D61AQ6WVmV0N/bFykZAki5xq+9/pO7NT4A1lAY
X-Received: by 2002:a17:90a:df82:b0:2a2:8fb1:f89a with SMTP id p2-20020a17090adf8200b002a28fb1f89amr13749888pjv.11.1713358174617;
        Wed, 17 Apr 2024 05:49:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/kkJ5tWc7v3qi7zk3/D8RuOQIfyBSI1TjHKo+txD12wOnf1R7EH9uXfh0i4ZQPlwH1KEEcWo+zAaz5j+fdzU=
X-Received: by 2002:a17:90a:df82:b0:2a2:8fb1:f89a with SMTP id
 p2-20020a17090adf8200b002a28fb1f89amr13749872pjv.11.1713358174270; Wed, 17
 Apr 2024 05:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416152913.1527166-2-omosnace@redhat.com> <0a814ce3acdea2c07cef6f7c31008e19@paul-moore.com>
In-Reply-To: <0a814ce3acdea2c07cef6f7c31008e19@paul-moore.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Wed, 17 Apr 2024 14:49:23 +0200
Message-ID: <CAFqZXNvsumcLSKKRGzvUDmz=6WYfw3a0tG43juBjnUTdbfsDsw@mail.gmail.com>
Subject: Re: [PATCH 1/2] cipso: fix total option length computation
To: Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 8:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Apr 16, 2024 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > As evident from the definition of ip_options_get(), the IP option
> > IPOPT_END is used to pad the IP option data array, not IPOPT_NOP. Yet
> > the loop that walks the IP options to determine the total IP options
> > length in cipso_v4_delopt() doesn't take it into account.
> >
> > Fix it by recognizing the IPOPT_END value as the end of actual options.
> > Also add safety checks in case the options are invalid/corrupted.
> >
> > Fixes: 014ab19a69c3 ("selinux: Set socket NetLabel based on connection =
endpoint")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  net/ipv4/cipso_ipv4.c | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> > index 8b17d83e5fde4..75b5e3c35f9bf 100644
> > --- a/net/ipv4/cipso_ipv4.c
> > +++ b/net/ipv4/cipso_ipv4.c
> > @@ -2012,12 +2012,21 @@ static int cipso_v4_delopt(struct ip_options_rc=
u __rcu **opt_ptr)
> >                * from there we can determine the new total option lengt=
h */
> >               iter =3D 0;
> >               optlen_new =3D 0;
> > -             while (iter < opt->opt.optlen)
> > -                     if (opt->opt.__data[iter] !=3D IPOPT_NOP) {
> > -                             iter +=3D opt->opt.__data[iter + 1];
> > -                             optlen_new =3D iter;
> > -                     } else
> > +             while (iter < opt->opt.optlen) {
> > +                     if (opt->opt.__data[iter] =3D=3D IPOPT_END) {
> > +                             break;
> > +                     } else if (opt->opt.__data[iter] =3D=3D IPOPT_NOP=
) {
> >                               iter++;
> > +                     } else {
> > +                             if (WARN_ON(opt->opt.__data[iter + 1] < 2=
))
> > +                                     iter +=3D 2;
> > +                             else
> > +                                     iter +=3D opt->opt.__data[iter + =
1];
> > +                             optlen_new =3D iter;
>
> I worry that WARN_ON(), especially in conjunction with the one below,
> could generate a lot of noise on the console and system logs, let's
> be a bit more selective about what we check and report on.  Presumably
> the options have already gone through a basic sanity check so there
> shouldn't be anything too scary in there.
>
>   if (opt =3D=3D IPOPT_END) {
>     /* ... */
>   } else if (opt =3D=3D IPOPT_NOP) {
>     /* ... */
>   } else {
>     iter +=3D opt[iter + 1];
>     optlen_new =3D iter;
>   }

How about turning it to WARN_ON_ONCE() instead? It's actually the
better choice in this case (alerts to a possible kernel bug, not to an
event that would need to be logged every time), I just used WARN_ON()
instinctively and didn't think of the _ONCE variant.

>
> > +                     }
> > +             }
> > +             if (WARN_ON(optlen_new > opt->opt.optlen))
> > +                     optlen_new =3D opt->opt.optlen;
>
> This is also probably not really necessary, but it bothers me less.

I would convert this one to WARN_ON_ONCE() as well, or drop both if
you still don't like either of them to be there.

>
> >               hdr_delta =3D opt->opt.optlen;
> >               opt->opt.optlen =3D (optlen_new + 3) & ~3;
> >               hdr_delta -=3D opt->opt.optlen;
> > --
> > 2.44.0
>
> --
> paul-moore.com
>

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

