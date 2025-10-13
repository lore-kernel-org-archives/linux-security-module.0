Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89BE2F1FC8
	for <linux-security-module@vger.kernel.org>; Mon, 13 Oct 2025 20:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388949; cv=none; b=Dka2fNa0rEbVE0Yr6hEuZafVVQFaOI5wyRfsHJk72w/LFRNMXtV4bGSotyxNFa7/iQ2Y/Xp0almzeIw3i8BFvsmJEjYnNmB7+isuSZabKMSC6iqSDN2jUuQ7+J+io3D/EVji1gpp8tR1h3f8MIXhzMWMcnV3tuZnRH5ZN1df8m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388949; c=relaxed/simple;
	bh=gDYIsGZJNtpz85UGGORoVa634/GqJuKrEvq8/6pyYD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsioJH0IOc+GGVLHYIXirg+2Zp2CvpydiJZ1GHlh4UzTRSr9EUN5jePE30X0eYc/Izun5TY9xti+ybvQXYS0vpOTRIZxU9tm7UoyIy2rJEOTbF0mATscJxRZuDUJMXBCfiMYoTWNim/85JzTSNa68lTkRvBoWTyy8XRErzil7Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=O+UyanCS; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="O+UyanCS"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3324fdfd54cso4975351a91.0
        for <linux-security-module@vger.kernel.org>; Mon, 13 Oct 2025 13:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760388947; x=1760993747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RDNpZAyhwqcckigDtVfOVuYTuSUKS3TRvIv4aY4DWs=;
        b=O+UyanCSQFWA8QndFiHUonQfLD97F4UplMUx26OOxzdNUyK8VQWf+erRmFu7Dy3Sui
         NHebMdt19I2HyRYe/0jAJtARWwHbtB/A+frLu1OpSwXZ3MG824LUv+XqQRU5wBmPRUTp
         1Imz5QF5LGYz6OI52/86EenXOGn5h05YpnZWX99ODPlt4yZMXWc0PkyN/jWU3qatPuAq
         I4IzHvAgy5PtvarhBHvXKHDfI9/qHRTtMR3k3Rhlj4EYWIjcjIcX2oZqW+kRHcpuDlO0
         4IJrey4Y7Tf4rnQGDM79wXgYdKWlBymf4MCmwj8Wa/F/w8IGNGNGL3g1DXToqHxV+Bwh
         Gt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760388947; x=1760993747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RDNpZAyhwqcckigDtVfOVuYTuSUKS3TRvIv4aY4DWs=;
        b=e7RTxhhDJHqc/AN02SB8Z7qFqUF3tINC6lLqMc6OvrFelvbBeHc0BJpcrBtEEwFtgf
         BA/xQ0z2DdzwtxCOKahPHiDztoNsUpWWGmaynsmHbjRbHsGcMFhemx4EHwKaCK14crLt
         KZe15WQ0i+sz43ZDW25XCwgCwBkd3iK7hGYSAG/ExCQyiE6vEy7Xt50CCB1L/bkMHfzX
         G6PkFnH58N1/7N49rwY24i919VIH2KeIn+7ExYq0vmcoS+OWd43ydRa1O9IoqSrgPFuN
         r4xm9XNAPCfolvVkEPTIansOzhqvRZ9q/Yw+CknwO+R0/XBBF45Sa8kW6iiisWYMcROy
         0jTg==
X-Forwarded-Encrypted: i=1; AJvYcCWO1bzoTJD6c1/RAq9qLuAqeNwtIJjRDaQFBOFd+ZC0loDCGV9MrvabrW4HdPfUYjHDvEk7waXuKaGmDJ8A7UB1PJfv4C4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2H9+Er6Tskv+WYH8o3iqC6WI1O8/f+pFQZ+inIhaUMYuR1a68
	AC7pCzLNO2lp1AT3boEqacBseDAond7B1fuwr4CGDEcJuPZyE0+Qx16/BeC0yE7i7D8p76GfTxP
	Sr7RjRBN5akKaOahWZLnBSjq1C4CR+FWQ1eDTUb788+dkxgRvl1erjw==
