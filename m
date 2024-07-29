Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452AA14EC5B
	for <linux-security-module@vger.kernel.org>; Mon, 29 Jul 2024 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722261011; cv=none; b=lgqn/VVZ/5up+7cAmWgYNb9LZ0KxfzzkAajs7b78TEWjYAhrOg3by6b6WTu2vkTxGjjLWH2R/NHniUu2IEfd8n9ZDRmTzimm1atZzF3oK4jubEFhFiA2xprdLh3dlmki+lutKyJlmgJxToDqKuOOEV2KCHLR61jaroldvGRJ1aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722261011; c=relaxed/simple;
	bh=Q5uRKdexl1FWIgeaecl12wpeJjOcyl1fYNvfHXWGAkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJ0l2DTfpT4ljS1PiO3NS2ZVLgGMNRoCdvzLWfDlBlXzDjCctSESjbJHOLHbjQL1O/fY9dRbCiMClFZxZSot0zzpj7Obv5kmcmIkfhUXtoXGjajh30KlYDZwN9gy/q8ipWRIO6Q7XuxXvEoDjlgMQRsiJGBnVefXwjmH5ureZ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4vseqjZ/; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4vseqjZ/"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so12380a12.1
        for <linux-security-module@vger.kernel.org>; Mon, 29 Jul 2024 06:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722261008; x=1722865808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDb5V1QphvVrrCYy2ir9gaKSY7i3HzlEt0UMjL3m1Wo=;
        b=4vseqjZ/lvUgR5siBsVk0eC3FjzIgRIDmpFqz2Sx8iXB6fP+oWbdQQMyMvwjPRL1i9
         zTOrFaUtbBxRkyL0kJ+vvGbuvwLIFz6IyNllJ/l9sHsTZgcdpUHhLNTmz4e1jGeLPRkF
         bq8esFig8O0MAR5mgQuJPL5aCJby7JIJgubajRqQEmSxz3oSEKwjKbgkv4DOhAOA8UNQ
         najn5YnFbqy0L4fv6O8vJu7NlZ4NjMqPlKfPK5/4pVImK6LLrmdEy9NS7VXMJvLYn1Em
         Pb+ZqnUa6BmvK3OvtSsTrZDBKl+k0rLGtJ47zDggBJUk3tD2fOclqv2SO8PV1KTy9+g6
         SzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722261008; x=1722865808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDb5V1QphvVrrCYy2ir9gaKSY7i3HzlEt0UMjL3m1Wo=;
        b=qQ9kooeuPj1IEc9IOK4w5rfi/s16IxBz12+vPGDMEIP1VERWQYRG80v/5JYzFoiGb6
         sOSl4qMHxaodWXR2mvdrRp/2Ec3z/kDDZN2nn8ZT8RvhTfhVeP6xrzMTv+bUeLr8SF+5
         8SgJhvB8mdFOkjvgWXjrySI8nXXIQ+yF778pF92BJKlbAMrR7CUlMTG6P8SlBUKwMPbb
         bAz14t+AmaHvppT1f6fb58Wa9oZY1aW+AnYh+xH1u3T1lcpvsfORxWKez5OmJpZacJUU
         dSwsT+/bF+OpsUkI7y03Wf4BXdwL++6UyEiAU885my7keDVcyxa7dbfeybIkD1fLuZ/n
         za3A==
X-Forwarded-Encrypted: i=1; AJvYcCUjOqZIHCG6A2uj1+kGR9rm3h2xl021iHdLCa0bPQ06tng6G4V/6Bv/pNudw9L9Oo5NzjWlR70jLLPTn55CC5pWiY/+nzgEVi1MYlwl0SpOrulfcC50
X-Gm-Message-State: AOJu0YzVWwzpjR4BAXuV86GWy+13bFnmhI1FwEREs0MkyeL1MkR5dLnh
	2RlBnKSDYPr/1HvdOiotmmI6tb1rLuHYJu0r6MnEraIl3dbBaJiBiEHB0d6MHqot+xBmx5PigfB
	xdnNFNWNIZxBz+vaj/iBbYFTq2Ndkx1IEmkw9
X-Google-Smtp-Source: AGHT+IG+KGgrjitU74w+Wuh3bTE7G0peIlECTBGCgPXSxL/avmg0YQ1+aMUr2y6hMEsjbkLoM8BTilae4DsdRUeStuo=
X-Received: by 2002:a05:6402:2694:b0:5a1:4658:cb98 with SMTP id
 4fb4d7f45d1cf-5aed459c474mr562712a12.0.1722261007675; Mon, 29 Jul 2024
 06:50:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729125846.1043211-1-mic@digikod.net>
In-Reply-To: <20240729125846.1043211-1-mic@digikod.net>
From: Jann Horn <jannh@google.com>
Date: Mon, 29 Jul 2024 15:49:29 +0200
Message-ID: <CAG48ez3DzxGMWN9GDhSqpHrDJnZDg2k=VEMD_DFiET5yDr07rw@mail.gmail.com>
Subject: Re: [PATCH v1] keys: Restrict KEYCTL_SESSION_TO_PARENT according to ptrace_may_access()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	James Morris <jmorris@namei.org>, Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 2:59=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> A process can modify its parent's credentials with
> KEYCTL_SESSION_TO_PARENT when their EUID and EGID are the same.  This
> doesn't take into account all possible access controls.
>
> Enforce the same access checks as for impersonating a process.
>
> The current credentials checks are untouch because they check against
> EUID and EGID, whereas ptrace_may_access() checks against UID and GID.

FWIW, my understanding is that the intended usecase of
KEYCTL_SESSION_TO_PARENT is that command-line tools (like "keyctl
new_session" and "e4crypt new_session") want to be able to change the
keyring of the parent process that spawned them (which I think is
usually a shell?); and Yama LSM, which I think is fairly widely used
at this point, by default prevents a child process from using
PTRACE_MODE_ATTACH on its parent.

I think KEYCTL_SESSION_TO_PARENT is not a great design, but I'm not
sure if we can improve it much without risking some breakage.
