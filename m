Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FC839FCE
	for <linux-security-module@vger.kernel.org>; Sun, 13 Apr 2025 19:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744572321; cv=none; b=D+cyfqhmgAMPpJkRwAN+kA+0CpPN3ea0xDleZ5M8tFLpTE5dbRnK1R05Q+2gY+5WAYG+fqfzbcI3ApcW2xWYSQa1B6Kxxu1VW4Otss8UD5IRDvZIEshrhDUlSWUhPmRVVd002QGK7U2sAcudlOlicprJl6LEvawVPzn5/NMF2eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744572321; c=relaxed/simple;
	bh=cgoVDjX9IT6EtA89494TbMxqJl0RE2iUlZQmz+9vkuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asynN7nu1ICOeSzUkEJ2txLy9iplGcW8XXXi2Sl4V0Fo49cp/5oMBDusnlMi2aLmbqtYAls+PJYoqSWjpcfNk6zejsB1RzdLCTXjVeQTaHzL60HVi78CQZvq30E3xIo+zRGf/z8mKJ8HvIBtN58cAn6ZNR52ou8FGub8yqSsSIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=B5aFJFzI; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="B5aFJFzI"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e6e09fb66c7so3028267276.2
        for <linux-security-module@vger.kernel.org>; Sun, 13 Apr 2025 12:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744572319; x=1745177119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dq26RbuqV8heXEFnUrcIAdRGV+/86EMAIyh2oJSHIJI=;
        b=B5aFJFzIKjGgXqlYYGH9NShbk9/0aVER7GR/KLHODSF3YXlVT5Tl4PBcjBE8oOBNDr
         ce2RM71SZ6CD9tS48a+ZrU7dTa0RPp4+8+/mq31ZWrT0inYfuVjCw4hS/+DgC+FqynIW
         njlgGNKNgsje5t4K7E6BaT+QafjClfA5/m+qA/Hj0VwVun53bWFXefAywPhpy32s9LX8
         1/y7piHBf9qCOWRXqAFgqy71SEJaDbgHBs0Xh0Bg2/kfdI/shMLNLUb1MqE4dvBXhduF
         Mov1ms2gv9DOsMWpFTcqB9dKqYbukayUsfgdUqgKW5yCgUpaBgpAXSqjJlowg10Sa9UG
         Ahnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744572319; x=1745177119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dq26RbuqV8heXEFnUrcIAdRGV+/86EMAIyh2oJSHIJI=;
        b=waM1seoKBwJgpMEfUqv7mhBfWFoNRj/wURU7sL+tzp8NRFjqQf2+v3lGll5CtTKwb7
         PAV0oSl4aVJI7BzT5Li5ufALnGYjfMjy4N9NR4fCL2x7hZm7UzUUpDBX0yKPtkG6HmVg
         8ViBd1yaBzCG4YZ9eFIcF0yOh1EuRI2pafhfCi0/l5d8lnifpIDIQ4+y1qWopFCnaZnk
         ioOQTruu8Hs5NFFmOGXbfV6lCPma7GIJsOQQRp7IMB6b8oK2PlScmoaVDTohfInQWs3V
         /sJTUx9Evn3oWghyxsL82tPf8DJR6opDf1ZGM18fdVNC2tUstgr9JlDcuKNqGgDT41ro
         dr0w==
X-Gm-Message-State: AOJu0YyObe0tOWvLGyRjsTMBOpD7sHKcAcO4HAK51JNJYM+dDIa14Ezk
	S66EENL312Qo5vwdiXlevgTxVoni5kZU9TlM9EUU2UOyie7YwWHl0+E/rEE9dUdeqaQZqXWDRU9
	oseI8Ewwiqgs8dA42jSP/vGHh5ZLn+zMpCS5L
X-Gm-Gg: ASbGncumg4q2bgVPehNqfnRLZVNpp0kf4794sNSJu7Al3U/VxUfIzJjYhSOyjCjqdEV
	QD82sZaq/ZRO1dWpoeUZhdFG0H95XsSkyZ6wpg4Tp5G+Pc6y41//Rw6ZduX4V8cU71CHnjKqinL
	CrDdizPl3NG0zzFz9/ERFxOH6Z4lz2FNBF
X-Google-Smtp-Source: AGHT+IEK3FZOyF5DkkCwjbI6gGNlgoKbpro7f3xzWGq57ut4TKBLbfWVw1Qp6lUKEtjw+o5HwzHf67W/QIFHUN1a7Do=
X-Received: by 2002:a05:690c:4901:b0:6f9:b0a6:6a15 with SMTP id
 00721157ae682-70559ab718cmr165647647b3.38.1744572318910; Sun, 13 Apr 2025
 12:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321102422.640271-1-nik.borisov@suse.com> <CAHC9VhSpgzde_xRiu9FApg59w6sR1FUWW-Pf7Ya6XG9eFHwTqQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSpgzde_xRiu9FApg59w6sR1FUWW-Pf7Ya6XG9eFHwTqQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 13 Apr 2025 15:25:08 -0400
X-Gm-Features: ATxdqUFFPMWUt_uYVOB3P94cPJvgJmNzGSw0uhdEvSDjwZkXZa-eQQ48N-qvI6I
Message-ID: <CAHC9VhS97RWMYmCOQVCZPUUCxdMXPMzM3R0z_U4zJQNe40M4BA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Allow individual features to be locked down
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-security-module@vger.kernel.org, serge@hallyn.com, kees@kernel.org, 
	linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 5:13=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Mar 21, 2025 at 6:24=E2=80=AFAM Nikolay Borisov <nik.borisov@suse=
.com> wrote:
> >
> > This simple change allows usecases where someone might want to  lock on=
ly specific
> > feature at a finer granularity than integrity/confidentiality levels al=
lows.
> > The first likely user of this is the CoCo subsystem where certain featu=
res will be
> > disabled.
> >
> > Nikolay Borisov (2):
> >   lockdown: Switch implementation to using bitmap
> >   lockdown/kunit: Introduce kunit tests
>
> Hi Nikolay,
>
> Thanks for the patches!  With the merge window opening in a few days,
> it is too late to consider this for the upcoming merge window so
> realistically this patchset is two weeks out and I'm hopeful we'll
> have a dedicated Lockdown maintainer by then so I'm going to defer the
> ultimate decision on acceptance to them.

FYI, I expect we'll see something on the mailing list related to this soon.

--=20
paul-moore.com
