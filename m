Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790C2402443
	for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774634173; cv=pass; b=ndAVcbiuwIaHLLoG/mxu6AUw4PY0XO2mTYH3ZnfNKhaDNp2CjXPvvHsUZbkvHqasFrcU3TQ3tYPyVheEHdujZSHQUmrl7AnPiwbYI54R7cCL0NnXErs0zhVJnu0nwvnaeEW4iOjM+z4304NHx1tVOQsFQexdq2F60D8Eg2W2h68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774634173; c=relaxed/simple;
	bh=dkIOtQ3zu1m8d2A9QgVzKWqC1eb4yW1zDp6LErYwYAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbW6sNtyDRgIxvu028suRucGJQw2MPfsk4ntgLis5ouojAwhioOB8Rwt26rY8z+iuomSOfacnO1jepEENyHjCnk3EzEx88xnNOyD4A8xwIBud5iBq30TnX47QxqACuUYm9SwG5W8rab/u5r0oC3AjCZRyyLHy32fMuqEQfhi/Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=REZSkiJ3; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="REZSkiJ3"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8299f1ca894so1270279b3a.2
        for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 10:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774634171; cv=none;
        d=google.com; s=arc-20240605;
        b=b5k4bA+8+zQ+xpESm9lBeA3ObtHIwKGKi7FyhiTHW1eV/l/Rt6PZ8jl3vdbYHM9K6b
         OXZLwSHplE2Uqs8BxC8398sT/6gEBGsVsR2JPWulVBJI14dspsaF5m+YvYet/ypiQQsz
         417YygnDDH0N39sIaeY/6NCrIRWu4bx3hsAlp70KNaJOqquBKwKw+bDVSVno2JAObm07
         p+5YqtmvnhhVyj8TL7yBEMh8vGLH0n0ttmF4qW3YWh2PkD09uO4rIJMRO28+rHagUObp
         b9f4NcTEsPEHh9BnDYwu15AavBEgmPolwrI2127/bSQN5VogPamQNd8HT1VXOK9K3j6M
         oXNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s1EnQcn8nG5hIuUi9o2FJT/iD/jkMGN0EX2uMt+uZkc=;
        fh=kaKsV6RRYWZAtHxZ6SlR4a6LXcf1Mk5H0F+uFbytB5M=;
        b=SKm7cC+mNPbEOmmb9dDF4BW44mLyePkp9qYaOSci8zy2F/92uJaC/fqMLS+BXitjzy
         B7nR9kxAtkRV7WlS4kcXULast9ecaLKziG+C+VNlr7R/ISImtleRFUmP9V3v8M6Iph3R
         a0AM2g1rFbaaLz+oVSWA4XSDvcg126c8FiBZ8vtdhPN7PGz35dQypsL4xNV6WivbKuGQ
         RFAPqxEn1Bq0sRegl5EIjhzjODeQiAShYGJu6BPJOjuINrmi1IAX/3lrTtaiIjqITT9O
         uu+nq6j1Fm6J94QI9JiysMjjp/NuepFziMC0DNkku6oHBBAUSqoaGtpeB66SwlSL+D6T
         5kpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774634171; x=1775238971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1EnQcn8nG5hIuUi9o2FJT/iD/jkMGN0EX2uMt+uZkc=;
        b=REZSkiJ3vg8wwgVDyKnZxtm+F6wy927+ty0dQmCf4dLF+5eKirQxIxkhGB+YqtBw++
         XgTlgOmH4whRvCW5QGSynvMM3uvg4Ym608dnboJeal9s3HauJiX7SmOC1xLwBHVvlU3C
         cHmmEV7eITFHl0RS4BCHnvZc1lWqCbTmFgFaTwgTsANZAxCLMhaaXyh15qORTBdXHhKs
         Irw1z5licEX29n3liYEM7zRlV9OtFAhOdEekyZjIvvYTm1qKT9XqC3jTKAtzhFI3ll6c
         vywQdaDJ9U8vGf852zUDPDGQpw4VN9RiLbExk5tc1o/57pLaOawy4RLTzSG1JzI0GZSF
         ZcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774634171; x=1775238971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s1EnQcn8nG5hIuUi9o2FJT/iD/jkMGN0EX2uMt+uZkc=;
        b=SH4b2+S2F+ZMwjTEaK/TzS77f/z5yP+Z8mW0pGvDT4ROdmqmPUSc87Gxdx9qsKwwmY
         Y4p+r+fz5ZULFQab3hsTyRA4Tfwg2WDQKCCUllYLOUMk81sKlSbPup4+jNKZunYn3nn9
         HWRooziB/Qk9KHj+4DWixjUAfiDv+vNV6NTC8X+8SrZxalXACvUwMTZ7+4E0m0vUkR6/
         P5WC/ujDUE8qdPLrIygbdoVvOFuDVI0xShxwyjRFiLPleyfUFkkVtxqPtP5+d4Zyqqz+
         kSzIlyA4ZkCoj11yTdigkUdr+6+7lk9HXvMCnp+AhtGugpyqUEXmMdsqSroMO7Vqedgw
         VmtA==
