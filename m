Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831A047B40D
	for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2026 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549480; cv=pass; b=SwhkfQsT6VFL9TV9kSEOc/KkwvrBAY0L9bYeUuc4eFqJReVp/JsTdvNd9QF3voJ+3qW28cPWSILkMQQfpbod6vMaqdaEreFrTHZAnoVcBh6Rdh63li5I9UKWKdNr2/0FX4PdKcmpQqeUu48xZmyXCp4PmYe7R24XVG9zUPSGL4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549480; c=relaxed/simple;
	bh=/IeII68tNcQyIIr8PeEhC3EiDZx+rpE15xSusoJdc5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvwcNNr66Wn2R0E+nmMH1uDger0w56QfK2hq/2GCs2gPInUnbsa2ECxiFHY0QZ3fuIsTdgeIbK29LuPsanAydHINfiqY5/c9pMkm/PPVYmK9+22YMdQLAvCsCHNKLak4ktbJfuHxcZR9Ttrl57JxPDDMjxARX7wvtiEY2uf6ctw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fQ3Wx++p; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fQ3Wx++p"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cace91f112so14532345ad.0
        for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2026 08:44:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786549478; cv=none;
        d=google.com; s=arc-20260327;
        b=Hh0rV3LE6NelQrHG/CYptGBTYsZEzqd6IaupvrP6jf1YhElhu64jqWrU1R/nN+zRv8
         k7T5jtbhkg3fEWQuUcPiIgMMstKjhbGYWvMnoj4Pt+nBlCbmDePV5m65J7Jhjsv9xW3R
         AtGUhdt7CMcTXyrwLXaYy4iyIqJ7eL5Z9lBh78fxUgR077TgXOlqTyI/yeVCroIwR7bL
         P8MjsGGd/GpFHxQZH2DOSnP+gSPe8g0WGLQHDC7kBoUJ6j0w2+o5cEUgmYd9SX6M4PBy
         w33H1TFkhnD3axLHTyR35CC7+YJjA1K/rWHVwUpLLQBklq8lX6O6/QcVaKBuD9eazI5n
         do/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s1IWDnG3AF52MXJuclYMYHc+IQmTD43ohn2LvgapWrc=;
        fh=s4vlcuDvzXZEwwRTZu14ArRAqpHauiRBHc7jbPAIbXs=;
        b=ZlpcauRfvGzXy6/51tijPRT6byasKmdZJv7BmpJhfdarYKy5tc3zvcXTvyRD6tK4X8
         z5bZpt8ReBkOSlMjunCbJBFvwVgeahAMdU3fL9PSwaGimETHU6zgIL4QzYxHxkpfArM9
         z2Ux1kUvf3iKr8Qk1WLQmQ0FY6cPZeXhpKKHZlpqbWNUwNHVLXfZ3szcCpoHU2TmICZs
         jlKSb6H6N+yxMjWhrZH+U8q7FpJpskHnc46uDj+bqVRhuYQGMEUQ1WY0J+ZohTBPxXyU
         SQaBO/ip6P1YTKEMVniNSJlyQm/EpUa9Te7L/mFonV+2t/PJogLc4IAI86WwwAz70Qm5
         HqQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1786549478; x=1787154278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s1IWDnG3AF52MXJuclYMYHc+IQmTD43ohn2LvgapWrc=;
        b=fQ3Wx++pKT3wCst4Hb0bcoiH3pYGN9sbXz5tjnke6dH3EVT19Ewls3USSY1jTjNr8E
         pGP4umrfgQhAKsMJQXsCtzXaZE30JkxavfyYd4+Rj3c2OboHhwEcdtIBc7GZuNI/lTys
         heaS2J+odmMIY4h8lsHUlb1Z4U4/Tuvlg0gXtFxlEd+Ejfof0ih5Tq3y7apM0ez/9ixF
         jDcCd9UyG4jhqpU3w+IIk4Ry/FWlkY8EEiosg5F3SWD8jbRAIqIDw2a7enAU2S61fNNE
         QJ/vWkZn6PI4YjlzxbGXtFguixw6neTgUItoO8HPmW4psh2qUW3p6QLeOciowQ8Rs0SY
         xDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786549478; x=1787154278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s1IWDnG3AF52MXJuclYMYHc+IQmTD43ohn2LvgapWrc=;
        b=rYhWj1MMdffjpAoHD55b96I3h8Ow/cZXPCHMBHXBWhzAEoH3Lvc3lvNJXFVe9979OV
         av7C6phphBPXfeeWyXNZRkLj7t+wCpnYWC+TKksFtbx/3c/fifdpsFbOp2hFwkxfzBGn
         wTAo4JqDIXUcZhS7yCpX444udAjM6k7JMpn2XpVsPIumD2oCbt4cOsQtrzafyGLCU5DD
         6zel7tNf7WXCb6H7Wdy0W43QCVfcqghWhHiUz2STLJAmxsMzB5e7IV/Itv6K7g9WiKkB
         ZlAWchP8xOdIteM9YPjq+6HjNGxy1vgBNgJ5Om6pSmjhxu62dRUWWUKWfbBCQYMuyj0v
         l2tA==
