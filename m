Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5DD156887
	for <linux-security-module@vger.kernel.org>; Sat,  5 Oct 2024 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728144370; cv=none; b=MWNZyxDZquK/j/JCuRb8NlVfmqDieEZH/r4AWpPmfhh0TSayvCc/dRKH6/6mI57z9lwkDdEjFf6Ka6pU7J785p3OmGXBhsUUSjD1dLSFHSt1vDuY83TFnKVEna0xrPDnr6uREXCXg0Baz2YNbZkGs7XsWALz1cJBdQAVrzDsgRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728144370; c=relaxed/simple;
	bh=gy99hfMSEuciOLRvg9uneeNySFEdFxqOdHtelAWPaJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgyCACqFzs32AJdCRqv7GpIAKDb/Eh+bHJNI+y9tzUHE59QwPU9qeu9mUQS3Uy4WaJOGVoW1MvYiCVMi/nuS3c3SNUqv/uUL0AxoLLqfnEbAHmvFd0kFk43TuXOUHmaa7tVCFLacHjHP5kSKC8+/eaNsx/kDRhzHYVGeo9sU4ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VgK19q9H; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VgK19q9H"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e2c4ffa006so17512287b3.3
        for <linux-security-module@vger.kernel.org>; Sat, 05 Oct 2024 09:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728144368; x=1728749168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2KzT/GXNsWHTuq5WQm0xUlaFWxBnWL/Ti7SafWyJCs=;
        b=VgK19q9HrGwcsTkC9rID4uzgszYDSXG0Eb6K94W3/mLBohTCxbyXB0v6XrP1Mu87TG
         GC8jU3CAhbkKbVTZKQszq+KSURDhwmlG3vCs3l297nLHE8nDdPl9sR2ooMiS2Nkp+eZS
         BrQLA7qG6NfY4TJGbLBZlL/+sIhLAmGXF4kYpHposDOBtiuwtW4OnqX3i4xbye/uu0F6
         w2IPa164kd2hpBxFxm7d/jw4D211w4eWi5MnB4cYOKtF3WJfmeTonJ1y+k/bFx+PEybI
         j/WykT9Syv/ml3CGzrQG7Q8Hwzp15TiqcUoN+fPNubi9NxgKzCZC2zvi4VvqqC2er52h
         skRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728144368; x=1728749168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2KzT/GXNsWHTuq5WQm0xUlaFWxBnWL/Ti7SafWyJCs=;
        b=LVcmgCnrNSLC9ULLZFPqzE6jJHNyF2lSJqo0pz7f8EKq2FegPLqotZOB3gRn+G+Ufq
         0tmWKL52vvYJDcYctGpU2dSb7Cvc+w9i436LcC7RGZpk8whuUXBR3xDJlzmeuzLhIdxK
         fLqsi2FFE8+eNs3yXOrs55xQwwcOptZ0qNV63shMo25J0cAUZdJ+wMGgY3OJ90CK+Xwn
         inz18Ppb5wQNkF/ZLOCfJ0RGFUDUs9gXFRk0up5Sumt2xop1EidVkeOyZGafhrtzn8HK
         z/NKcUtl1tFfihw2+HqEPMPLaiGyVVFGct8XYhBMhgmL/dGZT3+0opp4YbUF+UZvWwQq
         g6GA==
X-Forwarded-Encrypted: i=1; AJvYcCUdhsrzRzQmfET0AzKJCQLuaJwT+GwUOJdhg8eGWrU5k59jDzf3CvZa+DrNvxpSBKLSmLJpc2qruEwnLTaqQtIcpI5Yblc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw70DG0nTrJnY/A9yvD3pA/hkQghMN1qhzC+Wtkc1l+Gi24TAuR
	XBtqShxkJYDKs8cFmrzJWHpLxfGh44eerbp9nis+xx2JOVgRTU9qzAkcdzs/tWZTZa7yewG95ny
	FyusI4YnZ3kL5YEbZEiUVmEe1EIo1L1cESF8zItZio/Osvu0=
X-Google-Smtp-Source: AGHT+IHLJpqTwDIdS5aDlwG70TD/g6SXQ+AOWaiPwUqLzRnbhuVBrMXZ3mrDPWqSdlT9mon9gacWlQXCsKDXazb5gfM=
X-Received: by 2002:a05:690c:60ca:b0:6e0:44a:2571 with SMTP id
 00721157ae682-6e2c7289fcemr58832887b3.32.1728144368490; Sat, 05 Oct 2024
 09:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002142516.110567-1-luca.boccassi@gmail.com>
 <CAHC9VhRV3KcNGRw6_c-97G6w=HKNuEQoUGrfKhsQdWywzDDnBQ@mail.gmail.com> <CAMw=ZnSkm1U-gBEy9MBbjo2gP2+WHV2LyCsKmwYu2cUJqSUeXg@mail.gmail.com>
In-Reply-To: <CAMw=ZnSkm1U-gBEy9MBbjo2gP2+WHV2LyCsKmwYu2cUJqSUeXg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 5 Oct 2024 12:05:57 -0400
Message-ID: <CAHC9VhRY81Wp-=jC6-G=6y4e=TSe-dznO=j87i-i+t6GVq4m3w@mail.gmail.com>
Subject: Re: [PATCH] pidfd: add ioctl to retrieve pid info
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: linux-kernel@vger.kernel.org, christian@brauner.io, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 2:48=E2=80=AFPM Luca Boccassi <luca.boccassi@gmail.c=
om> wrote:
> On Wed, 2 Oct 2024 at 15:48, Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Oct 2, 2024 at 10:25=E2=80=AFAM <luca.boccassi@gmail.com> wrote=
:

...

> > [NOTE: please CC the LSM list on changes like this]
> >
> > Thanks Luca :)
> >
> > With the addition of the LSM syscalls we've created a lsm_ctx struct
> > (see include/uapi/linux/lsm.h) that properly supports multiple LSMs.
> > The original char ptr "secctx" approach worked back when only a single
> > LSM was supported at any given time, but now that multiple LSMs are
> > supported we need something richer, and it would be good to use this
> > new struct in any new userspace API.
> >
> > See the lsm_get_self_attr(2) syscall for an example (defined in
> > security/lsm_syscalls.c but effectively implemented via
> > security_getselfattr() in security/security.c).
>
> Thanks for the review, makes sense to me - I had a look at those
> examples but unfortunately it is getting a bit beyond my (very low)
> kernel skills, so I've dropped the string-based security_context from
> v2 but without adding something else, is there someone more familiar
> with the LSM world that could help implementing that side?

We are running a little short on devs/time in LSM land right now so I
guess I'm the only real option (not that I have any time, but you know
how it goes).  If you can put together the ioctl side of things I can
likely put together the LSM side fairly quickly - sound good?

--=20
paul-moore.com
