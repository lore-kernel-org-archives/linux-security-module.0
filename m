Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848E135949
	for <linux-security-module@vger.kernel.org>; Wed, 18 Dec 2024 21:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734557081; cv=none; b=OBaFewzuQFe68H/QQ8xO1EcfAbOIk9yqThsOFwMtBEubbOuu8StIMhabdNJLtChDfwsuOZpowNb+eBB/Mn0hTTQdX/UHnSMFqkgbxfWE1mMoIFF6iZlZKBtNlERaC8BnlYryk+9zT5bxlJR54BluTytd5vjzsepswZwYV7oLyWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734557081; c=relaxed/simple;
	bh=2hrHNssRry+Pfo+ilOcGpNa+7kA+mGTazY1xOwJ4rlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SwfMKgIwVDnH0UDyyQ8lPh/oTRkKX4xBhmhE/dbKjg1D/C+vrnvYdkTWLayAcSSAeAC2dFG/LMl5s1JqKbXNujSp2QctU+RtSwmOlbWoyTsaz3Wz+HMq47l8G97wlOIojZIMAKTWKYQXeOfhR1H285R6PIWUZPgze79pz5zv6jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cB0p0MnJ; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cB0p0MnJ"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e387ad7abdaso142224276.0
        for <linux-security-module@vger.kernel.org>; Wed, 18 Dec 2024 13:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734557078; x=1735161878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfbnqAEPpxJBS72R4SgoHjJAx+OMbOow1uBkiK8I1BQ=;
        b=cB0p0MnJj641svwuPYGu66a58oIyEINA7gQFNsOizghh8L9rcTvYC9Z9MXVZ2hKgyZ
         jNymn1bDhVTnoj5ytle/039ipceHQeWpXQ90jOqdVUqJZkgeFWSJXkgtI/psaI9Qft9T
         s/wqJ36xukzP9DeE9wgpKvu6hMhQRoSUkz4TOZGnIzd4KhFwQ7nxe27BU8pTVZzRZBOI
         EyvlAgEyY8iaVJ/Wbqx+F7VAoDuoxVJ7XN7nNMk6x7isycFX8uipOzgdSaIrctBz7Knv
         6SBQb/9QRQ4V3YSKMwi6rnDW08/skEuOg8IFDN1JWXjUly/oHECH72qfblWcSjWrg8SM
         nMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734557078; x=1735161878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfbnqAEPpxJBS72R4SgoHjJAx+OMbOow1uBkiK8I1BQ=;
        b=A7m/ueVd2E6b+I4iXB8deY578XoNJ7ncpkB7QHsVty+TtVklpoSoxV6oZY1sMHa/0P
         fHdlWPdW2YZ0dzvHBzUSy18ffp+vtvXL8ui6YUrh1H8uykUrbbaem6/D961r5bZkozt0
         nNi671oOjn8ekz/6HzWIWTr101skMDQm6hQ1Nd1ntg9aQNCvv8D2gBxfOPzQfzE8ImYu
         qJygxs88nRXYWfxJs272bIIh95AtvbnKDBM+NYzPRRmr7hl5EBbvJ6Qt4Cc27RT3A7El
         7T382ad4NgMbupTLA+mVYkvlfO8mjSKnDER5Oq2P2dls68xtxv+qUvKXrXzEcL1cLB8B
         uv1g==
X-Forwarded-Encrypted: i=1; AJvYcCVUudJ3JWBkxAztbH3epxuf4vptnFqKj6TeTHU3PFxt/UWYvPfsezzhS8ypz96JsX5gesILD0s5tIVo76FVS6ZNpodaGLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3onS+dPWsKNHbh/zx/qEROa09DBx0DiLP8FQ4Jsmq9sBvftBH
	7vcAgKgA6+ARe8o9Ai9YgmEscJz+bhzwZFVM05r42wTK+KAxfFC2XXHpjjYwZ0I8v7VOEshVE4g
	NTUHnG52aXtHd9bIoh6CvuL2Pk9IH2Qo8EUM1
X-Gm-Gg: ASbGncuCEEQSiz+GT95aHPP+yoBDbg2G68D7tjSzhgsmqQR8yt83GkSLECKlvIZidfC
	zXldY0hTJN7XwHH/W2T9HX2tupcqb79UykzvC
X-Google-Smtp-Source: AGHT+IH7OPS0iStmzmEas32N/nAQgDtarFZ3F5NA0hqbTcmbqAPNvcNBDw5ucN0uum35Vxa2W2EaaqlutU5vD0VAtSw=
X-Received: by 2002:a05:6902:1008:b0:e53:5eca:de59 with SMTP id
 3f1490d57ef6-e536210f14bmr4802079276.13.1734557078446; Wed, 18 Dec 2024
 13:24:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aef181673159ac72f1e7922548186fc6@paul-moore.com>
 <20241206114108.342819-1-15074444048@163.com> <d382c0e.8393.193bf12a7f7.Coremail.15074444048@163.com>
In-Reply-To: <d382c0e.8393.193bf12a7f7.Coremail.15074444048@163.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Dec 2024 16:24:27 -0500
Message-ID: <CAHC9VhShLWXKL-pJ-rGZHQAYuH_gwfyjXFbV_G=S__2i9o2=Yg@mail.gmail.com>
Subject: Re: [PATCH] lsm: add reserved flag in lsm_prop struct
To: =?UTF-8?B?5p2O6LGq5p2w?= <15074444048@163.com>
Cc: jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	lihaojie <lihaojie@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 3:11=E2=80=AFAM =E6=9D=8E=E8=B1=AA=E6=9D=B0 <150744=
44048@163.com> wrote:
>
> it's the compile error that i met.
> In file included from ./include/linux/string.h:389,
>                  from ./include/linux/bitmap.h:13,
>                  from ./include/linux/cpumask.h:12,
>                  from ./include/linux/smp.h:13,
>                  from ./include/linux/lockdep.h:14,
>                  from ./include/linux/spinlock.h:63,
>                  from ./include/linux/wait.h:9,
>                  from ./include/linux/wait_bit.h:8,
>                  from ./include/linux/fs.h:6,
>                  from kernel/auditsc.c:37:
> In function =E2=80=98sized_strscpy=E2=80=99,
>     inlined from =E2=80=98__audit_ptrace=E2=80=99 at kernel/auditsc.c:273=
2:2:
> ./include/linux/fortify-string.h:293:3: error: call to =E2=80=98__write_o=
verflow=E2=80=99 declared with attribute error: detected write beyond size =
of object (1st parameter)
>   293 |   __write_overflow();
>       |   ^~~~~~~~~~~~~~~~~~
> In function =E2=80=98sized_strscpy=E2=80=99,
>     inlined from =E2=80=98audit_signal_info_syscall=E2=80=99 at kernel/au=
ditsc.c:2759:3:
> ./include/linux/fortify-string.h:293:3: error: call to =E2=80=98__write_o=
verflow=E2=80=99 declared with attribute error: detected write beyond size =
of object (1st parameter)
>   293 |   __write_overflow();
>
> i see commit d9381508ea2b590aff46d28d432d20bfef1ba64c merged,
> but it's a workaround, so how about my thoughts below?

Before we get too far into a workaround, can you confirm that you are
not seeing the error above with what is currently in Linus' tree, e.g.
commit d9381508ea2b ("audit: workaround a GCC bug triggered by task
comm changes")?  If that has resolved your problem, I think we can
leave things as they are for now, we have one workaround in Linus'
tree that should mask the compiler bug and I'm not excited about
adding another.

Like Casey, I'm not excited about adding a useless field to the lsm_prop st=
ruct.

--=20
paul-moore.com
