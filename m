Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B1E3AF668
	for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 22:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773182366; cv=pass; b=m9mfksP//zMnSTq6cjMYwLKJC48Pm1igGcDXLwOOUr19krgNMxLe8dvQQSMOtRVN7mewmqScZ9siVI99+mM/vwWg+EiE8dYRRUt/kBtezm8R3JlfyKRyin0EDDONXrsZwxerLCAGFx+Zd4op1lqZH9uX6MI9mQpjFMd97uZ6FOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773182366; c=relaxed/simple;
	bh=UK2S3nbtd7fjW6H8recpqCy0chW5jUnVIcKyUoUcVNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sehk3t5rJeg+9IxXOf3Ku4Ww4slZnhklpZb2qPxTyEILXUzIHT63PT5oktT7zHGGoKAO8h0LZAF1vu1XeDGgL5hwoycgv30p8ZfvOCfA/yNxAlg57fvTOluXkjk9Q7n0zpbqMAkxmQSouBRyXLgkNRe0wWwNyYXl4d7Fs0WyIVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=P7QRt8lD; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="P7QRt8lD"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2aae146b604so95563375ad.3
        for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 15:39:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773182364; cv=none;
        d=google.com; s=arc-20240605;
        b=Lj2jB7dj2y5PVuNzdzQeBCn2ka6mSMd1tGasWM+NbXjjjHUStrKeY6LOxyh9Zpb+OI
         XXdMxzwbtmL6k3UXTKMlOul93ylRuUQ2CSyms6aHA+RCwJ11Y6+/8OvwiDDPXXKH6ld8
         VNJinEaujluanXlRdrYoTAC+T62d753GvaA5GuK3mnp8UMkEJ70kGFzqy2AyoJnVCk2d
         511DHljjpJDiVL4FdbGwYBgxXl7xDx8SuFajdfprw4dhlnAYyAU6waN2VVXip/rPw4a4
         Wok/X++hyiSDKlgp1FGhrWeahjnYi1dU7q6CZlPU+pewnwnKC73Pcf9HM1lA4TzWe7gr
         R2bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hgZxL4dPG1JB+pwIvOvrwjtCO4ld6uZtto/CeKqDnV4=;
        fh=CiX0Fmfca6rL/sGrH99QMwVZz6Vzs5LKTDf8sPEhb2Q=;
        b=JRBcxeqdUh//hWIv2tA4vX/Bk/XVx7R7QWYHq0z491ElMIJqXpBACXY/4cMyi82nrZ
         SgZNX1KsWTSiWiUmzFziHHhMLTyBtay0Nvo6GLnrN6c+wGxsRYza19dGIjlA80raA4+u
         pEbUMkjeyzM8V4zd7wyTf8ofn2wqiD7NA+MkYtUqh2+RYURojmlwZ/vatcYiIrFO94xZ
         CPvqtLFtR9zlKOBIIvRhBx0+Qd4xpm9kvSRg2BhSqLfDM61jBQLw7X1TByasuWI6KpSk
         7+6UPg4xHVDyFhCdVTAFrWS1wLKgEn/o11Yyt0DXb1hkvSi6SIySSsDksR/SDoaovCsA
         9+QQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773182364; x=1773787164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgZxL4dPG1JB+pwIvOvrwjtCO4ld6uZtto/CeKqDnV4=;
        b=P7QRt8lDpDkuntUow9gPiq+yoTDDhrwnYnfdDNWA41Z/oK+VinxYp3A0NAWm0dNcrI
         nvQjj1tLybMADgjliODhp2B6Ijhk09cF/zjIimDX0MYehIEjU8TPYbp2fq1663esbNKK
         VdVrLP8KfmGhvMtmA3gyf6gtsTs33nAezbBBmfJGlUymV8CebuBofyPlhsSK6T8Eaddf
         FVrDvG0jbi+GyLD5GT+QvVFMtdi+mEeWzeF+9ulGOFwk4ua0qhrMr+qH3NTSYmcL9k8A
         JLPrB89OdohJ8YqmrEBAtQnfg9T+MFkkgrXdGIRIybWKpfdJaxamanW5JPJAxl9NeRif
         OP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773182364; x=1773787164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hgZxL4dPG1JB+pwIvOvrwjtCO4ld6uZtto/CeKqDnV4=;
        b=kKqmrHntT55oCqPtmKEC/0MDeyxf8B2LRiFwz7P0FXSsiEqJU5tSzulyLhuIFaFFuV
         MrkcAIVcpFUIE+vVM7IvZhK5sXoCGhO8scZBownv6uBEqkTqRRqHc6hmslRc6GXwkQsp
         E6bTTOE9dJ1lJREc7ZipNobWHjbPkYdzuyy7rU/IUvJYX2kwV7UlBa9RVDphEtHigToE
         x3G1DeBGw8vprUzxaGQxZ1VXsrTa+O0Y7OGfWOHP0TNwKU4k3SZGAtKBUr9MNCqf4wgK
         5mndIxPZI7EvcwKzR2jHCE15W/gMI8mHGF7Z50vZiaqLj/i4TXjsChNcbYC70ucg1dGm
         EzFg==