X-Forwarded-Encrypted: i=1; AJvYcCWTSFGvRN5ZDJxQSYNGqNgJaAf+2gaT/ZhcUtjO6y9oZseTusafKF9vlxNEmyIEVeGT/cGWc+WMhAEgIXdV6os9dnWsRJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw35Kgvec/nWqLEqiYL8gOuk88DKikx1kEHfcSZUQgSo2P1VF6B
	zk52lGW5+UDdCzBTanEkhG8TROhq6pVLBqQ3MWyghixoLvMUjFEFdDyyappxNWE1opgHI6EgOAg
	tjUzozs/pfQlTE8sAadCWmEl0I/Ko0JR6qtxIth5y
X-Gm-Gg: ATEYQzwtn7iL22JVs1bTwXzm6FGpHqmE/BXotPvbMXeX3DFSstK5PW+spyVfS7cqJaF
	qXQdtDTOK02L7ka+TKkhBKfA3iUay8+g1K9iJqyjdEUECppJRHVKTf1IW1CA7rkCKpKsREsKSfh
	Ka17e1troTrSUeNYyZtU4sYYLWdxbnyIZsGXtFFWs7hjrNZ3Lc/W4g7mYuuj9/+K/rngnZzufDF
	STfbunQ2rNVvW5Vxxf7SV8v66TJnOBl8UTTBIyhlY3OSxilH7aBd/JsMHIkje1Fuj/mSrt2Jnnk
	3B/NH6cE7dRpR3F1pg==
X-Received: by 2002:a05:6a00:a24b:b0:827:3914:f130 with SMTP id
 d2e1a72fcca58-82c9605964fmr3457259b3a.36.1774634170864; Fri, 27 Mar 2026
 10:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327164838.38231-1-gnoack3000@gmail.com> <20260327164838.38231-2-gnoack3000@gmail.com>
In-Reply-To: <20260327164838.38231-2-gnoack3000@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 27 Mar 2026 13:55:58 -0400
X-Gm-Features: AQROBzAkl2N3nYLN6Qz6Tf_ibeBjdYLVvulOQv-Ni6FR5-N-G3uDI_RGAB1oCno
Message-ID: <CAHC9VhRktViRp_U3ZAvo2e7vbjUd6RZb-y8+YPXhtLpt7hsXYg@mail.gmail.com>
Subject: Re: [PATCH v8 01/12] lsm: Add LSM hook security_unix_find
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>, 
	linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Georgia Garcia <georgia.garcia@canonical.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 12:49=E2=80=AFPM G=C3=BCnther Noack <gnoack3000@gma=
il.com> wrote:
>
> From: Justin Suess <utilityemal77@gmail.com>
>
> Add an LSM hook security_unix_find.
>
> This hook is called to check the path of a named UNIX socket before a
> connection is initiated. The peer socket may be inspected as well.
>
> Why existing hooks are unsuitable:
>
> Existing socket hooks, security_unix_stream_connect(),
> security_unix_may_send(), and security_socket_connect() don't provide
> TOCTOU-free / namespace independent access to the paths of sockets.
>
> (1) We cannot resolve the path from the struct sockaddr in existing hooks=
.
> This requires another path lookup. A change in the path between the
> two lookups will cause a TOCTOU bug.
>
> (2) We cannot use the struct path from the listening socket, because it
> may be bound to a path in a different namespace than the caller,
> resulting in a path that cannot be referenced at policy creation time.
>
> Consumers of the hook wishing to reference @other are responsible
> for acquiring the unix_state_lock and checking for the SOCK_DEAD flag
> therein, ensuring the socket hasn't died since lookup.
>
> Cc: G=C3=BCnther Noack <gnoack3000@gmail.com>
> Cc: Tingmao Wang <m@maowtm.org>
> Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>
> ---
>  include/linux/lsm_hook_defs.h |  5 +++++
>  include/linux/security.h      | 11 +++++++++++
>  net/unix/af_unix.c            | 10 +++++++---
>  security/security.c           | 20 ++++++++++++++++++++
>  4 files changed, 43 insertions(+), 3 deletions(-)

This patch doesn't look like it changed significantly in this
revision, is there a reason you dropped the tags from Georgia and I?

--=20
paul-moore.com
