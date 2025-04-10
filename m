Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1895290BB5
	for <linux-security-module@vger.kernel.org>; Thu, 10 Apr 2025 20:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744318388; cv=none; b=VRKexcVc8DGSUNrv36Lj02cI0/Rv/+QhPoE2XAqtSlkOXC32SS7BQ00sjth46z1LfkQGwb+XJPBlq8LKw/xHYPVPnW+tbR52lJYcoTAsmX3lZ6rJDSHEesCuYeVKb/OzmUcO5+4PwHjX+Gg6K/ROPZxEInjRfn0QW7ZotnsOIjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744318388; c=relaxed/simple;
	bh=H0u3vX5VsY8JiV57FEEEPi314b0Fhehwq879pYiM8lQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rDt8pJ0uLCD2uGSxcXPvTg6KgTuZxKRzTNzIwKL4ZRkD+/tNP7kolKio1JdUEpypvGcdwUqCMvca7nIbqs4av2+52p2vZPPtVGk7pbN/XX1EbmSsbhrfJ8KzEOp2cI8lfgr2DMCfUxh3dNgYQxOsNOiMSYuH6YTowI/czKLWvXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=F/PtC338; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F/PtC338"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e637edaa652so997024276.1
        for <linux-security-module@vger.kernel.org>; Thu, 10 Apr 2025 13:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744318385; x=1744923185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krwoQzIfIMwcctI32444l9PXwjI42QUcJLibz6Sa1no=;
        b=F/PtC338bdrBJPdlcUyRrnaMhtSu2bGeafLD7l6gCMIm1oUwOChmCswfmbMKKgMlCJ
         wfvQ1ABPJpwLuyR7txwmjZ+cz88V2QlfoWrPXMtAXjLsautFaLp9V4tWmOujGEcfHwgK
         MtkTYRFzAgCOc1eRZ2tQqcbMNkK5KHa+fbzLlg3dUfVinSrJNl8JtIAGYJis3nt9bvoN
         CSqBvdwJS1cAvcTnM1XwDx58DTs492Dugj3G/o3eo9+MunZJ7tGfYrWWlgS2XZeLwcj1
         QqrDHiEFZSmIPGL6nRwb7wB0xfS6uaqC+kASsY5ES3je/Ojzk9C1x4QoxMlRpPnaFlGj
         UXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744318385; x=1744923185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krwoQzIfIMwcctI32444l9PXwjI42QUcJLibz6Sa1no=;
        b=Mp1vKogx8qWMRRVtC9Ovu91ux8w07QMbZnIptbnQskY1qgVU+TkPf9LT48FKBnBPTL
         tps/x6gbkPG/eVGW6EUU8+5fv/AS5iPiKvDPJAz0EoSKGmmAwN0Km0qcRl4o2ifS8sjL
         8EVWcSzAxcxqzwMxVdrlx/TQN7wcH+bO1Pq3ojc1uBKFeX4Va5SNUZhkLdkMqo1RRhLO
         NerOEf7lXB5/U3vO1YDgWiafXasT5SywPf1IbzaGLyc765el4NXKvNn4+eOPeiUk5B8u
         HN3EBQCjHKfWIdmXclvsup+JfbWMEVUl7EQmW00OAs1cPJpQlLZAkYJbt8gQ5Zy/JEvO
         O/ZA==
X-Gm-Message-State: AOJu0YwJvcMbVc5WvcMxv+02nrucul5i7KrCb4rNpclB+TNmH/NfKD/7
	2Uid6bwtn00uH9GRisVCzf346QNW2MCC4NrVssJF+yxJfRltKO3JbiVKm8omtjN42NaC6//sHWT
	REdpvKGPFNsP7lv899v8GSfuX/J71HkY/gTz5
X-Gm-Gg: ASbGncsiIF8JngOBAkYSZvLZDuv1GtWoG6UklJszMAxrEd2YTf468r9yEnEUxpYwtEW
	OU6H2rXndVWHMFIlbuOXJfk7QzfoOXgU63SucPvz2h/d794H27XtnwSB+5zQBNQXq6NBKT66sqs
	8rYJqhwL2usEtyBhHRh4Tt4w==
