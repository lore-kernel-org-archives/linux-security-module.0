Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2264C2E8894
	for <linux-security-module@vger.kernel.org>; Wed,  9 Jul 2025 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074982; cv=none; b=qfnss0lvPdTtDjDiTper5Rg877dV1VBEprMsiiKFt0CDHtxHZEpMagwa3SDadPHr+VOGrqMpsg+8Jc5bXchG8tGamBG3Ft2huaQitAaXpblfjgsKeVn+1mkjlqIcVjP68py6OvbG9PCOGgBll04jRbwjX6/QRA6AGQgDdDN86F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074982; c=relaxed/simple;
	bh=p8u1I+TwDnZvr0r3AL4vw+eoMhlu7STVgxRUoFgI2GU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXqnPhwp5qprOOMzB5jgX3OsmLJcbZTMetEuCGGSPe2NA5ERc2wIAoY937zxMuaUEXMEfApTEbJBbQBoY+IOVbbaXEYDO11O/fgTmrgkyrQXTyzPEFmMQySaFwdjeSr1vYTsahHmzAB9K/M7Y5C0WaGoeDit4+liBo47NWc9wVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LOtOa/+5; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LOtOa/+5"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70e77831d68so410787b3.2
        for <linux-security-module@vger.kernel.org>; Wed, 09 Jul 2025 08:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1752074978; x=1752679778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qi9rgpEnLHZiafsUKLOufZyd7/6HZqWViU92Vja6Uog=;
        b=LOtOa/+5jQalS4WprVyD/D7ZtWnXDVRitYTzPWO8g9cHWF0lvePdNi/8503R092h9u
         /0YUzmWEwvxg/QWeFI8gkQyO/Mm91MVtPiEUrWv47tWCxLq5tm4BvD8cKJcPi2kByDv2
         6SPwTh1X4j7fARSI9Dx8mFZutxjtgiXj/3cb6RDTtBynA2zV/xmalQQewYeO4uykoNx+
         t1JGV1uVRVILLiVHqy++bzzewxxmUDX2V+FzxEbX0TQLajmQ6cL+7QCZ7j0/tmdWCLng
         Vkk4x/Mq2w8rX2oR7M16zKOagmjefPWZZBY7vzN64mZReLJvqABD+w+xMbjkClv4F7mg
         EKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752074978; x=1752679778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qi9rgpEnLHZiafsUKLOufZyd7/6HZqWViU92Vja6Uog=;
        b=hd8uJ6TQ2hodwbZXIYO+EHO03p8G1oAiq6LhjeaPjVF57A1FwlHF2Xg7H+p06kWzUg
         +xYfcIJzmuYDynJB5GnLogYnbo4/pCY7tjTwFtkwicz1kqpCxEaVbz1slC1ACoohPSGU
         HYG9vnuefPfBmq4SpftUgxeBtEOsVVpXzWLkK+rkrD3asllGe/X5QjymukRbh+qmE7Fn
         pjlDMkX0zp2FcVBTbOp4d++8xnTfsdKJGun2j7LvnAuAwcNuBLar2q0WSnKiCqcrwxbW
         t9pUPg+p5ShUOntluC7YtJIWrUcMMAAAieiYSmUiKjv+E7IV76LDVIYv6cTkAf/xSAnM
         mPqg==
X-Forwarded-Encrypted: i=1; AJvYcCXbfhtLvZ3jFyFP0GjfrAYAcd2K9wS2ThN/DzJjtRX/I3J4v7jVtV/de0bTPLoNMjGPnvIhUxPNgyj7MF4Bz2eHMfUqnD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvf+F3BdaFV3a5vgIlxXBrMO9R/MdRZvA4Icyj5ormKyih5KbF
	QGvemxxpuDYQ4z8lZArDOharP58IL/yZbkaU9/WYnbu3rUvbevIy7VrNt2//j0WXgqnRyLbUClg
	tIBoatDZtkbkDi1QBQw7p0V0N37gM3n7BZpA7Zf7H
X-Gm-Gg: ASbGnct7jjJWpm8gkn75c0rJkHHcnYfsMXLFLjf3B6HAhgKkQaQA4CXEZ5bIJsrK6Y7
	MwiYwfq1W90RAWckWU5Cks0PTHTaUEu7I75LiRynIB+7ur9niDpwTGvLlGYW4tpWBEOprMGAytp
	OjXkLJGZcqVwbSkOHBA6eh2N6Ig/F3DibBYYQ7Zu8E6ag=
