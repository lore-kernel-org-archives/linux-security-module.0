Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CD0324B2C
	for <linux-security-module@vger.kernel.org>; Mon,  4 May 2026 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777927922; cv=pass; b=BVSZCcc/e9K1lpEjVxxECONnvIloozswMx5N65U2XXEbUjOemMj6tMAt3PwDiaP7irdb6gvh89dcUp63KfL3hT57uc9gjD6aOjfJaTvgHybKjg2c0NzFXXcoUK06UI8xOkEBaXFmrIolA5Zc9h5t9GYDhQfGWnFSlQisMU+xhQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777927922; c=relaxed/simple;
	bh=tJ66m+Ap+y9oidCE5FFl7LELM0PChA2R+pYpwfkimac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/OgZGEiYZzj9WJ8CXUuseDoSB0++h/ReyymLgyQWaMzMGR/2hhIB7BLRPXpg7iDu5TQD08XQramprKhtUvvXDhXDSmjrQRW9TZScg/1RnxElpS23I9MHpF5knxO6rHqA1xBrRw9MTpd3P2H39EtGdBW7EkYkTz0bNqWZgpXO+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Otqq3Ojv; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Otqq3Ojv"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82735a41920so1643669b3a.2
        for <linux-security-module@vger.kernel.org>; Mon, 04 May 2026 13:52:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777927920; cv=none;
        d=google.com; s=arc-20240605;
        b=NeZdX+dE728LWGy9mUbO8H/kFL2XSSrF3CSLTZwjzCMPpvF2e3N4wh5dYxnNz/3OGD
         tP/rf0AL/sVURDPbvAKG4Floh1braB0ubHDb5o6Xwv000+A98cZR3zOUbTrayTgFjQKw
         EfuAQe1iBKt0cXWKcMKbcvJLbb9bT5tKlztcHhKOTe4goZqKxc9sQx7mn49dYYniiXfE
         eoVfRakDNkrAg2nh2hFSUXd4j5/87MkjnszLzjbBf+HpRQ67c85f81Q8Sc3Ce57RxakQ
         RkTbfTRvjbzbziboOACTA0zQpMXTo1RvvecoN1wWMC5tMf/bEjhbBmKE1kPmD3mvb5Dg
         2wpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WJ2eAXPYNTEsOYZ4v8rz7h3jNo4Zy8g4wcsmv8Syleg=;
        fh=mijzLRNUBMneiJcxfcESZZCstGqg1b0j8lt6yxpzzJE=;
        b=ZIHKzhcMuCHtBf3SlyzMdfRrcUDZq18csdLtZZKNiDUXOiAALxU1IQZJFxaf6ruClo
         PKwB3T175QQwq/hxPXPkydxGgxu+dQEEf9ubU606MRtoHIu6UA5EsFY+y031fincAMPK
         +M3+N+/NMMO8UAxe99KzFoxdKqAAwqzOgMgEBHlCl9PQu/mLy5dfIi0AOsPAYQmT8OKd
         XGgsxcvZ4MmJVCHEPG1cDDQqMRVk4pl4MaY0aAayrTjQ15axK+i9+DHcIF/k7Xsn+T3B
         bfBO0CL/lkTzGB9tk8882axpeF2ZtGKQz2L5kreRizktXrQ+xVwXyMV1NdZlkGyl4JrH
         KmXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777927920; x=1778532720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJ2eAXPYNTEsOYZ4v8rz7h3jNo4Zy8g4wcsmv8Syleg=;
        b=Otqq3Ojvcxo+9zA+e3PF1kUEatfZzLGdq8AVTu9c+5mxLKNjyMPWUA0ayS13IjGn8q
         3Z0MU8AQM4yJ08YDclMRA0aKZXXHzq0Pc6x3K5fbzA3qB61pVCrilwpMr2mDHR8Ib2Lg
         QXKYiLrTI3avxcRSPOnP7b0wIhMdymrRlKy255GCA+VEOfq8qITc/6dCIeRrGiTWyDPh
         q0sCHQfWvRfD2XqsaJvWwPin1kqldAkinns5rOvr8liFiNCqC9z64hXdODfW66dxi2Cu
         l27dOM2LY2QmLNzximRynb4tnY/O1Wg1BurWQBY+wr7KGSnbVYHVQhn9sZF3OJYtjxxA
         abPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777927920; x=1778532720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WJ2eAXPYNTEsOYZ4v8rz7h3jNo4Zy8g4wcsmv8Syleg=;
        b=LFLnN8A24CcueQwr+klG7LSzSsWDTHC+YUKEe51sGzmWLcONYixnZtQl8QBYa4CcSs
         sLGSfE8pIssjRoLpKyE9ma18dzyKs6fbce1ElQlX15jSDTZcMDH92rxD4HSUUa9udvN0
         /ZVG2mPd1h6sZkqqXTVvMOedt36ye/NGIZ9yMZz6NWppjxRizZlBGEFbEOiwG6YrqAov
         Ay9UfTyuR2x4qnTi+gmEbkynO89D/Cc3shDmlgBY9acMIb9rZSY41/150Kq3fIUoFdPF
         y0CvEcpWTcDmELI6ik8qwB6a0D8gDUxZ5bUWrZAYoM6WJedAblyMy5cQXztoVPWIV1NS
         +g4w==
