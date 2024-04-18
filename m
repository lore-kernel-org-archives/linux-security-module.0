Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C410E15AD99
	for <linux-security-module@vger.kernel.org>; Thu, 18 Apr 2024 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713439451; cv=none; b=V3AVwJqLTBctMuvTxLZ9p3kBZS2OklS2gJcqqTJ/mXk/Qo43gLPsXMMwtAAjazLFiw57ihP6vrBT49xVNN6UuEq+LVh7D1D8N5UC2oRO7l+xIsyz6xLPdhO7fifMEMQctd8vEcQ0JoaXnBdSGm4higW6sFbAEwboNrSaOthHQT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713439451; c=relaxed/simple;
	bh=7p9II2+6mzGGxSqDcyqUxEIU+9mPe7JPFJ7NFBoK4iU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QgAgpF2s9+j0CjXgAbveyueBPPfTLXhgG8PeDy/Kef7z5ZkEyxOY/QwznAlKk/sBMRw33qWCTQgvMls9jM/IGEZ/+Reum2Apg+Oulx3STpBtn27WNOoshz/FNrho+H/Y5jgFYltsz51pvou6iFC8jBERyUqW/y6b3KQoWPLfDc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cT1b7SoD; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cT1b7SoD"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a556d19dff4so25790066b.2
        for <linux-security-module@vger.kernel.org>; Thu, 18 Apr 2024 04:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713439448; x=1714044248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VNR1QUJOgk6ycIsrP5lacR4A2Q7qc4VgOEzVUu8VSYY=;
        b=cT1b7SoD9+79RGP2m9qZXo5NoFNxmnSUynr3+sD82BKNANm2GamHQgYbN/+I8mXgE+
         7jTL4oP5SbM5B489HPnJYNWPBU9duJzfi8bOmq8cArOr/lDYMgQEIOVqkCB9DMDp3qFC
         DLBW1m+TQwfmwPuobFHnvXmdOdpN+GHrmnngrUWCQuBhWnUkPWYsYU/mGQvUdMz3UxdO
         T/IDUeooakWfTM/sA56YV0mJ7s3/lbHRePclSG9LSu0MSUU2N6ZhfXaj2DrNxLA49k+h
         FmXlfhgUbDc2N89nwsxmt2BWE45tFciShpukw2ic+pguSixydC62K91zo95pFclWdah8
         bGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713439448; x=1714044248;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VNR1QUJOgk6ycIsrP5lacR4A2Q7qc4VgOEzVUu8VSYY=;
        b=Z1JpgQvEluLTV8QYc+iMv76Rx8aqxdO1Xvb1GNatlQDgFl996/gJfCh8FZx6NZyspq
         x/icoz/hY/QSPEm9C2ER69iXXay3hvu0DIKQlZyR03FLWEZ7QzzyamIIVxT6odlIlvza
         EgdvAgzqzhV+7+HSKcHrmBxeO3ujqF43pIaUYpVX9TpmgV663pJLuy9IRGfUuBuq1BiK
         GbhNALFACFJjAPrryNbCINrdcW2K7weHF0fO5VX+MEneSWnzLBaIb9NoPnQooSZHKWnn
         1G3m/czBS6dXqEfgb8LTRzubgwvqkVz+d3NYhNlpEzDLBpp//e3qwrSaayh7F+j/YvZ7
         2JIw==
X-Gm-Message-State: AOJu0YxDdRS4t++sY2MXbaoxLM5Lk3mOdUvRNXAAB1pD3QqkKsMR2kwy
	cbYcJqmbcyQY2sekFjWZVDi/Z+HlX6IzM7caHfcUr/e4cAjOtoFMFYkqOiFrCcAH3HcTnv5A7yW
	dHA==
X-Google-Smtp-Source: AGHT+IFgB25PfeRTTxi+P20J+DJ77jyxs20V5UD9HuczYalCvPXrPLDinB0rPJRRjLyn+dlu+/szbDZiJoE=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:aa7:de01:0:b0:571:bd82:9c4c with SMTP id
 h1-20020aa7de01000000b00571bd829c4cmr1570edv.8.1713439447884; Thu, 18 Apr
 2024 04:24:07 -0700 (PDT)
Date: Thu, 18 Apr 2024 13:24:05 +0200
In-Reply-To: <20240412.IKoh6rius5ye@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405214040.101396-1-gnoack@google.com> <20240405214040.101396-8-gnoack@google.com>
 <20240412.IKoh6rius5ye@digikod.net>
Message-ID: <ZiEC1bbYezkX5POQ@google.com>
Subject: Re: [PATCH v14 07/12] selftests/landlock: Check IOCTL restrictions
 for named UNIX domain sockets
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 05:17:54PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, Apr 05, 2024 at 09:40:35PM +0000, G=C3=BCnther Noack wrote:
>=20
> Please add a small patch description.  You can list the name of the
> test.

Done - I explained what the test checks for (that the access right should h=
ave
no effect on named UNIX domain sockets).

> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing=
/selftests/landlock/fs_test.c
> > index 215f0e8bcd69..10b29a288e9c 100644
> > --- a/tools/testing/selftests/landlock/fs_test.c
> > +++ b/tools/testing/selftests/landlock/fs_test.c

> > +	ASSERT_LE(0, (srv_fd =3D socket(AF_UNIX, SOCK_STREAM, 0)));
>=20
> I'd prefer not to have this kind of assignment and check at the same
> time.

Done.


> > +	ASSERT_LE(0, (cli_fd =3D socket(AF_UNIX, SOCK_STREAM, 0)));
>=20
> Same here.

Done.

=E2=80=94G=C3=BCnther
