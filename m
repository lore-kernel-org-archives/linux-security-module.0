Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE1617623C
	for <linux-security-module@vger.kernel.org>; Fri, 26 Jul 2024 06:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721976664; cv=none; b=d0KJAf8tqURQM4cKM+9SWcpqS7JKFXUOl7ZJj/opHjcCYtJGnlFUYMGckjEQMBg+IuOK9Tc/R1H6U5AX5WLCGPjwWCSYFHuMJiQp0duwMA76AGIf5qUs224EhqstnVT47ezSVjo7OlXxttzCQ3LF6oLIQwQ0z2xfmFg1Jwjd8bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721976664; c=relaxed/simple;
	bh=bOrdCKvguQC+YaB6h3s3lVZl3WBnLHpu+JUwcZnQ2Yo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EdvWJa1dol5wDwhJyyY+Ws2qQNu0HlfZ+c/1KukF9t9m1B1Q3LUGIid49Zw3c1AVzNsXY355Wxy8OV9VJAfjh7ralOuPg49nQMUH6kRdD+c3zqZ9Esf+uNrWZCe0aPVz4CaYX7o1joW9VM9F3mPNVsevxGVLoyQKrjMJ6UNxJM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zPNaj7X3; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zPNaj7X3"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a7ab50e6735so66251666b.0
        for <linux-security-module@vger.kernel.org>; Thu, 25 Jul 2024 23:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721976661; x=1722581461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOLKGqHkSptnv/m/NuKOIAdG2X8Tq9WhgZPqQX5CUc0=;
        b=zPNaj7X3MPrXXKLeAhH81dfM7r6V0xFDhGQZzDA/ahW/OkNVDLkBfWPg2BBCtzlKRt
         lXnz4hBHeMf0zAiklYgwQtLglygTrbaMozjtK2BUyNvOdqsoLUG7+O6gd7GYB7CzVDCJ
         HRlJUowJYSA/fp5F+L8c2IOo4ZIGmsB90huOCaFsvhoQoEI8g91rb8pQRWUkLWoELlkJ
         JKLnRoJc0tf16Q/k1nXNcEyMDu4NA5Fbpv5qhshr5mlfih+HOyVr7LLRi5Vx+pHiaEWT
         Ebn65HQrOUpIqr5uIfUABuS0XiMnXWJUTxnRawv3k7sZfcYp81nPFemCEw1IDUvrVxRR
         43XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721976661; x=1722581461;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bOLKGqHkSptnv/m/NuKOIAdG2X8Tq9WhgZPqQX5CUc0=;
        b=pJmJ0bpO6RpiWhSH1Ay/0dQixkTZi64ZTlrUMIHJnaJ6nP/MaU1rXl28XIMUkF0RBk
         5+ZlKh2V2CqSI3JYs17s4P1m7kej/on2GC9xJ6SrBSr+RK3LMoK84a/hmLpRyuXd1Hd5
         2eGM4xe2gjJATC/IaEY9LP3l3pshh93aw+8L/hNdl0DEamytFZphCD3ci5YeIepQ23A9
         F4p62oWoiJWWH6niTC+3aHxqlWxc4PO89KtxGNkNIg4oosMfaOTIdl6OlChd+pd3rpuH
         ZwinJOLgqmfBirqDsfGf/fiPhX2kuT1BmeqxSsxS/63fObriwqyMtUyPzUJmtbmJ93zj
         SOpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5jd/bX9zC8yQ6big8QXevbdiKqN/lNCVDBm/IYL9GOIPJeGpLuVGiDpDFeay5jJKknfDtvUL/GZ+FQHDhYfPiMOYfCBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdeMcBC+0s0DCwGpc8swAQiFI4J0xQnEqRmeHd9O/VGMmDfsoR
	bSB27QCebqcke2vbnrZyk9JzcA5Li2X2xdQPcoZEDuLepBmIManbbdP6+gY8oJ376AI9r6IbJ0K
	aBg==
X-Google-Smtp-Source: AGHT+IFx9VhTiVJ6SOadIa9dxcURzunfi3a2JEINT2ESVsbZ2/OWjU51l+q8FY6uKZeu50wlnGWFGbQrjdc=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:dff1:b0:a7a:825a:de55 with SMTP id
 a640c23a62f3a-a7ac51735d4mr300366b.5.1721976660485; Thu, 25 Jul 2024 23:51:00
 -0700 (PDT)
Date: Fri, 26 Jul 2024 08:50:58 +0200
In-Reply-To: <20240725.wahChei0Hoo4@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1721269836.git.fahimitahera@gmail.com> <d7bad636c2e3609ade32fd02875fa43ec1b1d526.1721269836.git.fahimitahera@gmail.com>
 <20240725.wahChei0Hoo4@digikod.net>
Message-ID: <ZqNHQcqPuMUUjOc9@google.com>
Subject: Re: [PATCH v7 1/4] Landlock: Add abstract unix socket connect restriction
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Tahera Fahimi <fahimitahera@gmail.com>, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	outreachy@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 04:18:29PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On Wed, Jul 17, 2024 at 10:15:19PM -0600, Tahera Fahimi wrote:
> > diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.=
c
> > index 03b470f5a85a..799a50f11d79 100644
> > --- a/security/landlock/syscalls.c
> > +++ b/security/landlock/syscalls.c
> >  /**
> >   * sys_landlock_create_ruleset - Create a new ruleset
> > @@ -170,7 +171,7 @@ static const struct file_operations ruleset_fops =
=3D {
> >   * Possible returned errors are:
> >   *
> >   * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at =
boot time;
> > - * - %EINVAL: unknown @flags, or unknown access, or too small @size;
> > + * - %EINVAL: unknown @flags, or unknown access, or uknown scope, or t=
oo small @size;
>=20
> You'll need to rebase on top of my next branch to take into account
> recent G=C3=BCnther's changes.

Actually, I have missed this particular line in my recent documentation cha=
nges,
but I agree, we should follow the advice from man-pages(7) consistently -- =
the
preferred style is to list the same error code multiple times, if there are
multiple possible conditions under which it can be returned.

(Please also fix the typo in "uknown".)

Thanks,
=E2=80=94G=C3=BCnther
