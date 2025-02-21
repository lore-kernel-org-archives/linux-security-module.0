Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319E81FF7CC
	for <linux-security-module@vger.kernel.org>; Fri, 21 Feb 2025 20:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740168402; cv=none; b=ICQDaPQXg/wZW5xyHqIGGDn0tCWh0KzqqMdN0KP56mkClt4z3Dc1oa0SeEFaHBpV3vdAOp91455uop0x9W3nCpK3WKnKlMVBDTamcYvm02O4jE7gi3YEPRJ44eAzELHNdGO/n5qIO3Th6VFdH4FWst5DzY5VzKn2PhikCcFo/xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740168402; c=relaxed/simple;
	bh=9Z/mN2YSF6eh8sXWEhYPPWlb7NMi1cNsA4ai6y2hDz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TuY+Y84nMGC/fxuywinj99RS4x42uCfTzuyhc52Hw6/ebKMfid/9sOrW2iw5kXHdt3cnG5JeeLYHui/Qmdj/3qPo98Znsor6QXYQdfVMXE6OTRjuqajY4gLjP44xLrmGVHCiFZSLVLXssIn78BXnqaQivpyDcknPId+3GTXw4PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RkJrZFTe; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RkJrZFTe"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6fb8de54da9so15934807b3.3
        for <linux-security-module@vger.kernel.org>; Fri, 21 Feb 2025 12:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740168399; x=1740773199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAkKzhCP2EY8GRlMH17ObQbxqg/W96HoszdnirU+/Jw=;
        b=RkJrZFTeQB5lWwsfllhiTRJ/YNpRaL9xE1cby7AO/Relrlr8e1VPNzGXNCWXTibMlt
         3X3u9LEdQbA6jzwp5o6R2vhMrERPr+CfPYsLv6OGRMehgmmlaTGBnicmw9Vr2fo2acQM
         GwqKcpihjt3zuldjzr+YUOH85Z1WT99bJ7QFFun9pIrv7wpit4EnZDAIBrCkyrdwNdK5
         B3M72707OcYnIBPy33p7OWcAsOuKKpGgea4vVCAYZ+XmmAjV0Nsw/cV+DJ4+dUQ74dAf
         dZuuYXTQHm1L5QB4bCwy0Zi4tHrjS0RhlEgQvqj3zCkZvpJVNwDThEnyM/kzyHDzg4AP
         Jldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740168399; x=1740773199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAkKzhCP2EY8GRlMH17ObQbxqg/W96HoszdnirU+/Jw=;
        b=XN2/uNND9BIarsPCTQFbQsa2KWm0eiTUwMI8dhhkw3qiImdOUN9D0ykAp21lCfYrFO
         qAoY2gSak/BaLkxU1qV9V6LGq2o9iNNIAfptC6ImGuQLdlWYV8ioAmWXE6nL5pF5gplT
         337rYswfQshJcWkd54TjJPRzI4XzxVs/YF3Pz6Vf0uyf3PZEwKgdmCqxKiLzOSq1b7iz
         L3X8Cf24IprvPHdQKSdvzkVyhmOSRQzaQUOpVfk6Bk4uIUd9AUwBV87yQ0HjL1gHKv0S
         MrNrljwWiCwjhv20eyimjuTpOrJaa9NlpicgiklEkG2yWKrEx9B7NmZuzQKLtznoeCrr
         5p1A==
X-Forwarded-Encrypted: i=1; AJvYcCW215Ej0HvzxtLg+MIh2wXrgbXdFp0qsRhdUsjUgDuA6qqiqCCRYhunzD1UUuNXQ8dXkb98EIEFV6q2KlJTusgSnIkMLmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPy6qz7paTr8LQGQW+VtuO2omvhOn+DXhBsP93hbtqv6bmFHqd
	gAA/Q7eo4DMn1Rb1f/oHxUouHPY15xlD1HhBPbhGDtX/Wo5llJPF0QwYt1ytkcrihPVBvAlQKQV
	UhG0f5Zj1bMmYnJQvUNfJegIhebTqaC8Bk0E5
X-Gm-Gg: ASbGncvkinpQk+ZuWkZDw/iDo431XAhONKkb4gpklZqulE4Rqouk1uEPrjOmZO7vNxu
	JFA8JH/CskCLuIKoUp2GjZp/hGcc51En+p3/nRF8rvvFkAuCprgdzQPVVQz9E0QeBDnaYU7Es/G
	aFT1h9qPA=
X-Google-Smtp-Source: AGHT+IH+bi1IQ67FGfvj6F36iu81ZfMYdTISAGG3tReWwtD8h4lwBO6Mc2ZXwk8ymaJD8f9gOn7AxN97v2x7wWA1TlE=
X-Received: by 2002:a05:690c:6c05:b0:6f9:acb3:4434 with SMTP id
 00721157ae682-6fbcc286578mr44334477b3.19.1740168399103; Fri, 21 Feb 2025
 12:06:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d5fa8ace-8bc4-4261-bf34-c32e7c948bb8.ref@schaufler-ca.com> <d5fa8ace-8bc4-4261-bf34-c32e7c948bb8@schaufler-ca.com>
In-Reply-To: <d5fa8ace-8bc4-4261-bf34-c32e7c948bb8@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Feb 2025 15:06:28 -0500
X-Gm-Features: AWEUYZkqEWxJ97T2jz81KFUtk_fM7bnmKZyBYz1-HDNB-UBQ9ufxy2B7oyLLnZg
Message-ID: <CAHC9VhS-QHMz4Lza2WDXwt6sh6s03U+-12RcaPGJYVLBBprT7Q@mail.gmail.com>
Subject: Re: [PATCH] lsm,nfs: fix NFS4 memory leak of lsm_context
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 10:59=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
>
> The NFS4 security label code does not support multiple labels, and
> is intentionally unaware of which LSM is providing them. It is also
> the case that currently only one LSM that use security contexts is
> permitted to be active, as enforced by LSM_FLAG_EXCLUSIVE. Any LSM
> that receives a release_secctx that is not explicitly designated as
> for another LSM can safely carry out the release process. The NFS4
> code identifies the lsm_context as LSM_ID_UNDEF, so allowing the
> called LSM to perform the release is safe. Additional sophistication
> will be required when context using LSMs are allowed to be used
> together.
>
> Fixes: b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/apparmor/secid.c | 2 +-
>  security/selinux/hooks.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

I'm sorry Casey, but Stephen's patch seems like a much better approach to m=
e.

https://lore.kernel.org/linux-security-module/20250220192935.9014-2-stephen=
.smalley.work@gmail.com/

--=20
paul-moore.com