X-Forwarded-Encrypted: i=1; AFNElJ9UnMU1WMXCWQRgvfnGVM9diSy5DXdrypAr97xMcDA+LwG5g8NB0DFnqx2EQJusEAHT3bCA57kE+SWEOJtHhF1FNwZ9JJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPbu856ZqKpU24gxMbxoNcPh4SSVaoneqnKHsSmlukA8Gr9gEU
	VCqXKzEm1fmc962k9d1eOY5Hb+D9NRTSg6wadv8WeJys3I2LXwHvCyENNag4CIParbkoAIArjqZ
	jUUzJFX827CFrgc/qViaQ8iLy8zztNWbHCGvXHTKc
X-Gm-Gg: AeBDieuXrRnlPrVN9DNI4SAaE9O9fH1PXJoBvKYQhHby09Q8Q5zJIgo3dMD2PF/Frbn
	3rZOIngj/DdzcXkFuD8SyeaUPGxJ56mIRbcBCKbv4V4+WTTqTu+0vaGR+Xr/v25PKab1s537DIg
	4aEPfzV3wZIsY+hJE/LbDcBkgGG373mfRcBO+o445tQVtkheTy9eC9n7LwkUVb2aITvO/ad164W
	iHohplPSaDIh34E9HerriCYT8BuY03x8MMR3FCF4bOhIZKoxtWwxb84i6xA2CZpzzc3HaZS9BGO
	Dp0Z3n/pq8YrKoEgGg==
X-Received: by 2002:a05:6a00:430a:b0:81f:852b:a925 with SMTP id
 d2e1a72fcca58-8352d03bf06mr9580368b3a.1.1777927919687; Mon, 04 May 2026
 13:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777036497.git.noodles@meta.com> <7734099f5e7fda5480bca016a9e6707983325fbd.camel@linux.ibm.com>
 <afMlgstqahnZg68h@e129823.arm.com> <9f188536f09a2db30877d6bfbb84aeaf2565cccf.camel@linux.ibm.com>
 <CAHC9VhRsnmPp2KmQAns5uq5qXX5EF2xQQzyfTgrPi4O9AXyPpg@mail.gmail.com>
 <ba4bf28314b679474a6a8da6298e548e54b3754c.camel@linux.ibm.com>
 <CAHC9VhRE2kRr1fdDf6xgQgpSrtvqtP8Vy9LVGJhDZFUbzLKGmQ@mail.gmail.com> <ff28c6dcb60c357c752724927addaa8c4fd3bf2c.camel@linux.ibm.com>
In-Reply-To: <ff28c6dcb60c357c752724927addaa8c4fd3bf2c.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 May 2026 16:51:48 -0400
X-Gm-Features: AVHnY4Lr6yzqiFvtxlogRXd7Q0IQ_OqPkojIvu5hlaN_AhoE9caMVXM731mJvc8
Message-ID: <CAHC9VhQY2TMkTvQq9P8oZteQWQSr7qq2utOuH+pdVx+8jWLBCw@mail.gmail.com>
Subject: Re: [PATCH] ima: debugging late_initcall_sync measurements
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan McDowell <noodles@earth.li>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, jmorris@namei.org, serge@hallyn.com, 
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	jarkko@kernel.org, jgg@ziepe.ca, sudeep.holla@kernel.org, maz@kernel.org, 
	oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, 
	noodles@meta.com, sebastianene@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 8:03=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wro=
te:
> On Sun, 2026-05-03 at 12:46 -0400, Paul Moore wrote:
> > Regardless, assuming you always want IMA to leverage a TPMs when they
> > exist, your reply suggests that using an initcall based IMA init
> > scheme, even a late-sync initcall, may not be sufficient because
> > deferred TPM initialization could happen later, yes?
>
> Well yeah.  The TPM could be configured as a module, but that scenario is=
 not of
> interest.  That's way too late.  The case being addressed in this patch s=
et is
> when the TPM driver tries to initialize at device_initcall, returns
> EPROBE_DEFER, and is retried at deferred_probe_initcall (late_initcall). =
 Since
> ordering within an initcall is not supported, this patch attempts to init=
ialize
> IMA at late_initcall and similarly retries, in this case, at late_initcal=
l_sync.

Okay, so from a TPM initialization perspective you are satisfied with
a late-sync IMA initialization, yes?

--=20
paul-moore.com
