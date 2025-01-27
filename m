Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4A61A76BC
	for <linux-security-module@vger.kernel.org>; Mon, 27 Jan 2025 21:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738012999; cv=none; b=MaUNGqno3vkKDsDLo0WNHcTpPICbFjlcsUdRAujr9y+STTXcSKLDaIqz6UOa83qXnTtyG9fk5KCnCx7IniLqdNbESAB2yzRiktziYtUeyIbOuUKfuEW3ip2jM07mPYwTcD6+Zc0aIBy+CQiFT45A8Gyyq70xeilA46xYUhj81xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738012999; c=relaxed/simple;
	bh=XAyVRpnsN3psIErJlMt7zXtv2npL60nto/i5id7ai5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RpEI0hjZawWkDZsE9sA239UjzJCIG6IO1HYv26UND4AC1GSeaGsezC5kyCSDZxvrtxTeNHKCEQNI6FDsMwqbTQFPPwBsMk0r4ig31RKi9bXec08mqgVyOYsl+MuUxitNazlOSOBgMpv1ZIugygnBBZXdJqBDVndJQ8K98vZWIA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IL6qGAdP; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IL6qGAdP"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e4a6b978283so9481792276.0
        for <linux-security-module@vger.kernel.org>; Mon, 27 Jan 2025 13:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738012995; x=1738617795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAyVRpnsN3psIErJlMt7zXtv2npL60nto/i5id7ai5s=;
        b=IL6qGAdP5KtEU89F6UIipJRoq4GL+ZhA3eAAkGqA4SrDh2TYRUAF8DRvUZgaMK+4Em
         Vju0utuOfqEV1TK7KYxBVastQt5wpBxkkdonXc8DXT9wUvL3Cqto44Qc60CG29f+RV+9
         DACf/0mKDPDIs8FdEYC1UXQOV+1d0MvgLqw4Ru5YsoWIkSPoiDHFS0EHKAk6FWeUkaB6
         +JRCJR3+V7ULJ4i7DtH0Ev2VWq4XIEr80GK+hHjpsVggPeLqUblieuofzX65wZL9kksq
         BbEo4qE9nkXEm36GuprA9WhIeou12fGcioXTjGRlogmf4wW+5GXiTcfXx4vYU9DkUlx1
         EouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738012995; x=1738617795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAyVRpnsN3psIErJlMt7zXtv2npL60nto/i5id7ai5s=;
        b=bVh7JVgUDztVl7MZKNvvuTOJmLBJ1vS/HeDcJ82JovJ2oXHXOakrOGX76KyVh8Y3ak
         Suj0zPeukcCovGZJyr0vGAOfzG/kz+BFMXTzy5JIPXvUe1WVtsixxWyGwVKLJ7ksLQKI
         4o1vGXg0nEegTCY/qvmUBPL5bw55Tb+8bQIRjk+S3ghPz5OINREF3InSKYi/UKCrRPu1
         sboATg9+5p2EylcEme2PSaJTD4ka8yraTZSBfnDwtCFvZjabeP/BCOfUpMcaClu+B+g9
         U1kodGrE2b6Di5jxYhUzJlXWNT3d8QWYdCGVq1vJLqHMMRLU4GwmdnJLoLL3OuHuWf4V
         +7kg==
X-Forwarded-Encrypted: i=1; AJvYcCVEq85k10NhS5JP/FsGeMPG+KZI54SLIPJHDQ3CsvJMFAo4KyuWY5V8wwWvc+E9vmMtQVx0eLnVCyVQjg6mzuQ0gtLErog=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKjJZe2e8+hrquR+m4Frss0aviwGU/nNE8x+AEVKfRtCws1csd
	Y3AZNZV1UL8C1c8SZFXkQa4fTPiGhd6S6EbgruyV4uBmF6muvWuGVWYGl04Wycn3st1+xP2Nys0
	elCw76ZOlcRznzIcsqbawJ0NRyPyfnsGjm0bk
X-Gm-Gg: ASbGncuBJDKPSPGvXW1Mtu4UXjhHaWrQN2f8dBfiHQQz3nzlsUYa/Ta3I/mNP7wfa8c
	4WM3BJHOxGdDTcYM+nJrj7KyNdk0iDHUWykim/5dxQ/UmqV2UQE9F1PUYnYBs
X-Google-Smtp-Source: AGHT+IF5t5BkdSOg4TSJrHoTqiHeMhIdCAWFpEFPilYMsqGS822/Rm3nUcgF1QsJ8yeEYre5K2r6eTgn+B9c1RFUO7c=
X-Received: by 2002:a05:690c:7342:b0:6ea:88d4:fd4f with SMTP id
 00721157ae682-6f7976f7cc0mr9495627b3.18.1738012995453; Mon, 27 Jan 2025
 13:23:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127155723.67711-1-hamzamahfooz@linux.microsoft.com>
 <20250127155723.67711-2-hamzamahfooz@linux.microsoft.com> <bd6c2bee-b9bb-4eba-9216-135df204a10e@schaufler-ca.com>
In-Reply-To: <bd6c2bee-b9bb-4eba-9216-135df204a10e@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Jan 2025 16:23:04 -0500
X-Gm-Features: AWEUYZk_66DBXYyyXGpF3__XoAd1UXYaUgnN9Z9hxMeEkqEEj3wnGpO9yXQUN_Q
Message-ID: <CAHC9VhRaXgLKo6NbEVBiZOA1NowbwdoYNkFEpZ65VJ6h0TSdFw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] lsm,io_uring: add LSM hooks for io_uring_setup()
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, linux-kernel@vger.kernel.org, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-security-module@vger.kernel.org, 
	io-uring@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 12:18=E2=80=AFPM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 1/27/2025 7:57 AM, Hamza Mahfooz wrote:
> > It is desirable to allow LSM to configure accessibility to io_uring
> > because it is a coarse yet very simple way to restrict access to it. So=
,
> > add an LSM for io_uring_allowed() to guard access to io_uring.
>
> I don't like this at all at all. It looks like you're putting in a hook
> so that io_uring can easily deflect any responsibility for safely
> interacting with LSMs.

That's not how this works Casey, unless you're seeing something different?

This is an additional access control point for io_uring, largely to
simplify what a LSM would need to do to help control a process' access
to io_uring, it does not replace any of the io_uring LSM hooks or
access control points.

--=20
paul-moore.com