X-Gm-Gg: ASbGnctfTPIsbgj+uudv9jkTK1U0CDZ078u0neSnWMkKtPGhW0rOWsqJMqvVdjf1yX/
	+09N5E4nKoSXKllvXm9swK+qfDUd0438aI0ar0isyDGDBQpbBXv528pAoCNnJ1XCHuwY4UCm+oW
	LkduB/nP6+E7EsXgoDKm6oA9ZbdFLPEceRTfViH0N9z+x3k9B5t9noRUJKFrr7CFIMy9uc37dCm
	rjShU14+IqPfepvxCFjRRbBTWkag9CBcPIuKOqKhKnpJ3Y=
X-Google-Smtp-Source: AGHT+IFqAomyulxKG8LO+DgQFeLFDPy+KFQmqr2wqA7gA8PG1OfLl0aF1pmvG9L+PEXZ8/496jeCTHuT+POsXuT50tg=
X-Received: by 2002:a17:90b:3ec4:b0:32e:51dd:46dd with SMTP id
 98e67ed59e1d1-33b5116b782mr32102690a91.16.1760388947138; Mon, 13 Oct 2025
 13:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925171208.5997-1-casey@schaufler-ca.com> <20250925171208.5997-3-casey@schaufler-ca.com>
 <CAEjxPJ4D7A4KDF9BfmRa9VvzcAHBkkrdKCvmGazuZUto5=qDuw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4D7A4KDF9BfmRa9VvzcAHBkkrdKCvmGazuZUto5=qDuw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 Oct 2025 16:55:34 -0400
X-Gm-Features: AS18NWDkJN7A1rvC66jbpLrd01lw_5s8wNzGOHMHaR2wj-KW1Eukad0lJzueb3o
Message-ID: <CAHC9VhSRGyMuTYxP0nDpXv_MwvNqVsrBXcak84AGHj7ycDtu3A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] LSM: Infrastructure management of the mnt_opts
 security blob
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>, eparis@redhat.com, 
	linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-kernel@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 2:38=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Sep 25, 2025 at 1:12=E2=80=AFPM Casey Schaufler <casey@schaufler-=
ca.com> wrote:
> >
> > Move management of the mnt_opts->security blob out of the individual
> > security modules and into the security infrastructure.  The modules
> > tell the infrastructure how much space is required, and the space is
> > allocated as required in the interfaces that use the blob.
> >
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > ---
>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 4bba9d119713..1ccf880e4894 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -656,19 +651,13 @@ static int selinux_set_mnt_opts(struct super_bloc=
k *sb,
> >         mutex_lock(&sbsec->lock);
> >
> >         if (!selinux_initialized()) {
> > -               if (!opts) {
> > -                       /* Defer initialization until selinux_complete_=
init,
> > -                          after the initial policy is loaded and the s=
ecurity
> > -                          server is ready to handle calls. */
> > -                       if (kern_flags & SECURITY_LSM_NATIVE_LABELS) {
> > -                               sbsec->flags |=3D SE_SBNATIVE;
> > -                               *set_kern_flags |=3D SECURITY_LSM_NATIV=
E_LABELS;
> > -                       }
> > -                       goto out;
> > +               /* Defer initialization until selinux_complete_init,
> > +                  after the initial policy is loaded and the security
> > +                  server is ready to handle calls. */
> > +               if (kern_flags & SECURITY_LSM_NATIVE_LABELS) {
> > +                       sbsec->flags |=3D SE_SBNATIVE;
> > +                       *set_kern_flags |=3D SECURITY_LSM_NATIVE_LABELS=
;
>
> This seemingly would produce a change in behavior for SELinux.
> Previously we would only do this if there were no SELinux mount
> options specified.

What Stephen said.  I think this is good work that needs to be done
(thank you for doing it!), but we have to preserve existing behaviors.

--=20
paul-moore.com
