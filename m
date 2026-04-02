Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD72372678
	for <linux-security-module@vger.kernel.org>; Thu,  2 Apr 2026 19:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775158309; cv=pass; b=nMMg1aY3snrXURFcd6E+HcMmCpGYAyuXmMpVK0eRXNNPobqIKjcrocOIZ+w0lJ5HjSe+flAIHRH9t0LKgl/OvQQkx1HY86wz5gxYzfoulM3TzUi/nCm4C/lYqJ+3K6DlsP8HJ4W7k8B2xRQEbVA6lsms/hmAAWl2KLmbuGUZuc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775158309; c=relaxed/simple;
	bh=h4Q0Y5YHf5nDQ1C9hTkU/4FOQDfs8Yi/kGtNKAxFubE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0I7xTDTNr8XLAthGJd7HFUhHjQOg0DqJamNxyoWNUoAiU+t8gr/QVCJzsMqnFCxlyq9GOwmvqIHUACApRYolf453ekESaCP0++F/Dmm3xN1KgjJ3m67UD4S3lOIfogZiadTCDHZVDjEviRTXw/24wbnW8+7y4r+Ap4/kmTF6Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=F/Bo8Ef1; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F/Bo8Ef1"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b2494440f3so4752845ad.2
        for <linux-security-module@vger.kernel.org>; Thu, 02 Apr 2026 12:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775158306; cv=none;
        d=google.com; s=arc-20240605;
        b=QT3UKa3L0OITKHiMygfF6tOhGYZ7Y2MeHc9jdAk1bXuZ0sZcCkUS9vBJw5UDH5Dy8G
         FNPfo6Exth8doU0P8a5YPC5akVP64uplliBWmYWnrclu47akLAJIFdeHnVHshl3NDXID
         MgV4iCGcYiPsBHcq4PzWNI+6X1S8asXuxpnqqBTcVbskOInUvh0+RJQH0M1GYSMH/ujV
         bsr/dGPNONzyeOGDAXhgvOIXNh/PJiHWIDMD7jNyN/siy14NwcDaFJWtA3rttxwDkBUI
         IDDfI2vGB0nn6sN4o8UhEiYjIWTgyTSPNFagJnSEGeLYRK9mR1zsv3a+y+YBaM8tD6CR
         s47g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h4Q0Y5YHf5nDQ1C9hTkU/4FOQDfs8Yi/kGtNKAxFubE=;
        fh=F9cUN02MR78vT0IEjKwknxadABlxH0+nssW06rqPmWg=;
        b=jpBXK5ZdNgA+Dy+yMdSUgrp+TsjSfo9dQn3Buv6tEU+nqjcA0iONfzQOpooa82rDUg
         VOe/tEpGmmKhb7oE9OiQ4HkZZ27yoDS5zZ21VBQ/Ot4VWbg07qW1/g7oqBYyCRdRddnz
         n2u7jzQ/+rSvPBlhRmUUVfVXK+lwJDTySKQFLGVEoAcmGswRmDuxd6FAK3+CuPXWAQCS
         RJC7EiWXyOjyABolLtxFH68GZqxcjvmxB8VPTtVKX57tGP2fEPc4XpfIwCy/cVVD0xte
         Ff43LcBvthNaMnG9f/OqtPrz2TBcPQv4rFqn0Z7rDuwJwN40BiogmlXdHhKNk8CvweS3
         dcOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775158306; x=1775763106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4Q0Y5YHf5nDQ1C9hTkU/4FOQDfs8Yi/kGtNKAxFubE=;
        b=F/Bo8Ef1ix/Ip+36dzOWPBR/iRqCVgHYlnI4Lx1gj6WAjW21NzMiSUomGjwE4Kes+D
         EH2kFo36k4WMSuZkipKHnM1GIVU4lCfdS4q0fy7P8rB6v2dqPNVSEdTqB7T3+oSr/Evr
         BgX9YOknQCwI16TVGytJZ50PSwFqRHI6Ae5RYItot5F7Rb23GbFzuq8qr6CAq7wnfKrs
         DfqWbBXcUqt1VxRP9J4cXHE3UFWOJrhW7MJPLCtavTC48ClkMrTlXP9NqUknbFvF/2g/
         EVBxZIcgWuw8t3j3f4RniUtE8GM1yhoU9eN8V6ZiZApKP6rCnCe0iYPIJaC3ITb8xpZB
         Kb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775158306; x=1775763106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h4Q0Y5YHf5nDQ1C9hTkU/4FOQDfs8Yi/kGtNKAxFubE=;
        b=RlH1XESl6HwNvRJvC/r9AWttQGNvwPAOvH5y1uP3HH04aDxsuxKisBOt/FilZmGlvI
         gQ4i9tYhuHJN1fx7hD5Pkoi3jHMnUGKTkYDdlgvTxIjlfc4AVWVy7M0z97yk9+Ft7uc2
         xeUooovn8g3Oc+III3GOznimEF5WiF6jx9hFhdVQp+JKnCFhvXEghbYxxwiBhhwvD/TF
         vsdJLfQlv9i7DNlSyTmH6iii4OWXckNQEboN3aXyMtx2Q9LMxR+s+spjfSMlkofzYsJy
         odw+n3QctGyNU25ANUJYFA6y6Sy7q1tJ5Actm7L2nzrFeNxC53GzvxnevjOTQWWPTBJP
         0JKg==
