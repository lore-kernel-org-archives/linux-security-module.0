Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1768F1D6DDA
	for <linux-security-module@vger.kernel.org>; Mon,  6 Jan 2025 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736202800; cv=none; b=N5ivm+tYzpeNWRpmdN6C/RMtKEPnkYrpzEgEOitLf2Kp/LhqUJyo3nWPjabof9OJ8+UVNHIFJ3ffdFjYL7gqTqz6lBfgZjsv+ToTH9J6f9ve3pvvuIeIGMrOmf7U5hR176Wn8pcjwrnHQ0Tip2hfcpH4LLRgwzcsdHsSKkmC8v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736202800; c=relaxed/simple;
	bh=kpxzGR4JaJofJNDa5ZJ3pY4v2uSOH1urVRJeJzOWYII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzmWlnz7KUV/WXT51BaKrZjkwIVaAiw9Sa3Dt30fMBWFw4Jv9Si4A63mmWxf3OjbOLRWAHkrI0LMA7S/73aj+hPwxTcQxz7gL8sonwe4NDPTnPkpLhdxJxrG5CnEnNneFcgrg5VM8dOiydTuAFSGrbN/sXInRq615WYhXD1WEDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bamBrdNO; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bamBrdNO"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e39f43344c5so19536303276.1
        for <linux-security-module@vger.kernel.org>; Mon, 06 Jan 2025 14:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736202798; x=1736807598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnYEdpMsAz0QDzwNW1wx8vhWkXrIqVYrOc5wcWksEcQ=;
        b=bamBrdNOgaRjGQcB/8IbivWyomkC+0wFRLe0P3/ifJhkvZFRfHGyPYJqaPZ6jE7dr9
         3+vqcmVrULdJjdUVaJ0Oq7p82rF8gUzFweRtkootMaYSF/kkKXfpefWpB8FZ6vTamJ1t
         xA2R98f4tsT9er12hZoyvTmPkDaFMNh5y6L8Nfog+6d7kIvwLpcw+fPC2+96T/ULB+nI
         5SxqG1vSsRqKq2oGcXsVKSfZo6K3OxlRI2i1Ks7rnTPFAu4hQTS2mQubyI/Eqf52VQza
         oW2qV1+6avrf2xCG3ZKaTVmImawHM0t0ImeR0wr04FHNrgzaTIHnKjMUDM/s0aNSIcJj
         qVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736202798; x=1736807598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnYEdpMsAz0QDzwNW1wx8vhWkXrIqVYrOc5wcWksEcQ=;
        b=H9m2A7Ra8I9OicQBOxQDmPRAXt6t1TcOriK9PL7+48iAUXJT5gAEdTHaNuweQ3xs2r
         B9k4gn5i/6skz6wYpKD2coF3x6i8CCQ2bEdMUChxC1jQ4/DvuSJdBeiWHLf4OUE/RNd9
         6TmMQyHv/qhmg5hrE6cPl34YMk+aN6mug12r50i0XUztSATbsRG4+XkfbrPNgVgZoIDC
         4XxWMLAI7VRoiPrfhNjqeu1V1dpiKIhIzTcIzl923MlY2CQa8CqMpHPh1rK7n+rMZm++
         nPFcGND2ix/aTgk9veh10Md/ET9iQ3PIkD5U4cC8zZ0roKHAQky8KoOWOeNZgdqyF8GS
         ZJew==
X-Forwarded-Encrypted: i=1; AJvYcCUCiapEokM19gE08N5IPvYnTqwTXECVSJemmz844at2Cce0r7leEvEFSlq5m0gtLea2/oaILpuvioAqWzgDAWC6tjyOTd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzyNfnXpEV9gGmj3vWjwd77SkXZ/4mjsk4S/GW1ip2txtr1YGl
	xC9yY2KDsb1HNYHBnINuDAZdsYvQR/i4e8t6aByoFy0LN42YFwUMwH/ZLOAZePLAL1kOx3E/S2a
	2MuaizsL486aSkBsNmHcnd93c45iHs8fTQtUQ
X-Gm-Gg: ASbGncvCwqHnWUhkSpfxVh709d8NKoxLXkSpi/f/EuSsi6QylnDIOumyiNutcjUTZhQ
	x/IkveaOtbF7PSPG7l6wnK/0HNow/nR7yiNdq
X-Google-Smtp-Source: AGHT+IFSn6EmyzYcayFke1bry03EZjwyI2ykxVAT2ssmOGcaLUn1LXokDJByOKaRFr7je/0lN2AHCYWtk+7hnvzD69E=
X-Received: by 2002:a05:690c:4d81:b0:6ef:4e42:64b5 with SMTP id
 00721157ae682-6f3f8115a00mr425350417b3.16.1736202798164; Mon, 06 Jan 2025
 14:33:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122143353.59367-19-mic@digikod.net> <1372f9de0bb265a08114a870ec086da0@paul-moore.com>
 <20250106.ohHi4La0ahTh@digikod.net>
In-Reply-To: <20250106.ohHi4La0ahTh@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 6 Jan 2025 17:33:07 -0500
X-Gm-Features: AbW1kvYKse12ll4fYv0870kHY_o3Lyw_REBr4iiKqgVQkplZz_g1WsoqSMdceVg
Message-ID: <CAHC9VhQsUkthgGpoNZZdXGcPS9zF2aijYfKfuNYCZB08N=UDKg@mail.gmail.com>
Subject: Re: [PATCH v3 18/23] landlock: Log scoped denials
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Eric Paris <eparis@redhat.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, 
	Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 9:51=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Sat, Jan 04, 2025 at 08:23:53PM -0500, Paul Moore wrote:
> > On Nov 22, 2024 =3D?UTF-8?q?Micka=3DC3=3DABl=3D20Sala=3DC3=3DBCn?=3D <m=
ic@digikod.net> wrote:
> > >
> > > Add audit support for unix_stream_connect, unix_may_send, task_kill, =
and
> > > file_send_sigiotask hooks.
> > >
> > > Audit event sample:
> > >
> > >   type=3DLL_DENY [...]: domain=3D195ba459b blockers=3Dscope_abstract_=
unix_socket path=3D00666F6F
> >
> > Similar to 17/23, I believe the SOCKADDR record should already capture
> > the socket address information.
>
> This might not be the case, which is why SELinux and others explicitly
> log it I guess.

I think I may be misunderstanding you, can you point to the section of
SELinux code that you are referring to in your comment?

--=20
paul-moore.com
