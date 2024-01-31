Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C129363
	for <linux-security-module@vger.kernel.org>; Wed, 31 Jan 2024 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706659804; cv=none; b=Pw6Dc8b6q3DsiJkcERlC3TP8LIz33+q/uwiM6dvhPzDBTahc7DdgX+wu9l9W+yB9D3shcxCqwmOXatwIYJN/PTXp+OdjA2gII4AIlbYj9S9WCdfGWA36Zn8PxOh/o8o0pFkSacu+0ojgA0I06RLLom3UE42NyHtiWSfUyBlo7mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706659804; c=relaxed/simple;
	bh=xV6L6Ymilq/nlG7DvJBbGQsqFIg9Gci2q0NrbobrYho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ijcw3qh0LyaNhfs63nOKhgdfuED3mTu9cpPb3ffoOT78Bzr/5DBmEFdbCm8mIQBp+bvOeidaPYxKP9tRGqjmdNNsxnBiivgQfT0khad0HCrRhuCw0LxfbE4sbPf2mGFQUqEOIsO6BkwADeLSpCYZwLpU7NaaELhxPKFXKDGm8Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RPzSY7dO; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RPzSY7dO"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5ff7ec8772dso47207567b3.0
        for <linux-security-module@vger.kernel.org>; Tue, 30 Jan 2024 16:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706659800; x=1707264600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKTptMC1WQHlaB5jTzHxrSzmxkkZFO1cYogZobPN9Ns=;
        b=RPzSY7dO0uW6c0UxPy5HhogAePaey+7kKKUvioFMSDeIEG7KeJ1+i562jt79dAGDj6
         SxMYTNCMfoxeVCCIKcFCeWjtNf+bVGKMlm51ilbWxM7l8q5u6NQK0tCmEuwsLsdDBMb7
         XJuzno2p0xQfgxBQ3ul05i6RG/xvfyDhTsL0cCOIWeint1IRXesJZz44OX/Yvy7+v9aL
         zRkEpxQ4IyPjxA6161ArAwt7kXcJyAm03zWUePfg23kmTHBaFRIueROjEQ3IFgP7x2I7
         AtCMYXgaoybxWHkyPxg0WcRnRACid9MFnyX57OwfzxA/wU1jEH0kIMhQRbiVFjGu4AYp
         jUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706659800; x=1707264600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKTptMC1WQHlaB5jTzHxrSzmxkkZFO1cYogZobPN9Ns=;
        b=BzSxLpAr1/2qgVTLrnp2z4IJEsz3jAXoiOPatA5PC+asOeF0rJ3ostXe40Thu3GXvf
         FnnJxJBMynirDfeaKsTOooMC2tFS82BYgODU5y9gk1kk2Q58NuAPpYbeyTl4GFy9OWpe
         Z44VxUbPaRwrvbaFjcayhbYi3Lo7wHzKjQ9GbKtC/oNCCuZg+ZtuqhPByM7Qu5q2v1I/
         nChr8f9nusFOIhSVkFSSpBRl5r9CBGPohDl++wJXPZhZ6cWNQtjJ/LwSdY+0Z1CbDs+F
         faxZWBoTaHN/wflvuBwCZkK8iqkgtco0UNux7Y8DLEwDuem4U7C2mF6SXaRhRpdw0jpJ
         ZvrA==
X-Gm-Message-State: AOJu0YyTBFaoHf34WWU3Nxk3UDd/BYyBYhNc1wfn0/X9eiNQod/edjmH
	3Qmu8vN3S4XiCkO7V9DVBYx/ubUHFXVTJ2DW5aOTTdamYUPvzVqHM0KPWObC1y6bF4SZGs5JvSQ
	5DLrD5bE1id8OIDHSmocb1Uwto67ktv5jl1AQUU6kTRwq2rUD9Q==
X-Google-Smtp-Source: AGHT+IE7TZMN3BC26M7jWlTTO+Fc+C+rbQ0sRDoOZRxuD6ci2eQf3EiAM2HB2KNiAmfIOHwnKdCgI5H4KOHX9zn875U=
X-Received: by 2002:a25:e911:0:b0:dc2:2d05:186f with SMTP id
 n17-20020a25e911000000b00dc22d05186fmr137948ybd.46.1706659800231; Tue, 30 Jan
 2024 16:10:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129133058.1627971-1-omosnace@redhat.com>
In-Reply-To: <20240129133058.1627971-1-omosnace@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Jan 2024 19:09:49 -0500
Message-ID: <CAHC9VhSzdvJ2DAgV75Tdxk+tOLuhY-vM+BTT--Mfn6xoxVKbxQ@mail.gmail.com>
Subject: Re: [PATCH] security: fix no-op hook logic in security_inode_{set,remove}xattr()
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 8:31=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> These two hooks currently work like this:
> 1. If no LSM registers the hook, cap_inode_{set,remove}xattr() is
>    called.
> 2. If an LSM hook call returns 0, the loop continues to call further
>    LSMs (and only stops on an error return value).
> 3. The "default" return value is 0, so e.g. the default BPF LSM hook
>    just returns 0.
>
> This works if BPF LSM is enabled along with SELinux or SMACK (or not
> enabled at all), but if it's the only LSM implementing the hook, then
> the cap_inode_{set,remove}xattr() is erroneously skipped.
>
> Fix this by using 1 as the default return value and make the loop
> recognize it as a no-op return value (i.e. if an LSM returns this value
> it is treated as if it wasn't called at all). The final logic is similar
> to that of security_fs_context_parse_param().
>
> Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  include/linux/lsm_hook_defs.h |  4 ++--
>  security/security.c           | 45 +++++++++++++++++++++++++----------
>  2 files changed, 35 insertions(+), 14 deletions(-)

Thanks for working on this Ondrej, I've got a couple of thoughts on
the approach taken here, but we definitely need to fix this.

My first thought is that we really should move the
cap_inode_setxattr() and cap_inode_removexattr() calls in security.c
over to using the LSM hook infrastructure just as we do with other
capability hooks in commoncap.c:

  LSM_HOOK_INIT(inode_setxattr, cap_inode_setxattr);
  LSM_HOOK_INIT(inode_removexattr, cap_inode_removexattr);

... of course we will need to adjust cap_inode_setxattr to take (and
ignore the idmap) parameter, but that is easy enough.  It looks like
cap_inode_removexattr() can be used as-is.  Modifications to the only
two LSMs, SELinux and Smack, which explicitly call out to these
capability hooks looks rather straightforward as well.  Doing this
should simplify the LSM hooks significantly, and lower the chance of a
future LSM mistakenly not doing the required capability calls.  There
should also be a slight performance bump for the few (one? two?)
people running both SELinux and Smack in a production environment.

My second thought is that we *really* need to add to the function
header block comment/description for both these hooks.  Of course the
details here will change depending on the bits above about the
capability hooks, but if we need any special handling like you're
proposing here we really should document it in the hook's header
block.

--=20
paul-moore.com