X-Forwarded-Encrypted: i=1; AHgh+RragaS5IkRY/Hpr5F6AGZliQpGpCBEC1PapCyTPSSd85DjeT6Qg6jzAzP/n42WICV+/LOoB5amK0A+Bw76obH073z8Yr/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxathhpUqzMDn8LbBpWMTpby2hTkQu6s2G048tZp8CuBdvwyl/D
	H9tBbWFgKF7byPpQq0Xqw/+a+OPVcv0wXzeY0Q/b14CAig/Z/d1SpCbKHtKPX0Nfwk10rOO7TYa
	l0xBCDKK8dI9gAjEYEOXlklJvINI9shJYuJADXLSa
X-Gm-Gg: AR+sD11UbwlhzwieSdfKJjPEDoVMtbO0YZOhZ69i+Gt1LP29Ukhi7a/TstnRxLXwDI6
	Q9T5MQ0B3AQoHoY8Ak+ZU4CRpSKc/LBk77NqbZFk0p4YaWM7da2mlMMkhcbp4SY3yeu2kCKCcAL
	3AJ6NOrTe1w5HOmNlygS+38tEL6zFTjbLMpychXbqElsZz72a3KhmWgYh13OGqc4dLHd5ndZsQA
	fNyu9tPcboOefGHpf0IIxKA2uDuHoxhBDtZ3f6Ppg+mO8xZQFLL2jjo0E7NkEKYAL6YkcHk9CeI
	om15ECBzIiop5VBxh3n5a6/cRDm7PtRrBCnJaVBmjpML
X-Received: by 2002:a17:903:230b:b0:2ca:d975:5bbd with SMTP id
 d9443c01a7336-2d3455ffabcmr66794735ad.20.1786549477549; Wed, 12 Aug 2026
 08:44:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-cred-nonrcu-annotation-fix-v1-1-5fd149b2ab54@google.com>
 <2bdf79f45c5eb2ea66d59904418081c5@paul-moore.com> <anyKVxRCiWy/g0Cn@mail.hallyn.com>
In-Reply-To: <anyKVxRCiWy/g0Cn@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 12 Aug 2026 11:44:25 -0400
X-Gm-Features: AUfX_mz1CYC-wzRPK5n3KTtv131zQRSOinsU2x1ZkDohfDgiuhfc7o6Q6fO3Nrw
Message-ID: <CAHC9VhSv-+BgaOzfw7=86cWgnPkD_KD88NKk=j-fY=K_85wTxQ@mail.gmail.com>
Subject: Re: [PATCH] cred: clarify that task_struct::cred is only for the
 current task
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Jann Horn <jannh@google.com>, Serge Hallyn <sergeh@kernel.org>, Eric Paris <eparis@redhat.com>, 
	James Morris <jmorris@namei.org>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 10:59=E2=80=AFAM Serge E. Hallyn <serge@hallyn.com>=
 wrote:
> On Mon, Aug 10, 2026 at 03:41:54PM -0400, Paul Moore wrote:
> > On Aug  6, 2026 Jann Horn <jannh@google.com> wrote:
> > >
> > > The `cred` field in task_struct is currently marked as __rcu, but tha=
t's
> > > not true: It can point to credentials from access_override_creds(), w=
hich
> > > do not get freed with RCU delay.
> > >
> > > What actually protects task_struct::cred is that accessing it is only
> > > permitted for the current task (except for setting up a child during =
fork()
> > > or tearing down a dead process).
> > > (There is currently code in Smack that violates this rule, but that's=
 a bug
> > > and causes UAF, I have sent a separate fix for that.)
> > >
> > > Clarify this, remove the __rcu marker, and remove RCU helpers from al=
l
> > > accesses to this field.
> > >
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > ---
> > > For context:
> > > There have been at least two UAFs of struct cred that I'm aware of, b=
oth
> > > caused by wrong use of task_struct::cred:
> > >
> > >  - https://git.kernel.org/linus/a3727a8bac0a9e77c70820655fd8715523ba3=
db7
> > >  - https://lore.kernel.org/all/20260806-smack-uaf-fix-v1-1-26426d389a=
26@google.com/
> > > ---
> > >  include/linux/cred.h  | 17 +++++++++++------
> > >  include/linux/sched.h |  8 ++++++--
> > >  kernel/auditsc.c      |  5 +++--
> > >  kernel/cred.c         |  2 +-
> > >  security/lsm_init.c   |  2 +-
> > >  5 files changed, 22 insertions(+), 12 deletions(-)
> >
> > This looks good to me, with one small nit below, but as we are at -rc7
> > I think this is best kept until after the upcoming merge window so it
> > has more than a few days in linux-next.  I'm going to merge this into
> > lsm/dev-staging with the expectation of merging it into lsm/dev after
> > the upcoming merge window closes.  If anyone wishes to object to this
> > patch or add their own review/ACK/test tag before then, please do.
> >
> > Thanks Jann.
> >
>
> Thanks.  FWIW I did also look at this closely.
>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>

Updated, thanks.

--=20
paul-moore.com
