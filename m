Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EFA84D02
	for <linux-security-module@vger.kernel.org>; Mon,  8 Sep 2025 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757372770; cv=none; b=RlfrJ8yHpUdRwRnH0bFkYFH+lqJv9dvvt/5KVr3yDUlZOrN7DfjAbQYVymkwSbhb7/EMuLNiYcOYm4N3Kx1p32coJlQhRL5nYKzNk+XphbG7AzK4f2Yn5g48FHeTqAIiQZ5tVfroJIEbNTIhMFoFFYnbrcgVyH4hAZc3UC7FZtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757372770; c=relaxed/simple;
	bh=Y5RZSb94nAB2oyU1qoO8afAl+wCOgH+J1m+ytAgunGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=geUjgnVwF7sEnjucHZrcJIi65+NCAWpN8hTTD0S9r1MgrcK3fhYaygnpcTT05Egg1QIsnXZwvnPbCH/43nZa+cSC/HQEyzyUDLdQHkgtwXDuR3uRUEGeX3Xrg7wKXj5nwzhgcpQ+H/I9iWW78j6HoCSBVowj5t9N2wXtIi3t0qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FuCn4CUU; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FuCn4CUU"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32b590d819aso4194240a91.3
        for <linux-security-module@vger.kernel.org>; Mon, 08 Sep 2025 16:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757372768; x=1757977568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Erv6ujYQyM5esz/88jb3LaQCpJ9LwDgjjS4NuHxBBhU=;
        b=FuCn4CUUjgnNvtegpU/nHCxIG72/RqpukgPzgn/NB7mzyhx8waHFDDfVtFZ84r0haq
         A5CltYE17oZ6zKlQ1KkO7Rh1IcvqXZaZ84CPwy3RHww4qXC2AhxZOnzqVjQSJUwUu/i7
         Sgrp5zVpM2ekQyNsnpxNcfPoJ8x8PTufkYZ0diGzB38hw0qmxafGRm00yjbZBoiImyrg
         VawHe2RPR4E8xX5LD1cAgcT+Be7Fkgxpi5zuy9afzLCB98yv5jgM46zVjl1ysuuqgood
         zH5oHWUNiP/27MAJB3teMsatItiUqzQi4/z3wMEyPSZ6y8ljkRDGGf61maLLITB8cPzL
         q3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757372768; x=1757977568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Erv6ujYQyM5esz/88jb3LaQCpJ9LwDgjjS4NuHxBBhU=;
        b=UM7iMQfAY8tP/cO+a4uvUN4LMtz5+orc4k4NCPcRNw+6x3PMmnczuRY3hW1tRFd1Hq
         8dPcdWJHh3d9qpFA0PF0VNqDTRA8cupo+/x6L7ZjWAXjMnnfUlV34b0beMZV9lgFiJWJ
         cfsGswEf31LAxQMbsKUnOe9ClIfQIeaVUKpC4ivujTRGCTyKer6lS8W/eIEp0Mn8gAFn
         znxvZFcMo877pM/oT6EdlK9e1Km0rb8vOYFFNZEDqT5Cz2uzCLdQt7YBfqvgTodv6Qd9
         /TbirDwbnMGgYdsKO9uXHjBnc7P3KRF6Uc/L5BhLaqxH3YIvvWYU5UGT+FCo0KETVdz3
         z1RA==
X-Forwarded-Encrypted: i=1; AJvYcCUxUJ7BNMLYK3fkeuGnZGBtwU68Du5qyN4Protnz8dMwOc4TtQiSZOLifOQaKbxE09QzhP5kN5f+b61on9BRHA5pUFurUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI8HAw4vQIKi73/+mI6zXZPMgU1w1fgTANNF5M7dcTuzgD+8VB
	BjeWL04i79rFN4B8DJu/mi+B7uc7RxfHyUcITu5j6V0W03taRS4Ov38YFqL5O/r3nsxYJpFdsMc
	Pp0k44/hICQmKEbO0e6Aw8mwQFFefmM4cBeWf2mcb
