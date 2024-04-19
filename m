Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F0C85938
	for <linux-security-module@vger.kernel.org>; Fri, 19 Apr 2024 14:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535597; cv=none; b=rSjNCRXB0SYKfikZ+zk77/StP6Wrrt4uliFnsX42z/LcHOBfas4oao0+Oxx5T47r5rbJt1fXuHKflIGrYTEWFj+pZvwbc3iQkVp8/bijy/IqMxVgGY8al6byCWNS5Lne7QW9xkn7ubh/VjS38YplSzmg/E25wzsTrKBj0D7AGXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535597; c=relaxed/simple;
	bh=fZ1XlMMUpy10Gwas/CKc6QVK5m8lEX+IdBFYOy1ekGs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IHAImGUWuWoRAzZ6CS+dK4qfB0Ql1zCObNFYUD9D+M3uMUXvzl/2swkdAnRMl9tK3qh4/2OgjDuDvIakDLE2pLv1HPB3/9LVq/Sp1auZORbd1TM9cKRtww4rhK9OsuuP6CF71LTzIoaoZIHjzCICFuRGc7hd+LrNQPbiZKGnB3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VWKK7rbt; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VWKK7rbt"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-571bdbb3bd5so796990a12.2
        for <linux-security-module@vger.kernel.org>; Fri, 19 Apr 2024 07:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713535595; x=1714140395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDP9lixGtE5tEgwyR0XACy/HYxzizAJIPGzf/ZO8AOI=;
        b=VWKK7rbt7fQe6DNUYBpS9K+X2McHutVfC4Zzy70KXblcvbkxEjDD634mezMj+yesog
         pn6n6oGEGiIURAYJczhxI4m+WjrzXeVspurpCgt1NhpG7WLdlnEIs7AfpGg/FMBID7m2
         3J6h+wuZYqo2Zbhk57q4uRikWkwPv1xB094tK9gO/dQMPQTZoIMHCp0HVWQaRDmAwJNP
         Wqp07QYQTcu2HeUj+gbI1orLVvgOqdAh8WrEzzDzPhufRgnSAuLjSH0S42E+YRH68i94
         6mkg5pRXhBQOyZjhRtOiQW4bFU6YEkeqo42cqrZrwS/sNLafsC98s3uyoE4waw6Xm/rP
         cULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535595; x=1714140395;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DDP9lixGtE5tEgwyR0XACy/HYxzizAJIPGzf/ZO8AOI=;
        b=mO0Fgb6yTJTLh+/UkHhkYk2tm1hMGc95wyAEor/STMJSSYrM2TCVeHl2ZM/c8SS4jR
         IZ8sLFx8eWzRDqY1STWN1h6RxxAEo8j1XE80LiyJK7i2vvnft8SJOWkju8BldOCnpxwZ
         NMl5Y0oRf9mQFTwZqNXgksYGQwc/mtQcModg8WGMjqbM59uUsrxFdsfflUfQ1Pyp9ZnM
         Mw7Lm5G1+feZGM7bJj2TI5SoZB1/lYKoeIhbaENpLCn21mjF1v5Wx1DQlVRL4vjLey+6
         Q4X5+dqy3Ya5otSvzva49pDky/kIuEarPWRepObwcsYHKy/Y7wgb0J3tRiRwtQxuvT3f
         TNKg==
X-Gm-Message-State: AOJu0YwnO4F2Mz08Oqk4nt2n5spzNz5I+rliDeBYe3ttVYGMIyVNXuLf
	OAJj6ImbWVKGIGPnAzxFDmFo2RTNVBqijPetAhIfBPvHsExB9qHkfHlXK04AVq4LBhYi3FRzo4n
	wCA==
X-Google-Smtp-Source: AGHT+IF3bk2/TSR5machUXRDV7nlSBsyqT6EzRnkyazFWlLiXKdBdw1iKyaKa2d9UlgLQZek2sRUa/XOCtw=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:4581:b0:571:c126:57e3 with SMTP id
 ig1-20020a056402458100b00571c12657e3mr2676edb.5.1713535594615; Fri, 19 Apr
 2024 07:06:34 -0700 (PDT)
Date: Fri, 19 Apr 2024 16:06:32 +0200
In-Reply-To: <20240418.haet6ahfieH2@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405214040.101396-1-gnoack@google.com> <20240405214040.101396-4-gnoack@google.com>
 <20240418.haet6ahfieH2@digikod.net>
Message-ID: <ZiJ6aNlF3PTJWKCH@google.com>
Subject: Re: [PATCH v14 03/12] selftests/landlock: Test IOCTL support
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 10:44:00PM -0700, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, Apr 05, 2024 at 09:40:31PM +0000, G=C3=BCnther Noack wrote:
> > +/* Invokes the FS_IOC_GETFLAGS IOCTL and returns its errno or 0. */
> > +static int test_fs_ioc_getflags_ioctl(int fd)
> > +{
> > +	uint32_t flags;
> > +
> > +	if (ioctl(fd, FS_IOC_GETFLAGS, &flags) < 0)
> > +		return errno;
> > +	return 0;
> > +}
>=20
> test_fs_ioc_getflags_ioctl() should be moved to the next patch where it
> is used.

Thanks, done.
