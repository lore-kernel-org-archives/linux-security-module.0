Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A82B277CAE
	for <linux-security-module@vger.kernel.org>; Mon, 13 Oct 2025 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371901; cv=none; b=JkGurijNH3f4c7Tk/5fNFZ6JIYvybX4SsVXGD+n7ZtEf6eG5fV6NsmBT1SLGGnMBRm7PV+8pK5USrHImB062MkfOuUkUc5QaNYGm+0bdFTarW4H9Fu+prIsrxijgOF025ejc36LfCK7xxw9k/pjdWZut4KNOz7B4vfnVtD62mxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371901; c=relaxed/simple;
	bh=kg/O8YEE7mR+ya0+LRSE57GVTGuGrt0BUIQcKJIGT5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yu9LPPqHF9VYUYPrWQNH+o4uIMrmdZe2a2IAVRMw5VMu4B3lr9/AGhKhtISaKI39b9lJESbULrpXEJTPxYLaX3Ru3gWdmM+6P3CDPKKttCgk68LoBdiX8EnI8OUcUXga9CZWZhcVPrhlPr77/DMHN74C/TmwNWH/lGJhJHDXXB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BAafWk04; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BAafWk04"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-330469eb750so5507127a91.2
        for <linux-security-module@vger.kernel.org>; Mon, 13 Oct 2025 09:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760371899; x=1760976699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqOTihtF3LWBkyrOGHrf9dtz4pV67L7r6ac9tYX6C1E=;
        b=BAafWk04W2IbJqD903TwCKpzbScLcVU1DKRkLGTFdkHM1jBvA3zQR9GbyFNH8of9oF
         hwsmFajD2xsR0xDY9YRutepiKkY4bbQKElitqEKuRwwL2mDvhsN/CtCGOC3xe0188Qhq
         LigN5AGNIzz0C4FR4VO0ylgKaMMxboX1i2qSCAFwvkvUcRpAXac/uVrDQnIektIi6zq7
         2uNzT8uUFDkS4MwP/H4SfleVSXY3Bn+jcB2ta3lMuMxFFc3KMyQ4CcKm8RtXBhj+IROF
         438Ah7Z9VdA5IMeWIFwxRff350vLN1dFuwoTVgsq42uxqLcVVgyFQyF0glugqziB0CUM
         7V9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760371899; x=1760976699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqOTihtF3LWBkyrOGHrf9dtz4pV67L7r6ac9tYX6C1E=;
        b=JWbGAKinTJnfd4ApfqsLdD1VREjm0hHnntJa5MZSsfVFoZidX2DtGkmxyuMoFwqqAI
         W3S2fFY67a1OT+vz7C1PvLYck6Q/vORS+fMALzZ7p/6hER1Ou2RrQISZN39qHtIPtCu9
         AsDko4BZ5bX0f3D6Z9K8cdIw7N8Gy48q5n4o9Qsi0ZWclgfbOjemFWo6cwHUdNBrEAan
         8SIFtgTOhd3Wx4o/VcePkk4Ftm1fZ8xdhXI+vKzHRNxcJGSgj/7mb9FrkH+BH2jylk9E
         3T5KihumqkSz+uFCol2lWeBFA06qkhhqifpO4qCnMqQzLMOQUBq+BOYHpWdfLqIr4Pux
         IVQA==
X-Forwarded-Encrypted: i=1; AJvYcCW03Oj/CAUdsfKSop9YUtYpFICXbJe2X36jm3jbg2XG3ISlb4/sYCeYY4BoTQRGjaMAB7bNMNbFoSzUPB8aAlrdJs/vjpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgRqUNdu8spU76VIclOfSWGzHi3CSViHWgxJ9TIxDmwF2R39FJ
	hPY7MLb6QLCnX7eSxCUbIBEyJxNSJHe4K6ykPlMo+zvSgH1rjVhF3gYyYP9Xr23/sc9aCj93WDJ
	cIVGepPSZ/qw1lDaSJE6iVXc+F8MMyWIiJLSnHJ8H
X-Gm-Gg: ASbGncvvityJFpq4BcD2kjy/BYW+ZbsYnbIgzR4ObwOor6HFQYYhfCmVD61MRje3SMg
	jJLuv0faxu8rAix6gBsarEY9bRusXIK5ztQdNp2N5jolKWE9/QuXzHia2srpY3SLd9+6uw+kZcT
	Z2zoC+1kQmVUl/Ol+koud1RwhjwbnKMEvpAeZtWxQSHUx8GCFZ7MYQYeya4yOgf0ERAueKu1tU8
	fsB2oYzoCj0c7U8u1bkmYJTLA==
X-Google-Smtp-Source: AGHT+IHRsuUk9qzBCL3fBbXKncdyg4e+WegpXlz1W9aKK5q8PTZ1CSe8HMgR8w4ThEmt0m0Vt2wsoc3RPFAThEuvYAo=
X-Received: by 2002:a17:90b:1e0c:b0:32e:749d:fcb6 with SMTP id
 98e67ed59e1d1-33b51118ef7mr32930909a91.12.1760371898906; Mon, 13 Oct 2025
 09:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918020434.1612137-1-tweek@google.com> <CAHC9VhSbWJ-8tj5BxSTxznGO8zraKRSE31a+tqdfMHB53ef-MQ@mail.gmail.com>
 <CAEjxPJ5GidA9oT_fbKRe_nH1J3mER0ggM-dBW=Nuo765JDuQKg@mail.gmail.com> <CAHC9VhS2TU2GWgfUOHerbfjyxb5QZMSMqLdQirjSdkUohR7opg@mail.gmail.com>
In-Reply-To: <CAHC9VhS2TU2GWgfUOHerbfjyxb5QZMSMqLdQirjSdkUohR7opg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 Oct 2025 12:11:26 -0400
X-Gm-Features: AS18NWDWa7MaOMrTZEmj_OT-vE-kCVjZdzIYuzWQVFZrpDBS2O2ZFbNWHUYu4oU
Message-ID: <CAHC9VhTSRkP=jNw8bLRx5em6MnX9HTywBqXGsJCBPQ9MKJym=g@mail.gmail.com>
Subject: Re: [PATCH v3] memfd,selinux: call security_inode_init_security_anon
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Hugh Dickins <hughd@google.com>, James Morris <jmorris@namei.org>, 
	Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Isaac Manjarres <isaacmanjarres@google.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 3:30=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Mon, Sep 22, 2025 at 9:12=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > When would you recommend that I re-apply the corresponding userspace
> > patch to reserve this policy capability number for memfd_class?
> > After it is moved to selinux/dev? Understand that it isn't truly
> > reserved until it lands in a kernel.org kernel but would prefer to
> > reapply it sooner than that since there may be other policy capability
> > requests queueing up (e.g. bpf token) that should be done relative to
> > it. Can always revert it again if necessary, at least until another
> > userspace release is made (not sure on timeline for that).
>
> When it comes to API issues like this, my standard answer is "tagged
> release from Linus" as it is the safest option, but you know that
> already.
>
> The fuzzier answer is that unless something crazy happens, I'm likely
> going to move the patches, in order, from selinux/dev-staging into
> selinux/dev when the merge window closes.  This means that any
> policycap API additions for the next cycle are going to start with the
> memfd_class policycap, so it *should* be fairly safe to merge the
> userspace bits now, I just wouldn't do a userspace release with that
> API change until we see a tagged release from Linus.

... and the patch is now in selinux/dev, thanks everyone!

--=20
paul-moore.com