X-Gm-Gg: ASbGncvKoDjtqtSzE9kcdddhJLPWsfMJ57q73CVhVaxa59bsvMRZm/YlQbFaNFy0Plr
	iq7I4bx2uRyfRKW8l9dJPa+gsRi0eIav5SNEtZIbh76no64Py3FDR9JbETzDbKKSPDLIEJWbyYw
	tnMvpGJOo8N/gQ9R/veeSXwA0qm8K+08BcPFN4RXfi5gjqtJh1wJ6PH+kf0Q466Ba6XeDfAWjuC
	C3Yx+U=
X-Google-Smtp-Source: AGHT+IFB+FxnX4rjcAYZGM7fEt911DkcKdbHyBbmx41VKn8nMmV/AAJIF3WqaGwCTnbvarfbhMxVBFEgH0t3USpFar8=
X-Received: by 2002:a17:90b:1d0b:b0:32b:df0e:9284 with SMTP id
 98e67ed59e1d1-32d43f45856mr12879413a91.10.1757372768528; Mon, 08 Sep 2025
 16:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-47-paul@paul-moore.com>
 <06a68323-b297-4be7-92eb-c2091207b9f0@canonical.com> <dd03266930a7b219c590c54bb2c210366f8d89a1.camel@huaweicloud.com>
 <e92064a4-06c5-4913-917c-f9aca02378f3@canonical.com> <CAHC9VhQPmF-RCSUjZo-pe1+sWyw5ZGdnD7P0CWb7yXQQoo+92g@mail.gmail.com>
 <CAHC9VhRjQrjvsn65A-TGKKGrVFjZdnPBu+1vp=7w86SOjoyiUw@mail.gmail.com>
 <6e4bb79d-ba8f-47fa-ad12-0bb79d4442e0@I-love.SAKURA.ne.jp> <91e6cbd4-9811-4890-84e6-4d58c22a02b0@I-love.SAKURA.ne.jp>
In-Reply-To: <91e6cbd4-9811-4890-84e6-4d58c22a02b0@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 8 Sep 2025 19:05:56 -0400
X-Gm-Features: Ac12FXxJDTl9FmflOjd4KGcqf27UBcWa5-_QkD1wxw_L_dqqk3VN6ThLKrEYEI4
Message-ID: <CAHC9VhRvdxdmyp1+hDpiOZTLdJjuK1u5Rvk5dTsbN=oDAyPkNA@mail.gmail.com>
Subject: Re: [PATCH v3 11/34] lsm: get rid of the lsm_names list and do some cleanup
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: John Johansen <john.johansen@canonical.com>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 9:07=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2025/09/07 16:35, Tetsuo Handa wrote:
> > On 2025/09/05 2:52, Paul Moore wrote:
> >> +               if (!str) {
> >> +                       str =3D str_tmp;
> >> +                       len =3D len_tmp - 1;
> >
> > This needs to be
> >
> >                       len =3D len_tmp - 1;
> >                       mb();
> >                       str =3D str_tmp;
> >
> > , or concurrent access might reach simple_read_from_buffer()
> > with str !=3D 0 and len =3D=3D 0. (If you don't want mb(), you can use
> >
> > -     if (unlikely(!str)) {
> > +     if (unlikely(!str || !len)) {

Good catch, thanks.  I'm going to go with the approach above as it is
rather straightforward.

> Well, memory barrier is more complicated; it will be
>
>         len =3D len_tmp - 1;
>         wmb();
>         str =3D str_tmp;
>
> and
>
>         }
>         rmb();
>         return simple_read_from_buffer(buf, count, ppos, str, len);
>
> pair.
>
> Just splitting the whole { } block that follows "if (unlikely(!str))"
> out as an initcall function is much simpler ...

I would very much prefer to get the string generation out of the boot,
and generate it on demand.

--=20
paul-moore.com