X-Google-Smtp-Source: AGHT+IEd2P6zJ3kWghatDD3PuttWYXbQstUnXrNxhPW9V/XABSJDX4cZ3tvH6hXpPKypZE3XGkQDfVX5HjrqG3b1m4k=
X-Received: by 2002:a05:690c:6d04:b0:70e:731f:d4c7 with SMTP id
 00721157ae682-717b1b00f7fmr39534977b3.8.1752074978213; Wed, 09 Jul 2025
 08:29:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729180233.1114694-1-mic@digikod.net> <20241007.aek5Ohpahlai@digikod.net>
 <20250709.ZooYu6oasaiN@digikod.net>
In-Reply-To: <20250709.ZooYu6oasaiN@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Jul 2025 11:29:27 -0400
X-Gm-Features: Ac12FXyFIPyY3gbGpyuEASo18cXUllnIboPZdeX6_Di8-I0tjzRR9-qOUQiFx04
Message-ID: <CAHC9VhSZ7bfyKvUxmN+0P-XSN-FC6CH44PTKB5nj5mS32vRNHg@mail.gmail.com>
Subject: Re: [PATCH] tools/certs: Make print-cert-tbs-hash.sh compatible with
 recent OpenSSL
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, 
	Eric Snowberg <eric.snowberg@oracle.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Daniel Urbonas <t-durbonas@microsoft.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 9:20=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> I can take it but I'd like an Acked-by please.

%  openssl -v
OpenSSL 3.5.1 1 Jul 2025 (Library: OpenSSL 3.5.1 1 Jul 2025)

With Linus' current tree:
% ./print-cert-tbs-hash.sh ./LVFS-CA.pem
Could not open file or uri for loading certificate from -: No such file or =
direc
tory
tbs:e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855

With the patch below:
% ./print-cert-tbs-hash.sh ./LVFS-CA.pem
tbs:b11d0663606508a8510b760d68acb599f1911726f7c06c01df4d122fce8b957b

Tested-by: Paul Moore <paul@paul-moore.com>

> On Mon, Oct 07, 2024 at 08:42:16PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > Could someone please take this patch?
> >
> > On Mon, Jul 29, 2024 at 08:02:32PM +0200, Micka=C3=ABl Sala=C3=BCn wrot=
e:
> > > Recent OpenSSL versions (2 or 3) broke the "x509" argument parsing by
> > > not handling "-in -" (unlike OpenSSL 1.1):
> > >   Could not open file or uri for loading certificate from -: No such
> > >   file or directory
> > >
> > > Avoid this issue and still make this script work with older versions =
of
> > > OpenSSL by using implicit arguments instead.
> > >
> > > To hopefully make it more future-proof, apply the same simplification=
s
> > > for other OpenSSL commands.
> > >
> > > Cc: David Howells <dhowells@redhat.com>
> > > Cc: David Woodhouse <dwmw2@infradead.org>
> > > Cc: Eric Snowberg <eric.snowberg@oracle.com>
> > > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > > Reported-by: Daniel Urbonas <t-durbonas@microsoft.com>
> > > Fixes: 58d416351e6d ("tools/certs: Add print-cert-tbs-hash.sh")
> > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > ---
> > >  tools/certs/print-cert-tbs-hash.sh | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/certs/print-cert-tbs-hash.sh b/tools/certs/print-c=
ert-tbs-hash.sh
> > > index c93df5387ec9..22bdeec4d286 100755
> > > --- a/tools/certs/print-cert-tbs-hash.sh
> > > +++ b/tools/certs/print-cert-tbs-hash.sh
> > > @@ -54,7 +54,7 @@ RANGE_AND_DIGEST_RE=3D'
> > >  '
> > >
> > >  RANGE_AND_DIGEST=3D($(echo "${PEM}" | \
> > > -   openssl asn1parse -in - | \
> > > +   openssl asn1parse | \
> > >     sed -n -e "${RANGE_AND_DIGEST_RE}"))
> > >
> > >  if [ "${#RANGE_AND_DIGEST[@]}" !=3D 3 ]; then
> > > @@ -85,7 +85,7 @@ if [ -z "${DIGEST_MATCH}" ]; then
> > >  fi
> > >
> > >  echo "${PEM}" | \
> > > -   openssl x509 -in - -outform DER | \
> > > +   openssl x509 -outform DER | \
> > >     dd "bs=3D1" "skip=3D${OFFSET}" "count=3D${END}" "status=3Dnone" |=
 \
> > > -   openssl dgst "-${DIGEST_MATCH}" - | \
> > > +   openssl dgst "-${DIGEST_MATCH}" | \
> > >     awk '{printf "tbs:" $2}'
> > > --
> > > 2.45.2

--=20
paul-moore.com
