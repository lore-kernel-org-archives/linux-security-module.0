Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FA41369A8
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jul 2024 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720633699; cv=none; b=o7cgoGYQcZEOB4x7ffE4tcAsI1bDmMWzXgtHV/yc4jkIWbqx5BpUP4w/KaFudktf1fFF1cj9Gl/yxTKKZGzUVi2ieF8gQCW27RCVZdFOhOa/+YYlEZtYbITaGRnjTTbdrQku46348tDB90Zudh6kJDU1Sf/AFnvPy/vgFi0HOyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720633699; c=relaxed/simple;
	bh=FUlPPz3uZfjH6WI5a2gPI+SiY7y7BqxirjJxe7umn7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l75KOfD8SeEHK7BgqXahRx38SBzZDxddtiW9tNzw9Z5QxVnphox09jddcs2H3SEGeifWIaXI+5D4/NmxALPPTM/j9TNIFnq2xXxtvPV2tbkyJMPwx6ZBLd0S0EvF2vFUAVyvhlEuk18yKZlJC8ygcPrLlocbG5L6TZCa+tKw2RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OQA0J01W; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OQA0J01W"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-64789495923so240607b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 10 Jul 2024 10:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720633697; x=1721238497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gf29W4pL6r4Ar1NWig+G1vXbiZRND3iKsdxbXClbSTI=;
        b=OQA0J01WaJSs3idUwERCn+vj/iQ8ArT65BPhqfOAuG5EGbL2Ve1Nrt0M+42fzCNNT3
         aCQvCcYTyJ06fuJ4Nbv6fJ0/8fVE/jyaUEZSUhrC4kHaPjjmwjhFkFq5ApTDURdIoRN9
         nia9ppuEWMOyCXCZVLvQ7gARC5IxE7rRgDoVaUNgTl/f/2geGVArS1kLidDaZEFG/JTY
         BxEvxEcehcOVbmK/3xD5qPlNNDq/wQRy2uVt9z2ztRumYDyjxknGBmrD+m7KLmIuo+kQ
         jzdbG392CaFwFTi4emMJ5VGRciY5ZNoefk1ynw01X5DqG3zDSeX16Co1UFf/r6YJct4S
         DUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720633697; x=1721238497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gf29W4pL6r4Ar1NWig+G1vXbiZRND3iKsdxbXClbSTI=;
        b=K6eV/LlRP9Kq25TMwKSVsZX5qn1K0TWh6Me1IQZqdAECdqBGVSgeUhX6YeAFxdJOPI
         tiECqqLEgTSFlRVIOEcQHp5+BKlopfwA0lclk6wLaNDRQzuR5spM7piuEbnEd6nVJaoR
         vUJXKXGyAUF9nDkyEB04Psan1mLtGRll/vUKqmbBsoBe0mPoOJyZQJs6CpoxJiPIYO4r
         lIKKi7CFUjgWFfjuBf8c1bdsCLJwBaiyiYE4UIMfjjYMh+EK+NjZqWBYNP89FYd76VZY
         6QZ5MDB6Y6TVOzR03Tg/3J7CWy6wL98W+ZjWCSYVJ2VMuIEBR/eUnRwdbE7ch25NWn27
         MZ8g==
X-Forwarded-Encrypted: i=1; AJvYcCVgzX1mMWKZiY+4O7+o/q0YhKudbwpq8M2P4tQMZDGWicavHBsKIbfdmEykSrque/buyAy5SrDzyxfvrwS8IJBLNes72IbLdU+EaoLFRI22SP/+YTKN
X-Gm-Message-State: AOJu0YzGZqFm+nDCrgh1c9VFRi4Uz8Us/c+LBchB6zPAqLPqAHfCzmoG
	K+y/g7FBd0MHyi+fOjjtRW3hZqsZqaqJ2vPcUPmi2iJ7FGV4KnfP/zpjQTPEmJS3kZ7JSgxfDPh
	lnMtYKaFHDdvjtsVKemZJIHnnift2xOUjE/ZNrIpwy6LKC9A=
X-Google-Smtp-Source: AGHT+IHTKWboArCBLCtn1rj420vpTjh/kyJWUjZzRX6sCLpuPLH23OsgK9G2ASSfXGWE+m8HJ9Lz5sz3oGzx8Sj5L3Y=
X-Received: by 2002:a05:690c:648a:b0:64b:14bf:2fcf with SMTP id
 00721157ae682-658ee79084fmr81928177b3.8.1720633697159; Wed, 10 Jul 2024
 10:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710024029.669314-2-paul@paul-moore.com> <20240710.peiDu2aiD1su@digikod.net>
 <CAHC9VhTxz6eFFUBZYJ3kgneRqKMSqaW63cXuQvVs_tt88GU_OA@mail.gmail.com> <cda2665d-34c3-4276-afc6-e79e553b7664@schaufler-ca.com>
In-Reply-To: <cda2665d-34c3-4276-afc6-e79e553b7664@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 10 Jul 2024 13:48:06 -0400
Message-ID: <CAHC9VhQAiCORNL=rYfpvoqBY7AUKZ1c0hkVqKgvDxuEnmRMHZA@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM
 implementation hook
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 12:41=E2=80=AFPM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 7/10/2024 9:20 AM, Paul Moore wrote:

...

> > However, I have always thought we should add some better
> > structure/typing to these opaque LSM blobs both to get away from the
> > raw pointer math and add a marginal layer of safety.  I've envisioned
> > doing something like this:
> >
> >   struct lsm_blob_inode {
> >     struct selinux_blob_inode selinux;
> >     struct smack_blob_inode smack;
> >     struct aa_blob_inode apparmor;
> >     ...
> >     struct rcu_head rcu;
> >   }
>
> I have considered doing this as part of the stacking effort for quite
> some time. I've already done it for the lsmblob structure that will repla=
ce
> most uses of the u32 secid in the LSM APIs. I am concerned that there wou=
ld
> be considerable gnashing of teeth over the potential increase in the blob
> sizes for kernels compiled with LSMs that aren't active.

Yes, that's a fair point and something that needs to be considered.

> I have been frantically
> avoiding anything that might slow the stacking effort further. If this wo=
uld
> help moving this along I'll include it in v40.

No, don't worry about this as part of improving the multi-LSM support,
this is something that can be done independently, if at all.

--=20
paul-moore.com
