Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75701B86E1
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jul 2024 19:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720552531; cv=none; b=nqQf2YH20pFES/nWR5CcaU6IXfClfqOs8umP7b2zkuEsr0NrCYjhsOudfcOd2rZpAspwYDZ4GxySbpVy6zRHBDXDiO8PAwhWxRJuz1GrlQmeWPTnWvLDOvfUPt16LyJdE0tmbkrIT5TDO8Dmdr+vVtThhW1PAEaKRsO0GjoLaMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720552531; c=relaxed/simple;
	bh=hcJbSXb9iRkH4M9VPyQWhLBJDQ00SALEl33nZapbsZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxNBr0M9L6nJ6v5A3nbnNutJ1n9eu5R0sKA2oIBeW5xRDvjVr/NAqN9hn23YpR8ZafyvpN9LhmLyr9q4i1Oz32IPCrsqw8tzhA5T4j+vVkMczXcPtNvu0TYW09bAOBQa+SGnyBUcxO3U292H+xqSioaiDR5OUafp26qJJn7wxJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eKonhYP1; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eKonhYP1"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-65465878c1fso45551117b3.2
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jul 2024 12:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720552529; x=1721157329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+6wO4uQcICrR4cyjqbI8yyDVTutM3VpxL4mHT8kUh8=;
        b=eKonhYP1D1eP/VPQDpYB4rKUkNxVPbGCTkJIiMQFb+6iyi5dJBzCXk+Abqlw3v9Jph
         daeehbKIm62yrd/w1UgUPnCY/iRo55o9dtnWLhoQXQDPplpwymXpP03SeXHqxZxByc3x
         q1oKb0bnAF/vSh92BvWRhFOovy0I3H9ZNS+slKJ9wa+SJW5JY9J/WoIgoHEe/meynlEz
         PP8+gDFniMFKvH6dq2ZFO2V1VN9jF8Hzi+4a0KE4pn3JN0MIXwLH/CIE9+t7n3yuo1A+
         6Wnjo2JHI3c4QmNQivoyaWDtCDt+NEuGotFEe6vVv3LCrQ6wfAe21Xxx6Ksz1S8MoBMU
         j6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720552529; x=1721157329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+6wO4uQcICrR4cyjqbI8yyDVTutM3VpxL4mHT8kUh8=;
        b=RA8lHIpT77LGNbl/mn8rI08LUZ8HoJyU6bh9zZa7uRGzxrsAqSOlDObFsJeju7v3yE
         rG2A1upGEN9sfkSJVUw7ta5hJAjYyhmrZF+AtkPLBcSUhJ12e/t8lNKaiTcvMq3Ci5Fw
         hwjNhS1f5hjJeFm2zArNyU3dZoegi1PkgFgyuSsgLguWsZNqwvDKdYid8Pfrut+9L69J
         nwQwjv72n4vF6Ilob57ZqG9x9hlkOGjKhkDDtUTM1+pButDpnxtnE2uNT1/rzI1s3nVs
         T1MB1gzIgdwMpULLsmD2oJyb2AItB92j+GJon/EygtfUR+x78fJdVk7CvjqDt8kTX+E3
         s5Hg==
X-Gm-Message-State: AOJu0Yz9PFIDRL3H7n/+BF7CFCxNE3eAWLU7HzeuZdoOJwCqsqqQstZY
	/70sIW2qnMDl/kD9gRud/WKuxze5nX732g1Bwyo5S/22wGwW08GboEtYWSoRwQTRvb3vwxQpWZO
	XkujQF/CnFOtg6XcFEaWE/0xOqfMW8pZoffg9x9VUg7FQeNP9Pw==
X-Google-Smtp-Source: AGHT+IHefFN38jSjnSt/RZqyE65DZl9+jH/loeNSdnfzgHve8gq1n6ofF4PhphAEnXPX9XFJ9hg1S9EaQLol9dugExE=
X-Received: by 2002:a05:690c:4a13:b0:64a:7d9b:934 with SMTP id
 00721157ae682-658eed5fc6dmr41044327b3.16.1720552528801; Tue, 09 Jul 2024
 12:15:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708213957.20519-1-casey@schaufler-ca.com> <20240708213957.20519-2-casey@schaufler-ca.com>
In-Reply-To: <20240708213957.20519-2-casey@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 9 Jul 2024 15:15:17 -0400
Message-ID: <CAHC9VhR-OOsjS-gB+Y35_bsLxTS__eJEwrYOrzLYou8gU10imw@mail.gmail.com>
Subject: Re: [PATCH 1/6] LSM: Infrastructure management of the sock security
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 5:40=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> Move management of the sock->sk_security blob out
> of the individual security modules and into the security
> infrastructure. Instead of allocating the blobs from within
> the modules the modules tell the infrastructure how much
> space is required, and the space is allocated there.
>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h         |  1 +
>  security/apparmor/include/net.h   |  3 +-
>  security/apparmor/lsm.c           | 17 +------
>  security/apparmor/net.c           |  2 +-
>  security/security.c               | 36 +++++++++++++-
>  security/selinux/hooks.c          | 80 ++++++++++++++-----------------
>  security/selinux/include/objsec.h |  5 ++
>  security/selinux/netlabel.c       | 23 ++++-----
>  security/smack/smack.h            |  5 ++
>  security/smack/smack_lsm.c        | 70 +++++++++++++--------------
>  security/smack/smack_netfilter.c  |  4 +-
>  11 files changed, 133 insertions(+), 113 deletions(-)

...

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7eed331e90f0..19346e1817ff 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5495,8 +5488,8 @@ static void selinux_sctp_sk_clone(struct sctp_assoc=
iation *asoc, struct sock *sk
>
>  static int selinux_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
>  {
> -       struct sk_security_struct *ssksec =3D ssk->sk_security;
> -       struct sk_security_struct *sksec =3D sk->sk_security;
> +       struct sk_security_struct *ssksec =3D selinux_sock(ssk);
> +       struct sk_security_struct *sksec =3D selinux_sock(sk);
>
>         ssksec->sclass =3D sksec->sclass;
>         ssksec->sid =3D sksec->sid;

That's new :)

Unfortunately I merged a previous version of this patch into lsm/dev a
couple of weeks ago (see below) which appears to have a bug based on
the changes in this revision (lore link below).  While I'm generally
adverse to popping patches off the lsm/dev branch so as to not upset
any ongoing development work, given that we are at -rc7 it's probably
okay and much cleaner than doing a full revert; I'll remove that
commit now.

https://lore.kernel.org/linux-security-module/CAHC9VhQeWF814h8+ho3uKuz+NvvF=
ApwJo4FkdmoRvYpuTcrk4A@mail.gmail.com

--=20
paul-moore.com