X-Forwarded-Encrypted: i=1; AJvYcCUNbHPrzT1J1xt4WbLLOy3W+cwrT+zgggbNdWad+1VKrN0CMiVp0F0lbqnroOhjyvw5fJuCBo1KMUmokcXYtLTC9Vh5g/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpUkJ/IBJjzjCLD2Anp9EEHRmR4fVacWNPYH44PSyAciGcy8Bu
	ExJgNRZGdt/UBNjQrnghoGq7V2+HKWwTyc9W+Uiqok4NTvLBJHodh4xxkyW2qAr+q8ax5v6nIyc
	SLKPyV9vqQd90+lr7+wyiLWTj5Zmz42FumQKRd91dOcucnxsO0uk=
X-Gm-Gg: AeBDietxwPNTM22oYd0WuY/lqOAhM12+WZbH6Apk6Jx1wXEUWA29vqT43uebpSVk4Nd
	Ry6VHRSvjoV2xvJEp7CS7HTqeBv0NI3ROaJUH3t+iOjitYhljGWlhGAJdZIHOdKr9XxxcuksE4V
	6SuklK7dUwzMELbv1fsrnj2YpIwnQiV+Gp+8DTwf1r6+PVh98NzDjWmyE3dr61xdfTLEfCE0I9x
	I7wlHCmZU7tzff+FD2BkFA6pjhaUAYjEiSIYwSIdNJlw2eY6fm4Jm3t0XmGVaIDLcXSjLrpoff7
	4jsVXN0=
X-Received: by 2002:a17:903:17cb:b0:2b2:5a5a:4f2d with SMTP id
 d9443c01a7336-2b28176a472mr5113795ad.31.1775158306102; Thu, 02 Apr 2026
 12:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAHC9VhTeVs7kS9hzukukZRfGu6CC6=Dq4KP69tpEtiFpBJ+jOQ@mail.gmail.com>
 <CAEjxPJ4urh7mUbDJEi-DbdiAifMM_uDH3m35tLeTdx6z+qhPyg@mail.gmail.com>
 <CAHC9VhTGruOPJ+NWZT8vw1bjXzkB4DSPFmWd1pC=J2jTYHP5BA@mail.gmail.com>
 <CAHC9VhRgi8_gdx0nKwkOws1VD6EFG+bHNTN5Q8YCxZ3HOCu5PQ@mail.gmail.com>
 <aclOtS61nbG5Wf3p@wind.enjellic.com> <CAHC9VhR1R7TcC2a2wZ9-G8dmXTuhcDK1YedDduq0sFgPC8QxFw@mail.gmail.com>
 <ac5MKr4lFQhc44i6@wind.enjellic.com> <5e210223-f9a4-4613-8c4b-bea5eea7f8c0@schaufler-ca.com>
In-Reply-To: <5e210223-f9a4-4613-8c4b-bea5eea7f8c0@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 2 Apr 2026 15:31:34 -0400
X-Gm-Features: AQROBzCKlDtIgICtjmoltlMzQQF_LTufdSQcW4goNdwWquqG4-w9OR3uTEvjvgU
Message-ID: <CAHC9VhQn1=pSPF=n0SnUAKFnsnyTr52OqCCGc0a32LVqx5JfLQ@mail.gmail.com>
Subject: Re: LSM namespacing API
To: "Dr. Greg" <greg@enjellic.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 1:49=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> On 4/2/2026 3:59 AM, Dr. Greg wrote:
> > That still leaves the question of whether or not CAP_MAC_ADMIN is
> > appropriate for gating the creation of a new security namespace.
>
> That will have to be up to the individual LSMs.

Yes, exactly.

> Not all LSMs implement Mandatory Access Controls.

... and not all LSMs that implement mandatory access controls rely on
CAP_MAC_ADMIN to gate configuration changes.

--=20
paul-moore.com