X-Google-Smtp-Source: AGHT+IFXHNys0Vus65ea3Y/4NyU5LsKY5+XwkeWSZndll+T+IMEQQ87WU9qeAi5e/zuv/55SqI008xJ/mLuSjAC3hoU=
X-Received: by 2002:a05:6902:240e:b0:e6e:1892:6288 with SMTP id
 3f1490d57ef6-e704df7a0dfmr714330276.16.1744318385560; Thu, 10 Apr 2025
 13:53:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-48-paul@paul-moore.com>
 <202504091406.0A86DE05@keescook>
In-Reply-To: <202504091406.0A86DE05@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 16:52:54 -0400
X-Gm-Features: ATxdqUFLySLsnQc7LikhtxNtcIk3wiotiSA5wvDMv50VG9dh8rCpFsiLKa6iTXk
Message-ID: <CAHC9VhQ=D30C4WfGCMDDvXTrTd8iX7=c8pwDW8wKF+nEydP0_Q@mail.gmail.com>
Subject: Re: [RFC PATCH 17/29] lsm: introduce an initcall mechanism into the
 LSM framework
To: Kees Cook <kees@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Micah Morton <mortonm@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 5:16=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Wed, Apr 09, 2025 at 02:50:02PM -0400, Paul Moore wrote:
> > Currently the individual LSMs register their own initcalls, and while
> > this should be harmless, it can be wasteful in the case where a LSM
> > is disabled at boot as the initcall will still be executed.  This
> > patch introduces support for managing the initcalls in the LSM
> > framework, and future patches will convert the existing LSMs over to
> > this new mechanism.
> >
> > Only initcall types which are used by the current in-tree LSMs are
> > supported, additional initcall types can easily be added in the future
> > if needed.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  include/linux/lsm_hooks.h | 33 ++++++++++++---
> >  security/lsm_init.c       | 89 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 117 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index a7ecb0791a0f..0d2c2a017ffc 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -148,13 +148,36 @@ enum lsm_order {
> >       LSM_ORDER_LAST =3D 1,     /* This is only for integrity. */
> >  };
> >
> > +/**
> > + * struct lsm_info - Define an individual LSM for the LSM framework.
> > + * @id: LSM name/ID info
> > + * @order: ordering with respect to other LSMs, optional
> > + * @flags: descriptive flags, optional
> > + * @blobs: LSM blob sharing, optional
> > + * @enabled: controlled by CONFIG_LSM, optional
> > + * @init: LSM specific initialization routine
> > + * @initcall_pure: LSM callback for initcall_pure() setup, optional
> > + * @initcall_early: LSM callback for early_initcall setup, optional
> > + * @initcall_core: LSM callback for core_initcall() setup, optional
> > + * @initcall_subsys: LSM callback for subsys_initcall() setup, optiona=
l
> > + * @initcall_fs: LSM callback for fs_initcall setup, optional
> > + * @nitcall_device: LSM callback for device_initcall() setup, optional
> > + * @initcall_late: LSM callback for late_initcall() setup, optional
> > + */
>
> Yay! Proper kerndoc. :)

 ;)

> > +/**
> > + * security_initcall_late - Run the LSM late initcalls
> > + */
> > +static int __init security_initcall_late(void)
> > +{
> > +     int rc;
> > +
> > +     rc =3D lsm_initcall(late);
> > +     lsm_pr_dbg("all enabled LSMs fully activated\n");
> > +
> > +     return rc;
> > +}
> > +late_initcall(security_initcall_late);
>
> You'd need a new place for the lsm_pr_dbg, but these are all just
> copy/paste. These could be macro-ified too?

If we didn't want to move the other LSM framework initcalls into these
initcalls (yes, I prefer it this way), or add the LSM_STARTED_ADD
event at the end, I would tend to agree with you.  Let's leave it
as-is for now, if something changes in the future wrt to any of things
above we can revisit this.

I'm also somewhat hopeful that this work will bring attention to the
different initcall types/levels that are in use by various LSMs, I
suspect there are a few LSMs which are currently using multiple
initcall types that could be consolidated into one.  That's not
something I wanted to tackle in this patchset, but if we could reduce
the number of initcall types that we use in the LSM subsystem as a
whole this may not really be an issue of any significance ...

--=20
paul-moore.com