X-Forwarded-Encrypted: i=1; AJvYcCVskY9Tj/vdN2txeel4e4oQq/bdB1OPtckTPCk/i5BceOLKWDNyaP3TV3TJezRZRAbKq/HUoQibV+cFtiX+28Fw8HJUZV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHifTqWxJWRKVyqUpEiaSlD0BLg92o1pFA5ZkkU+nlTF6XgTYz
	MYXzYIisN5Rghli16wv45Pap5MTSdLXvlMJY0ioN/dNepMnBNg6V6jbOPSG/RZ2JkPGXTkswKOh
	M6tHj81G92dR93WZntiPkhsrxHe0C1Dw5TB6Zor6V
X-Gm-Gg: ATEYQzy0lHYet7dYbfu8BqB6W45Y6iZRJcHrDl/pE0mFNqC7hcr8TsrWlic46mvkPM5
	a72z5dBB40+9MJ8k+LooiYE4tuQw1BlglRm/+88zI8VW4wSauIyiREaIKwWuVEK6ceBZ53W/Ygm
	h5AromtoQfeVQo3KKeB/YJQpeLSDpXJFLwrpDcmIGsCr0zlHCQ3tcgxeMDat/Fgx9uP8jQdKE2B
	7eif0sLktkBh+ckcadXAgDFZkL4i6gsoeTTfquCZ9gsN9EST+MC/CVecYQeGKXmP2/uebvjtF6E
	FucoYnU=
X-Received: by 2002:a17:903:240d:b0:2ae:588a:f3e5 with SMTP id
 d9443c01a7336-2aeae85b2d8mr3734425ad.30.1773182364628; Tue, 10 Mar 2026
 15:39:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZcPd3OKqxwCZV-5@suesslenovo> <20260219200459.1474232-1-utilityemal77@gmail.com>
 <20260219.de5dc35ec231@gnoack.org>
In-Reply-To: <20260219.de5dc35ec231@gnoack.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 10 Mar 2026 18:39:12 -0400
X-Gm-Features: AaiRm53Bi5v2R8sq4eGVQOtisSif0YBDoTMZ_De5pzTOEuKPyyUhzh7ujbtadX0
Message-ID: <CAHC9VhSu=YtE0dMiEtUQgz0pFy5K8cuHh_EWprNtFTDAxhss_w@mail.gmail.com>
Subject: Re: [PATCH v6] lsm: Add LSM hook security_unix_find
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: Justin Suess <utilityemal77@gmail.com>, brauner@kernel.org, demiobenour@gmail.com, 
	fahimitahera@gmail.com, hi@alyssa.is, horms@kernel.org, 
	ivanov.mikhail1@huawei-partners.com, jannh@google.com, jmorris@namei.org, 
	john.johansen@canonical.com, konstantin.meskhidze@huawei.com, 
	linux-security-module@vger.kernel.org, m@maowtm.org, matthieu@buffet.re, 
	mic@digikod.net, netdev@vger.kernel.org, samasth.norway.ananda@oracle.com, 
	serge@hallyn.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 3:26=E2=80=AFPM G=C3=BCnther Noack <gnoack3000@gmai=
l.com> wrote:
> On Thu, Feb 19, 2026 at 03:04:59PM -0500, Justin Suess wrote:
> > Add a LSM hook security_unix_find.
> >
> > This hook is called to check the path of a named unix socket before a
> > connection is initiated. The peer socket may be inspected as well.
> >
> > Why existing hooks are unsuitable:
> >
> > Existing socket hooks, security_unix_stream_connect(),
> > security_unix_may_send(), and security_socket_connect() don't provide
> > TOCTOU-free / namespace independent access to the paths of sockets.
> >
> > (1) We cannot resolve the path from the struct sockaddr in existing hoo=
ks.
> > This requires another path lookup. A change in the path between the
> > two lookups will cause a TOCTOU bug.
> >
> > (2) We cannot use the struct path from the listening socket, because it
> > may be bound to a path in a different namespace than the caller,
> > resulting in a path that cannot be referenced at policy creation time.
> >
> > Cc: G=C3=BCnther Noack <gnoack3000@gmail.com>
> > Cc: Tingmao Wang <m@maowtm.org>
> > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > ---
> >  include/linux/lsm_hook_defs.h |  5 +++++
> >  include/linux/security.h      | 11 +++++++++++
> >  net/unix/af_unix.c            | 13 ++++++++++---
> >  security/security.c           | 20 ++++++++++++++++++++
> >  4 files changed, 46 insertions(+), 3 deletions(-)

...

> Reviewed-by: G=C3=BCnther Noack <gnoack3000@gmail.com>
>
> Thank you, this looks good. I'll include it in the next version of the
> Unix connect patch set again.

I'm looking for this patchset to review/ACK the new hook in context,
but I'm not seeing it in my inbox or lore.  Did I simply miss the
patchset or is it still a work in progress?  No worries if it hasn't
been posted yet, I just wanted to make sure I wasn't holding this up
any more than I already may have :)

--=20
paul-moore.com
