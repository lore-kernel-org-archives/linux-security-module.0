Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCE11A08C2
	for <linux-security-module@vger.kernel.org>; Fri,  1 Nov 2024 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730480593; cv=none; b=ouMcoV3Spp4Cs1NV55foKR+bC6GLGghXb3PlSvm/QQm9qNIjlgdIN7Q+dpHquT6K5/+lx/ELLoUYfq/9EBxyeBTftiyjykf/Ocgok8GQ7cxYAcQBGrKOC3x0b8RinJBG8g0SwgyXUpJUjtuDCCLIpG/rV+5DvXSH2Q1wNv+UxMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730480593; c=relaxed/simple;
	bh=F1UjkDS8cPDIM5v+JgBc51HxVQC+LyV9d08o7bvS4DA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9r5yNvJ3ld9cX8teo/VT6YhFPArH9aSJuS1saSAFRAHKlSoTcoDDcRBj5dMB71HAgBlU4UeOfkZb8iIW3lu0eXvdIjLEvPHYbjcqHZjI+WRd2taHHdHhGu/SsG1Ld6ilG1IwEfeSLL5/nuihnC09P2W1PF4MkfN4XsVhXe9aEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Tqy/poq9; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Tqy/poq9"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-50d525be53eso634060e0c.0
        for <linux-security-module@vger.kernel.org>; Fri, 01 Nov 2024 10:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730480590; x=1731085390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gzkEAtRLERKJA/Tw0nk+QI1E4oIoMTkMUA7GP+Au+o=;
        b=Tqy/poq90wjcydWwoNtWiv83X5XX+VG+V+dd03jGixQMTtEtnYVb+0Eyug0D7P1TKr
         O99z9hCTxlPTX9OJGTpjNJxIyAlu6T1KLU9FRyuTFTdptkacW6u5KPg/qPCldnM68DAR
         Bk5mrCXQAwJKmU6iQncvwsGf0QpiW/AkD5q+55Ni6WxG0PK2qm3rmYilHTSln4SYZxP0
         EAslw2h2ZaS+31gL5VWRZpIvH9IurR/UrfMNTiklCzGH22ZA5/sQ++epD5gH/M7Jz7Uu
         caIndQ4TXdYH22DCABsUGJ2eCW9sLFtC9w6XF6i8CmbMIaNS20IilrT43mQlQcn7L+fG
         LwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730480590; x=1731085390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gzkEAtRLERKJA/Tw0nk+QI1E4oIoMTkMUA7GP+Au+o=;
        b=FilhtGz2KcBCQfV93AMKBCW0KIRfFr8QJYMuA4FdPk1h74TwPh+rEu//seWjzKIHtw
         v5N2izLSMImAM98QE1QITBV90tv0OceYGlCLV/rXjokY2TDfle4wxjisJzoSByb3CnKO
         E9QE4HmVOdSt525O52OXBl2ow2iTtChhH2QIrBim5TZPYECsOsClrW7QuGiXeKloDkYd
         ndw5+xhpWOVQgMCSi+DBrEs5+9yVLcasJPtTfJhhXf80JArmEzwx6kkkDWRS5wQMWnvP
         iUiyRM1kJU0PlNeuVj6rr3QHw/mq7ImgUZ2aH50BzJXRheoe1b237WrS1CjQX0LEkLPI
         Ma2g==
X-Forwarded-Encrypted: i=1; AJvYcCURf2rV0ljfPi4vvhWid2XAFKTsgfk2idyovgB8NCUvUQxHRn2P1YsBx8EEkA9fivqLQqxZGBzjoeIgrnNu1aEn/KJma9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPILjUCn/WqjmrI3sGFYjU1CSmgCsjcBiJhSA0SnMa/esv8U8U
	zHTaYfV4Cb7e9DtnJR1LvcYj3QtnF1XwDmP+4aOB7I9/et3x7Z1M7IVBbl4EMkgE9dM0fBSPJ4w
	N7vP+5neFyYJFsKTBh0HZz4waST4oTNzUczJq
X-Google-Smtp-Source: AGHT+IHkpPN4aN6KLUER6T2zoHuJl3oBHnwC2V6UG/2nPgr2gh6oNQdtyJXnQHM7hBzNjZ+Jm27G0JaaA/bWSq07fVw=
X-Received: by 2002:a05:6122:90d:b0:50d:5f75:f7d9 with SMTP id
 71dfb90a1353d-5106b19b8f7mr8848634e0c.9.1730480590520; Fri, 01 Nov 2024
 10:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYv_Y2tzs+uYhMGtfUK9dSYV2mFr6WyKEzJazDsdk9o5zw@mail.gmail.com>
 <20241101095620.2526421-1-aliceryhl@google.com> <CAHC9VhS5wLQeF4LX67UgUYVG3oViA7CmSZS_kugH+M5J0XS2Vg@mail.gmail.com>
In-Reply-To: <CAHC9VhS5wLQeF4LX67UgUYVG3oViA7CmSZS_kugH+M5J0XS2Vg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 1 Nov 2024 13:02:59 -0400
Message-ID: <CAHC9VhTKzXPja5mLHmqOoTiDm1K8k=vtK+x9Hfa6t-7hpMmwag@mail.gmail.com>
Subject: Re: [PATCH] rust: lsm: replace context+len with lsm_context
To: Alice Ryhl <aliceryhl@google.com>
Cc: naresh.kamboju@linaro.org, casey@schaufler-ca.com, 
	anders.roxell@linaro.org, arnd@arndb.de, brauner@kernel.org, 
	dan.carpenter@linaro.org, kees@kernel.org, linux-kernel@vger.kernel.org, 
	lkft-triage@lists.linaro.org, ojeda@kernel.org, regressions@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	lkft@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 12:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Nov 1, 2024 at 5:56=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
> >
> > This brings the Rust SecurityCtx abstraction [1] up to date with the ne=
w
> > API where context+len is replaced with an lsm_context [2] struct.
> >
> > Link: https://lore.kernel.org/r/20240915-alice-file-v10-5-88484f7a3dcf@=
google.com [1]
> > Link: https://lore.kernel.org/r/20241023212158.18718-3-casey@schaufler-=
ca.com [2]
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Closes: https://lore.kernel.org/r/CA+G9fYv_Y2tzs+uYhMGtfUK9dSYV2mFr6WyK=
EzJazDsdk9o5zw@mail.gmail.com
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/helpers/security.c |  8 ++++----
> >  rust/kernel/security.rs | 38 +++++++++++++++++---------------------
> >  2 files changed, 21 insertions(+), 25 deletions(-)
>
> Thanks Alice.  Would you like me to pull this in via the LSM tree with
> the associated LSM changes, or would you prefer to do this some other
> way?
>
> I'm going to merge this into lsm/dev for now so that we fix the issue
> in linux-next, but I'm happy to drop it or do something else, let me
> know.

Nevermind, no I'm not, as I don't have the LSM/security rust helpers
in the LSM tree as it looks like those aren't in Linus' tree yet.

--=20
paul-moore.com
