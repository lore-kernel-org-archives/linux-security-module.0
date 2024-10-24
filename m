Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5911F585D;
	Thu, 24 Oct 2024 17:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792150; cv=none; b=J/rgAt2PKptV/p8tKWvDXD+LyN9myws2Pu2cXG00IN2J4CS0uLbqYXEoWdM5Omv8b48PTTFZTVmEibdrG3DZrmNRD4e5YYlyEPLqQuoynHIG8DMtzvPxikrrb5I0YVC+i/7RZfRFcdTM7iooJIupK0eUwbUkwgrg8Zoek6YVV00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792150; c=relaxed/simple;
	bh=o33mdDcr08NnMI6+EuH+0VIB/xt6TEqaE50XcDUztqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fr8f/mbYdPZSWOW2Sqa/DCe4pAb9g8rJykGoOPFgMm9jTL5uTa1Iui71Rst6b239TSLbGPtr+I1P8xBbc/UAQu0Kc8g2y66mToTfgimJHnR66vY/yOyxYQMWNYI6B090/4NtMdWWpiIDU93RTWqMZ/8fZup9w83pbOsFg52sO+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkqyQzka; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkqyQzka"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so790798a12.1;
        Thu, 24 Oct 2024 10:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729792147; x=1730396947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikFyTCNo4lCkc/He2G82/uKVruxJK5os7sSXWZwAzOQ=;
        b=WkqyQzkaG8NrCzqXtK0qQShsiELgMbAyFLLO39Cy8ELDwKgxJ3V/9qOhF2xcpuO8V3
         y2q/PFdPNR5tesFq82z17CYnCar07aQSISKoYVzsNtoIeJWu85b5zEYCrd80YXXa8INa
         qdPASdBuo6t1Mr9+i2cZwpO+Bag3XxqIx5zruo2Js6hXm2CVof0ZFX8BTP/HJpy3QdVn
         Mi8kdEtTlZ/QTJ7L4rcMVQzUlaWQ41pFfsnz4iHZBDPjaREhAxZC+EHm6iSfKUaginGQ
         dCHgLdGJ3jvWA59QupJ/p4ZycGSpTyXwvrqxRguxUcFgu6gNUlyHK3YvwgkcPGWux4j7
         PSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729792147; x=1730396947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikFyTCNo4lCkc/He2G82/uKVruxJK5os7sSXWZwAzOQ=;
        b=Wfq3Q+dPaOG7QqKAwI/nIMHpqTYZGe6Nn5XfD7kZcsKV8iwUNpcfilYgQzcCkk9Sdl
         YDYowhwgNiiERU/qaZd4tieXI/zjwF5NUW63lrO9YFBtIuXw50LHtCdYt7wafIR1IgKD
         O9RpCDQqa3fuyaTek3oUKOhwekDAMKMdAESkhx5P2j9g/U1guGwfgA6zOPdGgkhH6hh4
         biALmbwZhpClQP4x6Ycwk5LJFlIypjMoWdjLiTnITt5A1jKwyFuWokazhu8AIJvMl9vg
         9yrGlVepTGzqSzx8K8+qPND5p479cCe7TaffJuyyporj1yTSumrmjPDizG568E3/fHo5
         3ykQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHuFw/XyhhUQQfG5FZhyspr0uaaXXPxkgwrRFAFXbQQvCKQjw05aNuvuhHXswiDc3k/7K8mL5KDQZxtCiLxYqMcRdupY0=@vger.kernel.org, AJvYcCXABUknxHrQUuhEf1Xbdjr03QSZ70lOb1vEvHELsn4wQBtDptJhITjaH6WiEV/njgdRh3srPE9K9eDUgxgeLjY8zOkk@vger.kernel.org
X-Gm-Message-State: AOJu0YwmoYVxoafYIeO5LTZgPr23YZvZHpTZBj6QXvZLdj1BEpsd+KS5
	iXst+O72rAH9BjrdVJ8C45pQOUog2rAVSRl3bQa57CPcZlR7AqtxvDJTU+izS3Ltxs2PPATuN5w
	sCVWpoISEeI2Z1Cuwh/Q7XB6gD1c=
X-Google-Smtp-Source: AGHT+IEsjKUtq8o9rAgB39zgiEtf+gJZYutfiVjAzLYKGRVAld7uL9YPG545/aHblFPil+Go6LDHrgYKUEYNXpqCkpA=
X-Received: by 2002:a05:6a20:d805:b0:1d9:261c:5943 with SMTP id
 adf61e73a8af0-1d978ad5a29mr8702453637.10.1729792147606; Thu, 24 Oct 2024
 10:49:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024104012.1815022-1-linux@jordanrome.com> <20241024091904.2650d758@rorschach.local.home>
In-Reply-To: <20241024091904.2650d758@rorschach.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 24 Oct 2024 10:48:55 -0700
Message-ID: <CAEf4BzaZvSHnHBPcgkznq62sm_E2JNi1Bwg3g_a9PutfZLicmQ@mail.gmail.com>
Subject: Re: [v1] security: add trace event for cap_capable
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jordan Rome <linux@jordanrome.com>, linux-security-module@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Serge Hallyn <serge@hallyn.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 6:19=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 24 Oct 2024 03:40:12 -0700
> Jordan Rome <linux@jordanrome.com> wrote:
>
> > +TRACE_EVENT(capable,
> > +
> > +     TP_PROTO(const struct cred *cred, struct user_namespace *targ_ns,
> > +             struct user_namespace *capable_ns, int cap, unsigned int =
opts, int ret),
> > +
> > +     TP_ARGS(cred, targ_ns, capable_ns, cap, opts, ret),
> > +
> > +     TP_STRUCT__entry(
> > +             __field(const struct cred *, cred)
> > +             __field(struct user_namespace *, targ_ns)
> > +             __field(struct user_namespace *, capable_ns)
> > +             __field(int, cap)
> > +             __field(unsigned int, opts)
> > +             __field(int, ret)
> > +     ),
> > +
> > +     TP_fast_assign(
> > +             __entry->cred       =3D cred;
> > +             __entry->targ_ns    =3D targ_ns;
> > +             __entry->capable_ns =3D capable_ns;
> > +             __entry->cap        =3D cap;
> > +             __entry->opts       =3D opts;
> > +             __entry->ret        =3D ret;
> > +     ),
> > +
> > +     TP_printk("cap %d, opts %u, ret %d",
> > +             __entry->cap, __entry->opts, __entry->ret)
> > +);
> > +
>
> You record cred, targ_ns and capable_ns but don't use it in TP_printk?
>
> It's fine to print pointers there. Is there a reason you do not?

Are those pointers really useful for anything? Maybe it's better to
print ns->ns.inum instead? At least that's something that is usable
from user space side, no?

>
> -- Steve
